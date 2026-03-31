Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023128.outbound.protection.outlook.com [40.107.159.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A73E0C4B;
	Tue, 31 Mar 2026 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957942; cv=fail; b=KN1g7I2kQa9Kqlp/v+pnnzylVpRXpMVmeVemvpBvCCZTR+yDFzukSr4MlQZXme98aGOBiHuW9IogqkAEe8l8zxSTt4dfK3TvIU5JS3c6IecQ2emELhHERa52lFS32UGrFyoA4Bcco48luJjmDpjehvGJVsSmFTFPqH3s10vIy3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957942; c=relaxed/simple;
	bh=ALuin4UfC9tLMKBThLLmX3bHNekFLZs7bt9FJ+e7Kr0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UYoHXamVyZzxqlPVcLrMTBF27R40354jTJz1kOlYRPVVis130nNHC6c60UQvHOMKlRiBy5xKXqGCkSWaYMCdMteAljzYmVu5SgRO53k1f/SWVEG/+rCIDd5UfO8jTFTq4SpqanFAakAOtwF2Ibd7mj5tK6difMjoPq+xvHXJ/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=LqxqsqcO; arc=fail smtp.client-ip=40.107.159.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="LqxqsqcO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUX/TPBM5gjclYyPdxM+70Gg9f+5FfVh8bldiwZ5fDyjcG6sFZ0Z22DO9JqW6FdNNSGVMM9tPx7LxtwfjF0LPO19jfxPXfPsWE5CUFDeZmvwe+0Cmk9qVM9KRu4QHHUBaxSQnjCNzp4TSbzh1YbM1uXGZMrF7vjTzZNEmEQQUseL5ZJhoRBghvzPhhawy1xWd2EVzI0O08TjzNOdatVelzVsiHvHxzJjpmNqX8ZtmgjSkCTzw7jlAkWt2ylSyFpHc8dHTABexyE2Jdl5Vlpb5hnQ4fa/sEpbZb7bG2+nS6bCl/KpRaf5NmehwwqWfy7U76Q4kbbeLpFBVBAlJX4Itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALuin4UfC9tLMKBThLLmX3bHNekFLZs7bt9FJ+e7Kr0=;
 b=gi/8jJQuHZEHfB3KIsFyxU5/Yc0e49sHhqxcnx0Kv7CvDivEuwhc8ID0XYED6DL2/DLDl5lZVHv1OHQdOZOUmOjv6tGI0jwRTAOsK46j41vno+9EzEW3HoOTd/LDtonlNcuYUd+8oNNrPAl90lxdxe05BLNvD0QVnLWD0N1jFkgZjk+Y+4cDB4WDcVHyIi1QhO/tjUG+ETDRWcNioDHDLQF5LjTwL/tdQEPpw3sJZ8WYoYWNM55zY3+SWSstBlV8t21pHyyzCa4KBn1+1U3L7DvsdoTR01fxPwnmvdMqp5Vnk3VIprhZP9E8QnSBfxxZ8LRITOsrtHCNfpzYDQcyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALuin4UfC9tLMKBThLLmX3bHNekFLZs7bt9FJ+e7Kr0=;
 b=LqxqsqcOIzPc6h1aHk1aFheggaVGQE8MMMnXaE4+ob+jsraQOAGyf7vSdCmwTqZyGSk1UVd9qeOruWrOes9kKlUwcOhpqKU6lhgRvrt9faJItfAh/UOlX01G7D+23BxVqjgbdN1ghCzDgKPeO429G+C/RU+nN7X/AB0UuQIbMNUcScMkKuD5ughPS145y3p49qY2vXY8F9sdzzbPYWQwVSDnQP8jA0LeMsJWASv9WYg69AUtkt7YR+x017+TPV0XmMcNf9X8SVF4uZECs1d7XYLd/pUMOSwy3rO0mpxpuGOdHlC95RNqJTjOwcTBTw+hX7H7Z/0uPQdjQAzdDig5Sw==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by VI2PR04MB11219.eurprd04.prod.outlook.com (2603:10a6:800:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:52:12 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:52:12 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Bluetooth: SMP: honor local MITM requirements for
 legacy pairing
Thread-Topic: [PATCH v4 0/2] Bluetooth: SMP: honor local MITM requirements for
 legacy pairing
Thread-Index: AQHcwQTPqJIRUNCLJ0aqV85h4jzfvA==
Date: Tue, 31 Mar 2026 11:52:12 +0000
Message-ID: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|VI2PR04MB11219:EE_
x-ms-office365-filtering-correlation-id: 7e280958-a7a6-461d-ea4b-08de8f1bf239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7055299006|18002099003|56012099003;
x-microsoft-antispam-message-info:
 YMaVReICtUkZP7JlELsQO53EzHRZJ0a/3H3KLaL4A8Ylq1LH7wFaE6w8uq7iaT2dq9hPTWvPXFGn9NYkt9ITbQKqGFfQcNyYQ5Qy8EqLqaWWpkN5h7u+LlBS8p2DyEvVCv47VsD3taoiOecMbRlL6ZHwAveNW40yvCrpHb8hDNSHsI3Klbvt4TWHBySeR4XZouw5yXxjYZupzVZA+MCDpn2ByiYePCkDXsexoyt7IXfeOGgVliVicc3n+DFJiAzua57MX9JkD4z0Iq2VkcqoYl6+9itKsosnz0Tzzp+8OlYAVu1A5Ojr/cfV2fxp/drKGAlQ4ajaV+cC7pYsx/7GRkB2u3gqcsjCuR8m4/R2lbUGGFWEaxuFKkpCRYyjU7TllbapEpHnCPLxk5s3PXkDqtNUsuxD5IlVgRpmvNzorxRCDvbWEvAreDqDW2SYq89EcmdXlAb1CQindZ+SoS5m4qKu0Ht2GYwP93+1dF25st8H2r18mYTI5yR/35EY9uSYnB9cMV3w95PUnOFx4ehD1o091mLeVXXrukTlYIhtj5qSnde4gY7EeepUvRm2WoSLjR2YGy+ZZuL25RFHSJMXgXaLlTXLliihRed3u/ZSxtkHPj+LLBNIk0Je+/lHm8gn7IZ9zJS9pmJyahUvHn8MoPHKsPMN2Wyh2brAsItgTssQ1rEijJ7qmy4PoGM7TvabPPgGTDv8KFFTyzLFGA/2lhEZURPJW127He/e1Vlv4DaeXsq+h/Q7RkSuUOl6yc7Tzm7XDZYR0Dc/VoQZiZ60v4IUD7KFYWGIVhd+VpWVDWUvPILTKua9+5588W+mEWrT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7055299006)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THJSR3ROaTVSakVHdEQydU1HSXRWVkQxS0JwdmhWU0hlanp4bTUzUEZjdXRl?=
 =?utf-8?B?TlZFUndwRXk5d3dnWXMxcnk3dXl1R0dRalNCWnk0Q1JIdFd1TDVSTU1YN2JH?=
 =?utf-8?B?MmxrakdKajdlVlJFNjdEeUFma1pxK3c4c2UyNUV0OStrQzRpbmVzNnJjTWNJ?=
 =?utf-8?B?Yk05cEFCR2lCZXlBY0ExKzhqaEY0NDg4YW0vM0VJRC9XQ3BCTHlmQm40Vzg4?=
 =?utf-8?B?ejc0Z1dJbTRZdGk0SnF6aGFWK3NuTndsNE1oQWdGc1FZb3YzUjlyV3NROGZN?=
 =?utf-8?B?YmZzWmlqRHVUdFhnbzUzNU9mcWsvd24vamRTTE1BRWNLa0xyWnArSXRudXZI?=
 =?utf-8?B?RmxqbzFRRkNrWjVYTzRmNHJYR1ZGWXJZanZkR1NMNEcrdjFqazkvQStyb1hP?=
 =?utf-8?B?RVQvanRKU2o3QlJlek1rOXdTZWZnWXRFTU5ROERzcGh0ajZTZmRNcEUxVzY0?=
 =?utf-8?B?eDc1a05oR29tdHpsSWtvd0gyaXNIemJtb2dMb3pISWhxUGJkT25Cd0VPS04z?=
 =?utf-8?B?VU9HUUpjeE5wbGtHRitrdWJpZ2xTYWdRd0prTVpaU0o1WEl6alBINHU3ZnFC?=
 =?utf-8?B?VXlGRHdmd3VqYlpBN3V2dUIvcDVaYm9nUFE5Y3BlSHBvSTBCMDJtRWVjc0ZF?=
 =?utf-8?B?RHk1UTZVSURmeG9jK2tnSHdUTHNxTElLT1hhV2F0L0xiTUNpR3NqVVp4T252?=
 =?utf-8?B?R1I5SGFFVjV0YllMSW5Kd04xTXV4OUx3bTNJU3lYV1BTbVNlQWkySXJadFp0?=
 =?utf-8?B?b1g4T3JQbTJhZkgyYkFzNkdRYVNTZWJ3K2NUVU1uT2xvdUVCR1ExT0dBbXNF?=
 =?utf-8?B?eHM1cWpocVNFQkNnY2U2V2FHTHhZSTI0RnNzV0JkTUZzbUFZSThJZzFScStn?=
 =?utf-8?B?anFFUUZQODVLcUpyanlZaXhWR1dEbVlRVWkyNWVZaWNMZzVZREdGaHJiWUto?=
 =?utf-8?B?NVpEclFnUG52ZXRPelJGbW1Oc25vUkJKODFCcnB1RDJyeDZPaExpa0FibHFB?=
 =?utf-8?B?SzNVM3NoY3VCNmNHOGNpU0Z0ekFTRnVLTTdXOGJsdVF6bmh4Z1VmczUzaWRK?=
 =?utf-8?B?N1ljMHM5Mi9Gb1pjQTZIY3FXdDdkWm83akFOQlp0ZTBxYVJYWWYzRmhiSyt0?=
 =?utf-8?B?NThFOWtVbVJybmlGaElmSUlLeUNYZlphK2JVVDNORlB0SmRTa3Mvc05TQlNl?=
 =?utf-8?B?TlF3VHdja29MeTFxeVlrQnFETkoxcjVPY3NLcnlEREpsT3g1MWxCaGtQUFdr?=
 =?utf-8?B?Qk9WaGhvSjVJUW96NnBQRmQwYWRIK0pMYkFoYmY2ZVVJUWdSaWxTZE1PQjNu?=
 =?utf-8?B?b2p5ZkxiYUhCai9icWkvc21xOHdRUWhtOWtVZUg4TmQrMkk2VHdXWTdEcnVr?=
 =?utf-8?B?TDFuVExVbEg4QUlvNkJnNkh1SmhNTDdsQlExbDk0UFNySUE5YUpjZ09MdmZu?=
 =?utf-8?B?RWRzaVZ0L2M5QVE2Q1pUb29TVXQveGd1K1ArYk1meFhGN1dHNGQyaUdVT29I?=
 =?utf-8?B?YUczTGhzc3B4bm9Zdld3eVdYR0tQUnJvSUdOa1FDeUt1alVhcTVHSEUvaCtX?=
 =?utf-8?B?UWdvaTdyMUN1ZFJ0K0R5MlhNYllMTUw5QkpQODNLRE4vWm1RN3B6WkRDcFN0?=
 =?utf-8?B?QnZpOVhiZ1k0d2FHWnU1NjQ4RnpDWTk4YVY0YjlXVU5WeTM0U0ZscVA3Ym10?=
 =?utf-8?B?bWdvMlZCY2hGRTBYRFNXd0JNRkpTa3dIbUovUHhTU2dERVF2N1g5ZUZRbDFD?=
 =?utf-8?B?SHZSdTRhOExDZldKTmVpK2RNb0llMmN3WjV3RzhpTE92THM2WVc5Yk9FeHpM?=
 =?utf-8?B?aVVZMVRPb3NFWUlablJkblhYeFJCZU9OQ2RKMUhZODR5czhtVnRXbUxlUXNj?=
 =?utf-8?B?eHY0Q28wY0QxOFNFbERidXZXTHc2TGFvS0cvMWsybmhyYlNYMURmWE9DVGRD?=
 =?utf-8?B?SjRUa0grbmVJN1kyVnBkbmhxdmFCOU9ZaEtkd0l3cHRldkVKbFRpbVQ5MVdD?=
 =?utf-8?B?V0lxOTd3YkcrZC9BNklZZ2RBTStQNXc5U2hEZGhZM1B3eGtJa05IMU8rckJO?=
 =?utf-8?B?ZU1DSEx4bkk1UXBOZFdqdXJKMHYreDBIRk5UbjdOZk9wd2FVTEFIZE9SNmsv?=
 =?utf-8?B?cVA3NjZZZ1lVRVVCZ3NFRVFMNjdqQnZDOG5iVFE2RmdiTUdDSnR1S0JTZERP?=
 =?utf-8?B?L0IzSy9tZUQydDVXSUZhaXBmSkJLUFpPNXp0N2JZdktZbC84WWE5b0FyVWZu?=
 =?utf-8?B?ZkM5VlJJTmQ1VUpOVERLWTlLay9TbGpCR1lNYUV6RlpKUUZ0cVFxNEhLQzIv?=
 =?utf-8?Q?EUunmOmvo3qVGYQaei?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BA97FEC20F790448F5B47C379D4E14B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e280958-a7a6-461d-ea4b-08de8f1bf239
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 11:52:12.3643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgouQeRqHc04jEjArs8mTWfcCUEy51R+SHU4bdSgecPh9q8m9KgJSOyhjKEJLLl/q/kZjYdYu2erSYZ+edp3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11219

aGksDQoNCnRoaXMgdjQgc2VyaWVzIGZvbGxvd3MgdXAgb24gTHVpeidzIGxhdGVzdCByZXZpZXcg
ZGlyZWN0aW9uLg0KDQoxLzIgbW92ZXMgdGhlIHByaW1hcnkgZml4IGludG8gc21wX2NtZF9wYWly
aW5nX3JlcSgpOiB3aGVuIHRoZSBsb2NhbA0Kc2lkZSByZXF1aXJlcyBCVF9TRUNVUklUWV9ISUdI
LCB0aGUgcmVzcG9uZGVyIGZpcnN0IHZlcmlmaWVzIHRoYXQgTUlUTQ0KaXMgYWNoaWV2YWJsZSBh
bmQgdGhlbiBmb3JjZXMgU01QX0FVVEhfTUlUTSBpbiB0aGUgcGFpcmluZyByZXNwb25zZSBzbw0K
dGhlIHJlc3BvbmRlciBhdXRoIGJpdHMgYW5kIGxhdGVyIG1ldGhvZCBzZWxlY3Rpb24gc3RheSBh
bGlnbmVkLg0KDQoyLzIga2VlcHMgdGhlIHN0b3JlZCBsZWdhY3kgcmVzcG9uZGVyIFNUSyBhdXRo
ZW50aWNhdGlvbiBiaXQgdGllZCB0byB0aGUNCmFjaGlldmVkIE1JVE0gc3RhdGUgcmF0aGVyIHRo
YW4gdG8gcGVuZGluZ19zZWNfbGV2ZWwuIHRoYXQga2VlcHMgdGhlIGtleQ0KbWV0YWRhdGEgY29u
c2lzdGVudCB3aXRoIHRoZSBwYWlyaW5nIHJlc3VsdCBhcyBkZWZlbnNlIGluIGRlcHRoLg0KDQpi
b3RoIHBhdGNoZXMgY2FycnkgRml4ZXMgYW5kIENjOiBzdGFibGUuDQoNCmlmIGFueW9uZSB3aXRo
IHJlY2VudCBCbHVldG9vdGggcXVhbGlmaWNhdGlvbiBhY2Nlc3MgY2FuIHJ1biB0aGlzDQphZ2Fp
bnN0IFBUUyBhcyB3ZWxsLCB0aGF0IHdvdWxkIHN0aWxsIGJlIHZlcnkgaGVscGZ1bC4NCg0KdGhh
bmtzLA0KT2xlaA0KDQo=
