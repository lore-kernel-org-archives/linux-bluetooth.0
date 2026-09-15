Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FE364052;
	Tue, 15 Sep 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458064; cv=fail; b=fkRHuLmBlq30crtA8Z4HcIzbzNcjJMXh97/RuGGvsob+FkNWXszOhnam01TyLmDCOuKccoQnszauXYn3fTsj38l2jIBvUYtYRH6qJ6OBSu03CRrsLNWxGUc8OvxVFuMHnI/qPBb4SNxhwRYNw+3kRTL4WjwhYqho6lK/7GXl1aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458064; c=relaxed/simple;
	bh=e6wkCX5+892a0avtDldOwGsjdcRgFPJmg1mxarTLCZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHyqTVVjhuMaSwTmP9+yG7kQ0pGr6P3m8R1oLo/zWO8EpJYQOUaSM7mH7sMpJ2UNPd5wyCQFEQlzJYGTKgE97IMyrW9XkOuxvqrTjck+5hZQONI16mwHWRgAkaxYZctNilUjOdTreiz34/zfQhMVW2zQnNZMGF7Tapw0ps3S17Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIjwLbd2; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIjwLbd2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSzNoy90HKjBasDGIXIIVVeLsoz65qxGqQlrJUBjccE+7taxsCxhHn+Yem34iooT7Grlf6tuveusb28Wq1hq1Lu/Vzm/HuXOZ2LQwXU/RNyqKEg2HhVw1yVvIBztEq3PjJrEMJn04RUaoaMe+jY7JKFAT52D1LBVrJhVrPxDH8mbJLxJ5e4eWzGc0igWjO8tnnpxjwkQYz4FeRbfzDwzV1Niz/tTeoPbDyAvgSN7H2Pn6yQtEEtJwH/kAQB2gSus2TA8s/fEB7YeVTOeAOpqeCYGoy05SqMeNJsLvzTGNPerabcRmZWUrJXDJOOqFXqGoyLU4mnPvylTxgiW4LRwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6wkCX5+892a0avtDldOwGsjdcRgFPJmg1mxarTLCZc=;
 b=i8y5Knaz82BRq9iKdPvlGYx77EfMFRpXKDps0FdmTBSbuUuqE6sfYqunuWCScgKncDj+/6HcQbCVq955xuSHDa41BGaQ//LPLqZtEmQ62pgR1ZdiNtaPimgHWOjqz/nVQdpoGDjX5MnrDQ1g5H1NNaMcckncpLBiZtt+zmRLzfPiWUCYAw8KBplh7N4kb+IU9YvR+qBBxCS57XVdj3ztYWG1+JRhFLt1YK7sY36O2teVBbKuIe/2w1tgO9FoTU1ci8jVC7w1P7B6jaa21ibjBPxdxJ/087pOAL+6Oi4gr40zWa5QTQ1t8G+gK7YoghXYIgXDTyEhZGcbU8zAA+JDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6wkCX5+892a0avtDldOwGsjdcRgFPJmg1mxarTLCZc=;
 b=XIjwLbd28qhgNA/UXGr4SFQRzviVUG5/OY1KblplZFiTyf/vYtUVokrTq/Be1KvGxnpLUv2QbwIF9aZ7+Gm5DZ8s/URt9h8N0KzHM559JTE80GQ3F1cgdT41QMhY4m5AleAWvKTQqYEdPmt7nPV5bk5g7lJdcdpo6PX6bs6fWgYyHHH8WFIEHVOnbqv/P7oSn5JNMFxGIu/d1Fel0xx/s02hTJfmemgugmIvNMpQpMMuQjTTLRNvDobbV3leoEtc+n6K03e6XMpe2yPcpGuLRUxi4h6l7qfVdoY5pH/EI6n60fTZ4s80uTKsk5TsAr0BO+K8tB8l3j5QTTWAIT+yHg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA3PR04MB11227.eurprd04.prod.outlook.com (2603:10a6:102:4ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 07:40:54 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 07:40:53 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>, Song Xue <song.xue_1@nxp.com>, Alex Zhou
	<alex.zhou@nxp.com>
Subject: [PATCH v2 1/2] Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt() by
 hci_acl_handle()
Thread-Topic: [PATCH v2 1/2] Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt()
 by hci_acl_handle()
Thread-Index: AQHdROWJRS9cr4HEZEObYJ+SKSlMHA==
Date: Tue, 15 Sep 2026 07:40:52 +0000
Message-ID:
 <AS4PR04MB96922A260006CC46DAC97E61E7BA2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com>
 <20260914-misc_fix-v2-1-6178d838c946@oss.qualcomm.com>
In-Reply-To: <20260914-misc_fix-v2-1-6178d838c946@oss.qualcomm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-15T07:39:32.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PA3PR04MB11227:EE_
x-ms-office365-filtering-correlation-id: 5ad853d2-c9f8-4e90-0652-08df12fcab97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 C/dakoZ/TRMxHZ7kO5VbFn5a+/f6sDtDkI6ixEl/hFsstppuctC5e3nymDh9MF297Ih52dzr4hX1qfSy9eS5rdOrUKH+NBsvO7CxOyIZXxyhiVItddSc300Si4x6Zl4SgqxkKGBRhi+hnC03TBV08P8HRwllTGh97bRL/awtLzbVK0pgDxB14rOAQIhkeBlqlvr4vEZIHwHlSf7L3HI8G6rDDkJTtlLeC3LlWoHRp5s4bmzpWvc0wn9MaH4O5opOJAglTScEja9fV8iNPctvngPwy5v/D5xIRfGpe8+KDtybH1jOc4Mora/EIThCwj6gV0nE/rnBooNp2cDA40YwisvdV5PeaPMPYSDcPwi2uYJ+XmSxwStKoxibbX3u24Vimh8/2qSkLIlvnUSoTZFo0J4A1ZSMymrxVLIx1cHA9TvhPGdADzCO+Dd+sXH1FBeycVR/MDVbxTFaykLiaAPMXbmzADCnLexESGZ8h4zexhyqRE6iEBH2M7ZAaDJqfZiscY9sOF902JwIyLU8HCUYq7XoX/u9PKMREcfT6+vZ81mbDSeQ9sP2VnZ5Ro60ErJRW91nOv97j6FR/Fbtql/8+AEbH5zY7iJY8wOUfiaPB0oOrzsCemswX9GsQgAVRUDYQC0SLojpl2AJohGYcrSM4zY2cCuiDLRI/8LgxTYXHkwPSLh/OEoYEFMT86T+JMCjsa8F0AieGHt0LhZI5rMNCNMokWovUA39cj5E0EA5ZZ4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXN2RWxhSG5IbzlqWFVZNTIwY3JsZ0JxZzJOT2pnd1MyNVFUMFFxc3FsYlFs?=
 =?utf-8?B?ckQ4Tk1DUkFuUTF0cm1QYjU4OFNWblRITi9Da3dnQzdOd0dXMlFXazZsajZP?=
 =?utf-8?B?bUU5ajBZUjcvRVNQSHRxeDlZT2FKK0dLSVIyb1JyYWdhUkN6RXZ4UEE5TXR3?=
 =?utf-8?B?NXpWczZFYXRQVmdSV0J5RDZTVzBSdnV3blJKT1ErL3hOb0pSVEpoNEhVVEFa?=
 =?utf-8?B?U2NPUCtId0Fwa09TRllNRUZpcGpCeTJmaEsybUtTSzRpNW5TeWl0dEhrdGRE?=
 =?utf-8?B?L1g2WGNwenhKRTVaQm8vTEVCK3QzYm1vOGJReUZmNEIyVDNrNEhYL05CZ21j?=
 =?utf-8?B?S0dwQzRkbHJXdEtlVnpYZmh4NkJwZmxZeVpxMzFVK3dKMmE1dTZCclZXSCtt?=
 =?utf-8?B?OVBPa3pjUXo0ZFlIN3NqejloK0s4YWExU25IMlpTaHpqNEVDNTRvek9ZUGk4?=
 =?utf-8?B?YWJjZzhmRVZPZHJZQmFhREdkS2EyYmt6WnF3ejZRMGpsblZKT2JmNnM1U0V0?=
 =?utf-8?B?Ri9wc3QwbEFqeUFEMHlYSk4vRHFndGQwbjE3bzNNdXAyM3c4dFkzNExGUlAw?=
 =?utf-8?B?VW1NWTExa2t0eFV0RXNkY2U5WGd4dE1pVHhuNXIyWTBSQWw4V2NJM01rUitI?=
 =?utf-8?B?MGRJMzkzaHQ1NmF3akZGUVVMaHFlS0JacDRaZnhVNGNJZm1nVEVNYVJZUGp4?=
 =?utf-8?B?M1VaNzFkdFZDN3V4dCtRMUhhRmRaMFYrZVNEblcvUi91SkdTbUhDbUVmT21Y?=
 =?utf-8?B?clVVSlNrUFQycm0wbFQ0WXpvcUhsTUxXa0RadU5WTERMcVdDeW9hRm9nVzRj?=
 =?utf-8?B?WHd1WVJMelJUUUZWdy9PQkNjU0tWRXdBbERDVmVkdCtrL1hub2R6TWdwbElr?=
 =?utf-8?B?V0VZOGxyNDMvWEJHdzI4aVhvWndabmRiS2lPQ0hzck8xOWY0bVRHMm1Dc29t?=
 =?utf-8?B?S05HWTFBRTFmQW9YOW9mcjhFRGhRRnZaS0NvU2E2VXJVVzFoNEg1eXlXK2pR?=
 =?utf-8?B?MDIveTRiR1U0cndrc0NZeUtBZzJoRVFOSGIwT2w5bUt0bnVsYjc1MmtCQkhr?=
 =?utf-8?B?RDgwTENLcDZZZ2Z1SWw0dC8yL1ZIVHI1L1hHVnpud0tRdTZmbWt1T2hRRXFu?=
 =?utf-8?B?c29rRDg0QVpCSkVGbUp0azhaemNzNEtQWWlJanQrRG1qTkl4YzlKU1lpNnRM?=
 =?utf-8?B?c0wvVHBXaWtWOFliTUd6RFo1U01jWG1sVE1vckViQTRvemNlcTkyUVpMY0hm?=
 =?utf-8?B?MDVubXZkU1pYd3BxallVZ3Bjb3VNMUNrNTlXU2ZkWjNMMlJ5bmNhdUE4YnN6?=
 =?utf-8?B?UkpRb2VRbHl0V2pSbTdSb0VXb1JJTFdCb29VRllHTWdSR3hqcTR1bks4YUpY?=
 =?utf-8?B?RnVmM3REQlJtdksvVTlIWUVYeDNQbUVQeFY2ZlF0VFRDa1BaYTJvNlFqTG9R?=
 =?utf-8?B?cWR0ak1iOGE5QXRHb09Edno3bXl5OEZsOTY2ZXY5SUMxbmt3Tm0zaTNEV2RE?=
 =?utf-8?B?bEdKMGZyUnNVMzNudXRmV1ZRUUdjekU2bU4yR05PcGdmZU1mc3NRM0w4ZTNJ?=
 =?utf-8?B?RHRTd3FMMzVOZkJ0M2hGWUI2c1ZSYUgrQjZUTUUvMnBpa1R4TjhWYVpTd2ZO?=
 =?utf-8?B?MkFiSElQeHFnTTduN1dIOHpXOFBZdXpOZXhpb1A2cmsxNjNpcTJaYko0UHcx?=
 =?utf-8?B?dmVqbk0wakluZktDdE9GQUl4eGlocjljaWpZeHhYRGg5RGRDSmhha2trczVk?=
 =?utf-8?B?MkhKRkp4NGpBZXZFM2NGQ3R2d0dFc0QvejJxNFNqMmNZRUNMeDE4ZkZUa29O?=
 =?utf-8?B?eGlGWXRiV0JSeUtXdytXQURRUXJPbXppRkxUSXA0TGYxVjI5Mm5XTmlsOFU2?=
 =?utf-8?B?ODF6ME5Ic1NtWnlGbEhoMXkzNytBcXp2UTA5WXBMZE9PTm4wRHMzem45b05S?=
 =?utf-8?B?WTArZDlpKzJHaDMwR1RsZzNsWHpjOS9iK0FvUVk0TDBVSU5zeUl5aUQvUXQ0?=
 =?utf-8?B?MXVtaXhCTFlkN095VVBxRDFTL3B3dlloWFpuY0s0REs1TzVzNlJxYW1aaDVY?=
 =?utf-8?B?RGtSUVl1S0Nzcmd6dFplNUxhcGJoSDZRNnVyclhYRk9aaGVMaW55a0Zzb21q?=
 =?utf-8?B?M0NoZm5IWWJJdmI3ZTYzTjJ4N0ZQUm0vNXZRN2UvUlRObGI0NjJSL3ZMTlV1?=
 =?utf-8?B?Snc4eGJMd2d4V0pLUWV4emM4Zzh5WE9JR05sblltNXMyY2RNczRIWHQ3QjB5?=
 =?utf-8?B?UHBIL2o0MXA3bVYxQlVOMWxDYi9rc1U3dDBCeTg1UWpnOHcvL2FzVmUvVVdu?=
 =?utf-8?B?WmNDZVRGdUJKM3hRa25jMlRRbU5RZEUvY2tWUGUxekNQbDJrZEhZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad853d2-c9f8-4e90-0652-08df12fcab97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 07:40:52.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETEo6Kl7O0Vbl08Ne0VkttZakUCK3Ywg354LlqN4BMVPMpLu+w+LkDoPeKz/C4Lkw09j7fJ2AcuqbjWyqSt29UNphj++3E82o4tppHXPkxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11227

SGkgWmlqdW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLiBUaGUgZml4IGxvb2tzIGdvb2Qg
dG8gbWUuDQoNClJldmlld2VkLWJ5OiBOZWVyYWogU2FuamF5IEthbGUgbmVlcmFqLnNhbmpheWth
bGVAbnhwLmNvbQ0KDQpUaGFua3MsDQpOZWVyYWoNCg0KPiBTaW1wbGlmeSBueHBfcmVjdl9hY2xf
cGt0KCkgYnkgdXNpbmcgaGNpX2FjbF9oYW5kbGUoKSBpbnN0ZWFkIG9mOg0KPg0KPiBfX3UxNiBo
YW5kbGUgPSBfX2xlMTZfdG9fY3B1KGhjaV9hY2xfaGRyKHNrYiktPmhhbmRsZSk7DQo+IC4uLiAo
aGFuZGxlICYgMHgwRkZGKSAuLi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWmlqdW4gSHUgPHppanVu
Lmh1QG9zcy5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvYnRueHB1
YXJ0LmMgfCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5j
IGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gaW5kZXggZjJiYmU2ZTQ2MmFhLi42
OWU4OTc0NDQxMTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5j
DQo+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+IEBAIC0xNDAwLDIwICsx
NDAwLDE4IEBAIHN0YXRpYyBpbnQgbnhwX3Byb2Nlc3NfZndfZHVtcChzdHJ1Y3QgaGNpX2Rldg0K
PiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4NCj4gIGZyZWVfc2tiOg0KPiAgICAgICAg
IGtmcmVlX3NrYihza2IpOw0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPg0KPiAgc3RhdGlj
IGludCBueHBfcmVjdl9hY2xfcGt0KHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKSAgew0KPiAtICAgICAgIF9fdTE2IGhhbmRsZSA9IF9fbGUxNl90b19jcHUoaGNpX2Fj
bF9oZHIoc2tiKS0+aGFuZGxlKTsNCj4gLQ0KPiAgICAgICAgIC8qIEZXIGR1bXAgY2h1bmtzIGFy
ZSBBQ0wgcGFja2V0cyB3aXRoIGNvbm4gaGFuZGxlIDB4ZmZmICovDQo+IC0gICAgICAgaWYgKCho
YW5kbGUgJiAweDBGRkYpID09IDB4RkZGKQ0KPiArICAgICAgIGlmIChoY2lfYWNsX2hhbmRsZShz
a2IpID09IDB4RkZGKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIG54cF9wcm9jZXNzX2Z3X2R1
bXAoaGRldiwgc2tiKTsNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
aGNpX3JlY3ZfZnJhbWUoaGRldiwgc2tiKTsgIH0NCj4NCj4gIHN0YXRpYyBpbnQgbnhwX3NldF9i
ZGFkZHIoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGNvbnN0IGJkYWRkcl90ICpiZGFkZHIpICB7DQo+
ICAgICAgICAgdW5pb24gbnhwX3NldF9iZF9hZGRyX3BheWxvYWQgcGNtZDsNCj4NCj4gLS0NCj4g
Mi4zNC4xDQoNCg0KTlhQIENvbmZpZGVudGlhbA0K
