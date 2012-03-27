Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 2/3] MAP: Initial outgoing parameters support
Date: Tue, 27 Mar 2012 13:56:18 +0200
Message-Id: <1332849379-12766-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1332849379-12766-1-git-send-email-lkslawek@gmail.com>
References: <1332849379-12766-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index f6d4799..ea2b4b2 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -110,6 +110,7 @@ struct mas_session {
 	gboolean nth_call;
 	GString *buffer;
 	map_ap_t *inparams;
+	map_ap_t *outparams;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -131,6 +132,8 @@ static int get_params(struct obex_session *os, struct mas_session *mas)
 		return -EBADR;
 	}
 
+	mas->outparams = map_ap_new();
+
 	return 0;
 }
 
@@ -143,6 +146,8 @@ static void reset_request(struct mas_session *mas)
 
 	map_ap_free(mas->inparams);
 	mas->inparams = NULL;
+	map_ap_free(mas->outparams);
+	mas->outparams = NULL;
 
 	mas->nth_call = FALSE;
 	mas->finished = FALSE;
-- 
1.7.4.1

