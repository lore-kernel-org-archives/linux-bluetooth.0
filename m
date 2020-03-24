Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B263C41621
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140572074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TVvH5Snk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCXT2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55767 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgCXT2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:34 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200324192832epoutp0270b11d726fe2db6daf42a2deb9a20415~-VCVEUdTJ3092430924epoutp028
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200324192832epoutp0270b11d726fe2db6daf42a2deb9a20415~-VCVEUdTJ3092430924epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078112;
        bh=VdQuGu7XaW8EZNEchKAVVlQEXh7waXd50ClipSR/8qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVvH5SnkZLtpKhNQGge6XId7g8lVHblSJQwRP/kNzjqhQ+tvCHi9iJYuI4ktc/P9R
         0CCS5iHIMT96fOXesYgU4LGk5ICPN25getcOS7rwggxW1vkqZDaDtCyBAVBoF4Gpqe
         4T8C+ofFmdNYWtX9ebPDuS7WyPWsa6r4O56GJdbg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200324192830epcas5p30412d36e4fc6c14e667343915e752533~-VCSjj36y0624506245epcas5p3N;
        Tue, 24 Mar 2020 19:28:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48n1WJ6XxfzMqYkV; Tue, 24 Mar
        2020 19:28:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.62.04782.B5F5A7E5; Wed, 25 Mar 2020 04:28:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200324192825epcas5p4c038b652414de6be433f224a655a2244~-VCOVZlp_2103621036epcas5p4O;
        Tue, 24 Mar 2020 19:28:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324192825epsmtrp2bafce09e8e4a6d68d4876dcdf981c254~-VCOUzg9J0076200762epsmtrp2B;
        Tue, 24 Mar 2020 19:28:25 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-6a-5e7a5f5bb781
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.2A.04158.95F5A7E5; Wed, 25 Mar 2020 04:28:25 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192824epsmtip1b9acac45f88cf6b3036399bec39e1a08~-VCNo2xqd0279802798epsmtip1S;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Initialize local_acked to zero
Date:   Wed, 25 Mar 2020 00:57:22 +0530
Message-Id: <1585078044-14974-8-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmhm50fFWcwd2DphZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJPx8Pla9oIjrBWzz9xlbWA8wtLFyMkhIWAi0bv4BFMXIxeH
        kMBuRomDWx6zQDifGCUuHN7JDuF8Y5RYtH0RI0zL/Rlr2SASexkldvw7zASSEBLoYJLYvD8I
        xGYTMJY4f/MVWFxEQFni2T6IGmYBe4kjP76D7RYWsJR4ubiHDcRmEVCVOL/6JpjNK+AhceJ1
        BxPEMjmJm+c6mUFsTgFPibVXjkEd8ZRV4umcCgjbRWLRrT+sELawxKvjW9ghbCmJz+/2skHY
        3YwSu9+4ghwtITCFUeLeC5CDOIAce4kJL/hBTGYBTYn1u/QhzuST6P39BKqCV6KjTQhiioLE
        qqkToS4Tk1g3/QvUJg+Jg9+OQENxDqPEtO1rmScwys5CmLqAkXEVo2RqQXFuemqxaYFhXmo5
        cjxtYgQnHS3PHYyzzvkcYhTgYFTi4W14XBknxJpYVlyZe4hRgoNZSYR3c2pFnBBvSmJlVWpR
        fnxRaU5q8SFGU2D4TWSWEk3OBybEvJJ4Q1MjMzMDSwNTYwszQyVx3kmsV2OEBNITS1KzU1ML
        Uotg+pg4OKUaGIWdS34u+OrLOWV11eNZb4xXqaQYmeX/Wjrh0jPfWXe2zXBt5rI4ezaSzZeH
        z1t72+NIp/1vk8WelsoqdLnPflD8MjGA1Xj3k7DcFP8FqvdV/A4uYarh8J3at6Ln6iynj0+v
        O52v9p24dPbFbTP3eCyeIxq8nLFcTP55hFmHy7RzMoWmDy4edFRiKc5INNRiLipOBACsxQsb
        UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTjcyvirO4NRiWYs51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKePh8LXvBEdaK2WfusjYwHmHpYuTk
        kBAwkbg/Yy1bFyMXh5DAbkaJpfeWQyXEJN6sOMEOYQtLrPz3nB2iqI1JYu+1zWBFbALGEudv
        vmICsUUElCWe7TsMZjMLOEp8ujKPDcQWFrCUeLm4B8xmEVCVOL/6JpjNK+AhceJ1BxPEAjmJ
        m+c6mUFsTgFPibVXjjGC2EJANX86Z7JNYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOGC0tHYwnjgRf4hRgINRiYdX42FlnBBrYllxZe4hRgkOZiUR3s2pFXFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGNufMLmxhhrkmvsvl7dy
        vOq9VHSF9XSN190/MqYIayyOkJzH6lTzoEPg0ly23W0xi06kstUzMvyR3ve5muecee0ujgKj
        mx2fTp1Te/jjVW3pqW97vzElic18eMY4Pr6VUzJDpnJF20H3bUf8c9jb5xlG211LlF5bpiYX
        zys3dVdO/sTTDPyeSizFGYmGWsxFxYkAg07okBQCAAA=
X-CMS-MailID: 20200324192825epcas5p4c038b652414de6be433f224a655a2244
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192825epcas5p4c038b652414de6be433f224a655a2244
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192825epcas5p4c038b652414de6be433f224a655a2244@epcas5p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Initialized local_acked to zero to send received acknowledge
to acceptor.
---
 mesh/pb-adv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 6ef45b8b0..f7aad0041 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -375,7 +375,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		first = !session->link_id;
 		session->link_id = link_id;
 		session->last_peer_trans_num = 0xFF;
-		session->local_acked = 0xFF;
+		session->local_acked = 0x00;
 		session->peer_trans_num = 0x00;
 		session->local_trans_num = 0x7F;
 		session->opened = true;
-- 
2.17.1

