Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] RFC: prioritizing data over HCI
Date: Wed,  3 Aug 2011 16:11:31 +0300
Message-Id: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set of patches uses the priority of the socket, set via SO_PRIORITY,
to prioritized data over HCI. Current priority range is from 0-7, where
0-6 priority can be set without any exatra capability which is according
to SO_PRIORITY documentation (socket(7)):

SO_PRIORITY

	Set  the  protocol-defined  priority  for  all packets to be sent
	on this socket.  Linux uses this value to order the networking
	queues: packets with a higher priority may be processed first
	depending on the selected device queueing discipline....
	Setting  a  priority outside  the  range  0  to  6 requires the
	CAP_NET_ADMIN capability.

This also enables in the future the use of guaranteed channels as it is
necessary to prioritized them over best effort (default) channels,
Bluetooth V4.0 spec (page 1497):

7.9 PRIORITIZING DATA OVER HCI

	In order for guaranteed channels to meet their guarantees, L2CAP
	should prioritize traffic over the HCI transport in devices that
	support HCI. Packets for Guaranteed channels should receive higher
	priority than packets for Best Effort channels.

Note: to be able to use guaranteed channels we need to negotiate QoS
parameters both in L2CAP and HCI, this is outside of the scope of this
patches since it probably requires new socket options to L2CAP sockets.

The main use case for this is A2DP, many people complained that when they
are using their HID devices (mouses) together with headset the mouse has
higher priority, which btw is not true since currently there is no
priority and connections receives the same quote.

With this changes it may reduce the problem since PulseAudio already sets
A2DP socket as low latency (priority 6), which means audio packets will be
processed before the HID packets, but this only affects tx and there still
exist the problem of some HID not letting us being master.

Ive been testing this using A2DP and HID connected simultaneusly without a
problem, though connecting/paging still makes audio skips, and also tried
OBEX transfers together to see if audio skips, indeed it does when HID is
active but it works better than having no priority (skips less frequent)
and in case of using priority 7 the audio doesn't skip anymore but it
eventually stall the OBEX transfer (this is maybe because OpenOBEX loop
while trying to write to socket and don't wait for POLLOUT).

Luiz Augusto von Dentz (3):
  Bluetooth: prioritizing data over HCI
  Bluetooth: set skbuffer priority based on L2CAP socket priority
  Bluetooth: make use sk_priority to priritize RFCOMM packets

 include/net/bluetooth/hci_core.h |    6 ++-
 include/net/bluetooth/l2cap.h    |    3 +-
 net/bluetooth/hci_conn.c         |    8 ++-
 net/bluetooth/hci_core.c         |  141 +++++++++++++++++++++++++++----------
 net/bluetooth/l2cap_core.c       |   47 +++++++++----
 net/bluetooth/l2cap_sock.c       |    2 +-
 net/bluetooth/rfcomm/core.c      |   51 +++++++++----
 net/bluetooth/rfcomm/sock.c      |    8 ++
 8 files changed, 194 insertions(+), 72 deletions(-)

-- 
1.7.6

