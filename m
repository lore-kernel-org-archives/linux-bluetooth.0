Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: bnep: Return err value while sending cmd is not understood
Date: Wed,  1 Apr 2015 16:24:12 +0200
Message-Id: <1427898255-27496-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send command not understood response should be verified if it was
successfully sent, like all send responses.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 05f57e4..c627817 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -239,7 +239,7 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 			pkt[0] = BNEP_CONTROL;
 			pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
 			pkt[2] = cmd;
-			bnep_send(s, pkt, sizeof(pkt));
+			err = bnep_send(s, pkt, sizeof(pkt));
 		}
 		break;
 	}
-- 
2.1.0

