Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A1AC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676BD6127C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGVFUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41591 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVFUU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:20 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210722060054epoutp03ff929ccb8b5bbf768136c69b6257430c~UB4oA60cf0824508245epoutp03B
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210722060054epoutp03ff929ccb8b5bbf768136c69b6257430c~UB4oA60cf0824508245epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933654;
        bh=VhAUX2KaLhcD0nEsXOQiKQD6baHytHOBPwc2nY0Hr9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm4HjPXOh2qmpZz3KoQG6mA6tdeFKbiZrxEDiNdQLmcj1m918MLmDCN0ixlskeo2l
         mMeLONooD480bSV3xTRNdcV4XDETiJB2qg3TtKVXbIiULanEVg8bzylJvxhczfg/lI
         dHD7+QZSzyGuj/ptkleMx9lvDrZGVMU7k6s6tDVQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210722060050epcas5p190ce885f3ed971de687fde4dc3ce24c6~UB4jxa9aa2840328403epcas5p1a;
        Thu, 22 Jul 2021 06:00:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.0B.09595.F8909F06; Thu, 22 Jul 2021 15:00:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210722055009epcas5p25e4997aa7e53cb2a6e3780fdb7301785~UBvPGCgsX1311413114epcas5p2g;
        Thu, 22 Jul 2021 05:50:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722055009epsmtrp136c979ae9ef2327e87a48a66370ac37f~UBvPFQRT03119631196epsmtrp1e;
        Thu, 22 Jul 2021 05:50:09 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-8b-60f9098fd051
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.6B.08289.11709F06; Thu, 22 Jul 2021 14:50:09 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055008epsmtip16e6be481b399800959be0f4b7b4eb380~UBvOWkjlC1099710997epsmtip1d;
        Thu, 22 Jul 2021 05:50:08 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 1/8] doc/device-api: Add Phy property
Date:   Thu, 22 Jul 2021 11:19:44 +0530
Message-Id: <20210722054951.8291-2-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmhu4Ezp8JBu3TmSzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MrovrmereAwR8X6A4eYGxi3sXUxcnJI
        CJhI3Fv+kL2LkYtDSGA3o8SJFTfZIJxPjBI7191jhnA+M0r0/G5kh2l5MfkYM4gtJLCLUeL1
        ekO4jiWd/WAJNgFNidcfvzCB2CICyhLP9h0Gs5kFdCXOvF8HtltYwFpi/qc9YDaLgKrEiunL
        WUBsXgEriZ3XTzJCLJOXWL3hANhMTqD6A49ugt0qITCdXWL/mZVQRS4S7zatZ4GwhSVeHd8C
        damUxMv+NqiGZkaJHZs3Qjk9jBIPfnRDg8Be4lzTM9YuRg6g8zQl1u/ShwjLSkw9tQ7qaj6J
        3t9PmCDivBI75sHYKhIbVnXCLft4bCEzhO0h0XHrEjQg+xglFu3bxzyBUW4WwooFjIyrGCVT
        C4pz01OLTQuM8lLL9YoTc4tL89L1kvNzNzGC41nLawfjwwcf9A4xMnEwHmKU4GBWEuFVKfqa
        IMSbklhZlVqUH19UmpNafIhRmoNFSZyXPR4oJZCeWJKanZpakFoEk2Xi4JRqYNrZmcivvWGl
        GWOrzqFfF9i+sH2rF8k16wlv4ojyuHcqMt/8hqWM6jtPvqAPGm8+PtUsn3fg6hYjsb6dPnOm
        8Vn6zcvefGy3tMrGJRLregR4jebZTHSQ948VD/z/bhXPi0OOGzfNcdltzRUTyHTytU9t0+eE
        wvM/L9x2bz3WIPBC3bLqm8vftb1ONtG/VDwVzvFsvOPbNFF66cRKmW/lKTIT5CTbr0w58TAw
        MMHmXHh+2v1fyyPuVsjPdb1g4Pi4zMVug8CBx1yZLy7YT8naIpD48RijsJa0d+79JXWX7Se8
        +nfms8nksCLXD8ltqewbmDKV2x/p3Z/QYTYj24bPo20zx+kj/FNFXpR8NfrrpsRSnJFoqMVc
        VJwIAMVwWORWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEJMWRmVeSWpSXmKPExsWy7bCSnK4g+88Eg2XXRC3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MrovrmereAwR8X6A4eYGxi3sXUxcnJI
        CJhIvJh8jLmLkYtDSGAHo8TZPxOZuhg5gBJSEo+X6UDUCEus/PecHaLmA6PE9PsPWUASbAKa
        Eq8/fmECsUUElCWe7TsMZjML6Es8vXCdEcQWFrCWmP9pD9gyFgFViRXTl4P18gpYSey8fpIR
        YoG8xOoNB5hBbE6g+gOPbrKD2EJANfdeb2GewMi3gJFhFaNkakFxbnpusWGBUV5quV5xYm5x
        aV66XnJ+7iZGcLBoae1g3LPqg94hRiYOxkOMEhzMSiK8KkVfE4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgOv4nOe3f5ddhbO3qs+d78r1kWLT23YwN
        GVHHL/37WDxv989U5guBdz+fmjnb7qVR7Fb/twcOpK+6E/TI+muAfqrZnumaP58eYf7NselB
        wWuP5/0OoWf+19g2iPoISps1WTj/S86QqDycueqzrLGyNP+/DzvW8vAEFN7K1Lfkn87v8W2n
        TktJ3P9E3xr9XQ3lr19u2HDnzJ8psVJ5lsrenIoxF5PXhRr8j9r96ZWsp/BGNw1VhWk8zhZV
        b2NXbP3/6fv7SyHvFk6b8idq8mIDv8TSNf8W/8jcf7uO17BgpuCRm0Uv+dcLxfTuM5x1NXrp
        17y1nx2u6Ai2ikxjWP04YYq/Qt6/q7W7fv6rXPflZpQSS3FGoqEWc1FxIgBcm/0ehQIAAA==
X-CMS-MailID: 20210722055009epcas5p25e4997aa7e53cb2a6e3780fdb7301785
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055009epcas5p25e4997aa7e53cb2a6e3780fdb7301785
References: <20210722054951.8291-1-ayush.garg@samsung.com>
        <CGME20210722055009epcas5p25e4997aa7e53cb2a6e3780fdb7301785@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This will allow to set the LE PHY preferences for
a connected device.

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
---
 doc/device-api.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4e824d2de..d0e108f74 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -272,3 +272,25 @@ Properties	string Address [readonly]
 			Example:
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
+
+		array{string} Phy [readwrite, optional]
+
+			PHY Preferences for a connected device.
+
+			Note: The controller might not be able to make the
+			change because of reasons like peer not supporting
+			the requested PHY or it couldnot schedule due to
+			other activites.
+
+			This is only available for LE capable controllers.
+			It will return Not Supported Otherwise.
+
+			Possible values:
+				"LE1MTX"
+				"LE1MRX"
+				"LE2MTX"
+				"LE2MRX"
+				"LECODEDTX"
+				"LECODEDRX"
+				"LECODEDS2"
+				"LECODEDS8"
-- 
2.17.1

