Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D30DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 04:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiDZFBs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDZFBr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 01:01:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD403B6D2D
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 21:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ8OvrOo0y67a8y2K9tDNnjHz42PUKJy5f4hFtDTtIJT1Nf2kYbaQ7AMiVhqCd/S/VUHtn7wb0TKmUUxqSUf3/irUDz0msLv1cMH636KsGmlTdyGbxfHuJq83a9m+IOuw7pvpuPkuX1c1yeYh9GFcT94dCEK04jmyC54r3YAdBea642AjLB+V8YXeHzQittMU/w9XCJW+O62ljexOG+YVuR2o3ne8AyiBupPQhEls1w8diyAjTv9UBXD5GUHAHnqOu8D0L5/B0T5zmuns51tQXzUZ77Iox6dd2uCA5TN3tnyWMSGzMUDY2Qfr/wUjPuaAAwn85hlg8k8RggFe9m7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUwbkf1YTKff+5mhzFRT2iu5Djqr4ggeW5xg0SnvaL8=;
 b=n0Euu3vje2ztuAO0Q5nShyHy7tLiDP4m5uDYBl+AHWQj4BDB8+lieIzuwI2diMpQd+KP9UACddg0noDulQsqr/G/VfH74FvzSeUrFrBThBlxnfqIytuy3vo93Pio8gZV/g6PdMaMa3i59aifF/eXogX+PjAXEp4QQL1eUYXNeVm0Qqo2hKX5BKWrCAe3AMGlhmsGYx9xjjNqV3aMKAu+5PVVvhPPMjtz10yfi9bZxYgQdkGnFc9IaNB2yEsLbXlDN6UHrlUVtfUuFrcffg9oOyXdsYoJ078dxbyC7Pc8sQrulJJxJlSWDgHtYjsgZmagJG4P1dnqQq5sLakXy794rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=life.net.br; dmarc=pass action=none header.from=life.net.br;
 dkim=pass header.d=life.net.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lifeservicos.onmicrosoft.com; s=selector1-lifeservicos-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUwbkf1YTKff+5mhzFRT2iu5Djqr4ggeW5xg0SnvaL8=;
 b=UIKqxtBM29MKjeUG1P/8wDEfKe2UhtiB1pxFcQAN42io+2rOj9optAq9yOe6926II2xxs4e+U/414jRzvLku1SPM+05JOPDkFfpAp/dcocj+4jZs+H3dDz5PeEKl7XY+CTnCcIiPK5fPbDt+8qfcLWEzvliDVOZ/M3moP93YNss=
Received: from RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:68::10) by
 CP2P152MB1507.LAMP152.PROD.OUTLOOK.COM (2603:10d6:101:22::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Tue, 26 Apr 2022 04:58:38 +0000
Received: from RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
 ([fe80::91c7:36e5:f6ea:89ae]) by RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
 ([fe80::91c7:36e5:f6ea:89ae%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 04:58:38 +0000
From:   Arthur Fragoso <arthur@life.net.br>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE Audio and LC3 support?
Thread-Topic: LE Audio and LC3 support?
Thread-Index: AQHYWSerrv4wb8GZJEuQDsMu+YmBOg==
Date:   Tue, 26 Apr 2022 04:58:38 +0000
Message-ID: <RO2P152MB4617632DBD67266CE4D1D3DE9BFB9@RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=life.net.br;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c21bc0f-34f3-47ea-aa89-08da27416d03
x-ms-traffictypediagnostic: CP2P152MB1507:EE_
x-microsoft-antispam-prvs: <CP2P152MB1507BF193E3F4C1A3213DB5E9BFB9@CP2P152MB1507.LAMP152.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jTH/IJlUOs9sRG4mp5o5ZDvZ4zrLJ0fuH5iOjaMuhn42QpxUKgz4TXcMFP5uLPGz7W3bVl2ellK1hz0StJ/mAwb+t4AGoNBc7chVKxIM9Ft7uG1pM9NqL7TIwbjJOTxt3nihXVS9n0UOZh6fnUV+HMvuDfM/5MhLezJWiXCn4phhgOO9LARbUGkwdXGjjKU8hc0oGyTUFzcQBQMMazczY0ww6MlmNDGtYO0lOtDFSjYcNR6YddY2BhWNM4wAoj74/j5Dl34EwyciGCvn1wNeObJGndxcDTZmexk9znrhVfmoElfM7BU12+SbyDJZzxHXsltUkUufhZIjOc2G9b/7PNxn95LngS60SfzCvPqBGX68MVepM0ofO+DiIZEmvkvUPovT5yctG2CTuaFZTNR1jbT8WXt2N9T9kTKAbkDuch54vq4w6HNri6Ij+iVLqobhEj/NDvfDTw6YHE3JgxALNtbHGl1yqlh9tjHYnxnvF5KXGtK12B2r9OBHxInW80af8HQ1moghgueLP53+ASqiGw3Xn6hH4fHfrt5Mr7eFZs5jrRdvGppXfbnYYPBXNHGdlzj8gkl+o+Smcz8xN/ZUF7nLe756tBpHLjcxGb81nKnS8xSd1gSsjKZI8gQgccAEdGzDZkiTHdefSt0LV3F332+Mqbezg3Ef1eOcn0HevF+CDNHemedEnQX6TVHzADBkRSvQFkNrsXd2yXzZETXuul7u8De7MHG5MYHFK5tsT9PGC2L0ph3ZYnSlXmlsa3DNVsO8FXdEeiPZyE0jvA/TjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(7696005)(5660300002)(8936002)(8676002)(52536014)(33656002)(66476007)(64756008)(66446008)(2906002)(55016003)(186003)(4744005)(38070700005)(86362001)(508600001)(316002)(966005)(38100700002)(66556008)(91956017)(76116006)(66946007)(122000001)(6916009)(9686003)(71200400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ad88tgNXm/CyzvqEnq50Z4M9GoKMCvCUU25LgyWKcKn2FnwtZ2S6VQDWis?=
 =?iso-8859-1?Q?lgrWCAlEjzq11awA0QsT2ZOO4NiM5NX6Y1MU9bKM77MQ46Hb1ZGUHfeZ/W?=
 =?iso-8859-1?Q?Etl4GXLCNqG8C4i1kyZQylsB6rQZZV3H0ZZ0BCECVSOBX68HDd69PLsx+H?=
 =?iso-8859-1?Q?JZgMywuxcEaILxhPE5vv/6/ypTFVbvz2HWHDF1SjLiNzRv7fgDYofhRDrA?=
 =?iso-8859-1?Q?RoNE8X2YYid9HlirSdm2tUv6z9ILD3YO9+wCdknKeZn+K0peboZFrV1y/c?=
 =?iso-8859-1?Q?RmbT3GefJfauVZbzEqcZv9aUDG4Al6pyPgNWSV7jvbCv1gTqzOTAIaqZxy?=
 =?iso-8859-1?Q?Uy0xV+byqtXIzfvmEf8gM4yaXwley9s6urazOINgCQPemNznaUiO+kFA2d?=
 =?iso-8859-1?Q?OFKWQo9+iXpoMSKk9sA+qihc3rxsTJ+GNM664brQ5nmcxeOT07UQI5YhkT?=
 =?iso-8859-1?Q?u89WB9Q2XX35RVRjhVO4aigRPeUTF/XU6CfU3dxyDg3QKx3oI5NStGV7Vn?=
 =?iso-8859-1?Q?1OES/Wyvd7EeWeCRLmPhUA+7jThknaPXQyrrwOz0iUNkv+Uey3ncs4jSsC?=
 =?iso-8859-1?Q?7GZnq8L4EpZ/AqrOkSEAW0FaqXul+ZtOv27afFHi3cmxpooNdKV8oyK4wT?=
 =?iso-8859-1?Q?A7U4w0lQK9cuiWEJFJo83YeGbQPwZkpO2L9qn/pUP+Dmeisw/RHFuZzPNg?=
 =?iso-8859-1?Q?HyeRT5gSeo6Ubw5j2qu8hVEnaPa3KtlDvAjqZmVl1gRb+gt0ZyVevhIuEq?=
 =?iso-8859-1?Q?dTP6iBR97OHt4/D+YGl91MP44y500Ux3DlH9i6KoNVzmWzp9T/0eytjiOm?=
 =?iso-8859-1?Q?QTMP6haFSqVpOwe4krVRSQcnkTq4HRvGR9pwdHS4+1xOUv+HRKomm43PES?=
 =?iso-8859-1?Q?P6cANGMyfmjlm2Kc/pI3nwMcFHHNmJj9gU4JW91ITInqiDEEDnJRZVtCoZ?=
 =?iso-8859-1?Q?u3mmrZRugozJv22h572pbA7eOlN5Jo0BlltVJHrBiJUYfsMxLr3Yq4z0b9?=
 =?iso-8859-1?Q?DsGnUQpczi9QN0pCG1XixSSQpGXClAevKOOCkrX+Fb9qF1nzl0fMdZA3JV?=
 =?iso-8859-1?Q?Lg/BmSRQ38ufvRPUaalzgiQjTgoaafvWe6UVfAsXP/fJcUnIG4w0YKyIG9?=
 =?iso-8859-1?Q?ZKwO7dui3gLPXhMql52rE1tR8zLqKvQUxKELXpXhEJg1JFP230fYF1unXu?=
 =?iso-8859-1?Q?J2E9Z81SQ6A+qApITMBEKGOj1yEbINYo2SvgNnIRyhVwRJ95fkD4LegDcs?=
 =?iso-8859-1?Q?i9kmv/fZuMS/BjuCNZz6bHrcfFEoeWw8vWLZc1YcRO4DyQgGGUgeIaam69?=
 =?iso-8859-1?Q?D7ao6eFRZ5OuMYC5cQ2bMeIG92aeQrvKVwlkOSc1u1afFcHip/8/XieCGK?=
 =?iso-8859-1?Q?XYTY7gNJwW2g8j+X2/F+xsdDCqNmuVUhkjp6e3LKsjDXMBzB59pd2OyQk8?=
 =?iso-8859-1?Q?5Nilqrc+pchyf/gtfFy8OeQuRreBwSFHvzC9XN+ajfUFbm0Ew8GfnNdvNF?=
 =?iso-8859-1?Q?eziDGwXxWs+fT3mIKvm4VIrlKzgUMo+I5BK67qQVMAzOqYjoK55QKlC/ma?=
 =?iso-8859-1?Q?Jr54T765jQmUrD1e5EqobrxgnV/7AAG4S6rTflUa4wbcI5aHx9CcsEFUoh?=
 =?iso-8859-1?Q?U9AwP2ErfFmaFthuW3Civaoroul1rCDQxmeRIrPRC67FLLgkCfsORAdqDq?=
 =?iso-8859-1?Q?iHXJUr4uGF7/rIBzfJVQ9XWxv3oJY5Ft8h7dDo6zcPWWbZN0EBzosj3zVJ?=
 =?iso-8859-1?Q?nLcpmhIVjYDuwXCaL9HYUrHP4PQEe4c/bjgKLefhZh7tjLeCtOwFIpE8rY?=
 =?iso-8859-1?Q?vX0lypC+AQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: life.net.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c21bc0f-34f3-47ea-aa89-08da27416d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 04:58:38.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 985e32eb-3341-40a8-9eb8-dfbc06ddcc28
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBgngD0t5kq1Iy6Pzeu83H4pSS8kOf6e5sUX6KDqBcoQSzh8cyiKZEZHz+L6tYKq+Z0ZaSmId3ALB5y9mi/awA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP2P152MB1507
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,=0A=
=0A=
I was gathering information about LE Audio & LC3 supported systems and incl=
uding it in the wikipedia article https://en.wikipedia.org/wiki/LC3_(codec)=
=0A=
=0A=
I saw Android 13 added support for it, but I was wondering if the Linux ker=
nel had support for it. (and at what version)=0A=
=0A=
I tried to look at the source code and commits description and I'm unsure.=
=0A=
=0A=
In the pipewire gitlab, there is a good discussion about it with good infor=
mation and links about implementation. =0A=
=0A=
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/1211=0A=
=0A=
And if this is currently not implemented, are there plans to implement it?=
=0A=
=0A=
Thanks a lot!=0A=
=0A=
Arthur H Fragoso=
