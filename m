Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2098.outbound.protection.outlook.com [40.107.223.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D012A144
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563353; cv=fail; b=cGvc6mEJ0atflVP7Mo5gtemeTF4iOqyI7/RS53ewYDm4MhCfHP68yTCRkRqFbxQVGRGupivwBR7E8GVaAOlFCCTHK/uRiQVBkMHuumSmXw94ThQMf1aK/bcL3hgR9+vlVuiaM38v0Jr54NAeOj/GKZRyx52yM4LlPatK1HO0nB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563353; c=relaxed/simple;
	bh=dQxSpd3mZmNjf4DkUl/uPK962VdKrlz9rIEel6JDhjw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tFhm8SUeYhnqbIP7XyVGqfyBjo1TTJE0xhnAlYNxYzd0aoPmHApDf7Iw75oFtfYo0p+y6y5Nn7KYRy2hc6uE6RWkQpzc79ZH9b0MtSuq0fuabNDlxwiQYjazEetXoK3qBKd7Q1IfNbAq0Ku7M+TWIYnufgvLtvCVMWzASSGKD0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ezurio.com; spf=pass smtp.mailfrom=ezurio.com; dkim=pass (2048-bit key) header.d=ezurio.com header.i=@ezurio.com header.b=VUrYjAw1; arc=fail smtp.client-ip=40.107.223.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ezurio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ezurio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ezurio.com header.i=@ezurio.com header.b="VUrYjAw1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Loq2GbSc7bY1ERJKzyrlCfeEzTcUIEOX2PGSVibsjRsw3impmrofBIrmq+8Byf1S00eFYsddh3EIByoK3VuMV3dfFmZezN61a507ZhX6nDQOICzVURQ2vJTxnfHwV98hoIpP32T/AvP5GkqH2Unfvt3wCcGhvDvzfmo5HSXx8IUaV5yKWxwdi0qtkFh2xe5x6FuzjgTwzHpIfv+F4wDtqy32SkdWKI28eEDL40owxcz6NGPwTEM/ytR8ncymySFi09CB3dT+YogKV/zBqRS68doXMlhfJ/0WAfxhbCXi8rme45qDfKm5Tj/57kanW4eONlFZXFlXlPHpE3P6Bh+D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KU1rCjZntAdYkgm/vjVM/2tzBHgScIwHL/z+X8m+Wjc=;
 b=au3phGnh/lD+GpLR3h0pDi/Qv+ENE4NfAz4ltNgfn3XhzvN/Qzh3RIGpBqhcnA4mmLMg1/LY/kQvj2UcP6bamfdtaIjp6Es4dp/sehykxNrkjQiLk3Tp1HQ+9Hd7/SIkSYa2/QFQz5vYv7p1ncAbAaj89Qlao/3g2clla+IwtF5dLxv+Qx2vBZR9tiinFa1y/baEMo9zpAou6kkUOxoZc0PwJ8uwc5LM/ZJl7QKh/FE8SSFS05LuBS7VejlMPsL7kDBJG14g8/fztHtfspTDEzHzkpjlLOFuBAJh7sg3k8hkfAinnR02+t3yhoTxX1uTdRiQ3Wne4GPB95wQ+YsQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ezurio.com; dmarc=pass action=none header.from=ezurio.com;
 dkim=pass header.d=ezurio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ezurio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU1rCjZntAdYkgm/vjVM/2tzBHgScIwHL/z+X8m+Wjc=;
 b=VUrYjAw1w8tcwJGe8BDcZ5XSVNTjwGKci9El37jHZ8ZHpN0oLbAIo6luL0gb/TS+MWlmL/P6wSTIeNaHwLD2NBYZDwIN017yTQrMyKVuY3LpOmnI52thEAYwQgwAg5i9edtdfE3kC08fPN+EVDoupM37RPXA7G6Pz8hzKk/iZj+tTPKZhH6/DXui90rUWjQyOpqGqnmtg77tZ6YfcKwoZuk1isJt0wNrQAM8BbpI1IGPybBOAe1XVV5Kp4eeuTd4ZWr4+CJ4is+PfaSiUlbUnLtfmKTfYqyaag8MgadfMIbrOXTXQUrpOvNISI55okFZO6tBcmKXTb9kFmep4pFPzg==
Received: from PH7PR14MB5300.namprd14.prod.outlook.com (2603:10b6:510:13c::8)
 by CO6PR14MB4273.namprd14.prod.outlook.com (2603:10b6:5:348::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Wed, 27 Mar
 2024 18:15:48 +0000
Received: from PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a]) by PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 18:15:48 +0000
From: Chris Laplante <Chris.Laplante@ezurio.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Maximum Bonded Devices
Thread-Topic: Maximum Bonded Devices
Thread-Index: AdqAcgMJHCNRz56XQrWX+InNCWrc+A==
Date: Wed, 27 Mar 2024 18:15:48 +0000
Message-ID:
 <PH7PR14MB53009C64A876F92F7F472CB5E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ezurio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB5300:EE_|CO6PR14MB4273:EE_
x-ms-office365-filtering-correlation-id: 9854d6b4-5526-47a8-8b47-08dc4e89ed8d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U5whAACIHAQD8af1NOhHaFPwlqj3gO/bO2w19BelfM7T2mt1CVRpeBaII1eTQMyXAYM/W+mMtIuLSoKUT1iepUcZEk5m6SsT9x8AVx468xRY9Gc2TSxcq32iV7LrLgYnuAMWiYk/Hjy2z1q/SBf5qt0OY19LVhtaLEc1PKqd/WFgJIliOV1D7vBITAUI6VM8+trsLQjFeL/wAcxQFgLTZqaBNCMCa4hDI+Q8M7aQXpBt5usvPTfOK6Epnz8UYTjNwkCCwqhtithiIv+Ul3ESJzengoKdKXbXMjblctu8y/tnBYdypceQuH5dlvzSF+6v36laKGusaozA7xaxcDkR+InJR3lg5ISm82+/EMPs49HonPmKe3KmvhwDSmwVVXceWFLD1935LDFWcGvedejnoiXdq0w0ylP1nDoEayNWBcs98/D2kahScJxea+tHdKxETty8E5nKqEhxehO0qpAbLWrG12oxbrqh1bwfUk22CDZpB5IGQnHSgXwUPe+olz+MrUPrsG55jmK2OF79uw+zA19bVDQtEnl7wXDFvNnMpD7ch8u+ASmX+mCmj2DlO1ZXx1J6bd9NF/HmAaTFkfOkSyZd4D5VjqyyRR6YBX+hojKV4TN9q44gqwICCex6J/jllBSF+AqP0XAK5R54u3PzFI89UyIteN1KKCfxhR9Yh7Uqvr3Pa121YyflvTBSbJBhaLFcNySi/ahu3hv4o58I14UCfBwg3X9bwS4WJJpkyb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5300.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4qf682oIhmUEEL1ReZJ9bO1FSdQxrK3sy2BDUl4RbZLEJ/MQ6AxSPZ2TvmbS?=
 =?us-ascii?Q?lK+GBaAayKYGMKKK84Vl+oPvmLz6NjP4l03FXs4x0Z7YdNf5tLFyC+45YRX1?=
 =?us-ascii?Q?SyvecfLfNG4J2pfg7cR8TBWqxgSxF4T0ysVVmO8ktab8WK0OJf6jUlY+2JFA?=
 =?us-ascii?Q?pXy7dIZPPpH7Zg1iZh0NkMd47VceD65ivD04T687+SCAU/YCc14K2K+I9+Q6?=
 =?us-ascii?Q?PaAFcqSFVE+udxAJTsIthQ7U70ZmpUd8omniJ84IorLHTMRLBtej7Q5RVHbt?=
 =?us-ascii?Q?Fi5LotD04dmTrLuV1m5UJWNc9KKG/YwM2jzPtzhrB1dQGgYsHSnHHNHrW+1+?=
 =?us-ascii?Q?KrGoAREnZ2HFD8GiP5KYQH/XaMtUalfxIui87hhuyfXuMdEGT+TdzPRLfLmK?=
 =?us-ascii?Q?H0gg5/FtV6WlPkz/cUe5ZY19xnoFT0h7yz6zQKq2wjoYfHMb3Kq7EqkWiTcK?=
 =?us-ascii?Q?5m6NsbdnVYHMh3o9TIGlCKteHj/VBhZpiGqbp4Sm1C/wP2EN9hpoxVPdOa6h?=
 =?us-ascii?Q?GIHbLt+XppivOY6Ez9YfBsxPnKfQ4jI0BWO1ro7OYGz3tuyCmicWMK1szyNf?=
 =?us-ascii?Q?HP3Ehg84/2Zlih0CWsKtOmBu29Z4dHVS2O8Mv3Jt7GbXpSQc45bjWsoFZkQT?=
 =?us-ascii?Q?rNYj1Zj4XlUxMnQFYdmMANEaFcG1eQdD3JP/PdPVRpbnhUhix1L96snzfreP?=
 =?us-ascii?Q?GejcbKv1173z1f62TrnfxkS2xa+JBJIei7OVDoDe4S7MRsasUGk5TKWnyjT0?=
 =?us-ascii?Q?FLc5SZgUw6UXmfBJdkSKVhpIqhDU8yjTEh+mT65T+ifV5f1TE3yr20/zHglw?=
 =?us-ascii?Q?jGkJ5p8EVHMEa4exzBt+TnYBrA0Y/WP1EUDdAJc4UiaKvA+gqq8/3dNV28RI?=
 =?us-ascii?Q?Q1xNAjw572hYtDXVXxt8j1ZwD65TgkUG4jMqUYTOObbhxfWIsQaRvlgG03Qo?=
 =?us-ascii?Q?gUz8MC4SqZes9DwW74+oOHLY9Wnhj8sFMpuDkt0XAXynmkyDhl3Kbfloym/B?=
 =?us-ascii?Q?kAGv7GSD2fS+ydm9rFs2v3DBBxu2BhYxNfmgP98TyioD+d+lsmU+JxYbRI+x?=
 =?us-ascii?Q?ogqkAlCapdOSsWnJxgTjpqtNjyGYEO4A3G8zrnoJpaIzJCOgU5mvqfyED5Me?=
 =?us-ascii?Q?xf0m8TJDuziMnfHZXPPIs4TG/yLr/Atu6CEpK/H4QsW6Ixgei9H6U3+mLavg?=
 =?us-ascii?Q?P8SFmZ1G7h96lwfQdZYTYiiLr7i+JFUVmr20YOYKa0KrgrDQmpGkFl7/8yRp?=
 =?us-ascii?Q?NsXE5Njlud0KfBYC//xUHWcoxRnJSr178jGE2ExjqzHpB4jfZNwCOSRuUrAh?=
 =?us-ascii?Q?NJKkBpmy54BzttQBl57mpKL5LusbMfzdDIvMx/5GlqwVi343i0IJiqOUt7gr?=
 =?us-ascii?Q?2GntIYG83dtUuv0LItiJ7CP93L7KWfu0QPbYEy6M+GkIjyqWWBSdHKbvF7hO?=
 =?us-ascii?Q?U1Uqstmxu/0YGx+6quTFEpbLmHDEeh/GTomWbqxFkaRGNCCb5FOs/9oSTZ5I?=
 =?us-ascii?Q?4j4x+GrsjjyqLQLmfSWsuYGSAEN67spj7LLrlcBYqNfBKbyIjs9lKIbbw6ev?=
 =?us-ascii?Q?mfRyhj51vkGJzH+F1IWFANq43QghmVZ4Xq2IQ50WtKfivEJuNquWv0uLBzjo?=
 =?us-ascii?Q?nb7R62Xacjmw38ZSu0OOkYS5meU9hHpiOLeF0rBguS5y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ezurio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5300.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9854d6b4-5526-47a8-8b47-08dc4e89ed8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 18:15:48.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH5eXfkn1HClqLC/PeT7NgqjZmfI1m719HAbiMcJV9rtwhOfVWDVBLLuh9j7MJOU5hHJXzLFMJEd67ctWVWS/MHK9Ie4sRFdlfhkJLBaeWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR14MB4273

Hi,

I have a customer with an issue where they are unable to get 30 devices pai=
red and bonded when the BL5340PA (nRF5340) SoC as their central device.

Following details might help you out-
1.      They are using the hci_usb sample code as the firmware on the SoC.
2.      The stack on the host Linux system being used is BlueZ (version 5.6=
6)

They are able to pair and bond with upto 8 devices pretty quickly and then =
this process slows down and they aren't able to pair with more than 12-15 s=
ensors in a single go.
After the pairing and bonding process stagnates at around 12-15 sensors if =
they restart the host system (and in turn the SoC as well) they are able to=
 pair with a few more sensors but not 30 sensors.
So far out of the things that they have tried out to identify the source of=
 the problem it has something to do with the BlueZ stack configuration ( th=
ey are currently using the default stack configuration) and/ or the firmwar=
e configuration parameters.

Do you have any idea on what configuration parameters could be causing this=
 behaviour and/ or what configuration changes need to be made so that they =
can achieve the target of pairing and bonding with 30 sensors. If you have =
any more questions please let me know.

I believe the default is set to something like 65K devices per MaxControlle=
rs in main.c as well as main.conf

parse_config_u16(config, "General", "MaxControllers",
                                                &btd_opts.max_adapters,
                                                0, UINT16_MAX);

# Maximum number of controllers allowed to be exposed to the system.
# Default=3D0 (unlimited)
#MaxControllers=3D0

I am assuming the issue isn't BlueZ specific but if there is any thoughts o=
r guidance you may have it would be appreciated.

Thanks
Chris

THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND I=
S INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RECI=
PIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSION =
OF EZURIO
