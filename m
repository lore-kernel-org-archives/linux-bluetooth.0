Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Scott James Remnant <keybuk@chromium.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/3] bluetooth: rfcomm: Defer session teardown after last dlc
Date: Thu, 13 Mar 2014 12:43:06 -0400
Message-Id: <1394728986-5096-4-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
References: <15A2D205-97BC-4790-A998-52AD8941DB3F@holtmann.org>
 <1394728986-5096-1-git-send-email-peter@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 9cf5b0ea3a7f1432c61029f7aaf4b8b338628884,
[Bluetooth] Disconnect L2CAP connection after last RFCOMM DLC,
immediately disconnects the session when closing the last dlc.
This commit predates the later addition of a session timer [1]
which sets up a timer to automatically close the session after the
last dlc is closed. This automatic behavior was further noted
noted in [2]:

    When the last RFCOMM data channel is closed, a timer is normally set
    up to disconnect the control channel at a later time.  If the control
    channel disconnect command is sent with the timer pending, the timer
    needs to be cancelled.

Rely on automatic session disconnect; this fulfills the responsibility
of closing the multiplexer while allowing the last dlc to be closed and
reopened without needing to handshake a new l2cap connection.

[1] commit 9e726b17422bade75fba94e625cd35fd1353e682
    Bluetooth: Fix rejected connection not disconnecting ACL link

[2] commit 79e654787c67f6b05f73366ff8ccac72ba7249e6
    Bluetooth: Clear RFCOMM session timer when disconnecting last channel

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/rfcomm/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 292322c..062a96c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1193,13 +1193,6 @@ static struct rfcomm_session *rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 		case BT_DISCONN:
 			d->state = BT_CLOSED;
 			__rfcomm_dlc_close(d, 0);
-
-			if (list_empty(&s->dlcs)) {
-				s->state = BT_DISCONN;
-				rfcomm_send_disc(s, 0);
-				rfcomm_session_clear_timer(s);
-			}
-
 			break;
 		}
 	} else {
-- 
1.8.1.2
