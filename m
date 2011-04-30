Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 12/16] Remove obsolete code.
Date: Fri, 29 Apr 2011 21:27:28 -0300
Message-Id: <1304123252-14464-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

adapter_get_discover_type() has become obsolete. This patch removes it and
do the proper adaptation.
---
 plugins/hciops.c |    8 --------
 src/adapter.c    |   38 --------------------------------------
 src/adapter.h    |    3 ---
 src/event.c      |    3 +--
 4 files changed, 1 insertions(+), 51 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 23e8915..8653ab5 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1710,7 +1710,6 @@ static void read_simple_pairing_mode_complete(int index, void *ptr)
 static void read_local_ext_features_complete(int index,
 				const read_local_ext_features_rp *rp)
 {
-	struct btd_adapter *adapter;
 	struct dev_info *dev = &devs[index];
 
 	DBG("hci%d status %u", index, rp->status);
@@ -1718,18 +1717,11 @@ static void read_local_ext_features_complete(int index,
 	if (rp->status)
 		return;
 
-	adapter = manager_find_adapter_by_id(index);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
 	/* Local Extended feature page number is 1 */
 	if (rp->page_num != 1)
 		return;
 
 	memcpy(dev->extfeatures, rp->features, sizeof(dev->extfeatures));
-	btd_adapter_update_local_ext_features(adapter, rp->features);
 }
 
 static void read_bd_addr_complete(int index, read_bd_addr_rp *rp)
diff --git a/src/adapter.c b/src/adapter.c
index 0279494..5de8775 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -136,7 +136,6 @@ struct btd_adapter {
 	sdp_list_t *services;		/* Services associated to adapter */
 
 	uint8_t  features[8];
-	uint8_t  extfeatures[8];
 
 	gboolean pairable;		/* pairable state */
 	gboolean initialized;
@@ -2336,37 +2335,6 @@ static void update_oor_devices(struct btd_adapter *adapter)
 	adapter->oor_devices =  g_slist_copy(adapter->found_devices);
 }
 
-static gboolean bredr_capable(struct btd_adapter *adapter)
-{
-	return (adapter->features[4] & LMP_NO_BREDR) == 0 ? TRUE : FALSE;
-}
-
-static gboolean le_capable(struct btd_adapter *adapter)
-{
-	return (adapter->features[4] & LMP_LE &&
-			adapter->extfeatures[0] & LMP_HOST_LE) ? TRUE : FALSE;
-}
-
-int adapter_get_discover_type(struct btd_adapter *adapter)
-{
-	gboolean le, bredr;
-	int type;
-
-	le = le_capable(adapter);
-	bredr = bredr_capable(adapter);
-
-	if (main_opts.le && le)
-		type = bredr ? DISC_INTERLEAVE : DISC_LE;
-	else
-		type = main_opts.discov_interval ? DISC_STDINQ :
-							DISC_PINQ;
-
-	if (main_opts.name_resolv)
-		type |= DISC_RESOLVNAME;
-
-	return type;
-}
-
 void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 					uint8_t *on_mode, gboolean *pairable)
 {
@@ -3640,12 +3608,6 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	return adapter_ops->passkey_reply(adapter->dev_id, bdaddr, passkey);
 }
 
-void btd_adapter_update_local_ext_features(struct btd_adapter *adapter,
-						const uint8_t *features)
-{
-	memcpy(adapter->extfeatures, features, 8);
-}
-
 int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					bt_hci_result_t cb, gpointer user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index a408a92..1db9225 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -264,9 +264,6 @@ int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							uint32_t passkey);
 
-void btd_adapter_update_local_ext_features(struct btd_adapter *adapter,
-						const uint8_t *features);
-
 int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 				bt_hci_result_t cb, gpointer user_data);
 
diff --git a/src/event.c b/src/event.c
index bf6f4e3..b223448 100644
--- a/src/event.c
+++ b/src/event.c
@@ -456,8 +456,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 		write_remote_eir(local, peer, data);
 
 	/* the inquiry result can be triggered by NON D-Bus client */
-	if (adapter_get_discover_type(adapter) & DISC_RESOLVNAME &&
-				adapter_has_discov_sessions(adapter))
+	if (main_opts.name_resolv && adapter_has_discov_sessions(adapter))
 		name_status = NAME_REQUIRED;
 	else
 		name_status = NAME_NOT_REQUIRED;
-- 
1.7.1

