Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD5C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91072074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 19:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vHoHcJ/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCXT23 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:28:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52310 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgCXT23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 15:28:29 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200324192826epoutp011dce9e0f11e9b618bf6a5fe14598448c~-VCPT8gHK1148511485epoutp01G
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200324192826epoutp011dce9e0f11e9b618bf6a5fe14598448c~-VCPT8gHK1148511485epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585078106;
        bh=UosWNyuHaPk4Bz/2D9N8H1YlkIJlkCEOvkf6aLdL38M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vHoHcJ/jsmu4A6nJVR5ZPhpR/J3blaITM1nKb5SQL/G5AHZ//PTsYkufNwO90mQg0
         UsgAJGnJ4SKsXdG59T3QWGq+AuF+UlpoaOTHzeGKqblbvvR+BRqOYLPaMTK208Y0DD
         oVmYy9gnvinr1Flm7VkGYehCdixcRu9flmL6YkF8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200324192826epcas5p39987c58a9cb8dc9f7bdadb2278da8b0d~-VCOxYwuB0868108681epcas5p3S;
        Tue, 24 Mar 2020 19:28:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.192]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48n1WD6L03zMqYkV; Tue, 24 Mar
        2020 19:28:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.DD.04778.75F5A7E5; Wed, 25 Mar 2020 04:28:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200324192821epcas5p3e756863feafcf1f8eab993a237c19521~-VCKMBvfg0624506245epcas5p3H;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200324192820epsmtrp1961d812e08ab2e4e306ae978c128a030~-VCJOoHlM3078230782epsmtrp1G;
        Tue, 24 Mar 2020 19:28:20 +0000 (GMT)
X-AuditID: b6c32a4a-353ff700000012aa-bd-5e7a5f572d47
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.2A.04158.45F5A7E5; Wed, 25 Mar 2020 04:28:20 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200324192819epsmtip1d19a7a706f8c31391f3b15b6943445a1~-VCImRIZ-1049610496epsmtip1F;
        Tue, 24 Mar 2020 19:28:19 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     s.syam@samsung.com, Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Add mesh agent cleanup to mesh cleanup
Date:   Wed, 25 Mar 2020 00:57:15 +0530
Message-Id: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7bCmpm54fFWcQf8rDYs51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgisqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdS
        yEvMTbVVcvEJ0HXLzAHaoaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQq0CtO
        zC0uzUvXS87PtTI0MDAyBapMyMmY+echa0GTQMWNtxfZGhhX8HYxcnBICJhIzGvg62Lk4hAS
        2M0oceRTExOE84lR4v/vr8wQzjdGiZuHpgJlOME6Fu5qYQSxhQT2Mkr8nhABUdTBJHFq1w6w
        BJuAscT5m6/AGkQElCWe7TsMZjML2Esc+fGdBcQWFnCU+HrhO1g9i4CqxKTmFmYQm1fAQ+LG
        u3csEMvkJG6e6wS7QkLgLKvE+jXTGCESLhIdHy4zQ9jCEq+Ob2GHsKUkXva3QdndjBK737hC
        NE9hlLj3AuQKkKftJSa84AcxmQU0Jdbv0oe4jU+i9/cTqApeiY42IYgpChKrpk6E+l1MYt30
        L1DTPSTm7n/LDgmHWIkn+/awTmCUmYUwdAEj4ypGydSC4tz01GLTAqO81HLkqNnECE4tWl47
        GJed8znEKMDBqMTDq/GwMk6INbGsuDL3EKMEB7OSCO/m1Io4Id6UxMqq1KL8+KLSnNTiQ4ym
        wDCbyCwlmpwPTHt5JfGGpkZmZgaWBqbGFmaGSuK8k1ivxggJpCeWpGanphakFsH0MXFwSjUw
        skgdtedNfX5kz5KYPhemP60TLX3Ys1/pH7ww5el+m5sT5MRXfmthMXdeZfJOiHt7WUrn3u+7
        Nosq/vrygIGRVbDg4K9Wd61VE+MbFV877tigvdD48oKLnPYvbXyFrq05ft444+fHJ5tLvpWk
        rMkM+HBd8r3bnjg+B67khomej51j5jj8iLD5q8RSnJFoqMVcVJwIABS2zeFDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSnG5IfFWcQfNuFos51/qYLf4vvcVu
        MWnfBxYHZo++LasYPT5vkgtgiuKySUnNySxLLdK3S+DKmPnnIWtBk0DFjbcX2RoYV/B2MXJy
        SAiYSCzc1cLYxcjFISSwm1Fi+epOZoiEmMSbFSfYIWxhiZX/nrNDFLUxSVx9u5MJJMEmYCxx
        /uYrMFtEQFni2b7DYDazgKPEpyvz2EBsYSD764XvjCA2i4CqxKTmFrAFvAIeEjfevWOBWCAn
        cfNcJ/MERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA0BLawfjiRPxhxgF
        OBiVeHg1HlbGCbEmlhVX5h5ilOBgVhLh3ZxaESfEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/
        WKSQQHpiSWp2ampBahFMlomDU6qBUW/h8VU3Dng897rmKiZy/3mNbfwptnU8l/WE5Quqzq/f
        aWKdEGxUm2Ms2Plg1+ffCloi6SGlFw54fzr8JPOpp4v0XW8H1YNbjD20cjtO17OcThVfUfg6
        Xfkzg1F6vuOX6x0rvyy090gu/xojt8xOgTOrpfVU3auHbZkXbh06/JK5592hNz3mSizFGYmG
        WsxFxYkAVPMA4PwBAAA=
X-CMS-MailID: 20200324192821epcas5p3e756863feafcf1f8eab993a237c19521
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200324192821epcas5p3e756863feafcf1f8eab993a237c19521
References: <CGME20200324192821epcas5p3e756863feafcf1f8eab993a237c19521@epcas5p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

Freed agent completely in agent_free(). Removed agent from queue
after app disconnects in provisioner case. Linked agent to
join_pending so that agent gets freed after every join call.
Added mesh_agent_cleanup in mesh_cleanup to clear and free
agents queue.
---
 mesh/agent.c   | 3 ++-
 mesh/manager.c | 1 +
 mesh/mesh.c    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 3ab3893a1..ec49c37d0 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -205,6 +205,7 @@ static void agent_free(void *agent_data)
 
 	l_free(agent->path);
 	l_free(agent->owner);
+	l_free(agent);
 }
 
 void mesh_agent_remove(struct mesh_agent *agent)
@@ -212,8 +213,8 @@ void mesh_agent_remove(struct mesh_agent *agent)
 	if (!agent || !l_queue_find(agents, simple_match, agent))
 		return;
 
-	agent_free(agent);
 	l_queue_remove(agents, agent);
+	agent_free(agent);
 }
 
 void mesh_agent_cleanup(void)
diff --git a/mesh/manager.c b/mesh/manager.c
index e4a7deaeb..0b6511b4a 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -92,6 +92,7 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	initiator_cancel(add_pending);
 	add_pending->disc_watch = 0;
 
+	mesh_agent_remove(add_pending->agent);
 	free_pending_add_call();
 }
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 6d2f86b6d..caabab508 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -336,6 +336,7 @@ void mesh_cleanup(void)
 	l_queue_destroy(pending_queue, pending_request_exit);
 	node_cleanup_all();
 	mesh_model_cleanup();
+	mesh_agent_cleanup();
 
 	l_dbus_object_remove_interface(dbus_get_bus(), BLUEZ_MESH_PATH,
 							MESH_NETWORK_INTERFACE);
@@ -480,6 +481,7 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 	}
 
 	join_pending->node = node;
+	join_pending->agent = agent;
 	num_ele = node_get_num_elements(node);
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
-- 
2.17.1

