Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1153594F;
	Thu,  3 Jul 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549045; cv=fail; b=SU6Gt+rBGYhD/DsDdyz8sNqG3Ced2xljWiyWQX7uRLCO8wtxc8D7GTVP5gA2Mp0pflHSjC9bLuBgGVuMC0hBw+7zxc1TnWsY9+uxkEvbBera2n08RjVBmgV0c26DGLGMQWKdaezYiSBAn6ANVjxqx41ilHkNY0ZyuUavdT6mpzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549045; c=relaxed/simple;
	bh=3xIRtyuFnyDKlMk7g+pMEQc5fCz3NUanplr8wgFmcsM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EcZBg+f7QsH2hYkYnEZzg1SuTC2vIPx5KagIrV36FmaIIS8DNt69oDGMCzSn6KOb+Fztzs1HGWkmB3JX+zo8HaSTEXzID8Y/rRd6Vf3ng6zcUikmDm9Aru4iomO5/WIh/Qfgi9S8uetJUr+KSrnOveZLw9TcNSn9ReEw19QtC9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DxyKUdcV; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DxyKUdcV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q36Y2GDdF9TTx6HgwBK4BBJ2IQ0Ulhd0s4vKVrrp4DrzZltdsN0WLGekWf1uaHOhQrwTsSGJ8vhJz6b7FS4YnP3SV5ekpVhrjfv+XdzAV5QEZ3iwOD5UnErNUjAyFn4VJrUJgirMbFnt9HF5ZgZAUDUDwmpvwcWU24HN1wbvAPMsrrM1GWSSMOUJIqFb70Nh2dpfL04sOjGmsi4kao5FohSJVC8FsJObMPyGZ1hdoiTAKaG+bvLaKY+aneXFWfx4SR+voi7SrPFkcO622+A0S2C0IZMLEnCMaocrUPIx/ybGO2qlE+gdEa5wbBWpSs9U0AaggyCLCs0hbSqnr8UdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAf0STOMY691vxgphBERkNuLPZpY8Tmq8pO4pFi/YgI=;
 b=QSw4l07tXdtpB06ZVd90md6Efc6rNkYy1dCclvsM5MXb/mTtcwOw6DxXyhAP6MDFKx8eHD3YOydu7NV+ZkvC9djT5N5bsS8iFPSvpmnjPdUomWBYBkbRp8/9tO/HET9XQGll+gz7lGJGHqgq+/e1XiL4K8nMlQVHcOsmcl0Jdt/sHfzWghPkFEq/beAT8tI4UC/y2UM/KxRjZtk5/wruz3BCNDdpdtyaWuOiF3y40Tv9LVqcA3t0qw3vQGYfHPgMaK18YX1xh1A1aBdzhHj0sIM/oIlijuZDhDgNEl6LPRFrXyKgDEDJIEk2aAJkCrkf0xilZjyon8Z1q+51DXFkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAf0STOMY691vxgphBERkNuLPZpY8Tmq8pO4pFi/YgI=;
 b=DxyKUdcVAoo1oNlcKWs61yPRKNu93XzU7rWwKQflbyWSqKfT+YDkwymAR0YNhoVprlyIltkNsbRH49NgeB1BNRdRsVDMaAUa11pZ9YWrat0PD6RCdIMn73IyCR9HHj4mkt04BDK61bbmIJd0N3vUOdue1Ja+7k/XI4p8CDsYB8d/LXk9vBQn+XBBVpsOXhHiwbkghF+koOrwGlU/Jh/5U57EdTx19LRuogHQjhqc2CDaF64/OsBb8m8uyJLjxB9v4XrUtTIyUzKrDP+m38zIm1srmv2rX108IobKqvt15xP2tzchIjBPvolR88/S9i1vdelFvOGGL4srwjEoelel1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 13:24:00 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:24:00 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com,
	jean-yves.salaun@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Correct the Independent Reset handling after FW dump
Date: Thu,  3 Jul 2025 18:35:48 +0530
Message-Id: <20250703130549.1659732-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI1PR04MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2201f9-765a-4105-70c2-08ddba34dee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm1McEx3Y1ZXemR1VkgrbVNXYXZrWnFTT1c1NDMrRWw3RVBYUVNaUjZXdWJu?=
 =?utf-8?B?Vnhabyt0czJuNTMyYWgrSXdhY2RBLytIM3Q5cG9xVUszMUJKMmdick5zU1BI?=
 =?utf-8?B?VEE5RS9jMVdpQ2w3RGE0MUlZNGk3eGtqK29wR1FJVW40NGVjUlhCMG9ZRzVC?=
 =?utf-8?B?TmpqUXVYcC90djhLN1ViSDBJOERnMXUyam4vWmRmeE01dFVnYnZzWVhuVmZo?=
 =?utf-8?B?T2hGQ2FpR3RNMUJVR3FBckZIQ3FweS9nQzVLNS8vbGRGaDVmak9ZY3NwQ05r?=
 =?utf-8?B?UThYclhZZVBwMEtmbGMxMVRmWnB4TW4rd004Tm9YV0l6WmhFbXNZZnBCc29v?=
 =?utf-8?B?WGkyYmRCWG8yMGs1alR6NStoMERpaGdMdGduUWJCem1kbWdPVStpVmhaZTBu?=
 =?utf-8?B?QTZveUpuSGlKMHkzbG9tcnQwK0hUUy9hSlR3cVhOTnpsWnJrOWt0NWJHa2FP?=
 =?utf-8?B?a2dsSnNJRDR6Z0xiSGw0dWdWajBtNkVBTENMNTM1cFRZUHJnZEhleCtmd2lu?=
 =?utf-8?B?TitpN0ZuRDR0WTd5UnhNa29LUmkwQ3RUUzhZd0Fld1FxWXUxdGJrOVp3TXZP?=
 =?utf-8?B?TWttRVFRYXBqOVdnK2tMejNWNlB4MStvaURaYkthVnZIR0dwNE5oOUcvVlJZ?=
 =?utf-8?B?THUwSDVCNkJmRFFid1lBMVF2REd5SUZoY3Q5WkVyUmJWTXM1djc4VENTdjJh?=
 =?utf-8?B?dEZPUkNod3ZiTCtEalErRldvVzNtVEtJeS9tNmFlZmUvSStiUlJXZE0rL29l?=
 =?utf-8?B?V21Ib1MvMmM1WWg4T2huRmRodmtnZlRwLzNlNGRYemsvSVEvME1IRldEQys5?=
 =?utf-8?B?M21xdjltWEZDU1BoeFVCaHZXMHZ4d2ZOT0NrRXFBNzFXWDhCNWRBTEpjRzlw?=
 =?utf-8?B?dkxxSUI0bjdEeDZiMTBBU05mOWpYZnlVRWdTN3ZudEJZRUlYc3dqWW5UYVB3?=
 =?utf-8?B?eGRkQmZ2ZmVkUE5tam1EblJ6STBxOTNzUjNLZEd3TTJFOXcxZFM1SUFldU5M?=
 =?utf-8?B?cXlGLy9ScVRzQk9tZU80Y0lPd3FUaG95U0lFL1JWMGp6U0xHckgwWm55NnBG?=
 =?utf-8?B?ZHlCWVFBbFZvbXIrZE9hRjNyREhuV2hzTVBIZWFLRmR0RFl3MnB1VGJBcm1t?=
 =?utf-8?B?SlQyODlrNUtnWkcrQUxQdTVOUk8xWG9TMDZXYy83SGdTcGtwVnQwVUlmWUU5?=
 =?utf-8?B?MmtueHQ2cXVlbDcrVHVOV29PdS9IZTM1M1ZrMWUyRmZqY3dSVlRzaENMZGYx?=
 =?utf-8?B?blgvU1pNRS9yNVk4NkhtUWwyQ1JXYUFVWGdRMVBISUF4RDltWncxK2xaWldk?=
 =?utf-8?B?Z3poQ2hjcUpuYnc5ZGs0Um8yY3oxVld6eTlFdENEeWFPeGMwd1NUc1UxSU9U?=
 =?utf-8?B?bzNEUFBRZ2NvRVhIUjhQblZINGptcGFQWXNuZEtEUGZpMWFNOVZsUHVvcThT?=
 =?utf-8?B?UDRrejIrNUJuZHNCMVlkTlV5M0FzVzVtakFKL09SYk9DbkNhaWxlRERuQW9J?=
 =?utf-8?B?NUZ6cUxhaE9SOEJtemVYTVhLY25SMVdJZTVKOCs0VGh2QldReEJSb1FNNVBH?=
 =?utf-8?B?R0IvOHppa0VicVJmcUpYRmRMMnArOWZyNUpZUFBHaWphVzFzZElCYzVsajFx?=
 =?utf-8?B?WnMrbkxxdDI3cUdWM3hIWlBBRGFxMU5YOHM5SGdReFp5WnhqanpEK1hxbXhm?=
 =?utf-8?B?UUFYL1QvZWxhemQ5bnFxZUpRYUJiQURXYU84UGo0VXJ6dFd6Z3dlK3NaOG1I?=
 =?utf-8?B?V2FtYkpPSzYwNTF0dHhSVVNXd2ZLUllHNUMydXptWCtHeEphRzJDSVpubVZw?=
 =?utf-8?B?d2JwclkraVZVMUNyNFJxK0Z5dDRiTmpIREVZalEwTS9JM1FZdTlEdWo2SUhS?=
 =?utf-8?B?c0R4TjQ1R3FRamtxeGVnSUI5Q3lVK3RSaEd3VWN0R0JLY3VvRFRyYU5SR1pP?=
 =?utf-8?B?ZE5tbVc4dDYzemhHbitqRUVxTDhHZDVaWGVNSldSZlo5cm9TOTNnYjM2TC9O?=
 =?utf-8?B?TC83RkNKKzZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZ1Z0o5OStocHVOTjVCMk9RWHRTZjF6RW5QLzhGNkVjR1JpQmpOSVdqUVpn?=
 =?utf-8?B?V2h1cmZvbVc3bll6TExnUkZqTnVGVjJSeEFMRC9BZG5EOWhKd0svdFRNSi9L?=
 =?utf-8?B?L2VNNVhFak12MTVoL1VxRWtiRXBmMFB2b3Vua2d6K0xGZVdtb1JNTGhJM3NR?=
 =?utf-8?B?SGxTWWUxbm5JbU5BMzU2OFlOOVZnc05BQjg3UjNUR0tKblB2UHVTVFZLSjFp?=
 =?utf-8?B?YlpjcjN0VlpIMjZEbHJlVzN5R1JDZ0dlTktnNGFYUkhkQWVvOTNQSFcxd0JY?=
 =?utf-8?B?TGN4SUFvK051eWMyRUhTZWVHYkxPUkY4RkpKc0dFUE1WR3p5ZjE3TWlTc0Z2?=
 =?utf-8?B?dG11S1JwVjZicENXV1BGTkxIa2hxQ2EweXJGOFFmOC9Oc2NkemVTbXk5SUpF?=
 =?utf-8?B?Sk0vVGRjUGhqa3RvaHF2VGgvMHFXNmZ5TFlQSitTQmRDVXRTK0NQWEcxTEJx?=
 =?utf-8?B?bWt6Vmc2a3ZUcGZjZHRCdGJ6VDluNXUzM0pFMW1UNHAzdDlKSk5nUCs4WFh1?=
 =?utf-8?B?QU1VazRMWFFNb051elZFWkFFOFoyLzB4cXVQN0puRDBxY0s5SWdHTzVxdDc1?=
 =?utf-8?B?WnppZGlZbENER2l4eFpCc2xXaXBQWnBrclpCckxNL3FMUzR1aTRYd01YZTFM?=
 =?utf-8?B?em0ybjJuSlhEUjdWUGcxL05sbThQdTdkVEl5YlZsb1psdXcrVWM3cDR2MDlY?=
 =?utf-8?B?dXlmWFMycFVqT2ZmQ3BhS20wbXJUZ2xVSU91aXA4NkZLaldYaXRmRnNjSGdt?=
 =?utf-8?B?QldPWnA2d1RzSytwQVRnandnNHNZQUoyV2huVERLU25MUDA0UDNZRkd3UlVo?=
 =?utf-8?B?WG4xbG9nZEtkd1JoZEFpaExUMytTNEwyakRsRFFQWTRtMWJ3cllSWkVkaUQ0?=
 =?utf-8?B?RkhEVmQxSVp2RklkcVd1RHRLRTJEbllJcWdoWlNyWTFpOFBiWGlsemUrbDFZ?=
 =?utf-8?B?ZjVmRHRObWhTUEF4M0d4VlFBbjgyQjRLN1g3a1dtcmFCWEpIREROOVI1K1Fm?=
 =?utf-8?B?aDhKR3k3aU1VUWY0ajBoRHVvRUZRRVBZQklJUUpubnFWNWFPRjdJYVd2RzYy?=
 =?utf-8?B?Yy9QZDZzcWNFUGtLeWx2N1IyMzdmbUVUeG9CdG01UENiOEtKdkxjRWZDcDVT?=
 =?utf-8?B?ZE9laVcySjZ5Nm80VENhU2ZZTC9hQ09lMS9NaVFEKzVZakExWkljVXVlYmZS?=
 =?utf-8?B?cDBFUkN3SmM5VllMaXRFOGU2dEtYS25TZ0cvL3ErTEg2bFh6YnRsdVdUWWFC?=
 =?utf-8?B?S1FRejZoRmpDc0I5TCtsYUthdFU3WEFmdEN4bm85ZkdVai83dDUrR1dIMEs1?=
 =?utf-8?B?OXZxZUlvMFp6L2FmZzQyZmdFWUdJOW5GR2J1VFlGM1dMeEhZeFdEK0x5a0JW?=
 =?utf-8?B?Wkk3U0NUZjlnUzVPeTlQbEtYU1M0ZTR6MHNBMmNROElNVzFuYjljQnFsZVd0?=
 =?utf-8?B?MUFjaGE4TUdWamVpTkIzazNjL015RVNoZHpCdkhjMU82ZUVxY015d0U4dm1H?=
 =?utf-8?B?NUEzTE5oRk9UaXBDUHpRcWpRQk9CRTJtcDhCWjExZkhOUmVBRUZmTHl4dnpk?=
 =?utf-8?B?c1YycHNlTFJtcXdvVzk0ckJ3UXdPTE5mUnhmc29nV2xyTHlMckdIZ2lKTGZ3?=
 =?utf-8?B?Y2dpYWJsNER1aXFMUmdtWUpoakllY3hpemliMVhBK3NGa0phODBDZ3ZtQjhh?=
 =?utf-8?B?KzFsckdQckEzNnlkSFVrb08vOTZZNXlGa21YVkFaaHI3ZzEramZOMHFSRnhS?=
 =?utf-8?B?L1ZyT2FGQzAzZ2h4OWFNTlluQ1d0NTdqM29NWkFYUGo5R05hVDNxQldmVmtT?=
 =?utf-8?B?OFE0dnRNTzA5dmdnUXRVL2x5V0l0dEhMa05Yc2xqSm42dXM0TGR3d0hXMFpi?=
 =?utf-8?B?S3l0eVhLY2VFdTVrcnBwYnlQSzNKdmM2cEZzR2R4RXlReHFxVWtTNEN2a2FF?=
 =?utf-8?B?TkY5ZUtISmxlN0NHblVCSXovVnd4dEpWd1FEbHdlSytNcjFjcFdPT1hZUEli?=
 =?utf-8?B?dmE3Z29pZGd4d3RFSkJhdWJORmdUTWtPSFNUaXNNTE9XZ1JLbExKdUl3OUd2?=
 =?utf-8?B?L24zVGMyRUh0TWtNc0JBS2s4cVRCWS9TZGRmNEppc1Q2NmVvV1FBdGg5R1M0?=
 =?utf-8?B?N0RORGJ3N1d5QnVJRGROMDd0Q295U0pocEVuVHUwYklQSEdXYWFKQks0QVZi?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2201f9-765a-4105-70c2-08ddba34dee9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:24:00.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKwQD+3CoouJa/hisimPTV+86K1ZZtUXUCRixAaeQy7kYaMqe//iqYKpVpfEUG7z//cCl7oUumFBzlnbFkd7PTgkrsl3r/gAxSJZrZvIQFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896

This adds proper handling for the independent reset command sent by the
driver after FW dump is complete.

In normal scenario, the independent reset vendor command gives a success
response before jumping to bootcode.

However, when FW goes in a bad state, and sends out FW dump packets, the
independent reset command does not get any response from the controller.

[  159.807732] Bluetooth: hci0: ==== Start FW dump ===
[  180.759060] Bluetooth: hci0: ==== FW dump complete ===
[  182.779208] Bluetooth: hci0: command 0xfcfc tx timeout
[  183.364974] Bluetooth: hci0: ChipID: 7601, Version: 0
[  183.368490] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[  184.679977] Bluetooth: hci0: FW Download Complete: 417064 bytes
[  187.963102] Bluetooth: hci0: Opcode 0x0c03 failed: -110

As a fix for such scenario, the independent reset vendor command is sent
using the __hci_cmd_send() API, which does not expect any response for
vendor commands.

__hci_cmd_send is non blocking, so before the tx_work is scheduled, it
sometimes gets canceled and 3F|FC command is never sent. Adding a small
delay after __hci_cmd_send allows the command to be sent to the
controller.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Jean-Yves Salaün <jean-yves.salaun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index c56b52bd8d98..f40794be2d89 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -367,17 +367,26 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
 					u32 plen,
-					void *param)
+					void *param,
+					bool resp)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 
 	/* set flag to prevent nxp_enqueue from parsing values from this command and
 	 * calling hci_cmd_sync_queue() again.
 	 */
 	psdata->driver_sent_cmd = true;
-	skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_CMD_TIMEOUT);
+	if (resp) {
+		skb = __hci_cmd_sync(hdev, opcode, plen, param, HCI_CMD_TIMEOUT);
+	} else {
+		__hci_cmd_send(hdev, opcode, plen, param);
+		/* Allow command to be sent before tx_work is cancelled
+		 * by btnxpuart_flush()
+		 */
+		msleep(20);
+	}
 	psdata->driver_sent_cmd = false;
 
 	return skb;
@@ -597,7 +606,7 @@ static int send_ps_cmd(struct hci_dev *hdev, void *data)
 		pcmd.ps_cmd = BT_PS_DISABLE;
 	pcmd.c2h_ps_interval = __cpu_to_le16(psdata->c2h_ps_interval);
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_AUTO_SLEEP_MODE, sizeof(pcmd), &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_AUTO_SLEEP_MODE, sizeof(pcmd), &pcmd, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting Power Save mode failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -646,7 +655,7 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 		break;
 	}
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_WAKEUP_METHOD, sizeof(pcmd), &pcmd, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting wake-up method failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -1272,7 +1281,7 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 	if (!psdata)
 		return 0;
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_SET_OPER_SPEED, 4, (u8 *)&new_baudrate);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_SET_OPER_SPEED, 4, (u8 *)&new_baudrate, true);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Setting baudrate failed (%ld)", PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -1330,7 +1339,7 @@ static void nxp_coredump(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	u8 pcmd = 2;
 
-	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd);
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd, true);
 	if (IS_ERR(skb))
 		bt_dev_err(hdev, "Failed to trigger FW Dump. (%ld)", PTR_ERR(skb));
 	else
@@ -1372,7 +1381,6 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (buf_len == 0) {
 		bt_dev_warn(hdev, "==== FW dump complete ===");
-		clear_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state);
 		hci_devcd_complete(hdev);
 		nxp_set_ind_reset(hdev, NULL);
 	}
@@ -1486,7 +1494,13 @@ static int nxp_shutdown(struct hci_dev *hdev)
 	u8 pcmd = 0;
 
 	if (ind_reset_in_progress(nxpdev)) {
-		skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1, &pcmd);
+		if (test_and_clear_bit(BTNXPUART_FW_DUMP_IN_PROGRESS,
+				       &nxpdev->tx_state))
+			skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1,
+					       &pcmd, false);
+		else
+			skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1,
+					       &pcmd, true);
 		serdev_device_set_flow_control(nxpdev->serdev, false);
 		set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		/* HCI_NXP_IND_RESET command may not returns any response */
-- 
2.34.1

