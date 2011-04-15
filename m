Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Second round of patches for the l2cap "rewrite"
Date: Fri, 15 Apr 2011 15:17:26 -0300
Message-Id: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches finishes almost all the data separatation bettween an L2CAP
socket and an L2CAP channel. Some missing pieces are:
	- New locking system to the l2cap_channel (together with the a new
	  	backlog recv queue implementation).
	- Keep the state of the connection on strcut l2cap_chan ( and notify
	  	the socket about changes on the state)
	- New ways to retrieve data from bt_sk.
	- New list to search for the psm and scid we can accept a connection
		or receive data (connectionless case)

Then we need to draw an API to access L2CAP channels from l2cap_sock.c and
RFCOMM, and a notify system for L2CAP core tell its users about new data, state
changes, etc.

Please comment.

Regards,

Gustavo F. Padovan (8):
  Bluetooth: Refactor L2CAP channel allocation
  Bluetooth: Move conf_state to struct l2cap_chan
  Bluetooth: Rename l2cap_do_connect() to l2cap_chan_connect()
  Bluetooth: Move some more elements to struct l2cap_chan
  Bluetooth: Move more vars to struct l2cap_chan
  Bluetooth: Move more channel info to struct l2cap_chan
  Bluetooth: Move more vars to struct l2cap_chan
  Bluetooth: Move conn to struct l2cap_chan

 include/net/bluetooth/l2cap.h |   67 +++---
 net/bluetooth/l2cap_core.c    |  578 ++++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c    |  236 ++++++++++--------
 net/bluetooth/rfcomm/core.c   |   21 +-
 net/bluetooth/rfcomm/sock.c   |    5 +-
 5 files changed, 465 insertions(+), 442 deletions(-)

-- 
1.7.5.rc1

