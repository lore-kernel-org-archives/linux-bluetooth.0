Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794968810;
	b=Xh6/1rZi+HRUtCb2LC+IiZV7T2n9D0nKvRr35kDLl9404JzsyckGnFfeZCf3dkR3tqrE
	 J/ooelb6NNVRI2MzMjEXEcLsk0ZdbnvbFHhGaO9eVXB/8S/omKXeVFKgc1At1k7/jU79c
	 +zbaz7EmI6TM6RhJZ0bsn0UsA6x5yTCb+PQ3N3KNoh7oTpkmamp1f0Gvd5itjcKE66OOW
	 hRze7D6VY3alud0b+sJNVCET0enSIY6/c6pBUx11sYqvROMaCQs+MDNHaFDP7bGKz7Ezm
	 QH8W/Q0V/a08bS4zBEyZq8Cri9yAxOqsPbXQqbCYsDuWy3Jy2J37Ui8J5Glr4mK4dmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968810;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iGy2iFQ6kfqYNMpbjzvBQTdM25mE/7Ei4jil4TRrNqg=;
	b=f28Lp60V4vALB/mg1o7E1AA7OCxKqh8XTgN1j7CYKvxcnouvX5DB1PRPVDCa0Dm6xpi0
	 R9V2YIIkjnvZg/ToVow7uXThUXa5f6AfIUb1x0LhidERR99Vf7rX/VsAUZ+/jv9DUIlds
	 cskR5pLDVjIdd4fxmX+6xmHizkoBOmLu27fd9uy6N4TCxRD7YaBd8xkJyZ/SV4Xnc9I92
	 /+ESeyYo2VDew848V52GqjrIy/49B/Ck8hP6Z+XTBp3sodbY2SVvVfqjZlOVT4xJK2ZMq
	 +9t9aH2xKQMVnNG5SRfyC74Qc1tsTp/PyaGAKw8WlkNQz+V7enWhAYjst4vZ76m6dAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tymphany.com;
	spf=pass smtp.mailfrom=tymphany.com;
	dkim=pass header.d=tymphany.com header.i=@tymphany.com header.a=rsa-sha256 header.s=selector2 header.b=gMiJWAjF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.126
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A8606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F3A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tymphany.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tymphany.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tymphany.com header.i=@tymphany.com header.a=rsa-sha256 header.s=selector2 header.b=gMiJWAjF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBeugPItWZlOSd+3YzSysAwU5T7akxrh/VxbeSLorZ5NZC9xHsEWMyIHxH1J/wigdVD64ZGvJcXNwEFhcwA21tC44ChIlVckjT5PRt4FpO+bxkaE7bBhpwtN7JyrVsjbPETXcgSopsEHgSVseusMO9jWEFd1TnxZIctYPvO9e9t7g1RwFCY5LnPToof2QlpjLXVguHHrqGV+XXLhIHTBbHKFHLpbpqNCNwNSucJBPv+iyW/dGFeohFVH5wYiPD++BFVCN6M97+WjEkm8tBYYmlxeFX8qzNpHNvKzwE6GRXN7/FPOxYNFh1YEzG0JZfdnK/eP1LYuQcvtxK5tXqp4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGy2iFQ6kfqYNMpbjzvBQTdM25mE/7Ei4jil4TRrNqg=;
 b=DBuRIlSFxururZdVDrhsyqJ+VhXfT4jmXaSo0EJ9yt2i+ZoTRjQV5XhEKO5wdQOXZDwK8pK6oS6UfSnGhoObu2uRoW+poG0KDLrd4JeojkOyiNAyTnRyxUfKhG4x1QYkt0N3HLkDafax2feBQuMCQ3ZC3/m1F8+7l5u+K3OSr1+BUtma0ZwqVTbT/pC2LEHUYnvmb8aJRPISlxgTS+l+e0r3tmRdfLCK3LWKqobLVvyNQdg1uTsW32i7kD4LTZ8PMATMOgfkeG/Os1vaqH92odo7pDYl2Bt62kSD13yDwtCLN4DxnmL40AT42v3rcOArzPj0l/TUsh35kgy4IE2ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.165.80.2) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=tymphany.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=tymphany.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tymphany.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGy2iFQ6kfqYNMpbjzvBQTdM25mE/7Ei4jil4TRrNqg=;
 b=gMiJWAjFKYvsMeYdIHD4Kli3EKCQCBIU/Ro45mkkgf+Sj5IcM/1OVUv9X0HRLUqPJySTRNLXeA+jJFNsB/Q3Ks/A7qKmYTSxhE66DVnEgveFw0+9ngo1W1zYZBTSGfz9E0C3Hyd208dY9kj7KVK274PrTgPIHk6OS9e7ujoWpwTeaNOubMycYkyf9ERtjIS0uYMvn0xVDZ70JjAmm8JsTnHWJjISMOgG/Lw5gbpjpKcPAjDI4BAiJIlF2sVCO1aAmBMygtDWV9SqMEy1GC4Ym2CPQeAguhLbPUbGESBqvJsw1YxrbHqdwmLndymoNjrswHsQFceFj8YRtsdetuYOQg==
Received: from SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) by SE1PPF5117CCFBC.apcprd04.prod.outlook.com
 (2603:1096:108:1::514) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 02:26:46 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:191:cafe::97) by SI2PR01CA0018.outlook.office365.com
 (2603:1096:4:191::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 02:26:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 103.165.80.2) smtp.mailfrom=tymphany.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=tymphany.com;
Received-SPF: Pass (protection.outlook.com: domain of tymphany.com designates
 103.165.80.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.165.80.2; helo=mail.tymphany.com; pr=C
Received: from mail.tymphany.com (103.165.80.2) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 02:26:45 +0000
Received: from TYHZEXCPAP2.tymphany.com (10.12.20.26) by
 TYHZEXCPAP2.tymphany.com (10.12.20.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 18 Nov 2026 10:26:43 +0800
Received: from TYHZEXCPAP2.tymphany.com ([fe80::240a:7d57:2653:1478]) by
 TYHZEXCPAP2.tymphany.com ([fe80::240a:7d57:2653:1478%14]) with mapi id
 15.02.1748.039; Wed, 18 Nov 2026 10:26:43 +0800
From: =?gb2312?B?SGFuayBGYW4gKLeyur0p?= <Hank.Fan@tymphany.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: =?gb2312?B?SGFuayBGYW4gKLeyur0p?= <Hank.Fan@tymphany.com>
Subject: [PATCH BlueZ] audio/avrcp: allow early VOLUME_CHANGED register
Thread-Topic: [PATCH BlueZ] audio/avrcp: allow early VOLUME_CHANGED register
Thread-Index: Ad13A5nNGymH7yU5RLCpQoUZGsfWJA==
Date: Wed, 18 Nov 2026 02:26:42 +0000
Message-ID: <8ddc3991712943d8bb45bb4512075ea7@tymphany.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SE1PPF5117CCFBC:EE_
X-MS-Office365-Filtering-Correlation-Id: 423e6e7e-a039-4150-9262-08df451b645a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|13003099007|56012099006|261022075727099003|261028144727099003|10067099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261021135927099003|261026140227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	9QUmQ9JFcA8q7xnWlRGRZyT/g2aLt97akg+chERlNW+KZWppfzI1xfqH29g+Jcsj48xaxtzrMPFAB0yQo6vK/XMl2FhT+kVReuKtc51YO9oeinrf9SvwJugMrEuvsTJAXTtleWVd38/nhRaUgsxmDeca4aHkNRp99okMwRrO9ChF6H3dYuBo20dGhZd0I6xm2he51Nll/QeY5xPsyWiAMgxmdUE7tOuRXjo2vYLYj+mQfwHwT38A03ISWd0GJOD4gIs+oA+tOSACZCqPuaJzzozWrXVkppQACh/CwzRqf1pd9F9hu+zeVdTRuzXac/AH5nRaxT184FZBGEtfNeh5Xcld0Bj5SumSCRfYPRAZW5gzOMuMwjswexmhvtVTFfHI9RUhbRNjl50OBTIjLFu6yYVDF7ma62vmBqYaekK7QskVQjpBZAsGm0n3fPZ0BIZzYEhpyvIO7wa1Z6DtxyC05iqSYr38SvXvityG0vkGL6k8TjuUhJwJv1ns5sHof03yCDsYr9vZfZzmO7+SwOZRYch4U4ug9dmIuIVt8fcCuMfCvbVvCHJrYoPJfseTXUuKOx8TMr6O5Pk7ixRzfQXecYxTTEzubDq2BpjRqKVZfM5CNA9uHruPUdQP3LEPP78uq5GnR13pE4dvsQ+MplQCqI08pxoqdI8vmtbrymGu+wPnl8DNrxz9XREx7ma34Z+M3sc7vCoUVVyFUwfbqQfaSQ==
X-Forefront-Antispam-Report:
	CIP:103.165.80.2;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.tymphany.com;PTR:mail.tymphany.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(13003099007)(56012099006)(261022075727099003)(261028144727099003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021135927099003)(261026140227099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QBWiWUoDU3aMF6lKy06csQYkzQ1uGpJq+jXAuZt5WM3L1iJBmoVFie8boctTjJfZTGWAri9IBCBponyGDsNuagC91nJVk9P8u84U88LRiRTSleehDzEwOrI81MeZyb7B7A3DoOw+M79bb+J2qA+k0EL8+20a/fAOssQGddJWbOWv77t4lJv49xTMsNaHKr7a3kZltXnkcuz+Ql7t0ZVZHJ7GAjeCjNS3BLxIKuwfBJZDfYhvL27qUlm0lqBJGgh1aJtKUBr7zn4x9cVvbtAmRfD3W/fWnNwcSlAZtmsLQ5vnMAwYU95c3P0l9mvzbD5eH1pNDUQEvTdm+68pvwHvVN25n362r23puii9QGbRLe0Xd8M4BBU3La1k5ZWCK3yVDFDekvtDqWF1K/UCLRx/A0QhqFdk1ohNfSxMZ8yRgnw1ZDk9WER+8UNNVRea4ShL
X-OriginatorOrg: tymphany.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 02:26:45.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423e6e7e-a039-4150-9262-08df451b645a
X-MS-Exchange-CrossTenant-Id: a0771152-a77a-4639-b170-34d5a9f863d1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a0771152-a77a-4639-b170-34d5a9f863d1;Ip=[103.165.80.2];Helo=[mail.tymphany.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF5117CCFBC

RnJvbSA2MGI0YjUzNTZkZmVjMjIyOWI0YzNkZjhiY2MzZmVhYjA3NWQzZDNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSGFuayBGYW4gPGhhbmsuZmFuQHR5bXBoYW55LmNvbT4NCkRh
dGU6IFR1ZSwgMTcgTm92IDIwMjYgMTQ6NTI6MzggKzAwMDANClN1YmplY3Q6IFtQQVRDSCBCbHVl
Wl0gYXVkaW8vYXZyY3A6IGFsbG93IGVhcmx5IFZPTFVNRV9DSEFOR0VEIHJlZ2lzdGVyDQoNClJl
Z2lzdGVyTm90aWZpY2F0aW9uIGZvciBFVkVOVF9WT0xVTUVfQ0hBTkdFRCByZWplY3RlZCB3aXRo
IEludmFsaWQNClBhcmFtZXRlciB3aGVuIG1lZGlhX3RyYW5zcG9ydF9nZXRfYTJkcF92b2x1bWUo
KSB3YXMgc3RpbGwgPCAwLiBBVlJDUA0KQWJzb2x1dGUgVm9sdW1lIENUcyBvZnRlbiByZWdpc3Rl
ciBhcyBzb29uIGFzIEFWQ1RQIGlzIHVwOyBzZWVkIHRoZQ0Kdm9sdW1lIHRvIDEyNyAoc2FtZSBh
cyB0YXJnZXRfaW5pdCkgYW5kIHJldHVybiBJbnRlcmltLg0KDQpBc3Npc3RlZC1ieTogQ3Vyc29y
OkNvbXBvc2VyDQpMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovcHVsbC8yODQx
DQotLS0NCiBwcm9maWxlcy9hdWRpby9hdnJjcC5jIHwgMTEgKysrKysrKysrLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
cHJvZmlsZXMvYXVkaW8vYXZyY3AuYyBiL3Byb2ZpbGVzL2F1ZGlvL2F2cmNwLmMNCmluZGV4IDJm
MjE0ZTk4Mi4uOGRmNTY4NWQ4IDEwMDY0NA0KLS0tIGEvcHJvZmlsZXMvYXVkaW8vYXZyY3AuYw0K
KysrIGIvcHJvZmlsZXMvYXVkaW8vYXZyY3AuYw0KQEAgLTE2NDksOCArMTY0OSwxNSBAQCBzdGF0
aWMgdWludDhfdCBhdnJjcF9oYW5kbGVfcmVnaXN0ZXJfbm90aWZpY2F0aW9uKHN0cnVjdCBhdnJj
cCAqc2Vzc2lvbiwNCiBicmVhazsNCiBjYXNlIEFWUkNQX0VWRU5UX1ZPTFVNRV9DSEFOR0VEOg0K
IHZvbHVtZSA9IG1lZGlhX3RyYW5zcG9ydF9nZXRfYTJkcF92b2x1bWUoZGV2KTsNCi1pZiAodm9s
dW1lIDwgMCkNCi1nb3RvIGVycjsNCisvKg0KKyAqIENUIG1heSBSZWdpc3Rlck5vdGlmaWNhdGlv
bihWT0xVTUVfQ0hBTkdFRCkgYmVmb3JlIHRoZQ0KKyAqIEEyRFAgdHJhbnNwb3J0IGV4aXN0cy4g
UmVqZWN0aW5nIHdpdGggSW52YWxpZCBQYXJhbWV0ZXINCisgKiBicmVha3MgQWJzb2x1dGUgVm9s
dW1lOyBzZWVkIG1heCBsaWtlIHRhcmdldF9pbml0IGRvZXMuDQorICovDQoraWYgKHZvbHVtZSA8
IDApIHsNCittZWRpYV90cmFuc3BvcnRfc2V0X2EyZHBfdm9sdW1lKGRldiwgMTI3KTsNCit2b2x1
bWUgPSAxMjc7DQorfQ0KDQogcGR1LT5wYXJhbXNbMV0gPSB2b2x1bWU7DQogbGVuID0gMjsNCi0t
DQoyLjUzLjANCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpUaGUgaW5m
b3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgdHJhbnNtaXNzaW9uIG1heSBjb250YWluIHByaXZp
bGVnZWQgYW5kIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbi4gSXQgaXMgaW50ZW5kZWQgb25seSBm
b3IgdGhlIHVzZSBvZiB0aGUgcGVyc29uKHMpIG5hbWVkIGFib3ZlLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSBy
ZXZpZXcsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBkdXBsaWNhdGlvbiBvZiB0aGlz
IGNvbW11bmljYXRpb24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBieSByZXBseSBl
bWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLg0KDQqx
vuBdvP4ouqzL+dPQuL28/imw/Lqsyty3qMLJsaPXb9LUvLCZQ8Pc1q7ZWdONo6yDSLmpsb7gXbz+
1ri2qLXEytW8/sjLyrnTw6GjyOe5+8T6gUu3x9a4tqi1xMrVvP7Iy6Os1YjBory00tTritfT4F28
/s2o1qq8xLz+yMujrIFLjKKxvuBdvP68sMv509DRfdOhsb6EaLP9oaPViNei0uKjrLfHvZvK2png
o6yHwLjxvfvWuemG01uhosmisqWhosmigdG78tF90XWxvuBdvP68sMbkg8jI3aGjDQo=
