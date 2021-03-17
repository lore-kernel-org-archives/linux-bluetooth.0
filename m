Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4691C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C80264F69
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCQL0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 07:26:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17278 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCQLZu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 07:25:50 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210317112548epoutp04fdeb5492238e2c2a963f8c47b56fa1f5~tHZCs4Q8e1026210262epoutp04b
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Mar 2021 11:25:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210317112548epoutp04fdeb5492238e2c2a963f8c47b56fa1f5~tHZCs4Q8e1026210262epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615980348;
        bh=dERvD/td+9LRYhYQE1Qiwd2zsUrqwzv21v1SnNUArfY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=I4FxlLkrZIQsowl60yPKuKPbLMjihqvbw+MeMieFQsd8j1X5qMJZMRzjEfIXTYV6e
         rPK/rw9af4INfAtQauRvISpHjme4V9OSNBxrMDvAdx9nvKYGc1Pf+Es+EE6NozjhxA
         k1Qui8lRvMrBg82MUEkFB+8GGFgyVDZ3ua2u+fNE=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210317112547epcas5p3b26e19ec0cf5302a1041d9f5cda97865~tHZBqabWx2635326353epcas5p3P;
        Wed, 17 Mar 2021 11:25:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.20.15682.B37E1506; Wed, 17 Mar 2021 20:25:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210317112220epcas5p40e3a942da73f819d20679cf03710860c~tHWAxtkD_2895728957epcas5p4E;
        Wed, 17 Mar 2021 11:22:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210317112220epsmtrp12a5dc3248f7d3f2040be7c23149b4eb3~tHWAw_o7U3274132741epsmtrp1m;
        Wed, 17 Mar 2021 11:22:20 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-2f-6051e73b99e4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.0B.13470.C66E1506; Wed, 17 Mar 2021 20:22:20 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210317112219epsmtip2e917934a34efeff95a68957e12d94777~tHV-_BdVf2161621616epsmtip2m;
        Wed, 17 Mar 2021 11:22:19 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH] Bluetooth: Fix incorrect status handling in LE PHY UPDATE
 event
Date:   Wed, 17 Mar 2021 16:52:14 +0530
Message-Id: <20210317112214.12622-1-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmlq7188AEg4YbAhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGWs3XiLuWAma8Wd8/eZGhhXsHQxcnBI
        CJhIrFyo38XIxSEksJtR4syrOewQzidGiW/f+9kgnG+MEh1v/7LCdNx8wAcR38so8eHXW6BJ
        nBAdb34IgdhsApoSrz9+YQKxRQSUJZ7tOwxmMwvoSpx5v44NxBYWCJJYeuAZO8hMFgFVif23
        zUDCvALWEnMvTGIFsSUE5CVWbzjADLJLQuA3m8T2c6uYIRIuElMOr2OBsIUlXh3fwg5hS0m8
        7G9jh2hoZpTYsXkjlNPDKPHgRzcbRJW9xLmmZ2DfMANdun6XPkRYVmLqqXVQh/JJ9P5+wgQR
        55XYMQ/GVpHYsKoTbtnHYwuhDvKQODrtFBMkIGIl7q1cxDKBUXYWwoYFjIyrGCVTC4pz01OL
        TQsM81LL9YoTc4tL89L1kvNzNzGC41XLcwfj3Qcf9A4xMnEwHmKU4GBWEuE1zQtIEOJNSays
        Si3Kjy8qzUktPsQozcGiJM67w+BBvJBAemJJanZqakFqEUyWiYNTqoEptYft3pn5v5/ZRH06
        9ZaLM5PhQlTptaclXovi2H1XeBctK/x7bbtOWr27+mLvn5XObKzBy5PN2ro4Vqsu5DK6knLD
        SDHK4HGHesHP/POiGl9lO/TFzh+9qdBktjhZ9pry7tduW6zVfBRUOcQFb2euszeLiW271KnW
        8Tvp+dwKBgUXIZ45axsDl1RF6gW8OP/vxcYrO1P+3dvUoWrKavfzwcrpPoI2O2r/etWs4Aj7
        oeXccyyrdt3epKJ6yz0rim+z2TOYNRUJBCm/b+iwO8ZVoLBcw6yZ2aF0yZvQnh+Cdqe8NH71
        Oa85cEhvj/GpW0KlZ86klD0um/FPbs9Uey+fiMmPuC9N2ry/TGJmuBJLcUaioRZzUXEiAIyZ
        5gVGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJMWRmVeSWpSXmKPExsWy7bCSvG7Os8AEg+ajHBZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGWs3XiLuWAma8Wd8/eZGhhXsHQxcnBI
        CJhI3HzA18XIxSEksJtRovvPH1aIuJTE42U6XYycQKawxMp/z9khaj4wSlz7/pIdJMEmoCnx
        +uMXJhBbREBZ4tm+w2A2s4C+xNML1xlBbGGBAImrfXuYQWayCKhK7L9tBhLmFbCWmHthEivE
        fHmJ1RsOME9g5FnAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyPY81qaOxi3r/qg
        d4iRiYPxEKMEB7OSCK9pXkCCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
        C1KLYLJMHJxSDUwnHt3ZqD3hvP6b839zV5TYHZ2ZvpeX7Xf0UyYnngVXTk0291Nxd5yhqbLV
        6rD8yQP3PzddMt+psVQj9VfkjX9JYiIfZqr73953M3KtWol4ubXaJt1pf1Z5PW91uRY+c4pq
        eXhYyvX6WY5Veo53V4ZUrus/Vflqg3ONrebc1bHWT3lv87f36T+cwHnocvTey0nxbvzsdhcL
        TT9bfmMz2sOwIGVlx8ef+5aFffGZO31Dq/Ua1/iDz8//3MqxdB7rnIo3vXyzD796cbz2m9iC
        Re4LfS0v2OnPWVHoXeo9i1sncxnz93l/JTWM1+yUTm6+Fs58IePvxLtpfls7RHa0Cx288tZf
        i2vzG92ZxtO0olV7lFiKMxINtZiLihMBClnV0GsCAAA=
X-CMS-MailID: 20210317112220epcas5p40e3a942da73f819d20679cf03710860c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210317112220epcas5p40e3a942da73f819d20679cf03710860c
References: <CGME20210317112220epcas5p40e3a942da73f819d20679cf03710860c@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Skip updation of tx and rx PHYs values, when PHY Update
event's status is not successful.

Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f4a734f8a9ac..cf2f4a0abdbd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5938,7 +5938,7 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	if (!ev->status)
+	if (ev->status)
 		return;
 
 	hci_dev_lock(hdev);
-- 
2.17.1

