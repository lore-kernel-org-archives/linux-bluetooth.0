Return-Path: <SRS0=4NR/=SL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE90C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 20:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3F20857
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 20:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="QwpsU5JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDIUas (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:30:48 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:38808 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbfDIUar (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 16:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1554841831; x=1586377831;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kCeMKjs6DvYf0Ns8VXgjbISlLtYD3A10Jv4O5SdBypA=;
  b=QwpsU5JK8WY5pB5NPX5YIKPnf8TiM0IJpBSEF0MKdOR/TSkSgRASPLdP
   pPoVF5jNVWFFda3lfs5XcgejPFS62zHhHxL5lzWpC9JojEuKqUyJ4Al6K
   LKAI/jPZb1WoqsbdkVA3i9rOdxTmAd3UNNPC4gLw6LJWNX3k+l8dRAA1I
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FaAQBv/6xchyeV50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYJoEYEDMYx/pSiBZw4BASMLhD6FYyI4EgEBAwEBCQEBAQECAQECEAE?=
 =?us-ascii?q?BAQgNCQgpIwyCOiIcTWsBAQEBAQEjAg1mFig0CxIBPmgBBA4NGoMAAYF1D6F?=
 =?us-ascii?q?3PQJvgQGJBwEBAYIehDEBhXsFgTCEX4ZoghaIcgESAWyFFAOKZpsgBwKCBYU?=
 =?us-ascii?q?uUYt4IoF2AZJokXWNWwIEAgQFAhWBZoEHcXCDPYIjiC6Fej8BAY5fgR+BIAE?=
 =?us-ascii?q?B?=
X-IPAS-Result: =?us-ascii?q?A2FaAQBv/6xchyeV50NlHAEBAQQBAQcEAQGBZYJoEYEDM?=
 =?us-ascii?q?Yx/pSiBZw4BASMLhD6FYyI4EgEBAwEBCQEBAQECAQECEAEBAQgNCQgpIwyCO?=
 =?us-ascii?q?iIcTWsBAQEBAQEjAg1mFig0CxIBPmgBBA4NGoMAAYF1D6F3PQJvgQGJBwEBA?=
 =?us-ascii?q?YIehDEBhXsFgTCEX4ZoghaIcgESAWyFFAOKZpsgBwKCBYUuUYt4IoF2AZJok?=
 =?us-ascii?q?XWNWwIEAgQFAhWBZoEHcXCDPYIjiC6Fej8BAY5fgR+BIAEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2019 15:30:30 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x39KHg2m066517
        for <linux-bluetooth@vger.kernel.org>; Tue, 9 Apr 2019 16:30:46 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2rppbrn150-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2019 16:30:46 -0400
X-LoopCount0: from 10.166.132.56
X-IronPort-AV: E=Sophos;i="5.60,330,1549951200"; 
   d="scan'208";a="339794727"
From:   <YouRen.Chen@dellteam.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     <Jared.Dominguez@dell.com>
Subject: Pairing failure with BLE 4.0
Thread-Topic: Pairing failure with BLE 4.0
Thread-Index: AdTvEP1ogHQ4ULOIQH6wZs4vol6S/g==
Date:   Tue, 9 Apr 2019 20:30:44 +0000
Message-ID: <87ee5fc2175747e1a7cf5b50bad819d4@ausx13mpc124.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=557 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090128
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Recently, I posted a bug report regarding authentication failures when
pairing with BLE 4.0 devices. I was told to raise this issued to the=20
Bluetooth mailing lists and I hope this is the correct email to contact.
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1822633

Regards and thank you,

You Ren (Joey) Chen
