Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 03/10] adaptername: Retrieve config name from adapter
Date: Wed, 10 Oct 2012 18:23:24 +0200
Message-Id: <1349886211-18920-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve saved config name using adapter_get_config_name() instead
of reading it from storage file.
---
 plugins/adaptername.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index f58fb0f..46dbbe8 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -198,7 +198,8 @@ static void set_pretty_name(struct btd_adapter *adapter,
 static int adaptername_probe(struct btd_adapter *adapter)
 {
 	int current_id;
-	char name[MAX_NAME_LENGTH + 1];
+	char *name;
+	char str[MAX_NAME_LENGTH + 1];
 	char *pretty_hostname;
 
 	pretty_hostname = read_pretty_host_name();
@@ -211,8 +212,10 @@ static int adaptername_probe(struct btd_adapter *adapter)
 	adapter_set_allow_name_changes(adapter, TRUE);
 	current_id = adapter_get_dev_id(adapter);
 
-	if (read_local_name(adapter_get_address(adapter), name) < 0)
-		expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
+	if (adapter_get_config_name(adapter, &name) < 0) {
+		expand_name(str, MAX_NAME_LENGTH, main_opts.name, current_id);
+		name = str;
+	}
 
 	DBG("Setting name '%s' for device 'hci%d'", name, current_id);
 	adapter_set_name(adapter, name);
-- 
1.7.9.5

