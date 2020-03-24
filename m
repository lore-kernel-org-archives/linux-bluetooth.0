Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA42C41621
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7D42074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d8Ic89sJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCXT23 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52312 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCXT23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:29 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200324192827epoutp0100d6cb15cb795ae1c521680c9ad24af1~-VCQLFNJy1218912189epoutp01s
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200324192827epoutp0100d6cb15cb795ae1c521680c9ad24af1~-VCQLFNJy1218912189epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078107;
        bh=6V3DiBBZBeWzfzJK31Y810gxS/vx0hVcyA0XAxI8BGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8Ic89sJ7u7EnFJnJpdwKTYdGWE/LU4e4QdPpx8S8oOmg2nbJF9A5XjOrEOoJkOoQ
         FYLtNDXKddQV6HdPcXSCakTGuGdAJST7JPB3o4oOtAfHeO+Tq8ciFDujoNRLf4uN3+
         J10yssXvVV6XS0ipL6vLgdiUt6qQfSvKHp2kYYVg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200324192826epcas5p306c58ece6d6182f69b9c7fea157266da~-VCPJ4tnk2547825478epcas5p3z;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.195]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48n1WF1vy2zMqYkV; Tue, 24 Mar
        2020 19:28:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.62.04782.95F5A7E5; Wed, 25 Mar 2020 04:28:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192824epcas5p1de37a38491d79ea6dca2cc5da50cd289~-VCNjWNK51650916509epcas5p19;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324192824epsmtrp20b3d326379f3287705e3d06a5bd10fdf~-VCNirDub2919629196epsmtrp2k;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-66-5e7a5f593e3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.F8.04024.85F5A7E5; Wed, 25 Mar 2020 04:28:24 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192824epsmtip15c7a3ab37e4d9f57aae1faa4536eb926~-VCM7Hu741049610496epsmtip1I;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle netkey delete when netkey is not in
 netkeylist
Date:   Wed, 25 Mar 2020 00:57:21 +0530
Message-Id: <1585078044-14974-7-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmpm5kfFWcwZ65XBZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJPxcuor1oLJ7BWfP15mbmB8xtrFyMkhIWAi8XPKXTYQW0hg
        N6PExO1VXYxcQPYnRokl6y6zQzjfGCVOfdvHDtPxveMyG0RiL6PEyrObWCHaO5gk/i2KBbHZ
        BIwlzt98xQRiiwgoSzzbdxjMZhawlzjy4zsLiC0sECTx6XYbmM0ioCox83MnM4jNK+AhcWrB
        WSaIZXISN89BxDkFPCXWXjnGCLJYQuApq8Sij1+gilwkdt3bywZhC0u8Or4F6lIpic/vYOLd
        jBK737hCNE9hlLj3AuQiDiDHXmLCC34Qk1lAU2L9Ln2IO/kken8/garglehoE4KYoiCxaupE
        qK1iEuumf4Ha5CEx/d1tVkiYzGGUmDP5GPMERtlZCFMXMDKuYpRMLSjOTU8tNi0wzEstR46n
        TYzgpKPluYNx1jmfQ4wCHIxKPLwNjyvjhFgTy4orcw8xSnAwK4nwbk6tiBPiTUmsrEotyo8v
        Ks1JLT7EaAoMwInMUqLJ+cCEmFcSb2hqZGZmYGlgamxhZqgkzjuJ9WqMkEB6YklqdmpqQWoR
        TB8TB6dUA6PWnx9+zFcFTj3/WH/WbfFE5UYL0QJenUK/CRvfJjWZLb17LELfTrbS84JsI7uf
        xUbn0KTTOk0vNq/beVzq0PEFC6tET+xlll/I/bsh32CW3TPBG7ODfvi6aMpmO61dt4SV9VId
        ++emjzFM1Q5Rnn6O9QfvzD978VRzxJ+dP5JqUztnNIvMdFBiKc5INNRiLipOBABqzNL2UAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTjcivirO4OJJbYs51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKeDn1FWvBZPaKzx8vMzcwPmPtYuTk
        kBAwkfjecZmti5GLQ0hgN6PE/d3z2CESYhJvVpyAsoUlVv57DmYLCbQxSZze6gpiswkYS5y/
        +YoJxBYRUJZ4tu8wmM0s4Cjx6co8NhBbWCBAYtavBmYQm0VAVWLm504wm1fAQ+LUgrNMEPPl
        JG6eg4hzCnhKrL1yjBFil4fEn86ZbBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAgOFy3NHYyXl8QfYhTgYFTi4dV6WBknxJpYVlyZe4hRgoNZSYR3c2pFnBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHep3nHIoUE0hNLUrNTUwtSi2CyTBycUg2M1gsK3y1SdXDuZXqil6Yp
        fMPw8VmF+KBV2b3a7iZd3+8V7HEP1N9/5Mff0zVyJXHMldUVYmVnt9px2kV/SJ48u/qqWtyP
        RtZ8FefN+Xamx6fMKua5U+YStFOztdpTguWHdB/TmUMtEowzL+ROvbT8uHic17JXmxefOi5h
        aHWO6+75/u9v+p8osRRnJBpqMRcVJwIA6h02QBMCAAA=
X-CMS-MailID: 20200324192824epcas5p1de37a38491d79ea6dca2cc5da50cd289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192824epcas5p1de37a38491d79ea6dca2cc5da50cd289
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192824epcas5p1de37a38491d79ea6dca2cc5da50cd289@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

4.4.1.2.9 of Mesh Profile Bluetooth specification:
When an element receives a Config NetKey Delete message that
identifies a NetKey that is not in the NetKey List, it
responds with Success, because the result of deleting the
key that does not exist in the NetKey List will be the same
as if the key was deleted from the NetKey List.
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index ec05b6be9..3546b87d0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -941,7 +941,7 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
 	if (!subnet)
-		return MESH_STATUS_CANNOT_REMOVE;
+		return MESH_STATUS_SUCCESS;
 
 	/* Delete associated app keys */
 	appkey_delete_bound_keys(net, idx);
-- 
2.17.1

