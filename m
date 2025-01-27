Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647B3FFD
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970217; cv=fail; b=eRM3q8v07FjnyHTJMw8xPav4z5XlcKEjUxyZIr0jO7L2uCmIFAPq4ItBziSakmwqK3bhwQxNFiu9nrOfKDf27mxiG36SlCGgy5uURdh5cmkLP7qjUyBJrxX8K0glZFUWUZANKtkCFm+hku70gngH2MQxxoMU86aN9pNZqevt2VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970217; c=relaxed/simple;
	bh=VOrPqoRT7wM+S1wMqPuQrJ0+K55ESvm+SomYOuOAIyg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hy4clIUMZfGBDT8QXUeFYTGPcY321M9MxlCQWu/KtoZan1RGPTHzVNiaNfD5gJyeq01UHK5wZE4RQwmDOpBvtAwQdo+1xXp2VYp3RQliDlocHuStS+nHFvxhe3QMFuZlZ703ruwoHqtkIt2zXwdL7vDVGEFwT2zIjHM79ZXaTFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vfe9H6JH; arc=fail smtp.client-ip=40.107.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vfe9H6JH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKSgO7oB5Irn5qUQF6F3JvX4dCLGq6ifgiaPMC3SL/HzgH7wMHidtqJD9047TtXu8pUPAlybLXxgn0hDp2aW4TjS/7+MgMgsN9KlR/91gCSWzIafh3WtPJuuIOoMyRkgKnH94hXT0lbWp9zsie2yD06umAusp1BTcm9SE/KHEpx/lyLoSYIIcaKysSNiKjOVkMiFgLsOIwRqzLRsuFIMt2abpl8RmhBtmr1ugbBN4/UqUsIQW5xPygcKafI7wXri3BCQtyVh365uvySg/LuHwOzdmZMTtRwNKSM2oHczfRUntHE7nTTWDXtdnkHhMfk9iNW87SVSiIgFK1Y1e0C95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybsKkE9muUFNCLi0fSrG/FhJNFspDrpxwmWAy7zzhds=;
 b=ssjm11Wvtu+IzrQ0WeG1CA1ZzoPBsEhYGM3YVZccc4WfxwQmNXvrtAwCEa/zxx7KnQAIqmmycmFwvDkYY0tjLhnt1+UqVtyQrysN84tR8uaziTHzqcwlmKYP8JSTynk6mba/PszIXHF/ZekaUx/waGuoc/x2EbXXyvdm+ru7U2QC1RCpsMIY56CVI2czCLlBnuz9HockMnlv3ZAQNhUAGR25UPo9gBzN4FDaYB6veAGEVfZ0t44MWYL/n+50igVLLndKcpLYNQ/KvJSXZROtoPGtPfyXjOl0NEhy/+wcOrNnH0LBnPqTZQifz/C9BHkvLdNiHafNfmpw2mvuCUj3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybsKkE9muUFNCLi0fSrG/FhJNFspDrpxwmWAy7zzhds=;
 b=Vfe9H6JHVw3QB31OI8zeFTMo5bedHFWWMvA66I1ROu2p54qIKGADdZVDeNZwtuKkN4pDh7NY+h7nD6GaX2csv4CJldT0pOkjJm4LnkIri1OnTM/4SQ3bdT/6b1RHKCGHwvvQeJMmj+o+Uzfhqx3xJAm89AcjvWp0D0m2KErDDgT6kcOQVTqA4l1YO0N6YePuIZ/PV4Jmtkk9QcKgs04cfPqP1JPBW/ognVnNPtcxxY/ALL4xXEoOX/48EMZpqhpa8Kb+0UsoB1axmjBobiYm3sN9bmURWkOjHI0smmdZq6f2DGbN61w5JAtpHZ1Q/zo2wxcAjRyA3F1UgKxxKEvZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:30:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:30:10 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/2] client/player: Rework transport.select
Date: Mon, 27 Jan 2025 11:30:02 +0200
Message-ID: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2de7cd-f7dc-47ee-069f-08dd3eb53214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OMbIKjqyKr20jEF2rLZBhN7AMiHEQJRN/YzZBx8LxhjxxnBga3l/5S4AjDy7?=
 =?us-ascii?Q?tHGDHXAIz6UBsHeOeEuREwyjuTBaM7EORD2FufzPxerSYVSV3U1dMCpH3Mgm?=
 =?us-ascii?Q?JjyQ03m0cSdCX4SS++cAx23ACYAFTyZ/EBaTXiH5dOXYYj7AFUF72kvr4F2V?=
 =?us-ascii?Q?EwEaSllLA8qc2/I4TEd0LTEdX0bEZYyhNRDBs7PJ0cinU2aT4sAH45Ex68OK?=
 =?us-ascii?Q?fP3F/bx7xZpXFbKFBVrknSmcSDZXQRacZh4XlVm3wepS0rBMbm2Gk5EqKixo?=
 =?us-ascii?Q?UG3UlFACbdgHsVxC4635rJuyOpImLXn8bN5+Te2vwIg7csYW3KRiIiw2hIUn?=
 =?us-ascii?Q?W5QvQp83NT7/RSuuSMuYvwHdgXg0GswwK4wekcvbiXVnqh2X54ahijACBQos?=
 =?us-ascii?Q?QZ1F8qTLoSo6fjfsQo2U+htFlx2W0LbG+C3Yrg6wr7WdNu9LG8XaCK2lwt/G?=
 =?us-ascii?Q?Jf8/07ePvTrjQoxhW/UMwNu6pG0t+TdchdZm8E7Ml/b/ctxp+gqW4lsBKeLw?=
 =?us-ascii?Q?AQiOPuaWpRxeOyUt1Mszei6CXoh4ucdOGbl/WUBiY4kW60HbHLpdDzLpp9Ce?=
 =?us-ascii?Q?M5WqsrJciW364LHQmhqOXnxlHaYGw9WrYnH7Vsi4YyIF/jsUkVJqbAo96ICt?=
 =?us-ascii?Q?GK4YT72a1FX/0IGRSrNClmuS45/OlZiov4ptRdC5h8H82dEtB0gqz5jmjDAD?=
 =?us-ascii?Q?z7WgkaSrCUtC0n2AIfnvr1ipKMgX2n+WLWaN0cwJ6uF1hlPczyCMZ3L6llfI?=
 =?us-ascii?Q?K0jcpkOPUmNtfpJlK8cEkrTX4Cgx7FF6uoJD14LDaSE+PtjHdvQvYow6W8ZP?=
 =?us-ascii?Q?K9yUI59OQgbPJm2Ju06f9ABbNWkLlo4TgJRFhseV5F0mejIF7mH3oSKZ/v0u?=
 =?us-ascii?Q?fFYjs4HoHjxGkPlbrbv0L958mdXseFU+1jQN9LTMa7IdE2qt61MDsJODrSVX?=
 =?us-ascii?Q?sNtZ5XcUPPw9yhyeFVE0ofe6oWfvet5i2Dj8H7TOEOwj2gnPVF1zsVq2UMB9?=
 =?us-ascii?Q?GvXT4ggZUYVRhdHo4TeoLJyNeYcIwV2FW2qgThGG3vDOwxJWoJfrZsR0jW7g?=
 =?us-ascii?Q?Lcf2fCglRjqbkkUdDBxAVL07iyJSVCRFCYPwKYe4iJvz6C3YGevntLWgMyou?=
 =?us-ascii?Q?tGNird6vY4Ezqpm+j3ch19OyWySUoavhEL2O4wzlY0wqqGRobitYbHgtRWDU?=
 =?us-ascii?Q?YM0cT4oi1TSGMAPSFqL5iFgPgvCehB2UZ3avY4XjjLG0zsNeuDgQpsRjqJLi?=
 =?us-ascii?Q?uOBv+gVsXtAOuLpUR5EQ6LeSmCxStGotNmmKumgcc98iwrO5Gj0EyIGv4vEu?=
 =?us-ascii?Q?fQ8hdOoWpLfyw6BPcE2ItSNLVAUTjWPCO6dXzSoxM1rehVzZFxklIHj4IqKG?=
 =?us-ascii?Q?DUHGMSnBelJ3IJO8RtJ/Q0iC/HQy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?biIip4/RIEMTuPxyJLXJ3zZaqCzWK6nmd4sx+gQQLa+uHNZ5HML3mLVF4MKq?=
 =?us-ascii?Q?+sr114BmSMIgxj5aYCHzTXMIC42JwahRVPJPBF9jQDRikzxL6suqDp+Cf8Lq?=
 =?us-ascii?Q?ygbLRVlxQZXXVMcngFEAnIFh3OaEYBSLSnDUxLxKr7lBS4Y5bkeh4CZerC5c?=
 =?us-ascii?Q?vNSUAPFWVv62BTug+Ggn1N1Ecpdx+o6Gaaia3HRSIcLAbRu5iNxULAXHGSsi?=
 =?us-ascii?Q?NYzAE+ctm61PRjM+Jeq0+sHxaNwBvVTfcCNxdaJrrEmXv0QXAW2J2K8Kf/qz?=
 =?us-ascii?Q?BfVDCEqFXmP6lI/yG+gHcKfsqyT0AEtyxxL5Hrk+qhBxTg+4Q88eRUNEoK1F?=
 =?us-ascii?Q?yClQFOKQaNAVwCA86NzmBWhTcKS0zjuXiFzw+Fj4/4xYfU4a1RSoqtMk8jQj?=
 =?us-ascii?Q?U2jzRKcJsvoGkInIV98LNawMA1X/Pbcm81YiheYARjCsp4ND9LElg91ldAyl?=
 =?us-ascii?Q?oooPAZKytioGANrXetXKVnvpCc2LYWvj6Y1fqZU9auFJPXKxKON1J65NVBpu?=
 =?us-ascii?Q?neT1t7ofYnTw/9ZpBUifdO62PX3YX5Eyl4xwQ/q84+daLUpg2cnisGVthqo5?=
 =?us-ascii?Q?twjzAVwsKntV9T0L1SckUvFKhA0rRDZwLqyX+ZavMyc3hhB7uecM/LaYGFqm?=
 =?us-ascii?Q?rwg2wYu3RPFNX6TY3Zc4VUuOT9AzpuG6Ugnllu4r77BD2t2LoTeUzn+uWA1F?=
 =?us-ascii?Q?0T9UfIbMNJtHrnlGJn/dcx4o9cD8AMGHC2ImSNyAQRgE8IoSun562yzvag8/?=
 =?us-ascii?Q?XEmuHu7j5SiOJsWnm9qNN7r92D4t58rkzme2PVsEaR7iiErkmXjRWVsf5jm2?=
 =?us-ascii?Q?shev06qepBh1VEF2YtlffyScrpOjZ+4Xi9xDAKXIOn2w7TP/FUlHVivg4cZW?=
 =?us-ascii?Q?daGzFZAWmrAWvLlD6jT7l/am/b3d+PUGP1Zhcq6L9/0ykL5GYrkPBbAy4dul?=
 =?us-ascii?Q?aBvKxldD8Pq2z46jYfNrUO7Pxx8QdRmRX+Rc/qexTuRcBaITwpHNXvTUNUJ/?=
 =?us-ascii?Q?HTIlEqMnQFFEJlLgPh65praJf9Cn8ILyonjsqkJhfnimHrqhuomaICVpVz36?=
 =?us-ascii?Q?wUUq6XA3JtaazrQQcgORzKvZUYpKefKWVCwkW47e7JGcmOjnz7HTABjhGkCl?=
 =?us-ascii?Q?wUseXWdEXhdz9R/JusbBGoAgA80NnOX+adeVvxt+Jw/vlizJ3ii3cuiuvCEW?=
 =?us-ascii?Q?/rUYEXaTBOUdElRdjDNBGq+4bpkDa2/t6TQYljhGfIZfroH8b9UKZ+5ohOhk?=
 =?us-ascii?Q?i9/+Kgy4X5DIHjQpXD9rS85l/gEzO35R3Fvq8uw14PqVdd2bGbl/oddcKXXU?=
 =?us-ascii?Q?5CUz1ghARs7iQ4q/7/Q7mWhNK/FeMxqawRpvXR8ivzTvqMrnwhNsTqfyv93i?=
 =?us-ascii?Q?kC1N6xMshimLOlU/DA1+EH86D6tZHmLeG7dMWIXF9wDx/Jjqx1HIyzfdm4kI?=
 =?us-ascii?Q?+hFh2grUPdhBW4UHoAe0l06yn7RdSJcLoC1JM9tj5RJD6ir0yPBK4ybp9ckO?=
 =?us-ascii?Q?FWrE0nvIgTDiRXCmlXTQaU+GQfoJ4eX9eB7UpsMMPEqEU/gwBSZO4J5tz2p1?=
 =?us-ascii?Q?IFQochvJ7oBRICilVTEXJMGASMvo74HLjbXDErEdh/FpJrWUh7BKnSXqyfEA?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2de7cd-f7dc-47ee-069f-08dd3eb53214
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:30:10.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqpTkmI6IRjvAzIYzMJ6c1pjnaNbqpG0CYB0OHjZaUpPmV8ao5XdCjN8qlDF6Aqv3rFCIhizgH1ItaQjDf1TVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

This reworks transport.select not to require a local bluetoothctl endpoint
in order to work, since the user should be able to use the command to
select transports created by PipeWire, meaning that the audio server
registers the broadcast sink endpoint, and no local endpoints are
available.

Iulia Tanasescu (2):
  client/player: Rework transport.select
  client: Update transport.select documentation

 client/bluetoothctl-transport.rst |  13 ++-
 client/player.c                   | 156 ++++++++++++++----------------
 2 files changed, 83 insertions(+), 86 deletions(-)

-- 
2.43.0

