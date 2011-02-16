Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/4] Fix Device Name Characteristic
Date: Wed, 16 Feb 2011 21:07:31 -0200
Message-Id: <1297897651-27731-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"Name" key value defined in the main.conf file can not be used without
substitution(hostname and adapter id). This patch adds Device Name
Characteristic with length 0 and updates the value when the adapter is
initialized.

Multiple adapters with different settings is not supported at the moment
by the attribute server. GAP characteristics values will be overwritten
if the host has multiple adapters.
---
 src/adapter.c       |    4 ++++
 src/attrib-server.c |    4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2a19ace..dbae219 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2658,6 +2658,10 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		expand_name(adapter->dev.name, MAX_NAME_LENGTH, main_opts.name,
 							adapter->dev_id);
 
+	if (main_opts.attrib_server)
+		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
+			(const uint8_t *) dev->name, strlen(dev->name));
+
 	sdp_init_services_list(&adapter->bdaddr);
 	load_drivers(adapter);
 	clear_blocked(adapter);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index c1ca5ba..5e00601 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -802,7 +802,6 @@ static void register_core_services(void)
 {
 	uint8_t atval[256];
 	uuid_t uuid;
-	int len;
 	uint16_t appearance = 0x0000;
 
 	/* GAP service: primary service definition */
@@ -820,9 +819,8 @@ static void register_core_services(void)
 
 	/* GAP service: device name attribute */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	len = strlen(main_opts.name);
 	attrib_db_add(name_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-					(uint8_t *) main_opts.name, len);
+								NULL, 0);
 
 	/* GAP service: device appearance characteristic */
 	appearance_handle = 0x0008;
-- 
1.7.4.1

