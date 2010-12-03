Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/5] Make EIR type an optional argument for bt_extract_eir_name
Date: Fri,  3 Dec 2010 11:28:50 -0300
Message-Id: <1291386532-4985-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386532-4985-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c     |    4 ++--
 src/glib-helper.c |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 04ffd2b..03ae1e9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3135,8 +3135,8 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 						(GCompareFunc) dev_rssi_cmp);
 
 	if (info->length) {
-		uint8_t type, flags;
-		char *tmp_name = bt_extract_eir_name(info->data, &type);
+		uint8_t flags;
+		char *tmp_name = bt_extract_eir_name(info->data, NULL);
 		if (tmp_name) {
 			g_free(dev->name);
 			dev->name = tmp_name;
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 927fb7c..e71841b 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -744,9 +744,10 @@ char *bt_extract_eir_name(uint8_t *data, uint8_t *type)
 	if (data[0] == 0)
 		return NULL;
 
-	*type = data[1];
+	if (type)
+		*type = data[1];
 
-	switch (*type) {
+	switch (data[1]) {
 	case EIR_NAME_SHORT:
 	case EIR_NAME_COMPLETE:
 		if (!g_utf8_validate((char *) (data + 2), data[0] - 1, NULL))
-- 
1.7.3.2

