Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F671F419F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815871; cv=fail; b=k138un1nzUFKXY7RyOc7sWTBRMlChc3QmdmzkVlQ5+cSaNJEGTC1uvy0fE68uLMlR/quKcYR5DYoFn4qKfBfCXoxBSg3QCQO1j7IG3sMWHUbx0KqHoqYYQQcuSGD4kO+OII32Q/A99su/EpZ0Kjx25jU3C/jYI2s7voGQrVNp5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815871; c=relaxed/simple;
	bh=aykA04Po9YgdPfRrnoSzbSlH2TGZiqf8zcpfdf/PsBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IImK5/MAaJDushwmwpB8I2rrJ63427/63RLmBV20g/gCjawFccxNttkIX/5Zx6v2e2Tr/RYMtQZNsalVbeMt+FmjTyWoHhebUAVilG7MyXa1aE2WHh1a/pWcpD0r0utlPJezhwSokhUf3roj6WQfl3xDcW1yDPuFTJ+meqemkBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=QagHuIam; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="QagHuIam"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHAgGa2loAECBTn+w4hVJpBT83u/Paz+G9IXrZ3hoV+ZT6KqZw3xdP9PH95wVG5xqPJf9wFSjXoE/coYsj9IzFU17RIo9CNp1eY4RAqbV/XLuRF7NUVKb6CkrAxu/esEUDlu+5vman5WlAswOOn6fjX4Ic1pPiD6OWZtC/SeR6P2hbql6WOU2xwldp6VzeC0jg+s83MHRPuQBug2GMdnhSRL2LVj2OiPMyp3TTDkuRO1Zctw35rD3ecd/YDkuW9ukAToqo6Fhq8bsBoseoMw1g4Qyf/xrHKkT/6tNgDDTrtCBBv3wQXL6df0cCfq3h/MNFZUfowPjsGWS9xF8lfrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7lHXj51w3dv9AIdUHT86ml5JiyBUvNe/iUQmosEWPk=;
 b=TpRULn4JKQrELd96F+F9rsahSt1E6sDQtOgwKZgOOPxmL7QFpJryaRlxun9pLRlkQQk0QMWaGnhQYdPJ2RhlDl9FlZpeAoK5b4sJTTp4ZwkLUe6LyxGB1nd3p4PLbJaXgFgc0MO7vekNoxOEMngtL8eOuAAAUCsbgN4lZ3LE9qmxBKnki1mwoP23lHoLFSORVkqPlTm3V1IuRo5ZikHG1C2qSCSL/zZUL4MHCq7rg8llQViFPMGatQF64IkFImZAeaREIwqYLVVWnolgJcCnDeYSKU1/7HvMf7n++sEBfowjQLnkRJQsN82bD8mm+Ee9u26gWXTXQvq/Tr/85UryPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7lHXj51w3dv9AIdUHT86ml5JiyBUvNe/iUQmosEWPk=;
 b=QagHuIamefAWqO/LC29nzkStrfmM2WgrQENM5h6Ba36zirdRDNO+VP1rBOt8eb8cQcMBQfKvohjRBgavo7gzGNPJ1Blgyimp10n5/xOhklSRMDOqha1AV7ZjkgEq9q886KSejS7i1AWrWyAB2CXZ3fqWQoRcamAe+K8FAXEAbu4=
Received: from AM6P195CA0061.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::38)
 by AM7PR03MB6530.eurprd03.prod.outlook.com (2603:10a6:20b:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:17:42 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:209:87:cafe::72) by AM6P195CA0061.outlook.office365.com
 (2603:10a6:209:87::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 13:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 13:17:42 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 11 Feb
 2026 14:17:42 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, <frederic.danis@collabora.com>
Subject: Running GATT/SR/GAI/BV-01-C and GATT/SR/GAI/BV-02-C tests
Date: Wed, 11 Feb 2026 14:17:42 +0100
Message-ID: <5832992.IbC2pHGDlb@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AM7PR03MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 506898b6-e67d-4ca5-2db9-08de696ff049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUpLZStSVkI2TndYSnF2cDNjbis4cUVhUE5HTHhwUTdOZWRlOGNFSkNMQWRN?=
 =?utf-8?B?SlVqejRCNWdTcVpseFJLMDNvUk5Ra1pCQmN6SjRPUmhUb3NTYUVKdHRGbU9r?=
 =?utf-8?B?YytyVG1qdVJyelRFa0dRaEtxUlJ3NmdvNXdnL3psT1RLSyt0WkVvSHRMYjNF?=
 =?utf-8?B?N0UxV3llVFk1OTlxYkNQaHB2QnJWTzAwejRnQjFwMkt3UlVPQ0dKRUI3dGpm?=
 =?utf-8?B?UjBDWHhvanU4d1doS3I2MmNvdmtDamdQODM5SFFRaU92TGU3RllzVzlVY2hH?=
 =?utf-8?B?NjFkQUR3YTF1SExjWDZERDNHWnEvMm9ncVF3N1JpUWdrVmFGRTV1UWVGMVNL?=
 =?utf-8?B?aXJtUFZOWk4zekFyVnlwMnFIUEl3ci92YXB0NnlydUJyOVgyL0FWcjNrb21N?=
 =?utf-8?B?azA5OG1MZkZUbFVvd3Rqam1wd1lUaUJQUjQ2Z3dMeU5UUWF4b214MEorbWJE?=
 =?utf-8?B?YldCMllpVjZQT2h5dlVlUXBneE1qREY5bkR5MFdqRkw2QWN2MHNzR1dpV2pj?=
 =?utf-8?B?Vzdkc1RVZlR6QzdieWRNZXF6UllwemFFYys3WGNVMnRCWDlpSXlEQ1RoK2dT?=
 =?utf-8?B?WmRoSWxDVU90V21hQ1p4TDdHblRoWW1IK1FzcjBMMll0N3RGQXZ3LzkzWHg2?=
 =?utf-8?B?dkgrZ0NtMVREa0hRUTA1YW9MRFVkNkJFZ2poYjNya1ZEUDc1RFJiWlV5VStV?=
 =?utf-8?B?eTBUNll0Y25TNm4yTXZNNWRHOVRxWm9FNVAwdnRkcVZPckNXZFZZOEZtbGFi?=
 =?utf-8?B?Q2ZQbGQ3NHdBTGxQTHMxcjNSR2k4NEpZRkVKWFBwNWxGWHlTM1ZhZnFwNG1W?=
 =?utf-8?B?MWwwb0crY3E5UVdHWGF6UUNPSU1ybGlqNi9wN284NDQ1TENObTBqSWJLOEFz?=
 =?utf-8?B?RDhKekwzMitxbkVTbzVKV2d4UndxV2ZzNlgyRGN4eDJqN2ZsOHY0M0V4SThq?=
 =?utf-8?B?S21iRFIvR0hBTTNwc1dXd1VGYTFVUVNlMG52eitYR3gxU1Rmc1JyT0MyQzhO?=
 =?utf-8?B?YnFtQTJsWHdBMlFESVBEVWtmSkNUZjBxTkxPRi9XaW44YXRWa01IT3VuNnpn?=
 =?utf-8?B?RGk4YlBBb3U0YlFZOFdvMTNKcGFzWklHMW94Q1FDUzA3a0hxM25JRkNRVlYy?=
 =?utf-8?B?T3A3a3VGcHJNTHBBRk9GdmdKUEFCcmFxbFZjZjhjV1FBQVFlemlZclQwNUw3?=
 =?utf-8?B?d3VvM0ZNSzJoV3J0cmdFS1pCcFhmajZmZ0JFSzRmUWY3aTl3bGM0a28zaXUz?=
 =?utf-8?B?L0g5NHVsWm0zTVRKZTRIUGRIUmo0V1QyLzRRK25QTEpHcEdSMUFTM2ZEWGd4?=
 =?utf-8?B?TzkyeWJOUmxQOStBa2w3bHpWYkFwME9Sa3pHSXRBVnJzZFVyTWhtQys3a21m?=
 =?utf-8?B?NDFoUkJVUEJrS25YbjJOQ1gvQ0p6djRvVUUvYXhmM0xtUmJEbWRWOWMra2dh?=
 =?utf-8?B?WTBnc0Nyd0ZldXM5cFBPK2pRNmwxRXRZbGtUQ1Z2TEMrKzVSWlhJdW9aaFc3?=
 =?utf-8?B?MWJSWW1OZWdjMUFmaVUxdlFXeHQ3SzA2OUhiNmNJWkdZb3JyUHI3OHVvOEVa?=
 =?utf-8?B?TmdCV2lSVVZxd09mcXVkaEcyQldzc3krUXZtOGhCaTA5czFmYXhPdFZqdXpK?=
 =?utf-8?B?V3g0YVpYeVd2dmZtWXJVZlNjOGtyV0s4cVNyaFAyTm9UbDBmcHhjejV4UjhI?=
 =?utf-8?B?bWhvTEdpWTNjRWtSOVJmdFZzWXNaZWtYV00wRmt6bThGQWYvWjVlaHR0aGwz?=
 =?utf-8?B?WTBZdTJtOEpCUWtxbFFPN2RUMzVxT0NPcENiSHZDWXVKUU9WQ0o3SkwwNlJ3?=
 =?utf-8?B?bGJsVThRVXR0MjExc0YxQnVZZG1MN05CeGhYc1lTRE1pZDJSNkJVRFM4S3NX?=
 =?utf-8?B?c1RUUlBXcHhWa3U1dUFuS0JIamcyaHNFL2tWUnJOQkNzM1Nuek92b3VYWGxV?=
 =?utf-8?B?TmR1YzRCWmdHSFJLYmtQSXRkS05QQUUxZU4yblB5SFhYalZzM3J4Q2dqaDZO?=
 =?utf-8?B?RUY3cDB3Z0wrcFpWNDlEOGtYaHdZVTVFN244eDRMbXQwNmN3UWwzZ3NVZzcw?=
 =?utf-8?B?UXkveExTbWJKL1BlQ2QrdWV0R0lLem1EYXVKRDJQUDJBMVhPeWIySFprRmhq?=
 =?utf-8?B?K2VEYis2VHJxVklLT2RwZ2t1aWkwZXVoekY5b0pyaGRjbzZPMlZxVFIzb1ow?=
 =?utf-8?Q?9Jw5TaEF5b6PXgecglWC3IQ=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zO6krjFErfni5Ri1/9KkRpdTeQtuh91jM1HXMrYZWApuYDy/kNfd3+poWUhrO/RV+ColEwTiugfpotdoqw06wbts/W8Lh0h1lFDidc7b8AYNvIcoW6/1qbDhpp8gQlYP222DW80C2lkHC8R4+reaPBR+P1aF6qjzc3xBGvCtv8ba0fybh5Ld18oz1x3KP3h/woRTapAgX0MvwjKNuCS6H4qQo40qQJWOQoTMiVIw2C+urZChDhPSdlIBQ1uargOp7DhFh2zuaNxQbAfg2ovzy0oLodltsewkNyNToIQW5rGdoIlJvhEwkRd0tJwScS7yjfsaY3tlqsTnh2vGN0h7Q1Lx52FqNWwL+zz0FrvfWRRCn7s7zlLqVqWiE4+ZHA/g7pCcBAkij/j042juAE4jtHeHLoFP5ZGbFjAykkDXd+vq48m7rU6cIeSKSH5HvEY6
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:17:42.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506898b6-e67d-4ca5-2db9-08de696ff049
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6530

According to Fr=C3=A9d=C3=A9ric's instruction [1], GATT/SR/GAI/BV-01-C shou=
ld executed
with a custom service/characteristic added via bluetootctl:

+------------------------+----------+---------+-------+--------------------=
=2D----------------------------------------------------+
| GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':=
                                                     |
|                        |          |         |       |                    =
                                                     |
|                        |          |         |       | - [bluetooth]# gatt=
=2Eregister-service 0xFFFF                             |
|                        |          |         |       |                    =
                                                     |
|                        |          |         |       |   - *yes* when aske=
d if primary service                                 |
|                        |          |         |       |                    =
                                                     |
|                        |          |         |       | - [bluetooth]# gatt=
=2Eregister-characteristic 0xAAAA read,write           |
|                        |          |         |       |                    =
                                                     |
|                        |          |         |       |   - enter '1' when =
prompted                                             |
|                        |          |         |       |                    =
                                                     |
|                        |          |         |       | - [bluetooth]# gatt=
=2Eregister-application                                |
+------------------------+----------+---------+-------+--------------------=
=2D----------------------------------------------------+

With the current PTS, the test is being stuck waiting for on indication on =
the
characteristic with the handle 0x0008:

> Please send an Handle Value indication handle =3D '0008'O after enabled b=
y the
> PTS.
>=20
> Description: Verify that the Implementation Under Test (IUT) can send han=
dle
> value notification to the PTS.

According to btmon, this is the "Service Changed" characteristic,
which is automatically created by bluetoothd in populate_gatt_service().

bluetoothd[511]: < ACL Data TX: Handle 24 flags 0x00 dlen 27               =
                                                           #36 [hci0] 1187.=
212787
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
=2E..
        Handle: 0x0007
        Value[5]:
        20 08 00 05 2a                                    ...*          =20
            Properties: 0x20
              Indicate (0x20)
            Value Handle: 0x0008
            Value UUID: Service Changed (0x2a05)

It looks like the testcase doesn't use the characteristic (0xAAAA) set up v=
ia
bluetoothctl at all. Instead it seems to pick up the first characteristic
returned by READ_BY_TYPE which has the 'Indicate' (0x20) property.

After comparing with the instructions for other tests, it looks like I need
to use 'btgatt-server' for manually sending the notification.

Q1: How does btgatt-server interfere with bluetoothd? I guess that both are
    listening on the same CID? It looks like btgatt-server has precedence in
    accepting new connections, but how does this work?

Instead of following the bluetootctl based setup, I then ran btgatt-server =
and
sent the notification manually. But there is another check in the testcase
which disconnects/reconnects the ACL and verifies that the client configura=
tion
descriptor has been reset to 0 (GATT/SR/GAI/BV-01-C, no bonding) or been ke=
pt
at 2 (GATT/SR/GAI/BV-02-C, with bonding):

> 4.8.2 Characteristic Value Indication - by Server
> =E2=80=A2 Test Purpose
> Verify that a Generic Attribute Profile server can send a Characteristic
> Value Indication and that it retains or resets the configured CCCD after
> disconnection and reconnection depending on bonding.

After reconnection, GATT/SR/GAI/BV-01-C fails because btgatt-server has
exited on disconnect and the consecutive READ_REQUEST is processed by
bluetoothd (instead of btgatt-server), where the CCCD handle (cached by PTS)
points to another characteristic (which of course doesn't contain the
expected value).

Immediately restarting btgatt-server can fix this, but it feels like this
defends the purpose of this unit test.

Q2: Are there plans to implement "manual sending of notifications by handle"
    in bluetoothd/bluetootctl?

In order to process with GATT/SR/GAI/BV-02-C, I modified btgatt-server in a
way that it accepts further ATT connections after disconnect instead of
exiting. Although the PTS test is happy (due to the retained value of the
CCCD's value), it feels wrong to me to reimplement the lifecycle of the CCC=
D's
value within btgatt-server instead of testing with the "real" implementatio=
n.

Any idea how can "improve" execution of this tests?

regards,
Christian

[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/qualificati=
on/gatt-pts.rst#n1106


