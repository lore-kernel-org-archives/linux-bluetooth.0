Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2207C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878716127C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhGVFU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19594 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhGVFU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:28 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722060103epoutp02e393e7df816488f17375a565431903f5~UB4v8CWk41764317643epoutp02M
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:01:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722060103epoutp02e393e7df816488f17375a565431903f5~UB4v8CWk41764317643epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933663;
        bh=GgWyk2DnZQ4LcpuBfoNND2z6/+1ylic5BsNXwwY1Fqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXsV9xhslWgBtH2+FYaBklAQeaOtzzyZrXHhLOijCDuFFI8PpmpchRPO27S+jM/KD
         VgaXSEBZ+dtxm98cUoj9LL1NVyrHtdaA898PQd154uDFnnCkqf5AdxpVVVb1kbQlhG
         c7Blj/E5UutQmJfDGmK529RofA/rMkAZ1KhPhq2E=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210722060053epcas5p3e32e5f4f09d84d8875391a9df6aa82eb~UB4nVnA300434204342epcas5p3S;
        Thu, 22 Jul 2021 06:00:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.7B.11627.59909F06; Thu, 22 Jul 2021 15:00:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055012epcas5p1bb92b3e31233da03906c4f562b22b4fc~UBvSRZr6w1933919339epcas5p1q;
        Thu, 22 Jul 2021 05:50:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055012epsmtrp135c35128e087c34e213c420cd6cf438d~UBvSQOwNJ3087030870epsmtrp1e;
        Thu, 22 Jul 2021 05:50:12 +0000 (GMT)
X-AuditID: b6c32a4b-acdff70000022d6b-4c-60f90995b469
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.14.08394.41709F06; Thu, 22 Jul 2021 14:50:12 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055011epsmtip19d0dda9537b3b9bb20424af634788ccb~UBvRXX1Go1099710997epsmtip1h;
        Thu, 22 Jul 2021 05:50:11 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 4/8] device: Add support for get/set PHY property
Date:   Thu, 22 Jul 2021 11:19:47 +0530
Message-Id: <20210722054951.8291-5-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmlu5Uzp8JBv9bRSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MpoWdvAXtDjUvH8+Ur2BsY+8y5GTg4J
        AROJmU/2M3YxcnEICexmlJg0/w4TSEJI4BOjxMU7FhCJb4wS+/dPZYLp6NjyhRkisZdR4smJ
        JcxwHd9OKYPYbAKaEq8/fgFrEBFQlni27zCYzSygK3Hm/To2EFtYwF1iyqPJYDaLgKrEue7J
        YDW8AlYSq2ZcYIdYJi+xesMBsPmcAtYSBx7dZAdZLCEwmV1iUcsFZogiF4nd814wQtjCEq+O
        b4FqlpJ42d8G1dDMKLFj80Yop4dR4sGPbjaIKnuJc03PWLsYOYDO05RYv0sfIiwrMfXUOqir
        +SR6fz+Bep9XYsc8GFtFYsOqTrhlH48tZAYZIyHgIfF9UQQkhPoYJVY9+csygVFuFsKGBYyM
        qxglUwuKc9NTi00LjPNSy/WKE3OLS/PS9ZLzczcxgmNZy3sH46MHH/QOMTJxMB5ilOBgVhLh
        VSn6miDEm5JYWZValB9fVJqTWnyIUZqDRUmclz0eKCWQnliSmp2aWpBaBJNl4uCUamC62ev8
        0aPX6+FtS63+mqX18QXcipK7/oQoT+/g37BDU0oryF0vN/S4ZePn22zFZjf/72YruP+wR2GR
        xZOEc7tu96xuW+MisH7OpFdqv89Xnpi9wLHqY1X6uekx1a4/czdcD8tKOL/RI+n0dr+7HQZz
        K5PmLXwkyz0na5Psit1/Lfjjsq89WmfnInzJT/7P9NDylC+nFC6e4n5uK/7d6soe+aBMwclx
        zX9TTdrm3V6e2fTS81GNguTDm3Kr2aJj2Gz8wtWblQ4Xzdoje6NZ3sbuGt9U3rLbm++c9F7j
        +7qxcev8I249/5dv3qgjVbfqLUP1GadyAw8XW9ONBrZ1i5qvnot7dGpvY1CjY8+Pd3eUWIoz
        Eg21mIuKEwFqIX1rVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSnK4I+88Eg6frNC3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MpoWdvAXtDjUvH8+Ur2BsY+8y5GTg4J
        AROJji1fmLsYuTiEBHYzSux9vAfI4QBKSEk8XqYDUSMssfLfc3aImg+MEndW72cBSbAJaEq8
        /viFCcQWEVCWeLbvMJjNLKAv8fTCdUYQW1jAXWLKo8lsIDaLgKrEue7JYDW8AlYSq2ZcYIdY
        IC+xesMBZhCbU8Ba4sCjm2BxIaCae6+3ME9g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
        L10vOT93EyM4WLQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6Voq8JQrwpiZVVqUX58UWlOanFhxil
        OViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTD1yMztmd4bIyHOF31yrv9/llVCb4WlUqf7
        XNK9tXHPKvsLEWsf690/9q652IuH/Z72Hf7Nv9+EzsxelsS7UMfu9JE+XXdulxuvzkinOUYn
        3X2aO3GNrW1bQ9Ln9l1FeX92Zx8OmbmtbpJznenDtqeqR6wKPVcuWvPP/qdvp1JSsbgzq/qG
        3PxELfVqq6dLp8/f8f0uy9J3VzSqZwTMFOkP2sSwOf6KZIHZ77+rdRZ/2HpEX+LlqxelR5N5
        rJiu35DOUn3rPqumRlr37xNB30PFuybsfcS9tDzgsvXzcL4/C86ui1ii3yog+jJVeH4Hq/9a
        mU9vjvNcuP93q8pSeRm2d1ouP8LsVN+Izzz251qzEktxRqKhFnNRcSIA3gHaVYUCAAA=
X-CMS-MailID: 20210722055012epcas5p1bb92b3e31233da03906c4f562b22b4fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055012epcas5p1bb92b3e31233da03906c4f562b22b4fc
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055012epcas5p1bb92b3e31233da03906c4f562b22b4fc@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change introduces a new device property
which will enable user to get PHYs of the current
LE Connection.
It will also allow to set preferred PHYs for
a particular LE connection.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 lib/bluetooth.h |   9 ++
 src/adapter.c   |   8 ++
 src/adapter.h   |   1 +
 src/device.c    | 220 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 9ab033ec4..a6afaa753 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -127,6 +127,15 @@ struct bt_voice {
 #define BT_PHY_LE_2M_RX		0x00001000
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
+#define BT_PHY_LE_CODED_S2	0x00008000
+#define BT_PHY_LE_CODED_S8	0x00010000
+
+#define BT_PHY_LE_MASK (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX | \
+				BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX | \
+				BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX)
+
+#define BT_PHY_LE_CODED_MASK (BT_PHY_LE_CODED_TX | \
+				BT_PHY_LE_CODED_RX)
 
 #define BT_MODE			15
 
diff --git a/src/adapter.c b/src/adapter.c
index 3861ade8a..5de92a570 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6661,6 +6661,14 @@ const char *adapter_get_path(struct btd_adapter *adapter)
 	return adapter->path;
 }
 
+uint32_t adapter_get_supported_phys(struct btd_adapter *adapter)
+{
+	if (!adapter)
+		return 0;
+
+	return adapter->supported_phys;
+}
+
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
 {
 	return &adapter->bdaddr;
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcc..21046ceaa 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -87,6 +87,7 @@ struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
 						   const char *path);
 
 const char *adapter_get_path(struct btd_adapter *adapter);
+uint32_t adapter_get_supported_phys(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
 const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
diff --git a/src/device.c b/src/device.c
index b29aa195d..6f74989c7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -272,6 +272,9 @@ struct btd_device {
 
 	GIOChannel	*att_io;
 	guint		store_id;
+
+	uint32_t phys;
+	bool pending_phys;
 };
 
 static const uint16_t uuid_list[] = {
@@ -1470,6 +1473,212 @@ static gboolean dev_property_wake_allowed_exist(
 	return device_get_wake_support(device);
 }
 
+static struct phys_config {
+	uint32_t flag;
+	const char *name;
+} phys_str[] = {
+	{ BT_PHY_LE_1M_TX, "LE1MTX" },
+	{ BT_PHY_LE_1M_RX, "LE1MRX" },
+	{ BT_PHY_LE_2M_TX, "LE2MTX" },
+	{ BT_PHY_LE_2M_RX, "LE2MRX" },
+	{ BT_PHY_LE_CODED_TX, "LECODEDTX" },
+	{ BT_PHY_LE_CODED_RX, "LECODEDRX" },
+	{ BT_PHY_LE_CODED_S2, "LECODEDS2" },
+	{ BT_PHY_LE_CODED_S8, "LECODEDS8" }
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
+static void device_set_phy(struct btd_device *device, uint32_t phys)
+{
+	if (!device)
+		return;
+
+	DBG("Device PHYs %u", phys);
+
+	device->phys = phys;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "Phy");
+
+}
+
+static int set_preferred_phy(struct btd_device *device, uint32_t phys)
+{
+	GIOChannel *io;
+	GError *gerr = NULL;
+	uint32_t supported_phys = 0;
+	int ret;
+
+	if (!device || !phys) {
+		error("Invalid arguments in method call");
+		return -EINVAL;
+	}
+
+	if (!device->le) {
+		error("Operation is not supported");
+		return -ENOTSUP;
+	}
+
+	if (!device->le_state.connected || !device->attrib) {
+		error("Device Not Connected");
+		return -ENOTCONN;
+	}
+
+	io = g_attrib_get_channel(device->attrib);
+
+	if (!io) {
+		error("Device Not Connected");
+		return -ENOTCONN;
+	}
+
+	supported_phys = adapter_get_supported_phys(device->adapter) &
+					BT_PHY_LE_MASK;
+
+	if (supported_phys & BT_PHY_LE_CODED_MASK) {
+		supported_phys |= BT_PHY_LE_CODED_S2;
+		supported_phys |= BT_PHY_LE_CODED_S8;
+	}
+
+	if (phys & ~supported_phys) {
+		error("Supplied phy(s) are not supported");
+		return -EINVAL;
+	}
+
+	if (device->pending_phys) {
+		error("Operation already in progress");
+		return -EINPROGRESS;
+	}
+
+	device->pending_phys = true;
+
+	if (device->phys == phys) {
+		device->pending_phys = false;
+		return 0;
+	}
+
+	bt_io_set(io, &gerr, BT_IO_OPT_PHY, phys, BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("bt_io_set: %s", gerr->message);
+		device->pending_phys = false;
+		ret = gerr->code;
+		g_error_free(gerr);
+		return ret;
+	}
+
+	return 0;
+}
+
+static gboolean dev_property_get_phy(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	append_phys_str(&array, device->phys);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static void dev_property_set_phy(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct btd_device *device = data;
+	DBusMessageIter array;
+	uint32_t phys;
+	int ret;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	dbus_message_iter_recurse(value, &array);
+
+	if (!parse_phys_str(&array, &phys)) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	ret = set_preferred_phy(device, phys);
+
+	if (ret >= 0) {
+		g_dbus_pending_property_success(id);
+		return;
+	}
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
+	case ENOTCONN:
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".NotConnected",
+					"Device Not Connected");
+		break;
+	case EINPROGRESS:
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InProgress",
+					"Operation already in progress");
+		break;
+	default:
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+							strerror(-ret));
+		break;
+	}
+
+}
+
 static bool disconnect_all(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -2950,6 +3159,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "WakeAllowed", "b", dev_property_get_wake_allowed,
 				dev_property_set_wake_allowed,
 				dev_property_wake_allowed_exist },
+	{ "Phy", "as", dev_property_get_phy, dev_property_set_phy },
 	{ }
 };
 
@@ -3017,6 +3227,12 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	state->connected = false;
 	device->general_connect = FALSE;
 
+	/* Reset PHYs if LE connection is disconnected */
+	if (bdaddr_type != BDADDR_BREDR) {
+		device->pending_phys = false;
+		device_set_phy(device, 0);
+	}
+
 	device_set_svc_refreshed(device, false);
 
 	if (device->disconn_timer > 0) {
@@ -5305,10 +5521,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	struct btd_gatt_database *database;
 	const bdaddr_t *dst;
 	char dstaddr[18];
+	uint32_t phys;
 
 	bt_io_get(io, &gerr, BT_IO_OPT_SEC_LEVEL, &sec_level,
 						BT_IO_OPT_IMTU, &mtu,
 						BT_IO_OPT_CID, &cid,
+						BT_IO_OPT_PHY, &phys,
 						BT_IO_OPT_INVALID);
 
 	if (gerr) {
@@ -5358,6 +5576,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	dev->attrib = attrib;
 	dev->att = g_attrib_get_att(attrib);
 
+	device_set_phy(dev, phys);
+
 	bt_att_ref(dev->att);
 
 	bt_att_set_debug(dev->att, BT_ATT_DEBUG, gatt_debug, NULL, NULL);
-- 
2.17.1

