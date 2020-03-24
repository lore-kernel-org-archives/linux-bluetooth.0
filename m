Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EAC41621
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AB52074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="anRSu+v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCXT2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:33 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:37938 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCXT2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:31 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200324192829epoutp042f6b97d1de7cf88423bb49222fda9ea1~-VCSKo60_0411104111epoutp04S
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200324192829epoutp042f6b97d1de7cf88423bb49222fda9ea1~-VCSKo60_0411104111epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078109;
        bh=TBPPkHs4BrAC5rcQRKVwe6avbPthA1l8jMhLQvgJNbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anRSu+v4wf/RstUv8fEm0r7kkIIfXGoLNddt3MZXIf0N0uiGYmzY6J6CUqtxvYg0+
         bVE4KVRC9HNI3YS4Ksl7hEUjC1ngcR0w7g8Avu0xet0Os6hDpXExnawEgwvSkp40Dh
         saMSN+FLGD5n3eM+j4M9/yExUNEOCoX0/i66l/tc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200324192828epcas5p47ccb547898e194ea646e08c91d711a24~-VCRYjznV2607026070epcas5p4w;
        Tue, 24 Mar 2020 19:28:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48n1WH4lkPzMqYkY; Tue, 24 Mar
        2020 19:28:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.62.04782.B5F5A7E5; Wed, 25 Mar 2020 04:28:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200324192827epcas5p3f70d5e24d6042786ffea8bdbd5ddc8e8~-VCPvFNC40624506245epcas5p3M;
        Tue, 24 Mar 2020 19:28:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192827epsmtrp185c785f58164cd9c4918040cf36ad1f8~-VCPp5PNS3078230782epsmtrp1M;
        Tue, 24 Mar 2020 19:28:27 +0000 (GMT)
X-AuditID: b6c32a49-8b3ff700000012ae-69-5e7a5f5b6a31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.2A.04158.A5F5A7E5; Wed, 25 Mar 2020 04:28:27 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192826epsmtip12ee8c704ad95daf3e05d5051674c4642~-VCPEltpu0279802798epsmtip1T;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Validate Provisioning Start PDU values
Date:   Wed, 25 Mar 2020 00:57:24 +0530
Message-Id: <1585078044-14974-10-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmum50fFWcwdU3KhZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJOxc8c79oIrnBWTZ+xgbGD8yN7FyMkhIWAisarxD1sXIxeH
        kMBuRoktx6azQjifGCWur3rADOF8Y5SY9WweXMve5efAbCGBvYwSN56bQhR1MEksW7qKESTB
        JmAscf7mKyYQW0RAWeLZvsNgNrOAvcSRH99ZQGxhAUeJPytfgNksAqoSd58dAOvlFfCU+Hvy
        NyvEMjmJm+c6mUFsTqD42ivHGCHiD1klFi4zh7BdJJrb9zND2MISr45vgTpUSuJlfxuU3c0o
        sfuNK8ihEgJTGCXuvQA5iAPIsZeY8IIfxGQW0JRYv0sf4kw+id7fT6AqeCU62oQgpihIrJo6
        kQnCFpNYN/0L1HQPiS9nNrJAgmEOo8TZ64/YJzDKzkKYuoCRcRWjZGpBcW56arFpgWFeajly
        PG1iBCcdLc8djLPO+RxiFOBgVOLhbXhcGSfEmlhWXJl7iFGCg1lJhHdzakWcEG9KYmVValF+
        fFFpTmrxIUZTYPhNZJYSTc4HJsS8knhDUyMzMwNLA1NjCzNDJXHeSaxXY4QE0hNLUrNTUwtS
        i2D6mDg4pRoY2ZkWGfitUOoo9AzZZbyH/VJ3D6f2o067cp6LP5/OvLbT/bXFga+vH080uzst
        lNH25P+Lfvv3KmbM0ctYU1rC63cieyfb9gyenT1falbOOXnewWf9i6r9VlN7F0WF9bLc+JAT
        3mls69qlwmI65572h3uuck2+S/POtGwTXDWld+oFRq1TtudXKbEUZyQaajEXFScCAHbtwYVQ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTjc6virO4E0bo8Wca33MFv+X3mK3
        mLTvA4sDs0ffllWMHp83yQUwRXHZpKTmZJalFunbJXBl7Nzxjr3gCmfF5Bk7GBsYP7J3MXJy
        SAiYSOxdfg7I5uIQEtjNKDFzw1OohJjEmxUnoGxhiZX/nkMVtTFJfNt/lgUkwSZgLHH+5ism
        EFtEQFni2b7DYDazgKPEpyvz2EBsYSD7z8oXYPUsAqoSd58dYASxeQU8Jf6e/M0KsUBO4ua5
        TmYQmxMovvbKMbAaIQEPiT+dM9kmMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yf
        u4kRHDBaWjsYT5yIP8QowMGoxMOr8bAyTog1say4MvcQowQHs5II7+bUijgh3pTEyqrUovz4
        otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjOVaNTX6Xhoxz1kmJbIq6i7l
        n/vl9oeINRMaX+fqPz73o+i+iZzERu9fp96evaW/cfVy0St/pbTK9O6IyzEnZjPFLNmpfJLb
        Ye2P5rmvJE562Gt/1J5Wv8es8KJJ2czXqharrVsMrHdprA7/fO6VdpqOwJ3Zn94fsBC3si+S
        s/HaX8QTeuhsuxJLcUaioRZzUXEiAGbrFyYUAgAA
X-CMS-MailID: 20200324192827epcas5p3f70d5e24d6042786ffea8bdbd5ddc8e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192827epcas5p3f70d5e24d6042786ffea8bdbd5ddc8e8
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192827epcas5p3f70d5e24d6042786ffea8bdbd5ddc8e8@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Check for inconsistent Authentication method versus Authentication
Action and Authentication Size fields before proceeding for
exchanging public keys. Check for Public Key OOB in Capabilities
and Start PDU.
---
 mesh/prov-acceptor.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 03972c227..d0ae77322 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -393,6 +393,21 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 			goto failure;
 		}
 
+		if (prov->conf_inputs.start.auth_method < 2 &&
+				(prov->conf_inputs.start.auth_action ||
+					prov->conf_inputs.start.auth_size)) {
+			l_debug("inconsistent auth method and action");
+			fail.reason = PROV_ERR_INVALID_FORMAT;
+			goto failure;
+		}
+
+		if (prov->conf_inputs.caps.pub_type !=
+				prov->conf_inputs.start.pub_key) {
+			l_debug("inconsistent pubkey type");
+			fail.reason = PROV_ERR_INVALID_FORMAT;
+			goto failure;
+		}
+
 		if (prov->conf_inputs.start.pub_key) {
 			if (prov->conf_inputs.caps.pub_type) {
 				/* Prompt Agent for Private Key of OOB */
-- 
2.17.1

