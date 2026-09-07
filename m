Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013072.outbound.protection.outlook.com [52.103.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CD302146;
	Mon,  7 Sep 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747059; cv=fail; b=nrR4SVJUXc909WYX/F2daDv9aVgASEqU14LNA989jBAa5ON+76Dl7Znd07MlJG/JH9PVn2GeVEs2q5GgT2I0GNQBogkDM/8GLP3KQzlSrUu/gN6K+mEclJppXlwBM2/qEnK0pcPEN/l+DfFBpndIeaqIndhH86nr9Thi/JidJ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747059; c=relaxed/simple;
	bh=Y3Bsr1n2UTD3QU8fFPuRem40DmaV9TthgHEPBMqd6pI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cxxGO/oWH2Ocfo8YC6VmSscdSMN77sFpoKkZ6OErMNofCpge4nmGWemrti/7MTBsa1tRDRXZuJIKldnFZhAoA1XXC8HFOaSwyHmKCgwVolm91PGEPDk6yNkNTwVOveXz8BMV/J/GweWEXgpFLZ8JNvJKzgv/p67WV2oHYLOyseE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TLlXW9kY; arc=fail smtp.client-ip=52.103.7.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TLlXW9kY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDrnF9qKKH4U736Ziol5WzE+xRf2pXtdpC7oVCIX2Ns2aXlQSlaqIDCxj9+zE+G7fkvPY2FhrrF6I6cXkBdLzrA+IVuSEYytK7WPj9HXXZn72p60/0j7n+yOpDykwfY5nTydYzfkEujYpFYjmBPlU6dfrOgcekZPTHeeiCruINqFNkQpq+RSF4MR5GOXhAwQo9QlHusicJP/ALmVdkep0vDxnz04EagO4s5WQrrt6kOUHCxISrY0/KwSPXJQdSRwheBC9r7Se6LOG+jNNyLNNvQIKOWhHKLiOVfk3S/xaQZEF1/I5nDvBT8iKAeKGDyKMi1YSwgfsYd+pUqFUuWJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6WJ2bl0LjdNop41f9w9YMW+m2TQ45VsgZyPnFP8eao=;
 b=B4DW6M/Iu9tu2B/WCNc7Qi/TN5dvs4igwuzSj7P6C0cWK5e4udsZNsDxrb8Ih6Bnif3GVFAQi/CcDkNro72LRW8aarJt3gkpNiJJsJXd0M/1hct2yEroHI+2Lt35hlIpmXwfW+poun5xX2jiSZD4MaLus5xDGV7LB2NyXK3fWiPo1cRVlzwIrRUVKtvjn+7LIXeBifS4hu09nvUrApBN9sLNgtSBGgmR3GxG7xuse0DbXGSBKbIMeccu5B7tmrvBhq9v6eQ/BAEB94r2O5cIp9m6T/lSfXNkYEkI5Pc4d8tsvg34GE0bqpITRlPMcYtsAk50FxixpBLw8fAVLBOIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6WJ2bl0LjdNop41f9w9YMW+m2TQ45VsgZyPnFP8eao=;
 b=TLlXW9kYQjui2Z8PgaQkU1bjDfUvXBFV6lC0kFBa9wvySJeghS/JotwW4/HMafStyIoWFLb/p8Z2HLOLFnMyasAJ+F+vP0m8yvlpfA/DZ3E27fM1NuPKf8MEcxCTaFjRoA8oD6E61TgKnSQC2Ysqcv+j89Z7MJPn/qAXg6fi+yRhJSk9g1AjsdLJfMewswCmyiuxdwzzUu5w9ZJhFUIAMtF2oktPYq7IfbAx8zB11f2z7jJFGoqjlYFEhDhyBoCEgBIU2ay3iFvpJXALj3CFRwOhd+H1gGjYi8xztM8cWMJlOYxnhAtHflU2h64TD9SZ3wbhNv64ne4dGNB84GOzYA==
Received: from SA3PR02MB9994.namprd02.prod.outlook.com (2603:10b6:806:37e::16)
 by MN2PR02MB7005.namprd02.prod.outlook.com (2603:10b6:208:209::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 02:10:52 +0000
Received: from SA3PR02MB9994.namprd02.prod.outlook.com
 ([fe80::840c:6b62:e76c:d803]) by SA3PR02MB9994.namprd02.prod.outlook.com
 ([fe80::840c:6b62:e76c:d803%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 02:10:52 +0000
From: Holmes Jin <JinRMoriarty@outlook.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>
Subject: [Bug Report] btusb: RTL8852BU (0bda:4853) list_del corruption in
 btusb_disconnect after failed suspends; lockup in hci_register_dev
Thread-Topic: [Bug Report] btusb: RTL8852BU (0bda:4853) list_del corruption in
 btusb_disconnect after failed suspends; lockup in hci_register_dev
Thread-Index: AQHdPm2agommWPE/e0SSBj8aRVYOpg==
Date: Mon, 7 Sep 2026 02:10:52 +0000
Message-ID:
 <SA3PR02MB999408EB34A11AC1312F4121C4B22@SA3PR02MB9994.namprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR02MB9994:EE_|MN2PR02MB7005:EE_
x-ms-office365-filtering-correlation-id: a0319d0a-e547-4934-d68c-08df0c853e26
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|24021099003|4140399003|25010399006|15080799012|19110799012|15030799006|6092099016|39105399006|8060799015|8062599012|20031999006|24071999003|13031999006|25031999004|31061999003|7071999006|31101999003|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?gb2312?B?ekRNWVJwUitCbit2RGNoY1M4c3JRZnJlbE1qYm5GZ0ZHSlpHN1JTblhPRndm?=
 =?gb2312?B?K0tlNGxRamtZa3JMd2duRUpIaUJEanFrSG5DTW5XUVVVMXRvajl2cDdCYVVW?=
 =?gb2312?B?VjZ0VERCRVcrQVZvc2F0bnUzUVNTbit1a055dnR2M2pEY0didWthWEQ3QVFs?=
 =?gb2312?B?VVpYblFkUlIxN2VMZ2dMd2NCTjlpSXB0SjdsU0RtS3h6SEdudEZ6QTZqNFox?=
 =?gb2312?B?em9WL21CRHpleFJKV2hSTHNTa242VHpCcDlEbXpEMmNGZGJnUnoyR2E4T1h6?=
 =?gb2312?B?RmMwYUR1VENNWkhGSi9GYVpxZWs0eWpxaHplZTVDWmsxUHhXNTFkMWtidktP?=
 =?gb2312?B?WHlSdTB5THBqeFgrWU05YVN0cllOS2ZQeTJlcnVBNXVGeUNaU1JGb3JyQ1ZW?=
 =?gb2312?B?TStmRGNUYlA0ai9WSWxQUmU4enlQNkNla2hLRWhkN3dwaTEzUUhhbVo1Uzg5?=
 =?gb2312?B?aFFMVk9WdWd4K3J5Nk1zcGl6Ly9zN2Q5V2RhdGU0cGlTREljck5VS1o0aEtN?=
 =?gb2312?B?NGZnZERMbS9kRFJVY2N1UmR1Sjl6NlY3a1cvQTdSTU8rQU9BQ3RlaUpSRGpu?=
 =?gb2312?B?N3RxUGJpV0plS2x5b3E3eWFlMWdjRDBMZVBRMTFVcE9tZXU3NmIvVzY2dXZU?=
 =?gb2312?B?VDl4QzRSUm5HVUhpMnNISVZLeTIvd3ZVUHR0eStSanh2VW5HaW5iVDU5eWpI?=
 =?gb2312?B?RUxNY3BQN2M2ZFpwSXRIMHhJLy9RTnFlY050aUdsZkRDdm9iK2l2N2Y1bEtl?=
 =?gb2312?B?NEZJbnJKb1VVRmdqbzJUeENSRlA0VVBhSWU2MWRic01zelRHYUlTRW1QcHow?=
 =?gb2312?B?Q2hNOTZNYm5UOWxuR1RET0t2NWVNZmgxa0FUV0dFYnoyQ0NNdlVFUjZxR0ox?=
 =?gb2312?B?MTRKb0x0cExOQkxuUWxQcWdGcGxIb3pKUmdhRFFBTm5hOHhoZnpQVEJvaGxJ?=
 =?gb2312?B?VUo5dUQ2MzNsTjYzSXBjOVNUUlJDTDY3ZGJQZnkyM3MxYVM0dXY4S2w3WEJv?=
 =?gb2312?B?MnJoNkdlbUtBVERmSDdWRFlidVloWVlOblUwVDNOQzdOdytCem9FRERseGlH?=
 =?gb2312?B?WXNuc0NLV2VjMVMwL2EvSEdKSWFJZ3Jpc0VzdkZrcXQvUzc5UEdFdm5mNENS?=
 =?gb2312?B?eTVUKzJhaGw4eGQ5ZHNka2doallISHhhcklnb09SSlpMQnVNcXhpWVRRbldy?=
 =?gb2312?B?NmtKVkpkdmxsRHhCZzZDemdRRG9XZ2tPeXBtTEZOekdrT0Vob0JDQzAvMmVo?=
 =?gb2312?B?dTJKZHVuOU93Q3RiM2gxSzMxT0FlWkNGdGdDa3dVWnJDNmJQSGhrM0xNTnNB?=
 =?gb2312?B?S0IzSVBPRTlsWFNyUVhyZmVGVit0UWtzTktGNEcreFhVRlBWbGVrVlczQ1Rh?=
 =?gb2312?B?SlEwM09tazR4aFdSNkd5RFZidGtadk52ZmpJMUhMRk8xWHUyUkhaWlVPUDFQ?=
 =?gb2312?B?b3NUWmJmRG1tTFN2Y3ZJd1VWQWJQRkZlNTlnMmVQMnZTZkh0OUk5N0FrODJS?=
 =?gb2312?B?Vnc5WmFzL1QyY3NQRyt6bE1qbkFGN3M3TnFhZGhLdWp4ZXJNMktVeUwwQld5?=
 =?gb2312?B?ZGgzNVJMZ1ZERzdERTVJeFZvaG1hSVR4aFh4YkNGZk5oc25LeVVBUnJRWTBC?=
 =?gb2312?B?MzJNcCtNMGdVbG0xanN2QUFTbFVDdlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VmYxd2sya05VZWp6U2lsZ3BCdVhJblYzV1kyeGhMaDhIMkd1eXliU2JBM2Qz?=
 =?gb2312?B?cWVhREt0dGxuYmx3OEVXaDd0TmtjSHVTNDhiWWZrV3Vtb040bmNrQjJ5enBx?=
 =?gb2312?B?TWx2aWNLbHFCcDVwcDFqUDB2NVB5bFZ4VE9QYmRHUnlLK21jR20xejBvczlD?=
 =?gb2312?B?LzRhMVhxd25KNStHZjNnc1VRMGV4SXhKSktRN3pjaEhjRXdjeGVaT1FPWm00?=
 =?gb2312?B?dmFrSjZGZEQ1R2ZnU1Zzc25YdzVVZDhxZnBpemdHWGdGSDdCT3Zzc0pPcWxG?=
 =?gb2312?B?ZWtHeXNxTnEybU0rK09XM3M2VnNsSEUyTHBnR0ZvbVQrT29Mdkd5K3FQRFdl?=
 =?gb2312?B?eE1uT0VNVWhCOHFpbDQvTEdWeGFNWG9WNFV3b0ZGRjdUZGZ6SG9lZ2N0ZW1x?=
 =?gb2312?B?Z1FPR21qZ2V3b0ZrNWtwODcxQVhISWRycWpEd3c1aXl3cURSNlNRbTVIc0hl?=
 =?gb2312?B?UTF3YWpVbjhhckswUzU1a0c4OU03RVNhdWc4MTVST203Nmt5K09rWUJiQThk?=
 =?gb2312?B?R3Fjcmw0SGV1akFRYkdMZmJjTVRtTDA2RzF0LzRxM3J3UDBSeE5ia0x3NUZh?=
 =?gb2312?B?S0lEMHg0ci9oR3FTaENvUzdZN0ROQVF4bU0rYzY0TXlUalgwTnpkUXQrZVVk?=
 =?gb2312?B?MlgyRVBaSC91Q21lbjlHZXFQa3B2TWZsN2FvTFIxZzh2SlR1UTBrS2JrNUg1?=
 =?gb2312?B?Mzhwd0RUS0ZBZExaV2ZOQm52R0NhV2FDbFZMU2ZWY2ZxK3YxUm8rWVRNZG9K?=
 =?gb2312?B?ODVkZEtXeiszbnBwRUpwR3VkeCtjVS8wb0tRYTFjanlBbzVOa0REMUxHdjhj?=
 =?gb2312?B?NVl4YUJnOFd6VWRuMXBIQmFTc2p3UDRuaUJLRitNSEhvVkhsT1M4c0o5ZUNl?=
 =?gb2312?B?WE5JZFErcUcyVm9FRjRLWVZXK3BybWVIZGFJdTNmSWtUaEFTREpZaXZYRCtN?=
 =?gb2312?B?OHFTTzhIc1JFbWt4VmE5dllKN1V6aFZrY2NVempBa1l6SFhZd2dEMVpWdURO?=
 =?gb2312?B?LzlqOFoySWhkZlJJbHBKcFc1KzZYMVZwaGw1cGoxR2dvOU1MZjB3UTFsaThz?=
 =?gb2312?B?bi9xSXFrd2ZuaDVjcEhrd0RDa3hmVkxYeUZWUTdsWjBSUUljcWpsQ1BKalNk?=
 =?gb2312?B?TTJURjN6L21nejIzeVZCNUpQTXF3blRFK0hYaU1uTGhuS0F4SXlwRUFIQ0dK?=
 =?gb2312?B?M0R0d0YvcVRpd1lkY0c0dytaVzJIRzhhWHRRTG5VOGE5eDNpMmxBRTFMOWZj?=
 =?gb2312?B?aVVjYlBudVdodDBQYjdEVUZBaXltZ25ZbTUwVXBSanI4V20yRzBla3laYStE?=
 =?gb2312?B?TmJtVEdpZTRVOEoxUzAzTjBNbDAzN0NNWHdCSU1pMW1hdEtyanZsU2xXeU52?=
 =?gb2312?B?U29WZ1VJN2N5OEJpMmdadXRlNno0UElNWW5aRUV5dWoyUXpqaFNXTmp5VXNL?=
 =?gb2312?B?Z1RrMGM3OENHcEtDSDFiR003NkxSZDFLNUpjVlNwdzExK01mRWdGdWpjdVk1?=
 =?gb2312?B?WnR2STFWWk1iZFdlZ0FCWmlod1JaMHZZMWtQOHR4WkIxOWJXOHZCdmcvWlB5?=
 =?gb2312?B?MEZpMmNQcXRoeElocFdtMlYxYlpJdmRld2RHamp2YjRjajJFYlV2N2g0cUdz?=
 =?gb2312?B?bGVFckx0OU1MaXc3NTZ4bFdkSElGVEFvVktLS3dLcUVwcHZBd29aSmNwbHVk?=
 =?gb2312?B?cnd1VWg0djRITk5nWkZudmxrZXNzUDNhU2NWUU52V2tVdEhIK0Iwak45aUFv?=
 =?gb2312?B?VTRmM3o5VmI3MWpmTGlsanZKZ2lRLzNRSHAvYnVxOHAxb2FGY21lMU9XNUFx?=
 =?gb2312?B?U0tpQ1F2WGhmSEhlT2pUemd6OUc3WllvRzFyZlpWdDBHZldxSEtnQ29QSnJW?=
 =?gb2312?Q?x07yMsnVk34rG?=
Content-Type: multipart/mixed;
	boundary="_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR02MB9994.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a0319d0a-e547-4934-d68c-08df0c853e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 02:10:52.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7005

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: multipart/alternative;
	boundary="_000_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_"

--_000_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNCkknZCBsaWtlIHRvIHJlcG9ydCBhIHJlcHJvZHVjaWJsZSBrZXJuZWwgY3Jhc2ggY2hh
aW4gaW52b2x2aW5nIHRoZSBidHVzYg0KZHJpdmVyIHdpdGggYSBSZWFsdGVrIFJUTDg4NTJCVSBC
bHVldG9vdGggcmFkaW8gb24gYSBMZW5vdm8gbGFwdG9wLA0KcnVubmluZyBOaXhPUyB3aXRoIHRo
ZSBsYXRlc3Qga2VybmVsLg0KDQo9PSBIYXJkd2FyZSAvIGVudmlyb25tZW50ID09DQoNCi0gTWFj
aGluZTogTEVOT1ZPIDgzRDUgKGJvYXJkIExOVk5CMTYxMjE2KSwgQklPUyBOUUNOMjdXVw0KLSBL
ZXJuZWw6IDcuMi4zICMxLU5peE9TIFBSRUVNUFQobGF6eSkgKG5peHBrZ3MgbGludXhQYWNrYWdl
c19sYXRlc3QpDQotIEJUIHJhZGlvOiBSZWFsdGVrIFJUTDg4NTJCVSwgVVNCIDBiZGE6NDg1Mywg
YnVzIDEtMyAoZnVsbC1zcGVlZCkNCi0gU2xlZXAgbW9kZTogczJpZGxlIChvbmx5IHN1cHBvcnRl
ZCBzdXNwZW5kIHN0YXRlLCAvc3lzL3Bvd2VyL21lbV9zbGVlcCkNCi0gU3dhcDogMzIgR2lCIExW
TSBwYXJ0aXRpb24gKGhpYmVybmF0ZSB3b3JrcykNCi0gQlQgc3RhdGUgZHVyaW5nIHRoZSB3aG9s
ZSBpbmNpZGVudDogcmZraWxsIFNPRlQgQkxPQ0tFRCAocmFkaW8gb2ZmIHZpYQ0KICBLREUpLCBi
dXQgYnR1c2IgZHJpdmVyIHN0aWxsIGJvdW5kIHRvIHRoZSBVU0IgaW50ZXJmYWNlDQoNCj09IFRp
bWVsaW5lIChhbGwgdGltZXN0YW1wcyBmcm9tIGpvdXJuYWxjdGwsIGJvb3Qgb2YgMjAyNi0wOS0w
NCAwOTo0MykgPT0NCg0KMS4gMjAyNi0wOS0wNCwgZGF5dGltZTogc3VzcGVuZC9yZXN1bWUgd29y
a3Mgbm9ybWFsbHkgKHNldmVyYWwgY2xlYW4NCiAgIHMyaWRsZSBjeWNsZXMpLg0KDQoyLiAyMDI2
LTA5LTA1IDAxOjA1OjU4OiB1c2VyLWluaXRpYXRlZCBISUJFUk5BVEUuIEl0IHN1Y2NlZWRlZA0K
ICAgKCJPcGVyYXRpb24gJ2hpYmVybmF0ZScgZmluaXNoZWQiLCBpbWFnZSB3cml0dGVuIHRvIHN3
YXAsIGNsZWFuDQogICByZXN1bWUgYXQgMDE6MDc6MTQpLg0KDQozLiBJbW1lZGlhdGVseSBhZnRl
ciB0aGF0IGhpYmVybmF0ZSwgZXZlcnkgczJpZGxlIHN1c3BlbmQgYXR0ZW1wdCBmYWlscw0KICAg
d2l0aCAiUE06IFNvbWUgZGV2aWNlcyBmYWlsZWQgdG8gc3VzcGVuZCwgb3IgZWFybHkgd2FrZSBl
dmVudA0KICAgZGV0ZWN0ZWQiIC0tIHRoZSBtYWNoaW5lIHdha2VzIHdpdGhpbiB+MSBzZWNvbmQu
IEtERSBwb3dlcmRldmlsDQogICByZXRyaWVkIGF1dG9tYXRpY2FsbHk6IG92ZXIgdGhlIG5leHQg
fjIuNSBkYXlzIHRoZSBzeXN0ZW0gYXR0ZW1wdGVkDQogICAyNzY4IHN1c3BlbmRzLCAyNzY0IG9m
IHRoZW0gZmFpbGVkLiBFYWNoIGN5Y2xlIGxvZ2dlZDoNCiAgICAgLSAiQmx1ZXRvb3RoOiBoY2kw
OiBSVEw6IGRvd25sb2FkIGZ3IGNvbW1hbmQgZmFpbGVkICgtMikiDQogICAgIC0gInVzYiAxLTM6
IHJlc2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4aGNpX2hjZCINCg0K
ICAgQ291bnQgdG90YWxzIGFjcm9zcyB0aGUgZmFpbGluZyBib290Og0KICAgLSBzdXNwZW5kIHJl
cXVlc3RzIChsb2dpbmQpOiAyNzY4DQogICAtIGtlcm5lbCBzMmlkbGUgZW50cmllczogNTUzMw0K
ICAgLSBmYWlsZWQgc3VzcGVuZHM6IDI3NjQNCiAgIC0gaGNpMCBmaXJtd2FyZSBkb3dubG9hZCBm
YWlsdXJlczogMjQ0OA0KICAgLSB1c2IgMS0zIHJlc2V0czogNjgxMQ0KDQo0LiAyMDI2LTA5LTA3
IDA2OjM0OjU5LCBkdXJpbmcgYSBmYWlsZWQgc3VzcGVuZCBhdHRlbXB0LCBmaXJzdCBrZXJuZWwN
CiAgIGNyYXNoIChsaXN0IGNvcnJ1cHRpb24gaW4gYnR1c2IgZGlzY29ubmVjdCBwYXRoLCB0cmln
Z2VyZWQgZnJvbSB0aGUNCiAgIHVzYl9yZXNldF9kZXZpY2Ugd29ya3F1ZXVlKToNCg0KICAgbGlz
dF9kZWwgY29ycnVwdGlvbiwgZmZmZjhhNzMwOGVhYzAwMC0+bmV4dCBpcyBOVUxMDQogICBrZXJu
ZWwgQlVHIGF0IGxpYi9saXN0X2RlYnVnLmM6NTIhDQogICBPb3BzOiBpbnZhbGlkIG9wY29kZTog
MDAwMCBbIzFdIFNNUCBOT1BUSQ0KICAgV29ya3F1ZXVlOiBldmVudHMgX191c2JfcXVldWVfcmVz
ZXRfZGV2aWNlDQogICBSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZF9vcl9yZXBvcnQu
Y29sZCsweGQvMHgxZQ0KICAgQ2FsbCBUcmFjZToNCiAgICAgaGNpX3VucmVnaXN0ZXJfZGV2KzB4
NDYvMHgyMzAgW2JsdWV0b290aF0NCiAgICAgYnR1c2JfZGlzY29ubmVjdCsweDdmLzB4MWIwIFti
dHVzYl0NCiAgICAgdXNiX3VuYmluZF9kcml2ZXJfaW50ZXJuYWwuLi4gLyB1c2JfZm9yY2VkX3Vu
YmluZF9pbnRmDQogICAgIHVzYl9yZXNldF9kZXZpY2UrMHhlZC8weDJiMA0KICAgICBfX3VzYl9x
dWV1ZV9yZXNldF9kZXZpY2UrMHgzYS8weDYwDQogICAgIHByb2Nlc3Nfb25lX3dvcmsgLyB3b3Jr
ZXJfdGhyZWFkIC8ga3RocmVhZA0KDQo1LiBUaGUgT29wcydlZCBrd29ya2VyIChQSUQgMTg4MTc0
MCwga3dvcmtlci91NjQ6MCkgRElFRCB3aGlsZSBob2xkaW5nIGENCiAgIGxvY2sgKGxhdGVyIHN0
YWNrIHNob3dzIGl0IHN0dWNrIGluIHF1ZXVlZF93cml0ZV9sb2NrX3Nsb3dwYXRoKS4NCiAgIEZy
b20gMDY6MzU6NDUgb253YXJkLCBldmVyeSBVU0IgcmUtcHJvYmUgb2YgdGhlIEJUIHJhZGlvIHF1
ZXVlZCBvbnRvDQogICBDUFUjNCBhbmQgc3B1biB0aGVyZSBmb3JldmVyIGluOg0KDQogICAgIGJ0
dXNiX3Byb2JlIC0+IGhjaV9yZWdpc3Rlcl9kZXYgLT4gcXVldWVkX3dyaXRlX2xvY2tfc2xvd3Bh
dGgNCg0KICAgVGhlIHNvZnQgbG9ja3VwIHJlcGVhdGVkIDI1MyB0aW1lcyBvdmVyIH4yaDEzbSAo
NzQ0MyBzZWNvbmRzIG9mDQogICAxMDAlIHNpbmdsZS1jb3JlIENQVSksIG92ZXJoZWF0aW5nIHRo
ZSBtYWNoaW5lLCBzdGFsbGluZyBSQ1UgYW5kDQogICBmb3JrKCksIG1ha2luZyB0aGUgc3lzdGVt
IHVudXNhYmxlIHVudGlsIGEgZm9yY2VkIHBvd2VyLW9mZi4NCg0KICAgUmVwcmVzZW50YXRpdmUg
c29mdCBsb2NrdXAgc3RhY2sgKDA4OjQ3OjM4LCBzYW1lIGFzIGZpcnN0KToNCg0KICAgd2F0Y2hk
b2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjNCBzdHVjayBmb3IgNzQ0M3MhIFtrd29ya2VyL3U2
NDowOjE4ODE3NDBdDQogICBXb3JrcXVldWU6IGV2ZW50c191bmJvdW5kIGRlZmVycmVkX3Byb2Jl
X3dvcmtfZnVuYw0KICAgUklQOiAwMDEwOnF1ZXVlZF93cml0ZV9sb2NrX3Nsb3dwYXRoKzB4NjIv
MHgxMjANCiAgIENhbGwgVHJhY2U6DQogICAgIGhjaV9yZWdpc3Rlcl9kZXYrMHgxZmMvMHg0NDAg
W2JsdWV0b290aF0NCiAgICAgYnR1c2JfcHJvYmUrMHhhMTcvMHgxMGI5IFtidHVzYl0NCiAgICAg
dXNiX3Byb2JlX2ludGVyZmFjZSAvIHJlYWxseV9wcm9iZSAvIC4uLg0KICAgICBkZWZlcnJlZF9w
cm9iZV93b3JrX2Z1bmMgLyBwcm9jZXNzX29uZV93b3JrIC8gd29ya2VyX3RocmVhZA0KDQo9PSBR
dWVzdGlvbnMgZm9yIG1haW50YWluZXJzID09DQoNCjEuIFdoYXQgY29ycnVwdHMgdGhlIGhjaV9k
ZXYgbGlzdCAob3IgaXRzIGxvY2spIHN1Y2ggdGhhdA0KICAgaGNpX3VucmVnaXN0ZXJfZGV2KCkg
c2VlcyBhIE5VTEwgLT5uZXh0IGR1cmluZyBhIGZvcmNlZCB1bmJpbmQgYWZ0ZXINCiAgIG1hbnkg
ZmFpbGVkIHN1c3BlbmQgY3ljbGVzPyBJcyB0aGlzIGEgYnR1c2IgYnVnLCBhIGJsdWV0b290aCBj
b3JlDQogICBidWcsIG9yIGEgVVNCLWNvcmUgaW50ZXJhY3Rpb24gKHVzYl9yZXNldF9kZXZpY2Ug
LT4gZm9yY2VkIHVuYmluZA0KICAgd2hpbGUgdGhlIGludGVyZmFjZSBkcml2ZXIgaXMgbWlkLXN1
c3BlbmQvcmVzdW1lKT8NCg0KMi4gV2h5IGRvZXMgYnR1c2JfcHJvYmUoKSBzcGluIGluIHF1ZXVl
ZF93cml0ZV9sb2NrX3Nsb3dwYXRoKCkgZm9yIDc0NDMNCiAgIHNlY29uZHMgd2l0aG91dCBldmVy
IGdpdmluZyB1cCAoaW5maW5pdGUgcmV0cnkgLyBubyB0aW1lb3V0LCBvciBsb2NrDQogICBoZWxk
IGJ5IGEgZGVhZCBPb3BzJ2VkIHRhc2spPyBUaGlzIGlzIHdoYXQgcGh5c2ljYWxseSBvdmVyaGVh
dGVkDQogICB0aGUgbWFjaGluZSBhbmQgbWFkZSB0aGUgc3lzdGVtIHVucmVjb3ZlcmFibGUgLS0g
YXJndWFibHkgdGhlIG1vc3QNCiAgIHVzZXItdmlzaWJsZSBkYW1hZ2UuDQoNCjMuIElzIGEgaGli
ZXJuYXRlLXRoZW4tczJpZGxlIHRyYW5zaXRpb24gZXhwZWN0ZWQgdG8gYmUgc2FmZSBmb3INCiAg
IGJ0dXNiL1JUTDg4NTJCVT8gVGhlIGRheXRpbWUgczJpZGxlIGN5Y2xlcyBvbiAwOS0wNCB3ZXJl
IGZpbmU7IHRoZQ0KICAgZmFpbHVyZSBtb2RlIGJlZ2FuIGV4YWN0bHkgYWZ0ZXIgdGhlIGZpcnN0
IGhpYmVybmF0ZSBvZiB0aGF0IGJvb3QuDQoNCj09IFdvcmthcm91bmQgPT0NCg0KQ29uZmlybWVk
IHdvcmtpbmc6IHVubG9hZGluZyB0aGUgYnR1c2IgZHJpdmVyIHN0YWNrIGJlZm9yZSBzbGVlcCBh
bmQNCnJlbG9hZGluZyBhZnRlciByZXN1bWUgKHBvd2VyTWFuYWdlbWVudC5wb3dlckRvd25Db21t
YW5kcyAvDQpyZXN1bWVDb21tYW5kcyBpbiBOaXhPUyk6DQoNCiAgbW9kcHJvYmUgLXIgYnR1c2Ig
YnRydGwgYnRpbnRlbCBidGJjbSBidG10aw0KICAjIHNsZWVwDQogIG1vZHByb2JlIGJ0dXNiDQoN
ClRoaXMga2VlcHMgdGhlIHJhZGlvIGVudGlyZWx5IGFic2VudCBmcm9tIHRoZSBzdXNwZW5kIHBh
dGggYW5kIGhhcw0KZWxpbWluYXRlZCBib3RoIHRoZSBpbnN0YW50LXdha2UgbG9vcCBhbmQgdGhl
IGNyYXNoLiAoV2UgZG9uJ3Qga25vdw0KeWV0IHdoZXRoZXIgaXQgc3Vydml2ZXMgYSBoaWJlcm5h
dGUgKyByZXN1bWU7IHdpbGwgcmVwb3J0IGJhY2suKQ0KDQo9PSBBdHRhY2htZW50cyAvIGxvZ3Mg
PT0NCg0KRXZpZGVuY2UgZmlsZXMgKH43MCBLQiB0b3RhbCksIGNvbGxlY3RlZCB3aXRoIGpvdXJu
YWxjdGwgZnJvbSB0aGUNCmZhaWxpbmcgYm9vdCwgYXJlIGF0dGFjaGVkOg0KDQoxLiAxLWtlcm5l
bC1vb3BzLWxpc3QtY29ycnVwdGlvbi5sb2cgLSBmdWxsIE9vcHMgYXQgMDY6MzQ6NTkgaW5jbC4N
CiAgIGNvbXBsZXRlIGNhbGwgdHJhY2UgYW5kIHJlZ2lzdGVyIGR1bXANCjIuIDItc29mdC1sb2Nr
dXAtZmlyc3QtcmVwb3J0LmxvZyAtIGZpcnN0IHNvZnQgbG9ja3VwIGF0IDA2OjM1OjQ1DQozLiAz
LXNvZnQtbG9ja3VwLWhjaS1yZWdpc3Rlci1kZXYtc3Bpbi5sb2cgLSBsYXRlciBzb2Z0IGxvY2t1
cCBzaG93aW5nDQogICB0aGUga3dvcmtlciBzdHVjayBpbiBoY2lfcmVnaXN0ZXJfZGV2IC0+IHF1
ZXVlZF93cml0ZV9sb2NrX3Nsb3dwYXRoDQo0LiA0LWhpYmVybmF0ZS10aGVuLWZhaWxpbmctc3Vz
cGVuZHMubG9nIC0gdHJhbnNpdGlvbjogc3VjY2Vzc2Z1bA0KICAgaGliZXJuYXRlLCBpbW1lZGlh
dGVseSBmb2xsb3dlZCBieSBmYWlsaW5nIHMyaWRsZSBhdHRlbXB0cw0KNS4gNS1oYXJkd2FyZS1h
bmQtY291bnRzLnR4dCAtIGhhcmR3YXJlIElEcyBhbmQgZXZlbnQgY291bnRzDQoNCkkgY2FuIHBy
b3ZpZGUgdGhlIGZ1bGwgam91cm5hbCBvZiB0aGUgZmFpbGluZyBib290IGlmIHVzZWZ1bA0KKGpv
dXJuYWxjdGwgLWIgLTEgaXMgc3RpbGwgb24gZGlzaykuDQoNCkJlc3QgcmVnYXJkcywNCkppbg0K
KEppblJNb3JpYXJ0eUBvdXRsb29rLmNvbSwgTml4T1MsIGtlcm5lbCA3LjIuMykNCg0K

--_000_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I'd like to report a reproducible kernel crash chain involving the btusb</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
driver with a Realtek RTL8852BU Bluetooth radio on a Lenovo laptop,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
running NixOS with the latest kernel.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
=3D=3D Hardware / environment =3D=3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- Machine: LENOVO 83D5 (board LNVNB161216), BIOS NQCN27WW</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- Kernel: 7.2.3 #1-NixOS PREEMPT(lazy) (nixpkgs linuxPackages_latest)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- BT radio: Realtek RTL8852BU, USB 0bda:4853, bus 1-3 (full-speed)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- Sleep mode: s2idle (only supported suspend state, /sys/power/mem_sleep)</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- Swap: 32 GiB LVM partition (hibernate works)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
- BT state during the whole incident: rfkill SOFT BLOCKED (radio off via</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; KDE), but btusb driver still bound to the USB interface</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
=3D=3D Timeline (all timestamps from journalctl, boot of 2026-09-04 09:43) =
=3D=3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. 2026-09-04, daytime: suspend/resume works normally (several clean</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;s2idle cycles).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. 2026-09-05 01:05:58: user-initiated HIBERNATE. It succeeded</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;(&quot;Operation 'hibernate' finished&quot;, image written to =
swap, clean</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;resume at 01:07:14).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. Immediately after that hibernate, every s2idle suspend attempt fails</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;with &quot;PM: Some devices failed to suspend, or early wake e=
vent</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;detected&quot; -- the machine wakes within ~1 second. KDE powe=
rdevil</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;retried automatically: over the next ~2.5 days the system atte=
mpted</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;2768 suspends, 2764 of them failed. Each cycle logged:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;- &quot;Bluetooth: hci0: RTL: download fw command faile=
d (-2)&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;- &quot;usb 1-3: reset full-speed USB device number 2 u=
sing xhci_hcd&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Count totals across the failing boot:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- suspend requests (logind): 2768</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- kernel s2idle entries: 5533</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- failed suspends: 2764</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- hci0 firmware download failures: 2448</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;- usb 1-3 resets: 6811</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
4. 2026-09-07 06:34:59, during a failed suspend attempt, first kernel</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;crash (list corruption in btusb disconnect path, triggered fro=
m the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;usb_reset_device workqueue):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;list_del corruption, ffff8a7308eac000-&gt;next is NULL</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;kernel BUG at lib/list_debug.c:52!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Oops: invalid opcode: 0000 [#1] SMP NOPTI</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Workqueue: events __usb_queue_reset_device</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;RIP: 0010:__list_del_entry_valid_or_report.cold+0xd/0x1e</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Call Trace:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;hci_unregister_dev+0x46/0x230 [bluetooth]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;btusb_disconnect+0x7f/0x1b0 [btusb]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;usb_unbind_driver_internal... / usb_forced_unbind_intf<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;usb_reset_device+0xed/0x2b0</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;__usb_queue_reset_device+0x3a/0x60</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;process_one_work / worker_thread / kthread</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
5. The Oops'ed kworker (PID 1881740, kworker/u64:0) DIED while holding a</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;lock (later stack shows it stuck in queued_write_lock_slowpath=
).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;From 06:35:45 onward, every USB re-probe of the BT radio queue=
d onto</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;CPU#4 and spun there forever in:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;btusb_probe -&gt; hci_register_dev -&gt; queued_write_l=
ock_slowpath</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;The soft lockup repeated 253 times over ~2h13m (7443 seconds o=
f</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;100% single-core CPU), overheating the machine, stalling RCU a=
nd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;fork(), making the system unusable until a forced power-off.</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Representative soft lockup stack (08:47:38, same as first):</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;watchdog: BUG: soft lockup - CPU#4 stuck for 7443s! [kworker/u=
64:0:1881740]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Workqueue: events_unbound deferred_probe_work_func</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;RIP: 0010:queued_write_lock_slowpath+0x62/0x120</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Call Trace:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;hci_register_dev+0x1fc/0x440 [bluetooth]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;btusb_probe+0xa17/0x10b9 [btusb]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;usb_probe_interface / really_probe / ...</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;deferred_probe_work_func / process_one_work / worker_th=
read</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
=3D=3D Questions for maintainers =3D=3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. What corrupts the hci_dev list (or its lock) such that</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;hci_unregister_dev() sees a NULL -&gt;next during a forced unb=
ind after</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;many failed suspend cycles? Is this a btusb bug, a bluetooth c=
ore</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;bug, or a USB-core interaction (usb_reset_device -&gt; forced =
unbind</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;while the interface driver is mid-suspend/resume)?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. Why does btusb_probe() spin in queued_write_lock_slowpath() for 7443</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;seconds without ever giving up (infinite retry / no timeout, o=
r lock</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;held by a dead Oops'ed task)? This is what physically overheat=
ed</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;the machine and made the system unrecoverable -- arguably the =
most</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;user-visible damage.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. Is a hibernate-then-s2idle transition expected to be safe for</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;btusb/RTL8852BU? The daytime s2idle cycles on 09-04 were fine;=
 the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;failure mode began exactly after the first hibernate of that b=
oot.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
=3D=3D Workaround =3D=3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Confirmed working: unloading the btusb driver stack before sleep and</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
reloading after resume (powerManagement.powerDownCommands /</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
resumeCommands in NixOS):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; modprobe -r btusb btrtl btintel btbcm btmtk</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; # sleep</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; modprobe btusb</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This keeps the radio entirely absent from the suspend path and has</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
eliminated both the instant-wake loop and the crash. (We don't know</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
yet whether it survives a hibernate + resume; will report back.)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
=3D=3D Attachments / logs =3D=3D</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Evidence files (~70 KB total), collected with journalctl from the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
failing boot, are attached:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
1. 1-kernel-oops-list-corruption.log - full Oops at 06:34:59 incl.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;complete call trace and register dump</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
2. 2-soft-lockup-first-report.log - first soft lockup at 06:35:45</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
3. 3-soft-lockup-hci-register-dev-spin.log - later soft lockup showing</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;the kworker stuck in hci_register_dev -&gt; queued_write_lock_=
slowpath</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
4. 4-hibernate-then-failing-suspends.log - transition: successful</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;hibernate, immediately followed by failing s2idle attempts</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
5. 5-hardware-and-counts.txt - hardware IDs and event counts</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I can provide the full journal of the failing boot if useful</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
(journalctl -b -1 is still on disk).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Best regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jin</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
(JinRMoriarty@outlook.com, NixOS, kernel 7.2.3)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_--

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/x-log; name="1-kernel-oops-list-corruption.log"
Content-Description: 1-kernel-oops-list-corruption.log
Content-Disposition: attachment; filename="1-kernel-oops-list-corruption.log";
	size=19989; creation-date="Mon, 07 Sep 2026 02:08:59 GMT";
	modification-date="Mon, 07 Sep 2026 02:10:51 GMT"
Content-Transfer-Encoding: base64

OeaciCAwNyAwNjozNDo1MSBuaXhvcyBrZXJuZWw6IHdscDRzMDogYXV0aGVudGljYXRlIHdpdGgg
MmM6NzA6NGY6M2Y6Nzc6NDIgKGxvY2FsIGFkZHJlc3M9YzA6MzU6MzI6ODE6ODE6OWQpCjnmnIgg
MDcgMDY6MzQ6NTEgbml4b3Mga2VybmVsOiB3bHA0czA6IHNlbmQgYXV0aCB0byAyYzo3MDo0Zjoz
Zjo3Nzo0MiAodHJ5IDEvMykKOeaciCAwNyAwNjozNDo1MiBuaXhvcyBrZXJuZWw6IEJsdWV0b290
aDogaGNpMDogY29tbWFuZCAweGZjNjEgdHggdGltZW91dAo55pyIIDA3IDA2OjM0OjUyIG5peG9z
IGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IEZhaWxlZCB0byBnZW5lcmF0ZSBkZXZjb3Jl
ZHVtcAo55pyIIDA3IDA2OjM0OjUyIG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSZXNl
dHRpbmcgdXNiIGRldmljZS4KOeaciCAwNyAwNjozNDo1MiBuaXhvcyBrZXJuZWw6IEJsdWV0b290
aDogaGNpMDogUlRMOiBSVEw6IFJlYWQgcmVnMTYgZmFpbGVkICgtMTEwKQo55pyIIDA3IDA2OjM0
OjUyIG5peG9zIGtlcm5lbDogd2xwNHMwOiBhdXRoZW50aWNhdGUgd2l0aCAyYzo3MDo0ZjozZjo3
Nzo0MiAobG9jYWwgYWRkcmVzcz1jMDozNTozMjo4MTo4MTo5ZCkKOeaciCAwNyAwNjozNDo1MiBu
aXhvcyBrZXJuZWw6IHdscDRzMDogc2VuZCBhdXRoIHRvIDJjOjcwOjRmOjNmOjc3OjQyICh0cnkg
MS8zKQo55pyIIDA3IDA2OjM0OjUyIG5peG9zIGtlcm5lbDogd2xwNHMwOiBhdXRoZW50aWNhdGVk
CjnmnIggMDcgMDY6MzQ6NTIgbml4b3Mga2VybmVsOiB3bHA0czA6IGFzc29jaWF0ZSB3aXRoIDJj
OjcwOjRmOjNmOjc3OjQyICh0cnkgMS8zKQo55pyIIDA3IDA2OjM0OjUyIG5peG9zIGtlcm5lbDog
d2xwNHMwOiBSWCBBc3NvY1Jlc3AgZnJvbSAyYzo3MDo0ZjozZjo3Nzo0MiAoY2FwYWI9MHgxMDMx
IHN0YXR1cz0wIGFpZD05KQo55pyIIDA3IDA2OjM0OjUyIG5peG9zIGtlcm5lbDogdXNiIDEtMzog
cmVzZXQgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkCjnmnIgg
MDcgMDY6MzQ6NTIgbml4b3Mga2VybmVsOiB3bHA0czA6IGFzc29jaWF0ZWQKOeaciCAwNyAwNjoz
NDo1MiBuaXhvcyBrZXJuZWw6IHdscDRzMDogTGltaXRpbmcgVFggcG93ZXIgdG8gMzAgKDMwIC0g
MCkgZEJtIGFzIGFkdmVydGlzZWQgYnkgMmM6NzA6NGY6M2Y6Nzc6NDIKOeaciCAwNyAwNjozNDo1
NCBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogY29tbWFuZCAweGZjNjEgdHggdGltZW91
dAo55pyIIDA3IDA2OjM0OjU0IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IEZh
aWxlZCB0byBnZW5lcmF0ZSBkZXZjb3JlZHVtcAo55pyIIDA3IDA2OjM0OjU0IG5peG9zIGtlcm5l
bDogQmx1ZXRvb3RoOiBoY2kwOiBSZXNldHRpbmcgdXNiIGRldmljZS4KOeaciCAwNyAwNjozNDo1
NCBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBSVEw6IFJlYWQgcmVnMTYgZmFp
bGVkICgtMTEwKQo55pyIIDA3IDA2OjM0OjU0IG5peG9zIGtlcm5lbDogdXNiIDEtMzogcmVzZXQg
ZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkCjnmnIggMDcgMDY6
MzQ6NTYgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IGNvbW1hbmQgMHhmYzYxIHR4IHRp
bWVvdXQKOeaciCAwNyAwNjozNDo1NiBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRM
OiBGYWlsZWQgdG8gZ2VuZXJhdGUgZGV2Y29yZWR1bXAKOeaciCAwNyAwNjozNDo1NiBuaXhvcyBr
ZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBSVEw6IFJlYWQgcmVnMTYgZmFpbGVkICgtMTEw
KQo55pyIIDA3IDA2OjM0OjU2IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSZXNldHRp
bmcgdXNiIGRldmljZS4KOeaciCAwNyAwNjozNDo1NiBuaXhvcyBrZXJuZWw6IHVzYiAxLTM6IHJl
c2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4aGNpX2hjZAo55pyIIDA3
IDA2OjM0OjU3IG5peG9zIGtlcm5lbDogd2xwNHMwOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gMmM6
NzA6NGY6M2Y6Nzc6NDIgYnkgbG9jYWwgY2hvaWNlIChSZWFzb246IDM9REVBVVRIX0xFQVZJTkcp
CjnmnIggMDcgMDY6MzQ6NTggbml4b3Mga2VybmVsOiBQTTogc3VzcGVuZCBlbnRyeSAoczJpZGxl
KQo55pyIIDA3IDA2OjM0OjU4IG5peG9zIGtlcm5lbDogRmlsZXN5c3RlbXMgc3luYzogMC4wMzYg
c2Vjb25kcwo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogRnJlZXppbmcgdXNlciBzcGFj
ZSBwcm9jZXNzZXMKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHVzZXIg
c3BhY2UgcHJvY2Vzc2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAwMSBzZWNvbmRzKQo55pyIIDA3
IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogT09NIGtpbGxlciBkaXNhYmxlZC4KOeaciCAwNyAwNjoz
NDo1OSBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MKOeac
iCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUg
dGFza3MgY29tcGxldGVkIChlbGFwc2VkIDAuMDAwIHNlY29uZHMpCjnmnIggMDcgMDY6MzQ6NTkg
bml4b3Mga2VybmVsOiBwcmludGs6IFN1c3BlbmRpbmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNv
bGVfc3VzcGVuZCB0byBkZWJ1ZykKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IFBNOiBT
b21lIGRldmljZXMgZmFpbGVkIHRvIHN1c3BlbmQsIG9yIGVhcmx5IHdha2UgZXZlbnQgZGV0ZWN0
ZWQKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFtk
cm1dIFBDSUUgR0FSVCBvZiA1MTJNIGVuYWJsZWQgKHRhYmxlIGF0IDB4MDAwMDAwODBGRkQwMDAw
MCkuCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiBT
TVUgaXMgcmVzdW1pbmcuLi4KOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAw
MDAwOjM1OjAwLjA6IFNNVSBpcyByZXN1bWVkIHN1Y2Nlc3NmdWxseSEKOeaciCAwNyAwNjozNDo1
OSBuaXhvcyBrZXJuZWw6IG52bWUgbnZtZTA6IDE2LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1
ZXMKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogY29tbWFu
ZCAweGZjNjEgdHggdGltZW91dAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogQmx1ZXRv
b3RoOiBoY2kwOiBSVEw6IEZhaWxlZCB0byBnZW5lcmF0ZSBkZXZjb3JlZHVtcAo55pyIIDA3IDA2
OjM0OjU5IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSZXNldHRpbmcgdXNiIGRldmlj
ZS4KOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBS
VEw6IFJlYWQgcmVnMTYgZmFpbGVkICgtMTEwKQo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5l
bDogdXNiIDEtMzogcmVzZXQgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHho
Y2lfaGNkCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4w
OiByaW5nIGdmeF8wLjAuMCB1c2VzIFZNIGludiBlbmcgMCBvbiBodWIgMAo55pyIIDA3IDA2OjM0
OjU5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMC4wIHVz
ZXMgVk0gaW52IGVuZyAxIG9uIGh1YiAwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBh
bWRncHUgMDAwMDozNTowMC4wOiByaW5nIGNvbXBfMS4xLjAgdXNlcyBWTSBpbnYgZW5nIDQgb24g
aHViIDAKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6
IHJpbmcgY29tcF8xLjIuMCB1c2VzIFZNIGludiBlbmcgNiBvbiBodWIgMAo55pyIIDA3IDA2OjM0
OjU5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMy4wIHVz
ZXMgVk0gaW52IGVuZyA3IG9uIGh1YiAwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBh
bWRncHUgMDAwMDozNTowMC4wOiByaW5nIGNvbXBfMS4wLjEgdXNlcyBWTSBpbnYgZW5nIDggb24g
aHViIDAKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6
IHJpbmcgY29tcF8xLjEuMSB1c2VzIFZNIGludiBlbmcgOSBvbiBodWIgMAo55pyIIDA3IDA2OjM0
OjU5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMi4xIHVz
ZXMgVk0gaW52IGVuZyAxMCBvbiBodWIgMAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDog
YW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMy4xIHVzZXMgVk0gaW52IGVuZyAxMSBv
biBodWIgMAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAu
MDogcmluZyBzZG1hMCB1c2VzIFZNIGludiBlbmcgMTIgb24gaHViIDAKOeaciCAwNyAwNjozNDo1
OSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgdmNuX3VuaWZpZWRfMCB1
c2VzIFZNIGludiBlbmcgMCBvbiBodWIgOAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDog
YW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBqcGVnX2RlYyB1c2VzIFZNIGludiBlbmcgMSBvbiBo
dWIgOAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDog
cmluZyBtZXNfa2lxXzMuMS4wIHVzZXMgVk0gaW52IGVuZyAxMyBvbiBodWIgMAo55pyIIDA3IDA2
OjM0OjU5IG5peG9zIGtlcm5lbDogbGlzdF9kZWwgY29ycnVwdGlvbiwgZmZmZjhhNzMwOGVhYzAw
MC0+bmV4dCBpcyBOVUxMCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiAtLS0tLS0tLS0t
LS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6
IGtlcm5lbCBCVUcgYXQgbGliL2xpc3RfZGVidWcuYzo1MiEKOeaciCAwNyAwNjozNDo1OSBuaXhv
cyBrZXJuZWw6IE9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gU01QIE5PUFRJCjnmnIgg
MDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBDUFU6IDAgVUlEOiAwIFBJRDogMTkyNjcyOSBDb21t
OiBrd29ya2VyLzA6MiBOb3QgdGFpbnRlZCA3LjIuMyAjMS1OaXhPUyBQUkVFTVBUKGxhenkpIAo5
5pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogSGFyZHdhcmUgbmFtZTogTEVOT1ZPIDgzRDUv
TE5WTkIxNjEyMTYsIEJJT1MgTlFDTjI3V1cgMDcvMTAvMjAyNAo55pyIIDA3IDA2OjM0OjU5IG5p
eG9zIGtlcm5lbDogV29ya3F1ZXVlOiBldmVudHMgX191c2JfcXVldWVfcmVzZXRfZGV2aWNlCjnm
nIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92
YWxpZF9vcl9yZXBvcnQuY29sZCsweGQvMHgxZQo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5l
bDogQ29kZTogYzcgYzcgMTAgYmIgOTAgYjcgZTggYWIgNGIgZmUgZmYgOTAgMGYgMGIgNDggYzcg
YzcgZTggYmEgOTAgYjcgZTggOWMgNGIgZmUgZmYgOTAgMGYgMGIgNDggYzcgYzcgMjAgYmMgOTAg
YjcgZTggOGQgNGIgZmUgZmYgOTAgPDBmPiAwYiA0OCBjNyBjNyA1MCBiYyA5MCBiNyBlOCA3ZSA0
YiBmZSBmZiA5MCAwZiAwYiA0ZCA4NSBmNiA0OCBjNwo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtl
cm5lbDogUlNQOiAwMDE4OmZmZmZkMDY2MjgwNTdkMTAgRUZMQUdTOiAwMDAxMDI0Ngo55pyIIDA3
IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAwMDMzIFJCWDogZmZmZjhh
NzMwOGVhYzAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBr
ZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiBm
ZmZmOGE3NjIxYTFlOTQwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBSQlA6IGZmZmY4
YTczMDhlYWM1ZDggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDA0ZjE2Mgo5
5pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogUjEwOiBmZmZmZmZmZmI4MjVlMDYwIFIxMTog
ZmZmZmQwNjYyODA1N2JjMCBSMTI6IGZmZmY4YTczMDhlYWMwMDAKOeaciCAwNyAwNjozNDo1OSBu
aXhvcyBrZXJuZWw6IFIxMzogZmZmZmZmZmZjMTllMjJmMCBSMTQ6IGZmZmZmZmZmYzE5ZTIyZjAg
UjE1OiBmZmZmOGE2ZmQ2ZDA3ODUwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBGUzog
IDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjhhNzY2OGNiYzAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBDUzogIDAwMTAg
RFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCjnmnIggMDcgMDY6MzQ6NTkg
bml4b3Mga2VybmVsOiBDUjI6IDAwMDA3OGUwMDgwMzJjMjggQ1IzOiAwMDAwMDAwNWU0YTIyMDAw
IENSNDogMDAwMDAwMDAwMGY1MGVmMAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogUEtS
VTogNTU1NTU1NTQKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IENhbGwgVHJhY2U6Cjnm
nIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiAgPFRBU0s+CjnmnIggMDcgMDY6MzQ6NTkgbml4
b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3
IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogIGhjaV91bnJlZ2lzdGVyX2RldisweDQ2LzB4MjMwIFti
bHVldG9vdGhdCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiAgYnR1c2JfZGlzY29ubmVj
dCsweDdmLzB4MWIwIFtidHVzYl0KOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6ICB1c2Jf
dW5iaW5kX2ludGVyZmFjZSsweDkyLzB4MzQwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVs
OiAgPyBrZXJuZnNfcmVtb3ZlX2J5X25hbWVfbnMrMHhlZi8weDExMAo55pyIIDA3IDA2OjM0OjU5
IG5peG9zIGtlcm5lbDogIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5ZS8weDIw
MAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogIHVzYl9mb3JjZWRfdW5iaW5kX2ludGYr
MHg4Yy8weGQwCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3Jl
dHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogID8g
dXNiX2F1dG9yZXN1bWVfZGV2aWNlKzB4MWUvMHg1MAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtl
cm5lbDogIHVzYl9yZXNldF9kZXZpY2UrMHhlZC8weDJiMAo55pyIIDA3IDA2OjM0OjU5IG5peG9z
IGtlcm5lbDogIF9fdXNiX3F1ZXVlX3Jlc2V0X2RldmljZSsweDNhLzB4NjAKOeaciCAwNyAwNjoz
NDo1OSBuaXhvcyBrZXJuZWw6ICBwcm9jZXNzX29uZV93b3JrKzB4MTk5LzB4MzcwCjnmnIggMDcg
MDY6MzQ6NTkgbml4b3Mga2VybmVsOiAgd29ya2VyX3RocmVhZCsweDE3Ny8weDJlMAo55pyIIDA3
IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEwLzB4MTAK
OeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6ICBrdGhyZWFkKzB4ZTIvMHgxMTAKOeaciCAw
NyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwCjnmnIgg
MDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiAgcmV0X2Zyb21fZm9yaysweDI1MS8weDMzMAo55pyI
IDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKOeac
iCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAK
OeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6ICA8L1RBU0s+CjnmnIggMDcgMDY6MzQ6NTkg
bml4b3Mga2VybmVsOiBNb2R1bGVzIGxpbmtlZCBpbjogbXB0Y3BfZGlhZyByYXdfZGlhZyB1bml4
X2RpYWcgYWZfcGFja2V0X2RpYWcgbmV0bGlua19kaWFnIHVkcF9kaWFnIHRjcF9kaWFnIGluZXRf
ZGlhZyBzZF9tb2Qgc2NzaV9tb2Qgc2NzaV9jb21tb24gY2NtIHFydHIgeHRfY29ubnRyYWNrIHh0
X01BU1FVRVJBREUgeGZybV91c2VyIHhmcm1fYWxnbyB4dF9zZXQgaXBfc2V0IHh0X2FkZHJ0eXBl
IG5mdF9jb21wYXQgbmZ0X21hc3EgbmZ0X3JlamVjdF9pcHY0IG5mX3JlamVjdF9pcHY0IG5mdF9y
ZWplY3QgYWN0X2NzdW0gY2xzX3UzMiBzY2hfaHRiIG5mdF9jaGFpbl9uYXQgcmZjb21tIHNuZF9z
ZXFfZHVtbXkgc25kX2hydGltZXIgc25kX3NlcSBzbmRfc2VxX2RldmljZSBhZl9wYWNrZXQgYWVz
IGFsZ2lmX2hhc2ggYWxnaWZfc2tjaXBoZXIgYWZfYWxnIGJuZXAgbmZ0X2N0IG5mdF9maWJfaW5l
dCBuZnRfZmliX2lwdjQgbmZ0X2ZpYl9pcHY2IG5mdF9maWIgbmZfdGFibGVzIGFtZGdwdSBubHNf
aXNvODg1OV8xIG5sc19jcDQzNyB2ZmF0IGZhdCBhbWR4ZG5hIGFtZF9wbWYgYW1kdGVlIGFtZHhj
cCBhbWRfc2ZoIGRybV9wYW5lbF9iYWNrbGlnaHRfcXVpcmtzIHNuZF9zb2NfZG1pYyBzbmRfcHNf
cGRtX2RtYSBzbmRfc29jX3BzX21hY2ggc25kX3NvZl9hbWRfYWNwNzAgc25kX3NvZl9hbWRfYWNw
NjMgc25kX3NvZl9hbWRfdmFuZ29naCBzbmRfc29mX2FtZF9yZW1icmFuZHQgcnR3ODlfODg1MmJl
IHNuZF9zb2ZfYW1kX3Jlbm9pciBzbmRfc29mX2FtZF9hY3AgcnR3ODlfODg1MmIgc25kX3NvZl9w
Y2kgc25kX3NvZl94dGVuc2FfZHNwIHJ0dzg5Xzg4NTJiX2NvbW1vbiBzbmRfc29mIHJ0dzg5X3Bj
aSBzbmRfc29mX3V0aWxzIHNuZF9wY2lfYWNwN3ggc25kX3BjaV9wcyBzbmRfc29jX2FjcGlfYW1k
X21hdGNoIHJ0dzg5X2NvcmUgc25kX2FtZF9zZHdfYWNwaSBzb3VuZHdpcmVfYW1kIHNuZF9jdGxf
bGVkIHNvdW5kd2lyZV9nZW5lcmljX2FsbG9jYXRpb24gc291bmR3aXJlX2J1cwo55pyIIDA3IDA2
OjM0OjU5IG5peG9zIGtlcm5lbDogIHNuZF9oZGFfY29kZWNfYWxjMjY5IHNuZF9zb2Nfc2RjYSBz
bmRfaGRhX2NvZGVjX3JlYWx0ZWtfbGliIHNuZF9oZGFfc2NvZGVjX2NvbXBvbmVudCBoaWRfc2Vu
c29yX2N1c3RvbSBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgc25kX3NvY19jb3JlIHNuZF9oZGFfY29k
ZWNfYXRpaGRtaSBtYWM4MDIxMSBzbmRfaGRhX2NvZGVjX2hkbWkgaGlkX211bHRpdG91Y2ggc3Bk
NTExOCBoaWRfc2Vuc29yX2h1YiBzbmRfY29tcHJlc3MgZHJtX2J1ZGR5IGRybV9leGVjIGFjOTdf
YnVzIGRybV9zdWJhbGxvY19oZWxwZXIgYnR1c2Igc25kX3BjbV9kbWFlbmdpbmUgZHJtX3R0bV9o
ZWxwZXIgYnRydGwgc25kX2hkYV9pbnRlbCBzcDUxMDBfdGNvIGJ0aW50ZWwgdXZjdmlkZW8gdHRt
IHNuZF9hY3BfcGNpIGJ0bXRrIHNuZF9hbWRfYWNwaV9tYWNoIGJ0YmNtIHdhdGNoZG9nIHNuZF9o
ZGFfY29kZWMgc25kX2FjcF9sZWdhY3lfY29tbW9uIGVkYWNfbWNlX2FtZCBkcm1fZGlzcGxheV9o
ZWxwZXIgdmlkZW9idWYyX3ZtYWxsb2MgbGVub3ZvX3dtaV9vdGhlciBjZmc4MDIxMSBlZGFjX2Nv
cmUgdXZjIGJsdWV0b290aCBzbmRfaGRhX2NvcmUgdmlkZW9idWYyX21lbW9wcyB1Y3NpX2FjcGkg
dGhpbmtfbG1pIGxlbm92b193bWlfY2FwZGF0YSBjZWMgdmlkZW9idWYyX3Y0bDIgc25kX2ludGVs
X2RzcGNmZyBzbmRfcGNpX2FjcDZ4IGxlbm92b193bWlfZ2FtZXpvbmUgZ3B1X3NjaGVkIHZpZGVv
YnVmMl9jb21tb24gaTJjX2FsZ29fYml0IGkyY19waWl4NCB0eXBlY191Y3NpIGFtZF9hdGwgc25k
X3BjaV9hY3A1eCBpZGVhcGFkX2xhcHRvcCBzbmRfaW50ZWxfc2R3X2FjcGkgbGVub3ZvX3dtaV9o
ZWxwZXJzIGxlbm92b193bWlfaG90a2V5X3V0aWxpdGllcyBmaXJtd2FyZV9hdHRyaWJ1dGVzX2Ns
YXNzIGxlbm92b193bWlfZXZlbnRzIHdtaV9ibW9mIHZpZGVvZGV2IGludGVsX3JhcGxfbXNyIGlu
dGVsX3JhcGxfY29tbW9uIGVjZGhfZ2VuZXJpYyBzcGFyc2Vfa2V5bWFwIHNuZF9od2RlcCBhZXNu
aV9pbnRlbCBnZjEyOG11bAo55pyIIDA3IDA2OjM0OjU5IG5peG9zIGtlcm5lbDogIHJhcGwgbWMg
cm9sZXMgZWNjIGV2ZGV2IGsxMHRlbXAgam95ZGV2IG1vdXNlZGV2IGkyY19zbWJ1cyBiYXR0ZXJ5
IHRlZSB0eXBlYyBydGNfY21vcyBzbmRfcGNtIHNuZF9ybl9wY2lfYWNwM3ggdmlkZW8gaTJjX2hp
ZF9hY3BpIHNuZF9hY3BfY29uZmlnIHNuZF90aW1lciBpMmNfaGlkIHRpbnlfcG93ZXJfYnV0dG9u
IHNuZF9zb2NfYWNwaSByZmtpbGwgaW5wdXRfbGVkcyBzbmQgbGliYXJjNCBidXR0b24gbGVkX2Ns
YXNzIGFlYWQgY3JjMTYgc25kX3BjaV9hY3AzeCBzb3VuZGNvcmUgYW1kX3BtYyBhYyB0aGVybWFs
IHdtaSBtYWNfaGlkIHNlcmlvX3JhdyBzY2hfZnFfY29kZWwga3ZtX2FtZCBjY3Aga3ZtIHh0X25h
dCBicl9uZXRmaWx0ZXIgeF90YWJsZXMgbmZfbmF0IGJyaWRnZSBuZl9jb25udHJhY2sgbmZfZGVm
cmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgdHVuIHN0cCBpcnFieXBhc3MgbG9vcCB2ZXRoIHVpbnB1
dCBsbGMgY3RyIGZ1c2UgZG1pX3N5c2ZzIGhpZF9nZW5lcmljIHVzYmhpZCBoaWQgcnRzeF9wY2lf
c2RtbWMgbnZtZSBhdGtiZCBtbWNfY29yZSBsaWJwczIgdml2YWxkaV9mbWFwIG52bWVfY29yZSBp
ODA0MiB4aGNpX3BjaSBudm1lX2tleXJpbmcgdGh1bmRlcmJvbHQgc2VyaW8geGhjaV9oY2QgcnRz
eF9wY2kgbnZtZV9hdXRoIGJ0cmZzIGxpYmJsYWtlMmIgZG1fc25hcHNob3QgZG1fYnVmaW8gZG1f
bW9kIHJhaWQ2X3BxIHhvciBjb25maWdmcyBlZml2YXJmcyBhdXRvZnM0CjnmnIggMDcgMDY6MzQ6
NTkgbml4b3Mga2VybmVsOiAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KOeac
iCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IE9PTSBraWxsZXIgZW5hYmxlZC4KOeaciCAwNyAw
NjozNDo1OSBuaXhvcyBrZXJuZWw6IFJlc3RhcnRpbmcgdGFza3M6IFN0YXJ0aW5nCjnmnIggMDcg
MDY6MzQ6NTkgbml4b3Mga2VybmVsOiBSZXN0YXJ0aW5nIHRhc2tzOiBEb25lCjnmnIggMDcgMDY6
MzQ6NTkgbml4b3Mga2VybmVsOiBlZml2YXJmczogcmVzeW5jaW5nIHZhcmlhYmxlIHN0YXRlCjnm
nIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBlZml2YXJmczogZmluaXNoZWQgcmVzeW5jaW5n
IHZhcmlhYmxlIHN0YXRlCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiByYW5kb206IGNy
bmcgcmVzZWVkZWQgb24gc3lzdGVtIHJlc3VtcHRpb24KOeaciCAwNyAwNjozNDo1OSBuaXhvcyBr
ZXJuZWw6IFBNOiBzdXNwZW5kIGV4aXQKOeaciCAwNyAwNjozNDo1OSBuaXhvcyBrZXJuZWw6IFBN
OiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpCjnmnIggMDcgMDY6MzQ6NTkgbml4b3Mga2VybmVsOiBG
aWxlc3lzdGVtcyBzeW5jOiAwLjA3MiBzZWNvbmRzCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2Vy
bmVsOiBwc3RvcmU6IGJhY2tlbmQgKGVmaV9wc3RvcmUpIHdyaXRpbmcgZXJyb3IgKC0xNikKOeac
iCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IFJJUDogMDAxMDpfX2xpc3RfZGVsX2VudHJ5X3Zh
bGlkX29yX3JlcG9ydC5jb2xkKzB4ZC8weDFlCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVs
OiBDb2RlOiBjNyBjNyAxMCBiYiA5MCBiNyBlOCBhYiA0YiBmZSBmZiA5MCAwZiAwYiA0OCBjNyBj
NyBlOCBiYSA5MCBiNyBlOCA5YyA0YiBmZSBmZiA5MCAwZiAwYiA0OCBjNyBjNyAyMCBiYyA5MCBi
NyBlOCA4ZCA0YiBmZSBmZiA5MCA8MGY+IDBiIDQ4IGM3IGM3IDUwIGJjIDkwIGI3IGU4IDdlIDRi
IGZlIGZmIDkwIDBmIDBiIDRkIDg1IGY2IDQ4IGM3CjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2Vy
bmVsOiBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcwo55pyIIDA3IDA2OjM1OjE5IG5peG9z
IGtlcm5lbDogUlNQOiAwMDE4OmZmZmZkMDY2MjgwNTdkMTAgRUZMQUdTOiAwMDAxMDI0Ngo55pyI
IDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAwMDMzIFJCWDogZmZm
ZjhhNzMwOGVhYzAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAwNjozNToxOSBuaXhv
cyBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJ
OiBmZmZmOGE3NjIxYTFlOTQwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBSQlA6IGZm
ZmY4YTczMDhlYWM1ZDggUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDA0ZjE2
Mgo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogUjEwOiBmZmZmZmZmZmI4MjVlMDYwIFIx
MTogZmZmZmQwNjYyODA1N2JjMCBSMTI6IGZmZmY4YTczMDhlYWMwMDAKOeaciCAwNyAwNjozNTox
OSBuaXhvcyBrZXJuZWw6IFIxMzogZmZmZmZmZmZjMTllMjJmMCBSMTQ6IGZmZmZmZmZmYzE5ZTIy
ZjAgUjE1OiBmZmZmOGE2ZmQ2ZDA3ODUwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBG
UzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjhhNzY2OGNiYzAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCjnmnIggMDcgMDY6MzU6
MTkgbml4b3Mga2VybmVsOiBDUjI6IDAwMDA3OGUwMDgwMzJjMjggQ1IzOiAwMDAwMDAwNWU0YTIy
MDAwIENSNDogMDAwMDAwMDAwMGY1MGVmMAo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDog
UEtSVTogNTU1NTU1NTQKOeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IG5vdGU6IGt3b3Jr
ZXIvMDoyWzE5MjY3MjldIGV4aXRlZCB3aXRoIHByZWVtcHRfY291bnQgMQo55pyIIDA3IDA2OjM1
OjE5IG5peG9zIGtlcm5lbDogRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxldGVk
IChlbGFwc2VkIDAuMDAxIHNlY29uZHMpCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBP
T00ga2lsbGVyIGRpc2FibGVkLgo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogRnJlZXpp
bmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcwo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5l
bDogRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyBmYWlsZWQgYWZ0ZXIgMjAuMDAz
IHNlY29uZHMgKDAgdGFza3MgcmVmdXNpbmcgdG8gZnJlZXplLCB3cV9idXN5PTEpOgo55pyIIDA3
IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogU2hvd2luZyBmcmVlemFibGUgd29ya3F1ZXVlcyB0aGF0
IGFyZSBzdGlsbCBidXN5Ogo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogd29ya3F1ZXVl
IGV2ZW50c19mcmVlemFibGU6IGZsYWdzPTB4MTA0CjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2Vy
bmVsOiAgIHB3cSA0NjogY3B1cz0xMSBub2RlPTAgZmxhZ3M9MHgwIG5pY2U9MCBhY3RpdmU9MCBy
ZWZjbnQ9Mgo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogICAgIGluYWN0aXZlOiBwY2lf
cG1lX2xpc3Rfc2Nhbgo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogd29ya3F1ZXVlIHVz
Yl9odWJfd3E6IGZsYWdzPTB4MTA0CjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiAgIHB3
cSAxODogY3B1cz00IG5vZGU9MCBmbGFncz0weDAgbmljZT0wIGFjdGl2ZT0xIHJlZmNudD0yCjnm
nIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiAgICAgcGVuZGluZzogaHViX2V2ZW50CjnmnIgg
MDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBSZXN0YXJ0aW5nIGtlcm5lbCB0aHJlYWRzIC4uLgo5
5pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogRG9uZSByZXN0YXJ0aW5nIGtlcm5lbCB0aHJl
YWRzLgo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogT09NIGtpbGxlciBlbmFibGVkLgo5
5pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogUmVzdGFydGluZyB0YXNrczogU3RhcnRpbmcK
OeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IFJlc3RhcnRpbmcgdGFza3M6IERvbmUKOeac
iCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiByZXN5bmNpbmcgdmFyaWFibGUg
c3RhdGUKOeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiBjcmVhdGluZyB2
YXJpYWJsZSBkdW1wLXR5cGUwLTItMS0xNzg4NzM0MDk5LUMtY2ZjOGZjNzktYmUyZS00ZGRjLTk3
ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBlZml2YXJmczog
Y3JlYXRpbmcgdmFyaWFibGUgZHVtcC10eXBlMC0zLTEtMTc4ODczNDA5OS1DLWNmYzhmYzc5LWJl
MmUtNGRkYy05N2YwLTlmOThiZmUyOThhMAo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDog
ZWZpdmFyZnM6IGNyZWF0aW5nIHZhcmlhYmxlIGR1bXAtdHlwZTAtNC0xLTE3ODg3MzQwOTktQy1j
ZmM4ZmM3OS1iZTJlLTRkZGMtOTdmMC05Zjk4YmZlMjk4YTAKOeaciCAwNyAwNjozNToxOSBuaXhv
cyBrZXJuZWw6IGVmaXZhcmZzOiBjcmVhdGluZyB2YXJpYWJsZSBkdW1wLXR5cGUwLTUtMS0xNzg4
NzM0MDk5LUMtY2ZjOGZjNzktYmUyZS00ZGRjLTk3ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcgMDY6
MzU6MTkgbml4b3Mga2VybmVsOiBlZml2YXJmczogY3JlYXRpbmcgdmFyaWFibGUgZHVtcC10eXBl
MC02LTEtMTc4ODczNDA5OS1DLWNmYzhmYzc5LWJlMmUtNGRkYy05N2YwLTlmOThiZmUyOThhMAo5
5pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogZWZpdmFyZnM6IGNyZWF0aW5nIHZhcmlhYmxl
IGR1bXAtdHlwZTAtNy0xLTE3ODg3MzQwOTktQy1jZmM4ZmM3OS1iZTJlLTRkZGMtOTdmMC05Zjk4
YmZlMjk4YTAKOeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiBjcmVhdGlu
ZyB2YXJpYWJsZSBkdW1wLXR5cGUwLTgtMS0xNzg4NzM0MDk5LUMtY2ZjOGZjNzktYmUyZS00ZGRj
LTk3ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBlZml2YXJm
czogY3JlYXRpbmcgdmFyaWFibGUgZHVtcC10eXBlMC05LTEtMTc4ODczNDA5OS1DLWNmYzhmYzc5
LWJlMmUtNGRkYy05N2YwLTlmOThiZmUyOThhMAo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5l
bDogZWZpdmFyZnM6IGNyZWF0aW5nIHZhcmlhYmxlIGR1bXAtdHlwZTAtMTAtMS0xNzg4NzM0MDk5
LUMtY2ZjOGZjNzktYmUyZS00ZGRjLTk3ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcgMDY6MzU6MTkg
bml4b3Mga2VybmVsOiBlZml2YXJmczogY3JlYXRpbmcgdmFyaWFibGUgZHVtcC10eXBlMC0xMS0x
LTE3ODg3MzQwOTktQy1jZmM4ZmM3OS1iZTJlLTRkZGMtOTdmMC05Zjk4YmZlMjk4YTAKOeaciCAw
NyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiBjcmVhdGluZyB2YXJpYWJsZSBkdW1w
LXR5cGUwLTEyLTEtMTc4ODczNDA5OS1DLWNmYzhmYzc5LWJlMmUtNGRkYy05N2YwLTlmOThiZmUy
OThhMAo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogZWZpdmFyZnM6IGNyZWF0aW5nIHZh
cmlhYmxlIGR1bXAtdHlwZTAtMTMtMS0xNzg4NzM0MDk5LUMtY2ZjOGZjNzktYmUyZS00ZGRjLTk3
ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcgMDY6MzU6MTkgbml4b3Mga2VybmVsOiBlZml2YXJmczog
Y3JlYXRpbmcgdmFyaWFibGUgZHVtcC10eXBlMC0xNC0xLTE3ODg3MzQwOTktQy1jZmM4ZmM3OS1i
ZTJlLTRkZGMtOTdmMC05Zjk4YmZlMjk4YTAKOeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6
IGVmaXZhcmZzOiBjcmVhdGluZyB2YXJpYWJsZSBkdW1wLXR5cGUwLTE1LTEtMTc4ODczNDA5OS1D
LWNmYzhmYzc5LWJlMmUtNGRkYy05N2YwLTlmOThiZmUyOThhMAo55pyIIDA3IDA2OjM1OjE5IG5p
eG9zIGtlcm5lbDogZWZpdmFyZnM6IGNyZWF0aW5nIHZhcmlhYmxlIGR1bXAtdHlwZTAtMTYtMS0x
Nzg4NzM0MDk5LUMtY2ZjOGZjNzktYmUyZS00ZGRjLTk3ZjAtOWY5OGJmZTI5OGEwCjnmnIggMDcg
MDY6MzU6MTkgbml4b3Mga2VybmVsOiBlZml2YXJmczogY3JlYXRpbmcgdmFyaWFibGUgZHVtcC10
eXBlMC0xNy0xLTE3ODg3MzQwOTktQy1jZmM4ZmM3OS1iZTJlLTRkZGMtOTdmMC05Zjk4YmZlMjk4
YTAKOeaciCAwNyAwNjozNToxOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiBjcmVhdGluZyB2YXJp
YWJsZSBkdW1wLXR5cGUwLTE4LTEtMTc4ODczNDA5OS1DLWNmYzhmYzc5LWJlMmUtNGRkYy05N2Yw
LTlmOThiZmUyOThhMAo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtlcm5lbDogZWZpdmFyZnM6IGZp
bmlzaGVkIHJlc3luY2luZyB2YXJpYWJsZSBzdGF0ZQo55pyIIDA3IDA2OjM1OjE5IG5peG9zIGtl
cm5lbDogcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uCjnmnIggMDcg
MDY6MzU6MTkgbml4b3Mga2VybmVsOiBQTTogc3VzcGVuZCBleGl0CjnmnIggMDcgMDY6MzU6MjAg
bml4b3Mga2VybmVsOiByY3U6IElORk86IHJjdV9wcmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3RhbGwg
b24gQ1BVCjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiByY3U6ICAgICAgICAgNC0uLi4u
OiAoMjA2MzEgdGlja3MgdGhpcyBHUCkgaWRsZT0wOGNjLzEvMHg0MDAwMDAwMDAwMDAwMDAwIHNv
ZnRpcnE9MjAxNDIxMTYvMjAxNDIxMTYgZnFzPTUwODcKOeaciCAwNyAwNjozNToyMCBuaXhvcyBr
ZXJuZWw6IHJjdTogICAgICAgICAodD0yMTAwMCBqaWZmaWVzIGc9NzU1NzM4NDEgcT0zNTE0IG5j
cHVzPTE2KQo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogQ1BVOiA0IFVJRDogMCBQSUQ6
IDE4ODE3NDAgQ29tbToga3dvcmtlci91NjQ6MCBUYWludGVkOiBHICAgICAgRCAgICAgICAgICAg
ICA3LjIuMyAjMS1OaXhPUyBQUkVFTVBUKGxhenkpIAo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtl
cm5lbDogVGFpbnRlZDogW0RdPURJRQo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogSGFy
ZHdhcmUgbmFtZTogTEVOT1ZPIDgzRDUvTE5WTkIxNjEyMTYsIEJJT1MgTlFDTjI3V1cgMDcvMTAv
MjAyNAo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogV29ya3F1ZXVlOiBldmVudHNfdW5i
b3VuZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMKOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJu
ZWw6IFJJUDogMDAxMDpxdWV1ZWRfd3JpdGVfbG9ja19zbG93cGF0aCsweDYyLzB4MTIwCjnmnIgg
MDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiBDb2RlOiA4OSBlZiBjNiAwNyAwMCAwZiAxZiAwMCA2
NiA5MCA1YiA1ZCBlOSBkMiBlOCBmYiBmZSBmMCA4MSAwYiAwMCAwMSAwMCAwMCBiYSBmZiAwMCAw
MCAwMCA4YiAwMyAzZCAwMCAwMSAwMCAwMCA3NCAwYiBmMyA5MCA4YiAwMyA8M2Q+IDAwIDAxIDAw
IDAwIDc1IGY1IGI4IDAwIDAxIDAwIDAwIGYwIDBmIGIxIDEzIDc0IGMzIGViIGRmIDY1IDhiCjnm
nIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmQwNjYyNTcyN2MwMCBF
RkxBR1M6IDAwMDAwMjA2CjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiBSQVg6IDAwMDAw
MDAwMDAwMDAxZmYgUkJYOiBmZmZmZmZmZmMxOGQyZTQ4IFJDWDogMDAwMDAwMDAwMDAwMDAwMAo5
5pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMGZmIFJTSTog
MDAwMDAwMDAwMDAwMDI4NiBSREk6IGZmZmZmZmZmYzE4ZDJlNDgKOeaciCAwNyAwNjozNToyMCBu
aXhvcyBrZXJuZWw6IFJCUDogZmZmZmZmZmZjMThkMmU0YyBSMDg6IDAwMDAwMDAwMDAwMDAwMDAg
UjA5OiBmZmZmOGE2ZmQ2ZWI0NmMwCjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiBSMTA6
IGZmZmY4YTZmYzAwNGUyMDAgUjExOiAwMDAwNzU5MGMwMDAwMDAwIFIxMjogMDAwMDAwMDAwMDAw
MDAwMAo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogUjEzOiBmZmZmOGE2ZmQzMGNkNDAw
IFIxNDogZmZmZjhhNmZkMzBjZDUyOCBSMTU6IGZmZmY4YTczMDhlYWMwMDAKOeaciCAwNyAwNjoz
NToyMCBuaXhvcyBrZXJuZWw6IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGE3
NjY4ZWJjMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAwNjozNToyMCBu
aXhvcyBrZXJuZWw6IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMKOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJuZWw6IENSMjogMDAwMDdiNGVhYWZmZDgy
OCBDUjM6IDAwMDAwMDA1ZTRhMjIwMDAgQ1I0OiAwMDAwMDAwMDAwZjUwZWYwCjnmnIggMDcgMDY6
MzU6MjAgbml4b3Mga2VybmVsOiBQS1JVOiA1NTU1NTU1NAo55pyIIDA3IDA2OjM1OjIwIG5peG9z
IGtlcm5lbDogQ2FsbCBUcmFjZToKOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJuZWw6ICA8VEFT
Sz4KOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJuZWw6ICBoY2lfcmVnaXN0ZXJfZGV2KzB4MWZj
LzB4NDQwIFtibHVldG9vdGhdCjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAgYnR1c2Jf
cHJvYmUrMHhhMTcvMHgxMGI5IFtidHVzYl0KOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJuZWw6
ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIggMDcgMDY6MzU6MjAg
bml4b3Mga2VybmVsOiAgPyBfX3BtX3J1bnRpbWVfc2V0X3N0YXR1cysweDE5MC8weDJmMAo55pyI
IDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIHVzYl9wcm9iZV9pbnRlcmZhY2UrMHhlMC8weDJk
MAo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIHJlYWxseV9wcm9iZSsweGRlLzB4Mzgw
CjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVu
aysweDUvMHhmYmVmNQo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogID8gX19wZnhfX19k
ZXZpY2VfYXR0YWNoX2RyaXZlcisweDEwLzB4MTAKOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJu
ZWw6ICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NS8weDE3MAo55pyIIDA3IDA2OjM1OjIwIG5p
eG9zIGtlcm5lbDogIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxZi8weDkwCjnmnIggMDcgMDY6MzU6
MjAgbml4b3Mga2VybmVsOiAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweDg5LzB4MTMwCjnmnIgg
MDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUv
MHhmYmVmNQo55pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIGJ1c19mb3JfZWFjaF9kcnYr
MHg5Mi8weGUwCjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAgX19kZXZpY2VfYXR0YWNo
KzB4YjAvMHgxYzAKOeaciCAwNyAwNjozNToyMCBuaXhvcyBrZXJuZWw6ICA/IHNyc29fYWxpYXNf
cmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAg
ZGV2aWNlX2luaXRpYWxfcHJvYmUrMHg0YS8weDcwCjnmnIggMDcgMDY6MzU6MjAgbml4b3Mga2Vy
bmVsOiAgYnVzX3Byb2JlX2RldmljZSsweDJkLzB4OTAKOeaciCAwNyAwNjozNToyMCBuaXhvcyBr
ZXJuZWw6ICBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMrMHg5Yi8weDEwMAo55pyIIDA3IDA2OjM1
OjIwIG5peG9zIGtlcm5lbDogIHByb2Nlc3Nfb25lX3dvcmsrMHgxOTkvMHgzNzAKOeaciCAwNyAw
NjozNToyMCBuaXhvcyBrZXJuZWw6ICB3b3JrZXJfdGhyZWFkKzB4MTc3LzB4MmUwCjnmnIggMDcg
MDY6MzU6MjAgbml4b3Mga2VybmVsOiAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMAo5
5pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIGt0aHJlYWQrMHhlMi8weDExMAo55pyIIDA3
IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKOeaciCAw
NyAwNjozNToyMCBuaXhvcyBrZXJuZWw6ICByZXRfZnJvbV9mb3JrKzB4MjUxLzB4MzMwCjnmnIgg
MDcgMDY6MzU6MjAgbml4b3Mga2VybmVsOiAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMAo55pyI
IDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMAo5
5pyIIDA3IDA2OjM1OjIwIG5peG9zIGtlcm5lbDogIDwvVEFTSz4K

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/x-log; name="2-soft-lockup-first-report.log"
Content-Description: 2-soft-lockup-first-report.log
Content-Disposition: attachment; filename="2-soft-lockup-first-report.log";
	size=16272; creation-date="Mon, 07 Sep 2026 02:09:00 GMT";
	modification-date="Mon, 07 Sep 2026 02:10:51 GMT"
Content-Transfer-Encoding: base64

OeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6IHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3Vw
IC0gQ1BVIzQgc3R1Y2sgZm9yIDQ1cyEgW2t3b3JrZXIvdTY0OjA6MTg4MTc0MF0KOeaciCAwNyAw
NjozNTo0NSBuaXhvcyBrZXJuZWw6IE1vZHVsZXMgbGlua2VkIGluOiBtcHRjcF9kaWFnIHJhd19k
aWFnIHVuaXhfZGlhZyBhZl9wYWNrZXRfZGlhZyBuZXRsaW5rX2RpYWcgdWRwX2RpYWcgdGNwX2Rp
YWcgaW5ldF9kaWFnIHNkX21vZCBzY3NpX21vZCBzY3NpX2NvbW1vbiBjY20gcXJ0ciB4dF9jb25u
dHJhY2sgeHRfTUFTUVVFUkFERSB4ZnJtX3VzZXIgeGZybV9hbGdvIHh0X3NldCBpcF9zZXQgeHRf
YWRkcnR5cGUgbmZ0X2NvbXBhdCBuZnRfbWFzcSBuZnRfcmVqZWN0X2lwdjQgbmZfcmVqZWN0X2lw
djQgbmZ0X3JlamVjdCBhY3RfY3N1bSBjbHNfdTMyIHNjaF9odGIgbmZ0X2NoYWluX25hdCByZmNv
bW0gc25kX3NlcV9kdW1teSBzbmRfaHJ0aW1lciBzbmRfc2VxIHNuZF9zZXFfZGV2aWNlIGFmX3Bh
Y2tldCBhZXMgYWxnaWZfaGFzaCBhbGdpZl9za2NpcGhlciBhZl9hbGcgYm5lcCBuZnRfY3QgbmZ0
X2ZpYl9pbmV0IG5mdF9maWJfaXB2NCBuZnRfZmliX2lwdjYgbmZ0X2ZpYiBuZl90YWJsZXMgYW1k
Z3B1IG5sc19pc284ODU5XzEgbmxzX2NwNDM3IHZmYXQgZmF0IGFtZHhkbmEgYW1kX3BtZiBhbWR0
ZWUgYW1keGNwIGFtZF9zZmggZHJtX3BhbmVsX2JhY2tsaWdodF9xdWlya3Mgc25kX3NvY19kbWlj
IHNuZF9wc19wZG1fZG1hIHNuZF9zb2NfcHNfbWFjaCBzbmRfc29mX2FtZF9hY3A3MCBzbmRfc29m
X2FtZF9hY3A2MyBzbmRfc29mX2FtZF92YW5nb2doIHNuZF9zb2ZfYW1kX3JlbWJyYW5kdCBydHc4
OV84ODUyYmUgc25kX3NvZl9hbWRfcmVub2lyIHNuZF9zb2ZfYW1kX2FjcCBydHc4OV84ODUyYiBz
bmRfc29mX3BjaSBzbmRfc29mX3h0ZW5zYV9kc3AgcnR3ODlfODg1MmJfY29tbW9uIHNuZF9zb2Yg
cnR3ODlfcGNpIHNuZF9zb2ZfdXRpbHMgc25kX3BjaV9hY3A3eCBzbmRfcGNpX3BzIHNuZF9zb2Nf
YWNwaV9hbWRfbWF0Y2ggcnR3ODlfY29yZSBzbmRfYW1kX3Nkd19hY3BpIHNvdW5kd2lyZV9hbWQg
c25kX2N0bF9sZWQgc291bmR3aXJlX2dlbmVyaWNfYWxsb2NhdGlvbiBzb3VuZHdpcmVfYnVzCjnm
nIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgc25kX2hkYV9jb2RlY19hbGMyNjkgc25kX3Nv
Y19zZGNhIHNuZF9oZGFfY29kZWNfcmVhbHRla19saWIgc25kX2hkYV9zY29kZWNfY29tcG9uZW50
IGhpZF9zZW5zb3JfY3VzdG9tIHNuZF9oZGFfY29kZWNfZ2VuZXJpYyBzbmRfc29jX2NvcmUgc25k
X2hkYV9jb2RlY19hdGloZG1pIG1hYzgwMjExIHNuZF9oZGFfY29kZWNfaGRtaSBoaWRfbXVsdGl0
b3VjaCBzcGQ1MTE4IGhpZF9zZW5zb3JfaHViIHNuZF9jb21wcmVzcyBkcm1fYnVkZHkgZHJtX2V4
ZWMgYWM5N19idXMgZHJtX3N1YmFsbG9jX2hlbHBlciBidHVzYiBzbmRfcGNtX2RtYWVuZ2luZSBk
cm1fdHRtX2hlbHBlciBidHJ0bCBzbmRfaGRhX2ludGVsIHNwNTEwMF90Y28gYnRpbnRlbCB1dmN2
aWRlbyB0dG0gc25kX2FjcF9wY2kgYnRtdGsgc25kX2FtZF9hY3BpX21hY2ggYnRiY20gd2F0Y2hk
b2cgc25kX2hkYV9jb2RlYyBzbmRfYWNwX2xlZ2FjeV9jb21tb24gZWRhY19tY2VfYW1kIGRybV9k
aXNwbGF5X2hlbHBlciB2aWRlb2J1ZjJfdm1hbGxvYyBsZW5vdm9fd21pX290aGVyIGNmZzgwMjEx
IGVkYWNfY29yZSB1dmMgYmx1ZXRvb3RoIHNuZF9oZGFfY29yZSB2aWRlb2J1ZjJfbWVtb3BzIHVj
c2lfYWNwaSB0aGlua19sbWkgbGVub3ZvX3dtaV9jYXBkYXRhIGNlYyB2aWRlb2J1ZjJfdjRsMiBz
bmRfaW50ZWxfZHNwY2ZnIHNuZF9wY2lfYWNwNnggbGVub3ZvX3dtaV9nYW1lem9uZSBncHVfc2No
ZWQgdmlkZW9idWYyX2NvbW1vbiBpMmNfYWxnb19iaXQgaTJjX3BpaXg0IHR5cGVjX3Vjc2kgYW1k
X2F0bCBzbmRfcGNpX2FjcDV4IGlkZWFwYWRfbGFwdG9wIHNuZF9pbnRlbF9zZHdfYWNwaSBsZW5v
dm9fd21pX2hlbHBlcnMgbGVub3ZvX3dtaV9ob3RrZXlfdXRpbGl0aWVzIGZpcm13YXJlX2F0dHJp
YnV0ZXNfY2xhc3MgbGVub3ZvX3dtaV9ldmVudHMgd21pX2Jtb2YgdmlkZW9kZXYgaW50ZWxfcmFw
bF9tc3IgaW50ZWxfcmFwbF9jb21tb24gZWNkaF9nZW5lcmljIHNwYXJzZV9rZXltYXAgc25kX2h3
ZGVwIGFlc25pX2ludGVsIGdmMTI4bXVsCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAg
cmFwbCBtYyByb2xlcyBlY2MgZXZkZXYgazEwdGVtcCBqb3lkZXYgbW91c2VkZXYgaTJjX3NtYnVz
IGJhdHRlcnkgdGVlIHR5cGVjIHJ0Y19jbW9zIHNuZF9wY20gc25kX3JuX3BjaV9hY3AzeCB2aWRl
byBpMmNfaGlkX2FjcGkgc25kX2FjcF9jb25maWcgc25kX3RpbWVyIGkyY19oaWQgdGlueV9wb3dl
cl9idXR0b24gc25kX3NvY19hY3BpIHJma2lsbCBpbnB1dF9sZWRzIHNuZCBsaWJhcmM0IGJ1dHRv
biBsZWRfY2xhc3MgYWVhZCBjcmMxNiBzbmRfcGNpX2FjcDN4IHNvdW5kY29yZSBhbWRfcG1jIGFj
IHRoZXJtYWwgd21pIG1hY19oaWQgc2VyaW9fcmF3IHNjaF9mcV9jb2RlbCBrdm1fYW1kIGNjcCBr
dm0geHRfbmF0IGJyX25ldGZpbHRlciB4X3RhYmxlcyBuZl9uYXQgYnJpZGdlIG5mX2Nvbm50cmFj
ayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCB0dW4gc3RwIGlycWJ5cGFzcyBsb29wIHZl
dGggdWlucHV0IGxsYyBjdHIgZnVzZSBkbWlfc3lzZnMgaGlkX2dlbmVyaWMgdXNiaGlkIGhpZCBy
dHN4X3BjaV9zZG1tYyBudm1lIGF0a2JkIG1tY19jb3JlIGxpYnBzMiB2aXZhbGRpX2ZtYXAgbnZt
ZV9jb3JlIGk4MDQyIHhoY2lfcGNpIG52bWVfa2V5cmluZyB0aHVuZGVyYm9sdCBzZXJpbyB4aGNp
X2hjZCBydHN4X3BjaSBudm1lX2F1dGggYnRyZnMgbGliYmxha2UyYiBkbV9zbmFwc2hvdCBkbV9i
dWZpbyBkbV9tb2QgcmFpZDZfcHEgeG9yIGNvbmZpZ2ZzIGVmaXZhcmZzIGF1dG9mczQKOeaciCAw
NyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6IENQVTogNCBVSUQ6IDAgUElEOiAxODgxNzQwIENvbW06
IGt3b3JrZXIvdTY0OjAgVGFpbnRlZDogRyAgICAgIEQgICAgICAgICAgICAgNy4yLjMgIzEtTml4
T1MgUFJFRU1QVChsYXp5KSAKOeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6IFRhaW50ZWQ6
IFtEXT1ESUUKOeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IExF
Tk9WTyA4M0Q1L0xOVk5CMTYxMjE2LCBCSU9TIE5RQ04yN1dXIDA3LzEwLzIwMjQKOeaciCAwNyAw
NjozNTo0NSBuaXhvcyBrZXJuZWw6IFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgZGVmZXJyZWRf
cHJvYmVfd29ya19mdW5jCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiBSSVA6IDAwMTA6
cXVldWVkX3dyaXRlX2xvY2tfc2xvd3BhdGgrMHg2Mi8weDEyMAo55pyIIDA3IDA2OjM1OjQ1IG5p
eG9zIGtlcm5lbDogQ29kZTogODkgZWYgYzYgMDcgMDAgMGYgMWYgMDAgNjYgOTAgNWIgNWQgZTkg
ZDIgZTggZmIgZmUgZjAgODEgMGIgMDAgMDEgMDAgMDAgYmEgZmYgMDAgMDAgMDAgOGIgMDMgM2Qg
MDAgMDEgMDAgMDAgNzQgMGIgZjMgOTAgOGIgMDMgPDNkPiAwMCAwMSAwMCAwMCA3NSBmNSBiOCAw
MCAwMSAwMCAwMCBmMCAwZiBiMSAxMyA3NCBjMyBlYiBkZiA2NSA4Ygo55pyIIDA3IDA2OjM1OjQ1
IG5peG9zIGtlcm5lbDogUlNQOiAwMDE4OmZmZmZkMDY2MjU3MjdjMDAgRUZMQUdTOiAwMDAwMDIw
Ngo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAwMWZmIFJC
WDogZmZmZmZmZmZjMThkMmU0OCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAwNjozNTo0
NSBuaXhvcyBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDBmZiBSU0k6IDAwMDAwMDAwMDAwMDAy
ODYgUkRJOiBmZmZmZmZmZmMxOGQyZTQ4CjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiBS
QlA6IGZmZmZmZmZmYzE4ZDJlNGMgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZmZjhhNmZk
NmViNDZjMAo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogUjEwOiBmZmZmOGE2ZmMwMDRl
MjAwIFIxMTogMDAwMDc1OTBjMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAw
NjozNTo0NSBuaXhvcyBrZXJuZWw6IFIxMzogZmZmZjhhNmZkMzBjZDQwMCBSMTQ6IGZmZmY4YTZm
ZDMwY2Q1MjggUjE1OiBmZmZmOGE3MzA4ZWFjMDAwCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2Vy
bmVsOiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjhhNzY2OGViYzAwMCgwMDAw
KSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiBD
UzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCjnmnIggMDcg
MDY6MzU6NDUgbml4b3Mga2VybmVsOiBDUjI6IDAwMDA3YjRlYWFmZmQ4MjggQ1IzOiAwMDAwMDAw
NWU0YTIyMDAwIENSNDogMDAwMDAwMDAwMGY1MGVmMAo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtl
cm5lbDogUEtSVTogNTU1NTU1NTQKOeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6IENhbGwg
VHJhY2U6CjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgPFRBU0s+CjnmnIggMDcgMDY6
MzU6NDUgbml4b3Mga2VybmVsOiAgaGNpX3JlZ2lzdGVyX2RldisweDFmYy8weDQ0MCBbYmx1ZXRv
b3RoXQo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogIGJ0dXNiX3Byb2JlKzB4YTE3LzB4
MTBiOSBbYnR1c2JdCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFz
X3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDog
ID8gX19wbV9ydW50aW1lX3NldF9zdGF0dXMrMHgxOTAvMHgyZjAKOeaciCAwNyAwNjozNTo0NSBu
aXhvcyBrZXJuZWw6ICB1c2JfcHJvYmVfaW50ZXJmYWNlKzB4ZTAvMHgyZDAKOeaciCAwNyAwNjoz
NTo0NSBuaXhvcyBrZXJuZWw6ICByZWFsbHlfcHJvYmUrMHhkZS8weDM4MAo55pyIIDA3IDA2OjM1
OjQ1IG5peG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUK
OeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6ICA/IF9fcGZ4X19fZGV2aWNlX2F0dGFjaF9k
cml2ZXIrMHgxMC8weDEwCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgX19kcml2ZXJf
cHJvYmVfZGV2aWNlKzB4ODUvMHgxNzAKOeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6ICBk
cml2ZXJfcHJvYmVfZGV2aWNlKzB4MWYvMHg5MAo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5l
bDogIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHg4OS8weDEzMAo55pyIIDA3IDA2OjM1OjQ1IG5p
eG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKOeaciCAw
NyAwNjozNTo0NSBuaXhvcyBrZXJuZWw6ICBidXNfZm9yX2VhY2hfZHJ2KzB4OTIvMHhlMAo55pyI
IDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogIF9fZGV2aWNlX2F0dGFjaCsweGIwLzB4MWMwCjnm
nIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysw
eDUvMHhmYmVmNQo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogIGRldmljZV9pbml0aWFs
X3Byb2JlKzB4NGEvMHg3MAo55pyIIDA3IDA2OjM1OjQ1IG5peG9zIGtlcm5lbDogIGJ1c19wcm9i
ZV9kZXZpY2UrMHgyZC8weDkwCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mga2VybmVsOiAgZGVmZXJy
ZWRfcHJvYmVfd29ya19mdW5jKzB4OWIvMHgxMDAKOeaciCAwNyAwNjozNTo0NSBuaXhvcyBrZXJu
ZWw6ICBwcm9jZXNzX29uZV93b3JrKzB4MTk5LzB4MzcwCjnmnIggMDcgMDY6MzU6NDUgbml4b3Mg
a2VybmVsOiAgd29ya2VyX3RocmVhZCsweDE3Ny8weDJlMAo55pyIIDA3IDA2OjM1OjQ1IG5peG9z
IGtlcm5lbDogID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEwLzB4MTAKOeaciCAwNyAwNjozNTo0
NSBuaXhvcyBrZXJuZWw6ICBrdGhyZWFkKzB4ZTIvMHgxMTAKOeaciCAwNyAwNjozNTo0NSBuaXhv
cyBrZXJuZWw6ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwCjnmnIggMDcgMDY6MzU6NDUgbml4
b3Mga2VybmVsOiAgcmV0X2Zyb21fZm9yaysweDI1MS8weDMzMAo55pyIIDA3IDA2OjM1OjQ1IG5p
eG9zIGtlcm5lbDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKOeaciCAwNyAwNjozNTo0NSBu
aXhvcyBrZXJuZWw6ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAKOeaciCAwNyAwNjozNTo0
NSBuaXhvcyBrZXJuZWw6ICA8L1RBU0s+CjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiB3
YXRjaGRvZzogQlVHOiBzb2Z0IGxvY2t1cCAtIENQVSM0IHN0dWNrIGZvciA3MXMhIFtrd29ya2Vy
L3U2NDowOjE4ODE3NDBdCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiBNb2R1bGVzIGxp
bmtlZCBpbjogbXB0Y3BfZGlhZyByYXdfZGlhZyB1bml4X2RpYWcgYWZfcGFja2V0X2RpYWcgbmV0
bGlua19kaWFnIHVkcF9kaWFnIHRjcF9kaWFnIGluZXRfZGlhZyBzZF9tb2Qgc2NzaV9tb2Qgc2Nz
aV9jb21tb24gY2NtIHFydHIgeHRfY29ubnRyYWNrIHh0X01BU1FVRVJBREUgeGZybV91c2VyIHhm
cm1fYWxnbyB4dF9zZXQgaXBfc2V0IHh0X2FkZHJ0eXBlIG5mdF9jb21wYXQgbmZ0X21hc3EgbmZ0
X3JlamVjdF9pcHY0IG5mX3JlamVjdF9pcHY0IG5mdF9yZWplY3QgYWN0X2NzdW0gY2xzX3UzMiBz
Y2hfaHRiIG5mdF9jaGFpbl9uYXQgcmZjb21tIHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgc25k
X3NlcSBzbmRfc2VxX2RldmljZSBhZl9wYWNrZXQgYWVzIGFsZ2lmX2hhc2ggYWxnaWZfc2tjaXBo
ZXIgYWZfYWxnIGJuZXAgbmZ0X2N0IG5mdF9maWJfaW5ldCBuZnRfZmliX2lwdjQgbmZ0X2ZpYl9p
cHY2IG5mdF9maWIgbmZfdGFibGVzIGFtZGdwdSBubHNfaXNvODg1OV8xIG5sc19jcDQzNyB2ZmF0
IGZhdCBhbWR4ZG5hIGFtZF9wbWYgYW1kdGVlIGFtZHhjcCBhbWRfc2ZoIGRybV9wYW5lbF9iYWNr
bGlnaHRfcXVpcmtzIHNuZF9zb2NfZG1pYyBzbmRfcHNfcGRtX2RtYSBzbmRfc29jX3BzX21hY2gg
c25kX3NvZl9hbWRfYWNwNzAgc25kX3NvZl9hbWRfYWNwNjMgc25kX3NvZl9hbWRfdmFuZ29naCBz
bmRfc29mX2FtZF9yZW1icmFuZHQgcnR3ODlfODg1MmJlIHNuZF9zb2ZfYW1kX3Jlbm9pciBzbmRf
c29mX2FtZF9hY3AgcnR3ODlfODg1MmIgc25kX3NvZl9wY2kgc25kX3NvZl94dGVuc2FfZHNwIHJ0
dzg5Xzg4NTJiX2NvbW1vbiBzbmRfc29mIHJ0dzg5X3BjaSBzbmRfc29mX3V0aWxzIHNuZF9wY2lf
YWNwN3ggc25kX3BjaV9wcyBzbmRfc29jX2FjcGlfYW1kX21hdGNoIHJ0dzg5X2NvcmUgc25kX2Ft
ZF9zZHdfYWNwaSBzb3VuZHdpcmVfYW1kIHNuZF9jdGxfbGVkIHNvdW5kd2lyZV9nZW5lcmljX2Fs
bG9jYXRpb24gc291bmR3aXJlX2J1cwo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIHNu
ZF9oZGFfY29kZWNfYWxjMjY5IHNuZF9zb2Nfc2RjYSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWtfbGli
IHNuZF9oZGFfc2NvZGVjX2NvbXBvbmVudCBoaWRfc2Vuc29yX2N1c3RvbSBzbmRfaGRhX2NvZGVj
X2dlbmVyaWMgc25kX3NvY19jb3JlIHNuZF9oZGFfY29kZWNfYXRpaGRtaSBtYWM4MDIxMSBzbmRf
aGRhX2NvZGVjX2hkbWkgaGlkX211bHRpdG91Y2ggc3BkNTExOCBoaWRfc2Vuc29yX2h1YiBzbmRf
Y29tcHJlc3MgZHJtX2J1ZGR5IGRybV9leGVjIGFjOTdfYnVzIGRybV9zdWJhbGxvY19oZWxwZXIg
YnR1c2Igc25kX3BjbV9kbWFlbmdpbmUgZHJtX3R0bV9oZWxwZXIgYnRydGwgc25kX2hkYV9pbnRl
bCBzcDUxMDBfdGNvIGJ0aW50ZWwgdXZjdmlkZW8gdHRtIHNuZF9hY3BfcGNpIGJ0bXRrIHNuZF9h
bWRfYWNwaV9tYWNoIGJ0YmNtIHdhdGNoZG9nIHNuZF9oZGFfY29kZWMgc25kX2FjcF9sZWdhY3lf
Y29tbW9uIGVkYWNfbWNlX2FtZCBkcm1fZGlzcGxheV9oZWxwZXIgdmlkZW9idWYyX3ZtYWxsb2Mg
bGVub3ZvX3dtaV9vdGhlciBjZmc4MDIxMSBlZGFjX2NvcmUgdXZjIGJsdWV0b290aCBzbmRfaGRh
X2NvcmUgdmlkZW9idWYyX21lbW9wcyB1Y3NpX2FjcGkgdGhpbmtfbG1pIGxlbm92b193bWlfY2Fw
ZGF0YSBjZWMgdmlkZW9idWYyX3Y0bDIgc25kX2ludGVsX2RzcGNmZyBzbmRfcGNpX2FjcDZ4IGxl
bm92b193bWlfZ2FtZXpvbmUgZ3B1X3NjaGVkIHZpZGVvYnVmMl9jb21tb24gaTJjX2FsZ29fYml0
IGkyY19waWl4NCB0eXBlY191Y3NpIGFtZF9hdGwgc25kX3BjaV9hY3A1eCBpZGVhcGFkX2xhcHRv
cCBzbmRfaW50ZWxfc2R3X2FjcGkgbGVub3ZvX3dtaV9oZWxwZXJzIGxlbm92b193bWlfaG90a2V5
X3V0aWxpdGllcyBmaXJtd2FyZV9hdHRyaWJ1dGVzX2NsYXNzIGxlbm92b193bWlfZXZlbnRzIHdt
aV9ibW9mIHZpZGVvZGV2IGludGVsX3JhcGxfbXNyIGludGVsX3JhcGxfY29tbW9uIGVjZGhfZ2Vu
ZXJpYyBzcGFyc2Vfa2V5bWFwIHNuZF9od2RlcCBhZXNuaV9pbnRlbCBnZjEyOG11bAo55pyIIDA3
IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIHJhcGwgbWMgcm9sZXMgZWNjIGV2ZGV2IGsxMHRlbXAg
am95ZGV2IG1vdXNlZGV2IGkyY19zbWJ1cyBiYXR0ZXJ5IHRlZSB0eXBlYyBydGNfY21vcyBzbmRf
cGNtIHNuZF9ybl9wY2lfYWNwM3ggdmlkZW8gaTJjX2hpZF9hY3BpIHNuZF9hY3BfY29uZmlnIHNu
ZF90aW1lciBpMmNfaGlkIHRpbnlfcG93ZXJfYnV0dG9uIHNuZF9zb2NfYWNwaSByZmtpbGwgaW5w
dXRfbGVkcyBzbmQgbGliYXJjNCBidXR0b24gbGVkX2NsYXNzIGFlYWQgY3JjMTYgc25kX3BjaV9h
Y3AzeCBzb3VuZGNvcmUgYW1kX3BtYyBhYyB0aGVybWFsIHdtaSBtYWNfaGlkIHNlcmlvX3JhdyBz
Y2hfZnFfY29kZWwga3ZtX2FtZCBjY3Aga3ZtIHh0X25hdCBicl9uZXRmaWx0ZXIgeF90YWJsZXMg
bmZfbmF0IGJyaWRnZSBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQg
dHVuIHN0cCBpcnFieXBhc3MgbG9vcCB2ZXRoIHVpbnB1dCBsbGMgY3RyIGZ1c2UgZG1pX3N5c2Zz
IGhpZF9nZW5lcmljIHVzYmhpZCBoaWQgcnRzeF9wY2lfc2RtbWMgbnZtZSBhdGtiZCBtbWNfY29y
ZSBsaWJwczIgdml2YWxkaV9mbWFwIG52bWVfY29yZSBpODA0MiB4aGNpX3BjaSBudm1lX2tleXJp
bmcgdGh1bmRlcmJvbHQgc2VyaW8geGhjaV9oY2QgcnRzeF9wY2kgbnZtZV9hdXRoIGJ0cmZzIGxp
YmJsYWtlMmIgZG1fc25hcHNob3QgZG1fYnVmaW8gZG1fbW9kIHJhaWQ2X3BxIHhvciBjb25maWdm
cyBlZml2YXJmcyBhdXRvZnM0CjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiBDUFU6IDQg
VUlEOiAwIFBJRDogMTg4MTc0MCBDb21tOiBrd29ya2VyL3U2NDowIFRhaW50ZWQ6IEcgICAgICBE
ICAgICAgTCAgICAgIDcuMi4zICMxLU5peE9TIFBSRUVNUFQobGF6eSkgCjnmnIggMDcgMDY6MzY6
MTMgbml4b3Mga2VybmVsOiBUYWludGVkOiBbRF09RElFLCBbTF09U09GVExPQ0tVUAo55pyIIDA3
IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogSGFyZHdhcmUgbmFtZTogTEVOT1ZPIDgzRDUvTE5WTkIx
NjEyMTYsIEJJT1MgTlFDTjI3V1cgMDcvMTAvMjAyNAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtl
cm5lbDogV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMK
OeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6IFJJUDogMDAxMDpxdWV1ZWRfd3JpdGVfbG9j
a19zbG93cGF0aCsweDYyLzB4MTIwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiBDb2Rl
OiA4OSBlZiBjNiAwNyAwMCAwZiAxZiAwMCA2NiA5MCA1YiA1ZCBlOSBkMiBlOCBmYiBmZSBmMCA4
MSAwYiAwMCAwMSAwMCAwMCBiYSBmZiAwMCAwMCAwMCA4YiAwMyAzZCAwMCAwMSAwMCAwMCA3NCAw
YiBmMyA5MCA4YiAwMyA8M2Q+IDAwIDAxIDAwIDAwIDc1IGY1IGI4IDAwIDAxIDAwIDAwIGYwIDBm
IGIxIDEzIDc0IGMzIGViIGRmIDY1IDhiCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiBS
U1A6IDAwMTg6ZmZmZmQwNjYyNTcyN2MwMCBFRkxBR1M6IDAwMDAwMjA2CjnmnIggMDcgMDY6MzY6
MTMgbml4b3Mga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAxZmYgUkJYOiBmZmZmZmZmZmMxOGQy
ZTQ4IFJDWDogMDAwMDAwMDAwMDAwMDAwMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDog
UkRYOiAwMDAwMDAwMDAwMDAwMGZmIFJTSTogMDAwMDAwMDAwMDAwMDI4NiBSREk6IGZmZmZmZmZm
YzE4ZDJlNDgKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6IFJCUDogZmZmZmZmZmZjMThk
MmU0YyBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGE2ZmQ2ZWI0NmMwCjnmnIggMDcg
MDY6MzY6MTMgbml4b3Mga2VybmVsOiBSMTA6IGZmZmY4YTZmYzAwNGUyMDAgUjExOiAwMDAwNzU5
MGMwMDAwMDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtl
cm5lbDogUjEzOiBmZmZmOGE2ZmQzMGNkNDAwIFIxNDogZmZmZjhhNmZkMzBjZDUyOCBSMTU6IGZm
ZmY4YTczMDhlYWMwMDAKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6IEZTOiAgMDAwMDAw
MDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGE3NjY4ZWJjMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDAKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6IENTOiAgMDAxMCBEUzogMDAw
MCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBr
ZXJuZWw6IENSMjogMDAwMDdiNGVhYWZmZDgyOCBDUjM6IDAwMDAwMDA1ZTRhMjIwMDAgQ1I0OiAw
MDAwMDAwMDAwZjUwZWYwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiBQS1JVOiA1NTU1
NTU1NAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogQ2FsbCBUcmFjZToKOeaciCAwNyAw
NjozNjoxMyBuaXhvcyBrZXJuZWw6ICA8VEFTSz4KOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJu
ZWw6ICBoY2lfcmVnaXN0ZXJfZGV2KzB4MWZjLzB4NDQwIFtibHVldG9vdGhdCjnmnIggMDcgMDY6
MzY6MTMgbml4b3Mga2VybmVsOiAgYnR1c2JfcHJvYmUrMHhhMTcvMHgxMGI5IFtidHVzYl0KOeac
iCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4
NS8weGZiZWY1CjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgPyBfX3BtX3J1bnRpbWVf
c2V0X3N0YXR1cysweDE5MC8weDJmMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIHVz
Yl9wcm9iZV9pbnRlcmZhY2UrMHhlMC8weDJkMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5l
bDogIHJlYWxseV9wcm9iZSsweGRlLzB4MzgwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVs
OiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA2OjM2OjEz
IG5peG9zIGtlcm5lbDogID8gX19wZnhfX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweDEwLzB4MTAK
OeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6ICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4
NS8weDE3MAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIGRyaXZlcl9wcm9iZV9kZXZp
Y2UrMHgxZi8weDkwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgX19kZXZpY2VfYXR0
YWNoX2RyaXZlcisweDg5LzB4MTMwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgPyBz
cnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA2OjM2OjEzIG5peG9z
IGtlcm5lbDogIGJ1c19mb3JfZWFjaF9kcnYrMHg5Mi8weGUwCjnmnIggMDcgMDY6MzY6MTMgbml4
b3Mga2VybmVsOiAgX19kZXZpY2VfYXR0YWNoKzB4YjAvMHgxYzAKOeaciCAwNyAwNjozNjoxMyBu
aXhvcyBrZXJuZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIgg
MDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgZGV2aWNlX2luaXRpYWxfcHJvYmUrMHg0YS8weDcw
CjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgYnVzX3Byb2JlX2RldmljZSsweDJkLzB4
OTAKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6ICBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1
bmMrMHg5Yi8weDEwMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIHByb2Nlc3Nfb25l
X3dvcmsrMHgxOTkvMHgzNzAKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6ICB3b3JrZXJf
dGhyZWFkKzB4MTc3LzB4MmUwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgPyBfX3Bm
eF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDog
IGt0aHJlYWQrMHhlMi8weDExMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogID8gX19w
Znhfa3RocmVhZCsweDEwLzB4MTAKOeaciCAwNyAwNjozNjoxMyBuaXhvcyBrZXJuZWw6ICByZXRf
ZnJvbV9mb3JrKzB4MjUxLzB4MzMwCjnmnIggMDcgMDY6MzY6MTMgbml4b3Mga2VybmVsOiAgPyBf
X3BmeF9rdGhyZWFkKzB4MTAvMHgxMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDogIHJl
dF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMAo55pyIIDA3IDA2OjM2OjEzIG5peG9zIGtlcm5lbDog
IDwvVEFTSz4KOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6IHJjdTogSU5GTzogcmN1X3By
ZWVtcHQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBr
ZXJuZWw6IHJjdTogICAgICAgICA0LS4uLi46ICg4MzYzNCB0aWNrcyB0aGlzIEdQKSBpZGxlPTA4
Y2MvMS8weDQwMDAwMDAwMDAwMDAwMDAgc29mdGlycT0yMDE0MjExNi8yMDE0MjExNyBmcXM9MjQ4
OTMKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6IHJjdTogICAgICAgICAodD04NDAwMyBq
aWZmaWVzIGc9NzU1NzM4NDEgcT0xMjI5ODggbmNwdXM9MTYpCjnmnIggMDcgMDY6MzY6MjMgbml4
b3Mga2VybmVsOiBDUFU6IDQgVUlEOiAwIFBJRDogMTg4MTc0MCBDb21tOiBrd29ya2VyL3U2NDow
IFRhaW50ZWQ6IEcgICAgICBEICAgICAgTCAgICAgIDcuMi4zICMxLU5peE9TIFBSRUVNUFQobGF6
eSkgCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiBUYWludGVkOiBbRF09RElFLCBbTF09
U09GVExPQ0tVUAo55pyIIDA3IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogSGFyZHdhcmUgbmFtZTog
TEVOT1ZPIDgzRDUvTE5WTkIxNjEyMTYsIEJJT1MgTlFDTjI3V1cgMDcvMTAvMjAyNAo55pyIIDA3
IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJl
ZF9wcm9iZV93b3JrX2Z1bmMKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6IFJJUDogMDAx
MDpxdWV1ZWRfd3JpdGVfbG9ja19zbG93cGF0aCsweDYyLzB4MTIwCjnmnIggMDcgMDY6MzY6MjMg
bml4b3Mga2VybmVsOiBDb2RlOiA4OSBlZiBjNiAwNyAwMCAwZiAxZiAwMCA2NiA5MCA1YiA1ZCBl
OSBkMiBlOCBmYiBmZSBmMCA4MSAwYiAwMCAwMSAwMCAwMCBiYSBmZiAwMCAwMCAwMCA4YiAwMyAz
ZCAwMCAwMSAwMCAwMCA3NCAwYiBmMyA5MCA4YiAwMyA8M2Q+IDAwIDAxIDAwIDAwIDc1IGY1IGI4
IDAwIDAxIDAwIDAwIGYwIDBmIGIxIDEzIDc0IGMzIGViIGRmIDY1IDhiCjnmnIggMDcgMDY6MzY6
MjMgbml4b3Mga2VybmVsOiBSU1A6IDAwMTg6ZmZmZmQwNjYyNTcyN2MwMCBFRkxBR1M6IDAwMDAw
MjA2CjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAxZmYg
UkJYOiBmZmZmZmZmZmMxOGQyZTQ4IFJDWDogMDAwMDAwMDAwMDAwMDAwMAo55pyIIDA3IDA2OjM2
OjIzIG5peG9zIGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMGZmIFJTSTogMDAwMDAwMDAwMDAw
MDI4NiBSREk6IGZmZmZmZmZmYzE4ZDJlNDgKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6
IFJCUDogZmZmZmZmZmZjMThkMmU0YyBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOGE2
ZmQ2ZWI0NmMwCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiBSMTA6IGZmZmY4YTZmYzAw
NGUyMDAgUjExOiAwMDAwNzU5MGMwMDAwMDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwMAo55pyIIDA3
IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogUjEzOiBmZmZmOGE2ZmQzMGNkNDAwIFIxNDogZmZmZjhh
NmZkMzBjZDUyOCBSMTU6IGZmZmY4YTczMDhlYWMwMDAKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBr
ZXJuZWw6IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGE3NjY4ZWJjMDAwKDAw
MDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6
IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKOeaciCAw
NyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6IENSMjogMDAwMDdiNGVhYWZmZDgyOCBDUjM6IDAwMDAw
MDA1ZTRhMjIwMDAgQ1I0OiAwMDAwMDAwMDAwZjUwZWYwCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mg
a2VybmVsOiBQS1JVOiA1NTU1NTU1NAo55pyIIDA3IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogQ2Fs
bCBUcmFjZToKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6ICA8VEFTSz4KOeaciCAwNyAw
NjozNjoyMyBuaXhvcyBrZXJuZWw6ICBoY2lfcmVnaXN0ZXJfZGV2KzB4MWZjLzB4NDQwIFtibHVl
dG9vdGhdCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiAgYnR1c2JfcHJvYmUrMHhhMTcv
MHgxMGI5IFtidHVzYl0KOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6ICA/IHNyc29fYWxp
YXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVs
OiAgPyBfX3BtX3J1bnRpbWVfc2V0X3N0YXR1cysweDE5MC8weDJmMAo55pyIIDA3IDA2OjM2OjIz
IG5peG9zIGtlcm5lbDogIHVzYl9wcm9iZV9pbnRlcmZhY2UrMHhlMC8weDJkMAo55pyIIDA3IDA2
OjM2OjIzIG5peG9zIGtlcm5lbDogIHJlYWxseV9wcm9iZSsweGRlLzB4MzgwCjnmnIggMDcgMDY6
MzY6MjMgbml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVm
NQo55pyIIDA3IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogID8gX19wZnhfX19kZXZpY2VfYXR0YWNo
X2RyaXZlcisweDEwLzB4MTAKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6ICBfX2RyaXZl
cl9wcm9iZV9kZXZpY2UrMHg4NS8weDE3MAo55pyIIDA3IDA2OjM2OjIzIG5peG9zIGtlcm5lbDog
IGRyaXZlcl9wcm9iZV9kZXZpY2UrMHgxZi8weDkwCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2Vy
bmVsOiAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweDg5LzB4MTMwCjnmnIggMDcgMDY6MzY6MjMg
bml4b3Mga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyI
IDA3IDA2OjM2OjIzIG5peG9zIGtlcm5lbDogIGJ1c19mb3JfZWFjaF9kcnYrMHg5Mi8weGUwCjnm
nIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiAgX19kZXZpY2VfYXR0YWNoKzB4YjAvMHgxYzAK
OeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5r
KzB4NS8weGZiZWY1CjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiAgZGV2aWNlX2luaXRp
YWxfcHJvYmUrMHg0YS8weDcwCjnmnIggMDcgMDY6MzY6MjMgbml4b3Mga2VybmVsOiAgYnVzX3By
b2JlX2RldmljZSsweDJkLzB4OTAKOeaciCAwNyAwNjozNjoyMyBuaXhvcyBrZXJuZWw6ICBkZWZl
cnJlZF9wcm9iZV93b3JrX2Z1bmMrMHg5Yi8weDEwMAo55pyIIDA3IDA2OjM2OjIzIG5peG9zIGtl
cm5lbDogIHByb2Nlc3Nfb25lX3dvcmsrMHgxOTkvMHgzNzAKOeaciCAwNyAwNjozNjoyMyBuaXhv
cyBrZXJuZWw6ICB3b3JrZXJfdGhyZWFkKzB4MTc3LzB4MmUwCjnmnIggMDcgMDY6MzY6MjMgbml4
b3Mga2VybmVsOiAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMAo55pyIIDA3IDA2OjM2
OjIzIG5peG9zIGtlcm5lbDogIGt0aHJlYWQrMHhlMi8weDExMAo55pyIIDA3IDA2OjM2OjIzIG5p
eG9zIGtlcm5lbDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAKOeaciCAwNyAwNjozNjoyMyBu
aXhvcyBrZXJuZWw6ICByZXRfZnJvbV9mb3JrKzB4MjUxLzB4MzMwCjnmnIggMDcgMDY6MzY6MjMg
bml4b3Mga2VybmVsOiAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMAo55pyIIDA3IDA2OjM2OjIz
IG5peG9zIGtlcm5lbDogIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMAo55pyIIDA3IDA2OjM2
OjIzIG5peG9zIGtlcm5lbDogIDwvVEFTSz4K

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/x-log; name="3-soft-lockup-hci-register-dev-spin.log"
Content-Description: 3-soft-lockup-hci-register-dev-spin.log
Content-Disposition: attachment;
	filename="3-soft-lockup-hci-register-dev-spin.log"; size=13808;
	creation-date="Mon, 07 Sep 2026 02:09:01 GMT";
	modification-date="Mon, 07 Sep 2026 02:10:51 GMT"
Content-Transfer-Encoding: base64

OeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6IHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3Vw
IC0gQ1BVIzQgc3R1Y2sgZm9yIDc0MTBzISBba3dvcmtlci91NjQ6MDoxODgxNzQwXQo55pyIIDA3
IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogTW9kdWxlcyBsaW5rZWQgaW46IG1wdGNwX2RpYWcgcmF3
X2RpYWcgdW5peF9kaWFnIGFmX3BhY2tldF9kaWFnIG5ldGxpbmtfZGlhZyB1ZHBfZGlhZyB0Y3Bf
ZGlhZyBpbmV0X2RpYWcgc2RfbW9kIHNjc2lfbW9kIHNjc2lfY29tbW9uIGNjbSBxcnRyIHh0X2Nv
bm50cmFjayB4dF9NQVNRVUVSQURFIHhmcm1fdXNlciB4ZnJtX2FsZ28geHRfc2V0IGlwX3NldCB4
dF9hZGRydHlwZSBuZnRfY29tcGF0IG5mdF9tYXNxIG5mdF9yZWplY3RfaXB2NCBuZl9yZWplY3Rf
aXB2NCBuZnRfcmVqZWN0IGFjdF9jc3VtIGNsc191MzIgc2NoX2h0YiBuZnRfY2hhaW5fbmF0IHJm
Y29tbSBzbmRfc2VxX2R1bW15IHNuZF9ocnRpbWVyIHNuZF9zZXEgc25kX3NlcV9kZXZpY2UgYWZf
cGFja2V0IGFlcyBhbGdpZl9oYXNoIGFsZ2lmX3NrY2lwaGVyIGFmX2FsZyBibmVwIG5mdF9jdCBu
ZnRfZmliX2luZXQgbmZ0X2ZpYl9pcHY0IG5mdF9maWJfaXB2NiBuZnRfZmliIG5mX3RhYmxlcyBh
bWRncHUgbmxzX2lzbzg4NTlfMSBubHNfY3A0MzcgdmZhdCBmYXQgYW1keGRuYSBhbWRfcG1mIGFt
ZHRlZSBhbWR4Y3AgYW1kX3NmaCBkcm1fcGFuZWxfYmFja2xpZ2h0X3F1aXJrcyBzbmRfc29jX2Rt
aWMgc25kX3BzX3BkbV9kbWEgc25kX3NvY19wc19tYWNoIHNuZF9zb2ZfYW1kX2FjcDcwIHNuZF9z
b2ZfYW1kX2FjcDYzIHNuZF9zb2ZfYW1kX3ZhbmdvZ2ggc25kX3NvZl9hbWRfcmVtYnJhbmR0IHJ0
dzg5Xzg4NTJiZSBzbmRfc29mX2FtZF9yZW5vaXIgc25kX3NvZl9hbWRfYWNwIHJ0dzg5Xzg4NTJi
IHNuZF9zb2ZfcGNpIHNuZF9zb2ZfeHRlbnNhX2RzcCBydHc4OV84ODUyYl9jb21tb24gc25kX3Nv
ZiBydHc4OV9wY2kgc25kX3NvZl91dGlscyBzbmRfcGNpX2FjcDd4IHNuZF9wY2lfcHMgc25kX3Nv
Y19hY3BpX2FtZF9tYXRjaCBydHc4OV9jb3JlIHNuZF9hbWRfc2R3X2FjcGkgc291bmR3aXJlX2Ft
ZCBzbmRfY3RsX2xlZCBzb3VuZHdpcmVfZ2VuZXJpY19hbGxvY2F0aW9uIHNvdW5kd2lyZV9idXMK
OeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICBzbmRfaGRhX2NvZGVjX2FsYzI2OSBzbmRf
c29jX3NkY2Egc25kX2hkYV9jb2RlY19yZWFsdGVrX2xpYiBzbmRfaGRhX3Njb2RlY19jb21wb25l
bnQgaGlkX3NlbnNvcl9jdXN0b20gc25kX2hkYV9jb2RlY19nZW5lcmljIHNuZF9zb2NfY29yZSBz
bmRfaGRhX2NvZGVjX2F0aWhkbWkgbWFjODAyMTEgc25kX2hkYV9jb2RlY19oZG1pIGhpZF9tdWx0
aXRvdWNoIHNwZDUxMTggaGlkX3NlbnNvcl9odWIgc25kX2NvbXByZXNzIGRybV9idWRkeSBkcm1f
ZXhlYyBhYzk3X2J1cyBkcm1fc3ViYWxsb2NfaGVscGVyIGJ0dXNiIHNuZF9wY21fZG1hZW5naW5l
IGRybV90dG1faGVscGVyIGJ0cnRsIHNuZF9oZGFfaW50ZWwgc3A1MTAwX3RjbyBidGludGVsIHV2
Y3ZpZGVvIHR0bSBzbmRfYWNwX3BjaSBidG10ayBzbmRfYW1kX2FjcGlfbWFjaCBidGJjbSB3YXRj
aGRvZyBzbmRfaGRhX2NvZGVjIHNuZF9hY3BfbGVnYWN5X2NvbW1vbiBlZGFjX21jZV9hbWQgZHJt
X2Rpc3BsYXlfaGVscGVyIHZpZGVvYnVmMl92bWFsbG9jIGxlbm92b193bWlfb3RoZXIgY2ZnODAy
MTEgZWRhY19jb3JlIHV2YyBibHVldG9vdGggc25kX2hkYV9jb3JlIHZpZGVvYnVmMl9tZW1vcHMg
dWNzaV9hY3BpIHRoaW5rX2xtaSBsZW5vdm9fd21pX2NhcGRhdGEgY2VjIHZpZGVvYnVmMl92NGwy
IHNuZF9pbnRlbF9kc3BjZmcgc25kX3BjaV9hY3A2eCBsZW5vdm9fd21pX2dhbWV6b25lIGdwdV9z
Y2hlZCB2aWRlb2J1ZjJfY29tbW9uIGkyY19hbGdvX2JpdCBpMmNfcGlpeDQgdHlwZWNfdWNzaSBh
bWRfYXRsIHNuZF9wY2lfYWNwNXggaWRlYXBhZF9sYXB0b3Agc25kX2ludGVsX3Nkd19hY3BpIGxl
bm92b193bWlfaGVscGVycyBsZW5vdm9fd21pX2hvdGtleV91dGlsaXRpZXMgZmlybXdhcmVfYXR0
cmlidXRlc19jbGFzcyBsZW5vdm9fd21pX2V2ZW50cyB3bWlfYm1vZiB2aWRlb2RldiBpbnRlbF9y
YXBsX21zciBpbnRlbF9yYXBsX2NvbW1vbiBlY2RoX2dlbmVyaWMgc3BhcnNlX2tleW1hcCBzbmRf
aHdkZXAgYWVzbmlfaW50ZWwgZ2YxMjhtdWwKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6
ICByYXBsIG1jIHJvbGVzIGVjYyBldmRldiBrMTB0ZW1wIGpveWRldiBtb3VzZWRldiBpMmNfc21i
dXMgYmF0dGVyeSB0ZWUgdHlwZWMgcnRjX2Ntb3Mgc25kX3BjbSBzbmRfcm5fcGNpX2FjcDN4IHZp
ZGVvIGkyY19oaWRfYWNwaSBzbmRfYWNwX2NvbmZpZyBzbmRfdGltZXIgaTJjX2hpZCB0aW55X3Bv
d2VyX2J1dHRvbiBzbmRfc29jX2FjcGkgcmZraWxsIGlucHV0X2xlZHMgc25kIGxpYmFyYzQgYnV0
dG9uIGxlZF9jbGFzcyBhZWFkIGNyYzE2IHNuZF9wY2lfYWNwM3ggc291bmRjb3JlIGFtZF9wbWMg
YWMgdGhlcm1hbCB3bWkgbWFjX2hpZCBzZXJpb19yYXcgc2NoX2ZxX2NvZGVsIGt2bV9hbWQgY2Nw
IGt2bSB4dF9uYXQgYnJfbmV0ZmlsdGVyIHhfdGFibGVzIG5mX25hdCBicmlkZ2UgbmZfY29ubnRy
YWNrIG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0IHR1biBzdHAgaXJxYnlwYXNzIGxvb3Ag
dmV0aCB1aW5wdXQgbGxjIGN0ciBmdXNlIGRtaV9zeXNmcyBoaWRfZ2VuZXJpYyB1c2JoaWQgaGlk
IHJ0c3hfcGNpX3NkbW1jIG52bWUgYXRrYmQgbW1jX2NvcmUgbGlicHMyIHZpdmFsZGlfZm1hcCBu
dm1lX2NvcmUgaTgwNDIgeGhjaV9wY2kgbnZtZV9rZXlyaW5nIHRodW5kZXJib2x0IHNlcmlvIHho
Y2lfaGNkIHJ0c3hfcGNpIG52bWVfYXV0aCBidHJmcyBsaWJibGFrZTJiIGRtX3NuYXBzaG90IGRt
X2J1ZmlvIGRtX21vZCByYWlkNl9wcSB4b3IgY29uZmlnZnMgZWZpdmFyZnMgYXV0b2ZzNAo55pyI
IDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogQ1BVOiA0IFVJRDogMCBQSUQ6IDE4ODE3NDAgQ29t
bToga3dvcmtlci91NjQ6MCBUYWludGVkOiBHICAgICAgRCAgICAgIEwgICAgICA3LjIuMyAjMS1O
aXhPUyBQUkVFTVBUKGxhenkpIAo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogVGFpbnRl
ZDogW0RdPURJRSwgW0xdPVNPRlRMT0NLVVAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6
IEhhcmR3YXJlIG5hbWU6IExFTk9WTyA4M0Q1L0xOVk5CMTYxMjE2LCBCSU9TIE5RQ04yN1dXIDA3
LzEwLzIwMjQKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6IFdvcmtxdWV1ZTogZXZlbnRz
X3VuYm91bmQgZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jCjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mg
a2VybmVsOiBSSVA6IDAwMTA6cXVldWVkX3dyaXRlX2xvY2tfc2xvd3BhdGgrMHg2Mi8weDEyMAo5
5pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogQ29kZTogODkgZWYgYzYgMDcgMDAgMGYgMWYg
MDAgNjYgOTAgNWIgNWQgZTkgZDIgZTggZmIgZmUgZjAgODEgMGIgMDAgMDEgMDAgMDAgYmEgZmYg
MDAgMDAgMDAgOGIgMDMgM2QgMDAgMDEgMDAgMDAgNzQgMGIgZjMgOTAgOGIgMDMgPDNkPiAwMCAw
MSAwMCAwMCA3NSBmNSBiOCAwMCAwMSAwMCAwMCBmMCAwZiBiMSAxMyA3NCBjMyBlYiBkZiA2NSA4
Ygo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogUlNQOiAwMDE4OmZmZmZkMDY2MjU3Mjdj
MDAgRUZMQUdTOiAwMDAwMDIwNgo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogUkFYOiAw
MDAwMDAwMDAwMDAwMWZmIFJCWDogZmZmZmZmZmZjMThkMmU0OCBSQ1g6IDAwMDAwMDAwMDAwMDAw
MDAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDBmZiBS
U0k6IDAwMDAwMDAwMDAwMDAyODYgUkRJOiBmZmZmZmZmZmMxOGQyZTQ4CjnmnIggMDcgMDg6NDc6
Mjkgbml4b3Mga2VybmVsOiBSQlA6IGZmZmZmZmZmYzE4ZDJlNGMgUjA4OiAwMDAwMDAwMDAwMDAw
MDAwIFIwOTogZmZmZjhhNmZkNmViNDZjMAo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDog
UjEwOiBmZmZmOGE2ZmMwMDRlMjAwIFIxMTogMDAwMDc1OTBjMDAwMDAwMCBSMTI6IDAwMDAwMDAw
MDAwMDAwMDAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6IFIxMzogZmZmZjhhNmZkMzBj
ZDQwMCBSMTQ6IGZmZmY4YTZmZDMwY2Q1MjggUjE1OiBmZmZmOGE3MzA4ZWFjMDAwCjnmnIggMDcg
MDg6NDc6Mjkgbml4b3Mga2VybmVsOiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZm
ZjhhNzY2OGViYzAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDg6NDc6
Mjkgbml4b3Mga2VybmVsOiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAw
MDgwMDUwMDMzCjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiBDUjI6IDAwMDA3YjRlYWFm
ZmQ4MjggQ1IzOiAwMDAwMDAwNWU0YTIyMDAwIENSNDogMDAwMDAwMDAwMGY1MGVmMAo55pyIIDA3
IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogUEtSVTogNTU1NTU1NTQKOeaciCAwNyAwODo0NzoyOSBu
aXhvcyBrZXJuZWw6IENhbGwgVHJhY2U6CjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiAg
PFRBU0s+CjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiAgaGNpX3JlZ2lzdGVyX2Rldisw
eDFmYy8weDQ0MCBbYmx1ZXRvb3RoXQo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogIGJ0
dXNiX3Byb2JlKzB4YTE3LzB4MTBiOSBbYnR1c2JdCjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mga2Vy
bmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA4OjQ3
OjI5IG5peG9zIGtlcm5lbDogID8gX19wbV9ydW50aW1lX3NldF9zdGF0dXMrMHgxOTAvMHgyZjAK
OeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICB1c2JfcHJvYmVfaW50ZXJmYWNlKzB4ZTAv
MHgyZDAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICByZWFsbHlfcHJvYmUrMHhkZS8w
eDM4MAo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5f
dGh1bmsrMHg1LzB4ZmJlZjUKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICA/IF9fcGZ4
X19fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHgxMC8weDEwCjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mg
a2VybmVsOiAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4ODUvMHgxNzAKOeaciCAwNyAwODo0Nzoy
OSBuaXhvcyBrZXJuZWw6ICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MWYvMHg5MAo55pyIIDA3IDA4
OjQ3OjI5IG5peG9zIGtlcm5lbDogIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHg4OS8weDEzMAo5
5pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsr
MHg1LzB4ZmJlZjUKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICBidXNfZm9yX2VhY2hf
ZHJ2KzB4OTIvMHhlMAo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogIF9fZGV2aWNlX2F0
dGFjaCsweGIwLzB4MWMwCjnmnIggMDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiAgPyBzcnNvX2Fs
aWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQo55pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5l
bDogIGRldmljZV9pbml0aWFsX3Byb2JlKzB4NGEvMHg3MAo55pyIIDA3IDA4OjQ3OjI5IG5peG9z
IGtlcm5lbDogIGJ1c19wcm9iZV9kZXZpY2UrMHgyZC8weDkwCjnmnIggMDcgMDg6NDc6Mjkgbml4
b3Mga2VybmVsOiAgZGVmZXJyZWRfcHJvYmVfd29ya19mdW5jKzB4OWIvMHgxMDAKOeaciCAwNyAw
ODo0NzoyOSBuaXhvcyBrZXJuZWw6ICBwcm9jZXNzX29uZV93b3JrKzB4MTk5LzB4MzcwCjnmnIgg
MDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiAgd29ya2VyX3RocmVhZCsweDE3Ny8weDJlMAo55pyI
IDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogID8gX19wZnhfd29ya2VyX3RocmVhZCsweDEwLzB4
MTAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICBrdGhyZWFkKzB4ZTIvMHgxMTAKOeac
iCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwCjnm
nIggMDcgMDg6NDc6Mjkgbml4b3Mga2VybmVsOiAgcmV0X2Zyb21fZm9yaysweDI1MS8weDMzMAo5
5pyIIDA3IDA4OjQ3OjI5IG5peG9zIGtlcm5lbDogID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTAK
OeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4
MzAKOeaciCAwNyAwODo0NzoyOSBuaXhvcyBrZXJuZWw6ICA8L1RBU0s+CjnmnIggMDcgMDg6NDc6
Mzggbml4b3Mga2VybmVsOiByY3U6IElORk86IHJjdV9wcmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3Rh
bGwgb24gQ1BVCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiByY3U6ICAgICAgICAgNC0u
Li4uOiAoNzk1OTA1MSB0aWNrcyB0aGlzIEdQKSBpZGxlPTA4Y2MvMS8weDQwMDAwMDAwMDAwMDAw
MDAgc29mdGlycT0yMDE0MjExNi8yMDE0MjExNyBmcXM9MzQ4NjYwMgo55pyIIDA3IDA4OjQ3OjM4
IG5peG9zIGtlcm5lbDogcmN1OiAgICAgICAgICh0PTc5NTk0MTkgamlmZmllcyBnPTc1NTczODQx
IHE9NzY4MjE4OCBuY3B1cz0xNikKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6IENQVTog
NCBVSUQ6IDAgUElEOiAxODgxNzQwIENvbW06IGt3b3JrZXIvdTY0OjAgVGFpbnRlZDogRyAgICAg
IEQgICAgICBMICAgICAgNy4yLjMgIzEtTml4T1MgUFJFRU1QVChsYXp5KSAKOeaciCAwNyAwODo0
NzozOCBuaXhvcyBrZXJuZWw6IFRhaW50ZWQ6IFtEXT1ESUUsIFtMXT1TT0ZUTE9DS1VQCjnmnIgg
MDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiBIYXJkd2FyZSBuYW1lOiBMRU5PVk8gODNENS9MTlZO
QjE2MTIxNiwgQklPUyBOUUNOMjdXVyAwNy8xMC8yMDI0CjnmnIggMDcgMDg6NDc6Mzggbml4b3Mg
a2VybmVsOiBXb3JrcXVldWU6IGV2ZW50c191bmJvdW5kIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVu
Ywo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogUklQOiAwMDEwOnF1ZXVlZF93cml0ZV9s
b2NrX3Nsb3dwYXRoKzB4NjIvMHgxMjAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6IENv
ZGU6IDg5IGVmIGM2IDA3IDAwIDBmIDFmIDAwIDY2IDkwIDViIDVkIGU5IGQyIGU4IGZiIGZlIGYw
IDgxIDBiIDAwIDAxIDAwIDAwIGJhIGZmIDAwIDAwIDAwIDhiIDAzIDNkIDAwIDAxIDAwIDAwIDc0
IDBiIGYzIDkwIDhiIDAzIDwzZD4gMDAgMDEgMDAgMDAgNzUgZjUgYjggMDAgMDEgMDAgMDAgZjAg
MGYgYjEgMTMgNzQgYzMgZWIgZGYgNjUgOGIKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6
IFJTUDogMDAxODpmZmZmZDA2NjI1NzI3YzAwIEVGTEFHUzogMDAwMDAyMDYKOeaciCAwNyAwODo0
NzozOCBuaXhvcyBrZXJuZWw6IFJBWDogMDAwMDAwMDAwMDAwMDFmZiBSQlg6IGZmZmZmZmZmYzE4
ZDJlNDggUkNYOiAwMDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVs
OiBSRFg6IDAwMDAwMDAwMDAwMDAwZmYgUlNJOiAwMDAwMDAwMDAwMDAwMjg2IFJESTogZmZmZmZm
ZmZjMThkMmU0OAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogUkJQOiBmZmZmZmZmZmMx
OGQyZTRjIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmZmY4YTZmZDZlYjQ2YzAKOeaciCAw
NyAwODo0NzozOCBuaXhvcyBrZXJuZWw6IFIxMDogZmZmZjhhNmZjMDA0ZTIwMCBSMTE6IDAwMDA3
NTkwYzAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mg
a2VybmVsOiBSMTM6IGZmZmY4YTZmZDMwY2Q0MDAgUjE0OiBmZmZmOGE2ZmQzMGNkNTI4IFIxNTog
ZmZmZjhhNzMwOGVhYzAwMAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogRlM6ICAwMDAw
MDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4YTc2NjhlYmMwMDAoMDAwMCkga25sR1M6MDAwMDAw
MDAwMDAwMDAwMAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo55pyIIDA3IDA4OjQ3OjM4IG5peG9z
IGtlcm5lbDogQ1IyOiAwMDAwN2I0ZWFhZmZkODI4IENSMzogMDAwMDAwMDVlNGEyMjAwMCBDUjQ6
IDAwMDAwMDAwMDBmNTBlZjAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6IFBLUlU6IDU1
NTU1NTU0CjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiBDYWxsIFRyYWNlOgo55pyIIDA3
IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogIDxUQVNLPgo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtl
cm5lbDogIGhjaV9yZWdpc3Rlcl9kZXYrMHgxZmMvMHg0NDAgW2JsdWV0b290aF0KOeaciCAwNyAw
ODo0NzozOCBuaXhvcyBrZXJuZWw6ICBidHVzYl9wcm9iZSsweGExNy8weDEwYjkgW2J0dXNiXQo5
5pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsr
MHg1LzB4ZmJlZjUKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICA/IF9fcG1fcnVudGlt
ZV9zZXRfc3RhdHVzKzB4MTkwLzB4MmYwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiAg
dXNiX3Byb2JlX2ludGVyZmFjZSsweGUwLzB4MmQwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2Vy
bmVsOiAgcmVhbGx5X3Byb2JlKzB4ZGUvMHgzODAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJu
ZWw6ICA/IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIggMDcgMDg6NDc6
Mzggbml4b3Mga2VybmVsOiAgPyBfX3BmeF9fX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4MTAvMHgx
MAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogIF9fZHJpdmVyX3Byb2JlX2RldmljZSsw
eDg1LzB4MTcwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiAgZHJpdmVyX3Byb2JlX2Rl
dmljZSsweDFmLzB4OTAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICBfX2RldmljZV9h
dHRhY2hfZHJpdmVyKzB4ODkvMHgxMzAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICA/
IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1CjnmnIggMDcgMDg6NDc6Mzggbml4
b3Mga2VybmVsOiAgYnVzX2Zvcl9lYWNoX2RydisweDkyLzB4ZTAKOeaciCAwNyAwODo0NzozOCBu
aXhvcyBrZXJuZWw6ICBfX2RldmljZV9hdHRhY2grMHhiMC8weDFjMAo55pyIIDA3IDA4OjQ3OjM4
IG5peG9zIGtlcm5lbDogID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKOeac
iCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICBkZXZpY2VfaW5pdGlhbF9wcm9iZSsweDRhLzB4
NzAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICBidXNfcHJvYmVfZGV2aWNlKzB4MmQv
MHg5MAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogIGRlZmVycmVkX3Byb2JlX3dvcmtf
ZnVuYysweDliLzB4MTAwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiAgcHJvY2Vzc19v
bmVfd29yaysweDE5OS8weDM3MAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogIHdvcmtl
cl90aHJlYWQrMHgxNzcvMHgyZTAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICA/IF9f
cGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVs
OiAga3RocmVhZCsweGUyLzB4MTEwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiAgPyBf
X3BmeF9rdGhyZWFkKzB4MTAvMHgxMAo55pyIIDA3IDA4OjQ3OjM4IG5peG9zIGtlcm5lbDogIHJl
dF9mcm9tX2ZvcmsrMHgyNTEvMHgzMzAKOeaciCAwNyAwODo0NzozOCBuaXhvcyBrZXJuZWw6ICA/
IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVsOiAg
cmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwCjnmnIggMDcgMDg6NDc6Mzggbml4b3Mga2VybmVs
OiAgPC9UQVNLPgo55pyIIDA3IDA4OjQ4OjA1IG5peG9zIGtlcm5lbDogd2F0Y2hkb2c6IEJVRzog
c29mdCBsb2NrdXAgLSBDUFUjNCBzdHVjayBmb3IgNzQ0M3MhIFtrd29ya2VyL3U2NDowOjE4ODE3
NDBdCjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2VybmVsOiBNb2R1bGVzIGxpbmtlZCBpbjogbXB0
Y3BfZGlhZyByYXdfZGlhZyB1bml4X2RpYWcgYWZfcGFja2V0X2RpYWcgbmV0bGlua19kaWFnIHVk
cF9kaWFnIHRjcF9kaWFnIGluZXRfZGlhZyBzZF9tb2Qgc2NzaV9tb2Qgc2NzaV9jb21tb24gY2Nt
IHFydHIgeHRfY29ubnRyYWNrIHh0X01BU1FVRVJBREUgeGZybV91c2VyIHhmcm1fYWxnbyB4dF9z
ZXQgaXBfc2V0IHh0X2FkZHJ0eXBlIG5mdF9jb21wYXQgbmZ0X21hc3EgbmZ0X3JlamVjdF9pcHY0
IG5mX3JlamVjdF9pcHY0IG5mdF9yZWplY3QgYWN0X2NzdW0gY2xzX3UzMiBzY2hfaHRiIG5mdF9j
aGFpbl9uYXQgcmZjb21tIHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgc25kX3NlcSBzbmRfc2Vx
X2RldmljZSBhZl9wYWNrZXQgYWVzIGFsZ2lmX2hhc2ggYWxnaWZfc2tjaXBoZXIgYWZfYWxnIGJu
ZXAgbmZ0X2N0IG5mdF9maWJfaW5ldCBuZnRfZmliX2lwdjQgbmZ0X2ZpYl9pcHY2IG5mdF9maWIg
bmZfdGFibGVzIGFtZGdwdSBubHNfaXNvODg1OV8xIG5sc19jcDQzNyB2ZmF0IGZhdCBhbWR4ZG5h
IGFtZF9wbWYgYW1kdGVlIGFtZHhjcCBhbWRfc2ZoIGRybV9wYW5lbF9iYWNrbGlnaHRfcXVpcmtz
IHNuZF9zb2NfZG1pYyBzbmRfcHNfcGRtX2RtYSBzbmRfc29jX3BzX21hY2ggc25kX3NvZl9hbWRf
YWNwNzAgc25kX3NvZl9hbWRfYWNwNjMgc25kX3NvZl9hbWRfdmFuZ29naCBzbmRfc29mX2FtZF9y
ZW1icmFuZHQgcnR3ODlfODg1MmJlIHNuZF9zb2ZfYW1kX3Jlbm9pciBzbmRfc29mX2FtZF9hY3Ag
cnR3ODlfODg1MmIgc25kX3NvZl9wY2kgc25kX3NvZl94dGVuc2FfZHNwIHJ0dzg5Xzg4NTJiX2Nv
bW1vbiBzbmRfc29mIHJ0dzg5X3BjaSBzbmRfc29mX3V0aWxzIHNuZF9wY2lfYWNwN3ggc25kX3Bj
aV9wcyBzbmRfc29jX2FjcGlfYW1kX21hdGNoIHJ0dzg5X2NvcmUgc25kX2FtZF9zZHdfYWNwaSBz
b3VuZHdpcmVfYW1kIHNuZF9jdGxfbGVkIHNvdW5kd2lyZV9nZW5lcmljX2FsbG9jYXRpb24gc291
bmR3aXJlX2J1cwo55pyIIDA3IDA4OjQ4OjA1IG5peG9zIGtlcm5lbDogIHNuZF9oZGFfY29kZWNf
YWxjMjY5IHNuZF9zb2Nfc2RjYSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWtfbGliIHNuZF9oZGFfc2Nv
ZGVjX2NvbXBvbmVudCBoaWRfc2Vuc29yX2N1c3RvbSBzbmRfaGRhX2NvZGVjX2dlbmVyaWMgc25k
X3NvY19jb3JlIHNuZF9oZGFfY29kZWNfYXRpaGRtaSBtYWM4MDIxMSBzbmRfaGRhX2NvZGVjX2hk
bWkgaGlkX211bHRpdG91Y2ggc3BkNTExOCBoaWRfc2Vuc29yX2h1YiBzbmRfY29tcHJlc3MgZHJt
X2J1ZGR5IGRybV9leGVjIGFjOTdfYnVzIGRybV9zdWJhbGxvY19oZWxwZXIgYnR1c2Igc25kX3Bj
bV9kbWFlbmdpbmUgZHJtX3R0bV9oZWxwZXIgYnRydGwgc25kX2hkYV9pbnRlbCBzcDUxMDBfdGNv
IGJ0aW50ZWwgdXZjdmlkZW8gdHRtIHNuZF9hY3BfcGNpIGJ0bXRrIHNuZF9hbWRfYWNwaV9tYWNo
IGJ0YmNtIHdhdGNoZG9nIHNuZF9oZGFfY29kZWMgc25kX2FjcF9sZWdhY3lfY29tbW9uIGVkYWNf
bWNlX2FtZCBkcm1fZGlzcGxheV9oZWxwZXIgdmlkZW9idWYyX3ZtYWxsb2MgbGVub3ZvX3dtaV9v
dGhlciBjZmc4MDIxMSBlZGFjX2NvcmUgdXZjIGJsdWV0b290aCBzbmRfaGRhX2NvcmUgdmlkZW9i
dWYyX21lbW9wcyB1Y3NpX2FjcGkgdGhpbmtfbG1pIGxlbm92b193bWlfY2FwZGF0YSBjZWMgdmlk
ZW9idWYyX3Y0bDIgc25kX2ludGVsX2RzcGNmZyBzbmRfcGNpX2FjcDZ4IGxlbm92b193bWlfZ2Ft
ZXpvbmUgZ3B1X3NjaGVkIHZpZGVvYnVmMl9jb21tb24gaTJjX2FsZ29fYml0IGkyY19waWl4NCB0
eXBlY191Y3NpIGFtZF9hdGwgc25kX3BjaV9hY3A1eCBpZGVhcGFkX2xhcHRvcCBzbmRfaW50ZWxf
c2R3X2FjcGkgbGVub3ZvX3dtaV9oZWxwZXJzIGxlbm92b193bWlfaG90a2V5X3V0aWxpdGllcyBm
aXJtd2FyZV9hdHRyaWJ1dGVzX2NsYXNzIGxlbm92b193bWlfZXZlbnRzIHdtaV9ibW9mIHZpZGVv
ZGV2IGludGVsX3JhcGxfbXNyIGludGVsX3JhcGxfY29tbW9uIGVjZGhfZ2VuZXJpYyBzcGFyc2Vf
a2V5bWFwIHNuZF9od2RlcCBhZXNuaV9pbnRlbCBnZjEyOG11bAo55pyIIDA3IDA4OjQ4OjA1IG5p
eG9zIGtlcm5lbDogIHJhcGwgbWMgcm9sZXMgZWNjIGV2ZGV2IGsxMHRlbXAgam95ZGV2IG1vdXNl
ZGV2IGkyY19zbWJ1cyBiYXR0ZXJ5IHRlZSB0eXBlYyBydGNfY21vcyBzbmRfcGNtIHNuZF9ybl9w
Y2lfYWNwM3ggdmlkZW8gaTJjX2hpZF9hY3BpIHNuZF9hY3BfY29uZmlnIHNuZF90aW1lciBpMmNf
aGlkIHRpbnlfcG93ZXJfYnV0dG9uIHNuZF9zb2NfYWNwaSByZmtpbGwgaW5wdXRfbGVkcyBzbmQg
bGliYXJjNCBidXR0b24gbGVkX2NsYXNzIGFlYWQgY3JjMTYgc25kX3BjaV9hY3AzeCBzb3VuZGNv
cmUgYW1kX3BtYyBhYyB0aGVybWFsIHdtaSBtYWNfaGlkIHNlcmlvX3JhdyBzY2hfZnFfY29kZWwg
a3ZtX2FtZCBjY3Aga3ZtIHh0X25hdCBicl9uZXRmaWx0ZXIgeF90YWJsZXMgbmZfbmF0IGJyaWRn
ZSBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgdHVuIHN0cCBpcnFi
eXBhc3MgbG9vcCB2ZXRoIHVpbnB1dCBsbGMgY3RyIGZ1c2UgZG1pX3N5c2ZzIGhpZF9nZW5lcmlj
IHVzYmhpZCBoaWQgcnRzeF9wY2lfc2RtbWMgbnZtZSBhdGtiZCBtbWNfY29yZSBsaWJwczIgdml2
YWxkaV9mbWFwIG52bWVfY29yZSBpODA0MiB4aGNpX3BjaSBudm1lX2tleXJpbmcgdGh1bmRlcmJv
bHQgc2VyaW8geGhjaV9oY2QgcnRzeF9wY2kgbnZtZV9hdXRoIGJ0cmZzIGxpYmJsYWtlMmIgZG1f
c25hcHNob3QgZG1fYnVmaW8gZG1fbW9kIHJhaWQ2X3BxIHhvciBjb25maWdmcyBlZml2YXJmcyBh
dXRvZnM0CjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2VybmVsOiBDUFU6IDQgVUlEOiAwIFBJRDog
MTg4MTc0MCBDb21tOiBrd29ya2VyL3U2NDowIFRhaW50ZWQ6IEcgICAgICBEICAgICAgTCAgICAg
IDcuMi4zICMxLU5peE9TIFBSRUVNUFQobGF6eSkgCjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2Vy
bmVsOiBUYWludGVkOiBbRF09RElFLCBbTF09U09GVExPQ0tVUAo55pyIIDA3IDA4OjQ4OjA1IG5p
eG9zIGtlcm5lbDogSGFyZHdhcmUgbmFtZTogTEVOT1ZPIDgzRDUvTE5WTkIxNjEyMTYsIEJJT1Mg
TlFDTjI3V1cgMDcvMTAvMjAyNAo55pyIIDA3IDA4OjQ4OjA1IG5peG9zIGtlcm5lbDogV29ya3F1
ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMKOeaciCAwNyAwODo0
ODowNSBuaXhvcyBrZXJuZWw6IFJJUDogMDAxMDpxdWV1ZWRfd3JpdGVfbG9ja19zbG93cGF0aCsw
eDYyLzB4MTIwCjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2VybmVsOiBDb2RlOiA4OSBlZiBjNiAw
NyAwMCAwZiAxZiAwMCA2NiA5MCA1YiA1ZCBlOSBkMiBlOCBmYiBmZSBmMCA4MSAwYiAwMCAwMSAw
MCAwMCBiYSBmZiAwMCAwMCAwMCA4YiAwMyAzZCAwMCAwMSAwMCAwMCA3NCAwYiBmMyA5MCA4YiAw
MyA8M2Q+IDAwIDAxIDAwIDAwIDc1IGY1IGI4IDAwIDAxIDAwIDAwIGYwIDBmIGIxIDEzIDc0IGMz
IGViIGRmIDY1IDhiCjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2VybmVsOiBSU1A6IDAwMTg6ZmZm
ZmQwNjYyNTcyN2MwMCBFRkxBR1M6IDAwMDAwMjA2CjnmnIggMDcgMDg6NDg6MDUgbml4b3Mga2Vy
bmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAxZmYgUkJYOiBmZmZmZmZmZmMxOGQyZTQ4IFJDWDogMDAw
MDAwMDAwMDAwMDAwMAo=

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/x-log; name="4-hibernate-then-failing-suspends.log"
Content-Description: 4-hibernate-then-failing-suspends.log
Content-Disposition: attachment;
	filename="4-hibernate-then-failing-suspends.log"; size=19607;
	creation-date="Mon, 07 Sep 2026 02:09:02 GMT";
	modification-date="Mon, 07 Sep 2026 02:10:51 GMT"
Content-Transfer-Encoding: base64

OeaciCAwNSAwMTowNTo1MSBuaXhvcyBrZXJuZWw6IHVzYiA3LTE6IFVTQiBkaXNjb25uZWN0LCBk
ZXZpY2UgbnVtYmVyIDMKOeaciCAwNSAwMTowNTo1OCBuaXhvcyBrZXJuZWw6IHdscDRzMDogZGVh
dXRoZW50aWNhdGluZyBmcm9tIDJjOjcwOjRmOjNmOjc3OjQyIGJ5IGxvY2FsIGNob2ljZSAoUmVh
c29uOiAzPURFQVVUSF9MRUFWSU5HKQo55pyIIDA1IDAxOjA1OjU5IG5peG9zIGtlcm5lbDogUE06
IEltYWdlIG5vdCBmb3VuZCAoY29kZSAtMTYpCjnmnIggMDUgMDE6MDU6NTkgbml4b3Mga2VybmVs
OiBQTTogaGliZXJuYXRpb246IGhpYmVybmF0aW9uIGVudHJ5CjnmnIggMDUgMDE6MDU6NTkgbml4
b3Mga2VybmVsOiBGaWxlc3lzdGVtcyBzeW5jOiAwLjA0MiBzZWNvbmRzCjnmnIggMDUgMDE6MDc6
MTQgbml4b3Mga2VybmVsOiBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcwo55pyIIDA1IDAx
OjA3OjE0IG5peG9zIGtlcm5lbDogRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxl
dGVkIChlbGFwc2VkIDAuMDAyIHNlY29uZHMpCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVs
OiBPT00ga2lsbGVyIGRpc2FibGVkLgo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogUE06
IGhpYmVybmF0aW9uOiBNYXJraW5nIG5vc2F2ZSBwYWdlczogW21lbSAweDAwMDAwMDAwLTB4MDAw
MDBmZmZdCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBQTTogaGliZXJuYXRpb246IE1h
cmtpbmcgbm9zYXZlIHBhZ2VzOiBbbWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0KOeaciCAwNSAw
MTowNzoxNCBuaXhvcyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogTWFya2luZyBub3NhdmUgcGFn
ZXM6IFttZW0gMHgwOWMwMDAwMC0weDA5ZGUwZmZmXQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtl
cm5lbDogUE06IGhpYmVybmF0aW9uOiBNYXJraW5nIG5vc2F2ZSBwYWdlczogW21lbSAweDA5ZjAw
MDAwLTB4MDlmM2JmZmZdCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBQTTogaGliZXJu
YXRpb246IE1hcmtpbmcgbm9zYXZlIHBhZ2VzOiBbbWVtIDB4MmU4N2QwMDAtMHgzNWFmZGZmZl0K
OeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogTWFya2luZyBu
b3NhdmUgcGFnZXM6IFttZW0gMHg3MjA5MTAwMC0weDcyMjcxZmZmXQo55pyIIDA1IDAxOjA3OjE0
IG5peG9zIGtlcm5lbDogUE06IGhpYmVybmF0aW9uOiBNYXJraW5nIG5vc2F2ZSBwYWdlczogW21l
bSAweDczNGNkMDAwLTB4NzM0Y2RmZmZdCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBQ
TTogaGliZXJuYXRpb246IE1hcmtpbmcgbm9zYXZlIHBhZ2VzOiBbbWVtIDB4NzdhZmUwMDAtMHg3
YTdmZGZmZl0KOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjog
TWFya2luZyBub3NhdmUgcGFnZXM6IFttZW0gMHg3YmZmMzAwMC0weDdiZmY1ZmZmXQo55pyIIDA1
IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogUE06IGhpYmVybmF0aW9uOiBNYXJraW5nIG5vc2F2ZSBw
YWdlczogW21lbSAweDdjMDAwMDAwLTB4ZmZmZmZmZmZdCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mg
a2VybmVsOiBQTTogaGliZXJuYXRpb246IEJhc2ljIG1lbW9yeSBiaXRtYXBzIGNyZWF0ZWQKOeac
iCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUg
dGFza3MKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHJlbWFpbmluZyBm
cmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFwc2VkIDAuMDAxIHNlY29uZHMpCjnmnIggMDUg
MDE6MDc6MTQgbml4b3Mga2VybmVsOiBQTTogaGliZXJuYXRpb246IFByZWFsbG9jYXRpbmcgaW1h
Z2UgbWVtb3J5CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBQTTogaGliZXJuYXRpb246
IEFsbG9jYXRlZCAyODA0MDc4IHBhZ2VzIGZvciBzbmFwc2hvdAo55pyIIDA1IDAxOjA3OjE0IG5p
eG9zIGtlcm5lbDogUE06IGhpYmVybmF0aW9uOiBBbGxvY2F0ZWQgMTEyMTYzMTIga2J5dGVzIGlu
IDE1Ljg1IHNlY29uZHMgKDcwNy42NSBNQi9zKQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5l
bDogcHJpbnRrOiBTdXNwZW5kaW5nIGNvbnNvbGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQg
dG8gZGVidWcpCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBBQ1BJOiBFQzogaW50ZXJy
dXB0IGJsb2NrZWQKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IEFDUEk6IFBNOiBQcmVw
YXJpbmcgdG8gZW50ZXIgc3lzdGVtIHNsZWVwIHN0YXRlIFM0CjnmnIggMDUgMDE6MDc6MTQgbml4
b3Mga2VybmVsOiBBQ1BJOiBFQzogZXZlbnQgYmxvY2tlZAo55pyIIDA1IDAxOjA3OjE0IG5peG9z
IGtlcm5lbDogQUNQSTogRUM6IEVDIHN0b3BwZWQKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJu
ZWw6IEFDUEk6IFBNOiBTYXZpbmcgcGxhdGZvcm0gTlZTIG1lbW9yeQo55pyIIDA1IDAxOjA3OjE0
IG5peG9zIGtlcm5lbDogRGlzYWJsaW5nIG5vbi1ib290IENQVXMgLi4uCjnmnIggMDUgMDE6MDc6
MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBDUFUgMTUgaXMgbm93IG9mZmxpbmUKOeaciCAwNSAw
MTowNzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IENQVSAxNCBpcyBub3cgb2ZmbGluZQo55pyI
IDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogc21wYm9vdDogQ1BVIDEzIGlzIG5vdyBvZmZsaW5l
CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBDUFUgMTIgaXMgbm93IG9m
ZmxpbmUKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IENQVSAxMSBpcyBu
b3cgb2ZmbGluZQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogc21wYm9vdDogQ1BVIDEw
IGlzIG5vdyBvZmZsaW5lCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBD
UFUgOSBpcyBub3cgb2ZmbGluZQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogc21wYm9v
dDogQ1BVIDggaXMgbm93IG9mZmxpbmUKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IHNt
cGJvb3Q6IENQVSA3IGlzIG5vdyBvZmZsaW5lCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVs
OiBzbXBib290OiBDUFUgNiBpcyBub3cgb2ZmbGluZQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtl
cm5lbDogc21wYm9vdDogQ1BVIDUgaXMgbm93IG9mZmxpbmUKOeaciCAwNSAwMTowNzoxNCBuaXhv
cyBrZXJuZWw6IHNtcGJvb3Q6IENQVSA0IGlzIG5vdyBvZmZsaW5lCjnmnIggMDUgMDE6MDc6MTQg
bml4b3Mga2VybmVsOiBzbXBib290OiBDUFUgMyBpcyBub3cgb2ZmbGluZQo55pyIIDA1IDAxOjA3
OjE0IG5peG9zIGtlcm5lbDogc21wYm9vdDogQ1BVIDIgaXMgbm93IG9mZmxpbmUKOeaciCAwNSAw
MTowNzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IENQVSAxIGlzIG5vdyBvZmZsaW5lCjnmnIgg
MDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBTcGVjdHJlIFYyIDogVXBkYXRlIHVzZXIgc3BhY2Ug
U01UIG1pdGlnYXRpb246IFNUSUJQIG9mZgo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDog
UE06IGhpYmVybmF0aW9uOiBOb3JtYWwgcGFnZXMgbmVlZGVkOiAzMjU4NjA2ICsgMTAyNCwgYXZh
aWxhYmxlIHBhZ2VzOiA0MDE0NTM4CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBBQ1BJ
OiBQTTogUmVzdG9yaW5nIHBsYXRmb3JtIE5WUyBtZW1vcnkKOeaciCAwNSAwMTowNzoxNCBuaXhv
cyBrZXJuZWw6IEFDUEk6IEVDOiBFQyBzdGFydGVkCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2Vy
bmVsOiBMVlQgb2Zmc2V0IDAgYXNzaWduZWQgZm9yIHZlY3RvciAweDQwMAo55pyIIDA1IDAxOjA3
OjE0IG5peG9zIGtlcm5lbDogRW5hYmxpbmcgbm9uLWJvb3QgQ1BVcyAuLi4KOeaciCAwNSAwMTow
NzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAxIEFQ
SUMgMHgxCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBTcGVjdHJlIFYyIDogVXBkYXRl
IHVzZXIgc3BhY2UgU01UIG1pdGlnYXRpb246IFNUSUJQIGFsd2F5cy1vbgo55pyIIDA1IDAxOjA3
OjE0IG5peG9zIGtlcm5lbDogQ1BVMSBpcyB1cAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5l
bDogc21wYm9vdDogQm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDIgQVBJQyAweDIKOeaciCAwNSAw
MTowNzoxNCBuaXhvcyBrZXJuZWw6IENQVTIgaXMgdXAKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBr
ZXJuZWw6IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAzIEFQSUMgMHgzCjnmnIgg
MDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBDUFUzIGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4
b3Mga2VybmVsOiBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgNCBBUElDIDB4NAo5
5pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogQ1BVNCBpcyB1cAo55pyIIDA1IDAxOjA3OjE0
IG5peG9zIGtlcm5lbDogc21wYm9vdDogQm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDUgQVBJQyAw
eDUKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IENQVTUgaXMgdXAKOeaciCAwNSAwMTow
NzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciA2IEFQ
SUMgMHg2CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBDUFU2IGlzIHVwCjnmnIggMDUg
MDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3Ig
NyBBUElDIDB4Nwo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogQ1BVNyBpcyB1cAo55pyI
IDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogc21wYm9vdDogQm9vdGluZyBOb2RlIDAgUHJvY2Vz
c29yIDggQVBJQyAweDgKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IENQVTggaXMgdXAK
OeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFBy
b2Nlc3NvciA5IEFQSUMgMHg5CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBDUFU5IGlz
IHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBCb290aW5nIE5vZGUg
MCBQcm9jZXNzb3IgMTAgQVBJQyAweGEKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IENQ
VTEwIGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBCb290aW5n
IE5vZGUgMCBQcm9jZXNzb3IgMTEgQVBJQyAweGIKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJu
ZWw6IENQVTExIGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBib290OiBC
b290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTIgQVBJQyAweGMKOeaciCAwNSAwMTowNzoxNCBuaXhv
cyBrZXJuZWw6IENQVTEyIGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBzbXBi
b290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTMgQVBJQyAweGQKOeaciCAwNSAwMTowNzox
NCBuaXhvcyBrZXJuZWw6IENQVTEzIGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVs
OiBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTQgQVBJQyAweGUKOeaciCAwNSAw
MTowNzoxNCBuaXhvcyBrZXJuZWw6IENQVTE0IGlzIHVwCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mg
a2VybmVsOiBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTUgQVBJQyAweGYKOeac
iCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IENQVTE1IGlzIHVwCjnmnIggMDUgMDE6MDc6MTQg
bml4b3Mga2VybmVsOiBBQ1BJOiBQTTogV2FraW5nIHVwIGZyb20gc3lzdGVtIHNsZWVwIHN0YXRl
IFM0CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBBQ1BJOiBFQzogaW50ZXJydXB0IHVu
YmxvY2tlZAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogdXNiIHVzYjM6IHJvb3QgaHVi
IGxvc3QgcG93ZXIgb3Igd2FzIHJlc2V0CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiB1
c2IgdXNiMTogcm9vdCBodWIgbG9zdCBwb3dlciBvciB3YXMgcmVzZXQKOeaciCAwNSAwMTowNzox
NCBuaXhvcyBrZXJuZWw6IHVzYiB1c2I0OiByb290IGh1YiBsb3N0IHBvd2VyIG9yIHdhcyByZXNl
dAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogdXNiIHVzYjI6IHJvb3QgaHViIGxvc3Qg
cG93ZXIgb3Igd2FzIHJlc2V0CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiB1c2IgdXNi
NTogcm9vdCBodWIgbG9zdCBwb3dlciBvciB3YXMgcmVzZXQKOeaciCAwNSAwMTowNzoxNCBuaXhv
cyBrZXJuZWw6IHVzYiB1c2I2OiByb290IGh1YiBsb3N0IHBvd2VyIG9yIHdhcyByZXNldAo55pyI
IDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogQUNQSTogRUM6IGV2ZW50IHVuYmxvY2tlZAo55pyI
IDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogdXNiIHVzYjc6IHJvb3QgaHViIGxvc3QgcG93ZXIg
b3Igd2FzIHJlc2V0CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiB1c2IgdXNiODogcm9v
dCBodWIgbG9zdCBwb3dlciBvciB3YXMgcmVzZXQKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJu
ZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFtkcm1dIFBDSUUgR0FSVCBvZiA1MTJNIGVuYWJsZWQg
KHRhYmxlIGF0IDB4MDAwMDAwODBGRkQwMDAwMCkuCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2Vy
bmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiBQU1AgaXMgcmVzdW1pbmcuLi4KOeaciCAwNSAwMTow
NzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJlc2VydmUgMHg0MDAwMDAw
IGZyb20gMHg4MGY4MDAwMDAwIGZvciBQU1AgVE1SCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2Vy
bmVsOiBudm1lIG52bWUwOiAxNi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzCjnmnIggMDUg
MDE6MDc6MTQgbml4b3Mga2VybmVsOiB1c2IgMS0zOiBXQVJOOiBpbnZhbGlkIGNvbnRleHQgc3Rh
dGUgZm9yIGV2YWx1YXRlIGNvbnRleHQgY29tbWFuZC4KOeaciCAwNSAwMTowNzoxNCBuaXhvcyBr
ZXJuZWw6IHVzYiAzLTE6IHJlc2V0IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2lu
ZyB4aGNpX2hjZAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogdXNiIDEtMzogcmVzZXQg
ZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2lfaGNkCjnmnIggMDUgMDE6
MDc6MTQgbml4b3Mga2VybmVsOiB1c2IgMS0yOiBXQVJOOiBpbnZhbGlkIGNvbnRleHQgc3RhdGUg
Zm9yIGV2YWx1YXRlIGNvbnRleHQgY29tbWFuZC4KOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJu
ZWw6IHVzYiAxLTI6IHJlc2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2luZyB4
aGNpX2hjZAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAu
MDogUkFTOiBvcHRpb25hbCByYXMgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZQo55pyIIDA1IDAx
OjA3OjE0IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogUkFQOiBvcHRpb25hbCBy
YXAgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZQo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5l
bDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogU0VDVVJFRElTUExBWTogb3B0aW9uYWwgc2VjdXJlZGlz
cGxheSB0YSB1Y29kZSBpcyBub3QgYXZhaWxhYmxlCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2Vy
bmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiBTTVUgaXMgcmVzdW1pbmcuLi4KOeaciCAwNSAwMTow
NzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFNNVSBpcyByZXN1bWVkIHN1
Y2Nlc3NmdWxseSEKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1
OjAwLjA6IFtkcm1dIERNVUIgaGFyZHdhcmUgaW5pdGlhbGl6ZWQ6IHZlcnNpb249MHgwODAwNUUw
MAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmlu
ZyBnZnhfMC4wLjAgdXNlcyBWTSBpbnYgZW5nIDAgb24gaHViIDAKOeaciCAwNSAwMTowNzoxNCBu
aXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29tcF8xLjAuMCB1c2VzIFZN
IGludiBlbmcgMSBvbiBodWIgMAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogYW1kZ3B1
IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMS4wIHVzZXMgVk0gaW52IGVuZyA0IG9uIGh1YiAw
CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5n
IGNvbXBfMS4yLjAgdXNlcyBWTSBpbnYgZW5nIDYgb24gaHViIDAKOeaciCAwNSAwMTowNzoxNCBu
aXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29tcF8xLjMuMCB1c2VzIFZN
IGludiBlbmcgNyBvbiBodWIgMAo55pyIIDA1IDAxOjA3OjE0IG5peG9zIGtlcm5lbDogYW1kZ3B1
IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMC4xIHVzZXMgVk0gaW52IGVuZyA4IG9uIGh1YiAw
CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5n
IGNvbXBfMS4xLjEgdXNlcyBWTSBpbnYgZW5nIDkgb24gaHViIDAKOeaciCAwNSAwMTowNzoxNCBu
aXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29tcF8xLjIuMSB1c2VzIFZN
IGludiBlbmcgMTAgb24gaHViIDAKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdw
dSAwMDAwOjM1OjAwLjA6IHJpbmcgY29tcF8xLjMuMSB1c2VzIFZNIGludiBlbmcgMTEgb24gaHVi
IDAKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJp
bmcgc2RtYTAgdXNlcyBWTSBpbnYgZW5nIDEyIG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MTQgbml4
b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5nIHZjbl91bmlmaWVkXzAgdXNlcyBW
TSBpbnYgZW5nIDAgb24gaHViIDgKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdw
dSAwMDAwOjM1OjAwLjA6IHJpbmcganBlZ19kZWMgdXNlcyBWTSBpbnYgZW5nIDEgb24gaHViIDgK
OeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcg
bWVzX2tpcV8zLjEuMCB1c2VzIFZNIGludiBlbmcgMTMgb24gaHViIDAKOeaciCAwNSAwMTowNzox
NCBuaXhvcyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogQmFzaWMgbWVtb3J5IGJpdG1hcHMgZnJl
ZWQKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IE9PTSBraWxsZXIgZW5hYmxlZC4KOeac
iCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IFJlc3RhcnRpbmcgdGFza3M6IFN0YXJ0aW5nCjnm
nIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBSZXN0YXJ0aW5nIHRhc2tzOiBEb25lCjnmnIgg
MDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBlZml2YXJmczogcmVzeW5jaW5nIHZhcmlhYmxlIHN0
YXRlCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBlZml2YXJmczogcmVtb3ZpbmcgdmFy
aWFibGUgSGliZXJuYXRlTG9jYXRpb24tOGNmMjY0NGItNGIwYi00MjhmLTkzODctNmQ4NzYwNTBk
YzY3CjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBlZml2YXJmczogZmluaXNoZWQgcmVz
eW5jaW5nIHZhcmlhYmxlIHN0YXRlCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBCbHVl
dG9vdGg6IGhjaTA6IFJUTDogZXhhbWluaW5nIGhjaV92ZXI9MGIgaGNpX3Jldj0wMDBiIGxtcF92
ZXI9MGIgbG1wX3N1YnZlcj04ODUyCjnmnIggMDUgMDE6MDc6MTQgbml4b3Mga2VybmVsOiBCbHVl
dG9vdGg6IGhjaTA6IFJUTDogcm9tX3ZlcnNpb24gc3RhdHVzPTAgdmVyc2lvbj0xCjnmnIggMDUg
MDE6MDc6MTQgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDogYnRydGxfaW5pdGlh
bGl6ZToga2V5IGlkIDAKOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDog
aGNpMDogUlRMOiBsb2FkaW5nIHJ0bF9idC9ydGw4ODUyYnVfZncuYmluCjnmnIggMDUgMDE6MDc6
MTQgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDogbG9hZGluZyBydGxfYnQvcnRs
ODg1MmJ1X2NvbmZpZy5iaW4KOeaciCAwNSAwMTowNzoxNCBuaXhvcyBrZXJuZWw6IEJsdWV0b290
aDogaGNpMDogUlRMOiBjZmdfc3ogNiwgdG90YWwgc3ogNjI1MzkKOeaciCAwNSAwMTowNzoxNCBu
aXhvcyBrZXJuZWw6IFBNOiBoaWJlcm5hdGlvbjogaGliZXJuYXRpb24gZXhpdAo55pyIIDA1IDAx
OjA3OjE1IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogVk0gbWVtb3J5IHN0YXRz
IGZvciBwcm9jIC5rc2NyZWVubG9ja2VyXygyNDE2MjcpIHRhc2sga3NjcmVlbmxvYzpjczAoMjQx
NjE3KSBpcyBub24temVybyB3aGVuIGZpbmkKOeaciCAwNSAwMTowNzoxNSBuaXhvcyBrZXJuZWw6
IEJsdWV0b290aDogaGNpMDogUlRMOiBmdyB2ZXJzaW9uIDB4MTI3Y2ZkNzgKOeaciCAwNSAwMTow
NzoxNSBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogTUdNVCB2ZXIgMS4yMwo55pyIIDA1IDAxOjA3
OjE4IG5peG9zIGtlcm5lbDogd2xwNHMwOiBhdXRoZW50aWNhdGUgd2l0aCAyYzo3MDo0ZjozZjo3
Nzo0MiAobG9jYWwgYWRkcmVzcz1jMDozNTozMjo4MTo4MTo5ZCkKOeaciCAwNSAwMTowNzoxOCBu
aXhvcyBrZXJuZWw6IHdscDRzMDogc2VuZCBhdXRoIHRvIDJjOjcwOjRmOjNmOjc3OjQyICh0cnkg
MS8zKQo55pyIIDA1IDAxOjA3OjE4IG5peG9zIGtlcm5lbDogd2xwNHMwOiBhdXRoZW50aWNhdGUg
d2l0aCAyYzo3MDo0ZjozZjo3Nzo0MiAobG9jYWwgYWRkcmVzcz1jMDozNTozMjo4MTo4MTo5ZCkK
OeaciCAwNSAwMTowNzoxOCBuaXhvcyBrZXJuZWw6IHdscDRzMDogc2VuZCBhdXRoIHRvIDJjOjcw
OjRmOjNmOjc3OjQyICh0cnkgMS8zKQo55pyIIDA1IDAxOjA3OjE4IG5peG9zIGtlcm5lbDogd2xw
NHMwOiBhdXRoZW50aWNhdGVkCjnmnIggMDUgMDE6MDc6MTggbml4b3Mga2VybmVsOiB3bHA0czA6
IGFzc29jaWF0ZSB3aXRoIDJjOjcwOjRmOjNmOjc3OjQyICh0cnkgMS8zKQo55pyIIDA1IDAxOjA3
OjE4IG5peG9zIGtlcm5lbDogd2xwNHMwOiBSWCBBc3NvY1Jlc3AgZnJvbSAyYzo3MDo0ZjozZjo3
Nzo0MiAoY2FwYWI9MHgxMDMxIHN0YXR1cz0wIGFpZD0xMSkKOeaciCAwNSAwMTowNzoxOSBuaXhv
cyBrZXJuZWw6IHdscDRzMDogYXNzb2NpYXRlZAo55pyIIDA1IDAxOjA3OjE5IG5peG9zIGtlcm5l
bDogd2xwNHMwOiBMaW1pdGluZyBUWCBwb3dlciB0byAzMCAoMzAgLSAwKSBkQm0gYXMgYWR2ZXJ0
aXNlZCBieSAyYzo3MDo0ZjozZjo3Nzo0Mgo55pyIIDA1IDAxOjA3OjI0IG5peG9zIGtlcm5lbDog
d2xwNHMwOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gMmM6NzA6NGY6M2Y6Nzc6NDIgYnkgbG9jYWwg
Y2hvaWNlIChSZWFzb246IDM9REVBVVRIX0xFQVZJTkcpCjnmnIggMDUgMDE6MDc6MjUgbml4b3Mg
a2VybmVsOiBQTTogc3VzcGVuZCBlbnRyeSAoczJpZGxlKQo55pyIIDA1IDAxOjA3OjI1IG5peG9z
IGtlcm5lbDogRmlsZXN5c3RlbXMgc3luYzogMC4xMDUgc2Vjb25kcwo55pyIIDA1IDAxOjA3OjI2
IG5peG9zIGtlcm5lbDogRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMKOeaciCAwNSAwMTow
NzoyNiBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIGNvbXBsZXRl
ZCAoZWxhcHNlZCAwLjAwMiBzZWNvbmRzKQo55pyIIDA1IDAxOjA3OjI2IG5peG9zIGtlcm5lbDog
T09NIGtpbGxlciBkaXNhYmxlZC4KOeaciCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IEZyZWV6
aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MKOeaciCAwNSAwMTowNzoyNiBuaXhvcyBrZXJu
ZWw6IEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFwc2Vk
IDAuMDAxIHNlY29uZHMpCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBwcmludGs6IFN1
c3BlbmRpbmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykKOeac
iCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IFBNOiBTb21lIGRldmljZXMgZmFpbGVkIHRvIHN1
c3BlbmQsIG9yIGVhcmx5IHdha2UgZXZlbnQgZGV0ZWN0ZWQKOeaciCAwNSAwMTowNzoyNiBuaXhv
cyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFtkcm1dIFBDSUUgR0FSVCBvZiA1MTJNIGVu
YWJsZWQgKHRhYmxlIGF0IDB4MDAwMDAwODBGRkQwMDAwMCkuCjnmnIggMDUgMDE6MDc6MjYgbml4
b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiBTTVUgaXMgcmVzdW1pbmcuLi4KOeaciCAw
NSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFNNVSBpcyByZXN1
bWVkIHN1Y2Nlc3NmdWxseSEKOeaciCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IG52bWUgbnZt
ZTA6IDE2LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMKOeaciCAwNSAwMTowNzoyNiBuaXhv
cyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgZ2Z4XzAuMC4wIHVzZXMgVk0gaW52
IGVuZyAwIG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBhbWRncHUgMDAw
MDozNTowMC4wOiByaW5nIGNvbXBfMS4wLjAgdXNlcyBWTSBpbnYgZW5nIDEgb24gaHViIDAKOeac
iCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29t
cF8xLjEuMCB1c2VzIFZNIGludiBlbmcgNCBvbiBodWIgMAo55pyIIDA1IDAxOjA3OjI2IG5peG9z
IGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMi4wIHVzZXMgVk0gaW52
IGVuZyA2IG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBhbWRncHUgMDAw
MDozNTowMC4wOiByaW5nIGNvbXBfMS4zLjAgdXNlcyBWTSBpbnYgZW5nIDcgb24gaHViIDAKOeac
iCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29t
cF8xLjAuMSB1c2VzIFZNIGludiBlbmcgOCBvbiBodWIgMAo55pyIIDA1IDAxOjA3OjI2IG5peG9z
IGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMS4xIHVzZXMgVk0gaW52
IGVuZyA5IG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBhbWRncHUgMDAw
MDozNTowMC4wOiByaW5nIGNvbXBfMS4yLjEgdXNlcyBWTSBpbnYgZW5nIDEwIG9uIGh1YiAwCjnm
nIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5nIGNv
bXBfMS4zLjEgdXNlcyBWTSBpbnYgZW5nIDExIG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MjYgbml4
b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5nIHNkbWEwIHVzZXMgVk0gaW52IGVu
ZyAxMiBvbiBodWIgMAo55pyIIDA1IDAxOjA3OjI2IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6
MzU6MDAuMDogcmluZyB2Y25fdW5pZmllZF8wIHVzZXMgVk0gaW52IGVuZyAwIG9uIGh1YiA4Cjnm
nIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5nIGpw
ZWdfZGVjIHVzZXMgVk0gaW52IGVuZyAxIG9uIGh1YiA4CjnmnIggMDUgMDE6MDc6MjYgbml4b3Mg
a2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiByaW5nIG1lc19raXFfMy4xLjAgdXNlcyBWTSBp
bnYgZW5nIDEzIG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiB1c2IgMS0z
OiByZXNldCBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNpbmcgeGhjaV9oY2QKOeac
iCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IE9PTSBraWxsZXIgZW5hYmxlZC4KOeaciCAwNSAw
MTowNzoyNiBuaXhvcyBrZXJuZWw6IFJlc3RhcnRpbmcgdGFza3M6IFN0YXJ0aW5nCjnmnIggMDUg
MDE6MDc6MjYgbml4b3Mga2VybmVsOiBSZXN0YXJ0aW5nIHRhc2tzOiBEb25lCjnmnIggMDUgMDE6
MDc6MjYgbml4b3Mga2VybmVsOiBlZml2YXJmczogcmVzeW5jaW5nIHZhcmlhYmxlIHN0YXRlCjnm
nIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiBlZml2YXJmczogZmluaXNoZWQgcmVzeW5jaW5n
IHZhcmlhYmxlIHN0YXRlCjnmnIggMDUgMDE6MDc6MjYgbml4b3Mga2VybmVsOiByYW5kb206IGNy
bmcgcmVzZWVkZWQgb24gc3lzdGVtIHJlc3VtcHRpb24KOeaciCAwNSAwMTowNzoyNiBuaXhvcyBr
ZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBleGFtaW5pbmcgaGNpX3Zlcj0wYiBoY2lfcmV2
PTAwMGIgbG1wX3Zlcj0wYiBsbXBfc3VidmVyPTg4NTIKOeaciCAwNSAwMTowNzoyNiBuaXhvcyBr
ZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiByb21fdmVyc2lvbiBzdGF0dXM9MCB2ZXJzaW9u
PTEKOeaciCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBi
dHJ0bF9pbml0aWFsaXplOiBrZXkgaWQgMAo55pyIIDA1IDAxOjA3OjI2IG5peG9zIGtlcm5lbDog
Qmx1ZXRvb3RoOiBoY2kwOiBSVEw6IGxvYWRpbmcgcnRsX2J0L3J0bDg4NTJidV9mdy5iaW4KOeac
iCAwNSAwMTowNzoyNiBuaXhvcyBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogUlRMOiBsb2FkaW5n
IHJ0bF9idC9ydGw4ODUyYnVfY29uZmlnLmJpbgo55pyIIDA1IDAxOjA3OjI2IG5peG9zIGtlcm5l
bDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IGNmZ19zeiA2LCB0b3RhbCBzeiA2MjUzOQo55pyIIDA1
IDAxOjA3OjI2IG5peG9zIGtlcm5lbDogUE06IHN1c3BlbmQgZXhpdAo55pyIIDA1IDAxOjA3OjI2
IG5peG9zIGtlcm5lbDogUE06IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkKOeaciCAwNSAwMTowNzoy
NiBuaXhvcyBrZXJuZWw6IEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDE3IHNlY29uZHMKOeaciCAwNSAw
MTowNzoyOSBuaXhvcyBrZXJuZWw6IEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzCjnmnIgg
MDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3NlcyBj
b21wbGV0ZWQgKGVsYXBzZWQgMC4wMDIgc2Vjb25kcykKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBr
ZXJuZWw6IE9PTSBraWxsZXIgZGlzYWJsZWQuCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVs
OiBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzCjnmnIggMDUgMDE6MDc6Mjkgbml4
b3Mga2VybmVsOiBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIGNvbXBsZXRlZCAo
ZWxhcHNlZCAwLjAwMSBzZWNvbmRzKQo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogcHJp
bnRrOiBTdXNwZW5kaW5nIGNvbnNvbGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQgdG8gZGVi
dWcpCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDog
ZG93bmxvYWQgZncgY29tbWFuZCBmYWlsZWQgKC0yKQo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtl
cm5lbDogQUNQSTogRUM6IGludGVycnVwdCBibG9ja2VkCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mg
a2VybmVsOiBhbWRfcG1jIEFNREkwMDA5OjAwOiBMYXN0IHN1c3BlbmQgZGlkbid0IHJlYWNoIGRl
ZXBlc3Qgc3RhdGUKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IEFDUEkgQklPUyBFcnJv
ciAoYnVnKTogQ291bGQgbm90IHJlc29sdmUgc3ltYm9sIFtcWFhERl0sIEFFX05PVF9GT1VORCAo
MjAyNjA0MDgvcHNhcmdzLTM2NSkKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IEFDUEkg
RXJyb3I6IEFib3J0aW5nIG1ldGhvZCBcX1NCLlBFUC5fRFNNIGR1ZSB0byBwcmV2aW91cyBlcnJv
ciAoQUVfTk9UX0ZPVU5EKSAoMjAyNjA0MDgvcHNwYXJzZS01NDMpCjnmnIggMDUgMDE6MDc6Mjkg
bml4b3Mga2VybmVsOiBBQ1BJOiBFQzogaW50ZXJydXB0IHVuYmxvY2tlZAo55pyIIDA1IDAxOjA3
OjI5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogW2RybV0gUENJRSBHQVJUIG9m
IDUxMk0gZW5hYmxlZCAodGFibGUgYXQgMHgwMDAwMDA4MEZGRDAwMDAwKS4KOeaciCAwNSAwMTow
NzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IFNNVSBpcyByZXN1bWluZy4u
Lgo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogU01V
IGlzIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5IQo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDog
YW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBnZnhfMC4wLjAgdXNlcyBWTSBpbnYgZW5nIDAgb24g
aHViIDAKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6
IHJpbmcgY29tcF8xLjAuMCB1c2VzIFZNIGludiBlbmcgMSBvbiBodWIgMAo55pyIIDA1IDAxOjA3
OjI5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMS4wIHVz
ZXMgVk0gaW52IGVuZyA0IG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBh
bWRncHUgMDAwMDozNTowMC4wOiByaW5nIGNvbXBfMS4yLjAgdXNlcyBWTSBpbnYgZW5nIDYgb24g
aHViIDAKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6
IHJpbmcgY29tcF8xLjMuMCB1c2VzIFZNIGludiBlbmcgNyBvbiBodWIgMAo55pyIIDA1IDAxOjA3
OjI5IG5peG9zIGtlcm5lbDogYW1kZ3B1IDAwMDA6MzU6MDAuMDogcmluZyBjb21wXzEuMC4xIHVz
ZXMgVk0gaW52IGVuZyA4IG9uIGh1YiAwCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBh
bWRncHUgMDAwMDozNTowMC4wOiByaW5nIGNvbXBfMS4xLjEgdXNlcyBWTSBpbnYgZW5nIDkgb24g
aHViIDAKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6
IHJpbmcgY29tcF8xLjIuMSB1c2VzIFZNIGludiBlbmcgMTAgb24gaHViIDAKOeaciCAwNSAwMTow
NzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgY29tcF8xLjMuMSB1
c2VzIFZNIGludiBlbmcgMTEgb24gaHViIDAKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6
IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgc2RtYTAgdXNlcyBWTSBpbnYgZW5nIDEyIG9uIGh1
YiAwCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBhbWRncHUgMDAwMDozNTowMC4wOiBy
aW5nIHZjbl91bmlmaWVkXzAgdXNlcyBWTSBpbnYgZW5nIDAgb24gaHViIDgKOeaciCAwNSAwMTow
NzoyOSBuaXhvcyBrZXJuZWw6IGFtZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcganBlZ19kZWMgdXNl
cyBWTSBpbnYgZW5nIDEgb24gaHViIDgKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGFt
ZGdwdSAwMDAwOjM1OjAwLjA6IHJpbmcgbWVzX2tpcV8zLjEuMCB1c2VzIFZNIGludiBlbmcgMTMg
b24gaHViIDAKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IG52bWUgbnZtZTA6IDE2LzAv
MCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6
IHVzYiAxLTM6IHJlc2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMiB1c2luZyB4aGNp
X2hjZAo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogT09NIGtpbGxlciBlbmFibGVkLgo5
5pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogUmVzdGFydGluZyB0YXNrczogU3RhcnRpbmcK
OeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IFJlc3RhcnRpbmcgdGFza3M6IERvbmUKOeac
iCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiByZXN5bmNpbmcgdmFyaWFibGUg
c3RhdGUKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IGVmaXZhcmZzOiBmaW5pc2hlZCBy
ZXN5bmNpbmcgdmFyaWFibGUgc3RhdGUKOeaciCAwNSAwMTowNzoyOSBuaXhvcyBrZXJuZWw6IHJh
bmRvbTogY3JuZyByZXNlZWRlZCBvbiBzeXN0ZW0gcmVzdW1wdGlvbgo55pyIIDA1IDAxOjA3OjI5
IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IGV4YW1pbmluZyBoY2lfdmVyPTBi
IGhjaV9yZXY9MDAwYiBsbXBfdmVyPTBiIGxtcF9zdWJ2ZXI9ODg1Mgo55pyIIDA1IDAxOjA3OjI5
IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6IHJvbV92ZXJzaW9uIHN0YXR1cz0w
IHZlcnNpb249MQo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kw
OiBSVEw6IGJ0cnRsX2luaXRpYWxpemU6IGtleSBpZCAwCjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mg
a2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDogbG9hZGluZyBydGxfYnQvcnRsODg1MmJ1X2Z3
LmJpbgo55pyIIDA1IDAxOjA3OjI5IG5peG9zIGtlcm5lbDogQmx1ZXRvb3RoOiBoY2kwOiBSVEw6
IGxvYWRpbmcgcnRsX2J0L3J0bDg4NTJidV9jb25maWcuYmluCjnmnIggMDUgMDE6MDc6Mjkgbml4
b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDogY2ZnX3N6IDYsIHRvdGFsIHN6IDYyNTM5
CjnmnIggMDUgMDE6MDc6Mjkgbml4b3Mga2VybmVsOiBQTTogc3VzcGVuZCBleGl0CjnmnIggMDUg
MDE6MDc6MzAgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IGhjaTA6IFJUTDogZncgdmVyc2lvbiAw
eDEyN2NmZDc4CjnmnIggMDUgMDE6MDc6MzAgbml4b3Mga2VybmVsOiBCbHVldG9vdGg6IE1HTVQg
dmVyIDEuMjMKOeaciCAwNSAwMTowNzozMyBuaXhvcyBrZXJuZWw6IHdscDRzMDogYXV0aGVudGlj
YXRlIHdpdGggMmM6NzA6NGY6M2Y6Nzc6NDIgKGxvY2FsIGFkZHJlc3M9YzA6MzU6MzI6ODE6ODE6
OWQpCjnmnIggMDUgMDE6MDc6MzMgbml4b3Mga2VybmVsOiB3bHA0czA6IHNlbmQgYXV0aCB0byAy
Yzo3MDo0ZjozZjo3Nzo0MiAodHJ5IDEvMykKOeaciCAwNSAwMTowNzozMyBuaXhvcyBrZXJuZWw6
IHdscDRzMDogYXV0aGVudGljYXRlIHdpdGggMmM6NzA6NGY6M2Y6Nzc6NDIgKGxvY2FsIGFkZHJl
c3M9YzA6MzU6MzI6ODE6ODE6OWQpCjnmnIggMDUgMDE6MDc6MzMgbml4b3Mga2VybmVsOiB3bHA0
czA6IHNlbmQgYXV0aCB0byAyYzo3MDo0ZjozZjo3Nzo0MiAodHJ5IDEvMykKOeaciCAwNSAwMTow
NzozMyBuaXhvcyBrZXJuZWw6IHdscDRzMDogYXV0aGVudGljYXRlZAo55pyIIDA1IDAxOjA3OjMz
IG5peG9zIGtlcm5lbDogd2xwNHMwOiBhc3NvY2lhdGUgd2l0aCAyYzo3MDo0ZjozZjo3Nzo0MiAo
dHJ5IDEvMykKOeaciCAwNSAwMTowNzozMyBuaXhvcyBrZXJuZWw6IHdscDRzMDogUlggQXNzb2NS
ZXNwIGZyb20gMmM6NzA6NGY6M2Y6Nzc6NDIgKGNhcGFiPTB4MTAzMSBzdGF0dXM9MCBhaWQ9MTEp
CjnmnIggMDUgMDE6MDc6MzMgbml4b3Mga2VybmVsOiB3bHA0czA6IGFzc29jaWF0ZWQKOeaciCAw
NSAwMTowNzozMyBuaXhvcyBrZXJuZWw6IHdscDRzMDogTGltaXRpbmcgVFggcG93ZXIgdG8gMzAg
KDMwIC0gMCkgZEJtIGFzIGFkdmVydGlzZWQgYnkgMmM6NzA6NGY6M2Y6Nzc6NDIKOeaciCAwNSAw
MTowNzozOSBuaXhvcyBrZXJuZWw6IHdscDRzMDogZGVhdXRoZW50aWNhdGluZyBmcm9tIDJjOjcw
OjRmOjNmOjc3OjQyIGJ5IGxvY2FsIGNob2ljZSAoUmVhc29uOiAzPURFQVVUSF9MRUFWSU5HKQo=

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_
Content-Type: text/plain; name="5-hardware-and-counts.txt"
Content-Description: 5-hardware-and-counts.txt
Content-Disposition: attachment; filename="5-hardware-and-counts.txt";
	size=725; creation-date="Mon, 07 Sep 2026 02:09:02 GMT";
	modification-date="Mon, 07 Sep 2026 02:10:51 GMT"
Content-Transfer-Encoding: base64

PT0gaGFyZHdhcmUgPT0Ka2VybmVsOiA3LjIuMyAjMS1OaXhPUyBQUkVFTVBUKGxhenkpCmRtaTog
TEVOT1ZPIDgzRDUsIGJvYXJkIExOVk5CMTYxMjE2LCBCSU9TIE5RQ04yN1dXCmJ0OiBVU0IgMGJk
YTo0ODUzIChCbHVldG9vdGggUmFkaW8pLCBidXMgMS0zLCBmdWxsLXNwZWVkCm1lbV9zbGVlcDog
W3MyaWRsZV0KQlQgcmZraWxsIHN0YXRlIGR1cmluZyBpbmNpZGVudDogc29mdCBibG9ja2VkIHll
cyAocmFkaW8gb2ZmLCBkcml2ZXIgc3RpbGwgYm91bmQpCgo9PSBjb3VudHMgYWNyb3NzIGZhaWxp
bmcgYm9vdCAoMjAyNi0wOS0wNCAwOTo0MyAtPiAyMDI2LTA5LTA3IDA4OjQ5IGZvcmNlZCBwb3dl
ci1vZmYpID09CnVzZXJzcGFjZSBzdXNwZW5kIHJlcXVlc3RzIChzeXN0ZW1kLWxvZ2luZCk6IDI3
NjgKa2VybmVsIHMyaWRsZSBlbnRyaWVzOiA1NTMzCmZhaWxlZCBzdXNwZW5kcyAoJ1NvbWUgZGV2
aWNlcyBmYWlsZWQgdG8gc3VzcGVuZCwgb3IgZWFybHkgd2FrZSBldmVudCBkZXRlY3RlZCcpOiAy
NzY0CmJ0IGZpcm13YXJlIGRvd25sb2FkIGZhaWx1cmVzICgnZG93bmxvYWQgZncgY29tbWFuZCBm
YWlsZWQnKTogMjQ0OAp1c2IgMS0zIChidCByYWRpbykgcmVzZXRzOiA2ODExCnNvZnQgbG9ja3Vw
IHJlcG9ydHMgKENQVSM0LCBrd29ya2VyIHN0dWNrIGluIGJ0dXNiX3Byb2JlLT5oY2lfcmVnaXN0
ZXJfZGV2LT5xdWV1ZWRfd3JpdGVfbG9ja19zbG93cGF0aCk6IDI1Mwo=

--_008_SA3PR02MB999408EB34A11AC1312F4121C4B22SA3PR02MB9994namp_--
