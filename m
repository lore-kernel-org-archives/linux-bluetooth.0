Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDAFC2BAEE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BBF2076F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BesH4yst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCXT2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:33 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15032 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCXT2a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:30 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200324192828epoutp03ac76bfa28615e95590cafb69c9539f30~-VCRXG8KK0335903359epoutp03_
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200324192828epoutp03ac76bfa28615e95590cafb69c9539f30~-VCRXG8KK0335903359epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078108;
        bh=wx0C0C3fFCZ3eGmioDklDPTyveNr3B/1zKlgUVwwVvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BesH4ystJmV6Wsnb9LmKGEg35VFzS3Db9+1sS56IkvuV3o5riYNgYctE55TOTeZos
         zCPA+wxhDQ9zbVVUncdadir2ooefGDFOBHZOSWk1wKgZ3fSgY3jGgnZLlYfwPEsawM
         avp6cutwLcBZOGjonDu5+497t4auQZDsK2lGs6hw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200324192828epcas5p297613c2687dcf37ca19779f4bb6c8320~-VCQmk_FT0057600576epcas5p2a;
        Tue, 24 Mar 2020 19:28:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48n1WG6Pq3zMqYkV; Tue, 24 Mar
        2020 19:28:26 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.DD.04778.A5F5A7E5; Wed, 25 Mar 2020 04:28:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200324192826epcas5p2eb80e44ac061329faf5421ba3b76e5f8~-VCO8r6s_0057600576epcas5p2Z;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324192826epsmtrp2fabcaba7c7288d7e609397d5c318fced~-VCO8Ideh0076200762epsmtrp2C;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
X-AuditID: b6c32a4a-33bff700000012aa-c2-5e7a5f5a797b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.F8.04024.A5F5A7E5; Wed, 25 Mar 2020 04:28:26 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192825epsmtip1961dd9675a73e40ea169135d97c8a7c7~-VCOWyfnC2936029360epsmtip15;
        Tue, 24 Mar 2020 19:28:25 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Send input complete for input OOB Authentication
Date:   Wed, 25 Mar 2020 00:57:23 +0530
Message-Id: <1585078044-14974-9-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7bCmlm5UfFWcwdelBhZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJOx5vAf1oKzbBW33l9ibGDcz9rFyMkhIWAiseHVVOYuRi4O
        IYHdjBLTlrxhgnA+MUq87N3ODuF8Y5TY/uoEE0zLvd+P2EFsIYG9jBKfmkMhijqYJF7+/cgG
        kmATMJY4f/MVWIOIgLLEs32HwWxmAXuJIz++s4DYwgLeEp3vV4HFWQRUJRas+sQIYvMKeEhc
        /L8KapmcxM1zncwgNqeAp8TaK8cYQZZJCLxklbh74BM7RJGLxKZ1P6FsYYlXx7dA2VISn9/t
        ZYOwuxkldr9xhWiewihx7wXIRRxAjr3EhBf8ICazgKbE+l36EHfySfT+fgJVwSvR0SYEMUVB
        YtXUiVCniUmsm/4FapOHxLwPS9gg4TCHUWLv5mtMExhlZyFMXcDIuIpRMrWgODc9tdi0wCgv
        tRw5ojYxgtOOltcOxmXnfA4xCnAwKvHwajysjBNiTSwrrsw9xCjBwawkwrs5tSJOiDclsbIq
        tSg/vqg0J7X4EKMpMAAnMkuJJucDU2JeSbyhqZGZmYGlgamxhZmhkjjvJNarMUIC6Yklqdmp
        qQWpRTB9TBycUg2MG3leVn0S45BbfTxs8ZnQRYunemw5lHRFsUpwo82aJZ05ttHuOkc+/jLT
        kPovxGRwYtaquxfSg/6djJxWFOn7XC9fI+f4vOrTXLOmv3JKW6q9R9MyRW051+Fc+9nB3Gus
        FpdvOyi5/v6OnQKexWettzVZ7/lV72G/PsI8/8Tz59t/fIiqd/b8p8RSnJFoqMVcVJwIAPEy
        UFZRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTjcqvirOYMMufos51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKWHP4D2vBWbaKW+8vMTYw7mftYuTk
        kBAwkbj3+xF7FyMXh5DAbkaJ9h8r2SASYhJvVpxgh7CFJVb+ew5V1MYkceFDPwtIgk3AWOL8
        zVdMILaIgLLEs32HwWxmAUeJT1fmgQ0SFvCW6Hy/CizOIqAqsWDVJ0YQm1fAQ+Lif4i4hICc
        xM1zncwgNqeAp8TaK8fAaoSAav50zmSbwMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66
        XnJ+7iZGcMBoae5gvLwk/hCjAAejEg+v1sPKOCHWxLLiytxDjBIczEoivJtTK+KEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYCxntvEz+MkVPW2G/GqV
        GYvZ917/1BsnfzqTsbPrw5mHr5d21df2S+ysyjU9/LLztf2hqQ7GR3ZeOfsnjnfy8z2Hyu9m
        20smqWjZPfA0WvdzY+qWfx1TA0JLK4t3Hnu12PZOYvv8l0u3Lv7dt+xI183SHarmjEdOHj7F
        PEl0Qsa+LXFRqnxy9zSVWIozEg21mIuKEwGhv2pzFAIAAA==
X-CMS-MailID: 20200324192826epcas5p2eb80e44ac061329faf5421ba3b76e5f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192826epcas5p2eb80e44ac061329faf5421ba3b76e5f8
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192826epcas5p2eb80e44ac061329faf5421ba3b76e5f8@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Send input complete when user completes input operation.
---
 mesh/prov-acceptor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 03972c227..20a2ce4be 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -272,6 +272,12 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	memcpy(prov->rand_auth_workspace + 16, key, 16);
 	memcpy(prov->rand_auth_workspace + 32, key, 16);
 	prov->material |= MAT_RAND_AUTH;
+
+	if (prov->conf_inputs.start.auth_action ==
+							PROV_ACTION_IN_ALPHA) {
+		msg.opcode = PROV_INP_CMPLT;
+		prov->trans_tx(prov->trans_data, &msg.opcode, 1);
+	}
 }
 
 static void priv_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
-- 
2.17.1

