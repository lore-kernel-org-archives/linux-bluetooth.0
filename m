Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE6C63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00266128A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhGVFUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:20:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49374 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGVFUP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:20:15 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722060050epoutp01bd1b41f14fc192ddf5bb383dc63c76ab~UB4kGrtge2242822428epoutp01S
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722060050epoutp01bd1b41f14fc192ddf5bb383dc63c76ab~UB4kGrtge2242822428epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933650;
        bh=N+dLaKvvsC2xvnB1tNGzWGddUydDkE1My8ujT6jliFM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hqMMLvMnAVgZrFQhclMZkDdu9Dbw67hAQTwbu2BLqGTHxJVarJbRVVWFJhyAZalxN
         oCVPCfgHzqYsWjEhZUvmVC4hvj+Q9HHDBcdowad5ko8XmjNSKSQJpj7IAGAmfrdYtj
         3RwFXaRQMgIETixx/whExfLR+ne5/bZ3DOBc1/lo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722060034epcas5p25edeb4d90044fa746af920e4566d4bec~UB4Vjl7te0866608666epcas5p2L;
        Thu, 22 Jul 2021 06:00:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F2.55882.18909F06; Thu, 22 Jul 2021 15:00:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210722055008epcas5p28da6985b690d3bbc564a5957c1b209f4~UBvOPVhAy1227212272epcas5p20;
        Thu, 22 Jul 2021 05:50:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722055008epsmtrp2c4e52536ccde6f747e7cab47837e4133~UBvOPERDz1175011750epsmtrp2q;
        Thu, 22 Jul 2021 05:50:08 +0000 (GMT)
X-AuditID: b6c32a49-f4fff7000001da4a-76-60f90981e1d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.04.08394.01709F06; Thu, 22 Jul 2021 14:50:08 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210722055007epsmtip1876805a27e4d9ded0b8e4b0041801d17~UBvNb_dDI1031410314epsmtip1h;
        Thu, 22 Jul 2021 05:50:07 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH BlueZ 0/8] Support for connection specific LE PHY
 configuration
Date:   Thu, 22 Jul 2021 11:19:43 +0530
Message-Id: <20210722054951.8291-1-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCmpm4j588Eg3dbjCzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MpoePaeqeAeV8Xk4x2MDYw9HF2MnBwS
        AiYSH29OYOxi5OIQEtjNKHGq8QgbhPOJUaLjzh1WCOcbo8S6WZOZYFoe/znMDJHYyyjx4cpS
        ZriWvrVvmEGq2AQ0JV5//ALWISKgLPFs32Ewm1lAV+LM+3VsILawQKDEvFfHWEFsFgFViY6H
        b8BsXgEriZn//zBDbJOXWL3hANgCCYH/bBL7N3ZAJVwknt5ezwZhC0u8Or6FHcKWkvj8bi8b
        REMzo8SOzRvZIZweRokHP7qhOuwlzjU9A1rHAXSSpsT6XfoQYVmJqafWQV3KJ9H7+wnUz7wS
        O+bB2CoSG1Z1wi37eGwh1EEeEhv/toLVCAnEShz5/4xpAqPsLIQNCxgZVzFKphYU56anFpsW
        GOallusVJ+YWl+al6yXn525iBMetlucOxrsPPugdYmTiYDzEKMHBrCTCq1L0NUGINyWxsiq1
        KD++qDQntfgQozQHi5I4L3s8UEogPbEkNTs1tSC1CCbLxMEp1cBUX3OraPZaC78Zq49muHf2
        OTDv/JVXmC2zM/LPOof9L39wfd2zKyZMPYdfRETqfctm/Q9HgjpW7jsv3JHqFLGownGayK0j
        k1L2Mk3clFEvb5228LTnvScuf8s23uQt76ibx6P6rFd4Tmg604607glp0qXtRtetlMPnVrfa
        zYm8XaBcHHpNzH4lg8hP1ws9O4//2Bute/ZWc/9cj4JmXts1cQeSj3bevHFhY/EcYT8Jn7Ut
        12J1NnB/9ayyNfTZtVjRVr0zlXNOfdGP2d8POc76GHwv+cTr1qWyTAvzFS2FD+fZPOW9srs9
        k2Gvom3UPlfnl0bTL51d+jnUwnjn13/JRTMe7rhwb3XIMj6GEmslluKMREMt5qLiRAA5AhFR
        SgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJMWRmVeSWpSXmKPExsWy7bCSnK4A+88Egz3vhS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MpoePaeqeAeV8Xk4x2MDYw9HF2MnBwS
        AiYSj/8cZu5i5OIQEtjNKHFlVj97FyMHUEJK4vEyHYgaYYmV/56zQ9R8YJS4teUcM0iCTUBT
        4vXHL0wgtoiAssSzfYfBbGYBfYmnF64zgtjCAv4STSevsYPYLAKqEh0P37CC2LwCVhIz//9h
        hlggL7F6wwHmCYw8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBHtfS3MH4/ZV
        H/QOMTJxMB5ilOBgVhLhVSn6miDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs
        1NSC1CKYLBMHp1QD02Kd1PAd//x1Tk3a3G1e8+7+zLVzfVfWyb/5Z/v9OtP2Ui3pbQGuqxwT
        N5xWM+vZP5+1xL7FtsFl84Inh9a/5Z2QPLGmWyWzTYZxY879xvs2Bo/n+iXfCFD//c4xZPHM
        9Ejdbc+Mg31/fF4o5n3H9klY/WXT4PsuT7JF6s6+LTRp81owQ+nwhcWph3N6Vgk/F53yOWrJ
        q4+bfcIi3zP4d1f8u/DzgPON41YfVJdfWbJyrtQRrx0zfAI+/yhnvTTD8BX3l9CLYaU33K9q
        ac/tVK1xV2RKmbbz+aHP8SH/TgirFyrw2p/SffLg5f8UAZOMvUd/hcyI4H74/PPCw7XLpWz0
        TvI78Im/XvxV5pDQa2klluKMREMt5qLiRAD+RDW2bQIAAA==
X-CMS-MailID: 20210722055008epcas5p28da6985b690d3bbc564a5957c1b209f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722055008epcas5p28da6985b690d3bbc564a5957c1b209f4
References: <CGME20210722055008epcas5p28da6985b690d3bbc564a5957c1b209f4@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This patch set contains a proposed approach to enable
user to get the PHYs of a particular LE connection
and to set preferred PHYs for the same on BT 5.0 and
above controllers.

It will introduce a new device property "Phy" which
is based on the L2CAP socket option "BT_PHY".

Note: This patch series is dependent on the the previous patch
series "Support for Adapter's Default PHY Configuration" and
should be applied after it.

Ayush Garg (8):
  doc/device-api: Add Phy property
  doc/mgmt-api: Add support for LE PHY Update Complete event
  btio: Add BT_IO_PHY option to set le phy options
  device: Add support for get/set PHY property
  adapter: Add support for LE PHY Update Complete event
  client: Add support for LE get/set device PHY in bluetoothctl
  device: Save device PHY in storage and read it at init
  monitor: Add support for LE PHY Update event

 btio/btio.c        |  25 ++++-
 client/main.c      |  45 ++++++++
 doc/device-api.txt |  22 ++++
 doc/mgmt-api.txt   |  29 ++++++
 lib/bluetooth.h    |   9 ++
 lib/mgmt.h         |   8 ++
 monitor/packet.c   |  14 +++
 src/adapter.c      |  48 +++++++++
 src/adapter.h      |   1 +
 src/device.c       | 248 +++++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   2 +
 11 files changed, 447 insertions(+), 4 deletions(-)

-- 
2.17.1

