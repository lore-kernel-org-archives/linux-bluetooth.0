Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013030.outbound.protection.outlook.com [52.101.72.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD93932EE;
	Tue, 18 Aug 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046145; cv=fail; b=AQKtT2ZXJ29LC6jAXwWib96KeSuzwS68DjVArXAgyvaWePjzjNGyNrrz46v0+bjOQt+76f4C+aiU5CJTR2CWs+3oOoYHWbIWrDqwl6kkbFSIkjconRBCCwrL12nSpY5GF4q0EBKWEFOv1b3UY9Jjh2Y/CJ3QYLGimdsAmFqnDKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046145; c=relaxed/simple;
	bh=972ZxZNKvThArHlNks8/DYnkDwV2cduJJut6uaD2l10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N5GvG0Mm242EGq3NS145g21ADL6O/EfnYOKt+SoaT9YY3NB7fCO9zTOUTUhHWaJiVcQT9H/Rr5yLbVC+pcgp1MTpmZnPf9Wp6UZgkuAJI7OropihOV2piz4ja2b2EPbX2pjMweCtyztgkxXArsSgXL6vnan1/OBhGvYFipfhx50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n3QuR/R2; arc=fail smtp.client-ip=52.101.72.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3QuR/R2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0al5kQVKV6BT4zjpieQJgiu9WIxLFbF3aHqZ+v1/xMuYfeAie2WP/GicCYGA4YKWcIxFIsXRSbGn7qHMznj73TuPHWIPDix2vCChk9LsXxzO27ptuNEixF4QBKG7RtTnXGjRhC3D7U+/wn/i1w5hhs4TlFv3/Je2wWKYK8TT44+Dj0nS+TTu4t2cxTOBQf5MOSBe4vuNpTjfjKDXrqDgu1IhqAr8OJ9Tz/OdPwPeBTTPSk5OMsZBm2kvbrYuNXbmpD1TsYIew+KnsSG6BKBJyo1OMzDKhLXu1cTmoY6+iXpB7PYoYypbG/eoxhoV5VQRCLY+vk22oFkoOy7TOc5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMzQsVaMpJM4h8+x9Rft4oxKlgGOKGjSDE9uYQImcvY=;
 b=umFC9RIsf5Cn7oJrZ32knIluT/wz5J4J6Zbs0CMZ7CwCYagsznAHJui4p972+IYhSIe3S3LVAJOQR/Vo+BONPUts7r4i82hzvnMzw6TrdEEScwHlQxASRDPcJgLFi+h0TTdwgV3EZPq8zldJfcwXdx5+Dk/932oyoiFqD9GmsCUiaknwtUTVqVD52XrNDtLhHmOtltEEf+ZnmhuOmWNmw48wZhpQ4/ddrJg+iLptQahlYKBFm9APWidukbTpsC6cDVH9xuLy/8VU3c0Q5NDkXe0gY4BrtIKlzyIbU5gl/3pdDQCmIm5/TyLrJqsPmwqxXc2oIo5azu9paVPzrJv0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMzQsVaMpJM4h8+x9Rft4oxKlgGOKGjSDE9uYQImcvY=;
 b=n3QuR/R2oPrItxwRBKMRvQaEqSfV12YANDu8mt2NmgN9alVSbH0zlzbUWdsvxfqSw1h7hdQZu82xdwcZ3Q3G5LI6aseAIz93BF0SCYxymtxjRtaL+Qt070mR9xi6GpOOWDx/WBIa7IImLrJMYkF2zFq8v8KQNcr8sNx/nZ8B8a94HbE2ipeFJbVpUgTBhTFmKQ+fu5hFjkjSthP/VMvZZnR3u438ItYh/W3FHOeQvQcRD5XK8MTF5RP/LbJ/3WL7YGhWq6QIBeFw9lRY+Ftmj+f/WpIIF/lNlTqaefRDM6rEeNcFQjQJlTF2LOXaUFUL0RIBouwFhWqdmIZYA9tTiw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AMBPR04MB12567.eurprd04.prod.outlook.com (2603:10a6:20b:779::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:42:21 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 09:42:21 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: Alex Zhou <alex.zhou@nxp.com>, Song Xue <song.xue_1@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
Thread-Topic: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump
 chunks
Thread-Index: AQHdLvXdSNn5L6FnqEq9WkiuML82cA==
Date: Tue, 18 Aug 2026 09:42:21 +0000
Message-ID:
 <AS4PR04MB9692A4C20F6FBF002E08A7E4E7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
References:
 <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20260818080104.563675-1-ali@iusegentoo.com>
In-Reply-To: <20260818080104.563675-1-ali@iusegentoo.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-18T09:41:35.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AMBPR04MB12567:EE_
x-ms-office365-filtering-correlation-id: 42bfa3f7-fa94-44d3-1ec2-08defd0d0059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|38070700021|6133799003|4133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 kbPOza44elGOe9naKVzvs14azbkdgGdKNHabDzRZuGRs078X5Fo5wZmU0sZaI6MTw4MdqD0WrxbvKsjkN5A3Ar8wW6BaeKyQFVMa6IIAYjlDPx2KVR1qBGyF8eD3EkyK9RAIw/pZUz7p1rPbZPzbkqKGNLy3ujBI9wqmdWnccxC87UkFq0bqEDMafmy74juc3QV32fvPrmMWa/3aYlepI2DHSjYaPfWLkZ4bQ7vJpvoJ+hJfNswklwAXKxCR69TUO9WesEoiFDmWKyvZwnJ2SjQLARpb0K56Nw3MWe1JsdezTexnRQsCqgGmJITU+nUi2fRJC098Ux3dHbWGpZzgOYHPisHHWfxAeng1c/GdeHTUTKe/QQ2yJX8K8OhUPisysC/lDpGV+5f12Ol0dSSTVwqrFVslBF5/AwfVKLBLzBH9FqZzdaIxer3QsM5ldC08cYHFLsZTGreNtsRqJFyd8Q4GE9oVE28LBiRbZsSs5srUy+OQ8VRj3h6D43N++widnXOyCOFBhe4iy1Q2zi4uWO7rFvAxGiSZ0U4SDRdo1mhI0m9RhRBXHz5p6wV9oY5qmZYVwflaFHejlNfQTD9w1Zp1m4cyXN9Cf6YSUS4QtUwz7rfBOJdJTLqi4NPzWQ0v0S++3dZ5FwsjFZz+hyAVhKanmbDZEcRjIdckWrM0qt4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(38070700021)(6133799003)(4133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D98IIYHyy448YXY3nk1Uaa7RoJ3FS4pllP/uiaV6XcUGU9OJEwp+JNyu97Si?=
 =?us-ascii?Q?4tLfSpF6N5YtPFglA4nSFfBZE0azuKSrYo3DXd0H5BtjPgk+RZ2oM9SX9IAK?=
 =?us-ascii?Q?aiD6bxuWG72LyoAtWQ0CAAX2M/iiGMtUS2BMDlVxbCWe2k73kBWPiRMp3eQf?=
 =?us-ascii?Q?cj0F3BR7Z10UpzOi74QqCcuTQ5x2aj/QjIKCTN9Rwxv4udSG1i0tCeywlYXt?=
 =?us-ascii?Q?IpDFlqWYGYp5clGTYaC+ojSieiuWAvJXhYl6xVywXW95eQ4gzD6QPXn6eCX9?=
 =?us-ascii?Q?R6YFdN7s7aRLqnprsm8nQrLG9QyV26uk542PD9TPchH4B7g3FniNcYaLQLfF?=
 =?us-ascii?Q?Fk2wUVYSdx7Evv9SUF9uJmU6ocT7OnhYylh7/68b+8gvfjPabAq6hLFt6g+Q?=
 =?us-ascii?Q?4+G3PBXT/SkFYmhu/MFxBeJoswtrIiPx/Cd+ZLEIh7yzlq7AMytgH8VZQwm+?=
 =?us-ascii?Q?FYsB61LJGMaxBF101CtBr6GgG6ax6uZ6e/Ia5YqCLfdSaGqFxjVRQghKWfKU?=
 =?us-ascii?Q?YU7RoGbSHIj86WqwTptlL1AnhWWLTl0IWtB+j/2S5K0sECiqslhrvK4S1uAz?=
 =?us-ascii?Q?J5dVyki5foLItLzGPVocVD6Z1Z9BJ7dje4lHVsU93iwGqQtXJ2rl+zX33+WU?=
 =?us-ascii?Q?U80SjRD0Igjasa5/toAFpDx4gslhBAGNHQKIfkIiA6TjADYotC/b2pJ6AJAO?=
 =?us-ascii?Q?gNn0yJH/766G/USMNqVHQIVdkSPuDxn+/UAV4b2rIkF8LV8PtRE+f7SdSIoS?=
 =?us-ascii?Q?ougEu47gvrzq9zMNgG1yp5MlZVnn7gpDK0tA6Zjk4TBCuuLTRv6ohW0SR65N?=
 =?us-ascii?Q?+jMthzHjawpLrktQaasFCigJYbyGx0CFpqyZABZXIfjdTqkwx3bhQxWc2D4Q?=
 =?us-ascii?Q?Z+I7Uc/wRTShnkJ8361oW6sJC9oqPHXmJUUjyI3R+byr1X22kETwdCtvymSG?=
 =?us-ascii?Q?qLX0YaK2/ZFEVfa2YqHm+zDsoa6D5AG1e/bafY+0n0OrgHaOJwy5ma6RvWi/?=
 =?us-ascii?Q?BAk9Z7zGpQOk7oumR6mHKChjwK0BZFXMDl3YT5PWzDWbdBpBSZp/MqXP/Jvb?=
 =?us-ascii?Q?MC/fvLdCYUdWmLfkDqbaEUM9NhpgD96bnQSAhKrGep2JvQNmzEd69sym9W3I?=
 =?us-ascii?Q?Agcrr3PtJ2O2LRu3vkznOdUM3qi8a05F+qOuXiB0Md90/7uwQXeUxQrMA7mb?=
 =?us-ascii?Q?Vbm2XkqprxCci9FqDUxSq6Up0ahtO95L57B/Zuq3SGhXO+9gDOZSEJHClBbx?=
 =?us-ascii?Q?EwocJRaDQe3X63BFva/T8agVGd6D6ekn9h/mdhzCTULCeiV9P+iNxYvzFUm5?=
 =?us-ascii?Q?e1Tc+q+bmBHbpucIBHfx7MkQQKBdkSLjtV05nShkJhovvMpgq7Su1OZGLIaP?=
 =?us-ascii?Q?00nNmzRmx+Hdt3z17dmv13/vsPb5KrZvA6VtSRf9rK/zJ38E0p6pt8P0tbzm?=
 =?us-ascii?Q?5UyNwP8sLCfkO7dlKnhCDIwoUcVUOp7DTN6VTIGiDmQmeIC7jdTA1iSFGC3A?=
 =?us-ascii?Q?pmb5h5cLHAEgYZYP7B1sXY2y91ZGaXhrnGr4DOqMh+4NaCc1r86wLgbaIyc5?=
 =?us-ascii?Q?ZHth741chmkSjFgPF/182syA7dwAKZ97i5K0eul/wzgXqL1AGEZvTrHgA5dA?=
 =?us-ascii?Q?WR9ZPcq2qQNNUT0X5LMcTelzEWy0VOowCmZmxsY2MQeGjB38sOHxzsJ/dc/1?=
 =?us-ascii?Q?7P0Wi0eeKj6cOmtOloRXF0zEowDHssD6Zcvz5ntg5vowGj+c9IV/+P6nA/DM?=
 =?us-ascii?Q?464xI/Ny1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bfa3f7-fa94-44d3-1ec2-08defd0d0059
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:42:21.5318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7AqmkQHVgFmMBUgrBe3fEvR2tbeo5G1Avt6X0n9kgPdpTe3NVdQFNFgMcAQYwtRRMu041HxYW2RX5MKkjb1pFkk/xQQUvo66BYYY6XUu+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12567

Hi Ali,

Thank you for the quick fix.

Reviewed-by: Neeraj Kale neeraj.sanjaykale@nxp.com

Thanks,
Neeraj


>
> Commit 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump header
> length") changed nxp_process_fw_dump() to use skb_pull_data() when
> validating the FW dump header.
>
> This also removes the header from skb->data. Since the skb is cloned for
> hci_devcd_append() afterwards, the FW dump header is missing from the
> coredump chunk.
>
> The NXP FW dump analyzer expects nxp_fw_dump_hdr at the beginning of
> each chunk, so this results in invalid coredumps.
>
> Check the header length without pulling it from the skb instead. This kee=
ps
> skb->data pointing to the FW dump header when the skb is cloned.
>
> Fixes: 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump header
> length")
> Reported-by: Neeraj Kale <neeraj.sanjaykale@nxp.com>
> Link:
> https://lore.ke/
> rnel.org%2Flinux-
> bluetooth%2FAS4PR04MB9692EC13E3176B6D7525D097E7A72%40AS4PR04M
> B9692.eurprd04.prod.outlook.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale
> %40nxp.com%7Ce5c09f2752bc463e224608defcfee41a%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C639226368879983123%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DmEFZvI
> Xr7Buf8x4p9NDDl3B1mJJR93pBKXZuARuRmX0%3D&reserved=3D0
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> Sorry for the late follow-up. I missed your reply on the v2 thread and on=
ly
> noticed it after the change had landed. This patch restores the approach =
from
> v2, as you suggested.
>
>  drivers/bluetooth/btnxpuart.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index f2bbe6e462aa..16d0f709d4b7 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1359,14 +1359,14 @@ static int nxp_process_fw_dump(struct hci_dev
> *hdev, struct sk_buff *skb)  {
>         struct hci_acl_hdr *acl_hdr =3D (struct hci_acl_hdr *)skb_pull_da=
ta(skb,
>                                                                          =
 sizeof(*acl_hdr));
> -       struct nxp_fw_dump_hdr *fw_dump_hdr;
> +       struct nxp_fw_dump_hdr *fw_dump_hdr =3D (struct nxp_fw_dump_hdr
> + *)skb->data;
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>         __u16 seq_num;
>         __u16 buf_len;
>         int err;
>
> -       fw_dump_hdr =3D skb_pull_data(skb, sizeof(*fw_dump_hdr));
> -       if (!fw_dump_hdr) {
> +       /* The ACL payload must be long enough to hold the FW dump header
> */
> +       if (skb->len < sizeof(*fw_dump_hdr)) {
>                 bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump ch=
unk");
>                 goto free_skb;
>         }
> --
> 2.55.0


NXP Confidential
