Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 03/16] adaptername: Retrieve config name from adapter
Date: Wed, 24 Oct 2012 16:34:05 +0200
Message-Id: <1351089258-25179-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/adaptername.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index f58fb0f..353f11c 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -211,8 +211,10 @@ static int adaptername_probe(struct btd_adapter *adapter)
 	adapter_set_allow_name_changes(adapter, TRUE);
 	current_id = adapter_get_dev_id(adapter);
 
-	if (read_local_name(adapter_get_address(adapter), name) < 0)
-		expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
+	if (btd_adapter_get_name(adapter) != NULL)
+		return 0;
+
+	expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
 
 	DBG("Setting name '%s' for device 'hci%d'", name, current_id);
 	adapter_set_name(adapter, name);
-- 
1.7.9.5

