Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4AC43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFA221823
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BlXEaFAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFEN1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:13:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:41771 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfLFEN1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 23:13:27 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191206041324epoutp02c9e8533dbbc00848d731f36ead16f678~drPMB5IZ82130421304epoutp02R
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191206041324epoutp02c9e8533dbbc00848d731f36ead16f678~drPMB5IZ82130421304epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575605604;
        bh=4POB7SNhGDgpP+lM1S9nS5ET704qVBu6AQrj9wRuY08=;
        h=From:To:Subject:Date:References:From;
        b=BlXEaFAlTyrSYcRt1sAnw/aC5ISQGYLAHwhywFRUJwB/yR/2Tpg3T9NtFFTLGqVVr
         f6VMqF6sOv5cHGRtb62C6l1o1DuocjpweDXeP37+i2+aONOzEFNqppot/HdKMfR7rU
         y4GizSSHhiuYGX7MRrbfEo5e9EbhOqg4kRNY1BRE=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20191206041324epcas5p27e733a45361e287ff55c616cad9356b6~drPLy7W-71718017180epcas5p2o
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.16.19726.365D9ED5; Fri,  6 Dec 2019 13:13:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191206041323epcas5p35d6b7b22e50698d10af05d669001fd5a~drPLZd0j80563105631epcas5p3Y
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206041323epsmtrp291d7486faf8d6260ea310439b5761d2f~drPLY7XBg1552315523epsmtrp2C
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:23 +0000 (GMT)
X-AuditID: b6c32a49-7c1ff70000014d0e-fd-5de9d5638dc0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.F3.10238.365D9ED5; Fri,  6 Dec 2019 13:13:23 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206041323epsmtip219c7b4aaf461444cd1ce5e03486fca68~drPLDl4qt0716207162epsmtip2e
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:13:23 +0000 (GMT)
From:   Anurag Biradar <biradar.a@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] meshctl: Fix infinite sock read
Date:   Fri,  6 Dec 2019 09:43:04 +0530
Message-Id: <1575605584-734-1-git-send-email-biradar.a@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCmum7K1ZexBjOWMVnMudbH7MDo8XmT
        XABjFJdNSmpOZllqkb5dAldGc993loLXbBVzHi5lb2BcxNrFyMkhIWAi0XZyG1MXIxeHkMBu
        Rom/N/YzQzgzmCQW7OhnhHDmMEk0HP0P5HCAtVzYHwkR38so0X1/JwuEs45JYsKnyUwgc9kE
        dCR+bT3KDGKLCChLPNt3GCwuDNR8Y+IcFhCbRUBVou/nQbA7eAWcJX5s2MwCcZOcxM1znWBn
        SAisY5X49PAd1LEuEnM2PYSyhSVeHd/CDmFLSXx+t5cNwq6XWPX0EzOE3cEo8bXRF8K2l3i6
        aS47yAfMApoS63fpg4SZBfgken8/YYJ4jFeio00IolpBYtXUiUwQtpjEuulfoDZ5SDz+dZER
        xBYSiJV4smQL2wRG6VkIQxcwMq5ilEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAiOMS3P
        HYyzzvkcYhTgYFTi4Z3x+UWsEGtiWXFl7iFGCQ5mJRHedL6XsUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5J7FejRESSE8sSc1OTS1ILYLJMnFwSjUw6jzIsena+zJkU0vE9e1Or11nbHayz1SO
        eyFoWP7twpL/1Wm/jy6aN6WoPKFv3qcfd0PvHZ218mGcdf2pd24eRVtYdJtm6C7YoLpTQajD
        sPSJwIkFkamzbcIMdp2dUiysKHa+6Iv8URW+nzNbfVZkTbjbrmzS1jj/4YWZK6XfzJJi/qwu
        GrCoUomlOCPRUIu5qDgRAFN78XitAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJMWRmVeSWpSXmKPExsWy7bCSvG7y1ZexBkteqVrMudbH7MDo8XmT
        XABjFJdNSmpOZllqkb5dAldGc993loLXbBVzHi5lb2BcxNrFyMEhIWAicWF/ZBcjF4eQwG5G
        ibO/f7B1MXICxcUk3qw4wQ5hC0us/PecHaJoDZPExA+tTCAJNgEdiV9bjzKD2CICyhLP9h0G
        iwsDDb0xcQ4LiM0ioCrR9/MgK4jNK+As8WPDZhaIoXISN891Mk9g5F7AyLCKUTK1oDg3PbfY
        sMAwL7Vcrzgxt7g0L10vOT93EyPYk1qaOxgvL4k/xCjAwajEwzvj84tYIdbEsuLK3EOMEhzM
        SiK86XwvY4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg
        dAsp5e7u3WImeX+hs2To1DzNeftsk2ZVl6wt3cP+0pjjcxK72iaOxZ53JYQmndqyd9L82Lfl
        DwySZMyOZt7mYu9Zd+yl+YzYec8z/kl2Ll78T6ertO3ig6rWyMb8h50tfnt+XbkU5X5R9+nk
        jUohJ9QOSO2t4shq7P7zVYIlzkd50STX6QuqlViKMxINtZiLihMBVSiHLOABAAA=
X-CMS-MailID: 20191206041323epcas5p35d6b7b22e50698d10af05d669001fd5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191206041323epcas5p35d6b7b22e50698d10af05d669001fd5a
References: <CGME20191206041323epcas5p35d6b7b22e50698d10af05d669001fd5a@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a stream socket peer has performed an orderly shutdown,
then return value will be 0.
---
 tools/mesh-gatt/gatt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
index bff5947..1bd9868 100644
--- a/tools/mesh-gatt/gatt.c
+++ b/tools/mesh-gatt/gatt.c
@@ -416,7 +416,7 @@ static bool sock_read(struct io *io, bool prov, void *user_data)
 	msg.msg_iovlen = 1;
 
 	while ((len = recvmsg(fd, &msg, MSG_DONTWAIT))) {
-		if (len <= 0) {
+		if (len < 0) {
 			if (errno == EAGAIN)
 				break;
 			return false;
@@ -431,6 +431,11 @@ static bool sock_read(struct io *io, bool prov, void *user_data)
 				net_data_ready(res, len_sar);
 		}
 	}
+
+	/* When socket is orderly closed, then recvmsg returns 0 */
+	if (len == 0)
+		return false;
+
 	return true;
 }
 
-- 
2.7.4

