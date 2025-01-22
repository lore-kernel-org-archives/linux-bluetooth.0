Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2098.outbound.protection.outlook.com [40.92.20.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5318AE2
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543713; cv=fail; b=MGT/ehO86Xi5SodzATLeh8QgeHUzwDlIY6lej7n6j5q1NiNjXqDMDlXlg0mw0gRlgmHUz1g3V4/Bxf0nJCIROg8lLL7g+/5dI7BOe8JfqTmTIM/5T3ZeVS8ZUYJ29Pivy+nWP/FLapOIl0T+qR9idXowJCRvUGX0oSJILArX6ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543713; c=relaxed/simple;
	bh=DDblL+df69ZMsY8USL1vCoiy0ZuOXoom+SfduTnsfDQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YpKpN2pe2b6kCT6oER0AVSokEOscPQiz9+To63+RVQ6n98FGp364YcBeUlQU7LD8zXcIBgqBGMhZo/D03P/QOoBI32Es04ebelr+EvVY70/zgSylm0HFcopa5czNoHIPMK4FI7Raf4ZjebwWm0BZ6UO+WZF19E/bUr89T28UVrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DcfsQA2Y; arc=fail smtp.client-ip=40.92.20.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DcfsQA2Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrGOnf1XiSwmTYfL4264PXIzXGiQ0Q4MrKafoyEkdhFKW9qzvG3i/KvMRJhS4EwubKti9TI9sZb+c8ArxM7XfCDLkstYbNx/Uw9xvAztcQ9FOSbhLuE/ZueXZzoW+DnjarinVQqjP9l57F04XyB7BLIZ8U4mG4g30P+p2aS44TqTqqZMn3FEwsJcsaUj1a6M+a+Au/ddgWK1h+l8wAg/31g+Q907wm8IxGAAcSjou5qfBURMlnA14qSSzueCXCPXUAyFPnKok/k5aJ46uB8CGnljtP9NU763a3TO3DtRCQDGJByxXXOXd7jReS1+2GLASnMQsf+rOaynUz0DjC9n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDblL+df69ZMsY8USL1vCoiy0ZuOXoom+SfduTnsfDQ=;
 b=b1dcyB2vVdANz8IjE5SXE6aQg+ZGtAGrTpVqj3sYGrJBWqqcHMNYDUziyI9lEnY/XznLBlG2ND2eZj0dvY0gIyARpoOkSUMptWEPvjJXa0bqJo1A9nEwzkkw6bWoO+GNKwEdtScrVmSecbAr3NdlEWpHsQ44kCBHwxCEoQg1JOSZVNmd1aRsmGGBIrBG3s5h6emvaK3NkEJcxxghPazREQYBdhV0hEilIcwG3p5IkVjEkLtEw5vPk/qZ15mQQOZ9hB9wSeQOkEKUuKKq/jjwtagMcND5lwZHfWAdS3H3/NDtyThbbDPOkvgMPFAMgMwW/5fdkbh9Gqb34rMp+KWpRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDblL+df69ZMsY8USL1vCoiy0ZuOXoom+SfduTnsfDQ=;
 b=DcfsQA2YPvsXWTBAuIrCQB81f6xkJemXMWBsHbItmxNR575ObSy36ljtLETo0n1KXB4incT6lX0qb3661Rx+imicBTpD+VW4kFjs+J+WlhvbPr4q9T7JzwpHevwiA2IC/oip6vv2lnavG7/IasPFZ4eCY+BAABJ3zVfqf6JgDJ1KpW3zU8/zuesIXcCI/ic195jnQM29YVIU4gLSbHVX4Y/Xdb7/bov9OXKjvzKvgzZoRVHSH1f2TqK7WLXUeIYo+ABn2t7xawwVft1vnc1gXAlR8CARe55YhKOnH07gsQ/Y6cz2EvA3ohmUa86mZVkteHWhVetoUh1DmOfQANv9ug==
Received: from PH7PR22MB4048.namprd22.prod.outlook.com (2603:10b6:510:247::20)
 by CH3PR22MB4539.namprd22.prod.outlook.com (2603:10b6:610:195::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 11:01:50 +0000
Received: from PH7PR22MB4048.namprd22.prod.outlook.com
 ([fe80::343:962d:76fe:237d]) by PH7PR22MB4048.namprd22.prod.outlook.com
 ([fe80::343:962d:76fe:237d%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 11:01:50 +0000
From: Phil Phil <heidegg@hotmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Starting a call on an Android smartphone from Linux via bluetooth
Thread-Topic: Starting a call on an Android smartphone from Linux via
 bluetooth
Thread-Index: AQHbbLzsHphVlikfyESfuZZnGtDmNg==
Date: Wed, 22 Jan 2025 11:01:50 +0000
Message-ID:
 <PH7PR22MB40485CE000F22A5A61C937B6AAE12@PH7PR22MB4048.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR22MB4048:EE_|CH3PR22MB4539:EE_
x-ms-office365-filtering-correlation-id: e4ef0ed7-9a8c-4019-a10b-08dd3ad42bff
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|15030799003|461199028|8062599003|7092599003|15080799006|440099028|12091999003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KUzKQTT8kyQXh9PspJiKliSrqkt7oPb2emE0tEoJRX/RUGspAgHywdwlxR?=
 =?iso-8859-1?Q?zVC5TWnrmyEq6cTJgMvdnqBsWGMDYpR4VjYEey/mScgwE2DqOSi8/kXyfL?=
 =?iso-8859-1?Q?IAnqvE8Xf41gWd2Fy3sJ6ppVa9KIwlhFnrWOsxApvTgI8zq5mQ3639SjtP?=
 =?iso-8859-1?Q?GAqCzPAsK1NRcgayvcLvJXz8ZgxxwqumvGdlLJ+YKr//ANWS2b80FLSUwZ?=
 =?iso-8859-1?Q?+28MvbDu/LENx5p1/zr3AifPIm7UXZErbtgvJe5Oc+WgXlHowQSpe4t48S?=
 =?iso-8859-1?Q?6Ol/nxh0oDb80eOcODppASYbO4W8IDaoHw73J0mrYaMnzQKD+ssoRxik4w?=
 =?iso-8859-1?Q?vqWT4zKIFWT9wTusOe6sCNYJc8GcyhJQAB5WpcWkG8Tjb7jWKzQG2/II9f?=
 =?iso-8859-1?Q?4nHX3PlGftkJorNxMty0CuBWkYRd3zpRw5kUpYgzWPIEEVANYP9asbdNWx?=
 =?iso-8859-1?Q?oVIMXqbjjyzaMOoMklrVBZlQLs4X7Ua3AhWlmLrqV1B2pJcA4Uk+d5+tem?=
 =?iso-8859-1?Q?pI9smDjb0tGL+hKTzG8T008rso6gpaKvFYb3MygtppfzNRvRNnOh35FQls?=
 =?iso-8859-1?Q?5Ml8pXnv5MIQbiD/ERs4+CUcYXyaOWcaeqWUepfXTxybVE32XSHKjGP1d4?=
 =?iso-8859-1?Q?Yaz2pxEjOjc5zkS0ljIjaTLkKpl3AkcLNiFJTUFT3HLvP+WzgNV3OKIBXY?=
 =?iso-8859-1?Q?wck+u9CoHMvIbbvnFsu+VMDnw3OL01pKcBQ0aJZrY6BSs7AwAc5uF2qFSl?=
 =?iso-8859-1?Q?FzU02UMX2LSTlJXDTUiokBSQvE1uWaGDtFw92napZMtV/3A9HdnxzN/sDD?=
 =?iso-8859-1?Q?oajS+8BDysMA5LHnOsv13QowOQHeQfHYZn/oq/PmrhwpahduhsDXtH4sFu?=
 =?iso-8859-1?Q?oNw2XViSUN05ruxzZ/vnLqYodn+urP70G9vAc7TMryXAERZh75Y/WFFulT?=
 =?iso-8859-1?Q?1oW0pVbqhzM5YRBPJzRUSAkRV8hHjoiwKQDEkfN4tQcXKYIQsHrRJNm8pV?=
 =?iso-8859-1?Q?7TMRiEBLdqvVihFHFf2Mo8TJ81eGr7R6c09sOTxhhV5R/RMSy89JgQPXna?=
 =?iso-8859-1?Q?ndK5yf7W5CSf4cciIen0rzBhIB09xNZC61CaAucNTOUha1k4Yvk1MWAJuc?=
 =?iso-8859-1?Q?d50z67v4RaedI4S96i7bYuDPJBwVNLrob4AaKxFrwoE0bIE+YdjyXGDVJz?=
 =?iso-8859-1?Q?yhPjJ5Qb9XbD1w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1O0xzdtrcmqAi2dkbKQX4bWx/FPzZbTNmngsXwkdySKFF04yEEI6SD1p1V?=
 =?iso-8859-1?Q?aJ2Jz/8wiNc2qxbwLHmrWtdjcsbkOkZlVcKCVMlw6HWMHtQ2ykyiCcpL32?=
 =?iso-8859-1?Q?bLr/KfAvGn68UbooI/gHOWof2EXvErlBAf/eG0bKUo4ahan2i1f/8NX57D?=
 =?iso-8859-1?Q?EeV6yCsjvjYXhbqXPQJV/w7KCB4L8whtSQ/2jIbsGpJUZkoT6CcxpzFy6S?=
 =?iso-8859-1?Q?yb+HVr+k6/lKHu+VfXWsaTYJKxllWDA8NNTF3WEmAxHNotEn2uEg7wpcgc?=
 =?iso-8859-1?Q?U7FP/PAfsENZSjqPm7wPdW8t/ox9HAeaK9i4uA+63o67NnbjgiodFN3rJz?=
 =?iso-8859-1?Q?4VOVhozTSbpzgH86SELXhZpR5pir8Jqlh5lCJGZl7sHsiVjh8xjJ3mCRNf?=
 =?iso-8859-1?Q?Mq58x8UzioGXNPk8nKB5QyA73i0CqZESIS42LtDE3aaIllM3Grit1kQCII?=
 =?iso-8859-1?Q?/EHFC9uL705LFf8CGt/n1DobP60HpeF9LgW0wmz3fMTQDGXuwMrMwuKovX?=
 =?iso-8859-1?Q?a7Y7PBVjmTysHuqZSr7r9P45wCZpdZklvgBVTXvuEgr0HtzXgVgV/Q/f0f?=
 =?iso-8859-1?Q?xQZ12NEHmzaYvXlQkKRSHJLnRd/qOcrBp/gs9CvYT9kPq7SKN37Q0cwhRA?=
 =?iso-8859-1?Q?sbaJGzf9kBuGfKdl2Ar4b6DKeC36YVDyrCGODLf2J/6PEy9NCmfhrqrweb?=
 =?iso-8859-1?Q?fKSlwcQ6mLIF9kDjJhILA3rIYBYSBGIVjiSYeo6F12CaLIAq5S5wZUGo90?=
 =?iso-8859-1?Q?sPXZnvD84w2h79BzasQlaa6yMbpF1LfAn1Ik7L5lChIRPvYUWaaNH6IkEA?=
 =?iso-8859-1?Q?b3aw2gqDAybqpqNarTNWKA/17a/OHqlD27aLj05zOsNzyKkE4uCA2ihJsn?=
 =?iso-8859-1?Q?TobXJ9h0CfOR0c3u2Z7YI0tk6q88lrIP+CatRMtn3e2SKyrVBPoihkhh1f?=
 =?iso-8859-1?Q?qOdwRjBGpZps8E0JMRMTl51H+9GdSLoqu/7qGgvNK43WY9JHwamyAtElCV?=
 =?iso-8859-1?Q?tgexRyqvBE971CC8ZIYhN4DnBChqrPX8qL1bFY6lojBH4cgBhmc4TC5yh8?=
 =?iso-8859-1?Q?CYKP0+XtfYWGyifWweEIpL7Zqmno2mMqdZfnFRKXAA3/BEUFIwtZhRyYtl?=
 =?iso-8859-1?Q?kQhxiX/aWAmJsiM3GT/6brNA6co/ccgZEpwbxvJL+2S1SmjtXO0CHxtFF0?=
 =?iso-8859-1?Q?5pqiQhYoMs5g/nmJ0dQ9YwT5vrqgmI66METtqKLXCfKM/0aIobzoYemZOV?=
 =?iso-8859-1?Q?O9jhtERaeV5eLwxezH3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-7da6c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR22MB4048.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ef0ed7-9a8c-4019-a10b-08dd3ad42bff
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 11:01:50.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4539

Greetings,=0A=
=0A=
I'm trying to implement a hands-free phoning device on a raspberry pi. I wa=
nt to write a simple app that triggers a phone call to a specific number on=
 the smartphone that is paired via bluetooth.=0A=
=0A=
Can someone tell me if this can be done via bluez and if there is example c=
ode for it, preferrably in c++ or python?=0A=
=0A=
Regards=0A=
