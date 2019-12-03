Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D61C432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD20A206EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GjHqvu1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCKBl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:01:41 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17377 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCKBl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 05:01:41 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191203100139epoutp04e41854b249b77f105f835a8253e38ecf~c1DZOD9YT3236332363epoutp04a
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2019 10:01:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191203100139epoutp04e41854b249b77f105f835a8253e38ecf~c1DZOD9YT3236332363epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575367299;
        bh=VpRDOnnyPw8xjH+aWUELDBPfn1y0ORb0TWNExi0efLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjHqvu1cseIa9/TarooI/abp17j7uyP8E2/OLM7pvK4Z++nhKaoLgLSl335gNYad7
         F+UxlfP0wczT5jkYJ8W1E7tpzjnYS8fCvsziZOFrimO3U1tcVQnfGF14kCUQGSp5HK
         wFG4g71dBkQloJLe1gIH0cZlrLYrG3BAhseTlmng=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191203100138epcas5p3ac41f57b887cf5dacc3311469b295520~c1DYti9002969329693epcas5p3o;
        Tue,  3 Dec 2019 10:01:38 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.192]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47RyDx2hJ2zMqYkY; Tue,  3 Dec
        2019 10:01:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.FF.19726.E7236ED5; Tue,  3 Dec 2019 19:01:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20191203100134epcas5p4855ab386bd90877c85114b970a252223~c1DUoR8Rt1308013080epcas5p41;
        Tue,  3 Dec 2019 10:01:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191203100134epsmtrp2561c881db438a0cf57e0895e94165b46~c1DUnuVZf0127701277epsmtrp2r;
        Tue,  3 Dec 2019 10:01:34 +0000 (GMT)
X-AuditID: b6c32a49-7a9ff70000014d0e-6f-5de6327e307b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.5E.06569.E7236ED5; Tue,  3 Dec 2019 19:01:34 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203100133epsmtip167b7bf21b5cfed4a1b25ebc244f69a8b~c1DUKIW5K1061410614epsmtip16;
        Tue,  3 Dec 2019 10:01:33 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Fix to send close indication on timeout
Date:   Tue,  3 Dec 2019 15:31:25 +0530
Message-Id: <1575367285-8098-3-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7bCmhm6d0bNYg21/DS3mXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEXl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qba
        Krn4BOi6ZeYAjVdSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFBgaFegVJ+YWl+al
        6yXn51oZGhgYmQJVJuRkfD37hrGgibPiw/LPTA2M29m7GDk5JARMJNp2TWbqYuTiEBLYzShx
        efEzNgjnE6NE+55ZLBDON0aJGQ/PM8G0zLr1kh0isZdR4uSGiVD9HUwSSx6uZQapYhMwljh/
        8xVYh4iAssSzfYfBbGYBbYlJb2aC2cICThITdzxgAbFZBFQlpjy6zAZi8wq4Syxf9Y4FYpuc
        xM1znUAzOTg4BTwkZuxJBtklIfCQVWLzl3fMEDUuEi1zZ0DZwhKvjm+Bek5K4vO7vWwQdjej
        xO43rhDNUxgl7r04DPWOvcTTTXPZQRYwC2hKrN+lD3Enn0Tv7ydMIGEJAV6JjjYhiGoFiVVT
        J0J1ikmsm/4FapWHxKYFS6DhMJtRouPkPuYJjLKzEKYuYGRcxSiZWlCcm55abFpgmJdajhxT
        mxjB6UbLcwfjrHM+hxgFOBiVeHgP/HkSK8SaWFZcmXuIUYKDWUmEd5vE01gh3pTEyqrUovz4
        otKc1OJDjKbAAJzILCWanA9MhXkl8YamRmZmBpYGpsYWZoZK4ryTWK/GCAmkJ5akZqemFqQW
        wfQxcXBKNTAusbF2sP/zOcVm/i8J6QQnpvyTD9i2v15+94HKS3f1VPvTqYlrnqqcnrn4zfQt
        Zz5P0dlkmWfCN2u116kkEQt9Pcntkr67bUOnBWyWtln2VG3/qaqt6wNPbSvbtqD01uSJDyIE
        WWKaPnNcnnRFXFNSftG7Jz0njrSLmNpecOEysu7sZzCewPVXiaU4I9FQi7moOBEAagVt300D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSnG6d0bNYg5WnxCzmXOtjtvi/9Ba7
        A5NH35ZVjB6fN8kFMEVx2aSk5mSWpRbp2yVwZXw9+4axoImz4sPyz0wNjNvZuxg5OSQETCRm
        3XoJZHNxCAnsZpT4svoaVEJM4s2KE1C2sMTKf8+hitqYJKZ+vQ2WYBMwljh/8xUTiC0ioCzx
        bN9hMJtZQFti0puZYLawgJPExB0PWEBsFgFViSmPLrOB2LwC7hLLV71jgVggJ3HzXCdzFyMH
        B6eAh8SMPckgYSGgki+PJrNPYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMj
        OEi0tHYwnjgRf4hRgINRiYc349eTWCHWxLLiytxDjBIczEoivNsknsYK8aYkVlalFuXHF5Xm
        pBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYKw8ffwy6/9otskOaj+TpnNc/rtQ
        6WDLRi6vkIlPPlW96fxgdzOwtSmoIeXojObXXKw3gu4ZXHxU13eC8dKzSd/9nXe7hAqqfD12
        aEITq9CTLs/zlV9fiPr9frTG8vTCPi+teUZT7xQGXWUvs6t1Ocr6gJmVKfDOqxlXXqUbbT09
        71bVMvt7hmFKLMUZiYZazEXFiQAFH3L+DgIAAA==
X-CMS-MailID: 20191203100134epcas5p4855ab386bd90877c85114b970a252223
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191203100134epcas5p4855ab386bd90877c85114b970a252223
References: <1575367285-8098-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20191203100134epcas5p4855ab386bd90877c85114b970a252223@epcas5p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

If pb_session is freed in timeout, close indication will not be sent.
pb_session is freed in pb_adv_unreg() and hence removed from tx_timeout.
Added acceptor_free() in acp_prov_close() to ensure pb_session is freed.
---
 mesh/pb-adv.c        | 2 --
 mesh/prov-acceptor.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 19d1453..586cd7f 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -175,8 +175,6 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	l_info("TX timeout");
 	cb = pb_session->close_cb;
 	user_data = pb_session->user_data;
-	l_free(pb_session);
-	pb_session = NULL;
 	cb(user_data, 1);
 }
 
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index bca0193..03972c2 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -121,6 +121,7 @@ static void acceptor_free(void)
 static void acp_prov_close(void *user_data, uint8_t reason)
 {
 	/* TODO: Handle Close */
+	acceptor_free();
 }
 
 static void prov_to(struct l_timeout *timeout, void *user_data)
-- 
2.7.4

