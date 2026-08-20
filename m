Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88440B102;
	Thu, 20 Aug 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220484; cv=fail; b=b8O/kSsmDBrLVVHEgDSjf2Ocn0xPSu3fhv346sZ8/jDnfX6PXWG56CMm25+n1o7UDRpDhMcSOi+8nVAU38LkCX1SABcS6xMBaZikPVt/JIOil6r+4Rah+YDfxCxZHw5jS0eFOJ/fMW6vkyZMDDY6Ay4z9dd3sY2MDldSKjVoxck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220484; c=relaxed/simple;
	bh=TmgVMaemOhK1qW/LHDPKXXeesr2NC6xfzEwJobzbKmc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aZQhTe0DKok1ioq0EVbE6Kpo6kjLfdCwJOcDob1oma/5WInKrUVBFGmM9/YII8CtC1+J8HcNzU4Rj3Mtkjo4RHojuK8Hm2mNbC/ol1FCnkVP6SZCVh7trZTMcy1uyYK2LeUYIn4xxjLNtJgEMJpElGzHMa2oin2yD2WKxzLbXnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ox0KxR8Z; arc=fail smtp.client-ip=40.107.159.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ox0KxR8Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMgymEh8gfFWzzkd9veaw4fH2moQRki+YSzYSGDaGD/7IwDMC8I4ht+AMrlzKUHk3obJOvjujzRqiUbyNLrGLIHP5TkN4eflCTfq/hSd+qiTCo5ktv+H0ryDTynV+2L9pyd3SOECCGQjiG4IrXjK2qWve/Ulhz6HRwydXc2hDl7kdQEfMJW0/eNUreSo4wFvUL15wfKg6BZ+HPhI6Ok4dfO0NeO5zsWNBONlv9gQQN+WLc5kaTp6HexwRAXXR2Jz+lbM1V2GfY6jdhpvbhEOPUdVQ/0r90s5AyQEkCs5LJnv465lt40LpdRtgjk8VVlEGS9eMa2klGdmgjyzAzIiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XIX0LnvoDpw9u86CWbXkLDXOamTiWyQ9/A3MH1K8pU=;
 b=Pbvhdkc5bz9MDgXT9zhuRmfLm1fBQ+P5ML0y55viAL28IvQCU6l+Jz3gkOST/kvimdzMTO3K2wOiYQYDJBEkvojivZpWdTQRdMfXAUVka0e1arTcLu5ZSGNLg8qHV4eafmEIoylfPVhu75ib+6a20Dqkxeeym9bfsltlXsKa5SAXncEBz7sX1tpEoDs0rHbxD/siDYKKxQkOjnh/BcmZVXDG/akYJ4pag/8Mcgldt9QoeThYjnKQmOL1VBXm+TWQGrPghkGuJRDjtx8OdkTla7w/1tVOh2qyy+m6sEZOx92UY8M2Tw4xs/pplTpHEIC70ET+zqG4sZgtlTuziNGEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XIX0LnvoDpw9u86CWbXkLDXOamTiWyQ9/A3MH1K8pU=;
 b=Ox0KxR8Zot/6gW32bpFVO52sfKdWpdf7sVU90HMVZ0tdHV/rXkjYB3lx2AyDEQuiCTG6mwZlNMVu1jEfWjIU+dxL0PKwfnEkxWT+8gqvVIy5VR5Ckv5hZfibn/WIA07N1Zi/vM/Q07CTew08o3p53g5rhPykrmmUB4RlEnktBe7XT99/i4RqJ+MFwpvEE45WF2jFi9gfQbUTtjJtP1NioS4T9AYPqTInlx7OAJuH8KklrxqK4MxOrqcv4FeiZDoQIcGYkjITAirJUh/65wQ0IvAFpRXkS2bTQtgtTU4yaPT++v0ZAJxwHz12Z8u686fUGaWEC2YN7njbjLtoi39loQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10395.eurprd04.prod.outlook.com (2603:10a6:150:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 10:07:52 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 10:07:52 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>
CC: Alex Zhou <alex.zhou@nxp.com>, Song Xue <song.xue_1@nxp.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] Bluetooth: btnxpuart: Validate the FW dump header length
Thread-Topic: [PATCH v4] Bluetooth: btnxpuart: Validate the FW dump header
 length
Thread-Index: AQHdMIvD3un1VBinxke+2jyO3z4CCA==
Date: Thu, 20 Aug 2026 10:07:52 +0000
Message-ID:
 <AS4PR04MB96924AB37F9DD74A9F07F67AE7A42@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260818202211.617795-1-ali@iusegentoo.com>
In-Reply-To: <20260818202211.617795-1-ali@iusegentoo.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-20T10:06:18.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GV1PR04MB10395:EE_
x-ms-office365-filtering-correlation-id: b1779522-c59e-4095-c515-08defea2e5b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|10067099003|56012099006|6133799003|3023799007|4133799003|22082099003|18002099003|11063799006|13003099007|38070700021;
x-microsoft-antispam-message-info:
 8q0p9XjjKdcdwA+TXEtQeQh4DBjZiPflN4lIk7rpF+aGFrMSuO0jxvZl7Sfd5lFKUP5sGblgoy02qHOXbYpe2qgZTzJfOYkZd3TS/gPcX83Ld61yh/siX3QlZqIdpK0nkqUGsnKRVZWHVlQtoDda0x90lsLqRzb7eWk1t+ac6bSYXmbUU1cUy+y8ZUYRLKk3oNPsTe3DGum3aOY3qAjFXQPGgYAsCb/LOGsdLmOe4dNLOyNrS7FaBz6UZtERtC2O/lOtC2lz0VQygR3Ihg8A3TnfZITTIzm6/nEEKQBXck41Hvl1ZTn7pA1R4OC+xdh0DrlfbF2AFdBXiRtr423q3V+6EsSlqDiy75Ijnv/YO7cDIUz9O+uPDNq8xBpDsSw4av1SyjaLoB+00gakTvKJQANl3eYVjAUHi2o/DvZMmSGxj0CGLnzSuVO5Ga4/P4pMc6AmD4Bl1CtTXQ7+cQaUW/SkcGZxVFxk2nbeNLbuU+D7i4BqbfWWdKBoEC6+7DrdNDV87XwSITYIhUHk4EQH5GIpqwVGTwlrhzyIq41PxeIEsCM+rQNdYnmD/2zTjaws5HuCvjZdwxGXr0MlKJVkshmrQhBZVOD8rSWIaB5AR9geItZf60nDfV79YfOZpjoKqDcj0zaAgt/ZMKhTF7UfPfduwqujCk/cP1xZPj/Aewk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(4133799003)(22082099003)(18002099003)(11063799006)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zH1qKNrATgXj8DBQlFIS7f7KhFG/YaLJfLsAifaRHD8ABd1cnK6NnrW2ykf6?=
 =?us-ascii?Q?fPYQKefeT76O6bOj6ucQJ4ks32AGrIJd4WN1bPJJqEXDaEGssrg6sXa8HCV2?=
 =?us-ascii?Q?XLPTsUnm9vm/FpgmK5uU4RQsFUvF4k2x8/xcdik2DG2U6UO/rBHVgKmDdoA8?=
 =?us-ascii?Q?2u8q9CBAWTqwOylnt9Ky80eVMdYqIusQJ3Urlz7gg7VoZX45Wl5wkjnVo0x2?=
 =?us-ascii?Q?yvsHZ4bf81NbcOQtjDJ9h5iMCnXHJgvXzIs2QLs6AlRonrmOdReVfuRUdg2f?=
 =?us-ascii?Q?ZYtK1nZBn5cZnzNDWTH9wzLRzw4Io/YB/QBP0k+NbUekYbMnXaWnsenuTgIR?=
 =?us-ascii?Q?W0tllDqxP53PCRwqjITsXuDrUMVy5Pj7unVFb6udh96mS11h+lwHk2RoOGaB?=
 =?us-ascii?Q?RvCJ6TcAaSHgpSMDyl3oS8eyGVJWha7LHIOtLziLfLIyfT01tQ96j2cIL0D9?=
 =?us-ascii?Q?XRa/krIbf8yXasSMaVUBAFzgIZnGZQsS/ajIoveMsVrVYldAuzmMZ11kcLzn?=
 =?us-ascii?Q?osU9Sat2v0SxnHt8/aL66l/WYDQkPp7aFlPgS0/9TsRNwVZFTazELX3ns2Ra?=
 =?us-ascii?Q?u7gHn5rBtph7XerBJcjBf99B4tshF4IDTdzwZn0rNidHX2gRzwf6vItb4SIe?=
 =?us-ascii?Q?a1i1rMqJFvIrYVZ2HkM05XXccb5SuOmC7zXrf+DTIGwY9mJi3AyL5klydCf5?=
 =?us-ascii?Q?np3F0xnn9dkO1vmCHAdmER3EeDV1rZAJFpfL5Kwh1kae0F7dHERWP2S1maN+?=
 =?us-ascii?Q?bauKqahl+AOuKeT8VoHzWl9PBLjHIpuOHomI5sdQGZXYfl0cgoipR3tlkYpx?=
 =?us-ascii?Q?J/9knabFABkV2F+sXmrJinRzt+9LI/l2SGZ8OPTMNnbF0V20sflSFs2nINgb?=
 =?us-ascii?Q?F1/7Z9wNtLx0jwlTggs0R8dO6gQTzhUibIJ2CmMFgcVUeMpTh4I/Ku4afasa?=
 =?us-ascii?Q?AWvRmZgTHCXBsLNq62zQjXMCO/8R3bgxZYFcd4z2eDHUl3rOCokTlqpJl34n?=
 =?us-ascii?Q?z4dXPygbYRYJpkD/UgbgJpN/0jwnvq5utkxObzk57gvGyavTHxEK3RE/mOOa?=
 =?us-ascii?Q?kF8c1r+WX5RTJg91IQ6hbnpnd2Iu8lPTYZ6tY5G3Mczwr3cAGYUnBhChUItb?=
 =?us-ascii?Q?x66yDvIXMFrr0ahyR2A071XwxUQpyQCChpwWIS3gZCiuER1mtPwEvKIn29L7?=
 =?us-ascii?Q?ZTs77VuDqplPtTRsZ+CrxqjWiWe7Qmscj5cMo7uHJa6ncxOKNlyHudcHQPvQ?=
 =?us-ascii?Q?xEQqHNbsraKRyQOuYOwqlavbIpnwMP7cTXeE6vrL8uuOkmKSw8c8kMDa7yxf?=
 =?us-ascii?Q?xNv83mGAsD2Ryjc5h7r88+dvCj/Itl6DpkXmFD8ZX+0kTcLy8+pwBSCI/oPo?=
 =?us-ascii?Q?KPH1GefIvYDOso5+cHw8uVyYQ9eRez6rYr8mUoB8zTUUnVeCyPCI12DdwBp2?=
 =?us-ascii?Q?WNBlpnvHOLQTFOzuDDzCrLXXgIpwmNVFTChZuhnKEjD4jGqIJlV9VVKq4CBy?=
 =?us-ascii?Q?+Ph7mwPhAZsXAh6GAgjmCsJlc/55wAkagVanO2GAG5tpeP2QKRCwmLmFBbQA?=
 =?us-ascii?Q?d9JMzlOycdhXiXoZuu3R+30bayf9f7GgEmJZogu+gezb3hDTaQzEqwJhupt2?=
 =?us-ascii?Q?1npfqk/jgs6fAB4KJYueUUdN3ecgu2kz9JFpze+TSPHCJ43uqq9zv7KBMeyq?=
 =?us-ascii?Q?07vQpP0TkPGPztqal0c1hq/qhRImnDe4SF2jk3jMbIOW0rbK58YCEiHJtWxt?=
 =?us-ascii?Q?KaZWgVBvAQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1779522-c59e-4095-c515-08defea2e5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 10:07:52.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLvexpN0GK12SU20yBcgJNwPbTF2NClXYNdNDpioXYKnynzTzWrbjfOcSmXMulRdhZeXjrjvJkNq1SdLIhpcmOS678G74AbGGvP7eyJcbF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10395

Hi Ali, Luiz

This v4 approach looks correct - header preserved in skb->data for hci_devc=
d_append() and dump aborted cleanly on the error path.

Reviewed-by: Neeraj Kale neeraj.sanjaykale@nxp.com

Thanks,
Neeraj

> nxp_process_fw_dump() pulls the ACL header off the frame and then reads
> seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data
> without checking that the ACL payload is long enough to contain it.
>
> h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
> number of payload bytes named in that header, so skb->len is 4 + dlen wit=
h
> dlen supplied by the controller and possibly smaller than the 8 byte dump
> header, or zero. A short frame with connection handle 0xfff can therefore
> read both fields beyond the received data.
>
> This is not only an out-of-bounds read. buf_len is also what terminates a
> dump, so a value of zero makes the driver call hci_devcd_complete() and
> reset the controller. A truncated frame can therefore end a dump early.
>
> Check that the payload is long enough before reading the header. The head=
er
> is not pulled from the skb because the skb is cloned for
> hci_devcd_append() afterwards and the NXP FW dump analyzer expects
> nxp_fw_dump_hdr at the beginning of each chunk in the dump.
>
> Abort the dump when a chunk is too short to contain the header. The
> firmware is not expected to generate such chunks, so receiving one means
> something already went wrong and the rest of the dump can no longer be
> trusted. Dropping it silently would leave userspace with a dump that look=
s
> complete even though a chunk went missing from it.
>
> hci_devcd_abort() still reports the data collected so far and records
> HCI_DEVCOREDUMP_ABORT in the State line of the dump header, so
> userspace can tell that the dump is truncated. The controller is reset as=
 on the
> completion path because BTNXPUART_FW_DUMP_IN_PROGRESS makes
> nxp_enqueue() reject commands until the reset clears it.
>
> Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump
> feature")
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link:
> https://lore.ke/
> rnel.org%2Flinux-
> bluetooth%2FAS4PR04MB9692EC13E3176B6D7525D097E7A72%40AS4PR04M
> B9692.eurprd04.prod.outlook.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale
> %40nxp.com%7C6bcc0ce20725451b167f08defd666c70%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C639226813511440640%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DYympY
> uys6asrlyl5WTAQitOSv2dLGy6jf%2By0Usf%2BRqQ%3D&reserved=3D0
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> v4: Restore the v2 approach of checking the length without pulling the
>     header. skb_pull_data() in v3 also advances skb->data, so the clone
>     passed to hci_devcd_append() lost the nxp_fw_dump_hdr that the NXP
>     dump analyzer expects, as Neeraj pointed out. On top of that, abort
>     the dump when a chunk is too short, as suggested by Luiz.
>
>     Sent as a new version rather than as an incremental fix on top of
>     1fcf216462ec, since you mentioned folding it in. It applies to
>     1fcf216462ec^. If you would rather keep 1fcf216462ec and take a
>     delta on top, let me know and I will send that instead.
>
>     Dropped Neeraj's Reviewed-by from v2 and from the follow-up patch,
>     since the abort handling is new here.
>
> https://lore.ke/
> rnel.org%2Flinux-bluetooth%2F20260818080104.563675-1-
> ali%40iusegentoo.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> %7C6bcc0ce20725451b167f08defd666c70%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C639226813511473591%7CUnknown%7CTWFpbGZsb3d8
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DH27cFkiatrKCHHeu
> %2BWxL%2FoJwwj1mnO8tClM3KoP9TgE%3D&reserved=3D0
>
> v3: Use skb_pull_data() to validate and pull the FW dump header, as
>     suggested by Luiz.
>
> v2: Warn on the early exit path instead of dropping the frame silently,
>     as suggested by Neeraj. Dropped the trailing newline from the
>     suggested message, since bt_dev_warn() already appends one.
>
> v1:
> https://lore.ke/
> rnel.org%2Fall%2F20260814081221.913676-1-
> ali%40iusegentoo.com%2F&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> %7C6bcc0ce20725451b167f08defd666c70%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C639226813511491888%7CUnknown%7CTWFpbGZsb3d8
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DjH6B1H5Yho2fVz7it
> 5H8k31dQGGcX%2BU2Zm5JOGG%2F7G8%3D&reserved=3D0
>
>  drivers/bluetooth/btnxpuart.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e2b8f7997e4e..f6d08942a91e 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1361,10 +1361,23 @@ static int nxp_process_fw_dump(struct hci_dev
> *hdev, struct sk_buff *skb)
>                                                                          =
 sizeof(*acl_hdr));
>         struct nxp_fw_dump_hdr *fw_dump_hdr =3D (struct nxp_fw_dump_hdr
> *)skb->data;
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
> -       __u16 seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> -       __u16 buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +       __u16 seq_num;
> +       __u16 buf_len;
>         int err;
>
> +       /* The ACL payload must be long enough to hold the FW dump header
> */
> +       if (skb->len < sizeof(*fw_dump_hdr)) {
> +               bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump ch=
unk");
> +               if (fw_dump_in_progress(nxpdev)) {
> +                       hci_devcd_abort(hdev);
> +                       nxp_set_ind_reset(hdev, NULL);
> +               }
> +               goto free_skb;
> +       }
> +
> +       seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> +       buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +
>         if (seq_num =3D=3D 0x0001) {
>                 if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS,
> &nxpdev->tx_state)) {
>                         bt_dev_err(hdev, "FW dump already in progress");
>
> base-commit: c519ffc1e2c669296b976d11f5e7a79d2f82debb
> --
> 2.55.0


NXP Confidential
