Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB57C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 20:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiEZUud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiEZUuc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 16:50:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD5E27BD
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 13:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAoVYHp/TwlxVZtSWrSwTH29ve5GWL9olNkrFF+7RixFiIKBVUEc1PYJB5EBr39GiUoFBxnknyCTjhH2nT7GCHVTojXI3iPsbNsGxL8fQbsfu6gEqylyt1Q4yFrqJ75V92TGuOYmZUy+RrkufuUMLP50yy1imO72LO+NmRC63JOv8ehyYUoZ7o/tEfhrJkfJJKFJLB3i4kycLAM9uHr6+PHi2YMxXwEtTz71mn4JLaMPFn+QbIGeiEWGr++1aVTJ2/Oj5rH5OEnC+CJejPqaF5NiA1gYir0SjPq3UrZt2dVpZbato7FC9UPvzH1VA0bP6tiBYwZp/Sm8HXUK478XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4onpLZdpyVd/lykKpQnfu5dWeuhMEQjmW+c8OsufvAk=;
 b=F3qKs9PimpitIzDf28iznfuDSDBIlZvt2XMTEqEZPVRWy2QkrYfH1coWip2PDtKAfWF3aOj8WEAKSPnE4Jba05OMMvhmDAXh3AHEDLpc+gsoLX2wwZ2Ct3XrqRv5b9TXTYSIivFVzBtgsE1GnpbRM3XWmW5rFS+lznSoRf6JEBdnHoSHTAt8v7JWoVWbcPt/Pzs65oxEXXCVFiVcpBF9C579vDmKbjoLlMnv1rVPSQMLFoU2cLb8E5PjCSBbtm7sAmmxFJCcivw4vlHJiP9LBkq8t6ECKxcbSyNRYQgGZ+anppOQo+L4Xb1ikJDVOVFQVzXfgCosRUIK6VaqXTwMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verifone.com; dmarc=pass action=none header.from=verifone.com;
 dkim=pass header.d=verifone.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verifone.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4onpLZdpyVd/lykKpQnfu5dWeuhMEQjmW+c8OsufvAk=;
 b=sQ/9iBppcSxXGjrrf6U41PvNfRKeuo5TtPTzhLw2X37tLtO53q4awOFIGi6My+m9EP37NTLiQQZG1P3lk6swjWwblACbo5Gq3Qe28tqHs8kXRDX4UsIuHOSu7+G80AsS/fY2DKp29q9zDua+hwpdMUKFo3Kdl2oRGW/L9TthupM=
Received: from BYAPR03MB3701.namprd03.prod.outlook.com (2603:10b6:a02:ab::24)
 by DM6PR03MB4953.namprd03.prod.outlook.com (2603:10b6:5:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 20:50:28 +0000
Received: from BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::7d5d:2b55:d7b7:62b8]) by BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::7d5d:2b55:d7b7:62b8%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 20:50:28 +0000
From:   Tom Unbehau <Tom.Unbehau@VERIFONE.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Thread-Topic: [PATCH-stable] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Thread-Index: AQHYcHNRf+RytFOnm0aotWe3QvGozq0xoN9H
Date:   Thu, 26 May 2022 20:50:28 +0000
Message-ID: <BYAPR03MB3701F946C27811EB60E8502F87D99@BYAPR03MB3701.namprd03.prod.outlook.com>
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
 <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
 <20220524142128.01acb75a@hermes.local>
 <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
 <CABBYNZ+gQf-YfT5Kiq6GRFsjhyyF7k0vtEc=Zzkc1O-_dExFVg@mail.gmail.com>
In-Reply-To: <CABBYNZ+gQf-YfT5Kiq6GRFsjhyyF7k0vtEc=Zzkc1O-_dExFVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1300b795-deb6-761f-295e-74be89328b67
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=VERIFONE.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c1a0620-b7fa-4eb8-d23c-08da3f595d87
x-ms-traffictypediagnostic: DM6PR03MB4953:EE_
x-microsoft-antispam-prvs: <DM6PR03MB4953CA1B8844654FE9A33E4587D99@DM6PR03MB4953.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDPWL7GBjxei1rckZ78sAsvmT7eeCPcR7PEcPxTUQWjcq7sWrF9hnMCIsuvHXWBOciryQLj+nZ847L9ePehuf8x/PHZAVIi2dOizvTtr0CEGh4nQh8T3zfaNLHML+2qTYrJUwY+LFTlBg2kvpCi3Ghqp12M1JLIpVLDT8YR45j6ChTPfjparMHiLKwp39AB7nYfH3tPZL+h+csuec+03fj0bzp0dH50Io5Jjxf5Dr5TT9AUJPRDSor6UCGsBzDZMUIYgNciZmSGLPapFnDnOZni9CaEKyikhlhguy4wKNmEQW0PjvJLhI09XgMTKetRNUy2hGuuOtjRZOeAp+EQMGwvOrfysJdpuQ5zN75LJRp6eK45GwL91+DNH+wBLBVFU/52SgGDBrdQPrRr7Tcxg5nKKvZxCb6EFSsW/PRM3amCGnXmbJApwxtR92MTJX18XuLz9OCws6c9PG/UP2xnmo2Tl0ygRqXDIpMCtJYGwOKKMFFy9AkCHNZHsUP9tFpqv01ewecoWRAHPPcEda0m3iN0nc1ANEv02em9M7G9l7UycSkrvcJgithxuYF4xRYD4AXzI9F/Ah6HWLKKV3Soeq440T6uK+sTSE3+MMRKSXluLOlHDcnhX+xlXvWxG+QWO6Hu5XvWKMsh5ufgmM8uz4bN4WHawvyLj9lcZkUTrVj+nt1lv+eY1N6W8jWqKAA86QmTt67M4Gfs2/nWzsyhRRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3701.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(6916009)(186003)(86362001)(38070700005)(38100700002)(26005)(4744005)(5660300002)(8936002)(4326008)(52536014)(76116006)(66946007)(66556008)(9686003)(55016003)(66446008)(64756008)(91956017)(66476007)(8676002)(71200400001)(6506007)(7696005)(316002)(122000001)(99936003)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4KVFq6vZCUdiGhl2mCPVg7ILQoekU3RAHw6a+lntXxlsPrQhtAqJNIdH2P?=
 =?iso-8859-1?Q?fECmqwIRcVByKivuC03EaHsivFamWOzTSAJ4BBQh+FAE/hRsppOA255kZx?=
 =?iso-8859-1?Q?7sakyDJBZn6HwyZjqJd0A8xEEAweyfBehKtGDzpLV3VAnCr/kDIQKilmP3?=
 =?iso-8859-1?Q?jecEoX4Pd/yqPvYoClwVZNQ5mhorpLIWCvNQS/QaJD+APxfpq55dsxC/TA?=
 =?iso-8859-1?Q?ixCP/oI7C9uEqAjHOGmNqB8CWYrFC4nIl+2lGj4N1fKVcljFCZ7v9Dtgi+?=
 =?iso-8859-1?Q?Q/ua5rmP4mk/872lEDCphjZAAcwpxWHVIPwy54DhpNtJ/LqwiqdBpPEwAI?=
 =?iso-8859-1?Q?yAUUGjTTTR3VxUJSF1Yd4p/9IpzOywKNOz2HvwWxbQ1nr+/tmhF2grRYqo?=
 =?iso-8859-1?Q?C4wwwSjxSH7y7K4OoXgMd7ZsdMoqxWFS512nvWYnrBdhwUMlQqbMK66GmJ?=
 =?iso-8859-1?Q?JKFGfLayU53Gvk9nTkxfEZ4rOhH5X8EWebhTh9ckqx17/nfkLdAHnJGfx3?=
 =?iso-8859-1?Q?EnyuEIpv31WLVEEnGVuUAa3iBVfRif9NFNPbPNujCpXpkxBXiAFjMZ3QY2?=
 =?iso-8859-1?Q?4ol3l0EqNuPN3lmOakWnV2XpN7SFst1spn3mduelkxD4dV2l+sH6LIwJ/r?=
 =?iso-8859-1?Q?CHUys9GsY5iKcbVmtjFYcXWDjTQpCXFyFZGvuFiCsIYnPp+snwQLJZmiWP?=
 =?iso-8859-1?Q?EF1BJONtQ7c5ZN6jr/x60jgxMdSXt5cvfdyaqNivnJpZ6oSOLpQGQTNCFj?=
 =?iso-8859-1?Q?LvbZJF31P/KkKXZg4gwvkAZW8/+pdgZFPLX31JV1P3dVdROBc4xUwo7qPs?=
 =?iso-8859-1?Q?DH9socZmHt+kRStPk4bIz9W5e+AxacQsMSpj/Z8EMjtjVXSOw81r/rD+FK?=
 =?iso-8859-1?Q?6r6FwZGmFQEnTEB38OI+VNVP03VQZzSEWwfyrVRvTsgcntLNWMKKzGSKng?=
 =?iso-8859-1?Q?OWvNpBeswjJ+20vn18MnNWrw0qGlUjNhu9NyESXQS0Htb8lRJr+FiFi1MU?=
 =?iso-8859-1?Q?6zcfqeEU9yt8QVywSyOL92C2HRQNjlx5636jUxL7JwF1cOY53IWLPJBoQb?=
 =?iso-8859-1?Q?7NMFTQYgQrtmzQB8HByFk9jfKd8viyA5oBEXoVviuCgqhgtvEZEGxn21K4?=
 =?iso-8859-1?Q?cMDRJcRJXW0ZSPbp86TcKQgDIeAhdNIwTDErOuLTF4u37NqINgbngTlTbm?=
 =?iso-8859-1?Q?ypAjtN1tQ/1U+4RmMhBOFgDwoLD1sr6HLxfdm/btCXtgcAKU6QMhxDWlgj?=
 =?iso-8859-1?Q?MJGQ3HajaUhZ+SazvJI61VmvKDq2PbiuIyDpd0XPkpz/hRd36UZIs/gYHL?=
 =?iso-8859-1?Q?FVb3Y7xzKgE7esasUDpC7JV7hFsycCYOfCxMC3ZVV1gXsw9FiFq0l9WjE/?=
 =?iso-8859-1?Q?53MQUOa4AGEO4Jd8HpGMc3W0zQjFry0EOMkVt9FfKOva73lVCDSRNKVPdZ?=
 =?iso-8859-1?Q?ezItQsPXlJar8CV8fiTO+lYIWLBYZZVrCCxK0JaAooWXNRAGFJhVJd+AjZ?=
 =?iso-8859-1?Q?0p1WDuKRYX4LQGZYBoNCAAfI4vGSZYVDTemWO2cheahOUTSA0Ga+/AMp5Q?=
 =?iso-8859-1?Q?VTUWjPrF2rRtV7/QzNiQNFis0DjSQlUms3qYpqs7LHMx1FDyS/k8ofidTQ?=
 =?iso-8859-1?Q?Z9OA4hR91LMSM57wk+ilMbU5pliLeL7CrxpckowiNCjaKFmCMrQBi2r/ed?=
 =?iso-8859-1?Q?mZKE+fv9p7D9j4Azh+LL6Z+aW7//edYreH+yYrVL3+LgMJsTzvEqzhtb4Q?=
 =?iso-8859-1?Q?vNuYas2VFJ4rYI2iyLyMr4wXKaZIr9djiJJqgiWlSWY+s8?=
Content-Type: multipart/mixed;
        boundary="_002_BYAPR03MB3701F946C27811EB60E8502F87D99BYAPR03MB3701namp_"
MIME-Version: 1.0
X-OriginatorOrg: verifone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3701.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1a0620-b7fa-4eb8-d23c-08da3f595d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 20:50:28.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 611a22d6-8c40-4958-84e3-ce47d8205d98
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/dVKNJOt25fcyGi0SUmszXNQoh2Xj3jf98nbkbtMe4AMsdRjZcLSBoBaH0VKSMjZumYCYs5F6mKkhrusJyJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4953
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--_002_BYAPR03MB3701F946C27811EB60E8502F87D99BYAPR03MB3701namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sending this mail again due to HTML mails not being allowed.=0A=
=0A=
Hi Luiz,=0A=
=0A=
The patch did not fix my issue. The issue described in the bugzilla ticket =
was an error=0A=
in the mgmt.c module. I do not see any direct correlation between your patc=
h and the error i am encountering.=0A=
I have tried your patch on mainline (5.18) and got the same strlen bug when=
 executing the example=0A=
program I have attached to the bugzilla ticket.=0A=
=0A=
I think strlen in the mgmt.c module needs to be replaced by strnlen.=0A=
I have attached a patch with these changes to this mail. After applying thi=
s patch the=0A=
error could not be reproduced for me.=0A=
=0A=
However, I am not sure, if the changes you have made in the eir.c module ar=
e also prudent and could fix=0A=
similar issues (I am not familiar with this).=0A=
=0A=
Regards,=0A=
Tom Unbehau=0A=

--_002_BYAPR03MB3701F946C27811EB60E8502F87D99BYAPR03MB3701namp_
Content-Type: text/x-patch; name="btfix2.patch"
Content-Description: btfix2.patch
Content-Disposition: attachment; filename="btfix2.patch"; size=725;
	creation-date="Thu, 26 May 2022 20:49:43 GMT";
	modification-date="Thu, 26 May 2022 20:49:43 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbWdtdC5jIGIvbmV0L2JsdWV0b290aC9tZ210LmMK
aW5kZXggZDJkMzkwNTM0ZTU0Li44ZTUyOGZhZDIyNjQgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9v
dGgvbWdtdC5jCisrKyBiL25ldC9ibHVldG9vdGgvbWdtdC5jCkBAIC0xMDgyLDExICsxMDgyLDEx
IEBAIHN0YXRpYyB1MTYgYXBwZW5kX2Vpcl9kYXRhX3RvX2J1ZihzdHJ1Y3QgaGNpX2RldiAqaGRl
diwgdTggKmVpcikKIAkJZWlyX2xlbiA9IGVpcl9hcHBlbmRfbGUxNihlaXIsIGVpcl9sZW4sIEVJ
Ul9BUFBFQVJBTkNFLAogCQkJCQkgIGhkZXYtPmFwcGVhcmFuY2UpOwogCi0JbmFtZV9sZW4gPSBz
dHJsZW4oaGRldi0+ZGV2X25hbWUpOworCW5hbWVfbGVuID0gc3RybmxlbihoZGV2LT5kZXZfbmFt
ZSwgc2l6ZW9mKGhkZXYtPmRldl9uYW1lKSk7CiAJZWlyX2xlbiA9IGVpcl9hcHBlbmRfZGF0YShl
aXIsIGVpcl9sZW4sIEVJUl9OQU1FX0NPTVBMRVRFLAogCQkJCSAgaGRldi0+ZGV2X25hbWUsIG5h
bWVfbGVuKTsKIAotCW5hbWVfbGVuID0gc3RybGVuKGhkZXYtPnNob3J0X25hbWUpOworCW5hbWVf
bGVuID0gc3RybmxlbihoZGV2LT5zaG9ydF9uYW1lLCBzaXplb2YoaGRldi0+c2hvcnRfbmFtZSkp
OwogCWVpcl9sZW4gPSBlaXJfYXBwZW5kX2RhdGEoZWlyLCBlaXJfbGVuLCBFSVJfTkFNRV9TSE9S
VCwKIAkJCQkgIGhkZXYtPnNob3J0X25hbWUsIG5hbWVfbGVuKTsKIAo=

--_002_BYAPR03MB3701F946C27811EB60E8502F87D99BYAPR03MB3701namp_--
