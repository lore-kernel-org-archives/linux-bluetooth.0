Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2113.outbound.protection.outlook.com [40.107.100.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE1537E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531604; cv=fail; b=taGrS/X1uKgN4SQayzii8a9cm3d6FncMFFkT5M4ic1hWM5E8dme17bro9k3yncmgFIll4frR+pl0K3L0WQj570Es86HCpt3zrXnzIok8g2LAuP5wzlGhbbEdhBn7bRWgbgyx0F9lafRVgadpCav2WKaNZ5IeypPIbTDXEm3XJu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531604; c=relaxed/simple;
	bh=3LzYH+JeU2YCL4XA/fsABGpEF29OwJOzvoPY9WtX/+c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bddgza/RWFDvCAQEklkpHLB0RLIIfhHWWj7hMkY5V/twm/Wb+4YY1iTVlfaTtotuxZKvf7h1v5hNy+7jx3AAb1X01GSbeOX8d3lZzeGeaNmeA8+Kk8rJjSla3lqeXP3bIZE8Mm7XECyQ6Kye+IhTrIyCJgK/ORo9J6l4OuOaQ+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lairdconnect.com; spf=pass smtp.mailfrom=lairdconnect.com; dkim=pass (2048-bit key) header.d=lairdconnect.com header.i=@lairdconnect.com header.b=bTBRw39M; arc=fail smtp.client-ip=40.107.100.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lairdconnect.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lairdconnect.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lairdconnect.com header.i=@lairdconnect.com header.b="bTBRw39M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeX4/BQsHmega0EcdL6tPHH8fdgxDrR7yqpf0P3OvmNsUvLzfnG2TR05B4UskGo7C27T0G+ba2hO4WzE3D+37R/D8BZz82EP9YS897hlBLn29EEbDjbLAVWGKG0Xy9vI+rnDRqPuOFapmOz5S/QoJofVjR7vyydxXWiI377ktMMeCDOYABAUsfIW/X5WpjbwpgfV0vCWm3Qx6XXmADXqxWz/8FOSY+AqupbeVhwfyIqSw/iXvLEoa+Rm1VQmG7yWGe3iO1MIRFimfAj6ntcx8phjwciN3j/MauicziBqphv1sxcbFmqB7Z11i0mykXwjUEHzAje1Xon/6yOpug7yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LzYH+JeU2YCL4XA/fsABGpEF29OwJOzvoPY9WtX/+c=;
 b=MJNcICnc0mZCLztlfrOVMjwIpuUNuSfFcg2qZ4JeFFzsw5dYc3hZ5SDzmLjB3prPGsRevlYEsCq93lszW6ksdqLSA4KdyV5bP8bPiJXqtLBh7awYggGK4k9WydmohuYKS7fT2TTuVhYp6fMvZtA1xtlpadzjuhMlww9IpQwBC/Zwr60K5aJ4WYCPxBAeKgRFY3erZCupO1SuFQuyhpHo0lcFB/4gHhMir0sxtADIgX4BVg8jVT4YcfP/+5pD04v7xr7JdvjCYKjGR9iUbQQXsJTDlWfDsSrgH36NiE8Qjd6ldoQOIpqcB+FpYyRfG1CWiSgx0ojC2gyIf9FhxpXToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LzYH+JeU2YCL4XA/fsABGpEF29OwJOzvoPY9WtX/+c=;
 b=bTBRw39MSz87PBXzPC0AL2fT17PjJI2KgUg0Hc0HD9zK/WgE22zziYPuiBLGDO7UolExzQk5Yu4LF+qnOM6GUHyl5dQt5hF7LMpIZB3PtXDHeokZLfuXJSNQJl0pKGh+/54D23opeHEcizfxlA73oL11h2KAzQDr7S9j1B2EWRg9jjjsb3bb8nf200sIqRUDEMRRJENHm0T5fZ6wiCeAsQZiCpCPzE909L7UTcYYH32XYY7xLuxb945JCqzt2ji89aqmdIBUiR7thleKQgSCSQTJ2r/vyGzx1xaw5AV8hRPBl69ZJuUpk/PuQAvTpDvQHw9/MDELUsj9yJXvVQ/zGA==
Received: from PH7PR14MB5300.namprd14.prod.outlook.com (2603:10b6:510:13c::8)
 by MN2PR14MB4205.namprd14.prod.outlook.com (2603:10b6:208:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Fri, 15 Mar
 2024 19:40:00 +0000
Received: from PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a]) by PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a%4]) with mapi id 15.20.7362.031; Fri, 15 Mar 2024
 19:39:59 +0000
From: Chris Laplante <Chris.Laplante@lairdconnect.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Bluetoothctl Fail when typing power on
Thread-Topic: Bluetoothctl Fail when typing power on
Thread-Index: Adp3D3vbygkaF08KTA+3pm5SLMwpuw==
Date: Fri, 15 Mar 2024 19:39:59 +0000
Message-ID:
 <PH7PR14MB530075545340A73BC4BA353EFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lairdconnect.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB5300:EE_|MN2PR14MB4205:EE_
x-ms-office365-filtering-correlation-id: 062b583e-9e2c-44ea-2015-08dc4527b384
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rvQgE6jr2rbXxrIU9aI5K1sde2DO3RO2k8+pOUaqfH6CHts+dW77l5hWirWinu96rJ61B3q3M8pwZ3YQZfpKJ1oVqcMfhMLba3St0VdsaYMsv/suOIIaPdKD4Da8MX3ufGmktwZBbirmcmq8YZmJd65Wj5rGLfqgWxbOAtPt1RybpfnaT/+/NGDplWpzmQtKliCX7WnunEz5wGb8RYb/oKz3QhH2gnjYAMiZWMeNLWa7v+30G2xFFBIFit03uiFSqs/m0hw2+2RUY2Ba2lZUArvYXt7C+D7KHGHXB+FJF5HV6cE3gSY3YIzrgO4RpfX9L8zSAraUa/kB8Md1EnRKZk8pZZKdjTzNO1UQYMQ4jgt0U8t2AMYjDjf9xs0MDchRybP8NaZTUwLNqxc0SOs/lCSlphwzF2iPXXcfOHOu71pBKWge6VjgtLJ8dxCL8CUG/qf53UzDOyhJfkynJAZysjSNpthKfDz+iUqekev0B1phKEnMam6cCcoDuY8QVNWrRuGykB00V6yvvq78TcCOKmNbkxTvyhwwmSvl3/9AvAEwAIOtutFRWoSlUMluLRFCXF4XFtYM/reCx2TT3jgiYDImv/UbHfmgVfPAu9q6nj617z61C5xcpPlk8Fs1gerAjyhSl/PwhXD2sYL7q/EPld3Q3bqfnBbV2qkVtbwZFgYD2mB4JF+2nh+JcnNpIu3+rEusWQo3JVugBZhEv7Lo5g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5300.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?10I78MfpoiDN6zJvxDOU1od6i74FgA77hIvNg/Gk7aoDnxjp7dTSsv5ZRVjY?=
 =?us-ascii?Q?A83ksOnO9R5ZcHDz7eadH6jPPs/vW8uyq7askZqgfPXmYgRU37LDOp8Qqr2m?=
 =?us-ascii?Q?wqe8US4xuBi+m8SqU7AuPfHLNwuL2rd1o7HHy2TYHRnrRtaJuzatHQkQc3yV?=
 =?us-ascii?Q?6dTiD90VmqypROp1GSSzDggvMHeKuDd9IYG4/guiZ76PNA/Qw/or7pcp7E/7?=
 =?us-ascii?Q?ZQdaysfxSFHMZsKznam1JAf7C6xjwyp0nN9nUCbcdfCD0AJUs5tfPdblgxy6?=
 =?us-ascii?Q?s9g0D0qBfJf1uDqtHKOaeLD3UNXZDGdKOijsgeB2DvL7pKQhLe8ifs7mY+nL?=
 =?us-ascii?Q?SxjdX3sly9UWvbNYcUR37JFykgMykfS1662JkJh6t5bMuL1KJk+EHuiSzlib?=
 =?us-ascii?Q?jzQOdSzMHtHCT/DKLn5fHqAnpPhgsNPRZ0HRuNHxgaf3zVE38c1K/kWf6sX5?=
 =?us-ascii?Q?yOjPbZkaVhVBxydECO+7iOK8OLNnPRUlUbMfiwrxyIIAfdQifpE+1HPm0ucH?=
 =?us-ascii?Q?4q0we4/RCByKpBlLXotnSYndnD6GN4HznoumCp4MlBv0yVAtXm3Yfok7o29U?=
 =?us-ascii?Q?ANkrVzlMhoWqrtaNn6lJUR9gw/GxjJos310Wd90IzJsPfpy4z77B6JwN/N7F?=
 =?us-ascii?Q?3kI7qHaXujCQeGgRc70CIa6QtU6b4Xno14iZXVwxiIisJTeRNAfMhhYXzbaT?=
 =?us-ascii?Q?1A2rsFXoOd76i0n4YbOUxGVj8M6z8eXzytc/qkiLBp0nk38119BpmJFB0BkL?=
 =?us-ascii?Q?RZ4SflInHf85t8eEfJt7tllQs84NmDI/QSqeeXwqnLRxM2Qu271LwZuFWq4g?=
 =?us-ascii?Q?Z23GRSF00lOuugAqAO8sTU4rpHc5Tp//o49hpu4IJNbaNIypXHDVXqgxEYXI?=
 =?us-ascii?Q?O2K2MxndZURLuLtM+PwvA2VLGFsjEZdEAmfYfuUExw6+7BgfOMoun+miPJcj?=
 =?us-ascii?Q?vMe3A9xkiPxB6HKnOW02KV+VSHyD3eY18mpgf38q3XT+uYcadB9d55IUEjJT?=
 =?us-ascii?Q?oNh2a1gjSp7CBquc/YhYZFpyaA5FqmLTKUGTw7X+YGzdkipK/8pVsl/yx7AQ?=
 =?us-ascii?Q?6XN8onhzAxA74ISK+pxPgfgtgQMwYnzdQjNnmpM3K/q470+IBfLJba60FYeL?=
 =?us-ascii?Q?3gkeADgvr9j+swmtmQw2q83N+rLM6+Y6m/Hf57dF9TtnJZEDA3vnnXD4qs0c?=
 =?us-ascii?Q?veYtc/ZkTTekf/oTEFr+dE1TJ87FLUeI+o6/tCV0M89zNRc0ecNpTXgpM0G0?=
 =?us-ascii?Q?u80M9EqcoaTB0seRZl4wok7lSZtkgiQdiwHoH9QLwXvEDCvnCDR/bybtQQDg?=
 =?us-ascii?Q?YHy4V+xfSBYywG7yl4puGFii24xdwQN7WCkluXxYlvZs5LYDpeWQEUHSn8b7?=
 =?us-ascii?Q?Z14Qp4GhSOaxabnAkA5gXsMBLf0wvzwYnLMTP1uR838O9GXHgiMh9au/oQSm?=
 =?us-ascii?Q?DTbg7ZH0dVGZxiwWlNHH+MThAZ6idhHxrjnvyAbgLovPlgDZGFvPO/OQBjTB?=
 =?us-ascii?Q?H+YiAv+pbiG4W8ScVIuyDSJKiqYsL2h+sOtaFLkfyd5RXF0qusJ3uIoaPoln?=
 =?us-ascii?Q?ePoGBUeFpp/cBtp2xTDwx6XJa2wpBikxe+SqA4N6qpnv1A1W/eXC+qd77isU?=
 =?us-ascii?Q?XOsm4yKDHtdgNX1HhZEpHgJfykLTBVL7vcHN4kwI9CsXvjj+3nziWBsYNmxi?=
 =?us-ascii?Q?TVnNgw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5300.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062b583e-9e2c-44ea-2015-08dc4527b384
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 19:39:59.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I89VKqNHO6mTAzdIKZQsU8nERRkL7Zi2o6Un2r5FCu0OFKOz26HbwgmmBoB/YdvnVQ/RGnGWLdwqS7cSnaKXQv/vha+5JCG3vwsBieu2DJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4205

In BlueZ 5.65 I am able to attach. When I go into bluetoothctl I can see my=
 device address. When I type power on I see the following error:

Failed to set power on: org.bluez.Error.Failed

I have found a few threads online where people had the same issue but there=
 doesn't seem to be any common denominator.

I have tried rfkill list and nothing is blocked. Regardless I still type rf=
kill unblock Bluetooth but I still get the error.

I have tried to stop and start the Bluetooth service.

systemctl stop bluetooth.service
systemctl start bluetooth.service

IS there something in the build environment that may be missing? Any sugges=
tions?

Thanks!
Chris
THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND I=
S INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RECI=
PIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSION =
OF EZURIO
