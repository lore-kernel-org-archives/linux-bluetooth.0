Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D2C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6446060FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGVFSu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:18:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43673 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhGVFSt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:18:49 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210722055923epoutp044cab1af8c2eafd042de7ce12bbc73c11~UB3TZ8BIS0449404494epoutp04d
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210722055923epoutp044cab1af8c2eafd042de7ce12bbc73c11~UB3TZ8BIS0449404494epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933563;
        bh=z8qo1DRvdeaa9Y6VJE/6/pYv3iElbhwzP1M8LlRop5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIIm7eNRR6rp3qEyQ77Mgy7Swf3rggpGcsVKFyfv18kqPwhnBJLxfwCsvLkHTps87
         Sy+ZgFcSb8H1QWtlTKuRwVXHVgSELokXsJSuMmJzyVAThrOBr6mvHXjIEQIuReRA6X
         aa2vlcqIxVlcxCwVTtiQBlwxct+/EglireEzVp8c=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722055923epcas5p2253770474b588230c66cb64c39aaac94~UB3S2YfBt0624106241epcas5p2E;
        Thu, 22 Jul 2021 05:59:23 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.CA.11627.A3909F06; Thu, 22 Jul 2021 14:59:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210722052738epcas5p3b6074e49f088159e8282bba3457d56ba~UBblEuFkt1662316623epcas5p3p;
        Thu, 22 Jul 2021 05:27:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722052738epsmtrp2f8c86706eabc85674b610cb46bc3f80f~UBblD0ur40040400404epsmtrp2e;
        Thu, 22 Jul 2021 05:27:38 +0000 (GMT)
X-AuditID: b6c32a4b-04849a8000022d6b-9b-60f9093add3d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.F8.08289.AC109F06; Thu, 22 Jul 2021 14:27:38 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052737epsmtip2a08f797289b9e422c437643e15a776ae~UBbkUBwF-0848408484epsmtip2K;
        Thu, 22 Jul 2021 05:27:37 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 1/7] doc/adapter-api: Add SupportedPhyConfiguration
 property
Date:   Thu, 22 Jul 2021 10:56:34 +0530
Message-Id: <20210722052640.5863-2-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCmlq4V588Eg45zZhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGUsWnWGveAYe8WrPVsZGxifsHYxcnJI
        CJhI/Djwk6WLkYtDSGA3o8TtSSsZIZxPjBIv7z5nhnA+M0q0nVrMDtOycNEuNojELkaJv6vu
        sMG1bFl4lhGkik1AU+L1xy9MILaIgLLEs32HwWxmAV2JM+/XsYHYwgIhEnvbpgNN5eBgEVCV
        uHLfASTMK2Al0T3tHSPEMnmJ1RsOMIPYnALWEjN634BdJCEwnV2i7eA6JogiF4kfx1uhGoQl
        Xh3fAnWplMTnd3vZIBqaGSV2bN7IDuH0MEo8+NHNBlFlL3Gu6RkryBXMQFev36UPEZaVmHpq
        HdTRfBK9v59ALeOV2DEPxlaR2LCqE27Zx2MLmUHGSAh4SKw+GQ8JlD5GiZaHZ5knMMrNQtiw
        gJFxFaNkakFxbnpqsWmBcV5quV5xYm5xaV66XnJ+7iZGcDRree9gfPTgg94hRiYOxkOMEhzM
        SiK8KkVfE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzsscDpQTSE0tSs1NTC1KLYLJMHJxSDUxh
        D3xfOoQfVGO+KvXirsapmtyrbhcfJfLfuiEU+FLkR3rT47UF2X9rneu7XsSUB+2Qy2IO9L6/
        d/6C8rbm91u5Ys7sinn5rCV8tU7Bs7i3lUUabVvO1ZWcMZz/WNbixzaDzlvuZ3uXVe1Uu7ry
        k9XDbZf7NV5x/OB8qBUZf2H5X+ZO66Sag/HNW6pvWtR3Pj7YfLU/2dx9/qOpmx5Knt9haPGl
        bWa4fm7z0i15S4yfrvuZZe9xfUL23rdBF8yt5yt/0zwZ9XtSW2BeEGvl1Xmmv3LyZzl+7Gf+
        HGiz9k1916JlXzappCpeaL/bkK6o8tD5u83XovucD5WnhiraJcke1q/5UPFJ4onA11U9pRpK
        LMUZiYZazEXFiQCPDLSWVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvO4pxp8JBsfPM1vcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJWxaNUZ9oJj7BWv9mxlbGB8wtrFyMkh
        IWAisXDRLrYuRi4OIYEdjBI3Wt+wdDFyACWkJB4v04GoEZZY+e85O0TNB0aJ94vbmEESbAKa
        Eq8/fmECsUUElCWe7TsMZjML6Es8vXCdEcQWFgiS2HTtGBvITBYBVYkr9x1AwrwCVhLd094x
        QsyXl1i94QDYSE4Ba4kZvW/AbCGgmqVf9rJNYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOFS0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFelaKvCUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwdc2ccvPkwrQDh60F3Zq3LlF9czBZy+Sf
        yEzbM1+XG3+Jmaabnp27nO/Q4b8L+y8xXGO8xMnkwhYbrRnyej7j/PrTbX4eKxSVwk9WyqXp
        mm6Q2+ldcvDztTM5zoVuou23jPgvbHjg550zaVuu2WkjTbd9gqUBHmrL13aGKGo1rSp6knxh
        o8Nck+XPp6x1P9+SvJzty5XVD9a9m58yReXflt4dz9Q8rmkJmrgxF3JePvlFRC2C18Rq5wHv
        LX/unYn/mywrxefh1BPx9e3Tfw+WlWz3aD1/dXXJx4C1Ond9JL8tLdoTeidx8+FMsXk5h4W3
        n2OZzz9DePvv7/pSSy3nLc9c99dHLXu9zeVzZ2x7JyqxFGckGmoxFxUnAgBD6RA7hAIAAA==
X-CMS-MailID: 20210722052738epcas5p3b6074e49f088159e8282bba3457d56ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052738epcas5p3b6074e49f088159e8282bba3457d56ba
References: <20210722052640.5863-1-ayush.garg@samsung.com>
        <CGME20210722052738epcas5p3b6074e49f088159e8282bba3457d56ba@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change add a new property to retrieve the PHYs
supported by the controller.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 doc/adapter-api.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 464434a81..25e370d75 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -335,3 +335,24 @@ Properties	string Address [readonly]
 				"peripheral": Supports the peripheral role.
 				"central-peripheral": Supports both roles
 						      concurrently.
+
+		array{string} SupportedPhyConfiguration [readonly]
+
+			List of PHYs supported by the controller.
+
+			Possible values:
+				"BR1M1SLOT"
+				"BR1M3SLOT"
+				"BR1M5SLOT"
+				"EDR2M1SLOT"
+				"EDR2M3SLOT"
+				"EDR2M5SLOT"
+				"EDR3M1SLOT"
+				"EDR3M3SLOT"
+				"EDR3M5SLOT"
+				"LE1MTX"
+				"LE1MRX"
+				"LE2MTX"
+				"LE2MRX"
+				"LECODEDTX"
+				"LECODEDRX"
-- 
2.17.1

