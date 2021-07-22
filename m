Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1439AC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE17961283
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhGVFUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:40 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41977 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhGVFUi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:38 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210722060110epoutp0314506dee29e79bcb56a87f8b8c5613fe~UB42v7wcZ1006110061epoutp03y
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210722060110epoutp0314506dee29e79bcb56a87f8b8c5613fe~UB42v7wcZ1006110061epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933670;
        bh=vZJ5YsLRm+TaNStqvt11eEi1/zcqwQc1xxbOq52U9+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfheJMdME89Eg3BOe0CYwXue2BgqpxcICjGcr1gV4AWsQxtsO0v6WrnvTajWlS6YZ
         U2MSfmm+U7YLUM/jNKQLUA9erI6kfU1x3GcRHSoms3yz2ughTlBv8IMODVh94BvRwP
         102E9Vs0r5zqxToAFh8aJ0mvNWQeSwadPiCqfbLY=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722060108epcas5p207518e1eb91d02a89dedfee61ccf463c~UB40eoSgS0861908619epcas5p2l;
        Thu, 22 Jul 2021 06:01:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.1B.09595.2A909F06; Thu, 22 Jul 2021 15:01:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210722055016epcas5p267b70f0da3b5c1991d29ca47d685ab6d~UBvVeUvLe0519705197epcas5p2c;
        Thu, 22 Jul 2021 05:50:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055016epsmtrp1d68eb3d80bba2ae437539030db7fe39b~UBvVdAcGv3119631196epsmtrp11;
        Thu, 22 Jul 2021 05:50:16 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-de-60f909a2980e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.7B.08289.81709F06; Thu, 22 Jul 2021 14:50:16 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055015epsmtip1de5ecd70dbb90deed93f8dcfe63ee946~UBvUlmjzS1278412784epsmtip1B;
        Thu, 22 Jul 2021 05:50:15 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 7/8] device: Save device PHY in storage and read it at
 init
Date:   Thu, 22 Jul 2021 11:19:50 +0530
Message-Id: <20210722054951.8291-8-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmlu4izp8JBp0XLS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mq4cPgna8Fxvoo7jXuZGxjvcHcxcnJI
        CJhIPH59m7GLkYtDSGA3o8Sy98dYIZxPjBJLu6ayg1QJCXxmlJj+wLeLkQOsY+9iNoiaXYwS
        O1asYodreLB5PgtIA5uApsTrj1+YQGwRAWWJZ/sOg9nMAroSZ96vYwOxhQWCJU7+ncIIYrMI
        qEps+3ECLM4rYCXR0PGRFeI8eYnVGw4wg9icAtYSBx7dBFsmITCZXeLJ2t9MEEUuEg2XGxgh
        bGGJV8e3sEPYUhIv+9ugGpqBTt28EcrpATr1RzcbRJW9xLmmZ6wgvzEDnb1+lz5EWFZi6ql1
        UFfzSfT+fgK1jFdixzwYW0Viw6pOuGUfjy1khrA9JNobrkDDsY9R4tGnbpYJjHKzEFYsYGRc
        xSiZWlCcm55abFpglJdarlecmFtcmpeul5yfu4kRHM1aXjsYHz74oHeIkYmD8RCjBAezkgiv
        StHXBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK87PFAKYH0xJLU7NTUgtQimCwTB6dUA9Nm2YzQ
        ph3nOgOTl8oE5XrGd8z/3rNr/uq3PDyLzItfGx+fnNj6P+6w5dvPDpXcsodUUxTOH9r+Z0v+
        m8UCM1TvvVp6XJbR2uBxMMeMovq8/XuW98vuL9fOeJn5ILpew51x3s79G8/6nb+TkZptHv1l
        x29GE7bo/8HM049nvTJXt5I06nE3zeKSWG0avtP/9R+Ryz3PDG5rvm/tDvsVciLUsudY2fpo
        q5fVTa8vxa5stSqOTxZt+qN8SehK28vyNIdcmbtPJi6bHujGmb/4Z7ie+MPVsxjD568//yGy
        WVi++6D9+lk3mjYwzU2OXeHG55Xs2rs4RjvCJqGpe/exQofTV91MHvb0qr2zCO3ep8RSnJFo
        qMVcVJwIACc7Z7dVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnK4E+88Egx9XuS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mq4cPgna8Fxvoo7jXuZGxjvcHcxcnBI
        CJhI7F3M1sXIxSEksINRYtnDD2wQcSmJx8t0uhg5gUxhiZX/nrND1HxglNi35TUTSIJNQFPi
        9ccvYLaIgLLEs32HwWxmAX2JpxeuM4LYwgKBEpvXHQGLswioSmz7cYINxOYVsJJo6PjICrFA
        XmL1hgPMIDangLXEgUc32UFsIaCae6+3ME9g5FvAyLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
        L10vOT93EyM4VLS0djDuWfVB7xAjEwfjIUYJDmYlEV6Voq8JQrwpiZVVqUX58UWlOanFhxil
        OViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTApBk00evzk91MbW77vx3YZblr4c+aGgKOH
        ts5e4u321b9jpeFV7sIlEkuO3zo9o//PFZXUMyfkraTZHh0J/R2y5vSHHzZ1DYZ2B65Jyc+y
        2xHmaLniznGzbNn6/QE7b0+65rXK2dvpSo3QhCkWpm0vNVxeLOQUSvu59EqDS7JK8LP6tSwz
        9+urKn7q3vKnI9GfOS+xY90x/axzh07us35SXXt68pvVx89nvPqSc9hCJeppdltfatKFJxHS
        xzzqorK4+8++iDK7b3H8kcal12lM9+r+/WpmvxiuyLhy8bGbS+4cF/L+7vpqIedhhgUuPQVn
        bvFGfeJa+1zQQufE6qiXZ/j4pi6Nj+qZe7jm/CzZ50osxRmJhlrMRcWJAILGE/CEAgAA
X-CMS-MailID: 20210722055016epcas5p267b70f0da3b5c1991d29ca47d685ab6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055016epcas5p267b70f0da3b5c1991d29ca47d685ab6d
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055016epcas5p267b70f0da3b5c1991d29ca47d685ab6d@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will save the current LE connection PHY in
the storage when LE PHY Updated Event is received.
It will also load and set the last stored LE PHY when
that device is re-connected.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 src/device.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/device.c b/src/device.c
index 4b11772b8..b708fc822 100644
--- a/src/device.c
+++ b/src/device.c
@@ -275,6 +275,7 @@ struct btd_device {
 
 	uint32_t phys;
 	bool pending_phys;
+	uint32_t stored_phys;
 };
 
 static const uint16_t uuid_list[] = {
@@ -448,6 +449,12 @@ static gboolean store_device_info_cb(gpointer user_data)
 		g_key_file_remove_key(key_file, "General", "Services", NULL);
 	}
 
+	if (device->stored_phys)
+		g_key_file_set_integer(key_file, "General", "Phy",
+					device->stored_phys);
+	else
+		g_key_file_remove_key(key_file, "General", "Phy", NULL);
+
 	if (device->vendor_src) {
 		g_key_file_set_integer(key_file, "DeviceID", "Source",
 					device->vendor_src);
@@ -3576,6 +3583,14 @@ next:
 		gerr = NULL;
 	}
 
+	/* Get PHY */
+	device->stored_phys = g_key_file_get_integer(key_file,
+					"General", "Phy", &gerr);
+	if (gerr) {
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+
 	if (store_needed)
 		store_device_info(device);
 }
@@ -5578,6 +5593,9 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 
 	device_set_phy(dev, phys);
 
+	if (dev->stored_phys)
+		set_preferred_phy(dev, dev->stored_phys);
+
 	bt_att_ref(dev->att);
 
 	bt_att_set_debug(dev->att, BT_ATT_DEBUG, gatt_debug, NULL, NULL);
@@ -5688,6 +5706,9 @@ void device_le_phy_updated(struct btd_device *dev, uint32_t phy)
 {
 	dev->pending_phys = false;
 
+	dev->stored_phys = phy;
+	store_device_info(dev);
+
 	device_set_phy(dev, phy);
 }
 
-- 
2.17.1

