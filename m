Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/4] Bluetooth: Process receiving FCS_NONE in L2CAP Conf Rsp
Date: Thu, 29 Nov 2012 17:46:07 +0200
Message-Id: <1354203968-1335-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354203968-1335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20121129103405.GC26707@joana>
 <1354203968-1335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Process L2CAP Config rsp Pending with FCS Option 0x00 (No FCS)
which is sent by Motorola Windows 7 Bluetooth stack. The trace
is shown below (all other options are skipped).

...
< ACL data: handle 1 flags 0x00 dlen 48
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 36
      ...
      FCS Option 0x00 (No FCS)
> ACL data: handle 1 flags 0x02 dlen 48
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 36
      ...
      FCS Option 0x01 (CRC16 Check)
< ACL data: handle 1 flags 0x00 dlen 47
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 4 clen 33
      Pending
      ...
> ACL data: handle 1 flags 0x02 dlen 50
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 4 clen 36
      Pending
      ...
      FCS Option 0x00 (No FCS)
< ACL data: handle 1 flags 0x00 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d22d183..8c43277 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3431,6 +3431,13 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
 					   (unsigned long) &efs);
 			break;
+
+		case L2CAP_CONF_FCS:
+			if (*result == L2CAP_CONF_PENDING)
+				if (val == L2CAP_FCS_NONE)
+					set_bit(CONF_NO_FCS_RECV,
+						&chan->conf_state);
+			break;
 		}
 	}
 
-- 
1.7.10.4

