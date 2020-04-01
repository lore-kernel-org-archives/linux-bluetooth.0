Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE44C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CDC20776
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 11:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y595J0/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbgDAL5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:57:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22386 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAL5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 07:57:50 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200401115749epoutp0361a53677bbc97f67377a0b57ae272ae7~BsDEufZjS0165801658epoutp03T
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2020 11:57:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200401115749epoutp0361a53677bbc97f67377a0b57ae272ae7~BsDEufZjS0165801658epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585742269;
        bh=LSjE23dZvHkiBuOSucWbsS3z4beRs3eod8rYvXQy/0E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y595J0/fUg/tlhcOkFOVLe3+qrdvCJmm8mwCpiCbPVh7KOiOedKoH0DWmvbgY+2M8
         d5LkoC0tyKOGBIrYbVHnb/wzLgDZ04wCvfulm4WAMUY4M2xcQm5dustWQsVe1e4B3F
         n40HqMyBuhVtZLNF+SRArAfuFMGhBMewz3doj0Iw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200401115747epcas5p3c51c0e8204c042a5f95948be863738e2~BsDDkABee1109611096epcas5p3V;
        Wed,  1 Apr 2020 11:57:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.07.04778.BB1848E5; Wed,  1 Apr 2020 20:57:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200401112015epcas5p10545143f69c22449f559818476845cc5~BriRryGqc0866408664epcas5p1A;
        Wed,  1 Apr 2020 11:20:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200401112015epsmtrp1e67a3e0e139e1d871a069bc6873705a6~BriRrIeMY2720927209epsmtrp1U;
        Wed,  1 Apr 2020 11:20:15 +0000 (GMT)
X-AuditID: b6c32a4a-33bff700000012aa-8e-5e8481bb7b76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.F7.04158.FE8748E5; Wed,  1 Apr 2020 20:20:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.92.161]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200401112014epsmtip2701b20cae3019a3a03e32ff94f247c1f~BriQrYMov0080400804epsmtip2-;
        Wed,  1 Apr 2020 11:20:14 +0000 (GMT)
From:   Anupam Roy <anupam.r@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     amit.jaiswal@samsung.com, nitin.j@samsung.com,
        semun.lee@samsung.com, dh79.pyun@samsung.com
Subject: [PATCH BlueZ] mesh: Add check for valid netkey index
Date:   Wed,  1 Apr 2020 16:50:06 +0530
Message-Id: <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCmpu7uxpY4g/1bdC3edU1ns1jy/SOb
        xZxrfcwW29a1M1sc2/SUyYHVo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDJ2NYQVrOSsaOs5
        w9bAuI29i5GTQ0LARKL13zSmLkYuDiGB3YwSc2ZsYoNwPjFKTLh5kxHC+cYocWrjNlaYlsen
        lkO17GWU2P1qApTzhVGi7+8xJpAqNgF1iV8Pd7CA2CICyhLP9h0GizMLJEq8mraIEcQWFrCV
        +LX0HTOIzSKgKjHz2Wewo3gFnCX2P3zOCLFNTuLmuU5mCPsuq8T91RYQtovEnMd7WCBsYYlX
        x7dAPSQl8bK/jR3kIAmBbkaJzoef2SASUxgl/l83hbDtJc41PQN6hwPoIE2J9bv0IcKyElNP
        rYO6k0+i9/cTJog4r8SOeTC2ksTW6/OhISEh0bd5F1TcQ+Lkll9gtpBArMSRlnnMExhlZyFs
        WMDIuIpRMrWgODc9tdi0wCgvtVyvODG3uDQvXS85P3cTIziOtbx2MC4753OIUYCDUYmHVyGt
        JU6INbGsuDL3EKMEB7OSCO9sF6AQb0piZVVqUX58UWlOavEhRmkOFiVx3kmsV2OEBNITS1Kz
        U1MLUotgskwcnFINjHt0a4365teerfWYtKMz5evZVl/f5n01u75ODarY7tBcGDWv75aECr+f
        zvrEhYvu69YHCP1JeRNiM8eg592B4+uCj7EnrjWSebTgW9Wd9LeGp8Ikv77yMo7gDYiTehUl
        vMdz6pSF67pCSyMX9bXMyHCz3Tf1nvxb3gqWtBnzZ73xbLCfOWtCgRJLcUaioRZzUXEiAEfh
        BmLfAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSvO77ipY4g+7PvBbvuqazWSz5/pHN
        Ys61PmaLbevamS2ObXrK5MDq0bdlFaPH501yAUxRXDYpqTmZZalF+nYJXBm7GsIKVnJWtPWc
        YWtg3MbexcjJISFgIvH41HImEFtIYDejxOW7AhBxCYkzk9+yQtjCEiv/PQeq5wKq+cQosevQ
        RxaQBJuAusSvhzvAbBEBZYln+w4DDeLgYBZIlTg4lxckLCxgK/Fr6TtmEJtFQFVi5rPPYHt5
        BZwl9j98zggxX07i5rlO5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSH
        g5bWDsYTJ+IPMQpwMCrx8CqktcQJsSaWFVfmHmKU4GBWEuGd7QIU4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGhm9YQjcN+2hF6Jym8srq1nN7yfZjMz
        /f6pjZF6bvdYswU3Wa8+OKmQX/7DhudlWxIPOOdNcV9z0uza7sOb0vzFgmuOKZhdm3TB8suB
        FbbfnjVLV3WeuuRjcnVpsl9Mb7XejJVsWfdXiphGuO55OyFTfobETIlTPNePXdHgF7txsOi7
        3XqDEhUlluKMREMt5qLiRABJMmJNAwIAAA==
X-CMS-MailID: 20200401112015epcas5p10545143f69c22449f559818476845cc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200401112015epcas5p10545143f69c22449f559818476845cc5
References: <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds validation of net key index, which will be
used to send message to nodes. Return error in case net key index
is not valid. This avoids message encryption using device key
and further processing of the message.
---
 mesh/model.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/model.c b/mesh/model.c
index 9455833..6cc1dc5 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -546,6 +546,7 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 	uint8_t dev_key[16];
 	uint32_t iv_index, seq_num;
 	const uint8_t *key;
+	struct keyring_net_key net_key;
 	uint8_t *out;
 	uint8_t key_aid = APP_AID_DEV;
 	bool szmic = false;
@@ -578,8 +579,16 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		}
 
 		net_idx = appkey_net_idx(node_get_net(node), app_idx);
+		if (net_idx == NET_IDX_INVALID) {
+			l_debug("no net key for (%x)", net_idx);
+			return false;
+		}
 	}
 
+	if (!keyring_get_net_key(node, net_idx, &net_key)) {
+		l_debug("no net key for (%x)", net_idx);
+		return false;
+	}
 	l_debug("(%x) %p", app_idx, key);
 	l_debug("net_idx %x", net_idx);
 
-- 
2.7.4

