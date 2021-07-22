Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC51FC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF80560FE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGVFTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17872 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVFTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:14 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210722055949epoutp0229de27f031a38346151c67da00b43d5e~UB3rJB9JD1351313513epoutp02P
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210722055949epoutp0229de27f031a38346151c67da00b43d5e~UB3rJB9JD1351313513epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933589;
        bh=YWWW3sFxlEYPqnWHJ4NPzTzuKq32Xo6uaUJ17t+OrQo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cGqfPiDWOWGHYR2zSB3JrrPFma6j+SmDY1OxA5xYGG9r3JjRyvBQcup9nl1CA3qCA
         t4YKmpdLoetCUNXZ1tOao/XlEf3AOFPFncjroKHCIgeBqODrpTDRdMu+uTllhPPByH
         9+VkdHpRFWuk4/QT2zxiH798oUmkp8yodz4s1a68=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055948epcas5p45036c8bced718ccc560b0f7a1682a5e6~UB3q0szIY2203722037epcas5p4Q;
        Thu, 22 Jul 2021 05:59:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.92.55882.45909F06; Thu, 22 Jul 2021 14:59:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053858epcas5p2ecff386b264d4d8578a0ee454f898880~UBleTpePT0528705287epcas5p2f;
        Thu, 22 Jul 2021 05:38:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722053858epsmtrp2150fd77aebb1ad08a09a3220016de41c~UBlePR5aG0680906809epsmtrp2o;
        Thu, 22 Jul 2021 05:38:58 +0000 (GMT)
X-AuditID: b6c32a49-f65ff7000001da4a-9b-60f909546d51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.1A.08289.27409F06; Thu, 22 Jul 2021 14:38:58 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053857epsmtip2a77a516c513e769d0aafe318283b259a~UBldVNew11391413914epsmtip29;
        Thu, 22 Jul 2021 05:38:57 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH 0/4] Bluetooth: Support for LE Set Preferred PHY
Date:   Thu, 22 Jul 2021 11:08:39 +0530
Message-Id: <20210722053843.6691-1-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCmum4I588Eg609ahZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGW86O9mLrjOXnFhykHmBsZmti5GDg4J
        AROJX9/1uxi5OIQEdjNKLFp2ih3C+cQosf9pOwuE85lR4u7OrUxdjJxgHZe3bmCGSOxilFi8
        4jZCy6WeJcwgVWwCmhKvP34B6xARUJZ4tu8wmM0soCtx5v06NhBbWMBBYsqz9WBxFgFVicVP
        NoP18gpYSRzuW8kMsU1eYvWGA2DbJAR+s0k8XrucFSLhIrF76i12CFtY4tXxLVC2lMTnd3vZ
        IBqaGSV2bN7IDuH0MEo8+NHNBlFlL3Gu6RkrKAiYgU5dv0sfIiwrMfXUOqhL+SR6fz+B+plX
        Ysc8GFtFYsOqTrhlH48tZIaEpIfE3WU6IGEhgViJGyfesE5glJ2FsGABI+MqRsnUguLc9NRi
        0wLDvNRyveLE3OLSvHS95PzcTYzgmNXy3MF498EHvUOMTByMhxglOJiVRHhVir4mCPGmJFZW
        pRblxxeV5qQWH2KU5mBREudljwdKCaQnlqRmp6YWpBbBZJk4OKUamHr+1syN1zF6eF5xuuk0
        3ptnkz2Cl2mlr2VdflTWTMTsR8mEprDAF1Ons+ct4XLLUfH+nD5jXu9WY02fvysiNKSufeLc
        51gYIsRyYJrDc9e0P4Zzb5u9Wc3gf3XRdhvxmpYb1i2rbrYfENjV7HtHlP/8eaWM1jd3uD7E
        feNj35Uz93FTV8Xn74KGZ9nffDVSPWoq8U1p1/9PURwRyacv/v5cc+XZidoL8Y8WTp2cunDJ
        M5Z8r0lie11vPq19t+m+X4CwqM7bSf84D9//LbJu7V/1zOOnU96wFKtELw34Vp2qO2Xxq90z
        0pYb1PvqnDh+eYk3B9PPPlW9qP97r+7N2zt74bPpD33USrNitA8sEXRVYinOSDTUYi4qTgQA
        RTeOJEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJMWRmVeSWpSXmKPExsWy7bCSvG4Ry88EgxeNQhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGW86O9mLrjOXnFhykHmBsZmti5GTg4J
        AROJy1s3MHcxcnEICexglNjf+Yi1i5EDKCEl8XiZDkSNsMTKf8/ZIWo+MEosW9rOCJJgE9CU
        eP3xCxOILSKgLPFs32Ewm1lAX+LphetgNcICDhJTnq0Hi7MIqEosfrKZGcTmFbCSONy3khli
        gbzE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iRHsfS2tHYx7Vn3Q
        O8TIxMF4iFGCg1lJhFel6GuCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
        C1KLYLJMHJxSDUzrruddvXn1mNLVm0e8uI38RSSVdh3bqu1845vrwXw1S+/P31iutyS37zP3
        +Wvf7K2yabH+ISnLdoF6Je+0WVOqFoi65y9xbzYzndum2M4fnKf39UalsaDm1yUn32w8f+vw
        j4C5k/1Yp01LTfm3izUtXKT/0CqWGGYLq0cbteyZfrItKrYTaOt4XGlhk3v08G/ebmuhi2+O
        vlwxgaU9//199TBNkVzf8yaTZDlTt90RTrhjfV/tbNmEqSVa56av+TTfRdLxccyhy0yL8vWe
        KIXy629jPL1hWfo50R2vvp7ptooKvm3944yVFOPN+Qs4xcIdNnz/2cSw2VPgm3uy41kHVRU7
        7g1f3/WnpAilOiixFGckGmoxFxUnAgCc1XC/bQIAAA==
X-CMS-MailID: 20210722053858epcas5p2ecff386b264d4d8578a0ee454f898880
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722053858epcas5p2ecff386b264d4d8578a0ee454f898880
References: <CGME20210722053858epcas5p2ecff386b264d4d8578a0ee454f898880@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This patch set fixes some minor bugs and adds support for
BT 5.0 PHY based HCI command "HCI_OP_LE_SET_PHY" to request
controller to change connection specific PHY settings
(2M PHY, coded PHY etc.).

Ayush Garg (4):
  Bluetooth: Fix incorrect parsing of LE_PHY params
  Bluetooth: Implement BT_PHY setsocket option
  Bluetooth: Add support for sending LE PHY Update event over mgmt
  Bluetooth: Update LE TX & RX PHYs when connection established

 include/net/bluetooth/bluetooth.h |  7 +++
 include/net/bluetooth/hci.h       | 28 +++++++++++
 include/net/bluetooth/hci_core.h  |  2 +
 include/net/bluetooth/mgmt.h      |  7 +++
 net/bluetooth/hci_conn.c          | 77 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_event.c         | 62 +++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c        | 21 ++++++++-
 net/bluetooth/mgmt.c              | 34 ++++++++++++++
 8 files changed, 220 insertions(+), 18 deletions(-)

-- 
2.17.1

