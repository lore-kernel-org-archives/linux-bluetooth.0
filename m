Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9338C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A1C61244
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhGVFTB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:01 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:47922 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhGVFTA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:00 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722055935epoutp01936c2614460ae78fc4ce0730e3999872~UB3d7zqnp1854918549epoutp019
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722055935epoutp01936c2614460ae78fc4ce0730e3999872~UB3d7zqnp1854918549epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933575;
        bh=+10zOpJewNqhRy9kORWki5Ijl1Zb0ULOKm2TwsGLDds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKqTMeSzMsJbzYu0IQ03ru3tCGxECObqjMWG0Dns6PF5OjndDZ7Ko8V18gnCG+mwn
         oq1Ru54gk9+BfGpYug/80X8CxmUlFaxD+gemojOvl427QuQIfvvi5gD6UEHrda8KKb
         CMMwqzmjSTESyXhW4ZOLBtGOd7kgfp8VfeOz4Va0=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210722055934epcas5p3ca56e66230f501759022bed00fafccf8~UB3c8mdBN0717107171epcas5p3A;
        Thu, 22 Jul 2021 05:59:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.6A.09595.54909F06; Thu, 22 Jul 2021 14:59:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052741epcas5p2cb3cbad65a301b0ec0cf1780c0920103~UBbnw4ITq3201732017epcas5p2F;
        Thu, 22 Jul 2021 05:27:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722052741epsmtrp16bce4c6d74546d41fe923e1a9891d685~UBbnwGyhK2024420244epsmtrp1c;
        Thu, 22 Jul 2021 05:27:41 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-25-60f9094535cc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.91.08394.CC109F06; Thu, 22 Jul 2021 14:27:40 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052740epsmtip251830a0fa8c2109661a8174e713ef5ec~UBbnCUWL70837808378epsmtip2V;
        Thu, 22 Jul 2021 05:27:40 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 4/7] adapter: Add support for the get supported phy
 property
Date:   Thu, 22 Jul 2021 10:56:37 +0530
Message-Id: <20210722052640.5863-5-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmpq4r588Eg58XdS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MroOrCFseADV8X9tduYGxj/cHQxcnJI
        CJhIfDiwihnEFhLYzSjRcUami5ELyP7EKHFk4wQ2COcbo8Tpy7cZYTpm/17ABJHYyyhxb/5R
        driWaVM2g1WxCWhKvP74hQnEFhFQlni27zCYzSygK3Hm/To2EFtYIERiadtKdhCbRUBV4nt3
        I1gNr4CVxLr/7awQ2+QlVm84AHYfp4C1xIzeN8wgyyQEJrNL/J83E6rIRWLJ4oNQtrDEq+Nb
        2CFsKYmX/W3sEA3NjBI7Nm+EcnoYJR786GaDqLKXONf0DKibA+g8TYn1u/QhwrISU0+tg7qa
        T6L39xMmiDivxI55MLaKxIZVnXDLPh5byAxhe0gsXH2PCRKqfYwSyx8HTWCUm4WwYQEj4ypG
        ydSC4tz01GLTAqO81HK94sTc4tK8dL3k/NxNjOBo1vLawfjwwQe9Q4xMHIyHGCU4mJVEeFWK
        viYI8aYkVlalFuXHF5XmpBYfYpTmYFES52WPB0oJpCeWpGanphakFsFkmTg4pRqYNhxfdJ5f
        OmxV/MSXL9TL5sxatcfCwq9v/paJlW5r4pbPfvxNPzzS+JtwUs3D8GVFgvkCCb3h3xf+khZd
        tzT79Q27Nc96/PRVmm6W7qsxPHHf+/m07zGS8rIJx+Pvs1YU6fxREG6bf1r0XtfB1MDql44v
        Z034LCoQbmrMFmlQFuIrZiV4uIXV8NqpX6HRK07/j5X9HxCZbpF97P/t5MU60me/dRSx8lZt
        658THy/7J0+m3vpDR3rix/p7QjfuWsut4nM/Ff/tesHma3ksdVYZO8+JeXFeqmfZtbFM0/sX
        47lHJw7unaodUDhLqMYrd2/m5JM/Emt2GZU0ZF1U3tl+aHbqzz1r1LbWic5vtt+ixFKckWio
        xVxUnAgAacMFE1UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvO4Zxp8JBsf2WlncWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJXRdWALY8EHror7a7cxNzD+4ehi5OSQ
        EDCRmP17AVMXIxeHkMBuRomZtx8ydzFyACWkJB4v04GoEZZY+e85O4gtJPCBUeLcWU8Qm01A
        U+L1xy9MILaIgLLEs32HwWxmAX2JpxeuM4LYwgJBEucef2IBsVkEVCW+dzeC1fAKWEms+9/O
        CjFfXmL1hgPMIDangLXEjN43zBC7rCSWftnLNoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc
        4tK8dL3k/NxNjOBQ0dLcwbh91Qe9Q4xMHIyHGCU4mJVEeFWKviYI8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNS9rujpt8c/rv87xLfi+AemPS1sjzvP
        RXRWL+GV2rf86YJkwWZ2m1rd8/J7Wjm66nZq7vpWxFf1YZeIiXGqg9bm3+npXrv4MuvkZj9/
        +K+fX1tY+dn88x89+RtjjXpW2taUeHbsuty7cWeG+LavXyzP2PSs3BrqLzxb/UDgLRkOj8zN
        8R999ezSvydebkkKE1dRe9RwWFGmNnRloXK8087JG7e9ebT0dUnzznUh9hy3yxfuv2P25kjS
        yWdX15QfEpoid2qHzmnFTb9UJFfF8praBIksP2eVLvC7jdfL8cGfWyuCljzOin1ySG3J1Ke9
        55Mb+xNtTEImecZYhlqkfDLd0OnNrR3bH3lr2wGPP0osxRmJhlrMRcWJAIqsDqWEAgAA
X-CMS-MailID: 20210722052741epcas5p2cb3cbad65a301b0ec0cf1780c0920103
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052741epcas5p2cb3cbad65a301b0ec0cf1780c0920103
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052741epcas5p2cb3cbad65a301b0ec0cf1780c0920103@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change introduces a new adapter property which
will allow user to get the adapter supported PHYs.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 src/adapter.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index fd4c654dc..c64a5333d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3405,6 +3405,22 @@ failed:
 	return -EIO;
 }
 
+static gboolean property_get_supported_phy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	append_phys_str(&array, adapter->supported_phys);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static gboolean property_get_phy_configuration(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
@@ -3753,6 +3769,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Modalias", "s", property_get_modalias, NULL,
 					property_exists_modalias },
 	{ "Roles", "as", property_get_roles },
+	{ "SupportedPhyConfiguration", "as", property_get_supported_phy,
+					NULL},
 	{ "PhyConfiguration", "as", property_get_phy_configuration,
 					property_set_phy_configuration },
 	{ }
-- 
2.17.1

