Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix crash setting NULL name
Date: Fri,  6 Sep 2013 11:02:09 +0300
Message-Id: <1378454530-24686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

set_name might be invoked with name argument as shown below:
set_name(adapter, btd_adapter_get_name(adapter)) and
btd_adapter_get_name may return NULL. Add check to prevent crash.
---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 17f5508..7291a6d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -643,6 +643,9 @@ static int set_name(struct btd_adapter *adapter, const char *name)
 	struct mgmt_cp_set_local_name cp;
 	char maxname[MAX_NAME_LENGTH + 1];
 
+	if (name == NULL)
+		return -EINVAL;
+
 	memset(maxname, 0, sizeof(maxname));
 	strncpy(maxname, name, MAX_NAME_LENGTH);
 
-- 
1.8.1.2

