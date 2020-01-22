Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7814C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC62465A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qca.qualcomm.com header.i=@qca.qualcomm.com header.b="ZnJwv6Wa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="HB9SDx5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAVQya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:54:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57324 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgAVQy3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 11:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qca.qualcomm.com; i=@qca.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1579712069; x=1611248069;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kaEbGuT+GWl2/MGW5Ti1JANQBwYuSjM5XrE0fINOxK4=;
  b=ZnJwv6WalJvnCw+fyrPCQWOetmE4PX9OFt/OFCY1JjS2bsbWsuyzymSx
   ZjenWMVIq2gcmfv94k8XvlgpkTFcdncs3Bl0x4RHVnoBKnx7QvIRkEZou
   1LN563vwv9ymFOtANW/3WLDPGkt1jEtEgB9BJj86nisSCwlUaZQj6s1MZ
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jan 2020 08:54:29 -0800
Received: from nasanexm03f.na.qualcomm.com ([10.85.0.47])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 22 Jan 2020 08:54:29 -0800
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 22 Jan 2020 08:54:28 -0800
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 22 Jan 2020 08:54:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 22 Jan 2020 08:54:23 -0800
Received: from BYAPR02MB6006.namprd02.prod.outlook.com (20.179.63.144) by
 BYAPR02MB4919.namprd02.prod.outlook.com (52.135.241.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 16:54:22 +0000
Received: from BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::f13a:b064:4db7:b09b]) by BYAPR02MB6006.namprd02.prod.outlook.com
 ([fe80::f13a:b064:4db7:b09b%3]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 16:54:22 +0000
From:   Kalle Valo <kvalo@qca.qualcomm.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PULL] btqca firmware 20200122
Thread-Topic: [PULL] btqca firmware 20200122
Thread-Index: AQHV0USWwg/r1norU0SRVVboymqSGg==
Date:   Wed, 22 Jan 2020 16:54:21 +0000
Message-ID: <BYAPR02MB600646BA6832ADB7C920A45A920C0@BYAPR02MB6006.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kvalo@qca.qualcomm.com; 
x-originating-ip: [88.114.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f84597ef-aef0-4b4f-a1dc-08d79f5bbac7
x-ms-traffictypediagnostic: BYAPR02MB4919:
x-microsoft-antispam-prvs: <BYAPR02MB49197CBAD54FA6B6F15F271F920C0@BYAPR02MB4919.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(71200400001)(478600001)(5660300002)(86362001)(316002)(52536014)(8676002)(81156014)(81166006)(6506007)(8936002)(2906002)(26005)(4326008)(33656002)(7696005)(186003)(6916009)(55016002)(64756008)(66476007)(9686003)(66446008)(66556008)(66946007)(76116006)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4919;H:BYAPR02MB6006.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lsWwRme3B0pCCkICO+WgzqqaQr0kcrljm3XDWC1I1awOIQrGEq4H8w8AaiQA2w2iCpscHCH14f/SJmG+mF3+fdgH3b9LUzDggj7glDj1DaBDtLsQ32FrNDNi6ePphFf84vB7rfGIeols7uYaSPaEalf/eVt/Ug2TRtS2O3Q4sQBfiogP4nF820wYNT6XIEWurNCQshu9jjSh7ff2XGDUJgkEyT8s9cW5D2Uu/mLrVAV3Y2RKHd5F9RGNg1tElmiFrv3gLwR1oI+jcfXS2jSk6wG3U8kP8PH2ffLRt1g38+dtnjV+kYejywJlXQZJZOJ6Dhtx4kzY8UYH9pPrOGvzV3SsTj+S1Pxqmr//113GHxwjUnx68zN3xhBtuEkVYwVChZv6tayAk9wm1gHxf/T5rjlZhBBgBovwX0Zh/uPHgMPpJaJ99ta0toHT8RplGsv
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NusC7nsrEjN0Qp/8bFjKYqyxtXkBZn7ZdWw5PlzZfSxeWB0X0MwcygQJ2tn5FzikqNxvSDux0k06Xmc4soqaJp6RUX29Gvl9sDpUS4qBTMeqWqAebiNXnJVgDrzDWT96k+LegAFaD9rjfFHRjaocO3Z9Vj0cD4tVB4AEbLKAEUWSUjcjebcjOjiDroIN7MiaKEKGJCLTGUfKZTKps0GwmM9Ceb7yf51T3Pk1kvTpO2QQX5FhS/DwyTC3jmCNKP8MnGZF8DYDJINmjA10e6wUeyP5aH1m8fUDvCIhZPsA9wQzvgdOGNDJY6k6pzuvgKx08cO3YdiX5iBkFvvICYF4XA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj4xSg/I12hvlQ0nHW1GVqsSPxVMreTEmambtDZ/wXc=;
 b=XJbWYL4ZRE/qbHp7lZ6Qy3fgJgAgdCBCm0x9YqG87xNxfYgXjx7eLIj888+wXJcLjhMRjmzZ/0jjLtBq9oWHZU4W5DUwkMuBBxKCkxAUr15K2y5B2izdMhtnpHkEur6mh7V+5vVXU1Z0rw2m+EfWQQ7JxXdxc9cMLbDnA4QUgO74cL3VWjDWQ/YLf4QNR6vFlUgR3EOTqQvdB1peRAHcvkrqFL49ojaXZSpVhupxm4rODKwskWW7Bq8vllUDAm3fdL4XGBgVEEsg+btJmw68QbukGHYg4rnZdzn0xPoWWBvVx6WMpMCrgGr2wwGhXF6KmPK4z/ZMXidYgDvl1lSomA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qca.qualcomm.com; dmarc=pass action=none
 header.from=qca.qualcomm.com; dkim=pass header.d=qca.qualcomm.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj4xSg/I12hvlQ0nHW1GVqsSPxVMreTEmambtDZ/wXc=;
 b=HB9SDx5JDNdPKAv7vQPkfmJmxnVIhFsPB2bJ7ocO0snE5L8yOMfOhjJLEXFBOSfuZzGCotw4eJvymL9UYE02LWJ/CATD7FU5osZneGoO3l1lxv1WyhjVdd4acuoxdtlVPvOOrSvM/hGQkmH11C6Jc50354R9+a1DAU/o54cIr+4=
x-ms-exchange-crosstenant-network-message-id: f84597ef-aef0-4b4f-a1dc-08d79f5bbac7
x-ms-exchange-crosstenant-originalarrivaltime: 22 Jan 2020 16:54:21.9410 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 613UY7i/N8XeGW3KQYDBo0Lqi1/Mxa3ei6jh8OD2hvnoo10xjaqPn+a1JGC1pCePwZS+nK5hCcOUcZ9XMq+rig==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4919
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qca.qualcomm.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-firmware maintainers,

here's a pull request for btqca bluetooth driver. Please let me know if you=
 have any problems.

Kalle

The following changes since commit 1eb2408c6feacccd10b02a49214745f15d1c6fb7=
:

  linux-firmware: Update firmware file for Intel Bluetooth AX200 (2020-01-2=
2 06:26:14 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git bt=
-20200122

for you to fetch changes up to 30550605b75c16489ee75fa1cf8be6aea8506068:

  qca: update bluetooth firmware for QCA6174 (2020-01-22 18:27:20 +0200)

----------------------------------------------------------------
Kalle Valo (1):
      qca: update bluetooth firmware for QCA6174

 WHENCE                        |   7 ++++++-
 qca/nvm_00440302_eu.bin       | Bin 0 -> 2041 bytes
 qca/nvm_00440302_i2s_eu.bin   | Bin 0 -> 2041 bytes
 qca/nvm_usb_00000302_eu.bin   | Bin 0 -> 1998 bytes
 qca/rampatch_00440302.tlv     | Bin 0 -> 66332 bytes
 qca/rampatch_usb_00000302.tlv | Bin 0 -> 66964 bytes
 6 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 qca/nvm_00440302_eu.bin
 create mode 100644 qca/nvm_00440302_i2s_eu.bin
 create mode 100644 qca/nvm_usb_00000302_eu.bin
 create mode 100644 qca/rampatch_00440302.tlv
 create mode 100644 qca/rampatch_usb_00000302.tlv
