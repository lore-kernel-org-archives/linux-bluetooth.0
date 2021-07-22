Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD4C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AD461279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGVFUX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19484 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVFUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:22 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722060057epoutp02a421aaf98fad0ef58c912b083e5fddae~UB4qZcEF01764317643epoutp02I
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722060057epoutp02a421aaf98fad0ef58c912b083e5fddae~UB4qZcEF01764317643epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933657;
        bh=pAi250CDFGbNfpdLR4WHLR17XIUus+005tpHnZhisVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsUcVVb3BemxLb0rLwoPVtGvBJSPXeZ47NIi/ZDcjRr+wFrIqjHiU5D56nqvwSOwD
         mnDciYjGAHLE/+YlPC3pedLgnngeiT9ktuVpTgz5PQGiCyXd2kSSKJC4L4Mev8XuCQ
         LUWLA/i4jyEvGIfbmZQmnk62AVzAx0SnLVDChWgM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210722060047epcas5p1aed4914c7362aebdc596b7b67e934f02~UB4hcv_T72576525765epcas5p1V;
        Thu, 22 Jul 2021 06:00:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.03.55882.D8909F06; Thu, 22 Jul 2021 15:00:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722055010epcas5p45a16ff704c37d108a9df0d6c0a1942a8~UBvQAq-iO2535725357epcas5p4G;
        Thu, 22 Jul 2021 05:50:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055010epsmtrp1ce7e23b831485f35ef28327a459700e3~UBvP-taDv3087030870epsmtrp1X;
        Thu, 22 Jul 2021 05:50:10 +0000 (GMT)
X-AuditID: b6c32a49-f65ff7000001da4a-b7-60f9098ddf3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.6B.08289.21709F06; Thu, 22 Jul 2021 14:50:10 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055009epsmtip1524cc0293ebfce1a1f9d8d23e70f0772~UBvPQey2n1099710997epsmtip1e;
        Thu, 22 Jul 2021 05:50:09 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 2/8] doc/mgmt-api: Add support for LE PHY Update
 Complete event
Date:   Thu, 22 Jul 2021 11:19:45 +0530
Message-Id: <20210722054951.8291-3-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmlm4v588Eg427WCzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mp4f3QDY8Eczor9nTfYGhjnsncxcnJI
        CJhIHJg6l6WLkYtDSGA3o8SRjgvsEM4nRomNDy5BZT4zSpz48JENpuVWy0eoql2MEs2f3rPB
        tXy8/ZsVpIpNQFPi9ccvTCC2iICyxLN9h8FsZgFdiTPv14FNEhYIl7j+cwKQzcHBIqAqMXFe
        GkiYV8BK4k/DKiaIZfISqzccYAaxOQWsJQ48ugm2WEJgMrvElhPTGUF6JQRcJB79hvpHWOLV
        8S1QtpTEy/42qPpmRokdmzdCOT2MEg9+dEO9Yy9xrukZK8ggZqCj1+/ShwjLSkw9tQ7qZj6J
        3t9PoA7ildgxD8ZWkdiwqhNu2cdjC5khbA+J1v1ToYHSxyhx8sYG5gmMcrMQVixgZFzFKJla
        UJybnlpsWmCYl1quV5yYW1yal66XnJ+7iREczVqeOxjvPvigd4iRiYPxEKMEB7OSCK9K0dcE
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzs8UApgfTEktTs1NSC1CKYLBMHp1QDk1vc3oP3nvwp
        KNZleS0/Z5XkUbuPkx5KJzwT83O0npm8aua7qd9juxxj9zxZefbcVc8n8WKRR4WZLukXnL64
        8d0UueKrFSXO56foSbMePdEndXrbwsk8rmJX9z29pLt5UlriozWJ1c5vLkdMyy1W2LBf7qxQ
        VcRfu4ldB626LV04N+mI+EVrBKXlvJjTvXrTzHXXFEP/+xotu75XOUrzRspVBlv1wCcxyzTu
        3VRyjTtxw+nT/X0/21tDd6YyPVpykqPp99uN/BkPjlu8fZYdwuuwwlOthXeG5xvpiRJMf86l
        zf/oVLPqusMRYZFtETO/ycyyPR/r6Jd2oTHgsseRl0GT7m5x/tIXe/Ze4G7Gog1KLMUZiYZa
        zEXFiQBpl59QVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSnK4Q+88Eg93HRSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mp4f3QDY8Eczor9nTfYGhjnsncxcnJI
        CJhI3Gr5CGRzcQgJ7GCU2PnkI3MXIwdQQkri8TIdiBphiZX/nkPVfGCUOH9nGhtIgk1AU+L1
        xy9MILaIgLLEs32HwWxmAX2JpxeuM4LYwgKhEp9nPGQCmckioCoxcV4aSJhXwEriT8MqJoj5
        8hKrNxxgBrE5BawlDjy6CXabEFDNvddbmCcw8i1gZFjFKJlaUJybnltsWGCUl1quV5yYW1ya
        l66XnJ+7iREcKlpaOxj3rPqgd4iRiYPxEKMEB7OSCK9K0dcEId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpi8CzUVf1dfj9I79VaP4YiP+iL1JLe3s3c8
        jv527M7S0MyZVefvSlTVRpvLmmRe0ZmZb5K+bGJMbsID5a3X9u88oPGTq74tzn91WMNPIeez
        pdPXRE/mibvz53y1qvbJ1JoJfWvuSi/h3y8gt3R1gmbpTvEfK2oPMWXLLTuzSaG34l94XvWF
        qWl7nap+zTuuoSUexZkpK/mUc41C6SuXpcd25N6wM7zSfzQqIMX8WDPv64w1S69m7+kSLdhR
        G2Ry/UfaUeG9Tzdw2Cx5sP/n5+/fXhz4J7I+fMeSef0OJy5O2XAg6H2Q9s/Hvx/KHSzUfKUv
        l3Pr78NnIh7bcye5ii069K5+t4OpuvjbjxLlBp1eSizFGYmGWsxFxYkABIjs1oQCAAA=
X-CMS-MailID: 20210722055010epcas5p45a16ff704c37d108a9df0d6c0a1942a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055010epcas5p45a16ff704c37d108a9df0d6c0a1942a8
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055010epcas5p45a16ff704c37d108a9df0d6c0a1942a8@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 doc/mgmt-api.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..f7379fcd9 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4910,3 +4910,32 @@ Controller Resume Event
 	Address_Type. Otherwise, Address and Address_Type will both be zero.
 
 	This event will be sent to all management sockets.
+
+
+LE PHY Update Complete Event
+===============================
+
+	Event Code:		0x002f
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Status (1 Octet)
+				PHYs (4 Octets)
+
+	This event indicates that LE PHYs have been changed for this
+	connected device.
+
+	The PHYs parameters are a bitmask with currently the
+	following available bits:
+
+		9	LE 1M TX
+		10	LE 1M RX
+		11	LE 2M TX
+		12	LE 2M RX
+		13	LE Coded TX
+		14	LE Coded RX
+
+	This event will be used in case of autonomous PHY update made
+	by the controller or HCI_LE_SET_PHY command succeeded.
+
+	This event will be sent to all management sockets.
-- 
2.17.1

