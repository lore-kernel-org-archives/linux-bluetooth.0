Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <ulrik.lauren@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] Race condition between RFCOMM and L2CAP
Date: Wed, 9 Nov 2011 14:12:19 +0100
Message-ID: <1320844340-1966-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I recently came across race condition between RFCOMM and L2CAP.

When new rfcomm_session is allocated inside rfcomm_session_create there is also
L2CAP channel connection started there (and ACL link implicitly). And it can
happen that actions are scheduled in a way that rfcomm_security_cfm is called
before newly created rfcomm_session finished initialization and still has
refcnt set to 0 (because it's not yet linked to rfcomm_dlc). If this happens,
session will be deleted on rfcomm_session_put and connection will fail:

<4>[  226.167144:0] [2475] rfcomm:rfcomm_sock_connect:395 sk cdf73400
<4>[  226.167205:0] [2475] rfcomm:__rfcomm_dlc_open:399 dlc cddb83c0 state 2 00:00:00:00:00:00 00:19:7F:64:0A:0E channel 1
<4>[  226.167266:0] [2475] rfcomm:rfcomm_session_create:696 00:00:00:00:00:00 00:19:7F:64:0A:0E
<4>[  226.167297:0] [2475] rfcomm:rfcomm_l2sock_create:221
<4>[  226.167358:0] [2475] bluetooth:l2cap_sock_create:1019 sock ce43e040
<4>[  226.167388:0] [2475] bluetooth:l2cap_sock_init:915 sk cdf73000
<4>[  226.167449:0] [2475] bluetooth:l2cap_sock_bind:45 sk cdf73000
<4>[  226.167480:0] [2475] rfcomm:rfcomm_session_add:605 session cd41c780 sock ce43e040
<4>[  226.167968:0] [2475] bluetooth:l2cap_sock_connect:109 sk cdf73000
<4>[  226.168029:0] [2475] bluetooth:l2cap_chan_connect:1100 00:00:00:00:00:00 -> 00:19:7F:64:0A:0E psm 0x03
<4>[  226.169372:0] [2475] bluetooth:hci_get_route:478 00:00:00:00:00:00 -> 00:19:7F:64:0A:0E
<4>[  226.169433:0] <intr> bluetooth:hci_connect:522 hci0 dst 00:19:7F:64:0A:0E
<4>[  226.169494:0] <intr> bluetooth:__l2cap_chan_add:311 conn cca152e0, psm 0x03, dcid 0x0000
<4>[  226.169616:0] <intr> bluetooth:l2cap_set_timer:222 chan cdf73000 state 5 timeout 40000
<4>[  226.169677:0] <intr> bluetooth:hci_conn_security:661 conn cd570400
<4>[  226.169708:0] <intr> bluetooth:hci_conn_encrypt:647 conn cd570400
<4>[  226.169738:0] <intr> bluetooth:hci_send_cmd:1918 hci0 opcode 0x413 plen 3
<4>[  226.169799:0] <intr> bluetooth:hci_send_cmd:1933 skb len 6
<4>[  226.169860:0] <intr> bluetooth:hci_cmd_task:2397 hci0 cmd 1
<4>[  226.169921:0] <intr> bluetooth:hci_send_frame:1896 hci0 type 1 len 6
<4>[  226.170623:0] <intr> bluetooth:hci_rx_task:2342 hci0
<4>[  226.170715:0] <intr> bluetooth:hci_cs_set_conn_encrypt:1075 hci0 status 0x0
<4>[  226.170806:0] <intr> bluetooth:hci_rx_task:2342 hci0
<4>[  226.170867:0] <intr> bluetooth:hci_encrypt_change_evt:1672 hci0 status 0
<4>[  226.170898:0] <intr> bluetooth:l2cap_security_cfm:
<4>[  226.170928:1] [1906] bluetooth:hci_dev_get:325 0
<4>[  226.170928:1] [1906] bluetooth:hci_del_off_timer:970 hci0
<4>[  226.170959:0] 4091 conn cca152e0
<4>[  226.170989:0] <intr> bluetooth:l2cap_security_cfm:4100 chan->scid 65
<4>[  226.171051:0] <intr> bluetooth:l2cap_build_cmd:1729 conn cca152e0, code 0x02, ident 0x04, len 4
<4>[  226.171081:0] <intr> bluetooth:l2cap_send_cmd:548 code 0x02
<4>[  226.171142:0] <intr> bluetooth:hci_send_acl:1983 hci0 conn cd570400 flags 0x0
<4>[  226.171173:0] <intr> bluetooth:hci_send_acl:1992 hci0 nonfrag skb cd5769c0 len 16
<4>[  226.171234:0] <intr> bluetooth:l2cap_security_cfm:4100 chan->scid 64
<4>[  226.171264:0] <intr> rfcomm:rfcomm_security_cfm:2065 conn cd570400 status 0x00 encrypt 0x01
<4>[  226.171325:0] <intr> rfcomm:rfcomm_session_del:633 session cd41c780 state 3
<4>[  226.171386:0] <intr> rfcomm:rfcomm_session_clear_timer:274 session cd41c780 state 3
<4>[  226.171417:0] <intr> bluetooth:l2cap_sock_release:820 sock ce43e040, sk cdf73000
<4>[  226.171478:0] <intr> bluetooth:l2cap_sock_shutdown:790 sock ce43e040, sk cdf73000

One solution here is to move L2CAP socket connection outside rfcomm_session_create
and put it e.g. at the end of __rfcomm_dlc_open - but this does not look nice.
Or just set flag and handle this in rfcomm_process_sessions - this looks nice
but cannot return error code from kernel_connect on L2CAP socket as it's done
now.

My patch goes in a different direction and simply holds internal reference to
rfcomm_session inside __rfcomm_dlc_open so it won't be deleted before it's
finally linked to DLC. Note that in case of rfcomm_session_create reference
has to be held inside this function (i.e. before connecting L2CAP).


Andrzej Kaczmarek (1):
  Bluetooth: Fix race condition between RFCOMM and L2CAP

 net/bluetooth/rfcomm/core.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

-- 
on behalf of ST-Ericsson

