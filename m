Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nami <nami.li@atheros.com>
Subject: [PATCH obexd 09/14] Add psm parameter for session_find.
Date: Mon, 20 Jun 2011 18:00:51 +0800
Message-ID: <1308564051-19004-2-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
References: <1308564051-19004-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 client/session.c

diff --git a/client/session.c b/client/session.c
old mode 100644
new mode 100755
index dd08610..3db1c1d
--- a/client/session.c
+++ b/client/session.c
@@ -498,6 +498,7 @@ static struct session_data *session_find(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner)
 {
 	GSList *l;
@@ -519,7 +520,8 @@ static struct session_data *session_find(const char *source,
 		if (g_strcmp0(service, session->service))
 			continue;

-		if (channel && session->channel != channel)
+		if ((channel && session->channel != channel)
+			&&(psm && session->psm != psm))
 			continue;

 		if (g_strcmp0(owner, session->owner))
@@ -547,7 +549,7 @@ struct session_data *session_create(const char *source,
 	if (destination == NULL)
 		return NULL;

-	session = session_find(source, destination, service, channel, owner);
+	session = session_find(source, destination, service, channel, psm, owner);
 	if (session) {
 		session_ref(session);
 		goto proceed;
--
1.7.1

