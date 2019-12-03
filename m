Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB5C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 09:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D9920661
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 09:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bENdHiuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLCJs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:48:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10974 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJs5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 04:48:57 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191203094853epoutp0424f56c38950e3a8221b80e2abc211a08~c04QHUjMB2038920389epoutp040
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191203094853epoutp0424f56c38950e3a8221b80e2abc211a08~c04QHUjMB2038920389epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575366533;
        bh=FwaqjaxnZ41q7KSt1yI9UikB0Kh1JM6AInZTKp6CZMM=;
        h=From:To:Subject:Date:References:From;
        b=bENdHiuQtRPUuHPwzj2itWCoJ5Sm8D7unOp9mC6BIJO3UG/lhDRySH01W0p1fI0vW
         77XNBKPauglB5l/SxsmJoFAfj4rVfUFBu+jkqosqJ5wQ3pqg6vdf4muSVb2Y6xD1/7
         fdk1gYbFzKkEJF6wdQWWsAUBvHL7IQ48QG6E52IU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191203094853epcas5p35d9cf9af6efb58dd06b91e349d9af8af~c04P7lycl1733717337epcas5p3f
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47RxyC3P74zMqYkX for
        <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.EC.19629.18F26ED5; Tue,  3 Dec 2019 18:48:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191203094848epcas5p296450885dea6e4939072c7b8b50e71fa~c04Lrz91_2569325693epcas5p2I
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191203094848epsmtrp1ba9e3e978840be11fde5a2c5c637443c~c04Lq8IpR1588015880epsmtrp1F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:48 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-9f-5de62f818f37
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.FB.10238.08F26ED5; Tue,  3 Dec 2019 18:48:48 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203094848epsmtip1458bff01c3631d5d3bcebdf707d02ef9~c04LVTyau0063900639epsmtip10
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 09:48:48 +0000 (GMT)
From:   Syam Sidhardhan <s.syam@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] client: Fix memory leak
Date:   Tue,  3 Dec 2019 15:18:42 +0530
Message-Id: <1575366522-7742-1-git-send-email-s.syam@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmhm6j/rNYg57n5hZzrvUxOzB6fN4k
        F8AYlWOTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZAzRU
        SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgaFSgV5yYW1yal66XnJ9rZWhgYGQK
        VJmQk3F+9S2Wgv0sFZ+bm1kbGM8zdzFyckgImEhMWPqDpYuRi0NIYDejxOSuRlYIZwaTRM+a
        U1DOHCaJJ3POMsK03D46mx0isZdR4tam41D965gkeg++ZAKpYhPQkth79Tw7iC0ioCzxbN9h
        sLiwgI5E79W7YHEWAVWJNX8egMV5BRwlbt59zwaxQU7i5rlOqANXsUocnxMCYbtIzLy1nQXC
        FpZ4dXwLO4QtJfGyvw3sIgmBZkaJznMHGCGcGYwS595OYYWospd4umkuUBUHB7OApsT6Xfog
        YWYBPone30+YQMISArwSHW1CENUKEqumTmSCsMUk1k3/ArXLQ+LlnSXgkBASiJXY8fsH2wRG
        6VkIQxcwMq5ilEwtKM5NTy02LTDOSy1HjpFNjOBUoeW9g3HTOZ9DjAIcjEo8vAf+PIkVYk0s
        K67MPcQowcGsJMK7TeJprBBvSmJlVWpRfnxRaU5q8SFGU2CgTWSWEk3OB6axvJJ4Q1MjMzMD
        SwNTYwszQyVx3kmsV2OEBNITS1KzU1MLUotg+pg4OKUaGNuM915oc36xxvjQ619zmS/sMZp7
        Mt73t2PgkbziPXe/J/6R7pSXecIn5ZK7/3s4d3+1g6aKqei3RSnzHr3LPrpBw8nhagbnveYd
        u652Jxslf5xcqtByLvpuuIPgy8CO5r05urbnazk2bku7F3U+pKg8rtD/buOSuIZMD5Etkraa
        04I+CaacUGIpzkg01GIuKk4EAKlkKhErAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJMWRmVeSWpSXmKPExsWy7bCSnG6D/rNYg+tvTC3mXOtjdmD0+LxJ
        LoAxissmJTUnsyy1SN8ugSvj/OpbLAX7WSo+NzezNjCeZ+5i5OSQEDCRuH10NnsXIxeHkMBu
        Rompf3rYIRJiEm9WnICyhSVW/nsOVbSGSeLTopVg3WwCWhJ7r54HKxIRUJZ4tu8wE4gtLKAj
        0Xv1LlicRUBVYs2fB2BxXgFHiZt337NBDJWTuHmuk3kCI/cCRoZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjBvtTS3MF4eUn8IUYBDkYlHt4Df57ECrEmlhVX5h5ilOBgVhLh3Sbx
        NFaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRuGXUzM6
        Ew/niV0utvlroWfOP6V5z4Ydj4MWiC53f/ws2+2U6q8dHdEHnkxYfV76ogvPYrnl3WzReaeZ
        n/840Gm2ceqlU8oNa3bd/83adsLjyDmDytIHS7dNmrzCbL54hWTayrW7Xn2dwry14WaG5Ud7
        98fiszZsPKq9i/fXo7dZnR86bWIkM5WVWIozEg21mIuKEwG7vtX34QEAAA==
X-CMS-MailID: 20191203094848epcas5p296450885dea6e4939072c7b8b50e71fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191203094848epcas5p296450885dea6e4939072c7b8b50e71fa
References: <CGME20191203094848epcas5p296450885dea6e4939072c7b8b50e71fa@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 client/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index 68dabda..8bd0bac 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1792,11 +1792,11 @@ static void remove_device(GDBusProxy *proxy)
 {
 	char *path;
 
-	path = g_strdup(g_dbus_proxy_get_path(proxy));
-
 	if (!default_ctrl)
 		return;
 
+	path = g_strdup(g_dbus_proxy_get_path(proxy));
+
 	if (g_dbus_proxy_method_call(default_ctrl->proxy, "RemoveDevice",
 						remove_device_setup,
 						remove_device_reply,
-- 
2.7.4

