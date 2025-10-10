Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214552EFDA5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104554; cv=fail; b=rSH9J4T0PpxJ0mhRfhGmgPMXFDxcgUMMncY96N97bz149ELDiOWvJJG/ItP+6BZ3kWaO1WX/SMSruBviAuJmC66Q85Sgw/qEj5AiKf5lc3TmFda7qi5OnupFDz1P+s1aDD2cDXnESKjF3oAvhwBg0/r0SOiZarsNYHWFUGn2JN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104554; c=relaxed/simple;
	bh=lUdxhe3BG2lVZRF+arShD1Pv6ZUnjddGuiAJfU74UNY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NTgjr8Rz7K9TKSa0U5vZQNR8RETigdHDgLcFy71i7w92KGsgFXSJ+jydyvPHPz8uRJYuNSCsxrUp71qDd89nMTA+63Y8r3cUDBToutEKTfMbX1NplZ5W6MRQBjMc1qMZVq1wx3RvXN8tAQnlZymxc3DTYbRt4oki2GbbvOh27Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWMt1zLk; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWMt1zLk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iayUgG+lQfv2Jw4H603/vfqucspmmWSJAX2VTx1ri/qlYhf19nqg+8rv14QV+l1kzEiRD899EygP4oS24XLWjhWSO12sDeFpkUMMYs1oNn1BazN8I4oMHakz27mKh/eS8remnJ68SP7Qx6aPInuWoEXY0IhKOPMWRlGcI7oPimmg61Z5xgI49AnfpeERvasFN+RNZwCPLlo0jd/EPtCbKx8uBA0/zyIzX/6BKTHJs5SNdXXtGgrMQHjvQy7/ufW7JWtTHZo7QZLQdhBLNUR7W66W4FuvSTWCYdiG/G/6qM9TKFI+QfswYfgjPPfuivZt0z/6wE+H1KMFl+xBpN5Imw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CJTivoBHhIgWmKMJRoWku33JJbOJJ/8aVvkIXpLrZM=;
 b=iEgkLD7blfbt9gUnxTsde4GyTXK7wk2kwlusip+STFMGA5UeqFzUP231iqFXxAkej79im/PDxwR6uXBvs03OVnasQZw69+HasP5SxRZ3UqEqGJTGmonuD5Cl4wfJNl3W/aFXrWmDc4OgKSdSGNCoi2CXZQsdjpvWWkxr5FxbnmFWnTDg0M2N9uIaimpXgj9XNHkzD/87fV0Cemuxql5wajP1xBasqxPNVe5nfXWOty9jPLP7rdcqiO/X9bixP0hNxXkNt4qJj4qyCkQ3wqC30t7uFZmvd7Tw4kNDq+GzYE5s0nJV4XNHPOwEQZfNbAR87X5pJ6dwE/q/LLMf0TD+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CJTivoBHhIgWmKMJRoWku33JJbOJJ/8aVvkIXpLrZM=;
 b=UWMt1zLkjPe/aAUKYD9uHVaHBRO84eKldyqO4TmMshdjiVBo4tJn9XQqyxcDYbett8yEbx4sXdq0N5MRXD666OYYsByqb1WtTfJMV9N23xvFsNKsTB+NTbKFUueRQg/C8c472jYi6Cen/ibbFljQTBOQ1mSMEYcz3x3HuKSyRUObaLlwsWutIggupUJnLdecUaGrvVFIlJku5fiBSO16QyhJCJmtrjnHAnnltS550S1BpHeHfr13tlnf/gO+afquQZwuE990YZ6MkvHgFZZiUw6uj3QoIcPNfKihxm6Tn4ANzefbZJ4I7kdEm07+FAcCtYn/Pdda+ddLoAYCcodvew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by DU7PR04MB11138.eurprd04.prod.outlook.com (2603:10a6:10:5b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:55:49 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%7]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 13:55:49 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH v3 0/1] tools: Add raw advertising data support to BlueZ
Date: Fri, 10 Oct 2025 16:55:20 +0300
Message-ID: <20251010135521.4854-1-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:205:1::36) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|DU7PR04MB11138:EE_
X-MS-Office365-Filtering-Correlation-Id: b39e751e-5ede-4055-24bc-08de0804b790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zeEg9juNlWGfwkB7lvH5HYT1JAKw4fypW0Q6g2eRdfFfEQmR1ZLZW5S2BcjW?=
 =?us-ascii?Q?qRmzZnkuAT/TFP6hMEemDXjtHKPZQM57tKISwftJ/KJBGF4xFEbNs48HdrXb?=
 =?us-ascii?Q?XVRIDbuXWVnmZfs4xufW6NUs7znyXYbeIEGD5CnSu+/CXrczWxe3p4veChzu?=
 =?us-ascii?Q?7+BtQFJK8l/ZYczW3FLGBblL3qSN4NSbEYE1uLk22ngqLane0G5NI0zVNo0H?=
 =?us-ascii?Q?CjFKeS7K9p2dvHYzQIpSibbEES6Zu9RJmCt5pAwoFqA9mBqCf04F8FEO1Qx1?=
 =?us-ascii?Q?+1WZ8M+GD6ZXpUY+EzkxV7QsQeozEnSkAsZjNJTk+DNxTtDK1sf+4Y9x2iN+?=
 =?us-ascii?Q?bbxIDfPITHk1i0sfkpqQ3xX8zJDOPXmojOe44ttc8HIZzkjzUytRGezkCtIa?=
 =?us-ascii?Q?iRU6A4gJfu14Ng5zX7IG0ogB8VOq2bGPpLhLDz/tzbPHnkwH/Kh5L2XnZU5Q?=
 =?us-ascii?Q?wU1Os6CnufhHgREI0IkYqftiV6M/gdEc3NGidPnhPWezvE/korZIgCGSEi4c?=
 =?us-ascii?Q?uxc0S6dGdm2Vx46l2Okp7Ys2xK1MuWt9CEM/xetBhHyIiif4m+Rp9B6IZwE1?=
 =?us-ascii?Q?sLC1klVdcCldOs55FBT2Gl2WPyKiqo0yCEVoIDQREzmHVOPgU3JKrQYCHgX6?=
 =?us-ascii?Q?Ppuxjkhca+SfV6IfVBBoJw66AnIVHYbbevY3Ulnz8g1DvFBirCmbz9Gb8+/Q?=
 =?us-ascii?Q?jaVf4qvZsc7hIIhtdomJc7NHBw7Sjz2QZNXygxDoILZT7zB8W7Bg7oaGt/j6?=
 =?us-ascii?Q?nzQZnbOC6hKqEzU2fIGl1hppIVaasRVQXyCmgLYrPRHJ+C8lmkbOHoHSyf1z?=
 =?us-ascii?Q?etvTxrj4ta+B4VO/NbtDZUBQnn05CGiK3PrcYWpRyAmNffFEVEdXqD7L9uSY?=
 =?us-ascii?Q?byGA+tlwno8aGGSXQLIa9Aen3NrlYNXSCqZ73dHVuBz79/QSy3DGOu9oaWrp?=
 =?us-ascii?Q?VpqI3Ux2MRulzMEZl1SeMoAI/ueqlp6zBA0D1GiqLwMBChu2/X3av4fvRAN8?=
 =?us-ascii?Q?khRooC44tOtevH6BqwidC8UjFpe+Kgbc86rgwsJUn5zWFgRlBgujg3/qsk6y?=
 =?us-ascii?Q?oWgIm5/xY1ACmurpmZp7QHWaB6JE4UbrpWolBmzE2rY5dBtcqTtUkBEPACci?=
 =?us-ascii?Q?DWDI8xwDJWxQ84d0wUlSx07Whmh/x1tUePJ3UjalBSk4X5uzXYBXR3bSEnTS?=
 =?us-ascii?Q?YsA2FgEixknlNCOefSuAXWUQtNY7P0hhFI0Iue6+xjH5m0SMkRF+doCMdxmX?=
 =?us-ascii?Q?SwjAMzjIIX15xZ15WOEFZKkrWG0m0QE6Fpkx5vExvhm+mVcyaKWNHZZCiUSi?=
 =?us-ascii?Q?Sb9E+CjeKzngehcwsgs11ISdZezn+zPDUn1Ai8/dbtt03SSF0MPdsEACt/JG?=
 =?us-ascii?Q?AaSSY6JLsR64N0CO+AFyq1eoe67BxRZwpi04qA1Y4MLTZSg2US2lDB8Wnp8B?=
 =?us-ascii?Q?OrT6NdrjhBM+8VA2tL+X30sRmboVYtfu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWM9Vz3REb9ezf88R3NfqDpBO+60GXW4J/w8+Oh2Mfg/AHbYrbwhVq9rdBCc?=
 =?us-ascii?Q?9Spts47UPXyxnWgUamyghI5FsXbtlBEe+hxZ6o4hM8IgrZ+RxlEzxMrcoqX8?=
 =?us-ascii?Q?MQEagJXGuaRoE1WMhma5iUp1/7ullknmgiBF6YKicXx9TqYijzbmeS7NDFhG?=
 =?us-ascii?Q?AchL901qWB2oBPF5mj57tNQkJ8SMK8teor8rT2TDHG1RruaHamx8W7yQpwKt?=
 =?us-ascii?Q?AvnAACQnW7kk33gN7qgs63xKHVcTti5kBqE9enOb/+Er8uywlis7XmPShvqK?=
 =?us-ascii?Q?xxb99CbuHgU+52HrQGp4A6esMJb0hm6yEKcC3i/doS5Fz0dh7AFrU/7QhHjl?=
 =?us-ascii?Q?8dxZmgrTSoiAcNQ9z2EawLmbOiD+hdghbkCGgkupmveKXwYai8hmrtl62yhK?=
 =?us-ascii?Q?Q5UH2agpkXId4k+nFPUYLjN6mIB0r/EjCTSHpt+1FsUNT3hBIJIXwQpcaqQ7?=
 =?us-ascii?Q?kzdu9iOSs2jvYh+/EzreE3JbF8XwKuovj+3aVIwiIlgYVB/yrfJJW0ij1tj7?=
 =?us-ascii?Q?w6kHNU5S2OE9ZoYcPpKu41eD+RFrCXEybbokxgXU/V4xwPMF/m5Q+ve3Oqr6?=
 =?us-ascii?Q?GzQRf6D+cKPj8J/n+aRpEKD3UWdo+tjzRd74BjRAKs2nQQrAIHbPSQ+dbUo+?=
 =?us-ascii?Q?Y9VX53iOuzg42odGB4f4pf8HUHicD4J4DjLUCBTaeLJhFq0yy5ht59j0fOTO?=
 =?us-ascii?Q?bXD5iBauIK1Z8tVq2LsJW52tadKwUQf4/+crKlOA67shHv5VN3Mtuo/AtSru?=
 =?us-ascii?Q?Yhl1TdsVUu9tRezagJS7dEbzdX+h/UPgQXU79b6Yfx2CjWX2ElBbmoHmcoK3?=
 =?us-ascii?Q?FG2HkNEgYdcbXSRefrzh96QjhlorXSZKAYJMp5KGptEy6za2/oSzCNYfZKC9?=
 =?us-ascii?Q?QHXCRu+MHTJlcZ/J8joyLL0nV0VE4V1Lfbtggv4dm3LTeCnYjVKP3Zmu8z++?=
 =?us-ascii?Q?fs9Y8nr5HoMhCYjJD/0ayoJVrTmjF0EVvOduObTUBMM5UC/IK9CGhk/YMVX0?=
 =?us-ascii?Q?QzRst3JlaioOpJ1c1Yq9KBD9YwvscVDeiTkmaAzcW/GAhnseTgsdscl2ITM9?=
 =?us-ascii?Q?+49pPfNRMyIaX3VhgAcBzSTiw1mmas+fVk03AvkNNKKePSgSi7mQFm3dI+Bc?=
 =?us-ascii?Q?HxjUvVas69jLJEPnqBhlVMaVdXPu4dEFnB7Dk61rQtMKGE4FDMJSRuLMP3PJ?=
 =?us-ascii?Q?5pKO5DheRliYynYtxR5nFROGJlVvHhqv67g/NxtS1ODuJqMiX620Wtb+kYTq?=
 =?us-ascii?Q?Xl5pUVrdHCBD/w6NGjIiSuBaDZsFPUOKmBP+OohYS/f2bt/uHFdQap8oYj71?=
 =?us-ascii?Q?bmMjE0IWDnhe6Qf2uCZ39GzAp+zF3ONAgrrHTrOKBRZ47okq3yfQpGdrNkOy?=
 =?us-ascii?Q?ddfq1UFy5EnsBx5gPZmMuNit2BnSDeSm595+SNqiavTcT597hCS/0ubzeVeR?=
 =?us-ascii?Q?SuhxehjpHajdmpSM9bjMOX0kxf5tBotTgzp6LgrN84QFsOZKNtGtVtp7U1MU?=
 =?us-ascii?Q?1g2cMtd9EKI9kttnHXlmlV4dWNY2ZDzxJW2DR+hW72+Nj37siTNEDKD6DdQT?=
 =?us-ascii?Q?q2AsLquteVhbMh9Jcud1hJk5Z9t1CGW9Y/A6h7g2uVbHzUfjNt7F55sd4fbJ?=
 =?us-ascii?Q?DM5lEPUFASJt4t/ifVRo1+8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39e751e-5ede-4055-24bc-08de0804b790
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:55:48.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9U5ZUxMSE/u3KkR898Z6c2jjxPFnMKyG1oGl3gSOoxZMo3zUfIEkQgawymJ4ssv4K3DR3AgqaFa3XZRvw4sYNMYGLOAsGsUtX/5KYmEMAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11138

This patch introduces support for storing and exposing raw advertising
data from Bluetooth Low Energy devices through D-Bus properties and
internal APIs.

Key changes:
- Add raw_data fields to eir_data and bt_ad structures
- Implement bt_ad_set_raw_data(), bt_ad_clear_raw_data(),
  bt_ad_has_raw_data(), and bt_ad_get_raw_data() APIs
- Expose RawAdvertisingData D-Bus property on device objects
- Store raw advertising data during EIR parsing
- Update BTP client to include raw advertising data in device found events

The RawAdvertisingData property is marked with G_DBUS_PROPERTY_FLAG_TESTING
for debugging and protocol testing purposes. This enables applications to
access complete raw advertising packet contents for custom parsing,
compliance testing, and troubleshooting scenarios.

The raw data format follows the Extended Inquiry Response Data Format
as described in BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Adrian Dudau (1):
  tools: Add raw advertising data support to BlueZ

 src/adapter.c     |  5 +++++
 src/device.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h      |  2 ++
 src/eir.c         |  7 ++++++
 src/eir.h         |  3 +++
 src/shared/ad.c   | 50 +++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h   |  8 +++++++
 tools/btpclient.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
 8 files changed, 184 insertions(+), 4 deletions(-)


base-commit: 4be24398f9ef510e4904e7190688fc2c02f3a583
-- 
2.45.2

