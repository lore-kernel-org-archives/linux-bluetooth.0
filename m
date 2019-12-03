Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED07C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D758B206EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 09:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bM5DklZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLCJxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:53:46 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:13316 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJxq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 04:53:46 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191203095343epoutp0420ca0909bc8a74eb8c38d3bcfb63a82e~c08eC1VWU2407624076epoutp04R
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191203095343epoutp0420ca0909bc8a74eb8c38d3bcfb63a82e~c08eC1VWU2407624076epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575366823;
        bh=FNtu+rZmo3beJBFO4K5Dudvw/qZkcxb96EvgpeMiFhI=;
        h=From:To:Subject:Date:References:From;
        b=bM5DklZC5215seW9Wa7JZGxU/jgcJAxD142iZmMUtgG98pW6BtZdMIrgR47kS+lW/
         UNF8lOMvXWzjJMV5DBHIWLgJretqbhFEWHggaGhWUfI/dJQ2S+qLBxdpOY3V6Y3YGG
         aOMQw+Mcg8/QRU7pRsu4i7C6/XyqNyPVF9LIP0ls=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191203095342epcas5p197d8426768c5baab29aad51001fcc664~c08dYkWek1446714467epcas5p1l
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.194]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47Ry3n3JJxzMqYlm for
        <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.DD.19726.0A036ED5; Tue,  3 Dec 2019 18:53:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191203095335epcas5p2f42315a8d7d9a081afa929f96bb66356~c08WqPus-2116621166epcas5p21
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191203095335epsmtrp2d863ae45088c04be97fc44bcda8d2a06~c08WpsPnB2909929099epsmtrp2y
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:35 +0000 (GMT)
X-AuditID: b6c32a49-7a9ff70000014d0e-da-5de630a0f53c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.BD.06569.F9036ED5; Tue,  3 Dec 2019 18:53:35 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203095335epsmtip1b13908a499db78436b2d3c777047b809~c08WSMHgG0036000360epsmtip1x
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:53:35 +0000 (GMT)
From:   Nagaraj D R <nagaraj.dr@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] mesh: Fix invalid netkey index in appkey add/delete
Date:   Tue,  3 Dec 2019 15:23:27 +0530
Message-Id: <1575366807-7878-1-git-send-email-nagaraj.dr@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmpu4Cg2exBv1nmC3mXOtjdmD0+LxJ
        LoAxKscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2io
        kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KhArzgxt7g0L10vOT/XytDAwMgU
        qDIhJ2PD/TNsBTNZKx7MucDYwDifpYuRk0NCwETi6oX77F2MXBxCArsZJaacuATlzGCSuPrz
        AyOEM4dJovfcSTaYlnuLXzJBJPYySuxePZMZwlnHJLG7YynYYDYBLYnt13qZQGwRAWWJZ/sO
        g9nCAh4Sly68YwSxWQRUJWYtXApm8wq4SrTvWcsMsUFO4ua5TrChEgKrWCXurXvACJFwkTiw
        YhvUGcISr45vYYewpSQ+v9sLFe9mlJjeXwbRPIVRYt6pFiaIhL3E001zgRo4OJgFNCXW79IH
        CTML8En0/n7CBBKWEOCV6GgTgqhWkFg1dSJUp5jEuulfoFZ5SLS8ncMKYgsJxEq8XjeNdQKj
        9CyEoQsYGVcxSqYWFOempxabFhjmpZYjx8gmRnCq0PLcwTjrnM8hRgEORiUe3gN/nsQKsSaW
        FVfmHmKU4GBWEuHdJvE0Vog3JbGyKrUoP76oNCe1+BCjKTDQJjJLiSbnA9NYXkm8oamRmZmB
        pYGpsYWZoZI47yTWqzFCAumJJanZqakFqUUwfUwcnFINjE2NXvXnJBYUvuZ6vfe2yeFPvx/s
        U4l1ebx3v+C8ApZVl2Nl8o8VrnygseP+nHXTvaLc56gmhJTNldO+kc9/Mlam8FGpTMfxRr+V
        G82kNwiu4Oqftv6TiQ5bhJ/RzefPvyjOq5zpsb1G5b0C07E9085abJzH9VTJW537qVPBiwkx
        mz8GqrXH+CqxFGckGmoxFxUnAgDvKN2NKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJMWRmVeSWpSXmKPExsWy7bCSnO58g2exBi9Wy1vMudbH7MDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGhvtn2ApmslY8mHOBsYFxPksXIyeHhICJxL3FL5m6GLk4hAR2
        M0qcv3iTHSIhJvFmxQkoW1hi5b/n7BBFa5gknn14yQiSYBPQkth+rZcJxBYRUJZ4tu8wmC0s
        4CFx6cI7sBoWAVWJWQuXgtm8Aq4S7XvWMkMMlZO4ea6TeQIj9wJGhlWMkqkFxbnpucWGBUZ5
        qeV6xYm5xaV56XrJ+bmbGMG+1NLawXjiRPwhRgEORiUe3oxfT2KFWBPLiitzDzFKcDArifBu
        k3gaK8SbklhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoFRwZe3
        9Jz2VaVTU/Vfbvy5cu/Cc8prnP7Nfs67NqfXNmBb9oYQdx7Lq66bucWm6DO8mp7QLyP3gO3F
        lAeTgmaVhaTKFXvZ3Clpz++KtTq6wZRbq2/FgZYjsv4r1f8t95rElW7EwHJze0jZKc0tW6vn
        5RWf2uoQs22rjNzrwyc2nnnVq1Qia3xEiaU4I9FQi7moOBEAPxT7YeEBAAA=
X-CMS-MailID: 20191203095335epcas5p2f42315a8d7d9a081afa929f96bb66356
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191203095335epcas5p2f42315a8d7d9a081afa929f96bb66356
References: <CGME20191203095335epcas5p2f42315a8d7d9a081afa929f96bb66356@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

8 LSbs of netkey index should be packed into the first octet
---
 tools/mesh-gatt/config-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mesh-gatt/config-client.c b/tools/mesh-gatt/config-client.c
index 5e6374f..ed31c67 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -591,7 +591,7 @@ static void cmd_app_key(int argc, char *argv[], uint32_t opcode)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	msg[n++] = net_idx & 0xf;
+	msg[n++] = net_idx & 0xff;
 	msg[n++] = ((net_idx >> 8) & 0xf) |
 		((app_idx << 4) & 0xf0);
 	msg[n++] = app_idx >> 4;
-- 
2.7.4

