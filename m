Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AF2862A4;
	Wed, 19 Feb 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959079; cv=fail; b=TLrwHS/78yOjT5Wb674yjtjVjbvuEHXSysIgrCBNrE4enAb2fzlAoVEgrCJAQKFK2vPLgwR+GG/Jqz4NvAYF5Nb5la2rc2LhL2ggHwcCIL/6sPI13M3M8qxU57mCfJfeHUL5cKWCh6r6b+noFJ+qrEUsuZFNjwZRvQ933a96BUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959079; c=relaxed/simple;
	bh=D+gmGdjJaP/t2492HhBd7YtqNGUk73Fk0f/c49GCzJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Papmw2MVM3deNYYldv8JjtGVRWOXsWk/U8dcFlrXzpMul06rIrmplShGPtBY01x1kQK2oc1NXVZ5WQNawiDQR8gK5B0TY+ytQd5YH7eQUQcBk+fIJ1QWNSVhukCZCX/IA4RrZZDrDbEkkWP7Z5l8kfCwu+C9NyIxczN0airT9Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RDguNqoQ; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDguNqoQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yv0fIaeeiD8SOOQ2uma0pf5xZAR5izbhVi86dgYGuJ7Zzw7K5cpHmaQtpu4ZFDLrlcL1xyWMvMKn9vQrzp/Ekuf8nOxuE46k2HlRXDC/fWcfKoBIeIpJ7CxzM1YLjlvbjYJ8SrTXnXfeuXPTmgjjpqi4pSvYS8yVKgnUna899E5fG/DT/eLfnhsUqaJTCNS2eUMkLMc/+MsaEgM0hQT15HHQgfq3E3ViKKx9hM+G2nLik0mxEjO9rAsd3lFQVBoGVY7nZJ4tik0goC6ceA62tYL5LYhYs1gEZJiP1LUOrLxTv85A5kCMd961UVzvBKcOH7kqtTNwCa9mBVG8Qo40EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NnotRFbjyRo3X94eHKwPUXPGa/HmMNPtsZcP6qefik=;
 b=dUuX6bmGa3aPhvTR8NIEYTfAWjv2RkSKN8kgpnMDiMxCR6UINvHI9lGLkL+Ozo/lIwPRvHAF6CrG9U7+We6Brl0TD9ds9qeeg8uhuhS5B+EsK7NPpwFWVirczjfp7H/HnYvUA2/ogdykItBtHkv4JJFRfgFYl4stm/ebZ0v0gsxrq/nN8ZFpwFzUbAYL+f8pHjTRFHKsOXvkVFfyLq3MUueY/bq+Fh3X66VjEMUpWVsUBDfZ352TjcgEQ9xjqVrf8X9QTgKk+F6W7JFCHbfcayGU9onCi4v6RD1OFOwp9nIYUwkgG/f+O/ZF2J/4bdb2jM9ygR3GvbMVIsiXDhCaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NnotRFbjyRo3X94eHKwPUXPGa/HmMNPtsZcP6qefik=;
 b=RDguNqoQPphrA0CvS/iZtsna8HOw5A7mSoG90efB14016aQCHxg821r/OyIwLxpZ268uZ6jZo3LMdkcNemur0Z6maXtaTJC3uc8rfi9UxSFFTUKLT01YtntXJ76uykzRp7sDaS8UeQRD3SuHhm/JTUureb0vpiZfs5IdcHfEqhzGoun6lrF4xtBWa7bdE0/VgPvKIsoBLRve49DVYFGJ2uVyGwHbMJtzDZp7iuSa4tg1VJ/8CSCVKmJodu9/i70GexeomrH8bGCdGdCsPu7jJblwQp8CRWG7FRkywtUIktq6/TapWDPsDFVw/1uYTikt3E+fXAAIBLqJG3L6r7EfOg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Wed, 19 Feb
 2025 09:57:53 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:57:53 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Loic Poulain <loic.poulain@linaro.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>
Subject: [PATCH v2 2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin
 properties
Thread-Topic: [PATCH v2 2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin
 properties
Thread-Index: AQHbgrS9NYLCk0WGO02hl2Tw72ozEQ==
Date: Wed, 19 Feb 2025 09:57:53 +0000
Message-ID:
 <AS4PR04MB96922EF4EE4386F6F4EEC77CE7C52@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250219091512.290231-1-loic.poulain@linaro.org>
 <20250219091512.290231-2-loic.poulain@linaro.org>
In-Reply-To: <20250219091512.290231-2-loic.poulain@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM9PR04MB8955:EE_
x-ms-office365-filtering-correlation-id: a10eca27-53ee-4718-7947-08dd50cbe07d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?do4REUI13RYtkQvg7UT/VM0lLrDHCA1psiIbac/kxBMMeZLuqujyNCiuKypt?=
 =?us-ascii?Q?QI+pqpxeZMBBtbNoXviOpsdkESrCDEfEBEla4dQOoZtem7y35a6xUncdHwQh?=
 =?us-ascii?Q?GlX9iz5RNx4VAWWTilM8xS1sv73gQeixBG3cO5FnHczqOyJ42PNfBGyGGk/M?=
 =?us-ascii?Q?LeDxcD1HFtfKGhi4dmyTMzfrR34cgMQTEJYjD7na/ANcEBpxFaDFLN97ak5m?=
 =?us-ascii?Q?b7eUxV1+pISeV59S3wYty+V0bFAP7g1P1ShIA7F67vGDcVWZ+RC1/1ojwZAB?=
 =?us-ascii?Q?I9p0TPTVazL3yotjTds+JwJKxUzUhPOUP4UAKBYe5RN/SCN1zKtrL4LH7d9j?=
 =?us-ascii?Q?qxQlERR43KAd7QxyjRVQ5rKP+loc2K1jNSshj5XDFGz+R/kPDXFz66koKpwq?=
 =?us-ascii?Q?BVihgvoWWDwkUBAnFeo/31wJiygb6CoXfG/cowlssXhuGzTQ/O7RmWQopTLz?=
 =?us-ascii?Q?wr4KMzfCcPZAmhiPggFu+TAUWVg1KpzyIMBE3JGzXUos8ClAahJ45crnGhNc?=
 =?us-ascii?Q?5/ow+BUWenTdgPunbVg/bUB3+ddAg6T8j8+99VQZ4Xnrri2YLg3IoPmwGf0x?=
 =?us-ascii?Q?RNSFI1va9feOqo1H6OkSIZEo8MPfjDrURPi2p0PDvd3zHd1jPu5STq4ZuiBf?=
 =?us-ascii?Q?DV/0VCzwfjGfEADWeMpEXqJIsOjCbykH3LFcqmBrL10/uCCPR2FJgt6Ch1nN?=
 =?us-ascii?Q?C1+mihUtiASZIpqXwCa2XwtW7+nHxoG9ZFSh/EUfd0XC6runeZ/iUlI9Of+n?=
 =?us-ascii?Q?7xdrY5yvrerYd+zGnkzn+w4qGuhLe5PJhB75/XptPr7OlyU0uRiIUD3CW25P?=
 =?us-ascii?Q?n+v0t8nDHz1Er+uwtSj5xUYOuvFRxkIEUTbrNMSvthPG7fXP2FCHCEJhydKY?=
 =?us-ascii?Q?+wca2UGDR3Yf9IMF6PL+TBFkXacKA8/t7uLLVFRSlova+BNg3YXx3woaaopK?=
 =?us-ascii?Q?2guP+OafCoe8yJ7q5PLLctjU7KHZ11p5PbVAgwKHv54UibHcl3pVR+PPzO4O?=
 =?us-ascii?Q?byW1eDaOLd8oFWtc8Z74VCxEiaBj7+Un1LB4fUOitaWMqz3wZIe+H7zGapS+?=
 =?us-ascii?Q?IWKQPUNxnJyjmJsIwHBK4xmdNI2U/KFhHtGBDEW5lxLsna+T8GYowRRXRLO3?=
 =?us-ascii?Q?niEN32Ty5IPsJrAHloT95S2WIUsL4v7eD+GFa2314kH5qRsa4TkTzLs5AQZF?=
 =?us-ascii?Q?BMdEBJ6rbEYdjyFY3lAMHxxkIW7OuemhVI42oeU8m+ea/xdlKJdx4jq3ELu/?=
 =?us-ascii?Q?D1krDP1SgabpyKqxKEPxwRYjS7xiXNRTCNYmw6k7d/tvY1+SZ2AoQNcW4KoE?=
 =?us-ascii?Q?C6nkBZXTed4QfN6s+GV7YSTKIrTnwtF2KM1d0EmHcQbIIGy58TKkqmsUEd7f?=
 =?us-ascii?Q?ogFdZSfTJ54bFzNCVyBlGu2j4bY30okE+lOcpS8iczxZjdbIwyyEg5cDbId8?=
 =?us-ascii?Q?Ydw98xfqRZV4jt5joXWevAtmaS+5ls32?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Xev8tv3kc01ve0EgLbKMvqwE6MRAVD4Q2XRpVvWm47mQG88CswMSD0DeRPx?=
 =?us-ascii?Q?Or80BxJn2ypkXmX5eX5ZOlAhyNspxajj9ILrAKErmcg7NrgiK/lxLdh2CjOm?=
 =?us-ascii?Q?1YkYZqNZ/r7UeiFmYyKy/F2JzmjPjeFacbGnf4OFOElnScXjbUAmC8ntj8e8?=
 =?us-ascii?Q?f7gO+z6w7QgYqRz9GLCZuvjnXDdDC7uLDE2LdhZ7tqymu1RwVrb2T7hKuANw?=
 =?us-ascii?Q?2KL2ctDdMexbsiwmXxoR8NbI4CNpFDfVxk6XxEopnSOh2us+OQRE7l6aQaja?=
 =?us-ascii?Q?OxXpTRWidx3XxbYHxH5MCutlOUnQ3UlZCSPa9hcJcw7vTTmjWLzbZGGnIdAX?=
 =?us-ascii?Q?wjo3wCNte4uTl8IjkI1zLT1i1jKLkgCi/+2lxKerPEKXuM9E8J28PNRoEiFN?=
 =?us-ascii?Q?hDwdHuomp399iqxQJg1hkyYxj8FZYv3FHvQ3qzqG7tRHbn1PUFb01qoRSLJk?=
 =?us-ascii?Q?w5+UGdTqXKU0EYbKADulF/tk1tEM5fCRp1WXdIJjQVgw7+ewDenqhQs1mzW/?=
 =?us-ascii?Q?DG7Puz9ajgWPRYPB07uVOaw5OvZiU9qx+W2B2IjpvMkkyg3iazRgCC7QcDzP?=
 =?us-ascii?Q?JHg0HSmvg195gUOtsf9BIARkcJBrekgcWrn0FeaStEmcdLPUUjboYLQxSIbS?=
 =?us-ascii?Q?aE1IdH9zh2yg3aDH6Y2Ndrlsy+TSwtJZ5dP6lNAiQHlfteomLZ/6sz5aIcdD?=
 =?us-ascii?Q?N0eAsuVOJnR0JasVuE0vqQr+KFRgdlKpk9GD3cScrgnSUbmXTIECy3Kfec7D?=
 =?us-ascii?Q?UXPqhfgmaFOKZxhAi2+oxOJVgpXIV87K9FUCPu6v/KySD7u9fGrGdsqGsl1D?=
 =?us-ascii?Q?DC0pSCGLNVaXxErhk2oxYB3+Kj5krf/+yuC4AbTsZIwXBaMUK2RtqYAG53Qo?=
 =?us-ascii?Q?F4IwnWJkisvRV0GdSJWOLCBbsnZKMfqZbtzbY+YWaY/At2B/Nxq6LM67awyE?=
 =?us-ascii?Q?ce0sYNC8ve3lnzksJrnoBkdHZsnEbiE1h3AXu9MwfOLzYkafSU3mUzzS49AI?=
 =?us-ascii?Q?kLJXGspO4pddbPnYY1knxq5+9vOGRMVp9ZQ0wKpeqiMDR4b2kZoNNIoGuB75?=
 =?us-ascii?Q?Wr261l1WmZm16fqkmAfk8oE6zXhBoA5PqKMbMqgLPvlfjBFHNwHRLhwZQhCg?=
 =?us-ascii?Q?o5s3FHMUTCOeISrME1I8S2ggCtA0g9Y5kURK8q6W8+7KYLKLNV2jQ9OIUscF?=
 =?us-ascii?Q?fo9mzFnUlBK4PU9KoE5khiLFEGExm8K3LecPSUEZQcMadCFBH3MKzy/HXHi5?=
 =?us-ascii?Q?znOehtskU4/vetPUEGQS0xxKQ334xbNrgYMzOboFmzm+veYyjhTpxW6j+ha0?=
 =?us-ascii?Q?MKRjE4XRUO5blOlOKCaf+76MU+nMmQFXjiWNAUJWMEkGjrhaJrcIe8JiaXtn?=
 =?us-ascii?Q?S1dj/8Bvga/Ke7TaonO3G5JNieafSet+mECv/KK4Bx8gD+KUFX5QZhwTULGg?=
 =?us-ascii?Q?d42HOoTcTOGMUrxG1YAKA770/pcIcjDZ6RD1rkhcTLGbgjEIdZQOhXUqopS2?=
 =?us-ascii?Q?iNfYVLR7fWTIO523Isin9ymNuTgrnDLNx/NtwbpbhVzE/4SKt9qfLB3MdT4k?=
 =?us-ascii?Q?KNqa70uV4wmvi5qR96l+d77YAsSbBVYMDZ2imNYK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a10eca27-53ee-4718-7947-08dd50cbe07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:57:53.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OALPwD5QCL3rJwwlRGQEASeYpbhbnfsRuSeHFf7d4Kz47nDLbI9FSCnA+Wc/0wDb3pXo4Qdp6qzAazvnta0SSWM3rEw2VyObe2oM6ofEcYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

Hi Loic,

I am okay with this DT patch for adding nxp,wakein-pin and nxp,wakeout-pin.

Thanks,
Neeraj

> NXP bluetooth controller may have GPIO pins used and routed for `WAKE_IN`
> and `WAKE_OUT`, such pin info must be known so that the driver is can
> configure the controller's firmware accordingly.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: No change
>=20
>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> index 0a2d7baf5db3..04f55fac42ce 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
> bt.yam
> +++ l
> @@ -40,6 +40,16 @@ properties:
>        Host-To-Chip power save mechanism is driven by this GPIO
>        connected to BT_WAKE_IN pin of the NXP chipset.
>=20
> +  nxp,wakein-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      The GPIO number of the NXP chipset used for BT_WAKE_IN.
> +
> +  nxp,wakeout-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      The GPIO number of the NXP chipset used for BT_WAKE_OUT.
> +
>  required:
>    - compatible
>=20
> @@ -54,5 +64,7 @@ examples:
>              fw-init-baudrate =3D <3000000>;
>              firmware-name =3D "uartuart8987_bt_v0.bin";
>              device-wakeup-gpios =3D <&gpio 11 GPIO_ACTIVE_HIGH>;
> +            nxp,wakein-pin =3D /bits/ 8 <18>;
> +            nxp,wakeout-pin =3D /bits/ 8 <19>;
>          };
>      };
> --
> 2.34.1

