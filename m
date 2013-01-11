Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 01/11] transport: Initialize the "Volume" property with 50%
Date: Fri, 11 Jan 2013 17:25:24 -0300
Message-Id: <1357935934-20033-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a4370a5..6ffa98a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -787,7 +787,7 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 		struct a2dp_transport *a2dp;
 
 		a2dp = g_new0(struct a2dp_transport, 1);
-		a2dp->volume = -1;
+		a2dp->volume = 63;
 
 		transport->resume = resume_a2dp;
 		transport->suspend = suspend_a2dp;
-- 
1.7.11.7

