Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865FC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E8F2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QQB5nBZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCXT20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:26 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37924 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXT20 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:26 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200324192823epoutp043fec07a1dacb97bb8fb803812b159ad5~-VCMXxBcP0411104111epoutp04Q
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200324192823epoutp043fec07a1dacb97bb8fb803812b159ad5~-VCMXxBcP0411104111epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078103;
        bh=9Q/n9W/DM7iy18ueyuO2gTywZ26jTP+FsGIrAQYDcD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQB5nBZIWWkriAC/pvHF9LU+ViNHDjnDxU84i8uomRjtNpVBq1/CiaCHYUuiaTR8A
         XRc3zZ9wwqLxhhtcgVeB5VXLXNtqKrv43K509eqkJC9erh6Rmg1kn+cb/tvy0qLeIY
         TIC//9GlvUEIMJJT+UjLh8rreiZxH6cBO+UXazXY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200324192823epcas5p4d10afa4d53206de380768d5482dc5c57~-VCL5yn2Z0495104951epcas5p4V;
        Tue, 24 Mar 2020 19:28:23 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.196]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48n1W969qVzMqYkV; Tue, 24 Mar
        2020 19:28:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.62.04782.55F5A7E5; Wed, 25 Mar 2020 04:28:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099~-VCJ73LHS2153921539epcas5p1N;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192820epsmtrp1f4e0049085a878abd720f3d5ff4b87b7~-VCJ4SO1T3078230782epsmtrp1I;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-62-5e7a5f5596b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.2A.04158.45F5A7E5; Wed, 25 Mar 2020 04:28:20 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192820epsmtip131a6d31e4a911fddf73ca545d616fc4f~-VCJUaaHs0279802798epsmtip1P;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Check limits for count and interval of relay
Date:   Wed, 25 Mar 2020 00:57:16 +0530
Message-Id: <1585078044-14974-2-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7bCmpm5ofFWcwfN7RhZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJMx/fYTxoInbBX/pvE0MO5h7WLk5JAQMJHY9KyXuYuRi0NI
        YDejxL9tD5kgnE+MEgcefIXKfGOU+PrqKSNMy8/9t9ghEnsZJTZ9/88G4XQwSTTs/MECUsUm
        YCxx/uYrJhBbREBZ4tm+w2A2s4C9xJEf38FqhAXcJe68nQN2CIuAqsTEc0/YQWxeAQ+J1vlH
        oQ6Uk7h5rpMZxOYU8JRYe+UYI8gyCYGnrBJbPs8GauAAclwkvvQWQtQLS7w6voUdwpaSeNnf
        BmV3M0rsfuMK0TuFUeLeC5CDQHrtJSa84AcxmQU0Jdbv0oc4k0+i9/cTqApeiY42IYgpChKr
        pk5kgrDFJNZN/wJ1gIfE5gcGkFCYwyix9dsNlgmMsrMQhi5gZFzFKJlaUJybnlpsWmCYl1qO
        HE2bGMEpR8tzB+Oscz6HGAU4GJV4eBseV8YJsSaWFVfmHmKU4GBWEuHdnFoRJ8SbklhZlVqU
        H19UmpNafIjRFBh8E5mlRJPzgekwryTe0NTIzMzA0sDU2MLMUEmcdxLr1RghgfTEktTs1NSC
        1CKYPiYOTqkGRkGH8ge1JzK3Hjl0e6Gix+vo/xMqnBxzXbekpbUpuc2rLNDapG0/xf7GwosT
        1W7t/3M0krnSvn+13GqjszxGDWxWLjar1qixLPw+82LLvG7hL9fSMpsMKmcftjwleYXluvUz
        if/5Fw48iL8gYTpX9s5W2Xnnjl4+KHdwultS3tMgHVm+tNnnDZVYijMSDbWYi4oTAb1IChtP
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTjckvirO4NEWY4s51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKmH77CWPBE7aKf9N4Ghj3sHYxcnJI
        CJhI/Nx/i72LkYtDSGA3o8SuK/cYIRJiEm9WnGCHsIUlVv57DlXUxiTRe38HG0iCTcBY4vzN
        V0wgtoiAssSzfYfBbGYBR4lPV+aB1QgLuEvceTsHbBuLgKrExHNPwIbyCnhItM4/CnWFnMTN
        c53MIDangKfE2ivHwI4QAqr50zmTbQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
        +bmbGMHhoqW1g/HEifhDjAIcjEo8vBoPK+OEWBPLiitzDzFKcDArifBuTq2IE+JNSaysSi3K
        jy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cDo5cNaEz3Tp99tiY5dseRW
        1t87eOXrxc0mt59/Id6VMpHvl2TH9VjN3zzMayPvX3zI0LwnO78muNj30Pc5cvwzez+qH7H8
        dsVt7xf/InF5tT9rHm6zX3bYq7xvwyPu51V3pl3XZlOMmOtd7sjvoV1ReSXsrbm4xJvviV93
        ymcuW13qtZB5lpASS3FGoqEWc1FxIgCBttwlEwIAAA==
X-CMS-MailID: 20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192820epcas5p10a4ae9a6d7e7dab22f4a5ab4ee752099@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Added limit checking condition for count and interval
before processing for count and interval steps.
---
 mesh/cfgmod-server.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 7111411c7..151cab154 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -881,7 +881,11 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		n = mesh_model_opcode_set(OP_CONFIG_RELAY_STATUS, msg);
 
 		msg[n++] = node_relay_mode_get(node, &count, &interval);
-		msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
+
+		if (count > 0 && interval >= 10)
+			msg[n++] = (count - 1) + ((interval/10 - 1) << 3);
+		else
+			msg[n++] = 0;
 
 		l_debug("Get/Set Relay Config (%d)", msg[n-1]);
 		break;
-- 
2.17.1

