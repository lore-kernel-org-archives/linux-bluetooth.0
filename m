Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Luk=C3=A1=C5=A1_Turek?= <8an@praha12.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Never deallocate a session when some DLC points to it
Date: Wed, 5 Jan 2011 02:43:59 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201101050243.59801.8an@praha12.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix a bug introduced in commit 9cf5b0ea3a7f1432c61029f7aaf4b8b338628884:
function rfcomm_recv_ua calls rfcomm_session_put without checking that
the session is not referenced by some DLC. If the session is freed, that
DLC would refer to deallocated memory, causing an oops later, as shown
in this bug report: https://bugzilla.kernel.org/show_bug.cgi?id=15994

Signed-off-by: Lukas Turek <8an@praha12.net>
---
 net/bluetooth/rfcomm/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 432a9a6..cbe72c5 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1164,7 +1164,8 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			 * initiator rfcomm_process_rx already calls
 			 * rfcomm_session_put() */
 			if (s->sock->sk->sk_state != BT_CLOSED)
-				rfcomm_session_put(s);
+				if (list_empty(&s->dlcs))
+					rfcomm_session_put(s);
 			break;
 		}
 	}
-- 
1.7.2.2
