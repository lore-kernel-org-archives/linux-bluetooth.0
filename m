Return-Path: <SRS0=M10/=Z4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70836C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2154D21823
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Dec 2019 04:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dGGKbUP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFEJG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 23:09:06 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30359 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFEJG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 23:09:06 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191206040903epoutp017599e80cc5e3315c9bc6ae2e6962c55f~drLZGU4Y60452804528epoutp01Q
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2019 04:09:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191206040903epoutp017599e80cc5e3315c9bc6ae2e6962c55f~drLZGU4Y60452804528epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575605343;
        bh=D8b3fXY9p3ghBt5uxcATFJqG+c+LG92bM8lbhYjFRdE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dGGKbUP6UzC9WtHarN9pzGx+4+h73QtMmFkyUSoB5I/WDFyonW0XtRuC9HwJi3aan
         KmYM4jGjHsziBk8Y2lzLKjwakXAXBtpjwZYqZZkVn6dJy6oavmpGHVHHuWsJwFLOPb
         BlN5uRBoPnjgkeZ+0WwNVmXGLnFf45hiJBsaigZs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191206040902epcas5p4f190fd196aed29756dce780abfe8ac0a~drLYnTRlm2392223922epcas5p44;
        Fri,  6 Dec 2019 04:09:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.197]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47TfGj4grmzMqYkg; Fri,  6 Dec
        2019 04:09:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.25.19726.D54D9ED5; Fri,  6 Dec 2019 13:09:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac~drLWBlLm73137531375epcas5p2D;
        Fri,  6 Dec 2019 04:09:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206040900epsmtrp2033cba9a103d9dd6349aee4ccf6ef66d~drLWBEad01294412944epsmtrp2F;
        Fri,  6 Dec 2019 04:09:00 +0000 (GMT)
X-AuditID: b6c32a49-7c1ff70000014d0e-ca-5de9d45d5341
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.75.06569.C54D9ED5; Fri,  6 Dec 2019 13:09:00 +0900 (KST)
Received: from SyamLinux.sa.corp.samsungelectronics.net (unknown
        [107.109.107.247]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191206040859epsmtip2f832b1cffd55dee0be839cbcc8820206~drLVmD0Nu1292012920epsmtip24;
        Fri,  6 Dec 2019 04:08:59 +0000 (GMT)
From:   Prathyusha Nelluri <prathyusha.n@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Prathyusha N <prathyusha.n@samsung.com>
Subject: [PATCH 1/1] mesh: Start link establishment timer of 60 sec
Date:   Fri,  6 Dec 2019 09:38:39 +0530
Message-Id: <1575605319-461-1-git-send-email-prathyusha.n@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmpm7slZexBmcXKFnMudbHbPF/6S12
        ByaPvi2rGD0+b5ILYIrKsclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21
        VXLxCdB1y8wBGq+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0KtArTswtLs1L
        10vOz7UyNDAwMgWqTMjJeLjrDGvBR7aKq9vnMjYwXmLtYuTkkBAwkXjTcoGpi5GLQ0hgN6PE
        xrfvmSGcT4wSPxdvYINwvjFK7LuznhmmZdWXr6wQib2MEsfndrNAOB1MEnOPTmIEqWITMJY4
        f/MVE4gtIqAs8WzfYTCbWUBbYtKbmWC2sICzxMKnK8CmsgioSqx7vwEszivgJnFuywGobXIS
        N891gt0kIXCSVeLIzBuMEAkXiRl/XzNB2MISr45vYYewpSQ+v9vLBmF3M0rsfuMK0TyFUeLe
        i8NQDfYSTzfNBWrgALpIU2L9Ln2I4/gken8/YQIJSwjwSnS0CUFUK0ismjoRqlNMYt30L1Cr
        PCR+Nm0HB6SQQKzEnG33WCYwysxCGLqAkXEVo2RqQXFuemqxaYFhXmo5cuxsYgSnFS3PHYyz
        zvkcYhTgYFTi4Z3x+UWsEGtiWXFl7iFGCQ5mJRHedL6XsUK8KYmVValF+fFFpTmpxYcYTYGB
        NpFZSjQ5H5jy8kriDU2NzMwMLA1MjS3MDJXEeSexXo0REkhPLEnNTk0tSC2C6WPi4JRqYJSX
        XVrmKDvP74joCxk/7et3dk2r3HXm+b4X8mHzDWQ2+r6sLuVLCpvnOOvHevU2/fX2M64YXGu5
        w5Djx6L957KA3Rnef7L9RyUF9+ewBTAt3avQZnbHXtAxS8Bshnewyo99tbn7FvlO+3Dt/Fbv
        VYfaBc69+V7zZ9/89wXJczPqlOSvrZrT76rEUpyRaKjFXFScCADn+RNcQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJMWRmVeSWpSXmKPExsWy7bCSvG7MlZexBoffc1nMudbHbPF/6S12
        ByaPvi2rGD0+b5ILYIrisklJzcksSy3St0vgyni46wxrwUe2iqvb5zI2MF5i7WLk5JAQMJFY
        9eUrkM3FISSwm1Fi/qddbBAJMYk3K06wQ9jCEiv/PWeHKGpjkvj3dRkjSIJNwFji/M1XTCC2
        iICyxLN9h8FsZgFtiUlvZoLZwgLOEgufrmAGsVkEVCXWvd8AFucVcJM4t+UAM8QCOYmb5zqZ
        JzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJEex3La0djCdOxB9iFOBgVOLh
        nfH5RawQa2JZcWXuIUYJDmYlEd50vpexQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmk
        J5akZqemFqQWwWSZODilGhhLHe+3P4xx+Hi/Xmq+xuX0967nAtovrF+Uy7JgiZPK9aIt5z4e
        f7Lkq9nSpqWzP0TYrVj/7PXvK9MsV6+8t/r+qbiSN/KSK+Yv3/OsY1/G6nscbwta3u7beyF4
        gfH0gighhsLsQ8+3yRdzrm2fbrL8ienD++dfB00sbdt0wEpsixF7y+5m5Q18dkosxRmJhlrM
        RcWJADr/vtP3AQAA
X-CMS-MailID: 20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac
References: <CGME20191206040900epcas5p2ccb274134dab1154452d6f8d75dfedac@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Prathyusha N <prathyusha.n@samsung.com>

5.3.2 of Mesh Profile Bluetooth specification:
To open a link, the provisioner shall start the link establishment
timer, set to 60 seconds, and then shall start sending Link Open
messages.

On timeout, close indication will be sent. Provisioner cancels the
Link Establishment timer, when the link is open i.e. in pb_adv_tx().
---
 mesh/pb-adv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 27cbc46..c9a2a65 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -458,6 +458,8 @@ bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
 
 	if (initiator) {
 		l_getrandom(&pb_session->link_id, sizeof(pb_session->link_id));
+		pb_session->tx_timeout = l_timeout_create(60, tx_timeout,
+							pb_session, NULL);
 		send_open_req(pb_session);
 	}
 
-- 
2.7.4

