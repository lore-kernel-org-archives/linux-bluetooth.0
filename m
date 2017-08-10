Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 10/14] advertising: Don't depend on kernel to include an appearance
Date: Thu, 10 Aug 2017 16:32:47 +0300
Message-Id: <20170810133251.23920-10-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The flag to include an Appearance may not be available in older kernels
so instead of depending on the kernel to add it just generate it locally
and add as part of advertising data:

@ MGMT Command: Add Advertising (0x003e) plen 15
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 4
        Appearance: Unknown (0x0000)
        Scan response length: 0
---
 src/advertising.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 7e7458414..61b17e400 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -536,6 +536,18 @@ static size_t calc_max_adv_len(struct btd_adv_client *client, uint32_t flags)
 	return max;
 }
 
+static uint8_t *generate_adv_data(struct btd_adv_client *client,
+						uint32_t *flags, size_t *len)
+{
+	if ((*flags & MGMT_ADV_FLAG_APPEARANCE)) {
+		*flags &= ~MGMT_ADV_FLAG_APPEARANCE;
+		/* TODO: Get the appearance from the adaptor once supported. */
+		bt_ad_add_appearance(client->data, 0x0000);
+	}
+
+	return bt_ad_generate(client->data, len);
+}
+
 static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
 						uint32_t *flags, size_t *len)
 {
@@ -573,8 +585,7 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 
 	flags |= client->flags;
 
-	adv_data = bt_ad_generate(client->data, &adv_data_len);
-
+	adv_data = generate_adv_data(client, &flags, &adv_data_len);
 	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
 		error("Advertising data too long or couldn't be generated.");
 
-- 
2.13.4

