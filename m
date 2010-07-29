Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] modem: Add method to get modem by path
Date: Thu, 29 Jul 2010 15:18:19 +0800
Message-Id: <1280387901-8581-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1280387901-8581-1-git-send-email-zhenhua.zhang@intel.com>
References: <1280387901-8581-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return modem instance by searching modem path.
---
 include/modem.h |    1 +
 src/modem.c     |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/modem.h b/include/modem.h
index e1cd049..34c3fbf 100644
--- a/include/modem.h
+++ b/include/modem.h
@@ -36,6 +36,7 @@ void ofono_modem_remove_interface(struct ofono_modem *modem,
 					const char *interface);
 
 const char *ofono_modem_get_path(struct ofono_modem *modem);
+struct ofono_modem *ofono_modem_get_modem_by_path(const char *path);
 
 void ofono_modem_set_data(struct ofono_modem *modem, void *data);
 void *ofono_modem_get_data(struct ofono_modem *modem);
diff --git a/src/modem.c b/src/modem.c
index f89d609..6907a5e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -157,6 +157,21 @@ const char *ofono_modem_get_path(struct ofono_modem *modem)
 	return NULL;
 }
 
+struct ofono_modem *ofono_modem_get_modem_by_path(const char *path)
+{
+	GSList *l;
+	struct ofono_modem *modem = NULL;
+
+	for (l = g_modem_list; l; l = l->next) {
+		modem = l->data;
+
+		if (g_str_equal(modem->path, path))
+			break;
+	}
+
+	return modem;
+}
+
 struct ofono_atom *__ofono_modem_add_atom(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					void (*destruct)(struct ofono_atom *),
-- 
1.7.0.4

