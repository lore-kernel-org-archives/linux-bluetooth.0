Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FDC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B155020737
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YJ9xoiNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZPL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:11:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:43303 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgCZPL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 11:11:26 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200326151124epoutp0162c65d832880c74de267f97465484061~-40Y1Viqc3028230282epoutp01Z
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 15:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200326151124epoutp0162c65d832880c74de267f97465484061~-40Y1Viqc3028230282epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585235484;
        bh=Pz97ngtWpSKkZdbYv99m7LOy8ZHxpkFgrUfzn5cUd+U=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=YJ9xoiNRhCME5fwMeerTXp34b0Feu7195QGmb2JK+tlHmfxdxETa5cQ5TogVkLiQK
         N0XO5PvzaFaUNei4sJGXN+rVnzQfAlwlQUQPOqLEDsToFr5PTNhU033RYtndG5efY5
         Y3LlVDH7yRm+GwogwrSD9EphdTNkNQ06bSpbMN68=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200326151123epcas5p4b32059119c793ba8537878a57ea5acda~-40X7roOv0673006730epcas5p4g;
        Thu, 26 Mar 2020 15:11:23 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-ae-5e7cc61b9d18
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.BB.04736.B16CC7E5; Fri, 27 Mar 2020 00:11:23 +0900 (KST)
Mime-Version: 1.0
Subject: Mesh Key Refreshment procedure from Config client
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Semun Lee <semun.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
Date:   Thu, 26 Mar 2020 20:22:52 +0530
X-CMS-MailID: 20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmhq70sZo4g+a58hbvuqazWSz5/pHN
        Ys61PmaLY5ueMjmwePRtWcXo8XmTXABTFJdNSmpOZllqkb5dAlfGro+/2Qr+sVUsvHaUpYHx
        BGsXIyeHhICJxM5HP5hAbCGB3YwShw7YdjFycPAKCEr83SEMEhYWsJKYPecnG0SJnMTiqWvZ
        QEqEBTQlbm5MAQmzCahL/Hq4gwXEFhFwl9iz/zYjiM0sUC0x9ctiFohNvBIz2p9C2dIS25dv
        BavhFPCTWPJpKVRcVOLm6rfsMPb7Y/MZIWwRidZ7Z5khbEGJBz93M8LM2brgKVCcC8juZpR4
        vWM9E4QzhVHi48W3TBBV5hL/u9+CdfAK+ErsenYUbAOLgKrEyt/tbBA1LhIrnn1ihbhaXmL7
        2znMIE8yAz25fpc+RImsxNRT65ggSvgken8/YYJ5bMc8GFtJYuv1+dCglZDo27wLKu4h8fXE
        LhaQ24QEbjJKvJz8g30Co8IsRFDPQrJ5FsLmBYzMqxglUwuKc9NTi00LjPNSy/WKE3OLS/PS
        9ZLzczcxglOFlvcOxk3nfA4xCnAwKvHwNrTVxAmxJpYVV+YeYpTgYFYS4X0aCRTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOO4n1aoyQQHpiSWp2ampBahFMlomDU6qBcQpzlukpwyq1DbJ3fVsU
        dja0HRGMWO5Rt3ThUfZNJ7Mzl+izS2lMKZ7MNGPrB4W3jb5Tl8eUMk/wqUgQFs1Vkz9yvYGb
        Rfamgepe/+pPRf/TH/bFq1tlPpjy3fxUY+6py2ddp984JBVXzVyXvMdt4pPjEsXXa5lDeuu/
        SgiaHTirv8RVVdpMiaU4I9FQi7moOBEAisY8dREDAAA=
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
        <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p2>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi ,
 Presently, I am trying to check *Key Refreshment Procedure* from Mesh Config client.

For checking the operation, I did following steps
 - Create Subnet in Config client at Net index 1
 - Add SubNetKey to Local Node at Net Index 1
 - Add SubNetKey to Remote Node at Net Index 1
 - Update Netkey to remote Node in Net index 1

After updating the Netkey, I believe, config client has to either send out SNB with KeyRefreshment(KR) Flag=1 & secured with updated NetKey (i.e by subnet->net_key_upd id)
or send out "Config Key Refresh Phase Set" with transition parameter, set to 2. I could not find the later provision in cfgclient menu.
However, Config Client seems to be not sending out Secure Network Beacon as well. So KR procedure seems to be not progressing at my setup at present.

Any hint of what could be missing will be really helpful! Thank You.

BR,
-Anupam Roy
