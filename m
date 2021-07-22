Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC8EC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934F660FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVFTN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48114 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhGVFTK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:10 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722055945epoutp01b00239ee135cc4af52ffc545d7e0f947~UB3nh4-BL1720917209epoutp01O
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722055945epoutp01b00239ee135cc4af52ffc545d7e0f947~UB3nh4-BL1720917209epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933585;
        bh=yvLhXLJo1gC7HS333Qbuv5u1JDJYWuVzLFpYxe56V20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZllkImtjMLq+H0gzLJr9bDIfTzDZMxwg4DUUYTStDi3hHSpVnVPtOWbAiXNES7fP
         uiTg+UE8UFZFIraYVStJKRkDA4EyPsdFMIHHEqUd1s5mUEkqL3zwNA772TR3EGJ4A3
         t4HmxMNU3mZVfJumwqGk0/Ij6l8CuxaxA2Uw1Muo=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055944epcas5p40b71697b2264707675b2ddb5c57585b7~UB3m_q-6m1890418904epcas5p4d;
        Thu, 22 Jul 2021 05:59:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.DA.11627.05909F06; Thu, 22 Jul 2021 14:59:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722052744epcas5p46996d48d12500c39b4b63dfcecd30d37~UBbqkvSTs2470224702epcas5p46;
        Thu, 22 Jul 2021 05:27:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052744epsmtrp2ea4a84d369d2fd698dcbba2fde7cb175~UBbqj1DrS0094500945epsmtrp2I;
        Thu, 22 Jul 2021 05:27:44 +0000 (GMT)
X-AuditID: b6c32a4b-acdff70000022d6b-e0-60f90950e30c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.F8.08289.FC109F06; Thu, 22 Jul 2021 14:27:43 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052743epsmtip2ea20deabdf9a767dfa56b4d092af9aaa~UBbpwbzwe0848408484epsmtip2N;
        Thu, 22 Jul 2021 05:27:43 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 7/7] adapter: Save PHY Configuration in storage and
 read it at init
Date:   Thu, 22 Jul 2021 10:56:40 +0530
Message-Id: <20210722052640.5863-8-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCmpm4A588Eg+Pd4hZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGU8uDGLpaBXsuLR7jksDYyfRLoYOTkk
        BEwkPpz8wNzFyMUhJLCbUeJT6y82COcTo8TuWdcYIZzPjBJTd2xjh2lZerkBqmoXo8S8E2eY
        4Vp+XZ0OVsUmoCnx+uMXJhBbREBZ4tm+w2A2s4CuxJn369hAbGGBaIm70z6xgtgsAqoSp7qn
        g8V5Bawk7vdsgdomL7F6wwFmEJtTwFpiRu8bsGUSApPZJXau2ccKUeQicX/lX2YIW1ji1XGY
        ZimJz+/2skE0NDNK7Ni8kR3C6WGUePCjmw2iyl7iXNMzoEkcQOdpSqzfpQ8RlpWYemod1NV8
        Er2/nzBBxHkldsyDsVUkNqzqhFv28dhCqCM8JBqvbmSBBEsfo8S2v3uYJzDKzUJYsYCRcRWj
        ZGpBcW56arFpgXFearlecWJucWleul5yfu4mRnBEa3nvYHz04IPeIUYmDsZDjBIczEoivCpF
        XxOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ87LHA6UE0hNLUrNTUwtSi2CyTBycUg1MrJMlTrlO
        r+JrVd7Tnd0Wyc4WdXfhxpt/Cj5fDZ0lp83atez9BtH1DiLeF549O5JWcfR00f+9zt9ebl5+
        Rf/bscz8sgsHuEI7p2i+E/pY8mC1447y4kwGR/U1/cIORl9FOeZr3n0uI2770zqkjXl1ULRy
        y3QVi4YnywV2Gm4sCow78/d0a5f31gvHD5w1LZZlv69ccSg1vuNp18cZ/up7lj1j+ch2W0VM
        xPIWm+FzUZEJDvYnF9xJff7/6IGz1+PPfe7qkHEOO3rUX15b7dlNg576qkc79nHKdjsZSCTv
        8/80b+qPUxqKeX8ji94wqJayX7c6/yLxe4Jlxz/nGV/ZAldd6jz4ucA/Nfzf5Ef3lViKMxIN
        tZiLihMBcr7O5FcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSvO55xp8JBieemlvcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJXx4MYsloJeyYpHu+ewNDB+Euli5OSQ
        EDCRWHq5ga2LkYtDSGAHo8TzXdeAHA6ghJTE42U6EDXCEiv/PWeHqPnAKLH41X5mkASbgKbE
        649fmEBsEQFliWf7DoPZzAL6Ek8vXGcEsYUFIiVmznoFVs8ioCpxqns6G4jNK2Alcb9nCzvE
        AnmJ1RsOgNVwClhLzOh9A2YLAdUs/bKXbQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMHBoqW1g3HPqg96hxiZOBgPMUpwMCuJ8KoUfU0Q4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqganI++kRQ5mlPowh6yao7klgV/Q7FPJw5aLJ
        M9T75fae8tV97nNV9O29vg9e2ncFpt+77pZ+5XeT45cd/Gr7je+wLrdzyLv2Y0FfkR2PcpM8
        55EjL8x+Kt194Cgft+vqx//qT240z94fGGIpwfxpUeHdmnt3ar/5ljjUN1y6x8KfueSeYnbh
        rsRfCa5r5Kf6/axbnLrl64ONIjd4frC6FibbGHaJnLf+M/H6+0e9AnFXHvF929lcGdso5DXl
        aol22u6sLRPWvd4X1vKgiTfq+aE7bkpz+yVf3OraVP9TMGz1dC6fszf/uy7zeDJZa/vCWOcf
        KpLPK3fG5/989+vo9s4kY2lf6w+FXWlGx3yWxCorsRRnJBpqMRcVJwIASwF8soUCAAA=
X-CMS-MailID: 20210722052744epcas5p46996d48d12500c39b4b63dfcecd30d37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052744epcas5p46996d48d12500c39b4b63dfcecd30d37
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052744epcas5p46996d48d12500c39b4b63dfcecd30d37@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will save the current selected PHY configuration
in the storage when PHY Configuration Changed Event is
received. It will also load and set the stored PHY configuration
when controller initialized. Thus it enables the user to continue
with the last selected PHYs on controller restart.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 src/adapter.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 84dd2e5bd..3861ade8a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -288,7 +288,8 @@ struct btd_adapter {
 
 	uint32_t supported_phys;
 	uint32_t configurable_phys;
-	uint32_t selected_phys;
+	uint32_t selected_phys;		/* Current selected PHYs */
+	uint32_t stored_phys;		/* Stored last selected PHYs */
 	uint32_t pending_phys;
 };
 
@@ -508,6 +509,10 @@ static void store_adapter_info(struct btd_adapter *adapter)
 		g_key_file_set_string(key_file, "General", "Alias",
 							adapter->stored_alias);
 
+	if (adapter->stored_phys)
+		g_key_file_set_integer(key_file, "General", "PhyConfiguration",
+					adapter->stored_phys);
+
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings",
 					btd_adapter_get_storage_dir(adapter));
 
@@ -3329,10 +3334,13 @@ static void set_default_phy_complete(uint8_t status, uint16_t length,
 	btd_info(adapter->dev_id, "PHY configuration successfully set");
 
 	adapter->selected_phys = adapter->pending_phys;
+	adapter->stored_phys = adapter->pending_phys;
 	adapter->pending_phys = 0;
 
 	g_dbus_pending_property_success(data->id);
 
+	store_adapter_info(adapter);
+
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "PhyConfiguration");
 }
@@ -6548,6 +6556,15 @@ static void load_config(struct btd_adapter *adapter)
 		gerr = NULL;
 	}
 
+	/* Get PHY Configuration */
+	adapter->stored_phys = g_key_file_get_integer(key_file,
+				"General", "PhyConfiguration", &gerr);
+	if (gerr) {
+		adapter->stored_phys = 0;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+
 	g_key_file_free(key_file);
 }
 
@@ -9670,6 +9687,13 @@ static void read_phy_configuration_resp(uint8_t status, uint16_t length,
 	DBG("Supported phys: [0x%x]", adapter->supported_phys);
 	DBG("Configurable phys: [0x%x]", adapter->configurable_phys);
 	DBG("Selected phys: [0x%x]", adapter->selected_phys);
+
+	/*
+	 * Set the default PHYs to the last selected PHYs on which the
+	 * controller was operating before shutting down.
+	 */
+	if (adapter->supported_settings & MGMT_SETTING_PHY_CONFIGURATION)
+		set_default_phy(adapter, adapter->stored_phys, -1);
 }
 
 static void read_phy_configuration(struct btd_adapter *adapter)
@@ -9696,10 +9720,14 @@ static void phy_configuration_changed_callback(uint16_t index,
 	}
 
 	adapter->selected_phys = get_le32(&ev->selected_phys);
+	adapter->stored_phys = adapter->selected_phys;
+
 	info("PHYs changed, New PHYs [0x%x]", adapter->selected_phys);
 
 	adapter->pending_phys = 0;
 
+	store_adapter_info(adapter);
+
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "PhyConfiguration");
 }
-- 
2.17.1

