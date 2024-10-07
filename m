Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8601D26F1;
	Mon,  7 Oct 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305919; cv=fail; b=g/z9RG8/Ip/ecc+MVVkofhDyYnkncCgNjCeAq6WHLIzEfAgTs5scozvTWHwo+zKseAg98YTYvQkZIKO7IcI4FSMtJ/4/NPYaUcg2gfOxlyyapYKa1tIRIuAOJgAl4/LuQHitt+/rriPc6Zmhp9xPShRSsXJs8SwLXl3fEHOc4mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305919; c=relaxed/simple;
	bh=RHcsUFWhyIneBlGV0oUB3twvew96LfEYLBtd0xiH1tE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o7EV0L/NenGn4OiG94uEcpNiH8S6ooZXUKpft+PuMkf+YdRftCVtKSoz1pGs0bpyGdC5c/wh+82c39eodBbEnZw84/YvoOM/TkUJV7Ys7Q7j8/6asteY8AEnvupJj2k2UVkzMkIi4fqU51RfSonvynadaFc+J0vA117vZC3Q3b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=FOtwXBUD; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="FOtwXBUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0DqvgMaxP0nU0gvHd/DSkFd5oKtZhfxvFAqIGbRvQ3fjqUwpjGVlixGgeADiy6cvs2KAvAK/HLUInDnAY3ZbiOJ2oMEm2LC2/vgVY1DiT8BcldBrfQtD9enA2yYD18k/bVOhfjOYVLXH+97jkFuDSJjC3awpqR9jH/1tkQwNWsI3Rz+HRaqjy5+ovQzZ/yasYBumjmVmGgbDEmj34C6qUkKCGSbqgI/3T9K5HX56YK209rQR7kdG8HY1g+oCSJ8BaKiOLSoZ4CXX/VtgDHfh285qRTf88C8o9HjtKTYo6hwWKxXZsYSgxvffjr7T+55qkPJ71mjjJFHnMEapVsK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHcsUFWhyIneBlGV0oUB3twvew96LfEYLBtd0xiH1tE=;
 b=yn/d7tB9+BW4tQ06sIstI3z/vpR8l6gStt3sJWn6lDmn4Sk1w6oranTM3aEOXi3UImcOS/keesdmAdVYOcr8AUNOoheHWxWxpniIwA7NU4yV3WPpB6ApegctUDhky/LKY6Qx7c90Qh3MqVQm3JEMN5yTTEZ50jjiz/+TELihf84zU0tFPE2atMI2FInAG1AvbW0OxhHs54Lly7XDaf3kM15qygeaZViCNan+tn4eW8HqBOejlkscFmbSazTx/2B20ZD11Z8dH79a5F3AlFe9jlHCRT1/g/WNI3O7WNsEk6WHiRyejdjv5qcCM7L6/QF+iyd7PKvS6m9gxHT5BrTdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHcsUFWhyIneBlGV0oUB3twvew96LfEYLBtd0xiH1tE=;
 b=FOtwXBUDi/e/n9M4P5JxLvANm7R1H+XhE53F927Jds8Oaown+OzZX7SCDJiJxINHCyAraYWH136rEGSZTql24A17S3mF+uj5HfPyKVSPMDumtBScuk3deqEFF49AsCjb7uRWujxMpixrkNcG+ZCZzrWhJc3lq2b3eQdMiTNnlgA=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by PR3PR06MB7052.eurprd06.prod.outlook.com (2603:10a6:102:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 12:58:34 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 12:58:34 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale
	<neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index: AQHbFlGYxegmsfkbQ0S2PUUKI4YS47J5bJAAgAAtywCAAao9AA==
Date: Mon, 7 Oct 2024 12:58:34 +0000
Message-ID: <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
In-Reply-To: <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|PR3PR06MB7052:EE_
x-ms-office365-filtering-correlation-id: b7f375c5-908c-435d-d787-08dce6cfc0b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHVkTFBETU9qNFFkZ1JiSk92NVBmeFc0a0M3bGZQRnp2cFR6bFdGeUM4WG9m?=
 =?utf-8?B?OXRXV09xamtEM3ZoRlQraUVMMDBzUzhWdE9iL2VNM2g2dWlQWWZIcHhpdjZn?=
 =?utf-8?B?ZkYzNkRFVm9iQUxUTlhkN0ZXQkI5RjRWR3MvK3ZMKzl6Q21NWHZJUXhFUVVQ?=
 =?utf-8?B?VTBxK1EwbkRSY202cWpISHV0RGRqYUU1UFZ6TXJueUhqVnlwNENaVHdWVGdV?=
 =?utf-8?B?MkJCNEc5bk5qNkJ2MTJsci9QZWlIZFV1VXVBbGlySnBsY24rVFRJZWZZMThk?=
 =?utf-8?B?UEt1aDdiWmZqU2dmWmZTVlVQL056MkhwWEZuRGtkbFVwdjVuTmlGTVp3MHox?=
 =?utf-8?B?VS9qTlVpRktoYURicHNlaXVPU3AwMGxYYjFhdjZIVXN5MFJNczU4akxOV29D?=
 =?utf-8?B?d0FJZ1NLbjJFQzVuWTNCcGE2emRLY1pIQThmdFhTSjViSUduNnBkdHI4aGU2?=
 =?utf-8?B?L0czUlhrNngzbzVwS2NjTngxT05BRUZLQTNVeEJKOGxQZ1BQQzFjRng0ZXc5?=
 =?utf-8?B?YXlPaWNFWjhpUXpxbXNMSnUxdm9ZTGpSQW9YVElDVldyQzkrU0psUmFmcFRk?=
 =?utf-8?B?QWF5ZjJoWTFiTCtUd0JWdWN6M3Z2UWxPRkV2WlZOdzZ1cEhZaGNPd0Q1YVlT?=
 =?utf-8?B?TnRGN2FnSm8yRCs0ZDdTR2E2UGN3VklLeVFDaVB3Z0VXWmR1WmhBNFFTMFdX?=
 =?utf-8?B?RVF0bVNLK0ZYY2JDZDdkYUdVQ2UrMnB3UzdVeVNrZHl4ajk3M0pWZG9OYW96?=
 =?utf-8?B?S3lTcUdhZzJ1OVUwdzllVjhJYmNod2FZMTdhbGVlWjJmcVh2b2xMMGd2SFhI?=
 =?utf-8?B?V0FhOHJ0TVpyRmQ2T3BrN3FBNE4xWG5aZ0t1L3dXcE1ITUs2YzRaTTBJaEhv?=
 =?utf-8?B?ZXZGdFFwV1JrWFY4dFp4M1c2Wk9GcmJhdHFORmo3cWY2UjFFWHhHaGNFVXp1?=
 =?utf-8?B?bFBXM2FZZXQ2VnNPR29Ia1dBbytrYnlXYXU3bkNQc3FpdTZtTU9UbS9ubGor?=
 =?utf-8?B?L3ZVVTk4QWpqTG9jTXFzV3M1dThRU3JOQlpsV2pvcUdXWUlsOEx4ajhwL2lY?=
 =?utf-8?B?SHVtc3BzdmVnZlpZQXZJWnNuOSs2WXQ5eEFSM3lkdk1XSmhEU09tYmpyMzZm?=
 =?utf-8?B?Sk9oUkV0cEVWU0tTM3REYVV6eDRaZ2JSeW4rZ3VMcGZQN0VpOGY3UUIvSUg5?=
 =?utf-8?B?ZndMemhnMVVPeng0VFJUazBVa0k5eDhYa3BmdXRNRXZibEdqNlJQczJXelhh?=
 =?utf-8?B?OVZLa2Ztdmg0Q1VwdDVBTnllM3M3OStSWjBId0x0eG0vWTJzMXpmS2xVa2Mx?=
 =?utf-8?B?bEEwVmdOK2dtZFFvS2ZlN05CWXNIM3pCV2JRMitEUUhFRXRDY3QremxISVR5?=
 =?utf-8?B?amR1MFBWZmZ6KzFMdFVDckhmd0tLSlB4cENSV1BSWDZ3R2tyRUU5ajltcVFT?=
 =?utf-8?B?d1g0dnhsdWpyMFA2cWkzZWJHOWw5cUxFWmNCd29sQ0ltMjFhdnJDWDZSbUVx?=
 =?utf-8?B?SWJJU01xUXA2Vk4xTnUvSzZ2WGc4YmV1MDJheFlBaW8zdUo4VWpZclA5aGpM?=
 =?utf-8?B?RVVucndNSTdYci9tZW9kK2lmMy9rNHhzaUh3Q0tveHpMcHo4djlDT0pOem41?=
 =?utf-8?B?STZPK0FxeTdjNGZFcEUzUGtOcHZPZ1pVVHJ6ei9ZN3AvUDg1MDIvMDRHRFNZ?=
 =?utf-8?B?dW5mZkNwcVFmME05WDIxQ2FRQ29RUm5WdHlhWi8rTzRTb0E4eVYyZGlGS0hm?=
 =?utf-8?B?eHZXZzF1UUtJemNScDRCT2M5R1hOT1JRUk14andjNmg4Sk8vRERnczJPampZ?=
 =?utf-8?Q?cmEIQbW5sd+t0w57Lw5zgn5Xv892uSCoHi8nM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmZQbXZORTk2d1FjVDdQaU1BMmVBZkFFY2RIODlOSjdVTzdIM3dTMDJCdjdL?=
 =?utf-8?B?NXhtOEpoZ2xzUVAxZXFuQmlNdFNlUnRtNTBHZFNLRGRNdUE2c1I4TkRBUmVP?=
 =?utf-8?B?NFgvb0RibkNuYUVzVmNoNFlDZTlpbnhJaUJuT0pDNmtBVFdXNXI5bnk1NUZM?=
 =?utf-8?B?Mis4NjZ5cm1RZWNqdjVmYW1IeGFxWHpmT1RCckQxZFRKRk9KU3R1UGFRcUxJ?=
 =?utf-8?B?VDBhaTNJajdRb05seUpnTWV6M1NPR3E5T2VzRGxXRTNMWG0vWTdZNkZMVlk2?=
 =?utf-8?B?QXpyL1dJQk0wMndqb05RWFJIMDE4cDF5c0hBNHBrWElWelE4My9pTnFUN0VZ?=
 =?utf-8?B?VU5aaEZ4dUVvTEJoQmd1c0Y5akhPczRpVnUrd3c2RnlEa0FjRFRRMTRndmtZ?=
 =?utf-8?B?UVRnQklZQ0ZrTzBtT0F4aWhzSXhDUG42ZWFlNmJBajlnS0ZmbFZOWDcxSFdF?=
 =?utf-8?B?Q1B0K0JmQ2NFa3VwREhpMnBBSTVlYldtMGVBYXlWRXhZR0xhT0tWdlNIRlo0?=
 =?utf-8?B?MS9TZWl2Zk04TEVvcVFvU3ExQ1JxRzVVaDk1M0MxekJuZE93UmlVVGdheHRR?=
 =?utf-8?B?UXg4MHB5akRrTUNYUFF4UytIcTd5bWxhQ3F4cGdYRFhPcHJsay9wMGYvWXdQ?=
 =?utf-8?B?OUt6MWUwMzA3MzNKb2VGbldJcGd6YlczME4vTE1ZUXp1eUdjNHVvN05YQzRo?=
 =?utf-8?B?Y0xrVmVOVm5xV1Z3SWJZSllZdXRCNEV1VzhPVnN3em5mRkh2d3d4eFNRYk83?=
 =?utf-8?B?S1hJc0JPSnlPL29nWGJ5dnhjT0E1Y3pCRWl2MmVlWFVIY2JlcUFWaDRJOEFD?=
 =?utf-8?B?UDNYQXV4eFR0VUZpempmckdwbTlQbjNCclFKQVIyWVlkTkxxbVR2SndmM3Zq?=
 =?utf-8?B?aUJiTFQ1YXlOTTlLV2VhY2lMRUR5emgwdE5DSklSVlNMMElQVG9jcWRNcTBU?=
 =?utf-8?B?Z0tmQ2JwS3FRL3JyWDlwYzROT1pqelgvRy9FRzQzR3BpT0hJN1VtMjY4MGl1?=
 =?utf-8?B?UkRCQjBHRWh6MUJKUlQ2ZkpJc2t4c0N5SjYzK0Fld29RYUZQZjM1Q1JVY2Yr?=
 =?utf-8?B?NnJvSzRmZW84OHBrdjZJZnVIVGZLODBMS1pvM3FZSW1BODYyTnVYa3dGNEdD?=
 =?utf-8?B?VUM2MEQwcGVyS1IwZnVXSFQxRTlFUmFPaVRpWkQwOG5NT3NkUGxnblRZdmly?=
 =?utf-8?B?am81TURHYjU3RzF2em5WVmV2byt6Y01KS0E3ZmlVbFFFeUVBb25iMVU2UkRR?=
 =?utf-8?B?UEcyYzRCV3lLa2VkU2NiQlA4Y0FpemxvZkFWUmFkM0ZFWk5oK0w0NlJNSjh5?=
 =?utf-8?B?VXJzakUrYUtncWUrN3cxNDVRQzZaeVJuMGZwbDVoY1V4WFJKTGliTFM4R2h5?=
 =?utf-8?B?UFhuK28zazF3T0RoV1R2TG8xZGZrVVpPR0FSRGJkVXBOdmU2QzdpWGdsUFFh?=
 =?utf-8?B?eDloRWVQNFJUUzBodUUxSFEzZDVwTjdDaG9mbDF0RXdkeEp2ZHFBeFNOTDh3?=
 =?utf-8?B?QS9XSFRWeGc0UzNLNGREVFgreU05YXA3SVpkeW5CT2VnNkQzSjlyNFA3eGJO?=
 =?utf-8?B?SWF2bEdzeEFTTnJjMkZCMktsRFFpZldFNStNTXY1bGJaaUVTcTJyVm5tNW9z?=
 =?utf-8?B?bzlXQWVXK01rOXFabWFMOURybEkvM3Z2TVU5Rjd2WE5hZ1dKbmdabDA3cTdw?=
 =?utf-8?B?QVoxWCs2ZENyY2YvSnVTWVBsNVkrU3h0ZCtBN3pLOXg0N3lzblRCbWk0czBk?=
 =?utf-8?B?Y3VIb1Y0TGl2ckVyaDJuNUFPV0lhZ0wyNVVnYjBjM2U3M2ZOMDYyRWZOQSt5?=
 =?utf-8?B?RmdpTTRQd0cvdkdQQzg5dVZ1UnRiOHVGSUdLTytzRXF5QS9EeTVtZGQ2dWdV?=
 =?utf-8?B?amJtNUJ5QW43QWwzdTJhaGVaSVlCTFZTWGpKVEpGdmh1QzdCVFlQVi9FN2xW?=
 =?utf-8?B?c3puRTc5d21idTNOZXdPTUVFVWVlK3QyVkNJemhvRzUwZlVPZER2bzhXSUxx?=
 =?utf-8?B?aTU2ajRvTk8xMEhtS21MN3hsQldjbEZRZ0s4ODR3TVpBYUNxSEJMYVR6bytx?=
 =?utf-8?B?RjYxSlBWZ2dzRkJ1aStoazJIL244V3lEbEJ5QjRjd25HaXl3T1BvWVFuczJs?=
 =?utf-8?B?RThUckpWTFI5VjRENlNnb2lvTlpFSDh6VWlnMFkvS1VyeVZxc0d0Z1BXbFNQ?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54C6F170736E54D966BA998B860C434@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f375c5-908c-435d-d787-08dce6cfc0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 12:58:34.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrgAuVkj2OtY4nT3AqsUMfy7XXqqJU8/OXYZco8YGxuy2hHJZJttSVCRBmSOsxI0RJN+mmNt2JhsM8JH5OCyOjV1eRRgtHmUnRIJqaQ6GUnpfT05lIrM5uRO/xFopd2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7052

T24gMDYvMTAvMjAyNCAxMzozMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW1NvbWUg
cGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZy
b20ga3J6a0BrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFp
bCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUg
Y2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVw
bHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4gT24gMDYvMTAvMjAyNCAxMDo0OSwgU2hlcnJ5
IFN1biB3cm90ZToNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9t
OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4N
Cj4+PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNCwgMjAyNCA3OjM2IFBNDQo+Pj4gVG86IEFtaXRr
dW1hciBLYXJ3YXIgPGFtaXRrdW1hci5rYXJ3YXJAbnhwLmNvbT47IE5lZXJhaiBTYW5qYXkgS2Fs
ZQ0KPj4+IDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPjsgbWFyY2VsQGhvbHRtYW5uLm9yZzsN
Cj4+PiBsdWl6LmRlbnR6QGdtYWlsLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5l
bC5vcmc7DQo+Pj4gY29ub3IrZHRAa2VybmVsLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZQ0K
Pj4+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+Pj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbS5mZWxzY2hA
cGVuZ3V0cm9uaXguZGU7IGJzcC0NCj4+PiBkZXZlbG9wbWVudC5nZW9AbGVpY2EtZ2Vvc3lzdGVt
cy5jb207IENhdGFsaW4gUG9wZXNjdQ0KPj4+IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lz
dGVtcy5jb20+DQo+Pj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IG5ldDogYmx1
ZXRvb3RoOiBueHA6IGFkZCBzdXBwb3J0IGZvciBzdXBwbHkNCj4+PiBhbmQgcmVzZXQNCj4+Pg0K
Pj4+IEFkZCBzdXBwb3J0IGZvciBjaGlwIHBvd2VyIHN1cHBseSBhbmQgY2hpcCByZXNldC9wb3dl
cmRvd24uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFsaW4u
cG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+PiAtLS0NCj4+PiAgIC4uLi9iaW5kaW5n
cy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LWJ0LnlhbWwgICAgICAgIHwgMTEgKysrKysrKysr
KysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgv
bnhwLDg4dzg5ODctDQo+Pj4gYnQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LQ0KPj4+IGJ0LnlhbWwNCj4+PiBpbmRleCAz
N2E2NWJhZGI0NDguLjg1MjBiMzgxMmJkMiAxMDA2NDQNCj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny0NCj4+PiBidC55
YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVl
dG9vdGgvbnhwLDg4dzg5ODctDQo+Pj4gYnQueWFtbA0KPj4+IEBAIC0zNCw2ICszNCwxNCBAQCBw
cm9wZXJ0aWVzOg0KPj4+ICAgICBmaXJtd2FyZS1uYW1lOg0KPj4+ICAgICAgIG1heEl0ZW1zOiAx
DQo+Pj4NCj4+PiArICB2Y2Mtc3VwcGx5Og0KPj4+ICsgICAgZGVzY3JpcHRpb246DQo+Pj4gKyAg
ICAgIHBoYW5kbGUgb2YgdGhlIHJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHRoZSBzdXBwbHkgdm9s
dGFnZS4NCj4+PiArDQo+Pj4gKyAgcmVzZXQtZ3Bpb3M6DQo+Pj4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4+PiArICAgICAgQ2hpcCBwb3dlcmRvd24vcmVzZXQgc2lnbmFsIChQRG4pLg0KPj4+ICsNCj4+
IEhpIENhdGFsaW4sDQo+Pg0KPj4gRm9yIE5YUCBXSUZJL0JUIGNoaXAsIFdJRkkgYW5kIEJUIHNo
YXJlIHRoZSBvbmUgUERuIHBpbiwgd2hpY2ggbWVhbnMgdGhhdCBib3RoIHdpZmkgYW5kIEJUIGNv
bnRyb2xsZXIgd2lsbCBiZSBwb3dlcmVkIG9uIGFuZCBvZmYgYXQgdGhlIHNhbWUgdGltZS4NCj4+
IFRha2luZyB0aGUgTS4yIE5YUCBXSUZJL0JUIG1vZHVsZSBhcyBhbiBleGFtcGxlLCBwaW41NihX
X0RJU0FCTEUxKSBpcyBjb25uZWN0ZWQgdG8gdGhlIFdJRkkvQlQgY2hpcCBQRG4gcGluLCB3ZSBo
YXMgYWxyZWFkeSBjb250cm9sbGVkIHRoaXMgcGluIGluIHRoZSBjb3JyZXNwb25kaW5nIFBDSWUv
U0RJTyBjb250cm9sbGVyIGR0cyBub2Rlcy4NCj4+IEl0IGlzIG5vdCBjbGVhciB0byBtZSB3aGF0
IGV4YWN0bHkgcGlucyBmb3IgdmNjLXN1cHBseSBhbmQgcmVzZXQtZ3Bpb3MgeW91IGRlc2NyaWJp
bmcgaGVyZS4gQ2FuIHlvdSBoZWxwIHVuZGVyc3RhbmQgdGhlIGNvcnJlc3BvbmRpbmcgcGlucyBv
biBNLjIgaW50ZXJmYWNlIGFzIGFuIGV4YW1wbGU/IFRoYW5rcy4NCg0KSGkgU2hlcnJ5LA0KDQpS
ZWd1bGF0b3JzIGFuZCByZXNldCBjb250cm9scyBiZWluZyByZWZjb3VudGVkLCB3ZSBjYW4gdGhl
biBpbXBsZW1lbnQgDQpwb3dlcnVwIHNlcXVlbmNlIGluIGJvdGggYmx1ZXRvb3RoL3dsYW4gZHJp
dmVycyBhbmQgaGF2ZSB0aGUgZHJpdmVycyANCm9wZXJhdGUgaW5kZXBlbmRlbnRseS4gVGhpcyB3
YXkgYmx1ZXRvb3RoIGRyaXZlciB3b3VsZCBoYXMgbm8gZGVwZW5kYW5jZSANCm9uIHRoZSB3bGFu
IGRyaXZlciBmb3IgOg0KDQotIGl0cyBwb3dlciBzdXBwbHkNCg0KLSBpdHMgcmVzZXQgcGluIChQ
RG4pDQoNCi0gaXRzIGZpcm13YXJlIChiZWluZyBkb3dubG9hZGVkIGFzIHBhcnQgb2YgdGhlIGNv
bWJvIGZpcm13YXJlKQ0KDQpGb3IgdGhlIHdsYW4gZHJpdmVyIHdlIHVzZSBtbWMgcG93ZXIgc2Vx
dWVuY2UgdG8gZHJpdmUgdGhlIGNoaXAgcmVzZXQgDQpwaW4gYW5kIHRoZXJlJ3MgYW5vdGhlciBw
YXRjaHNldCB0aGF0IGFkZHMgc3VwcG9ydCBmb3IgcmVzZXQgY29udHJvbCANCmludG8gdGhlIG1t
YyBwd3JzZXEgc2ltcGxlIGRyaXZlci4NCg0KPiBQbGVhc2Ugd3JhcCB5b3VyIHJlcGxpZXMuDQo+
DQo+IEl0IHNlZW1zIHlvdSBuZWVkIHBvd2VyIHNlcXVlbmNpbmcganVzdCBsaWtlIEJhcnRvc3og
ZGlkIGZvciBRdWFsY29tbSBXQ04uDQoNCkhpIEtyenlzenRvZiwNCg0KSSdtIG5vdCBmYW1pbGlh
ciB3aXRoIHBvd2VyIHNlcXVlbmNpbmcsIGJ1dCBsb29rcyBsaWtlIHdheSBtb3JlIA0KY29tcGxp
Y2F0ZWQgdGhhbiByZXNldCBjb250cm9scy4gU28sIHdoeSBwb3dlciBzZXF1ZW5jaW5nIGlzIHJl
Y29tbWVuZGVkIA0KaGVyZSA/IElzIGl0IGIvYyBhIHN1cHBseSBpcyBpbnZvbHZlZCA/DQoNCj4N
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4NCg0K
