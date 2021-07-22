Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B4DC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F9D61264
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGVFSq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:18:46 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39483 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGVFSp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:18:45 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210722055919epoutp039cda9ee455a2d7f85d95c7fc68e3929e~UB3PaMb1d0618706187epoutp03G
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210722055919epoutp039cda9ee455a2d7f85d95c7fc68e3929e~UB3PaMb1d0618706187epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933559;
        bh=wqBGBxgujq2UOFSBiawtUUa/tRLLnDTUyto0ZSXi3J4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EawPEiRYS+O3OS8To5U6GrdV4YFFxb3PEMYTP2s9nwqLDR9GrQxnFtj8Kgy/7Xomj
         +pEld/bo1YZFIm06hNMcXGqZPnnXiNWtoQSETxYeHrZBgg2/sNAJPlV4eKzm9Qk1XV
         jiUjjUnlZ6En09JP0ORzZRbxcOcZWrFO30+//QHI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210722055918epcas5p1338b6e723216dbaa4e09145b5d697433~UB3OmnLhy2340323403epcas5p1z;
        Thu, 22 Jul 2021 05:59:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.42.55882.63909F06; Thu, 22 Jul 2021 14:59:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210722052737epcas5p1682a7f66d42470c3cdb8dd04160912ab~UBbkI3hFo1801618016epcas5p1T;
        Thu, 22 Jul 2021 05:27:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722052737epsmtrp1258bcceab1e3665681c5da621b518079~UBbkIMb6j2024420244epsmtrp1Z;
        Thu, 22 Jul 2021 05:27:37 +0000 (GMT)
X-AuditID: b6c32a49-4db99a800001da4a-38-60f90936cbd5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.F8.08289.9C109F06; Thu, 22 Jul 2021 14:27:37 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722052736epsmtip252176e43decb98afac18d68726a4d00b~UBbjZBmRj0848808488epsmtip2H;
        Thu, 22 Jul 2021 05:27:36 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 0/7] Support for Adapter's Default PHY Configuration
Date:   Thu, 22 Jul 2021 10:56:33 +0530
Message-Id: <20210722052640.5863-1-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmhq4Z588Egw8dghZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGVsbZ3IXPCVo2Lin/0sDYwL2bsYOTkk
        BEwkZn+Yy9zFyMUhJLCbUWLpufOsEM4nRol5q+6xgVQJCXxmlPi52Bam4/j6t0wQRbsYJf70
        f2eB6/jY+w2sg01AU+L1xy9MILaIgLLEs32HwWxmAV2JM+/XgdUIC3hJHOs+CrSOg4NFQFWi
        4bgriMkrYCXRv7IEYpe8xOoNB8CukxD4zSYx7dpyRoiEi8TWczugbGGJV8e3QL0jJfGyv40d
        oqGZUWLH5o1QTg+jxIMf3WwQVfYS55qegS1mBjp0/S59iLCsxNRT66Du5JPo/f2ECSLOK7Fj
        HoytIrFhVSfcso/HFjJD2B4SHyasZAIZKSQQK3Hvq8kERtlZCAsWMDKuYpRMLSjOTU8tNi0w
        zEst1ytOzC0uzUvXS87P3cQIjlctzx2Mdx980DvEyMTBeIhRgoNZSYRXpehrghBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe9niglEB6YklqdmpqQWoRTJaJg1OqgWkJ16qu3Rq/jIXKkhWtKxd2
        7l6ecu+dx7x3Sn6ng28ZHbtj3T7ljkYxT8FSyffXItbNm9un+tTCp/K/h25esanqBY/qo1OX
        ePz8v+i26Fan4i8PeQqXK+0ViAlaqPV9d5TPtAdCB3TsrNV9K/eeb+i6tURy17XXnhW98930
        t57Z57Hd/XiVTO6/lbWXN9Ro65/xu/vuXqdZaeyGtvwlJ412nBHfrfNcYf2r1rqr25+ZXPer
        tAi68/DyTRfBhnTl5eIrXgcEX3o6I8R1gc5B8aiACSz+p+Yo6hyYrsI1V/TVc2kPXqX/h1k2
        Hc3kf7nKUOnx7LP7svp1ar8e/P12V8TLR1oTHn+V/rhU1Cqg8tNbJZbijERDLeai4kQAm+JC
        BUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJMWRmVeSWpSXmKPExsWy7bCSvO5Jxp8JBmd3sVjcWW1tMedaH7PF
        tnXtzA7MHn1bVjF6fN4kF8AUxWWTkpqTWZZapG+XwJWxtXUic8FXjoqJf/azNDAuZO9i5OSQ
        EDCROL7+LVMXIxeHkMAORokJ+2cydzFyACWkJB4v04GoEZZY+e85O0TNB0aJOZ9XM4Ek2AQ0
        JV5//AJmiwgoSzzbdxjMZhbQl3h64TojiC0s4CVxrPsoK8hMFgFViYbjriAmr4CVRP/KEojx
        8hKrNxxgnsDIs4CRYRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRrDntbR2MO5Z9UHv
        ECMTB+MhRgkOZiURXpWirwlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MIXfn7gke+tP230ZpxpF2PQ2nDuwT9GnI0fQefeUp2m5b1uyP8xLfO7II7XF
        8nXumXuOZ7qOsLyMOF32cpe6WeP5+yxSFTOsFU7ufLrp1oYTcdm2i1bIHHl4iUn7ZIjJw/qS
        g2fNrf4Efd+xQfgYf2fg0studzvX5TdHHnrzsOzcmfr8d7tFTlZd+imwtYf7CX/p4+qv95z/
        +txvOP9x8uMK6SS37TrFwXb3mRcXqah/cbe0aFmzb+Wn2XE3fi3+cPqPVWKKxERzXguPmPwJ
        S5a+cWGv/T1Vt5dNZxlX48z06/9fX94c6sg+596UxV/OrTdWv13W67VgymOlZQbvLiYudOFb
        cmOb471drRd//RcwUWIpzkg01GIuKk4EAGFkyN5rAgAA
X-CMS-MailID: 20210722052737epcas5p1682a7f66d42470c3cdb8dd04160912ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722052737epcas5p1682a7f66d42470c3cdb8dd04160912ab
References: <CGME20210722052737epcas5p1682a7f66d42470c3cdb8dd04160912ab@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This patch set contains a proposed approach to enable
user to get/set adapter's default PHYs.

It will introduce two new adapter properties:
1. "SupportedPhyConfiguration": to get PHYs supported
by the adapter.
2. "PhyConfiguration": The user can use this property
to get/set the default adapter PHYs which will be used
in all subsequent connections.

These properties are based on "MGMT_OP_SET_PHY_CONFIGURATION"
and "MGMT_OP_GET_PHY_CONFIGURATION" MGMT commands.

Ayush Garg (7):
  doc/adapter-api: Add SupportedPhyConfiguration property
  doc/adapter-api: Add PhyConfiguration property
  adapter: Add support for get/set phy configuration property
  adapter: Add support for the get supported phy property
  adapter: Add support for PHY Configuration Changed event
  client: Add support for get/set PHY configuration in bluetoothctl
  adapter: Save PHY Configuration in storage and read it at init

 client/main.c       |  39 +++++
 doc/adapter-api.txt |  35 +++++
 src/adapter.c       | 355 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 429 insertions(+)

-- 
2.17.1

