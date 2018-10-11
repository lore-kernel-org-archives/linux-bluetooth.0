Return-Path: <SRS0=Gi1c=MX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07965C32788
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 07:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46742085B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Oct 2018 07:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46742085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fronius.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJKOkG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:40:06 -0400
Received: from mx01.fronius.com ([213.33.117.78]:65416 "EHLO mx01.fronius.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKOkG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Oct 2018 10:40:06 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3A60eguBe07kEQtyaqD21UZtX5lGMj4u6mDksu8pMi?=
 =?us-ascii?q?zoh2WeGdxcW6ZR7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVhsI24?=
 =?us-ascii?q?09vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7?=
 =?us-ascii?q?Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xAHUqXVSYe?=
 =?us-ascii?q?RWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLns65Nb3uhnZ?=
 =?us-ascii?q?TAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD+v6bpgRh31hy?=
 =?us-ascii?q?cdLzM38H/ZhNFsjKxVoxyhpgBwzYHbb4yOKPp+Z6Hdcc8GSWZdQMpcUTFKDIOm?=
 =?us-ascii?q?b4sICuoMJelWr4jmp1QQqxu+Bg6sBOf0xTRVmHH23ao60+E7HgHdwQctGN0AsH?=
 =?us-ascii?q?XPrNrrMqcSUue1zK3TwjnZcf1W2TD96I3SfRA6uvyMU6hwcc3XyUkuCgPFlU+c?=
 =?us-ascii?q?ppDiPzOQz+kAtXWQ4el4Ve+3lmIrtxt9ria1ysotkIXFm40YxkjZ+Sll2oo5O8?=
 =?us-ascii?q?e0RFB7bNK+DZdcqjyWO5N4Qsw8QGxkpCM3x7gdtpO4fiUHypEqyh7QZvGIfYiF?=
 =?us-ascii?q?5wnsWeaQLDtkgX9odry/iAy9/EWm1+byTNO70ExQoSpAitTMs3cN2AHN5cWfUf?=
 =?us-ascii?q?t9+1uh2S6I1wDO9uFIOUA0mrTfK54m2rM9ioQdvV3MECHrmUr5g6iYelwl9+S1?=
 =?us-ascii?q?5OnreLvmpoWbN49yiwH+L78ultajDuQ/NwgCR2mb+eKi273/5UD1XalGguconq?=
 =?us-ascii?q?XDsZ3WP9kXq6GhDw9QyIkj6hK/Dzm80NQfmHkKNF1LeBOcj4f3PVHOI/f4DfOk?=
 =?us-ascii?q?jFi2jjlrx/fGPrj7DZXWNXXDnq3hfbF7605d1Qoz1spT6I5TCrEEOP7zQFP+tM?=
 =?us-ascii?q?TEDh8lNAy52+LnCNR71oMDVmODG7SWMKfPsVCW+uIvJO6MZJMVuDvmNfgl6ODh?=
 =?us-ascii?q?jWUjlV8eY6apx50XZ268Hvh8JEWZe3Xs0Z89FjJAugs4UfyvglmfXCJUYGqyd7?=
 =?us-ascii?q?wz6yt9C4+8C4rHAIe3j/bJiCO6GIBGI2pCF12QFnD0d62aVPoWLiGfOMlslnoD?=
 =?us-ascii?q?T7f3GKE70hT7mQ7hxrxkKe7eshEYspfqz5AhyuzImBcx8jh+Sfid1GSEVEl6hG?=
 =?us-ascii?q?QORiItmqt4pBoumR+4zaFkjqkARpRo7PRTX1JiOA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2EqAQDI9r5b/w4GAgpjHgEGBwaBVAYLAYFUgkazPgwBE4l?=
 =?us-ascii?q?PNwoNAQMBAQEBAQECAQECgQYLgjYigmk6GTgBFSlCJgEEGxOsVhqEXYRmgnuKI?=
 =?us-ascii?q?T+DdosEAoholSUHAoIPhAaKNx+JOQOGU5VrAgQCBAUCFIFYgXgzGiODPYJNjge?=
 =?us-ascii?q?NGoEfAQE?=
X-IronPort-AV: E=Sophos;i="5.54,367,1534802400"; 
   d="scan'208";a="45830882"
Received: from unknown (HELO AT-ESXVM-614.fronius.com) ([10.2.6.14])
  by mx01.fronius.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2018 09:13:05 +0200
Received: from AT-ESXVM-612.fronius.com (10.2.6.12) by
 AT-ESXVM-614.fronius.com (10.2.6.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Thu, 11 Oct 2018 09:13:04 +0200
Received: from AT-ESXVM-612.fronius.com ([fe80::b877:544f:b560:3fa4]) by
 AT-ESXVM-612.fronius.com ([fe80::b877:544f:b560:3fa4%5]) with mapi id
 15.01.1466.003; Thu, 11 Oct 2018 09:13:04 +0200
From:   Eisenkolb Thomas <Eisenkolb.Thomas@fronius.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth: Is it possible to operate Bluez concurrent in central and
 peripheral role?
Thread-Topic: Bluetooth: Is it possible to operate Bluez concurrent in central
 and peripheral role?
Thread-Index: AdRhJz0atnowo1DfR/6vOpl/HVQE+AACoMow
Date:   Thu, 11 Oct 2018 07:13:04 +0000
Message-ID: <da781fd16860492a9b4d28334a593b77@fronius.com>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.25.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am working with blueZ 5.50 on a linux embedded device with kernel 4.14.

Now I have to implement a use case where the linux embedded device communicates as a central device with a few sensors through Bluetooth LE characteristics and at the same time it should advertise some data and accept at least one incoming connection from a Smartphone as a peripheral device for maintenance cases.

I haven't found any information about blueZ is supporting both LE roles at the same time. 
I have already tried it now for 2 days to get this use case to work and I found a few limitations for which I didn't find any solution.

I was not able to advertise any data while my device had an active connection to a peripheral device.
Also while the Smartphone is connected to my embedded device(peripheral), I don't receive any advertised Data from any sensor and I cannot connect to any sensor.

The Bluetooth Hardware Module which I am using on the embedded Linux System supports Bluetooth 4.2. From the Bluetooth Standard I have found that concurrent use of both Bluetooth Low Energy Roles should be supported since Bluetooth 4.1.

Is it possible from blueZ Stack side to implement this use-case?
If yes, can you give me some hints what I have to consider to get this case working?
If no, have you got a timeline when it will be supported or is this no planned to implement in near future?

Thanks for your answer,
Thomas


