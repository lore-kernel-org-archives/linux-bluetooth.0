Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92343C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7F52467F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 12:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QnnCvCXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAVMQX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:16:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:37389 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgAVMQW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 07:16:22 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200122121619epoutp02d67edaa5fa8ee01c827617f384e691bf~sNJQS9-h42902029020epoutp02T
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 12:16:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200122121619epoutp02d67edaa5fa8ee01c827617f384e691bf~sNJQS9-h42902029020epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579695379;
        bh=yBijimB8hgo0iZdZD4SM72f54+99FzN2+bEutNj9OU8=;
        h=From:To:Subject:Date:References:From;
        b=QnnCvCXaLsVM3SH8OweOLCyxtxCtpgoc656r3K/JlxJHAbcVAJRI8DHrOD2yTMSVO
         X3M1CO+/Lo7jRQEeihqsmLlNNxWTR9w7Ickz7et/whRx+9MagoQQzo3hcmM4nPXmiT
         Yob8OMVKJGmH+ci1nB8U8oqIh7laJQidEP1EfsUQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200122121619epcas5p448dc69e1afb07a76dd5b111941915756~sNJQHLnwN0764807648epcas5p4b
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 12:16:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.4C.19629.31D382E5; Wed, 22 Jan 2020 21:16:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200122121618epcas5p1c87cda317c786f71497ad61237843227~sNJPRvVnu1014110141epcas5p1T
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 12:16:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200122121618epsmtrp1b276df5f9ecf7ae832cfe0450caa7a59~sNJPRR5Uk2932129321epsmtrp1L
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 12:16:18 +0000 (GMT)
X-AuditID: b6c32a4b-345ff70000014cad-c4-5e283d13dd3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.D1.10238.21D382E5; Wed, 22 Jan 2020 21:16:18 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200122121618epsmtip1c784af21120be9725ec3a351abdef5b3~sNJO7JCkk1486414864epsmtip1g
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 12:16:18 +0000 (GMT)
From:   Shaunak Soman <shaunak.01@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] mesh: Fix provisioning agent method call failure
Date:   Wed, 22 Jan 2020 17:46:10 +0530
Message-Id: <1579695370-12779-1-git-send-email-shaunak.01@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmlq6wrUacwe0eZYs51/qYHRg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mq4/+8yY8FB9orpbXfYGhgnsXUxcnJICJhIrLk6kbWLkYtDSGA3
        o8SXe30sEM4MJol3B2ZCZeYwSWx6sJMZpmXzg/9sEIm9jBLvr7xhh3DWMUmsaljHBFLFJqAj
        8eL+WrAOEQFliWf7DgPFOTiEBVwl2r8qgYRZBFQlnv1vBLuDV8BNYtXlaVAL5CRunutkBpkp
        IbCKVWJC5xOoY10kfh3eCmULS7w6voUdwpaSeNnfxg7RMJlR4smXNUwQzmpGie6Nzxkhquwl
        nm6ayw5yBbOApsT6XfogYWYBPone30/AjpMQ4JXoaBOCqFaQWDV1IhOELSaxbvoXqF0eEg97
        t4AdKiQQK3H4aD/TBEbpWQhDFzAyrmKUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECI4z
        Le8djJvO+RxiFOBgVOLhdbDUiBNiTSwrrsw9xCjBwawkwrugSTVOiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO8k1qsxQgLpiSWp2ampBalFMFkmDk6pBkZt6+tt4j9m7fwYFVsr6HC47M8cSX1f
        JxOPJMPfDxd0bzy8MLOk/FtM3dtTN48//LlLz3yjj4+sCoMcl7V5kUns51LL7YtLAxxOCDBt
        NZCeb/aGS7bRKGO1rUGS/dzvXw2WarB598gFZBqcnZS/e1a6Ahd/07vTpi+ZLL86rvxZb1yV
        1Bnfr8RSnJFoqMVcVJwIAOAFasyvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJMWRmVeSWpSXmKPExsWy7bCSnK6QrUacwZ0ObYs51/qYHRg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mq4/+8yY8FB9orpbXfYGhgnsXUxcnJICJhIbH7wH8jm4hAS2M0o
        8ePTF6iEmMSbFSfYIWxhiZX/nrNDFK1hklg4ZScrSIJNQEfixf21zCC2iICyxLN9h5m6GDk4
        hAVcJdq/KoGEWQRUJZ79bwSbySvgJrHq8jRmiJlyEjfPdTJPYORewMiwilEytaA4Nz232LDA
        MC+1XK84Mbe4NC9dLzk/dxMj2JNamjsYLy+JP8QowMGoxMPrYKkRJ8SaWFZcmXuIUYKDWUmE
        d0GTapwQb0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjLLd
        195GMRg+1BMMOfNDydGw/FLyN/vyCek3lj75//D52qvtCmLBlsk6k0tl2xh6Q/buMr59/q+e
        WsOSM3ENrIzqgauayt6V/FI6r/vhIbtWvaba/2qG8wZdt4PTk4puur14HslhxHryuuykG5/3
        pVxf9+b5oXjP7blrtt64eiE8hun7snb7yUosxRmJhlrMRcWJAH/rJZDgAQAA
X-CMS-MailID: 20200122121618epcas5p1c87cda317c786f71497ad61237843227
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200122121618epcas5p1c87cda317c786f71497ad61237843227
References: <CGME20200122121618epcas5p1c87cda317c786f71497ad61237843227@epcas5p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Provisioning agent interface methods PublicKey, PrivateKey and
Cancel do not accept any parameters. So, while invoking them
explicitly set the parameters to "".
---
 mesh/agent.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mesh/agent.c b/mesh/agent.c
index 9f9399f..3ab3893 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -515,6 +515,8 @@ static int request_key(struct mesh_agent *agent,
 						MESH_PROVISION_AGENT_INTERFACE,
 						method_name);
 
+	l_dbus_message_set_arguments(msg, "");
+
 	l_debug("Send key request to %s %s", agent->owner, agent->path);
 
 	l_dbus_send_with_reply(dbus_get_bus(), msg, key_reply, agent, NULL);
@@ -649,5 +651,8 @@ void mesh_agent_cancel(struct mesh_agent *agent)
 	msg = l_dbus_message_new_method_call(dbus, agent->owner, agent->path,
 						MESH_PROVISION_AGENT_INTERFACE,
 						"Cancel");
+
+	l_dbus_message_set_arguments(msg, "");
+
 	l_dbus_send(dbus, msg);
 }
-- 
2.7.4

