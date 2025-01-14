Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46E126C0D;
	Tue, 14 Jan 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864469; cv=fail; b=jz8XN2y0lQ4SgH+aRui5ERqWxDz0G0HUYrEYKKvz/tonxJa8Lav+d5MBrxUzNpXyLK8g7ZDfzIPvqb2QhhXId7cWc6+yNPcC5YaDAohcdDjJcG6ibxVcIDHhpRJwgVK2tC+Rsdyo5f0pJ450uAUIi32gSAM4qPThfQIIVT5JNqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864469; c=relaxed/simple;
	bh=ulHuXFflD7+qIxHf4L/irpWqf0GI3USWEpRJVj37XN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSwUXlaDs6k5aUa7RMIpqYJ1yqUXDn3YZ3MZPVnfI6fpN3e/K3AUIb2OnXN5BhzA+bNmWpoFOEaBlJ0gmwyrs/Cd8243Na3jp+a71Zr5vs0aq9pZQrKE/YHA464ijlYnKf4Tnji+KfU/u9WbHPbOm3HWiAFjxFhF/wu5mDnLXKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYMBfh26; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYMBfh26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6HeU7FlmgpAj/sqTkVp6b40gXSCw4DOa4yy/olmyL2WPWoPrqbeSmlCHEqHQAvAvmjSUsn+IrQCqe283d3FV541KTyzuYgpp8QyVS3cOqYTW5qft7ges9svTNxuF8x9z1a1UpPJ709M99fVm120kNOShxrcMSwM8uZRDeHYCv6+BIzNK2Sx1MfR9YiwkzTQ8IFt6clFrHjgPMsA/1cKdzFVuVvKEBT9pCGisLYE8BLYEQZbzX+nYEpnuLypga02hSwS+LqU1sTILveTvSiZcNq3LdjTxr+ZDbNN/yeRPr5g4h3OprLy1SZ4IfVsq5wHijujqYYj95YMya7VgyddUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw7g1mP/8XdxkJxAM8+KC0/dsnk8r/auJson2HjXJQI=;
 b=SU44VJWDPSur3Yum3EyPPWmnONsQaaO0At4cl1jeVyXeO9FfS5a2oKiewJ3SDr7c9/Bxho4VqKq43ZGodaRSUQCRRJz3mFjcnXfA3C/06iayrszas3fr7Lf6VxTeq5eHTZKRY7Wcu54+a/nWqJ97U01BROPE7faAygm9oplL1jlLIgSUE+Oy/SZWIGhZ9m0f84uZ/1P55Ldyj4Sbsgh3j+kZzv6cAb+E08BZQX5GIJXwZoYfnO0P+LdV+Ed7re+PTLn1v5MpxW9xogzhJA4BCRquzT3mxWU8zftp1Tfp0q8ZMI1kjPUsy1+XpdQ+oHVouwbxawoq/KfdAWzXkPpFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw7g1mP/8XdxkJxAM8+KC0/dsnk8r/auJson2HjXJQI=;
 b=BYMBfh26N+5KNSBnRAZ9MgVEsrGk54nT3sPeB/HQJf5TJOR56bhNPKXOleXro4guIRQqmW+A0vMN3jzv16JRiSnzBxsHjG4sLP/+up+IBmKSpQraRRd2QInlX/JR5QQFagkRUP4pjhn/fHyMG/bVVdDeK0r/Ws9rtgTQUHLpTWP3HZ0nX0bvCd7p2v/IGPgQwTB0ODrSV0X8WmI8SwkRZcWax5clBT0FipKkFLVDXZQIjTnGuXFvOZ/XRwLOwbkk2Gu/BDnZEQFAPT6b02uAP7VSJW2fP83Ckhn9TcJyyLR1Ax2r3xNA3vg/iBkSksqYnYdI/gEL5BStxGp4l25rcA==
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.19; Tue, 14 Jan
 2025 14:21:05 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:21:05 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, "johan.korsnes@remarkable.no"
	<johan.korsnes@remarkable.no>, "kristian.krohn@remarkable.no"
	<kristian.krohn@remarkable.no>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Index: AQHbZo+LBDIIbVsdqEaGgnfpjAGlBg==
Date: Tue, 14 Jan 2025 14:21:05 +0000
Message-ID:
 <PA4PR04MB9687CB44A442FF6626A3859AE7182@PA4PR04MB9687.eurprd04.prod.outlook.com>
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
 <003b6048-eb38-4bbc-8c83-31d45f0db46d@kernel.org>
In-Reply-To: <003b6048-eb38-4bbc-8c83-31d45f0db46d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9687:EE_|AS8PR04MB7750:EE_
x-ms-office365-filtering-correlation-id: 880b30ca-c285-424c-63d8-08dd34a6ae74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kb5rKA0wWK3fVUJL5TpEK3way5PgatnB2gKJxvAHL5Y6bavkMvvQPEZMPw+3?=
 =?us-ascii?Q?G6zPkhOG6f7RgZIMJb4cKk3XMs83i+bAycuNYXCSQ4kgdBvjgQMlIefzrsl2?=
 =?us-ascii?Q?KdpM3sYXEmbtYS8i066PhqtX1+T6EsY4pzr/kO8FPJ1S3kVb45G+EhuwGWQS?=
 =?us-ascii?Q?eJ81gdkNfQH6MBRIZurw+bV1hthWKYZJj2LKr5UEF8ji2E9od8rZTcD+TnVA?=
 =?us-ascii?Q?qNITGWriFF/hR4I2r9+0vNCGNh7Y+UAVBrtNhaVt8DHSJwe4l/26O2SKxgGf?=
 =?us-ascii?Q?cvyciSACkKbLZ6YkMgW5wey7SjKJCyFH7div05yRHhJ+eT5J7oWvVs1ag2mC?=
 =?us-ascii?Q?jkMIwo23ZgJlN9Q8X62NZraIF8TKT8SKfZ2C7BkskorLDUE22kaonC0me/yH?=
 =?us-ascii?Q?nUqoxoTzDeMizE8lhMacF2HKuU20Q3QxR3r+K0so2YhOylSuX+9tbFc776en?=
 =?us-ascii?Q?7UCIIMSWf9GVjOgIRfECw9rDrRqZdC9fz2+MobqsnpYsqTJ5bFd95d37pISM?=
 =?us-ascii?Q?T607je20TlRyxPs3kkxM/5WOGyT/VFA9moFeVursMX/CHfBGO/zQyISIDRaq?=
 =?us-ascii?Q?btuOVr81RnJMIzTK551SjwPjgbE/Qpp4AHlM3BicQGiXnHQbtm5ANpWc22Ry?=
 =?us-ascii?Q?KDQJ1g8Fa3u4BKIZhmZP0TZBEPO/ugrK0EzD5Z5ImP6Yq54Hv6JOQDbqJMCq?=
 =?us-ascii?Q?zkQJu9prrhmEEDWbVK92StZFtBKlIwfBy+cluwP3oYJcaT5plmWvNmcdrksx?=
 =?us-ascii?Q?rLP0Gthbf+me/bMy+FnlJw7vSl1e/4nIBcQOmT3qfoBpLxyo+qoDQx9SppWk?=
 =?us-ascii?Q?WiCUnR/Biai6mILuvU0nyb3OhyawybQaYH1DcFYkUhtRaDBre9s264OSOIZe?=
 =?us-ascii?Q?6mSla41TJYxpQfyAPeTaKDTcBd3U50spQRmShnwbsDuY7+vOHYCkOvnjDGaa?=
 =?us-ascii?Q?xYjdjKIQLoxXSLehPmjmSedfGtTmDlgYU954jsy6RGy1qFW3UEZEgswFy0MM?=
 =?us-ascii?Q?4RgSxvnzB15OwyqphatR/q2w66rgxiMYD5ljlauRi9PYD1LvXbUsMyLgfAQ0?=
 =?us-ascii?Q?w9sIS+qFqC7xQZpyyDYvbP5yWdKlVBNhEeLneNysvx795cWjiii4oU7N5J2R?=
 =?us-ascii?Q?HHVX5P/RaeS56FtT1sEaIfjwPkcRrpTlZctl0rV3wASIb4AHwsprK2iPBdXQ?=
 =?us-ascii?Q?X0F9dHp6BBooPvJFSxQveFenp8t5zxEK4W5KK4X3Du9NDkqEf2hkqHmb0spP?=
 =?us-ascii?Q?OoxyET4kdyv/hz3GhGtFNZOtpCQ6oFYiNgYItuh+fHWaxm9ocx7eW01TXxP8?=
 =?us-ascii?Q?OkYhDMD7SwqdA5e9E7dPUz/EqSPZDzfdSvXQNJwl/7sg4KEBprGiag5f0Et/?=
 =?us-ascii?Q?nK93ODleuSJHN3uIdx6z3OpES9As?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QKiJPKZXdxsWfl8Bu5sLMFBskxVPk2dCb0Hjy/AtUK///5Yt7gsJ46j53k9o?=
 =?us-ascii?Q?CHGlH/mcBUbYELV4hMe7Ym3D1jJWE66Fu+0+v+NlQn6NqNddJa5gJPloYEwC?=
 =?us-ascii?Q?VLKHblRVgUlX0t8qVzTFJADCRre3Of7o9BajEleDr2GbaueEwWN84yCoyyaU?=
 =?us-ascii?Q?4hYRT3Znle94641AdvZk2xcY8Bdxke/OX1ncNE+LYH3VRQ5Lu4el8mAz57/0?=
 =?us-ascii?Q?ily0ei7jaj/4b2Lw2bwSCEcI7il+zTLxmOECdxbIFEi46+z/iaK9qz9Zm/+v?=
 =?us-ascii?Q?r7mmUGe/YqVlMef/3HPVYsbtrGVn3ZrsOcIQLcDF3UoQ3+vFGAq4xr/ioeB9?=
 =?us-ascii?Q?Dmdd96U+GvK1OrlFwwvjdTJ/p4PnNvNWXl2OYRL3kMgsXD9bVYAGEe0wEB/P?=
 =?us-ascii?Q?3+/UwNwieHZDLcyKVvNaRIfv1FmER/ZHpGjbwYxTRy2ai7RCK5iCzn01d02q?=
 =?us-ascii?Q?33AnhZhhm483/BIYg4BEpNL5cfhwP/Qeh8NE4ycwEc3DfezAJzDK59U/fQPL?=
 =?us-ascii?Q?G0EpCRIUaWirMrwDrj7bueeH5IaDn5uDV9h/VMbIxwldvVXh0DjcodcgLymo?=
 =?us-ascii?Q?vJ4xyYnUlgnc7+BMTtvH25xR7/aZhlp1oYz3aCyC+kAVBlVdlvXrczafFyZz?=
 =?us-ascii?Q?iqCpDMbNMBGInmSnbWU8I7M7bxQ2RKhvpXgjZIX4HJDToZSG3GnOW/0LjpRz?=
 =?us-ascii?Q?EnvhrmtH9ofU2CJdXMTrY1qKUEFPAF/CE6/l7BhQ8kQTBF2bwg9G6SPEF7XV?=
 =?us-ascii?Q?wkJSmhgDwZyQzSeJ+8TxlvdnoJSMs9eZRMTB4Ae4SOZzBpagnLgF6Kqt6B4v?=
 =?us-ascii?Q?eoDUetVRUAG6sA958EXkQiT3/f1tdHFTgT/BwbYnQaFyMCNYZHZBi1TyGp3a?=
 =?us-ascii?Q?DE7NBL2lRud1BpWmZVfmzkLFDt7ANlGZcZ8qJ17PhYrAh60ccdIcK3JLKwRY?=
 =?us-ascii?Q?y6dhS+sDSb7W1XzBEZtQFgobDU41ZrboX2+cCnka7aaMgbZ53tiqALKvDhba?=
 =?us-ascii?Q?CpcDhMuBLRLGnD694gGMTMGhGOLOCYx6D3+8psjNU134pUK/ncbRmg82lFD1?=
 =?us-ascii?Q?DpzNB3q+CPNodeZlB+KIXVXJSn/QhKDEObsiGoTZXiiuQhgUXdpWmDO22bK0?=
 =?us-ascii?Q?RHNYykvgum+qL/drNNhOIUrJwk2yZdwZ1PCvIaN5fC/0IMAKvYNqhQrRqrto?=
 =?us-ascii?Q?4TdBvbJaHoFIcp4QeKYDeUm2hmNZXlv7NuO3/x8p26z1nVLQUP7Nzp+5XCKq?=
 =?us-ascii?Q?7bAgzRARlMxF8yHIpTiMTdvGOls1HGhoOJ/zf+jkbsCL7RMBPUNbv5ke05p2?=
 =?us-ascii?Q?Mxim1mz+MwPqxg2iUALB9JJKGIO2p1JnxU+AQk9fmyPedmDWQurpJIeVpHPg?=
 =?us-ascii?Q?d46K+Gwt7PL8W5hYG6522hjrWMM1CYBVTCWdy3zcz0Yi9bAVIS8X7ewbYx87?=
 =?us-ascii?Q?RRc8SxRxZl8ezdM1YA7+VFNHnX3lyNN/7bbjTLkyWyf6qQCxFLhkqsjA7xXO?=
 =?us-ascii?Q?oUnAWtKwl2Cekk9A4fKWDzFap/W53lwJtKrrfGxF2iJM9KFfGjCeJ7qSiRm4?=
 =?us-ascii?Q?+mwRCzEcbrE1G0WZs8QLSUQdinveS46U9YuH6t5x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880b30ca-c285-424c-63d8-08dd34a6ae74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 14:21:05.2512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vcce6LJxqiLUNuxnc0NcwlurKdIkcAlw9FyJUyjqEwcuaheJjBVEhFSmHYNU952BrLR79wMSU5DbZ1ee/kQ5W3eoc6pGoSLrxdr+Du3R0WU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

Hi Krzysztof,

Thank you for the review.

If I understood it correctly, local-bd-address property would be picked fro=
m bluetooth-controller.yaml ref. Updated commit msg accordingly.

Please let me know if any further comments.

Thanks,
Neeraj.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Tuesday, January 14, 2025 7:09 PM
> To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Amitkumar Karwar
> <amitkumar.karwar@nxp.com>; Sherry Sun <sherry.sun@nxp.com>; Luke
> Wang <ziniu.wang_1@nxp.com>; johan.korsnes@remarkable.no;
> kristian.krohn@remarkable.no; Manjeet Gupta <manjeet.gupta@nxp.com>
> Subject: [EXT] Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add
> support to set BD address
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 14/01/2025 14:35, Neeraj Sanjay Kale wrote:
> > This adds a new optional device tree property local-bd-address to
> > allow
>
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.b/
> ootlin.com%2Flinux%2Fv5.17.1%2Fsource%2FDocumentation%2Fprocess%2F
> submitting-
> patches.rst%23L95&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C84b
> bc484675244ce050308dd34a0d9ac%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C638724587636722337%7CUnknown%7CTWFpbGZsb3d8eyJFb
> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWF
> pbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DEH9V57j1ClNq7VMsUt%2
> BzcZ3sisbeSIrOCogGt02Ca1M%3D&reserved=3D0
>
> > user to set custom BD address for NXP chipsets.
>
>
> >
> > Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> > ---
> > v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> > ---
> >  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8
> > +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > index 0a2d7baf5db3..5d75a45cac14 100644
> > ---
> > a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.y
> > +++ aml
> > @@ -17,6 +17,9 @@ description:
> >  maintainers:
> >    - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> >
> > +allOf:
> > +  - $ref: bluetooth-controller.yaml#
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -40,10 +43,12 @@ properties:
> >        Host-To-Chip power save mechanism is driven by this GPIO
> >        connected to BT_WAKE_IN pin of the NXP chipset.
> >
> > +  local-bd-address: true
>
> In case I was not clear: drop. And rephrase the commit msg to reflect thi=
s.
>
> Best regards,
> Krzysztof
