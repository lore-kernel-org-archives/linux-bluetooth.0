Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013079.outbound.protection.outlook.com [52.103.35.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEC3630B0
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249199; cv=fail; b=oxo+GjwwpfTIO2JCjbnflSUB56fbMRZ6IK66CYQwwf0C4ASYFG40bbPK61QnVtjzlvBZJxBQQk7WV1fDYde6w/vZ1PxY2ZNLCA5t9+PICMBXm+Q3s5jDa6Xz1/wNl8sRkeEfZQ03QF8MaxscSZ6yHAj0eA4d9ih5ALw5z7lyW0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249199; c=relaxed/simple;
	bh=KPjheWVSgRLx7/Lz7ih38qONVDmdMICtCZPUThSk8OY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L72HoKp/2ibgDHYZgG28NtZWVlhrESm3huhVIVPXekzn6kAdioFbyj4+7wcijYs+j6r3vvJS/sJQuLEUEUxdHRjmaRAOnDcv4y+ezzdDxvGxEWuwSHFjHlPl79ZhB30o/mI+kVDgPr/Nrd7svD2uogLJQ8NawRXrlrJdHznJ2s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SQ+gf07Y; arc=fail smtp.client-ip=52.103.35.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SQ+gf07Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtWsy3DbNgUj6ZswVGRaSVR59bg8n3v0yINpse+63KBldDrsTAvYEoSjXL9n6HywfUgN+Szfd/HgAgqrAn/8YS8+0DFloHcn+4uXReZjs+NJRegYQRDIMs+sNHoq8G175UpHS6iBUETs+8b1owFFQLNuOLAgBPHASJEE8Vx68yqqJw9nxTAzLZp1uVchHiwUU6u76qGDyamoNcHtIb8Lw0fz7VcG3YP8+15cVakFJxZsTZMrjU9YHBBchFaF3l7s/M+DDfAFnEU9zbl8KwC4QRYrrpNLYVIVE/KLkODbA8ikAMqzxVs7p9bhGLwviTWyjyzCm4BBmut+nvjzyYDgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzWdGgiMVLt+1+UXUCV0q8UJqr6BI+v6jdbf3lkFqG0=;
 b=h7a8S1XTAYObOGit37OtjNayPQ5LeOdv1tAdMrmnHjkATL4e6plWleJ3sE9sIYlBphoJa9//Q/n1bWMeN3cieFEq2J/sJWz51Qp+LiyXw4cqXNVjxzEfRSdRhkiKlSPQ0hQ1Z3YOVu3lhTAOkY5IRFbi2HUYQZ/+Cae+AkKtuM1v92wA9FFTr5hWOmL0Blf8YD+VZI5QS2pvUKktMOlWBGzkB0cltJVZcoFb/l7PGZ5quZvqgOAeAX0YnMlPUNUTqBxx+81xTH8t8GfO5Wx0T1AsSbIX8dBPZ04TxMEU6cv0qftDmD9tUfyTHM3uEoPFNYTCWRlBqGpTz16b8TnC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzWdGgiMVLt+1+UXUCV0q8UJqr6BI+v6jdbf3lkFqG0=;
 b=SQ+gf07YiC7yQPuj4/4WOEpkKZzm2cdcAfnM8VWny4RCTPAZcmRq00J2sVx+MbOPG96I6hzPIgRQBQIduLjFbaH/nbD5pS0AatZH1fwzqpQjJkltV9Udd0tXnw7ulP4iJ+GrxCIqh3qs+5WptlAhGxU5vFXxCeVKQOF+GLi9mspTOSaybtDsEuci3GBb+L8nac/Fo8BbJu6gV/uNAloet/bAk5IOIvkCQWGxNx0LM4lwSQ2juaVbfnGH+DhDRk4jiQDQO6rOXr7oRgPXMGBzb6qXfpeYHtZMUmhGG0xM5yqnlsLqujSJ/6BPHolqIiMAsgbyrCDrX2roiQ1KFVZI/w==
Received: from PA3P195MB2811.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4d7::8)
 by DBAP195MB1116.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 21:39:55 +0000
Received: from PA3P195MB2811.EURP195.PROD.OUTLOOK.COM
 ([fe80::befc:52db:b072:9f9]) by PA3P195MB2811.EURP195.PROD.OUTLOOK.COM
 ([fe80::befc:52db:b072:9f9%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 21:39:55 +0000
From: kiran francis <kiran.francis@outlook.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [RFC] mgmt/BlueZ: explicit PDU type, independent PHY selection, SID,
 and directed-advertising support for extended advertising
Thread-Topic: [RFC] mgmt/BlueZ: explicit PDU type, independent PHY selection,
 SID, and directed-advertising support for extended advertising
Thread-Index: AQHdQv7UoP6IG4WI+kqx/M7RWZp9/w==
Date: Sat, 12 Sep 2026 21:39:54 +0000
Message-ID:
 <PA3P195MB281100D47BF1120251E73243EFBD2@PA3P195MB2811.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3P195MB2811:EE_|DBAP195MB1116:EE_
x-ms-office365-filtering-correlation-id: 2a6cf2dc-7ed6-4533-b2ea-08df11166286
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|25031999004|12121999013|8062599012|51005399006|31061999003|19110799012|15030799006|8060799015|15080799012|6140399003|40105399003|3430499035|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?Tn8YmhBXvGirwAHxKzXkZokaLpgTgEJget3mG1FcAo+gRlN47rxkHVJM?=
 =?Windows-1252?Q?B0ZDlv2TL/ZIJGpNR99ucZg55EkevTNnCrYJuKA0bCMPGONfRJ10Lmw0?=
 =?Windows-1252?Q?bQwL6+U45C6jlKuyp4odf5oP+Z8ABnD2Ryq545g/thA4GzQP65sU6PgV?=
 =?Windows-1252?Q?OzZrvC1njm+9PgsVfEZWM0pNEK/dBbWJKXkTtj+AqibLSJXorFbD5pZC?=
 =?Windows-1252?Q?mSpX0m+k81rhLZTEUAsJU+4tHus+wowwunkFKDJuN2OpHhOk+vwTtnvB?=
 =?Windows-1252?Q?LG6o4W7Ug2BY0tASGckV1qMHH6272E/diJOnasYwGJbTHrhNLZrwbNxF?=
 =?Windows-1252?Q?Gjwx2SuXwoEwGajTQGy4kNlAjpiqCiERP3C6ekUXtTljjJCESJJcWwtA?=
 =?Windows-1252?Q?Imfrz9cI1SHsTNRA4Mfoa4+rFnaEQdm0X3RPiz6XPYYOaV4tMIJ1foW9?=
 =?Windows-1252?Q?sT4+biUmXlgRMCd3TagvF4BC2/3sJRA3q9QLXJn+h2asxkrWS26/6zfB?=
 =?Windows-1252?Q?geDrjI6+AMogHh9gkLGmnSSgRy6sUU47j9z93o/aAtB4Tj6VyTIp22o9?=
 =?Windows-1252?Q?kMYjBewhxVhtsEWb862IZcA20gfMOHip7S+suVodPEhrb29rgBho2jlW?=
 =?Windows-1252?Q?pY72vSiDpU8x1TbTfxvPkmgLuJOmyyMFYvJB66RX1almJhaghVoOEooH?=
 =?Windows-1252?Q?2Y3IuVwKAXMocF7GY7/W1Kk/xbnAR3yT5l7yULxQnJCjy5ucWySSLgBg?=
 =?Windows-1252?Q?q2lHh+91HaEI2lbrLnntS9AcmT8KBoA7mvX2EXJYFKEU29OZnIOyhF+t?=
 =?Windows-1252?Q?zRsroq4P931ej+Oc6Yit1CL7fNfYGu7o/+8JahU5/oZFxRKg18U/Tc46?=
 =?Windows-1252?Q?Wn3Xwl+OuaYlU0PE8SatGxHN+C79C8hz9WQs/Jx91Z1bgEZSiC4YvmYG?=
 =?Windows-1252?Q?HS1T2NsGY80sC5MUKYWDZDdohAWc9xfwxkYEJaS5bCy+YKyuBFbQ/kSm?=
 =?Windows-1252?Q?1BOz0hixtm70KlmskMO+K4N4+YgdEwMqW32GAEFy5qFn75ucOKpz8poX?=
 =?Windows-1252?Q?YIreex+EQUPPaDFc8/oaG4Pk9HsPmVqbGGKt+A5A9tbDluWjP1Twl7pp?=
 =?Windows-1252?Q?oC8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?CMVuSjlzdLDdWqXjqZKfaXVFj9PZtI58MUZfElUiaS9BacaRRkxuMbzn?=
 =?Windows-1252?Q?BhqwlrXcrrwWUsIAnYUbZYSQHTHxKb2a58v8itcBZGRR/Sd70Jtsm4RZ?=
 =?Windows-1252?Q?94S6hWshjgFvb5RdDx5LjU5SqJfzpBjucxmgla6KegZWxRNIpa5lA7em?=
 =?Windows-1252?Q?Hgk3aoMQBQXBwC/HzXrvGv2o9fG48Ywt8vTlSXEWOLpBY9cHWXPzFWye?=
 =?Windows-1252?Q?95oTx4rLusUXfa47TfYVfe0kM/XXcVnEURmv5JPPE08MnBOna6QdlTqd?=
 =?Windows-1252?Q?VQInWcHWkaINl1FXT7SDR4QdpGZQ4UrI1R71/nc/mdA/aGgPfwhFREoY?=
 =?Windows-1252?Q?8q9Xixw7XDyqH3w8LpPOW7v2kJv4QtmLTyo30Nrz+POaeegHSUCqY8bc?=
 =?Windows-1252?Q?dTHPjUoEfoCdg5MLBKKe1AdmHdkHoD4Dx7ISISZpWTnHXyhB2OJiH5V0?=
 =?Windows-1252?Q?vdbXEm+0Gc/ZSoKc3Guq6h41BPG/ESozrLJbMI4wD4irh5rOzepZ5ucu?=
 =?Windows-1252?Q?i89GdO1V4MjC6aSd5xKoAh++ngS7nnZILy9pbMksXhPLtHhJK3wh/al3?=
 =?Windows-1252?Q?j9k90V1B65ONtPkE+oFJtH731QmzhvurAj2PXYoNINVs8k1y4YwkRa/H?=
 =?Windows-1252?Q?ys8iUbqzfU6ENcSp830WlT6uWq7Mj6wwS9VuDkWhMyYLz48XdAjabxix?=
 =?Windows-1252?Q?DNGbeYTye2v8M1dk9t1yGgImzfq/FKwIRz5Vgjmc5CmScFCPQq5PWvZp?=
 =?Windows-1252?Q?E9vbjLnamHQdio4MQ68v06XpSqkcC1vUV3s7ArqX7xQtm7T8YmBxbFHw?=
 =?Windows-1252?Q?tX7XQ0GX7OF3AZqXoQiFm88GAeN2hanQNohPbJsO1d60MLOHUWQ2VHHa?=
 =?Windows-1252?Q?VktmJZ40zTvdZFm3g/NhPsSHZPo/EKZDf0O4jg/Q1SQvhZe1krmdCwCp?=
 =?Windows-1252?Q?c7jF19F4yReH16Gjva1aZMvfiglaSmimbFiKmdBL7IOxCUUWsOL02cXP?=
 =?Windows-1252?Q?7UWf1Ye04HMPTSzHkxUjVeUosVkETl4+FF0fe0WVevahN5l/mpJA+ele?=
 =?Windows-1252?Q?Az5oCbm8fQcvR3s1zwqVFtx6v8LuRkdEGQ34GhWRht89BGij2/6WCRLX?=
 =?Windows-1252?Q?NdGq5/ZdrNNFUbEkQmhicpfeDMgOoC1IH2xpyhxCFALH8YNpMji3VAYx?=
 =?Windows-1252?Q?OtW4iS/pqAi1R+YcNtDPEZHV/mGjgVMR1ppxscC9cWwMEauZUT9GliyT?=
 =?Windows-1252?Q?KBQrNud/TWxQNusI1jZ02ClrguslkOatgmQzgSbqAaqkcGsH0wgIgZB2?=
 =?Windows-1252?Q?ji6L/34R7+sCIBUZKTMoTDlQOfyVgCe5sLR0N2ChxuE2ojSm9p8bx9G5?=
 =?Windows-1252?Q?/eSfxweMtV8aqQF5aiTECY5su/Bwyr2/WI0tSyNpMaoo34bAEb+4IcfR?=
 =?Windows-1252?Q?IeTDcrtyptUkklK18VdqzgBGfj+irX50ASkFlclJlroxJ1Fr5VG0K9ap?=
 =?Windows-1252?Q?2qs+acoX?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3P195MB2811.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6cf2dc-7ed6-4533-b2ea-08df11166286
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2026 21:39:54.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1116

First time posting to this list.=0A=
=0A=
This affects both the kernel mgmt API and BlueZ's use of it, so posting as =
one thread rather than splitting across two.=0A=
=0A=
hci_setup_ext_adv_instance_sync() decides several advertising parameters on=
 its own instead of letting the caller set them directly:=0A=
=0A=
1. PDU type isn't a parameter at all =97 it's guessed. The function picks t=
he PDU type (ADV_IND, SCAN_IND, NONCONN_IND) by looking at a connectable fl=
ag combined with a separate global connectable setting, and an internal gue=
ss about whether the set is scannable. There's no parameter where a caller =
can just say "use this PDU type."=0A=
=0A=
2. Primary and secondary PHY aren't explicit parameters either =97 and can'=
t be selected independently. Like PDU type, PHY selection is derived from t=
he SEC_2M/SEC_CODED flags rather than being fields a caller sets directly. =
The Core Spec allows primary PHY to be 1M or Coded (2M isn't valid on prima=
ry/legacy channels =97 a hardware limitation) and secondary PHY to be 1M, 2=
M, or Coded =97 six valid combinations. Today's code only reaches three of =
them:=0A=
=0A=
=0A=
if (flags & MGMT_ADV_FLAG_SEC_2M) {=0A=
    cp.primary_phy =3D HCI_ADV_PHY_1M;    cp.secondary_phy =3D HCI_ADV_PHY_=
2M;=0A=
} else if (flags & MGMT_ADV_FLAG_SEC_CODED) {=0A=
    cp.primary_phy =3D HCI_ADV_PHY_CODED; cp.secondary_phy =3D HCI_ADV_PHY_=
CODED;=0A=
} else {=0A=
    cp.primary_phy =3D HCI_ADV_PHY_1M;    cp.secondary_phy =3D HCI_ADV_PHY_=
1M;=0A=
}=0A=
Primary=3D1M/secondary=3DCoded, primary=3DCoded/secondary=3D1M, and primary=
=3DCoded/secondary=3D2M are all unreachable. There's also a silent-priority=
 bug here: if a caller sets both SEC_2M and SEC_CODED, the if wins and SEC_=
CODED is dropped with no error =97 a different result than either flag alon=
e would suggest, with nothing telling the caller that happened.=0A=
=0A=
3. Directed advertising can't be produced at all =97 not just unconfigurabl=
e. The PDU-type decision only ever resolves to CONN_IND, SCAN_IND, or NONCO=
NN_IND, each as legacy or extended. Directed PDUs (ADV_DIRECT_IND and its e=
xtended form) are never one of the options, no matter what parameters are p=
assed in. Fixing this needs new logic, not just a new field.=0A=
=0A=
4. SID is always 0, with no way to change it. Every advertising set created=
 through the normal path (add_advertising/add_ext_adv_params) gets SID 0, b=
ecause the code that actually sets a non-zero SID only runs for Mesh/period=
ic advertising. A caller running several advertising sets at once has no wa=
y to give them distinct SIDs.=0A=
=0A=
5. I've already implemented one example of this pattern locally, not yet su=
bmitted: an explicit MGMT_ADV_PARAM_CHANNEL_MAP flag/field so callers can s=
et the channel map directly (previously also decided elsewhere, same as 1=
=964 above). I can include this as the first patch in the series if the gen=
eral approach below looks right to you.=0A=
=0A=
Proposal: add explicit parameters for PDU type, independent primary/seconda=
ry PHY, and SID, and add the missing code path for directed advertising =97=
 using the same shape as the channel-map patch above: a new flag bit plus a=
n extra field per parameter, only active if the controller supports it.=0A=
=0A=
Backward compatibility: each new field would follow the same pattern alread=
y used for channel map, so nothing changes for existing callers. The new fl=
ag bit is only ever reported as supported if the controller can actually do=
 it, and an old kernel rejects a request that sets a bit it doesn't recogni=
ze =97 so a caller has to check first, the same as today. The new field is =
added at the end of the request struct, and the minimum accepted request si=
ze stays the same, so an old, shorter request still works unmodified. And i=
f the new flag bit just isn't set on a given call, the kernel falls back to=
 exactly today's behavior =97 same guessed PDU type, same PHY selection, sa=
me SID of 0, no directed PDU ever produced =97 byte for byte unchanged.=0A=
=0A=
Regards,=0A=
Kiran Francis=
