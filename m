Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 05/11] transport: Keep a list o all existent transports
Date: Fri, 11 Jan 2013 17:25:28 -0300
Message-Id: <1357935934-20033-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4a81d85..c3e26f4 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -107,6 +107,8 @@ struct media_transport {
 	void			*data;
 };
 
+static GSList *transports = NULL;
+
 static const char *state2str(transport_state_t state)
 {
 	switch (state) {
@@ -703,6 +705,8 @@ static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
 
+	transports = g_slist_remove(transports, transport);
+
 	if (transport->owner)
 		media_transport_remove_owner(transport);
 
@@ -816,6 +820,8 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
 		goto fail;
 	}
 
+	transports = g_slist_append(transports, transport);
+
 	return transport;
 
 fail:
-- 
1.7.11.7

