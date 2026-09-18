Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021130.outbound.protection.outlook.com [52.101.65.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E093B47C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738047; cv=fail; b=gHrpW9GjddenlmpHdWwF2/R/cP6wP2mkP7sWJdCTEbWKN76G9dlk6Mc2oKHcTNm757aN8LEVNnRsCA89bCGV1hjz75JXQ7gy2EVwYp5HE2sXFXrRXSRsUhxFr2XiYgAFSASVnbTRbP7aTVpUKMSK5cukoNhMqsSJvYHxCTfDL5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738047; c=relaxed/simple;
	bh=SbiDmxmluGOyCAsq5KYvEMltBjPAGkZVJT3+C8IoAAg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MvhRaTuDJgvJoAZi+CKXCPsaBYnUsTLLaiTqVmEWD9ngVFGDpBFFwj/n1etH6wIPJSukmoDlt5WFcuiFMRa88/YMvsVBPnpz+DhWpu4ciwuNRBwLpbGLxukb3a7U2z4uogK2iozN26JQQBL0Osnvz+JMKTgFoavB5WpKA8tzd0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=WSRnIPTz; arc=fail smtp.client-ip=52.101.65.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="WSRnIPTz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6dzdXaQU4Vp3fL7HWzVHW+hHi42MKd4231nU6rfufGp6PXBRdpejy4X5uSAxB5jjl0OWQIqJ8ZCKOVWIKEIArKhWmmsHrsV+4w1aVzOxBJnK3wO8WEagz6m9Rvf6lnKAEUYdgDzvHiCWTB4Hs9bqUDmr3pPMwBa5mkdatVxOKsjM2ptM2BbD8Z4fKWNqkGCJhXHR61xPWhBzuZF3iyx4uNzqaQGz68vqR3b53xmdH3oPGTdleQR34nC6bCfw5Fj6BnXraoGBcJIgihw2QYPPodQpmYJ6iFphYAIkAUKvjuwaNIsNUSzt+evzNr9SFgSWlqinlmEDOGGc/9pXkHV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97YUpIuai1QYj7d0FP9S+YbVpYKiB/At4Gd4gFA5+Jc=;
 b=NQpVOtO9i+NhrK8MKWtbRQtMABgnJH6DJdnUiBkUarQC51a+pM/FKOmMy2GKJCBOUIUkJH1puOHFT2vrQd3Up3Mxu8R2FMTjL8I4JrojAnwkmYhK3PwZJV9PUrBLk0xK8oO0KGyzjXTmJCCfjsmZp1Ynmwx8axwSE+7KBkO+2xyS0X+5hhc5IeEJDcJAJPCw/t1ACacw953UtbXX0yGD/Nchpu5thVqSiFtmAmAEw5e4KIe/vs/UgqYwzjMDPG/CMVMSab8xLCb58F27DARPFzoM17MRIVT6fyi9Y20ajekmlr7yWZw8YsHKN/jmU+icJAapfrlT5XB2iguhiCNCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97YUpIuai1QYj7d0FP9S+YbVpYKiB/At4Gd4gFA5+Jc=;
 b=WSRnIPTzu14Um+nHjUbspL2u1R+XIGZa71Kq4ofxE1Xm5IZN8TQTM7e2O72tXXD7SXUWA1joETIUvJwj9J28eIAkR04MV8lOfxSx1DK0GUeqRuI2I/sby1vGzUaX1KXT/o6XEwfflGDkDWNsFpemp+9gKAe/WYQk+FpvS/WJvmg=
Received: from PA4PR03MB7150.eurprd03.prod.outlook.com (2603:10a6:102:f1::17)
 by AS2PR03MB9221.eurprd03.prod.outlook.com (2603:10a6:20b:5fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 13:27:21 +0000
Received: from PA4PR03MB7150.eurprd03.prod.outlook.com
 ([fe80::e397:f26c:9c11:ef66]) by PA4PR03MB7150.eurprd03.prod.outlook.com
 ([fe80::e397:f26c:9c11:ef66%2]) with mapi id 15.21.0428.009; Fri, 18 Sep 2026
 13:27:21 +0000
From: Mathias Grelck Johnsen <MAJO@bang-olufsen.dk>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ] adapter: Set Audio service class bit for A2DP sink
Thread-Topic: [PATCH BlueZ] adapter: Set Audio service class bit for A2DP sink
Thread-Index: AQHdR3FurO5AKN2Hw0CJ5lQlpmxgdQ==
Date: Fri, 18 Sep 2026 13:27:20 +0000
Message-ID: <ee9afb98a878284f53ec62d5d19a3d34048d3372.camel@bang-olufsen.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7150:EE_|AS2PR03MB9221:EE_
x-ms-office365-filtering-correlation-id: 77ce0185-ed25-4e77-32c3-08df1588917c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|10067099003|55112099003|18002099003|11063799006|3023799007;
x-microsoft-antispam-message-info:
 uIpbOfWND68aJTkyyrLD8P7MPinQ/GQKU6cX5A20wjS+Mb1sSF2SJtxZ4DGOXETOGbD4B1sEjCrLDi9FhzmdEq1dyanABhNnwjP8RBl9alhsvs2ltQISSV/YAMTQSz/rZR6EK0rpb8E1c6AB6tJ6DyVE2OMOr+RYtkVcPX6itCBP7B1/02yBu6BTak6U6AGKjJaKjcI+zUjC1tofPI3f3gCIh7VRvkpMUy8dwgkwhNmakISMmLI71yWjSiTPG60XBCperkmW8d8nLxwgtVHSXbH2iDa4JH5iXoVo4MNVojBIvPA57B8Esj6Qj053xUlq9+KsHRQAoPZJF2BF1AEyoTHRbDiazGnLJFizz0B1dlqSi62J7XRtNQCZ+V4iuXu0jvL5Wz6YlzHCSxbWFU/w6gaDrT5FZMpxUa0+YaGvtdOhGfpbWRkvqKU7QZ0HalAXtchWCMoDi9sIH2xgHP8CTF4pxh7eIi8bSGyKV8nI/8F/VSCeW2s/eb60bi3N7oEG5Jv0uiZ0HRcBNJ+g86+ksG/TrmufY8UMKOTmUBo6AEgnOQh9e0y4cM4T5mvefaG83SoKPhH/RrPEWfldtlJQAVvFgI7GjNBbJXAe3wHA+t5xDRW9X0pFEf0y4nM4rjtrm9hr2RIAWiP8ACbVFT7C/2kI7ML21/115bnyY4XiI5rSCChVYrR6PPx6IIdoZvTD0tfgUcOobctlduRViNXuUsZ9XCcPeVVTAojqCzafhAM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7150.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(10067099003)(55112099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mzR+8/ZNMrFnVbcStvM4t3yWM8N6oPgmUyetbBu3R5EezR3KwbRbEKK8yOir?=
 =?us-ascii?Q?AL3Uuhvllw/L2ozw4LjXHycUnSchr6dVU0+oTimPIGylf+gBygNpfgTisBa4?=
 =?us-ascii?Q?1WyPdB/73quW2u/qIo+gX/3WyDNHb2RZIH8wZjnrmThmpEEIz9ncsbOzodWl?=
 =?us-ascii?Q?sDNzFLqMie6xqZ7E19NSXzZpHDzW3k3fdlFO9BHBAN98WPJjK9EtDfAXA0dC?=
 =?us-ascii?Q?2VwWoMBTGIz2h1z1y68A8T1QQ+mbNfY5Ds2AMshXqE1BjwHWhXZc7dmG6D8V?=
 =?us-ascii?Q?IsvmgweUYcZo5B8o0pJCeN7LpsWTQTwnBQ0r99NN2TgqqrkdSMVoP16+OUWU?=
 =?us-ascii?Q?MQAvyCZviznVBCzSmQr9BRKN/lFhczVhuuokz4DQS1tiA8kAqPK6ILJDphQB?=
 =?us-ascii?Q?N0Oi3xYD+fUuNnhCclR+B3QlErvgtD02JxPKkxW2BBFBx5FQhJboML5qXAYm?=
 =?us-ascii?Q?k7TbUyqWUP6alHsTAKUmae3mWO84JFuBjdTWhnY40qUf8R4y7Ysugml4dEem?=
 =?us-ascii?Q?/ZBWhCUxRGFzvFLLRdPtjd8QplQOscI2L27I+VtjP2wrgnOxuCh5ynoxw61J?=
 =?us-ascii?Q?GRbpQHAnmxDwx5VQUHvFnJ0ILWcAMAM7vBMl+iqGBmaf8hItxAb93nZzDf/v?=
 =?us-ascii?Q?8F0rFsoPZtDI++xM11o9bMB7ps0szEjsKvund9zMAknUgRKiqzpnEzgdg+U0?=
 =?us-ascii?Q?L3nPggON92tMHra2LfpFiM0buiOxhgCZjPLHMkotWmIGcP46LsjTLX96VJUx?=
 =?us-ascii?Q?aaBen+2xtv7otg8jSiRTxpQ02o5ffZgHXsTbvbsw3djD2l3uE893D+l+/wap?=
 =?us-ascii?Q?uJZlP0RmdZN9pczMpQfN/puKJf0b0n9NAXusELFGGJ6F//K4QFLfEJPMljMx?=
 =?us-ascii?Q?e9LaSlhUKtnR0voTwfLdIVhuSanO1mQvJpBvHcX4S03dDdzP1rjZerpcc+g4?=
 =?us-ascii?Q?gapTA9wdih9xk9VHkG92Suor/4QMYdn5b51timZI8oxDpQMaiK6ie4TmODVB?=
 =?us-ascii?Q?Uvjxewtk4NJDsb7srT0HUHt6GYmK/a5yPP3IVMNxwPlhc5+9B33ry1XebAWG?=
 =?us-ascii?Q?szgSRPuX83OXOqFGsiWQD+nCtQC9w6s7fRybQaPZrsIPiMNB7aMiKhq8cjC5?=
 =?us-ascii?Q?7/N+Ph+SxOkKTIc+QD2xTkC7T1wS9m8BcT7hsTphsTRGBeDBnBnyN2eaKPLd?=
 =?us-ascii?Q?3pcVrg1EnqGW1DhRW9R1Gu8YoWZXRqTxuOyDrSWWwGzfFw0WENV87VG5xEy/?=
 =?us-ascii?Q?kZ0x3Ox76txg/SFRhkuLMMTIZnFxyj5txO13aIxbBQ5UtmXuQ65Kp//9wuci?=
 =?us-ascii?Q?mwbMXuJZSsEeRaQq+EKl0POdTuaMXQ6oaEjY4o5P64Td9QrWZZr6qB8f5iUs?=
 =?us-ascii?Q?cYkBLOHf0aM7J9rvU3RdTJxjMOku2vCIIFBgSNhl8jzS+zdpJRH3RpSkUXeR?=
 =?us-ascii?Q?2pK+qiGH5rwnBQQ1nyIREoyjILi4KIMKsWuUH0G5lb8mgeE4rdIAud7gNBcD?=
 =?us-ascii?Q?5I4+nfynQJ7RhMTkRgl/kaUVGzUod9dnUSVkoYnvlAF4tAeVpwdsLAhgd9yO?=
 =?us-ascii?Q?EkAITKA48v0JePSrtskve+H0cQfAFXgepA9F486UW9R5Jr3PiF2r2fcwT3Tw?=
 =?us-ascii?Q?MBjW+0ECZ3gwst+GAlz3PsmavL6XL3jVgCcYbBOQFsLkQeJvO3yVdX9guwBc?=
 =?us-ascii?Q?ZyWDnQWPzBNB5u71YBUpOlWR/DOWbjkvfvyAZatWnTFoPwdU3iBh6QnIWR3M?=
 =?us-ascii?Q?J2jKE7x8Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E48A56F49A791941B8C6587A7C6FA07D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7150.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ce0185-ed25-4e77-32c3-08df1588917c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 13:27:21.0231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpOZWJniim3pYr0kFymAaRPRB7G7LjgOkbiWJcPIWI+DP1knYTLj35nxxCpKYGF0FKt7173UvRN/tsGZQ0ATLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9221

From: Mathias Johnsen <majo@bang-olufsen.dk>

Problem: The Nintendo Switch refuses to connect to a device that does
not advertise the CoD 'Audio' (0x20) service class bit. It completes
pairing, takes the link key, then terminates the ACL with reason 0x13
without ever authenticating, encrypting, or connecting AVDTP on PSM 25.

Cause: get_uuid_mask() currently only grants the Audio service class
bit to HEADSET and HANDSFREE, so a device implementing A2DP sink
without HFP or HSP advertises 'Rendering' with no Audio bit set.

Fix: Report 'Audio' in addition to 'Rendering' (0x04) for
AUDIO_SINK_SVCLASS_ID in get_uuid_mask().

Tested on a Yocto-based speaker running bluez 5.65 with this change
backported and compile-tested on current master. Note get_uuid_mask()
is unchanged between 5.65 and current master. The speaker under test is
purely an A2DP sink; the patch changes the CoD from 0x040414 to
0x240414, after which the Switch connects and streams normally.

Note that A2DP v1.4 section 5.5.1 mandates only the 'Rendering' bit for
a sink, so the current behavior is conformant as it stands. Conversely,
adding the bit is not a violation either: Assigned Numbers section
2.8.1 defines bit 21 as 'Audio (Speaker, Microphone, Headset service,
...)', which a loudspeaker A2DP sink fits.

This is the same kind of device-specific workaround as the
HANDSFREE_AGW telephony bit for Nokia 616 carkit also present in the
get_uuid_mask() switch-statement.

Assisted-by: Claude:claude-opus-5
---
Switch system version 22.5.0. The speaker under test implements A2DP
sink and AVRCP only, no HFP or HSP, so get_uuid_mask() never grants it
the Audio bit.

CoD before: 0x040414  (Rendering | Audio/Video | Loudspeaker)
CoD after:  0x240414  (Audio | Rendering | Audio/Video | Loudspeaker)

btmon excerpt of a failing connection, before the change. BD_ADDRs and
the link key are removed; nested SDP data elements are elided and
summarised in parentheses.

> HCI Event: Connect Complete (0x03) plen 11           #21308 302.177551
        Status: Success (0x00)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)

> ACL Data RX: Handle 2 flags 0x02 dlen 28             #21350 302.288211
      Channel: 64 len 24 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 19
        [...]
      (search pattern: Audio Sink 0x110b; attribute IDs 0x0001, 0x0004,
       0x0009)

< ACL Data TX: Handle 2 flags 0x00 dlen 58             #21351 302.288706
      Channel: 82 len 54 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 49
        [...]
      (Service Class ID List: Audio Sink 0x110b; Protocol Descriptor
       List: L2CAP PSM 25, AVDTP 0x0019; Bluetooth Profile Descriptor
       List: A2DP 0x0103)

> ACL Data RX: Handle 2 flags 0x02 dlen 12             #21353 302.293176
      L2CAP: Disconnection Request (0x06) ident 6 len 4

> HCI Event: IO Capability Response (0x32) plen 9      #21357 302.298185
        IO capability: NoInputNoOutput (0x03)
        Authentication: General Bonding - MITM not required (0x04)

> HCI Event: Simple Pairing Complete (0x36) plen 7     #21398 302.649188
        Status: Success (0x00)

> HCI Event: Link Key Notification (0x18) plen 23      #21402 302.672037
        Link key: <redacted>
        Key type: Unauthenticated Combination key from P-192 (0x04)

> HCI Event: Disconnect Complete (0x05) plen 4         #21403 302.675468
        Status: Success (0x00)
        Reason: Remote User Terminated Connection (0x13)

The Switch tears down the ACL 3 ms after receiving the link key.
There is no Authentication Complete, no Encryption Change, and no
L2CAP connect to PSM 25 anywhere in the capture. The following
attempt repeats the full SSP exchange rather than authenticating
with the stored key, so the bond is not retained on the Switch
side.

 src/adapter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index fc734424b..98d758cdc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1303,9 +1303,17 @@ static uint8_t get_uuid_mask(uuid_t *uuid)
 	case AUDIO_SOURCE_SVCLASS_ID:
 	case VIDEO_SOURCE_SVCLASS_ID:
 		return 0x08;	/* Capturing */
-	case AUDIO_SINK_SVCLASS_ID:
 	case VIDEO_SINK_SVCLASS_ID:
 		return 0x04;	/* Rendering */
+	/*
+	 * A2DP v1.4 section 5.5.1 mandates only the 'Rendering'
+	 * bit for a sink, but the Nintendo Switch will not connect
+	 * to an audio device whose Class of Device is missing the
+	 * 'Audio' bit, which is otherwise only set for HEADSET and
+	 * HANDSFREE.
+	 */
+	case AUDIO_SINK_SVCLASS_ID:
+		return 0x24;	/* Audio & Rendering */
 	case PANU_SVCLASS_ID:
 	case NAP_SVCLASS_ID:
 	case GN_SVCLASS_ID:
--=20
2.43.0


