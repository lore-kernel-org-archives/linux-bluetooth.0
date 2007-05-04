Return-Path: <vitervo@nokia.com>
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org, Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 2/2] [BLUETOOTH] Disconnect l2cap connection after last dlc
Date: Fri,  4 May 2007 19:43:12 +0300
Message-Id: <11782969921054-git-send-email-ville.tervo@nokia.com>
In-Reply-To: <11782969921523-git-send-email-ville.tervo@nokia.com>
References: <20070504163843.GI5925@null.research.nokia.com>
 <11782969921523-git-send-email-ville.tervo@nokia.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Rfcomm spec says that the device closing the last connection (DLC) on a
particular session is responsible for closing the multiplexer by closing the
corresponding L2CAP channel.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/rfcomm/core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 94f4573..80c1c1e 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1058,6 +1058,12 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 		case BT_DISCONN:
 			d->state = BT_CLOSED;
 			__rfcomm_dlc_close(d, 0);
+
+			if (list_empty(&s->dlcs)) {
+				s->state = BT_DISCONN;
+				rfcomm_send_disc(s, 0);
+			}
+
 			break;
 		}
 	} else {
@@ -1067,6 +1073,9 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			s->state = BT_CONNECTED;
 			rfcomm_process_connect(s);
 			break;
+		case BT_DISCONN:
+			rfcomm_session_put(s);
+			break;
 		}
 	}
 	return 0;
-- 
1.5.1.1
