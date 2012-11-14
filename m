Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] adapter: Convert storage trusts
Date: Wed, 14 Nov 2012 11:16:05 +0100
Message-Id: <1352888166-7391-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
References: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All entry in trusts file are set to [all] (if a device is not trusted
it does not have entry in this file).
So, we do not need to check entry value and set device (entry key) as
trusted.
---
 src/adapter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ea7b8ff..99d58b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2544,6 +2544,11 @@ static void convert_aliases_entry(GKeyFile *key_file, void *value)
 	g_key_file_set_string(key_file, "General", "Alias", value);
 }
 
+static void convert_trusts_entry(GKeyFile *key_file, void *value)
+{
+	g_key_file_set_boolean(key_file, "General", "Trusted", TRUE);
+}
+
 static void convert_entry(char *key, char *value, void *user_data)
 {
 	struct device_converter *converter = user_data;
@@ -2619,6 +2624,9 @@ static void convert_device_storage(struct btd_adapter *adapter)
 
 	/* Convert aliases */
 	convert_file("aliases", address, convert_aliases_entry);
+
+	/* Convert trusts */
+	convert_file("trusts", address, convert_trusts_entry);
 }
 
 static void convert_config(struct btd_adapter *adapter, const char *filename,
-- 
1.7.9.5

