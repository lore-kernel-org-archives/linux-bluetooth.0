Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7DC43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FF21823
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tztqojv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLFENo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:13:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33158 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFENo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 23:13:44 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191206041342epoutp011d4300293429926a5c42c74626738a14~drPcrrw0w0868608686epoutp01L
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191206041342epoutp011d4300293429926a5c42c74626738a14~drPcrrw0w0868608686epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575605622;
        bh=C6RbCANrVyu7+PE5XLgUqnxru+qYsykm7/iVeYaD3LA=;
        h=From:To:Subject:Date:References:From;
        b=Tztqojv6Dn+qEruRFe/3eJS2yG9QDcsbDkUZUQM4ZfbbApc/jzicRpsg0qjtYXemA
         gLiMh6xZA+Y+ivYj1HR+G08ne2BKkf7kP7z0Qk7SvfxHXsbo6fk/UFb7v3Q37zIGzH
         ByHtCOY2IFI3cFFC/Y4f6kffPgBq+Bsuq+A/LEZw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191206041341epcas5p4503cf16decf9f96543ea96ddbda62927~drPcFwAgw1160711607epcas5p4v
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:41 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.C9.20197.575D9ED5; Fri,  6 Dec 2019 13:13:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd~drPbtGD6o1602916029epcas5p4P
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206041341epsmtrp2a13e0b3871f37304def23cecb7c06f2e~drPbsgmqM1552315523epsmtrp2I
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:41 +0000 (GMT)
X-AuditID: b6c32a4a-769ff70000014ee5-37-5de9d575ec88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.04.10238.575D9ED5; Fri,  6 Dec 2019 13:13:41 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206041340epsmtip201bedbd10c9e9f918988bd2ccf226e12~drPbVJwVN1240712407epsmtip2d
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:40 +0000 (GMT)
From:   Anurag Biradar <biradar.a@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] meshctl: Fix meshctl crash
Date:   Fri,  6 Dec 2019 09:43:36 +0530
Message-Id: <1575605616-787-1-git-send-email-biradar.a@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCmum7p1ZexBnePKFvMudbH7MDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGz/8L2AvWsVV0fNjG3sC4mrWLkZNDQsBEYuahxSxdjFwcQgK7
        GSXuvt7FDOHMYJJ4O2MqlDOHSeJy41m4llNdl9ghEnsZJT6f+gtVtY5Jom3/JEaQKjYBHYlf
        W48yg9giAsoSz/YdZgKxhQX0JaZc6QWyOThYBFQl/r62AAnzCjhLHJy4mh1igZzEzXOdYDMl
        BFaxSvyduYcNIuEisfbuMhYIW1ji1fEtUA1SEp/f7YWqqZdY9fQTM4TdwSjxtdEXwraXeLpp
        LjvIXmYBTYn1u/RBwswCfBK9v5+AnSMhwCvR0SYEUa0gsWrqRCYIW0xi3fQvUJs8JDr7D4LZ
        QgKxEu+7VrBMYJSehTB0ASPjKkbJ1ILi3PTUYtMCo7zUcr3ixNzi0rx0veT83E2M4BjT8trB
        uOyczyFGAQ5GJR7eGZ9fxAqxJpYVV+YeYpTgYFYS4U3nexkrxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnHcS69UYIYH0xJLU7NTUgtQimCwTB6dUA6PymfWXl17+mSV45OxVO7aFOSf0Ne85ux1Y
        8VFt7tqjSv/Pv4ljkj7GP6csk7G0JlP/5IwHF2JvXvCbsKV7DS+r+x2D3zqTH8/z87jBfPVL
        bPPK3/mf2r5eqE4Mq+di3fF8gWqNktt7DXk7iXVyu577cFa/9Nfrnr8r48+m6nU7PoiuyV0d
        a/BNiaU4I9FQi7moOBEALrcLFq0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJMWRmVeSWpSXmKPExsWy7bCSvG7p1ZexBsfvsFrMudbH7MDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGz/8L2AvWsVV0fNjG3sC4mrWLkZNDQsBE4lTXJfYuRi4OIYHd
        jBLXXh1ggUiISbxZcYIdwhaWWPnvOVTRGiaJzV++gnWzCehI/Np6lBnEFhFQlni27zATiC0s
        oC8x5UovkM3BwSKgKvH3tQVImFfAWeLgxNVQM+Ukbp7rZJ7AyL2AkWEVo2RqQXFuem6xYYFh
        Xmq5XnFibnFpXrpecn7uJkawJ7U0dzBeXhJ/iFGAg1GJh3fG5xexQqyJZcWVuYcYJTiYlUR4
        0/lexgrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAyJQg
        tjp6ZbjPpn91nbtnfo1wnu36rzmicX7MT6UPeZqrG31uz3PN+/viWqneA8vMn/9Tvxz7dEpK
        L5R94bWI92Evvidd6utiOV11KaWd58LvNHPt8zp83vmpWsleO0vv97Oozlu/c/OF/XIvdX9x
        PHroNN3WTENOMGfis99Nfq4zasuWur6+q8RSnJFoqMVcVJwIAGuoDyXgAQAA
X-CMS-MailID: 20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd
References: <CGME20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd@epcas5p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

list entry was not updated properly during flushing of packets

<call stack>
flush_pkt_list (list=0x638b40 <net+64>) at tools/mesh-gatt/net.c:1199
net_session_close (data_in=<optimized out>) at tools/mesh-gatt/net.c:1979
disconnect_device (cb=cb@entry=0x0, user_data=user_data@entry=0x0)
  at tools/meshctl.c:791
cmd_start_prov (argc=<optimized out>, argv=0x6a9fb0)
  at tools/meshctl.c:1789
---
 tools/mesh-gatt/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mesh-gatt/net.c b/tools/mesh-gatt/net.c
index e8171c6..d74e1f5 100644
--- a/tools/mesh-gatt/net.c
+++ b/tools/mesh-gatt/net.c
@@ -1197,6 +1197,7 @@ static void flush_pkt_list(GList **list)
 		pkt = l->data;
 		*list = g_list_remove(*list, pkt);
 		g_free(pkt);
+		l = g_list_first(*list);
 	}
 }
 
-- 
2.7.4

