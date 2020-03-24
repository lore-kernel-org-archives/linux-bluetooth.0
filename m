Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41743C54EEB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2AB2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bkBazCkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCXT2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55756 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgCXT2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:31 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200324192828epoutp021af599c319d4abcbe0c6a3f12fe59087~-VCREc0Hw3137231372epoutp02q
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200324192828epoutp021af599c319d4abcbe0c6a3f12fe59087~-VCREc0Hw3137231372epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078108;
        bh=3IdF/WGVzLCSQrGDErvZ/0YpckBw0tnpR0jqdfvTVRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkBazCkt6wCXur7I0cZHz0VfwPAf99Y6/dzO1R86tTRoIEYHdbri7M68ydnnmKo3p
         cmdMF/mTMhTnASX5a0Bm6upuNbpYid7ouskiqecnMA6Y0B7WCAcliEM55CzkxlIg71
         jgvmF2phb6x2oVu+ONTPRPuspJWBeDi1FsnAIsHo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200324192827epcas5p19a70c10048e2504738e9b5811bcc20f0~-VCQFqFzu1650916509epcas5p1_;
        Tue, 24 Mar 2020 19:28:27 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.198]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48n1WG2Z2hzMqYkY; Tue, 24 Mar
        2020 19:28:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.E6.04736.95F5A7E5; Wed, 25 Mar 2020 04:28:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200324192823epcas5p3b25363353b98e206a50d7fd4572c9552~-VCMuPbs22547825478epcas5p3y;
        Tue, 24 Mar 2020 19:28:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200324192823epsmtrp22960e7d823c8983694bac810c504ca3c~-VCMHacRc2919629196epsmtrp2i;
        Tue, 24 Mar 2020 19:28:23 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-b8-5e7a5f5993f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.2A.04158.75F5A7E5; Wed, 25 Mar 2020 04:28:23 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192822epsmtip1816c0a85d8f58163caecdb829b8b3cec~-VCLflhrk1049610496epsmtip1H;
        Tue, 24 Mar 2020 19:28:22 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Handle KeyRefresh phase 1 to phase 3
Date:   Wed, 25 Mar 2020 00:57:19 +0530
Message-Id: <1585078044-14974-5-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7bCmhm5UfFWcwfzpTBZzrvUxW/xfeovd
        YtK+DywOzB59W1YxenzeJBfAFJVjk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6k
        kJeYm2qr5OIToOuWmQO0Q0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhUoFec
        mFtcmpeul5yfa2VoYGBkClSZkJMxZcck1oJNfBUrfqxnbGB8z93FyMkhIWAice3iReYuRi4O
        IYHdjBKPpu9ghHA+MUqcfr+ZBcL5xijxtXcbO0zL5iMT2CASexklvh35AeV0MEksWzCPEaSK
        TcBY4vzNV0wgtoiAssSzfYfBbGYBe4kjP76zgNjCQHZfyxZmEJtFQFXiw4Y3YHFeAQ+J5onT
        mCG2yUncPNcJZnMKeEqsvXIM7D4JgZesEt2PmqGKXCSmn17PBmELS7w6vgXqVCmJz+/2QsW7
        GSV2v3GFaJ7CKHHvBchFHECOvcSEF/wgJrOApsT6XfoQd/JJ9P5+AlXBK9HRJgQxRUFi1dSJ
        TBC2mMS66V+gNnlIvD29Aex8IYE5jBJvf2tNYJSdhTB0ASPjKkbJ1ILi3PTUYtMC47zUcuSI
        2sQITjta3jsYN53zOcQowMGoxMPb8LgyTog1say4MvcQowQHs5II7+bUijgh3pTEyqrUovz4
        otKc1OJDjKbA8JvILCWanA9MiXkl8YamRmZmBpYGpsYWZoZK4ryTWK/GCAmkJ5akZqemFqQW
        wfQxcXBKNTBOS1/whnXe1lfHgvcGvBet3fDA8sC6EuuFy9zmXxM5+94/1FeVueBFRKz7lH3P
        WgpCBa5GKmissY5d/GqbRiurVQp7netF1wX3hRn2bOF+cPFMUcBhNl7ZVt36xRkLQqYudl+4
        tqsjN86k/sR0pXfTH4meOuF7XyixVEh9/ddAK96vIgxnpzUrsRRnJBpqMRcVJwIAlkmLYFED
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTjc8virOYOoZLos51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKmLJjEmvBJr6KFT/WMzYwvufuYuTk
        kBAwkdh8ZAJbFyMXh5DAbkaJtuMnmCESYhJvVpxgh7CFJVb+e84OUdTGJLHj13UmkASbgLHE
        +ZuvwGwRAWWJZ/sOg9nMAo4Sn67MYwOxhQXsJfpatoANZRFQlfiw4Q0LiM0r4CHRPHEa1DI5
        iZvnOsFsTgFPibVXjjGC2EJANX86Z7JNYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9d
        Lzk/dxMjOGC0tHYwnjgRf4hRgINRiYdX42FlnBBrYllxZe4hRgkOZiUR3s2pFXFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGJ2t2hOzt1xW7T4fGLku
        4rXLJDvpn/677p5R+VnpN3eHzSq+T9tlTRx9yiVv6TWaib3Y/rnP4vrZ1F1NSzklXwfseBDh
        6rL/+6riR8+kdBQbf+3cbBDL8pZ/ybK836cvCmyJU/Kf89hx8mFGvbmLuGUyLF5K7dVZJrZ1
        SzXv8qVpn2d9WaOpdlaJpTgj0VCLuag4EQDXUmc6FAIAAA==
X-CMS-MailID: 20200324192823epcas5p3b25363353b98e206a50d7fd4572c9552
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192823epcas5p3b25363353b98e206a50d7fd4572c9552
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
        <CGME20200324192823epcas5p3b25363353b98e206a50d7fd4572c9552@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Switch to phase 3 when updated net key index is same as
beacon key id. Switch beaconing key in phase 2 and phase 3.
---
 mesh/net.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index ec05b6be9..3b6c8365f 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2598,6 +2598,14 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
 	refresh_beacon(subnet, net);
+
+	/* send snb with updated net key id in phase 2 */
+	if (net->beacon_enable) {
+		/* Switch beaconing key */
+		net_key_beacon_disable(subnet->net_key_cur);
+		net_key_beacon_enable(subnet->net_key_upd);
+	}
+
 	queue_friend_update(net);
 
 	l_queue_foreach(net->friends, frnd_kr_phase2, net);
@@ -2625,6 +2633,13 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 
 	l_info("Key refresh phase 3: use new keys only, discard old ones");
 
+	/* required when skipping phase 2 */
+	if (net->beacon_enable) {
+		/* Switch beaconing key */
+		net_key_beacon_disable(subnet->net_key_cur);
+		net_key_beacon_enable(subnet->net_key_upd);
+	}
+
 	/* Switch to using new keys, discard old ones */
 	net_key_unref(subnet->net_key_cur);
 	subnet->net_key_tx = subnet->net_key_cur = subnet->net_key_upd;
@@ -2755,7 +2770,8 @@ static void process_beacon(void *net_ptr, void *user_data)
 				ivi != net->iv_index || ivu != net->iv_update)
 		update_iv_ivu_state(net, ivi, ivu);
 
-	if (kr != local_kr)
+	if (kr != local_kr || (subnet->kr_phase == KEY_REFRESH_PHASE_ONE &&
+				subnet->net_key_upd == beacon_data->key_id))
 		update_kr_state(subnet, kr, beacon_data->key_id);
 
 	net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
-- 
2.17.1

