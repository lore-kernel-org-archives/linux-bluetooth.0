Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222EC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702C82076E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jb9rq18e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCXT2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55757 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgCXT2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:31 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200324192828epoutp029ab3618b1f3a6c400591057767e4f450~-VCRSaFFa3092430924epoutp027
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200324192828epoutp029ab3618b1f3a6c400591057767e4f450~-VCRSaFFa3092430924epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078108;
        bh=nFNU8zNcGvxrZdjkWuzYbWqpgyGol9IijeP4XKZ7BxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb9rq18eoyepNDUXwsfhL2+d7aVbRefUvbWTL2AWqvnhCmL0m6MhrCVzydls/6lHG
         fgWYIHg9448nDJ0ifo9Me5L2DdWA1PpkxiHVo2Aqv0zvC/8pmMxuaNSqu2Y/OydwQw
         HLEDWJniDlodyDhC6Z530er6eBwqAsJCaGVMgBbo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200324192824epcas5p38adf62d092bf9e1d1d634290796a0f71~-VCNAE0jo0868108681epcas5p3O;
        Tue, 24 Mar 2020 19:28:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.192]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48n1WB6jvxzMqYkV; Tue, 24 Mar
        2020 19:28:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.DD.04778.65F5A7E5; Wed, 25 Mar 2020 04:28:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192821epcas5p1cc8182aac6ed0b096c76e3ccbd269688~-VCKqhna81650916509epcas5p16;
        Tue, 24 Mar 2020 19:28:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192821epsmtrp1055a46801ab02050ca75f543bf1f752a~-VCKpwdrN3078230782epsmtrp1J;
        Tue, 24 Mar 2020 19:28:21 +0000 (GMT)
X-AuditID: b6c32a4a-353ff700000012aa-bb-5e7a5f563587
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.F8.04024.55F5A7E5; Wed, 25 Mar 2020 04:28:21 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192821epsmtip1fbf6555a6e9660bba7c17ef547ed42e4~-VCKCxZjk1049610496epsmtip1G;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle close for Acceptor
Date:   Wed, 25 Mar 2020 00:57:17 +0530
Message-Id: <1585078044-14974-3-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7bCmum5YfFWcwZaXJhZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJPx6OlG5oKT/BV3P75jbWB8ydPFyMEhIWAiceqwaRcjF4eQ
        wG5GiXnvXjNBOJ8YJa58vMYC4XxjlHj2dT57FyMnWMfU9XvAbCGBvYwSX5plIewOJomlv2VA
        bDYBY4nzN18xgdgiAsoSz/YdBrOZBewljvz4zgJiCwPN+ftjKZjNIqAqse1/DzPIRbwCHhIH
        b3lDrJKTuHmukxnE5hTwlFh75RgjyD0SAi9ZJf493c0IUeQisXLhDyYIW1ji1fEtUHdKSbzs
        b4Oyuxkldr9xhWiewihx7wXIQSDv20tMeMEPYjILaEqs36UPcSafRO/vJ1AVvBIdbUIQUxQk
        Vk2dCLVJTGLd9C9Q0z0kth7oY4ME1RxGie6vU9gmMMrOQpi6gJFxFaNkakFxbnpqsWmBUV5q
        OXIsbWIEJxwtrx2My875HGIU4GBU4uHVeFgZJ8SaWFZcmXuIUYKDWUmEd3NqRZwQb0piZVVq
        UX58UWlOavEhRlNg+E1klhJNzgcmw7ySeENTIzMzA0sDU2MLM0Mlcd5JrFdjhATSE0tSs1NT
        C1KLYPqYODilGhhXhixW/75rrvPZtXd/f94meN5i1YRW07Lma8/meV4KyA7rMrodEcN018nH
        QFGwqa+UIejUDo3ns/g9Hx27UZ2uVrdtktiWnJRPBlMVf3Zes5uz9bJd9FNFF7vniVIX/a0v
        THfT2Og3U6NGI29PiPoS+4UTCy7+Zzn123tK04QlRjn5Qf7fKnYrsRRnJBpqMRcVJwIAYHmk
        zE4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LZdlhJTjc0virO4PYENYs51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKePR0I3PBSf6Kux/fsTYwvuTpYuTk
        kBAwkZi6fg97FyMXh5DAbkaJB81b2CESYhJvVpyAsoUlVv57DlXUxiTxbclfFpAEm4CxxPmb
        r5hAbBEBZYln+w6D2cwCjhKfrsxjA7GFgTb8/bEUrJ5FQFVi2/8e5i5GDg5eAQ+Jg7e8IebL
        Sdw818kMYnMKeEqsvXKMEcQWAir50zmTbQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV5
        6XrJ+bmbGMHhoqW5g/HykvhDjAIcjEo8vFoPK+OEWBPLiitzDzFKcDArifBuTq2IE+JNSays
        Si3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoExaVEby9We2Md6Sz4U
        zFPfWPTwzVxraTOenV/3BbEYzpHprzF4cuKlmmS/w5x728tPKi6O/v+A5TjP1hJR6Q7dxo3F
        ctV2Xl1Oj9hesS+Zti0w+cGL8jmt9zKe+hy3ilbvvlj6popHO6pUJMH6lpKn0dqzimFFlyay
        JMrw3flkz/dsPfPRHmMlluKMREMt5qLiRAAJBWYrEwIAAA==
X-CMS-MailID: 20200324192821epcas5p1cc8182aac6ed0b096c76e3ccbd269688
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192821epcas5p1cc8182aac6ed0b096c76e3ccbd269688
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192821epcas5p1cc8182aac6ed0b096c76e3ccbd269688@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Provision complete callback is handled in provision failure case.
If link closed received abruptly with reason success, triggered
provision complete callback. Removed session timeout and session
free as they are handled in pb_adv_unreg.
---
 mesh/pb-adv.c        | 7 -------
 mesh/prov-acceptor.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 6ef45b8b0..649816fc6 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -223,9 +223,6 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
-	l_timeout_remove(session->tx_timeout);
-	session->tx_timeout = NULL;
-
 	mesh_send_cancel(filter, sizeof(filter));
 
 	l_info("TX timeout");
@@ -392,15 +389,11 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		break;
 
 	case PB_ADV_CLOSE:
-		l_timeout_remove(session->tx_timeout);
 		l_debug("Link closed notification: %2.2x", pkt[0]);
 		/* Wrap callback for pre-cleaning */
 		if (true) {
 			mesh_prov_close_func_t cb = session->close_cb;
 			void *user_data = session->user_data;
-
-			l_queue_remove(pb_sessions, session);
-			l_free(session);
 			cb(user_data, pkt[0]);
 		}
 		break;
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 03972c227..b6da67cf0 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -120,7 +120,14 @@ static void acceptor_free(void)
 
 static void acp_prov_close(void *user_data, uint8_t reason)
 {
-	/* TODO: Handle Close */
+	struct mesh_prov_acceptor *prov = user_data;
+
+	if (reason != PROV_ERR_SUCCESS && prov->cmplt)
+		prov->cmplt(prov->caller_data, reason, NULL);
+	else if (reason == PROV_ERR_SUCCESS && prov->cmplt)
+		prov->cmplt(prov->caller_data, PROV_ERR_UNEXPECTED_ERR, NULL);
+
+	prov->cmplt = NULL;
 	acceptor_free();
 }
 
-- 
2.17.1

