Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B7BC636D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBKK5R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjBKK5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:12 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB383D2
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:10 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6F56F240769
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:09 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGs096Cz9rxF;
        Sat, 11 Feb 2023 11:57:08 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 9/9] bap: handle adapters that are not CIS Central / Peripheral capable
Date:   Sat, 11 Feb 2023 10:53:53 +0000
Message-Id: <80fb0196727ff8ea422b0e003be028a99844da70.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When BT adapter is not CIS Peripheral capable, set client-only for the
local db, so that ASCS/PACS are not registered.

When BT adapter is not CIS Central capable, ignore the remote device
GATT database, and don't start client sessions.
---

Notes:
    v2:
    * Use bt_bap_set_client_only and btd_adapter_has_features to do the
      stuff.
    * Don't attach client in bap_accept, if adapter doesn't support
      CIS Central.
    
      We still mark the service as connected.  If we want to mark the
      service unavailable in this case, we could return error in
      device_probe. Server connections are handled in bap_attached/detached
      and work also in this case, this should work based on looking at the
      code, and it works in testing.
    
    The patch series was manually tested with two machines running it, with
    Central flag forced to false on one end, and Peripheral flag to false on
    the other, and testing Pipewire being able to play + record audio over
    the BAP link.
    
    Playback + recording on non-BlueZ remote device was also tested with
    Peripheral flag disabled.
    
    bluetoothctl:
    
    Server (CIS Central bit disabled):
    
        [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
        [/local/endpoint/ep0] Auto Accept (yes/no): yes
        [/local/endpoint/ep0] CIG (auto/value): a
        [/local/endpoint/ep0] CIS (auto/value): a
        Capabilities:
          03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
        Endpoint /local/endpoint/ep0 registered
        [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
        [/local/endpoint/ep1] Auto Accept (yes/no): yes
        [/local/endpoint/ep1] CIG (auto/value): a
        [/local/endpoint/ep1] CIS (auto/value): a
        Capabilities:
          03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
        Endpoint /local/endpoint/ep1 registered
        [bluetooth]# show
        Controller XX:XX:XX:XX:XX:XX (public)
    	Name: xxx
    	Alias: xxx
    	Class: 0x00000000
    	Powered: yes
    	PowerState: on
    	Discoverable: no
    	DiscoverableTimeout: 0x000000b4
    	Pairable: no
    	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
    	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
    	UUID: Volume Control            (00001844-0000-1000-8000-00805f9b34fb)
    	UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
    	UUID: Audio Stream Control      (0000184e-0000-1000-8000-00805f9b34fb)
    	UUID: Published Audio Capabil.. (00001850-0000-1000-8000-00805f9b34fb)
    	Modalias: usb:v1D6Bp0246d0542
    	Discovering: no
    	Roles: central
    	Roles: peripheral
    	ExperimentalFeatures: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)
    	ExperimentalFeatures: BlueZ Experimental Blue.. (330859bc-7506-492d-9370-9a6f0614037f)
    	ExperimentalFeatures: BlueZ Experimental ISO... (6fbaf188-05e0-496a-9885-d6ddfdb4e03e)
    
    Client (CIS Peripheral bit disabled):
    
        [bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
        [/local/endpoint/ep0] Auto Accept (yes/no): yes
        [/local/endpoint/ep0] CIG (auto/value): a
        [/local/endpoint/ep0] CIS (auto/value): a
        Capabilities:
          03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
        Endpoint /local/endpoint/ep0 registered
        [bluetooth]# endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
        [/local/endpoint/ep1] Auto Accept (yes/no): yes
        [/local/endpoint/ep1] CIG (auto/value): a
        [/local/endpoint/ep1] CIS (auto/value): a
        Capabilities:
          03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
        Endpoint /local/endpoint/ep1 registered
        [bluetooth]# show
        Controller YY:YY:YY:YY:YY:YY (public)
            Name: yyy
            Alias: yyy
            Class: 0x00000000
            Powered: yes
            PowerState: on
            Discoverable: no
            DiscoverableTimeout: 0x000000b4
            Pairable: no
            UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
            UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
            UUID: Volume Control            (00001844-0000-1000-8000-00805f9b34fb)
            UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
            Modalias: usb:v1D6Bp0246d0542
            Discovering: no
            Roles: central
            Roles: peripheral
            ExperimentalFeatures: BlueZ Experimental ISO... (6fbaf188-05e0-496a-9885-d6ddfdb4e03e)
    
    The client is client-only, and has no ASCS/PACS.
    
        [bluetooth]# connect XX:XX:XX:XX:XX:XX
        ...
        [server]# transport.list
        Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd12
        Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd13
        [server]# endpoint.list
        Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
        Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
        [server]# endpoint.list local
        /local/endpoint/ep0
        /local/endpoint/ep1
        [server]# transport.acquire /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd12
        Acquire successful: fd 7 MTU 40:40
        [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd13 State: active
        [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd12 State: active
    
    Server:
    
        Auto Acquiring...
        [CHG] Transport /org/bluez/hci0/dev_YY_YY_YY_YY_YY_YY/fd6 State: pending
        Acquire successful: fd 7 MTU 40:40
        [CHG] Transport /org/bluez/hci0/dev_YY_YY_YY_YY_YY_YY/fd7 State: active
        [CHG] Transport /org/bluez/hci0/dev_YY_YY_YY_YY_YY_YY/fd6 State: active
        [client]# endpoint.list
        [client]# endpoint.list local
        /local/endpoint/ep0
        /local/endpoint/ep1
    
    The server is peripheral-only and has only local endpoints.

 profiles/audio/bap.c   | 26 ++++++++++++++++++++++++--
 profiles/audio/media.c |  6 +++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b8c75f195..426aa89aa 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1259,6 +1259,7 @@ static int bap_probe(struct btd_service *service)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
+	struct gatt_db *adapter_db, *device_db;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -1269,17 +1270,32 @@ static int bap_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
+	if (!btd_adapter_has_features(adapter, ADAPTER_CIS_CENTRAL) &&
+	    !btd_adapter_has_features(adapter, ADAPTER_CIS_PERIPHERAL)) {
+		DBG("BAP requires CIS features, unsupported by adapter");
+		return -ENOTSUP;
+	}
+
 	/* Ignore, if we were probed for this device already */
 	if (data) {
 		error("Profile probed twice for the same device!");
 		return -EINVAL;
 	}
 
+	adapter_db = btd_gatt_database_get_db(database);
+
+	if (!btd_adapter_has_features(adapter, ADAPTER_CIS_PERIPHERAL))
+		bt_bap_set_client_only(adapter_db);
+
+	if (btd_adapter_has_features(adapter, ADAPTER_CIS_CENTRAL))
+		device_db = btd_device_get_gatt_db(device);
+	else
+		device_db = NULL;
+
 	data = bap_data_new(device);
 	data->service = service;
 
-	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
-					btd_device_get_gatt_db(device));
+	data->bap = bt_bap_new(adapter_db, device_db);
 	if (!data->bap) {
 		error("Unable to create BAP instance");
 		free(data);
@@ -1303,6 +1319,7 @@ static int bap_probe(struct btd_service *service)
 static int bap_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
@@ -1315,6 +1332,11 @@ static int bap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	if (!btd_adapter_has_features(adapter, ADAPTER_CIS_CENTRAL)) {
+		btd_service_connecting_complete(service, 0);
+		return 0;
+	}
+
 	if (!bt_bap_attach(data->bap, client)) {
 		error("BAP unable to attach");
 		return -EINVAL;
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 0e0c40dc7..d9e133007 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1110,6 +1110,7 @@ static void bap_debug(const char *str, void *user_data)
 static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 								int *err)
 {
+	struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
 	struct btd_gatt_database *database;
 	struct gatt_db *db;
 	struct iovec data;
@@ -1122,7 +1123,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	database = btd_adapter_get_database(endpoint->adapter->btd_adapter);
+	database = btd_adapter_get_database(adapter);
 	if (!database) {
 		error("Adapter database not found");
 		return false;
@@ -1158,6 +1159,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		metadata->iov_len = endpoint->metadata_size;
 	}
 
+	if (!btd_adapter_has_features(adapter, ADAPTER_CIS_PERIPHERAL))
+		bt_bap_set_client_only(db);
+
 	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
 				endpoint->cid, endpoint->vid, &endpoint->qos,
 				&data, metadata);
-- 
2.39.1

