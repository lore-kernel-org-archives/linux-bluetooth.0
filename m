Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010021.outbound.protection.outlook.com [52.103.33.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB040099A
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759279; cv=fail; b=D6+PpYGNWncw/mG0+QuX8CkXmd6JlcBmYCk30dBS6we25vtEIxaIoJLC9+tsiZgZUtUHsHQE0Ie73Xmg9nSnqgwEDbtElOlln0/fp6t+8HqC9Zpqh4TvHhB5zLUZxOazWW0OlOoh+exkctFx2cW2Q/OshCy0QjLeK2jmVbXDfxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759279; c=relaxed/simple;
	bh=50HSutiElRmiq74Dk5xq4tfCjFlNLEZmuJ8yw/9opCo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dEQuRBpsH0tohBsL3PPBGJ/9+hkKe01jhDfY8j9/zwGXdgePrRhywj18jwBd8x7MFZJI1sPKugqlFBBKQQ30ItMb1qOH1QLxxDlyLxl6EQ8hCmjgDL2/KFDG/S1SPgOdjUaC6Qop1TMstU6EmNUFXiiVrtOpWy9C7p5rLwSyXS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QIRYx7nV; arc=fail smtp.client-ip=52.103.33.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QIRYx7nV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzEHuvhuMEOG78u8TO7BAVj53792jU++YdHE656MS0LDjCV9wXNbBvlLoOYALWwCZlAPGTf5tBvcuStItWq95K4ZI7a7pU8tWA2BnhUQn8BXWPOxephk/s+1le9DWGkCeYCUbP5CGXL8HbmKSkrxKtlkKOr5I5jUQJSffIlenDMWgGVWP8iLfiu8HObONt1Ux/X/Mt7nvmYBlhQT9v2aHdJXhyznI1LB4C05a0fsS7CBOEobCftyfUiQRwPkQZgg4MAaR3xB41CxJ+EwJBO/ay5AdVax6kUdyNER3IaMGYISGWG64OsB7MLAoDF/tFRLG0Kqm7SK3jjfyPZTf0+nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDAJXWQPXWzSuozrmXDyFjqkZXXeY/sLDeDAMUVQN00=;
 b=XLgseaUjp6nadUv8QF7hwYvIDs11kW10IUl1dkoCr0/NS/ydBCmb6YC07N3VjM0xhvJMRm74/3Qzo8DXaW6wWLBVSORyha10JffxS6SI4EfTVS5wr05QxBJlO6/Hr7Uk650dJb9Nmt/XMnEgzWnI7tXQIR6+QpKYQYz06jS9q71jVjiQYJS7MnB/GnWSS5ur4bMDorjb47Duex1K2Rm0oUD+/Hx8gOvNHNaM6ppT4uBlnBxNU1SDN3isVl9dVi0T8vLUQ47RB8SDA2jdHH5n5m99Cc6EOxf0HQV03pMecnJ/l4kEZn4Wf/PivBLkbrOuVxU4pYpgrXRIkOtF9HAICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDAJXWQPXWzSuozrmXDyFjqkZXXeY/sLDeDAMUVQN00=;
 b=QIRYx7nVw87L4WbTgamQXsJyFkZLDUqCPQly09aj1ba/lr/qzBnhgDYYkj0Bg3LZ95XP6R9JNGN19S2c3A9k651KpE+UtUnLsSXSeECgVm1URwhG1MHiq3ZKSRt5rPGvmdqj+3DanNKnV2FGLvSfxbdhCJvX7IF/Vp651uJbkfNXtkovW4PiK9ahsfkZ6nzoxgodX/F5LQvG1HRcQFS4DpsMeEJYu5l6VtCpfQ1v7cXo7Qn8ydHWLLNfimp+Et8d8MT2VheqNU61yJyHrFVxzWj+VVUZGDrZZfnk3MYYpkFHrRuJQ59ncAErUuvfP4WsOH80e36n2lCR/L7BnRa3dw==
Received: from DB9PR08MB9802.eurprd08.prod.outlook.com (2603:10a6:10:45d::19)
 by GV1PR08MB7331.eurprd08.prod.outlook.com (2603:10a6:150:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 12:14:34 +0000
Received: from DB9PR08MB9802.eurprd08.prod.outlook.com
 ([fe80::5064:ceaf:18a5:6d63]) by DB9PR08MB9802.eurprd08.prod.outlook.com
 ([fe80::5064:ceaf:18a5:6d63%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 12:14:34 +0000
From: Cedrik Piehler <cedrik.piehler@outlook.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Pair() silently degrades to "No Bonding" when adapter is not pairable
 -- throwaway key deleted at drop, remote re-pair rejected 0x18; SetPairable
 intermittently fails org.bluez.Error.Busy
Thread-Topic: Pair() silently degrades to "No Bonding" when adapter is not
 pairable -- throwaway key deleted at drop, remote re-pair rejected 0x18;
 SetPairable intermittently fails org.bluez.Error.Busy
Thread-Index: AQHdI0ERFbot69gG10WO54vwQ4VbRA==
Date: Mon, 3 Aug 2026 12:14:34 +0000
Message-ID:
 <DB9PR08MB9802E0CD4A603984E8A7FEBF8FD52@DB9PR08MB9802.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB9802:EE_|GV1PR08MB7331:EE_
x-ms-office365-filtering-correlation-id: 340e1a00-eb15-4977-0810-08def158c796
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBvhuFgLLe5qs4jWk9CHdv0AE7Wl2+bvi36sdjSLtELxa5zN6VtAbvYb8k+iVKPWqBAwUqkuysqNU5a6oC6YGB7q5/0+iUJJvJJ3GGnUwEZMDwVEP97qC8Gqym1Vfcp3N+j6XVXMjhv/NfVkViRdJ/QrYtqVvZsjuCs1mfIS4BGyot2XmxJQJfm7CJLC/Joi1FUQdZe/PRc9oYbpTT2kANBzD2FsyTq55vF3ZOruZhPyNOMHLoy+4ev9L+0PJNhyQCXHba1V7Rmv7jb6Pxx+qxUAFLE8HYX1SwgU5Cv/SV1Tup7Ws/FqbAMXx+D3PdWj73AFDyXfYGe+3EuqPKrf1FntXmqSlvvxaMMXyKrFdqP95sNyLTEtZbFH9FEyitpy7mvfSVppuiXTJjNx6qi3xchTA8UkycQlttLdlHizaQHKB03zIo925DzcBYGrc0DpxZXjIK8eXyQdHvV7KUaI2KCUKaM/pS1xYtcDDNPJlF3zHCk8S59TMKll6EidR2qaO5SN92vSplkXahR+8XnzKdu54yqdfhM/mJwSjaku4oNM1AYh196T1C1owkqJEGoSqJwyq353FFaugDQByl0hgVWeZhZkDKoR19wicj7t8dSxibjvfYD4JzQLCGsOaqtNTu0awYv4Xl//a1ETHZBffjlyZQhSPstK3rY5M+W3c9XZmh3yC0AsBEwaK8SdNO9QyhZ1XmQTx1GObNJqo98xoZBu6XpYhBM73mJ/VqxDh5U++KbMQ8miO4CATlKQGQkqotO4m4h96lai1akzn6JNucw9
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|24021099003|39105399006|41001999006|20031999006|15080799012|31061999003|25010399006|4140399003|15030799006|40105399003|2607281247196008|56899033|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Eu4i5ENL9PjBC84irAYe7mbxPJvOzFz+yhq23BbRBTA16J0wDGOA+g9QCf?=
 =?iso-8859-1?Q?73Z1B8BINfjFcZUHPlQNYuAOY+ZycCCsJFM8fhVaRxyS4iSsQrOm5BPRkU?=
 =?iso-8859-1?Q?Z8D1fouDnAyXFx2Ud5oMLD0eNsj9j0MjGdiLXsN2waig3T5lLOY0dt9Io7?=
 =?iso-8859-1?Q?ms6X5Wm0+AtJmbauP0fNFsb+ZDJ8rGHg9f4jfUkSGgSv9aDOagGO83TqIu?=
 =?iso-8859-1?Q?Nndr088Qgv6qB1HKieFGvdsB0oYkUK+LUUxYRZsVNOx7PMmz4T+EAY6mqE?=
 =?iso-8859-1?Q?8dH0Wp8FqJtFiJbGk4Es9VYny1E/sgEk1DtzsiCJ9lBl4L3BJ9lW9I/aMm?=
 =?iso-8859-1?Q?vUemOxfVnxIxjlrjUkpf0BGGc4axOb50DboYjQ/VxqJrCE6HYWFsPIwys6?=
 =?iso-8859-1?Q?V1pWf+Y8R4YhZgLcU5/RaWw9lsGqN0kNvjCIDT33ohA2oJnGuYZiaz46lx?=
 =?iso-8859-1?Q?NNligwpTP0wS17tiuJ7mAqD3Fk8qb5y57McgvL9aQILk9X0PH9WGAdcmns?=
 =?iso-8859-1?Q?WlC4RnyMu73oby0IOWp2U9mP8ccgerIguCQMg9dq/zUJfMfR39FYBMLvpj?=
 =?iso-8859-1?Q?Dw9o2L9Ewkhv67FXnjdJWcdUNZr2mJTYiZxEskokPNECac69Kynnxqw2ig?=
 =?iso-8859-1?Q?5MTrFYpKehfsO5QSJVEMje1jQmQXlOftPAUP9Eljbrt9kVKo+WbpcnHWNf?=
 =?iso-8859-1?Q?22cHI3/SK3CW+XYlDBUnHtxvsELpvRBOp3d9oW5ASM5WEC/dmDI6Lz+o+G?=
 =?iso-8859-1?Q?dOR9aKS0SbTTRmbIxNC3nGBbguu8omx21pyiNKLml9p49FeD/V9XzZQrP3?=
 =?iso-8859-1?Q?j0WPDT9WrusmSdoH0SQuSZ2txm6goDc+rBqZ3iCThmvBDdm+7tFS7ZvDfx?=
 =?iso-8859-1?Q?cdseUI8Rjz+N7jPzcG6tXzlvs8rdE/bTNziRzlOubg74uRrmhb9gEWysVb?=
 =?iso-8859-1?Q?AjBwrtt7IMM7oqPZrD1XnbDVS9QnxjegogIA6cayK5JRzGj/uvOvDKDYqF?=
 =?iso-8859-1?Q?5yFR9kPDnJVIoJk94soCAWZx282peodTzEC1a/fJ7JUVu45oOgobgig6hG?=
 =?iso-8859-1?Q?UHp5KyYfGG/kCguXN3sD9iE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q6UdDcxgYqgHx6MbT3MpedOL/J3bkiv367nUxwl9vjWRVJNFoSxfk1RUhC?=
 =?iso-8859-1?Q?6LYEdmehdS8DcNyWIZjmzyqyYjJ6wuVN91DUdFJPDdIWg2wjloZtTa6BQa?=
 =?iso-8859-1?Q?wCw4zZXew3u7/9Id+uBOJX+0qslEFGEOEOJa8ars2D5oRExcn2/EUGe6CY?=
 =?iso-8859-1?Q?ITjB0VTG8e2/Wx7G/qo7lYN/PoIJX6F5swKTLOHeIunNYq9iBL+APArq/d?=
 =?iso-8859-1?Q?71BaDe9xLma9V+nHibGoFc7Dn7c0ZXdFfB2+ECXeHByDj12FAM4x4pSi+h?=
 =?iso-8859-1?Q?0Qi3zNU54xrJNQjVyYfvyzpGB7o61ZysYsefu4xoKsTwrzXnrrLuUTf5tG?=
 =?iso-8859-1?Q?ZbLh4lKLRxgL1ne9LHe2D0uI1YK6oTNuw+VeNHd1HclCAtpCUkvboCXs0I?=
 =?iso-8859-1?Q?iYyDTvF3HHrCjdfk0evbwuR0CUsTpHefP9edelxKjfcnM2cRqc+aptsid9?=
 =?iso-8859-1?Q?JqTzxNhOjtkRfGL+m/6TBR1ei4fq396K9Eka4xbcBhYnOouJHvpliuP2e5?=
 =?iso-8859-1?Q?pAEO1QNijWD91kDdK7H5FE3HJlMiUL3tHajUn61aOf/7VaEBQXCY1Whkzn?=
 =?iso-8859-1?Q?4MtbKgBTCgNCcPIERNkes1dBLjuUimEN+IZLCPLFcuiTRpp4xKt3Y2X2Mh?=
 =?iso-8859-1?Q?Dbd9gTesWjO94VSwUU5CAXy9KVGC/UHTVpv4z/iG1UpoAp17uuX+Qb/+ow?=
 =?iso-8859-1?Q?fRbN32tdUspr7nfs7hs3EdaL1cL76BqdshSuoZnx2rX3z2xHZ8q7ImsXOR?=
 =?iso-8859-1?Q?ToYiJCSb4LJfhWt+FqWQDc9C5o8px9/Sa0/PJ2zNPmjwckiChng4ikqJUM?=
 =?iso-8859-1?Q?RoSNrqTFyL4w+EcEOQsZIFFP+2JQMEtyr91huhlEG3CbNq8lhVDdahhDky?=
 =?iso-8859-1?Q?sF9VEwl/ZfM5lqqmv+wfwhWAYc5Oz8heBABVHbTiv5fKKz4p+qNnRgMo4A?=
 =?iso-8859-1?Q?SYHJsJWt9K/uFbULJOV3+jr4I5N1xSeOMu9XKsPqdEnjQ4zjV6hUisSjKW?=
 =?iso-8859-1?Q?1iRIZitD9pp3zx9mBT6JI2t0VkT9TG/sxjPVF5ezXFo5GQV5M7zP6ffsTA?=
 =?iso-8859-1?Q?KOpuTsp4l6fnmTBhYaQAduN1cJl1rdC0sf6jgGtfyVUtpqaJJR0Txw/nD5?=
 =?iso-8859-1?Q?YHOJ+mGuC10vlGT9EIe3ntkCr6EfoukTmk+7Qd9LHIGapHT682LEfaXrKy?=
 =?iso-8859-1?Q?dxSBk/oRNirfJPjvN05GKA/EEKLtq/0f10AGcxlBP75mtvBcSdd2n3E8Kw?=
 =?iso-8859-1?Q?KBXhLm5if3WSmq/WE/h8n69EjNKR2VoKdmf1u+ovenAY78NHL+vij6B9ll?=
 =?iso-8859-1?Q?lIdQQlKczvKK1NJQ3iFn3L4LZO91ijpm+xMlzCj8QxdzMOIXLRFpwKXjHE?=
 =?iso-8859-1?Q?T8d1FRgFQnIGKKdD1TT+bDTYEh9QtIiqviei+ATtln0YdCG/8cQI/7YZFO?=
 =?iso-8859-1?Q?qfejPZfdjR3sBuLd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB9802.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 340e1a00-eb15-4977-0810-08def158c796
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 12:14:34.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7331

Component: bluetoothd + kernel mgmt pairing state machine (BR/EDR SSP bondi=
ng policy)=0A=
Version observed: BlueZ 5.87 (bluetoothctl 1.23), kernel 7.1.3-7.1.4 (x86-6=
4, Marvell/NXP IW620 BT via btusb)=0A=
Remote device: Sony DualSense (BR/EDR, SSP, requests Dedicated/General Bond=
ing)=0A=
Reproducibility: 100% when adapter is not pairable at Pair() time; 0% when =
it is (same boot, same adapter, same remote, minutes apart)=0A=
=0A=
Summary=0A=
-------=0A=
=0A=
Whether a Device1.Pair() produces a PERMANENT bond or a THROWAWAY link key =
depends entirely on the adapter's pairable flag at that instant -- but noth=
ing in the API surface tells the caller this, and three compounding behavio=
rs make the failure look random:=0A=
=0A=
1. Pairable silently turns itself off. With a default configuration (no exp=
licit PairableTimeout), pairable set via D-Bus was repeatedly observed gone=
 again ~30-60 s later, and also gone after daemon churn caused by disconnec=
ting/removing a previous bond.=0A=
=0A=
2. SetPairable can be rejected with org.bluez.Error.Busy while the daemon i=
s settling after a disconnect/remove -- so even re-asserting pairable immed=
iately before Pair() is not reliable unless the caller verifies the propert=
y afterwards.=0A=
=0A=
3. When pairable is off, Pair() still "succeeds" from the caller's perspect=
ive ("Pairing successful"), but the SSP exchange negotiated No Bonding (0x0=
1): the daemon stores a temporary link key, actively deletes it at the inev=
itable first disconnect (MGMT Unpair Device), and -- with pairable still of=
f -- answers the remote's own re-pair attempts with IO Capability Request N=
egative Reply, Reason: Pairing Not Allowed (0x18) until the remote gives up=
.=0A=
=0A=
Expected behavior=0A=
-----------------=0A=
=0A=
A client-initiated Pair() is an explicit bonding request. Either the daemon=
 should negotiate a bonding-capable authentication requirement for it regar=
dless of the pairable flag (pairable should gate INCOMING pairing, not an e=
xplicit outgoing Pair()), or it should fail loudly / document that Pair() r=
equires pairable to be set -- instead of returning success while producing =
a bond it deletes seconds later.=0A=
=0A=
Actual behavior (btmon-verified, A/B on the same boot)=0A=
-------------------------------------------------------=0A=
=0A=
Run A -- pairable OFF at Pair() time (fails):=0A=
=0A=
    @ MGMT Command: Set Bondable (0x0009)  Bondable: Disabled (0x00)   -> C=
urrent settings: 0x00400ac1   (Powered, SSP, BR/EDR, LE, SecureConn, LL Pri=
vacy -- NO Bondable)=0A=
    @ MGMT Command: Pair Device (0x0019)   Capability: KeyboardDisplay (0x0=
4)=0A=
    > HCI Event:  IO Capability Request (0x31)=0A=
    < HCI Command: IO Capability Request Reply  Authentication: No Bonding =
- MITM required (0x01)=0A=
    > HCI Event:  Simple Pairing Complete: Success=0A=
    > HCI Event:  Link Key Notification=0A=
    ... ~5 s later, link drops ...=0A=
    @ MGMT Command: Unpair Device          (daemon deletes the key it just =
made)=0A=
    # remote re-connects by itself (~+5 s, +11 s, +17 s); each time:=0A=
    > HCI Event:  Link Key Request -> Negative Reply (key already deleted)=
=0A=
    > HCI Event:  IO Capability Response (remote offers General Bonding 0x0=
4)=0A=
    < HCI Command: IO Capability Request Negative Reply  Reason: Pairing No=
t Allowed (0x18)=0A=
    > HCI Event:  Simple Pairing Complete: Authentication Failure (0x05) ->=
 Disconnect=0A=
=0A=
Run B -- pairable ON at Pair() time (works), minutes later, same everything=
:=0A=
=0A=
    @ MGMT Command: Set Bondable (0x0009)  Bondable: Enabled (0x01)    -> C=
urrent settings: 0x00400ad1   (... Bondable present)=0A=
    @ MGMT Command: Pair Device (0x0019)   Capability: KeyboardDisplay (0x0=
4)   # byte-identical to Run A=0A=
    > HCI Event:  IO Capability Request (0x31)=0A=
    < HCI Command: IO Capability Request Reply  Authentication: Dedicated B=
onding - MITM required (0x03)=0A=
    > HCI Event:  Simple Pairing Complete: Success=0A=
    > HCI Event:  Link Key Notification=0A=
    # link drops seconds later as with Run A -- but NO Unpair Device is eve=
r sent;=0A=
    # the remote re-connects and the bond is permanent. Zero 0x18 events.=
=0A=
=0A=
The Pair Device MGMT commands in both runs are byte-identical. The only dif=
ference is the bondable bit in the adapter settings at that moment.=0A=
=0A=
The SetPairable rejection (bluetoothctl output from a failing run):=0A=
=0A=
    [bluetoothctl]> pairable on=0A=
    Failed to set pairable on: org.bluez.Error.Busy=0A=
    hci0 new_settings: powered ssp br/edr le secure-conn ll-privacy     <- =
bondable absent=0A=
    [bluetoothctl]> pair D0:BC:C1:38:B2:7D=0A=
    Attempting to pair with D0:BC:C1:38:B2:7D=0A=
    ...=0A=
    Pairing successful        <- caller believes all is well; bond is a thr=
owaway per the trace above=0A=
=0A=
This run had issued "pairable on" ~40 s earlier (before a disconnect+remove=
 of the remote's previous bond and a 10 s scan). By Pair() time, pairable w=
as off again despite no client ever requesting that.=0A=
=0A=
Impact=0A=
------=0A=
=0A=
Any agent-driven pairing flow that (a) sets pairable more than ~30 s before=
 pairing, or (b) pairs after removing a stale bond, or (c) calls SetPairabl=
e while the daemon is busy -- i.e., most real-world re-pairing flows -- int=
ermittently produces bonds that self-destruct, with the failure surfaced se=
conds later and attributed by users to their hardware. Interactive "bluetoo=
thctl pair" succeeds or fails depending on how fast the operator types, whi=
ch made this extraordinarily hard to pin down (it looked like a timing/hard=
ware issue for weeks).=0A=
=0A=
Workaround (validated)=0A=
----------------------=0A=
=0A=
- PairableTimeout=3D0 in /etc/bluetooth/main.conf=0A=
- Set pairable AND verify (SetPairable, then read the property; retry while=
 org.bluez.Error.Busy) immediately before calling Pair(); re-assert after t=
he pairing session ends so remote-initiated re-pairs aren't rejected 0x18.=
=0A=
- With pairable confirmed on, the first bond is permanent (Dedicated Bondin=
g 0x03) and none of the fallback machinery is needed.=0A=
=0A=
Suggestions (as questions)=0A=
--------------------------=0A=
=0A=
1. Should an explicit Device1.Pair() really negotiate No Bonding? The calle=
r is, by definition, requesting a bond. Answering Dedicated/General Bonding=
 for an agent-initiated Pair() would make pairable a gate for incoming pair=
ing only, which matches user expectations.=0A=
2. If (1) is working as intended, could Pair() at least return a distinct e=
rror/warning when the result will be a throwaway key, instead of reporting =
success?=0A=
3. SetPairable -> org.bluez.Error.Busy during post-disconnect settling: cou=
ld this be queued/retried internally rather than rejected?=0A=
4. A short grace window before MGMT Unpair Device on a just-created No-Bond=
ing key (or re-using it when the same remote immediately attempts General B=
onding) would turn the failure mode into a success.=0A=
=0A=
Full decoded btmon traces of both runs available on request. Please keep me=
 in Cc on replies -- I am not subscribed to the list.=0A=
