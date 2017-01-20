Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/avdtp: Fix not aborting SetConfiguration
Date: Fri, 20 Jan 2017 15:43:31 +0200
Message-Id: <20170120134331.25438-3-luiz.dentz@gmail.com>
In-Reply-To: <20170120134331.25438-1-luiz.dentz@gmail.com>
References: <20170120134331.25438-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If for some reason SetConfiguration is cancelled an Abort shall be
generated since it there could be a stream pending.
---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4a21e03..51ead68 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2489,7 +2489,7 @@ static int cancel_request(struct avdtp *session, int err)
 		if (lsep && lsep->cfm && lsep->cfm->set_configuration)
 			lsep->cfm->set_configuration(session, lsep, stream,
 							&averr, lsep->user_data);
-		goto failed;
+		break;
 	case AVDTP_DISCOVER:
 		error("Discover: %s (%d)", strerror(err), err);
 		goto failed;
-- 
2.9.3

