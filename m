Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4512BF12
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819928; cv=fail; b=OAajdJaQDgtLEuTzmWTyMNyLRRfNp3vqlZY83k4wvwRer2DByJXI9Q+y+Z2skibM9VIuvb8QrXYXFDGzvgXz/7uPUs0fHAnGLm2w3T7RNHTsSOkTE5OKAMfVRo1oHgb709yO1GJa3YQhlPq363LCVexnHgkj58K3J7RoFpZs0tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819928; c=relaxed/simple;
	bh=cpFRoO+acXJsh7ipQxm0Zirgv8sUs8lamRHOAW9agUs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IujmJLyTp/Reo6OnY75eVJoYCUpJIrKVKzrBeKOgn6/emVhESTbF6FdLnx638smhC0IBtZAP70myBcQyIVPDBcrCmhDNbAxiz7J5Uvf65D580sBXJkOnWSXZiDzjNybjJ5bM5eJEfOvJ3O5ex2NcCUosdfxyBA65YyjW8olAcHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TBrXRLwt; arc=fail smtp.client-ip=40.107.104.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TBrXRLwt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnncygaRz5zDhyPIX3SLcxPM9jJHryxyem9diifJBh2+1CWjsFxJG69y2OF5bdXJrk1KMOOHgzGAugCc8d93gPUq4LvqcuzbZWeX0GzDYDTP/HFjXR7EN4+7fszUfIxUXG/PzwQlAwBqcOpZm0WSW526UYlfKycEXTGnUrdtMTHZcRVkYUN35wTVEslCKyaVPPYCD6v4WkaQ+VMk1vGzDA0LR5mCleGG2+sHSzyoyflxTsmH615CQCOasoK5BKTy22DyhvlCxi1sgpNUq7mFl5wf48+nyrnnOjHdWxQdnaO5OMexyNl8jQTpxAyk2Wtb8rxBcz1cT66Nl5uPXzr/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqtp4hZFJHJ7jDLUyLqmFXKnDoJHcl7Zc1zROeVXPtg=;
 b=Gjs1asjGX5nj3ZXUDG7tOIivmBSy8yuxknb8SsFR6JsHhLrN0Pg3X/Mmog5BeFf0zrxcm5W15pswNvhhlHAX3I5ODvEfKEF+XU7jfpiIZN/QcgRNA0WeDsIlaIMDBop7WaHBboYhkcownf1ZEzy0IN9n9yV9WRxAzWpTYIttmef3pi/yCL0JzGz/wqzE/qhVZxAujpMdbYfplp3s9NgjqtDMN/Iq7UNz0TeBrDHn/lB7hb5RlMVous6m6Dq91arBr4V+DAcUsibvr2TfMXZxTab+LAMmL0zNZsjItthAKo6q6cJuFL2ViQjGX9iIZoMUpHIezScfhkvVL3wGcJLx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqtp4hZFJHJ7jDLUyLqmFXKnDoJHcl7Zc1zROeVXPtg=;
 b=TBrXRLwtUgMS56/l1bHwhR/b4jq/ojPfryoPc8smhZa2nWuTArGzKIYS7WkMbAXv+WHsy0lzsgjqf6C2Fb7emPeLBxg3222a5+SOxGJNiPWFRUS+g6iXaIJFt1QYFkxl3F1C5sr/t993LzW0heh4lukEmsTgWmHSrYWzme2Yup8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AM9PR04MB8634.eurprd04.prod.outlook.com (2603:10a6:20b:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 13:58:43 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 13:58:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 0/2] Bluetooth: ISO: iso_listen_bis fixes
Date: Thu,  7 Mar 2024 15:58:32 +0200
Message-Id: <20240307135834.3941-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0273.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::46) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AM9PR04MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: f8afe56a-3f49-4ecc-ff82-08dc3eaeb30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m5VZQdMHXiGJXkYpBRD2xNloa74JDvyMljFqyfndf3lX63G0b+8qrwHl3ZiypwqeaSoe0gR83MuaBYFHiCmUyvkbrfwfDQI+yQbw16z2menlSY0hGAue10PX1eZyhh5uuZx6EHXyaocMC2h7VQUwCMZbf05Sife+X9WMcxMn+TPUZUccJt5F+THNZQ362OZrojlqb1AYVNsKQVRx4SlZZ/bIllSYhse7nmjrPJbkZHS7JRjqhavrJLcyYoM8mq4vs8vY9xmxYXhjlw++iZUNXomnskglYbaZpJDO5lnXXlVE4J7QP8VPiKyPpExWlPrEHwOc2HUVHq/DkZM4araPLDKHhfDH2sStWxWfeHakzk5qGc6hyAt8JhShMeyVQzc0qB2nXwZs6ur6ojWwBIYNQ/oxCujFxUZ2WyH13P3RB+VxqOgui2XFQVqcK7Pmh7YBJcwWL899cdVb/41xVQ4xMTYKtAqhvnXzF5uCI8fKs6DIDfF0o8CIkHJSB9L1QbSsKwfO0LNleeJoT7Be1bd53XeVSfcmEnDObw0hrwctbfTcfbWo7kAtuMfNWnKIG8G+Vt2AY+oRQywt/jS+XN3Ghf6kG4n7so+1dL6AVil/s8qpaJrQf6/uM+cmz4Hm43zpvS+ZeqvKIbs4VcJHH+MwwhNGH/nG5vytggsl5fVTrAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7Nrc0WPGFTlLF8/pZOrlGkQs2a+PEDbsPN22eSjB4H3sUmamh3TSwJgXeqC?=
 =?us-ascii?Q?wDcGCwxE/NQN73xArK2lKi+CGCwA8tn/Kwr5HenN+HiyNF6gStKEhNk46EQB?=
 =?us-ascii?Q?6MAdxcUytNn3olEIi2QPHE3mDRk0zXyxXsaHLlaHtcKXkNaYy24Vfhb7P5SR?=
 =?us-ascii?Q?ZX09xbI2Bb+dek0f7xSs2z5c0x2GQRZwiccAJyafwAVCn7lhWqk++2cDObFS?=
 =?us-ascii?Q?Wb3xoZNyWYly+a15VnHk+YgcAYCJ4XsaUR2Q3Hi2PhZa52M18EtRtYxHRK6q?=
 =?us-ascii?Q?PQT2GZ6pgr8I4FmDDRpmUKrzu7UE2/R1PzijZJvBCGSyLeFem6S6wzKjUp5Y?=
 =?us-ascii?Q?qoR9f0MgCbNqIHqcjexnrHjVfvDCb3iC3T9yGErSuN7EkygfuzDYhdgatEfA?=
 =?us-ascii?Q?hqngAqKEnPZ1D6r49b6Vk3z/oQiDRDy52gHzcccF6MtV3gWpTOXkyypupi62?=
 =?us-ascii?Q?2fveL9bRKNOkj2PanNJKl/Js6vl1zWfJZcnNOSXXa6EjQUxylratYgbs7xB7?=
 =?us-ascii?Q?tUmgBIhH8KHCh0B/qG7SsoqXU/AwoFp8I8ism2JoXZ7VCqc05ga8V+S05qX9?=
 =?us-ascii?Q?eHGhwpegb/zvux7djpPE+Z4bqQNeJ6Z34tsZ6TXj6CAWSJ/0IyZU4hGYu3kj?=
 =?us-ascii?Q?5XeMnp+5KFaPI4q1OS5hwLmykrg0da1spvceevytyeXsSaplKFv+T4XDK8Iq?=
 =?us-ascii?Q?HSkOCYlfKPMN85rHF6trZvOIrug6Ie0mn1b1OLLMLErkWL2nWZG7enwQVE23?=
 =?us-ascii?Q?fma7OR/wjcp9FmZa71hSaW4uwmuyR8KgEd42+L1TIFwPpB/SUX4LrN6WQJmL?=
 =?us-ascii?Q?kLN+mJN4EBMzkNttYuWLCfeDm9cjeOIbSUGn0m9nN91SzTll9Zag7kxiiAyu?=
 =?us-ascii?Q?FNwomZ3td/WjfEHf1llUqZvcqCc92nntxOf/rK8itgJnpqnKBHbGQBSze7vT?=
 =?us-ascii?Q?oYjc5gbri+kALmSa+hsiuPViFt0/jTOf8vLVxypNvGtXEFXgWGSgn4EUJytp?=
 =?us-ascii?Q?0wL2TfQuGBlLZNDakUAdmxOjAYJ0g5vgRRquaKRL5znn0Q2dW2PjkXfXMn9D?=
 =?us-ascii?Q?yNMBdJbCQN+hjMy0iefIFMJKLLajgbZylYDW81TINMp0/+JE+dfJf8Dfmm5Y?=
 =?us-ascii?Q?UKHnfHPihR5X1zvpdQIxRK/fl/LjJE7LpjeRi4y/sKB2AWGkdIqmcRFO7nex?=
 =?us-ascii?Q?RyAs7dLmjXkbhjlWiuMzB2e25xUW2JQWuaRGdKuyka6J2A/H8PtXL+7eAd3j?=
 =?us-ascii?Q?jNbHCCJoDUFv0QLtnObYbEroHUxFFnbIBYqJGWzqNrJ7iV8sKE0h8CHziu8q?=
 =?us-ascii?Q?/CXCz9uPjCZeMu3B8RpjBEzJYV2Sf+NvV/O+PWDsbzsl40wvGsb7siPLYAk7?=
 =?us-ascii?Q?AcNRrFnulxFmIWz7cHFshYUcaPTqM1vKnuXIQfkQ4OLACoYGs2NmhPk2h3lz?=
 =?us-ascii?Q?irv0KaH+ZSp/krveGTqBCh4LPYh14vKNrb61m6lK6C1xeUwskxJAaapJTbbb?=
 =?us-ascii?Q?3G4E5aTxJReOqkSP2AsWEJ9sUreGQsMI3QgbKQqyABWSF71vWYjBPljRQ7sm?=
 =?us-ascii?Q?bCYYDwpXBAtBEBTL+m6Y4WJpDHRZraxkeZyttGfphpuKCcHcGpV5CH1mqo1M?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8afe56a-3f49-4ecc-ff82-08dc3eaeb30d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:58:42.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3Mabc9z2Lzki9jKho+sp6r3ooR5En1TdmOt1WZBSy+tQQm4dQ5DBEYNIQsyKXvGjXRMGer77YN3WXwr9Fu2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8634

This patch adds some fixes for the iso_listen_bis function:

The first commit fixes the circular locking dependency warning
caused by iso_listen_bis attempting to lock the hdev while the
socket is locked from the caller function.

The second commit fixes the fact that hci_dev_put is only called
if iso_listen_bis returns successfully. Otherwise, the hdev will
still be held from hci_get_route.

Iulia Tanasescu (2):
  Bluetooth: ISO: Fix circular locking dependency warning
  Bluetooth: ISO: Always release hdev at the end of iso_listen_bis

 net/bluetooth/iso.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.39.2

