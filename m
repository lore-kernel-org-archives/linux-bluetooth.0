Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ABCC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648AB60FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhGVFS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:18:57 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43777 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhGVFS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:18:56 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210722055931epoutp047ed3cba0a902c1885ef076da4a8c0984~UB3aUun000482404824epoutp04N
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210722055931epoutp047ed3cba0a902c1885ef076da4a8c0984~UB3aUun000482404824epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933571;
        bh=8U5CBh6ZNg6S2y27qfyL25GAfE4R9EU8YGFjHonZbrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h97EPTXfWfCZwE3ChVPmtjAlAH0oflNajmoVaMMAHK4RBvUdR9cquHj6OOQsklX5D
         O4t+LxaSXDyoTXKd5jiUZ2na/WWtfJBSrWOLejzEwig6LDjaMvj8tQM0WCNWdOOeV3
         KzRlFVqEBz0SmhpeVWMBW11d/kDrHglTKjwmtIjM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055930epcas5p45f14bdd66e56954538f130bd26ee512c~UB3ZxZAXR1890418904epcas5p4K;
        Thu, 22 Jul 2021 05:59:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.72.55882.24909F06; Thu, 22 Jul 2021 14:59:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210722052740epcas5p1fce869a24434f376d111e9e5d4b208eb~UBbnAK4ky2035920359epcas5p1I;
        Thu, 22 Jul 2021 05:27:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052740epsmtrp20b4173b2eb91d40fc903a3c7c1f2d0ef~UBbm-coZU0094500945epsmtrp2B;
        Thu, 22 Jul 2021 05:27:40 +0000 (GMT)
X-AuditID: b6c32a49-f65ff7000001da4a-63-60f909427cca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.F8.08289.BC109F06; Thu, 22 Jul 2021 14:27:39 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052739epsmtip23067e73199277b3a5ef702f5ed841b40~UBbmIIm000694006940epsmtip2U;
        Thu, 22 Jul 2021 05:27:39 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 3/7] adapter: Add support for get/set phy
 configuration property
Date:   Thu, 22 Jul 2021 10:56:36 +0530
Message-Id: <20210722052640.5863-4-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmlq4T588Eg2W3hSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mq4u/ABW8Edz4qT7xexNzAetOli5OSQ
        EDCRuLT+EmMXIxeHkMBuRomlrw6zQzifGCVm/jzEBuF8ZpT4sXwdM0zL3B9tUIldjBJ/b58A
        S0C03DAHsdkENCVef/zCBGKLCChLPNt3GMxmFtCVOPN+HRuILSwQIfHuzQewXhYBVYmvLy6x
        g9i8AlYSp2+9glomL7F6wwEwm1PAWmJG7xtmkMUSAv3sElv3vWKCKHKR2PRpI1SDsMSr41vY
        IWwpic/v9rJBNDQzSuzYvJEdwulhlHjwo5sNospe4lzTM9YuRg6g8zQl1u/ShwjLSkw9tQ7q
        aj6J3t9PoJbxSuyYB2OrSGxY1Qm37OOxhVBHeEj0fHoODcg+RonHi3YyT2CUm4WwYgEj4ypG
        ydSC4tz01GLTAsO81HK94sTc4tK8dL3k/NxNjOB41vLcwXj3wQe9Q4xMHIyHGCU4mJVEeFWK
        viYI8aYkVlalFuXHF5XmpBYfYpTmYFES52WPB0oJpCeWpGanphakFsFkmTg4pRqYGl4LfLrZ
        ztz3pKf5xBcD/vQdd+ZIT+D58781OmDS0cUGSz+3pS1SPLHBtkpCqi5kah4Hg8P+fLaebWlr
        xcS1XipqXVjYl7paUsE1Xfn0mRUJvn2B5Ww6M2MijRwvJfY/3M+hcont/1Err2M8MpLWBxg7
        hRU77kh19dqINeu/USjw/cmg8/Lc955pgkHSSjf3Ox18IdbbyP/8o5234o1wf9n3S6sv7O1z
        i12RPSFdzHyfzsW7MY+/Tbnrk+t67EfrJX87deeXt7un+G6RajNUZpmv49uglsnklr/rYpMt
        56lsG6+JO2qDmhbqBC3NuLm3giFxj7k8f8fij4aiXOuLNqQ6n0vw0GOfYOxhpMRSnJFoqMVc
        VJwIAKTeJoFWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvO4Zxp8JBt1RFndWW1vMudbHbLFt
        XTuzA7NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZdxd+ICt4I5nxcn3i9gbGA/adDFyckgI
        mEjM/dHG1sXIxSEksINR4kznMsYuRg6ghJTE42U6EDXCEiv/PWeHqPnAKPHgdis7SIJNQFPi
        9ccvTCC2iICyxLN9h8FsZgF9iacXrjOC2MICYRJN146BxVkEVCW+vrgE1ssrYCVx+tYrZogF
        8hKrNxwAszkFrCVm9L4Bs4WAapZ+2cs2gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0
        veT83E2M4FDR0trBuGfVB71DjEwcjIcYJTiYlUR4VYq+JgjxpiRWVqUW5ccXleakFh9ilOZg
        URLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAdIzhyqn4I6sVfFX4dGJaZ26LVmAuvPbjrLSx
        x/Vy1eK/TDIbJbdqXDsrV1qYskz3xYTdifzuu7geTL/TPLUmn7Mg1jU9vCXzPM+cI1Gy21XX
        tGSvfnBgb5PcrodnXKaIPzCoP8q470jDXWuuTMd5zyZy6uw3vx/Rs+X1i+3LPb9XnJ6mvJ7d
        o2HhvY/Xlu+INrhr9tJuSp5FwqWcRV0fPcpVTO+Vdjj9Op9661Sx8u5nCdMmnTL8lbR9n6uI
        Sp7rdIMlNxh52O1PMD4JWtXIWCUZHSHyv43RcRdvJ3vDxdAPdRNDVVLXvWCd0vlkst5Uhud7
        vder/mNYGrVpr1OY2Zew850nfaZeaKh9qO7hq8RSnJFoqMVcVJwIANLDrw2EAgAA
X-CMS-MailID: 20210722052740epcas5p1fce869a24434f376d111e9e5d4b208eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052740epcas5p1fce869a24434f376d111e9e5d4b208eb
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052740epcas5p1fce869a24434f376d111e9e5d4b208eb@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change introduces a new adapter property(PhyConfiguration)
which will be used to read and set controller's PHY.
This property is based upon MGMT_OP_GET_PHY_CONFIGURATION
and MGMT_OP_SET_PHY_CONFIGURATION operations.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 src/adapter.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 12e4ff5c0..fd4c654dc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -285,6 +285,11 @@ struct btd_adapter {
 
 	bool le_simult_roles_supported;
 	bool quality_report_supported;
+
+	uint32_t supported_phys;
+	uint32_t configurable_phys;
+	uint32_t selected_phys;
+	uint32_t pending_phys;
 };
 
 typedef enum {
@@ -3245,6 +3250,237 @@ static gboolean property_get_roles(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static struct phys_config {
+	uint32_t flag;
+	const char *name;
+} phys_str[] = {
+	{ MGMT_PHY_BR_1M_1SLOT, "BR1M1SLOT" },
+	{ MGMT_PHY_BR_1M_3SLOT, "BR1M3SLOT" },
+	{ MGMT_PHY_BR_1M_5SLOT, "BR1M5SLOT" },
+	{ MGMT_PHY_EDR_2M_1SLOT, "EDR2M1SLOT" },
+	{ MGMT_PHY_EDR_2M_3SLOT, "EDR2M3SLOT" },
+	{ MGMT_PHY_EDR_2M_5SLOT, "EDR2M5SLOT" },
+	{ MGMT_PHY_EDR_3M_1SLOT, "EDR3M1SLOT" },
+	{ MGMT_PHY_EDR_3M_3SLOT, "EDR3M3SLOT" },
+	{ MGMT_PHY_EDR_3M_5SLOT, "EDR3M5SLOT" },
+	{ MGMT_PHY_LE_1M_TX, "LE1MTX" },
+	{ MGMT_PHY_LE_1M_RX, "LE1MRX" },
+	{ MGMT_PHY_LE_2M_TX, "LE2MTX" },
+	{ MGMT_PHY_LE_2M_RX, "LE2MRX" },
+	{ MGMT_PHY_LE_CODED_TX, "LECODEDTX" },
+	{ MGMT_PHY_LE_CODED_RX, "LECODEDRX" }
+};
+
+static void append_phys_str(DBusMessageIter *array, uint32_t phys)
+{
+	unsigned int i;
+
+	for (i = 0; i < NELEM(phys_str); i++) {
+		if (phys & phys_str[i].flag)
+			dbus_message_iter_append_basic(array, DBUS_TYPE_STRING,
+						&phys_str[i].name);
+	}
+}
+
+static bool parse_phys_str(DBusMessageIter *array, uint32_t *phys)
+{
+	const char *str;
+	unsigned int i;
+
+	*phys = 0;
+
+	do {
+		if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_STRING)
+			return false;
+
+		dbus_message_iter_get_basic(array, &str);
+
+		for (i = 0; i < NELEM(phys_str); i++) {
+			if (!strcmp(str, phys_str[i].name)) {
+				*phys |= phys_str[i].flag;
+				break;
+			}
+		}
+
+		if (i == NELEM(phys_str))
+			return false;
+	} while (dbus_message_iter_next(array));
+
+	return true;
+}
+
+static void set_default_phy_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct property_set_data *data = user_data;
+	struct btd_adapter *adapter = data->adapter;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		adapter->pending_phys = 0;
+		btd_error(adapter->dev_id,
+				"Failed to set PHY configuration: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		g_dbus_pending_property_error(data->id, ERROR_INTERFACE ".Failed",
+							mgmt_errstr(status));
+		return;
+	}
+
+	/* The default phys are successfully set. */
+	btd_info(adapter->dev_id, "PHY configuration successfully set");
+
+	adapter->selected_phys = adapter->pending_phys;
+	adapter->pending_phys = 0;
+
+	g_dbus_pending_property_success(data->id);
+
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "PhyConfiguration");
+}
+
+static int set_default_phy(struct btd_adapter *adapter, uint32_t phys,
+			GDBusPendingPropertySet id)
+{
+	struct mgmt_cp_set_phy_confguration cp;
+	struct property_set_data *data;
+	uint32_t unconfigure_phys;
+
+	if (!phys) {
+		btd_error(adapter->dev_id,
+			"Set PHY configuration failed: No supplied phy(s)");
+		return -EINVAL;
+	}
+
+	if (phys & ~(adapter->supported_phys)) {
+		btd_error(adapter->dev_id,
+			"Set PHY configuration failed: supplied phy(s) is not supported");
+		return -EINVAL;
+	}
+
+	if (phys == adapter->selected_phys) {
+		DBG("PHYs are already set [0x%x]", phys);
+		g_dbus_pending_property_success(id);
+		return 0;
+	}
+
+	unconfigure_phys = adapter->supported_phys & ~(adapter->configurable_phys);
+
+	if ((phys & unconfigure_phys) != unconfigure_phys) {
+		btd_error(adapter->dev_id,
+			"Set PHY configuration failed: supplied phy(s) must include PHYs %u",
+			unconfigure_phys);
+		return -EINVAL;
+	}
+
+	if (adapter->pending_phys) {
+		btd_error(adapter->dev_id,
+			"Set PHY configuration failed: Operation in progress");
+		return -EINPROGRESS;
+	}
+
+	adapter->pending_phys = phys;
+
+	cp.selected_phys = cpu_to_le32(phys);
+
+	data = g_try_new0(struct property_set_data, 1);
+	if (!data)
+		goto failed;
+
+	data->adapter = adapter;
+	data->id = id;
+
+	DBG("sending set phy configuration command for index %u", adapter->dev_id);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
+				adapter->dev_id, sizeof(cp), &cp,
+				set_default_phy_complete, data, g_free) > 0)
+		return 0;
+
+	g_free(data);
+
+failed:
+	btd_error(adapter->dev_id, "Failed to set PHY configuration for index %u",
+							adapter->dev_id);
+	adapter->pending_phys = 0;
+
+	return -EIO;
+}
+
+static gboolean property_get_phy_configuration(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	append_phys_str(&array, adapter->selected_phys);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static void property_set_phy_configuration(
+				const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter array;
+	uint32_t phys;
+	int ret;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+
+	if (!(adapter->supported_settings & MGMT_SETTING_PHY_CONFIGURATION)) {
+		ret = -ENOTSUP;
+		goto failed;
+	}
+
+	if (!parse_phys_str(&array, &phys)) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	ret = set_default_phy(adapter, phys, id);
+
+	/*
+	 * gdbus_pending_property_success event will be sent when success status
+	 * will be received from mgmt.
+	 */
+	if (!ret)
+		return;
+
+failed:
+	switch (-ret) {
+	case EINVAL:
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		break;
+	case ENOTSUP:
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotSupported",
+					"Operation is not supported");
+		break;
+	case EINPROGRESS:
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InProgress",
+					"Operation is in progress");
+		break;
+	default:
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+							strerror(-ret));
+		break;
+	}
+}
+
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -3517,6 +3753,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
 	{ "Roles", "as", property_get_roles },
+	{ "PhyConfiguration", "as", property_get_phy_configuration,
+					property_set_phy_configuration },
 	{ }
 };
 
@@ -9389,6 +9627,43 @@ static void read_exp_features(struct btd_adapter *adapter)
 	btd_error(adapter->dev_id, "Failed to read exp features info");
 }
 
+static void read_phy_configuration_resp(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_get_phy_confguration *rp = param;
+	struct btd_adapter *adapter = user_data;
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+				"Failed to get PHY configuration info: %s (0x%02x)",
+				mgmt_errstr(status), status);
+		return;
+	}
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter->dev_id, "Response too small");
+		return;
+	}
+
+	adapter->supported_phys = get_le32(&rp->supported_phys);
+	adapter->configurable_phys = get_le32(&rp->configurable_phys);
+	adapter->selected_phys = get_le32(&rp->selected_phys);
+
+	DBG("Supported phys: [0x%x]", adapter->supported_phys);
+	DBG("Configurable phys: [0x%x]", adapter->configurable_phys);
+	DBG("Selected phys: [0x%x]", adapter->selected_phys);
+}
+
+static void read_phy_configuration(struct btd_adapter *adapter)
+{
+	if (mgmt_send(adapter->mgmt, MGMT_OP_GET_PHY_CONFIGURATION,
+			adapter->dev_id, 0, NULL, read_phy_configuration_resp,
+			adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to read phy configuration info");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9498,6 +9773,13 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
+	if (btd_opts.experimental &&
+			btd_has_kernel_features(KERNEL_EXP_FEATURES))
+		read_exp_features(adapter);
+
+	if (adapter->supported_settings & MGMT_SETTING_PHY_CONFIGURATION)
+		read_phy_configuration(adapter);
+
 	err = adapter_register(adapter);
 	if (err < 0) {
 		btd_error(adapter->dev_id, "Unable to register new adapter");
-- 
2.17.1

