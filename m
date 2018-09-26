Return-Path: <SRS0=Mlcw=MI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFFFC43382
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A425421547
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z4O0Cde2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A425421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeI0ASn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:18:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56004 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI0ASn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 20:18:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8QHsQu2091083;
        Wed, 26 Sep 2018 18:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=prpVOI8pNdzYFDZw8b2AaUxxu6KYQ8BuAKZQsvONhZs=;
 b=z4O0Cde20fgalXXF4LNiIbhk5Liv1VTCf5DL4DlQgmh165vZNP9YzoMlEbF1EvVujaeE
 ls8GJAjS8gTIU8qoRGS9+xbZsCynj7BrGXzlvYDRlXlcobQZvhhDw7j6kBhF6mrPaHY7
 5FzWuG75BglejUZ5X4BhAu8hgpxvpIgL7cMoxnmXNqBlNaTR8LSOm+x0okELbj4tCjZM
 p0IMQXZY4B7EMeNHKkDokXQUVJ6N1n9SKeFG9sqFRoeC5a5C2LIoLYsKTD/SCoRTaB5t
 Ade0mhRHfPdGIVaB8A+FeUoyeUdi62xwyfdTkdfIEWbi89OMdygsGV8WetU1YDcPiWBz hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5tmagx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 18:04:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8QI4Q9O003312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 18:04:26 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8QI4QBZ007258;
        Wed, 26 Sep 2018 18:04:26 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Sep 2018 11:04:25 -0700
Date:   Wed, 26 Sep 2018 21:04:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bjorn.andersson@sonymobile.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver
Message-ID: <20180926180419.GA16656@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9028 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=709
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260167
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Bjorn Andersson,

The patch 1511cc750c3d: "Bluetooth: Introduce Qualcomm WCNSS SMD
based HCI driver" from Aug 12, 2016, leads to the following static
checker warning:

	drivers/bluetooth/btqcomsmd.c:164 btqcomsmd_probe()
	warn: 'btq->acl_channel' isn't an ERR_PTR

drivers/bluetooth/btqcomsmd.c
   149  static int btqcomsmd_probe(struct platform_device *pdev)
   150  {
   151          struct btqcomsmd *btq;
   152          struct hci_dev *hdev;
   153          void *wcnss;
   154          int ret;
   155  
   156          btq = devm_kzalloc(&pdev->dev, sizeof(*btq), GFP_KERNEL);
   157          if (!btq)
   158                  return -ENOMEM;
   159  
   160          wcnss = dev_get_drvdata(pdev->dev.parent);
   161  
   162          btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
   163                                                     btqcomsmd_acl_callback, btq);
   164          if (IS_ERR(btq->acl_channel))
   165                  return PTR_ERR(btq->acl_channel);

The qcom_wcnss_open_channel() returns error pointers if the CONFIG is
disabled, otherwise it returns NULL on error.  That seems like a design
mistake to me...  Anyway, it leads to a bug here.

   166  
   167          btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
   168                                                     btqcomsmd_cmd_callback, btq);
   169          if (IS_ERR(btq->cmd_channel))
   170                  return PTR_ERR(btq->cmd_channel);
   171  
   172          /* The local-bd-address property is usually injected by the

regards,
dan carpenter
