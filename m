Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89652C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BAF60FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhGVFSx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:18:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17554 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhGVFSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:18:52 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722055926epoutp024251ba0666935f185e150e73b5fa8ba9~UB3WT0dKZ1391413914epoutp02C
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722055926epoutp024251ba0666935f185e150e73b5fa8ba9~UB3WT0dKZ1391413914epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933567;
        bh=Ku/hEMoSqpFJ2TAHVmgIJESpqg6Bhi5eAy2IC3xCa1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejs2XbQOSjE3nmOOnkk69i253Po6uIPrXXlG4GLhN9AnK+1h9x34XQbahBWaTksdZ
         lFiR68JFkpH/IipKO4YYIQ7NWFwxG/lagFAGuUV9DUpsHv3+HspdSe9Jkhv+C3773m
         CbUUmeFwD/YDQi4fZ+4yOxXiTNG/slY7tkE8YHCo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055926epcas5p4c238feec53c177d5bc8d6fb89258882a~UB3WAuiN32438924389epcas5p4c;
        Thu, 22 Jul 2021 05:59:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.72.55882.E3909F06; Thu, 22 Jul 2021 14:59:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722052739epcas5p4412d38b394f51ab195c77c887f0a0aaf~UBbmB86bY2447724477epcas5p46;
        Thu, 22 Jul 2021 05:27:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052739epsmtrp287b826e05c2c798175234d12796d584f~UBbl-kJAb0040400404epsmtrp2j;
        Thu, 22 Jul 2021 05:27:39 +0000 (GMT)
X-AuditID: b6c32a49-f4fff7000001da4a-54-60f9093e854f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.F8.08289.AC109F06; Thu, 22 Jul 2021 14:27:39 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052738epsmtip2efdea6c9199f0f6fc4db7e5134eb1350~UBblOVKN20837908379epsmtip2l;
        Thu, 22 Jul 2021 05:27:38 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 2/7] doc/adapter-api: Add PhyConfiguration property
Date:   Thu, 22 Jul 2021 10:56:35 +0530
Message-Id: <20210722052640.5863-3-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmpq4d588Eg+cvBS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mp4MuMic8Ep9or2R7eYGhj/s3YxcnJI
        CJhInPh5gKmLkYtDSGA3o8T0348YIZxPjBLPP/ayQjifGSWOtU5ngWnpm7YNzBYS2MUoMXur
        N4QN1HF+ggKIzSagKfH64xcmEFtEQFni2b7DYDazgK7Emffr2EBsYQFPiWf3ZgJt4+BgEVCV
        WPWqDMTkFbCSaO8vg9gkL7F6wwFmEJtTwFpiRu8bZpBzJAQms0tMf7uVDaLIReJvbx8jhC0s
        8er4FnYIW0ri87u9bBANzYwSOzZvZIdwehglHvzohuq2lzjX9IwVZDMz0NHrd+lDhGUlpp5a
        B3Uzn0Tv7ydMEHFeiR3zYGwViQ2rOuGWfTy2kBnC9pA49L8HGnB9wFCcsIJtAqPcLIQVCxgZ
        VzFKphYU56anFpsWGOallusVJ+YWl+al6yXn525iBEeylucOxrsPPugdYmTiYDzEKMHBrCTC
        q1L0NUGINyWxsiq1KD++qDQntfgQozQHi5I4L3s8UEogPbEkNTs1tSC1CCbLxMEp1cCUN2fb
        9sOXpDOf/XLcfCVg53ur5JqNfFcCXPablcjVp7k1dT9VrN3hP/2QXdF5Boeo2zK8d1YVqv3O
        Y52vbb3P/4u89vOaexrtN9UOur648v9c+7niogRxEa/iuXOWLN0l65K3OLvTMLn56sb7O80Z
        Y9+wnzSPmjNPYvvZv+t72NYc05x4NYyvyexu59WUSl42C52ZAl2617Ze/dkTXFKZ/fGnlPYf
        xVlvJItebNzHHxnPNXXWIj7r7if2/9/Z8LpnJJzJ8/D72d2TrcX/oeOwpm68vt3czAO2iYsD
        RbY+lJdl27CjeXaM0Q0jhoJ1p6Oa2P/xzjqlFX2hRfKNum0u4yzlX921ATdfV3/qUlJiKc5I
        NNRiLipOBABntbTxUwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsWy7bCSvO5pxp8JBv1HGC3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mp4MuMic8Ep9or2R7eYGhj/s3YxcnJI
        CJhI9E3bxgJiCwnsYJRYfECki5EDKC4l8XiZDkSJsMTKf8/Zuxi5gEo+MEo87n8F1ssmoCnx
        +uMXJhBbREBZ4tm+w2A2s4C+xNML1xlBbGEBT4ln92YygsxkEVCVWPWqDMTkFbCSaO8vgxgv
        L7F6wwFmEJtTwFpiRu8bZohrrCSWftnLNoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjOAw0dLawbhn1Qe9Q4xMHIyHGCU4mJVEeFWKviYI8aYkVlalFuXHF5XmpBYfYpTm
        YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwJTp4dvrFqy67Fxk15W473skQ65tYF3Oto9R
        cu3VCy1cjpWtdW/+avCdWlnEsfKLSAxnTHlGrpEG+zRb5Qkxq6//4so8v911nktZ682iDS1L
        C+O2flvHemft71n3Tqtc/3nw2fVDF8r2Lt9id75haav7CaOkWrnaaQefu+y5NG/xpzMeex45
        HGyruZVSK/YgzWWHWNKuNq8JPpf0LJ8uuWDxijFO/9/z/X9mHbZdlnTOLWiOSnHkS6Hz01yM
        Jm0K5Z6vs6xx2SvBm67+3J0F7Xw+l3OTj8q3Fkj4fLknpijglx8+4cJ3h/Wml63FVpuuVQna
        pbjyDccTrRm6pbz82RvUjGSzT63fGfKBc9O/zSxKLMUZiYZazEXFiQCpOuSyggIAAA==
X-CMS-MailID: 20210722052739epcas5p4412d38b394f51ab195c77c887f0a0aaf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052739epcas5p4412d38b394f51ab195c77c887f0a0aaf
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052739epcas5p4412d38b394f51ab195c77c887f0a0aaf@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change add a new property which will allow the user
to get the controller's current selected PHYs and to
change it at any point of time.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 doc/adapter-api.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 25e370d75..97af8e70b 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -356,3 +356,17 @@ Properties	string Address [readonly]
 				"LE2MRX"
 				"LECODEDTX"
 				"LECODEDRX"
+
+		array{string} PhyConfiguration [readwrite]
+
+			Set/Get the default PHYs to the controller.
+
+			These PHYs will be used for all the
+			subsequent scanning and connection initiation.
+
+			The value of this property is persistent. After
+			restart or unplugging of the adapter it will continue
+			with the last set PHYs.
+
+			Refer SupportedPhyConfiguration property
+			for the possible values.
-- 
2.17.1

