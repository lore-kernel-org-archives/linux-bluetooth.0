Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37474C54EEB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A4B2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OQ9qE84B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXT2a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgCXT23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:29 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200324192827epoutp014d561e2b867a223fa9537e10cda93308~-VCQbEw281218612186epoutp01p
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200324192827epoutp014d561e2b867a223fa9537e10cda93308~-VCQbEw281218612186epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078107;
        bh=y+0Nnk0dHGSeVj81KfuTyqdqXT00O5hfX4Oc8olO3/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQ9qE84Bajlfffk+6Hb7ieeSEGlgvPiMt15oxVQ7KwxRFzE1jYRs0P38F/Y6UChX2
         buwzdAcLUJeZj3SHqLYwwrUu0TCkGUEIM2hjK2VYclXzl2RQSqi3qX2GzroozcOXc8
         kj5q83S2996HZFxgiqJZ6dpjWPVWPwHut7wksy3Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200324192826epcas5p2360a2052605765d8f34636551d254910~-VCO-_4Jf1207312073epcas5p24;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.198]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48n1WF1QQJzMqYlm; Tue, 24 Mar
        2020 19:28:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.E6.04736.95F5A7E5; Wed, 25 Mar 2020 04:28:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200324192824epcas5p4886d88a31b8f9b31eeaf2fa38385698b~-VCMziMCd0495104951epcas5p4Y;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192824epsmtrp18be4fe8f615202fc745cf51e750dcf26~-VCMy62jv3078230782epsmtrp1L;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-b6-5e7a5f59c36d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.F8.04024.75F5A7E5; Wed, 25 Mar 2020 04:28:23 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192823epsmtip1946eae9e1e60136e969026ef41db3590~-VCMNTbw40279802798epsmtip1R;
        Tue, 24 Mar 2020 19:28:23 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle KeyRefresh phase set to 3
Date:   Wed, 25 Mar 2020 00:57:20 +0530
Message-Id: <1585078044-14974-6-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7bCmlm5kfFWcwYnJXBZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJPx/vFB5oLHrBU/fj5laWC8ydLFyMkhIWAi0fToB1MXIxeH
        kMBuRomuo7eYIZxPjBLbF/1kh3C+MUp8an/MBNPyu7WVESKxl1Hi2aLZLBBOB5PE0wWdzCBV
        bALGEudvvgLrEBFQlni27zCYzSxgL3Hkx3ew5cIC1hJLr+1lBLFZBFQlvk2/wA5i8wp4SDTu
        f8cGsU1O4uY5iJmcAp4Sa68cA9ssIfCSVaJl/hxmiCIXiVetr6BsYYlXx7ewQ9hSEi/726Ds
        bkaJ3W9cIZqnMErcewFyEQeQYy8x4QU/iMksoCmxfpc+xJ18Er2/n0BV8Ep0tAlBTFGQWDV1
        IjQgxCTWTf/CDlHiITHvvQMkGOYwSjzqOcQygVF2FsLQBYyMqxglUwuKc9NTi00LjPNSy5Ej
        ahMjOO1oee9g3HTO5xCjAAejEg9vw+PKOCHWxLLiytxDjBIczEoivJtTK+KEeFMSK6tSi/Lj
        i0pzUosPMZoCw28is5Rocj4wJeaVxBuaGpmZGVgamBpbmBkqifNOYr0aIySQnliSmp2aWpBa
        BNPHxMEp1cDowK0s9f7CpMq6ZH719cefh06dV1tYOD+06cdEbzcpc1ehRbz3a5c03zJ4NzU3
        qNq+aNfB0Hdt01ZtOHvt75nUPSrm0ifnd31Uu3P+bJ9i2b34fcENaeuiu3Y+VZU20p3zS1d4
        s8q8iT/tpDoVJdeesE+vSC+o/hvfdNlCVq+RX/pfS/ydrxFKLMUZiYZazEXFiQDuRNXrUQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTjc8virO4OlLS4s51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKeP/4IHPBY9aKHz+fsjQw3mTpYuTk
        kBAwkfjd2srYxcjFISSwm1Fi28U5zBAJMYk3K06wQ9jCEiv/PQezhQTamCQaGjhBbDYBY4nz
        N18xgdgiAsoSz/YdBrOZBRwlPl2ZxwZiCwtYSyy9tpcRxGYRUJX4Nv0C2BxeAQ+Jxv3v2CDm
        y0ncPNcJtpdTwFNi7ZVjjBC7PCT+dM5km8DIt4CRYRWjZGpBcW56brFhgWFearlecWJucWle
        ul5yfu4mRnC4aGnuYLy8JP4QowAHoxIPr9bDyjgh1sSy4srcQ4wSHMxKIrybUyvihHhTEiur
        Uovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamBc1vfk+PM3rmd5aoq8
        N+olsuWbS4Vmrpi5N4FFlPFi57WHdXr/vkluSm15b9B+KOUhz4Y6Fssrr07W+bh+EBHtrb3G
        UP/JLO78lTt7QyO5Ba+wTXl63um61yvu288c/yluMdm3QuqF+in9XVLvNttqmd/5+jHzqFv3
        wuL0zOm/14v6ZxUqbW5RYinOSDTUYi4qTgQAXGR4GRMCAAA=
X-CMS-MailID: 20200324192824epcas5p4886d88a31b8f9b31eeaf2fa38385698b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192824epcas5p4886d88a31b8f9b31eeaf2fa38385698b
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192824epcas5p4886d88a31b8f9b31eeaf2fa38385698b@epcas5p4.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

If keyRefresh phase 3 is already completed then respond with
current phase state and status as SUCCESS.
---
 mesh/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index ec05b6be9..91d14b0b3 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3419,6 +3419,9 @@ uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
 	if (transition == subnet->kr_phase)
 		return MESH_STATUS_SUCCESS;
 
+	if (transition == 3 && subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
+		return MESH_STATUS_SUCCESS;
+
 	if ((transition != 2 && transition != 3) ||
 						transition < subnet->kr_phase)
 		return MESH_STATUS_CANNOT_SET;
-- 
2.17.1

