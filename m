Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=94.100.128.99
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792488788;
	b=xTOlzmMxhOgAGniB0W12pcbyXypZYmN3SXgYMinBKxS2nvgEdqRzOLsHY5jgg9H4uDTX
	 w1J6ce3O0TGP1Q+Dpp1xIzZfmWsvlaONOzPaZmnqDlPYjONiAsnC/JYj3NZli8kAl0CD2
	 X+NXuC+UqyU7f6X8wRTPT0PFwZVIRArjx2SdXXKuSGDY0np9mO2SiwvYMQ3yknOh9jIK6
	 2PNfzdoxhmSN++Kcksz+SU578teD4JqiDPwsTN50GZqVfFFVm82c5CVXxLLovwA5pmy1K
	 +ImxHtXUo1oMoAi7ydBgCQmTZbZgjTtnI1jj0pyTKkw+UPzQbQY4JCMME0sVKAssQrw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488788;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-transport-rule:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-cloud-security-sender:X-cloud-security-recipient:
	 X-cloud-security-crypt:X-cloud-security-Mailarchiv:
	 X-cloud-security-Mailarchivtype:X-cloud-security-Virusscan:
	 X-cloud-security-disclaimer:X-cloud-security-connect:
	 X-cloud-security-Digest:X-cloud-security:DKIM-Signature;
	bh=WV40d2TwBS1oKI/kHuVo9QvXYJNyk8YkZxiIwNKdyLc=;
	b=WHcirMC4H+TkzFneF5yr55u1JQ2h2lYKC8vV/9PCXU/aoRou3DQiKK5ElPN62baLKESq
	 6/RFZHtDM03ZRsVzsj+lJ3D9G4qcOC5zgIhUOd8KO3pmm/1PNXDbZsg2i9EQysii09pb1
	 vwOJXY+c/U+kyrrxkwzirq5kpZfNWEq3IEfrpuOgpqMrpriqF0ls7jT/WfvqnLfOJ49rt
	 /TFPAleJb1VZLgaL11u0KD4Pw/F6t2qTTdOzQ4a2PB6lKWwItUu7GWZmGpktoL2QDdHDU
	 M9J2We+Uo0bUpYRMWTTVCFlxmwTer49KHogJh8uBaCKKKcwwovL0I3s69uYwJv6R6GQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hoffmann-group.com;
	spf=pass smtp.mailfrom=hoffmann-group.com;
	dkim=pass header.d=hoffmann-group.com header.i=@hoffmann-group.com header.a=rsa-sha256 header.s=hse1 header.b="AXVkc/8f";
	arc=fail smtp.remote-ip=94.100.128.99
Received: from mx-relay89-hz1-if1.hornetsecurity.com (mx-relay89-hz1-if1.hornetsecurity.com [94.100.128.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0E606A319
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 09:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B0E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hoffmann-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hoffmann-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hoffmann-group.com header.i=@hoffmann-group.com header.a=rsa-sha256 header.s=hse1 header.b=AXVkc/8f
ARC-Authentication-Results: i=2; mx-gate89-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=52.101.66.111, headerfrom=hoffmann-group.com)
 smtp.mailfrom=hoffmann-group.com
 smtp.helo=duzpr83cu001.outbound.protection.outlook.com; dmarc=pass
 header.from=hoffmann-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=WV40d2TwBS1oKI/kHuVo9QvXYJNyk8YkZxiIwNKdyLc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version; i=2; s=hse1;
 t=1792488776;
 b=sUqJA/OHH2gfygKI7ROr+qC4RpTloT9MlJINhwugVo7GOyPz5MP5J+3pKyp5u74nponvQvj7
 bUj0r6Y+KN98pSgvEnjsaBkXt6bk+crByRWKTTI8qLAg+tgjHdIPgOSdF62uej8/fBFiFNx386J
 9yvq7uz4wmVvs0pXWHteavBMMTwKbGuPr3OOmAmScyw+BmBL2WWMdiPVjjyBQx1AZOFTLva4T3C
 Xv4YnGG07p4XxH3Vp+dmJfjw0AKwQcVAQUJz3NxsfNSATrnzuxt3VMQgfRGp425bs84McZZxmR3
 K5XMoHKelDiFvNcKP5c86IuZxQRuaPFyifN6Po1XijSJw==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1792488776;
 b=TR8WHuUthhPS+tVnyRMT0O8sOj038K5MdJQoLwyie3zESW4ij+HLW9fKQq6vxq9ha2LNFRlc
 1/rH3iDY21vmNudodC94m/DlxWThIIgdNxpBtf6xIjd0+fK0XaVOw8/Pcy8kFjAB7U7/abdmEXw
 5IHVI1fXh6+Na2JdwaLYUfX0ywZuoYWw+YRnAtiyAZ4WHM6GKw8zRGhkM6cfwuTqCb4t3nq8DBA
 1PRB2Uzgq/GuQZX7W28S8eg9eY5xmvIxitlnxXTofN9LpbVLLcxyqnht+aSZknXfyA3btEbBOts
 24yPf53s1VgXXP/rdJXORyDPQHWuQS/gT8bIuba05C2Bg==
Received: from mail-northeuropeazon11022111.outbound.protection.outlook.com ([52.101.66.111]) by mx-gate89-hz1;
 Tue, 20 Oct 2026 11:32:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh0bnMq+nbav61DywY3Ah+4j5bIrRD9lMD/ecpkMOg0xcERdVrW8F3mKhstssulLjq2Ahm7uuoyufdLAtVE9S+pPSvYCBagkh6ygRxIKEd62fD+szVh07pq3tVmDZ4s9t2pgWsNiWvv2BxHoQkx8WYhuxefpzntj3N5lkuyurBqgYq2lOzsniwqcwwikli0x2IwXb293X3SLf8zgXy9Uq6TJBvFFzHbLx7ckFa3wWBtb1cTb+fV6ApUbRsq2vwm2B04omeIU7qGvZorm0HFb0PfDyuLSgW5YYuMiFOziNZaH3E2aO1asKjZIjXeTfmTBsnBl82YEs5VAmWa+3h7XKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV40d2TwBS1oKI/kHuVo9QvXYJNyk8YkZxiIwNKdyLc=;
 b=GwOB0OE6hV9rpY/u1VcKYHfxTh9eHzgrPK+POjQjWEIThRNin2ik/llcuLI7f5vGxnYtgyf/nOj8mv/cisAAIkdqAy84ParDCFzwfNaTq63n/nsx6qLBBDAQbtoOLp6DOp5J/xRV4sBqi3WrN4xL0X9NaSHqXAeuxyttwpxShv9bHJLVF5vTi+Ef5Dovg522MEv2JW0tBCv8bcgmbEv3NiYQp57WCejP2YmhEi9vDLZp+LCuJR5Ng4oXs+6y+2tIJaqu/k5D2fexORBr39PvqGDzCZKiR689XW8ipO4HT1ZiQ3esMwpnlzFDScDfaTm3tKeHhIFREot3AH+zLB2y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hoffmann-group.com; dmarc=pass action=none
 header.from=hoffmann-group.com; dkim=pass header.d=hoffmann-group.com;
 arc=none
Received: from BR2PR01MB965253.eurprd01.prod.exchangelabs.com
 (2603:10a6:2c8:8::23) by AM7PR01MB7122.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:1b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 09:32:43 +0000
Received: from BR2PR01MB965253.eurprd01.prod.exchangelabs.com
 ([fe80::bd56:eea9:9d3f:8a3d]) by
 BR2PR01MB965253.eurprd01.prod.exchangelabs.com
 ([fe80::bd56:eea9:9d3f:8a3d%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:32:43 +0000
From: Schober Roland <Roland.Schober@hoffmann-group.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Plans for Periodic Advertising with Responses (PAwR) in kernel/BlueZ?
Thread-Topic: Plans for Periodic Advertising with Responses (PAwR) in
 kernel/BlueZ?
Thread-Index: AQHdYHW6Rpc0oHg7BEyFYyTbihg2lw==
Date: Tue, 20 Oct 2026 09:32:43 +0000
Message-ID: 
 <BR2PR01MB9652538FB65DC582F4A6C4DE80BA672@BR2PR01MB965253.eurprd01.prod.exchangelabs.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_Enabled=True;MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_SiteId=bab8ae91-c774-40ac-9d72-282d0f55f03a;MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_SetDate=2026-10-20T09:32:43.150Z;MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_Name=Public;MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_ContentBits=1;MSIP_Label_cc64dcfd-d02e-4bc9-8e4b-d225121e8391_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hoffmann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BR2PR01MB965253:EE_|AM7PR01MB7122:EE_
x-ms-office365-filtering-correlation-id: a78b0315-7841-4498-b93a-08df2e8d17c5
x-ms-transport-rule: HOG-Outbound-to-Hornetsecurity
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|18002099003|10067099003|3023799007|38070700021|56012099006;
x-microsoft-antispam-message-info: 
 PyJ/zh1SbRq507Di514VS0u16F2W4rrWDc1+RbBL9/7Om4iGOC7ivGOrISdGPvxqvXJkekLj4CgNN+u/qXIg91N05VhTauMeIRREU952Z3EVbir2TWgsO4pdi2OpsD/9z53R9s1xym2UEibwCI+uPapUoGMR8oN+5+NDaL6tNi4pm4p0Jk5vhlyjrCdWAuKu22WMCxyl89/frVskBG5o7EzAyJ4CGPZiYYV6ntP3LXn+UaXmINsbCa28IU6aM2hjZLtRY1mZpuIAG+QZL54L+sbDfNXmrKlkqZ1d/VuLb8ShhIFMS6KWqdBvT2Pd1T5yp1tYt8JyZWHsbmQjNUty6udUv1OtyBWTf3eyOGnwA57zaeiKFBtp75xfONrFfFkFTJnJ2Ojs5froUvU+QgMwadFjtqHxdXOtzNAhTmUiJOKUPQxzI/flQ5nrohU83cDAexbZhXUOpzMTFdWKbJ+WFkCU+c4wBzH6hxVWaFUDwvgSjhgIlZtkMn4JOvk9NwBAyiK4ONAADaa5Q/mBa2f1mcmHNhX5/CSSGl4t5mNNEeXo4wBy39isWx+73/Lpj0Ic6SGavXStYpRzs3SBSPg7Mv6jxhlsS9Sd1kyPetHW25B+BnsusXUUmoZwZv56mSIx4j8OZVhPCtWWjcTSdi/mRIe7nMsLtgDcgAQy+rpa+Qa7XrCbfoZY4CJw3BhihITqybpmaAwig5y4JkohQS+tI1Wu29sSikcEumEZKRofxVQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR2PR01MB965253.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(18002099003)(10067099003)(3023799007)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?6GFTPL0YoTpS4JSxXnTjPl94gVd1bxyHRylQpkmpiqUSkJ3FgC0eMl+6v5?=
 =?iso-8859-1?Q?9EE2HD/aN+xI4T0T/YncRb89foWFW7S2WmuMXBjq6gTRkxIDmpitvVNYgp?=
 =?iso-8859-1?Q?Yu1ROYIKTEjZz7LUuH1ucvCh9sIZSfhbig9sfDiH7jE5MHqJoxCiB912pa?=
 =?iso-8859-1?Q?2pBcR/5L1wJSwdd7LaaNk+25QBtlZ5DzrMFnPU0+oOPHDfYZTZWXcEmKXF?=
 =?iso-8859-1?Q?278iVMNwYJ3hjVuUWD6+jqrMcfiFNHSKhvSt2SFVGHuc0iXAZCpsLnw96A?=
 =?iso-8859-1?Q?UA88FB5xg1qCzXYDry5MyuHhJ68L/gfwrQwv/yPv3oglxaFdTi2ioOFXAW?=
 =?iso-8859-1?Q?PBSHK9zq0uQ+FIhOLTpzvT1kPF/PCiprS2QvQ6atwRRjNUuvrigBhwA9z9?=
 =?iso-8859-1?Q?umaeeGj+whuKDOlLtsTnD7wtpOG8Mol+AdX3T339GaYH6UdHAyL+EKnNJu?=
 =?iso-8859-1?Q?Ce0sBHo0bKk5D/NuLzbFuuAEfVOAzrm1jx99QycxUP80Rn48+i/x/VoIMm?=
 =?iso-8859-1?Q?E2UhcmH2zAwnxNgeC3BUJkPMKPwcLNFzHf455HOSKu4h/iQExcrJdJ+EpZ?=
 =?iso-8859-1?Q?ayNP/4kMJrRKY7JLNoFc7UQWZy1oIKsGElr/Hx4R70QhfE1lQgAQaIK3IY?=
 =?iso-8859-1?Q?6O7UZBICZ4Petw4e594fmI6QbKvfeTOWPUryJwT4jBeCwWC2nwruvlFlSY?=
 =?iso-8859-1?Q?IQd5BkopYxYUaM/H9eplRiwmontJPov6iXURhLCRmolzoempbMPrhuM8Ty?=
 =?iso-8859-1?Q?udDrgP3G3500sbhy91jcI0S34itqcrGbGrxVZgTWlk9Dn1wMPzgMKD8DYx?=
 =?iso-8859-1?Q?ok0b+Y+giPM7Jf3c/KkqMWyQSP1tHCz858PrsWCu5urS0/ucOvXqNuHLqJ?=
 =?iso-8859-1?Q?1eeVFk3KiEczMJS6WDOrAAojsLscpFZfMX+gbmjsiBeIH2gnL5TRmE0cR5?=
 =?iso-8859-1?Q?0LqS4CJWXO4Llo9rUOCs/UgkszAAMZM+QnH7Z6QLcJ+cHVzcVS0BLWkgI+?=
 =?iso-8859-1?Q?L0k8CV2qsRO6SF2HH0U3ytcL+nDl1rtv014I7ZjVJv5tofLRgESqLBGdCb?=
 =?iso-8859-1?Q?qjtB1sCCyCKFCq9YUwVYURtAg7cyXZ9hgEo+ypRFMQOR6wQ7U51r403R3j?=
 =?iso-8859-1?Q?QQLCSHg64EZFU57ymQ3wR2fwELNzzk1QRrM+YOWDz+8dYvEPGaQT3M0vYI?=
 =?iso-8859-1?Q?ZSKVSyWov7DbXkWgD1zX90cx+CFbtma4EVOpKl4DffOyxI24ZJ/Elh6qZZ?=
 =?iso-8859-1?Q?SbcB7b26awP79n2DBrvKvMsZiRl2zCx0jSlvldW8Y5eMFOOniZl+Znr8uU?=
 =?iso-8859-1?Q?8DPAo1aHfevD+hhOV6OVI0CUScqWid5VwbmGHRdKRPncv0jjfi7aao3+XL?=
 =?iso-8859-1?Q?RMBX83m+pM5gwUA5QinhqTqA3bPVb8vD+AONpQtQSw2EFkkqhb9lth1Hgv?=
 =?iso-8859-1?Q?O4KWDo+UbcUBy895r1B3giwqiQSDnVp15aZsjYGJqUseEvblczhasGP1nL?=
 =?iso-8859-1?Q?rX+MBIEH3gYJ6WKdPyo/SZK73U3WlVOeSDIdH3HJ1DkQoEATH/dR9OW1XB?=
 =?iso-8859-1?Q?y+W6zZeyvOK9k7COvQSKNQFbIqSPXZGGun83Qp/NkOS83AWP4/7hfvO2wm?=
 =?iso-8859-1?Q?G5M4EH6FBgCzWKep78pTbpRhzsVyZkQaE16ZqXLWlvkCix1UINyVtPI5Tt?=
 =?iso-8859-1?Q?cxoTGNhsIbLhw6x4M411lcXdmqMfcDRQJTDs/8sKN1TRpiXgPjue0i8x8N?=
 =?iso-8859-1?Q?4pWCam3Y2sBibw242giY6AnQZHo9Cae5tU1Lmr/f4l1odrqUqwk5wOtbdB?=
 =?iso-8859-1?Q?b+nKrouoXwZDVclsekF6kvYpkeiu5J278b8EaXHz1q6XTfNP+zJhcyhyCc?=
 =?iso-8859-1?Q?Zl?=
x-ms-exchange-antispam-messagedata-1: Kh13JNR47mgV0/8yr7OyyFvVbXF03T5MzbQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 Sg8Mk8DngVakv0A7UKCqwqfBCtqoQD+foT8yqpR0R8VgguVuMrImAIDyUjbUuBD/b9d3CHTq++z/fCBZ/QaCpajyna6kZd5WhCgkmWrPi3Cm0wA4D1hIxzDOaxWFwXaIEvpirzvllc3ApVjcYOizP5Mm6TEycsHgL9P/zWgPxRx34HX4jMe6jqZ8cKNzsSV/j9xI2fMK6/60F2fMbMMeJB8xuThe3BIfaYyOHf9yZa8di8Ii6+qHzPPNbdvlQrqCmPhx6UItTti6bQ7lxW/ktoUnH2sIF/IyDANDdLXn8NE20idcdwFdFhQ9+gOsXReWwExT8Gu6xX6TZCOzZ1v2Hw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
 +n4waDJsPK91azI5jH/kxYJj1mo60PutSwk0MuWDTBQ9Yo1h0KSAMPGyhW7k6bP1IAiBFnNq5V4Rh0sV80APl0aES5xjlT4TYAA+qkxQ+jqHErqusTjIaUQ/jVGOdWgkE1Mpcph6WASrXtwozbfWJPsYti9mOPNwf5sZd9vRUJ6lKOi7X4ZZUmLFT8MkoexOaRdy0uBdB5T659xOJagaKQosUdyGiVqTh/agHMQgO+T9D0ZZ9WZus9DHPGG6ggDexrynrKnTXtZFkD3zlgftlspVSriG7/fwvB0f/X7cCVP4kErUjOLUwUcFXwFVy5fjVdorpM7HTcfdqrNyX8hNu4Vs1CtIdi9EBPSXBJNPJ7QU0DQufbnIyGUPyVaphSeVLSUDURghEsxOtQWdNMIIr7fkoex/sUWs3h4xKzZhwNE1PxHyH24OEhlhf2fLPhFHTUOEmV8RYBjOeABieaTL179ODoLJUmmJd9/j8jEabACjpwKSOw50bmItUqkR9iUt7jvGU37smDbr8K5N/5JAZnoAfBnhJvY9c4MnR6OyXbWFWp1LIh7qHsNHs+1JrvbRv1QkI4fXbvOyVqGnaUk+JNkI5bVpsglnR6egISSrMk9yM4jwq4SdkszH5OwY2dklex2Nid+sMSTL6M04VAxPCA==
X-OriginatorOrg: hoffmann-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 BR2PR01MB965253.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a78b0315-7841-4498-b93a-08df2e8d17c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 09:32:43.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bab8ae91-c774-40ac-9d72-282d0f55f03a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 RcRWRJ1gZEs8mZweaAwbOsaTkCjuBLNAOIV1/L7nFn/XuW4Ti+Wz9k9dsHLQlQdynP0SnpT0NlQDKGYNFf9neYWEu6J+7301sUZHw7YSc/5m6J0twwHwQKqWLOYHtrpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB7122
X-cloud-security-sender:roland.schober@hoffmann-group.com
X-cloud-security-recipient:linux-bluetooth@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: roland.schober@hoffmann-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-gate89-hz1 with 4j86dp6YbNz2pNxt
X-cloud-security-connect: mail-northeuropeazon11022111.outbound.protection.outlook.com[52.101.66.111], TLS=1, IP=52.101.66.111
X-cloud-security-Digest:eaa640c38f31fb1f26aad3027ba6daae
X-cloud-security:scantime:4.478
DKIM-Signature: a=rsa-sha256;
 bh=WV40d2TwBS1oKI/kHuVo9QvXYJNyk8YkZxiIwNKdyLc=; c=relaxed/relaxed;
 d=hoffmann-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1792488775; v=1;
 b=AXVkc/8ffH/x5zbd6n73QHG3ZGwt4VhjQg03NvE9xFMV6wIZ7p8pV4jAgql/5PquOlGae/wy
 AXohfooyyDV+RtrcsQlx3xQmryykaVQAC97Etfg8QTo3Ye6vR7Ig0VysSOOTXWsSMbC9RkTU8gt
 Op+v1lpXcsMOW05dj3hB2rtug5KNMV3PGIEE/5FFG650+NYQp8XoHi70+4gkdVbuvgLs1W2CI+7
 HJS5alDwBEOXnkKzJkyfq6bJrixd7TGPYJK1xeJXSEX7WPUuSFno94zd5E8Mr980okHnP8moXBy
 imQRGrockSd58iiNJXnrsWndCXx+CajYJYA2NemYu0Wew==

Hi,=0A=
=0A=
I am building an embedded Linux gateway (NXP i.MX93, kernel 6.6,=0A=
BlueZ 5.72) that should act as a Bluetooth 5.4 PAwR advertiser,=0A=
similar to an ESL access point, serving a few hundred battery-powered=0A=
BLE displays (nRF54L15, Zephyr). The gateway would run the periodic=0A=
advertising train with subevents, collect the displays' responses,=0A=
and hand new displays their sync via PAST after a short connection=0A=
for pairing.=0A=
=0A=
As far as I can see, neither the kernel (no PAwR HCI commands/events=0A=
in hci.h up to current master, no mgmt interface for periodic=0A=
advertising outside the ISO broadcast path) nor BlueZ (no periodic=0A=
advertising in LEAdvertisement1, no btmon decoding) support PAwR yet,=0A=
and I could not find patches on the list.=0A=
=0A=
Is PAwR support planned or being worked on by anyone? If not, is it=0A=
something you would want to see, and in which shape? That would help=0A=
me decide whether to run the PAwR advertiser on Linux or on a=0A=
co-processor.=0A=
=0A=
Thanks,=0A=
Roland Schober=
