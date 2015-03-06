Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 1/7] tools/btgatt-client: Minor fix of menu alignment
Date: Fri,  6 Mar 2015 17:48:52 +0100
Message-Id: <1425660538-25884-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425660538-25884-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index c90f265..e2e0d15 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1135,9 +1135,9 @@ static struct {
 	{ "unregister-notify", cmd_unregister_notify,
 						"Unregister a not/ind session"},
 	{ "set-sec-level", cmd_set_sec_level,
-					"Set security level on le connection"},
+				"\tSet security level on le connection"},
 	{ "get-sec-level", cmd_get_sec_level,
-					"Get security level on le connection"},
+				"\tGet security level on le connection"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
 	{ }
-- 
1.8.4

