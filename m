Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582775BAFA
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571071; cv=fail; b=hyAP1SbK1y7mfF08Y59gxW1X3l1Dr6eUaXcoyu2nuOaj4kRh40kJKnDfTb9jVvGmrPl65MByNQhXSOQS7n8rfY0ElDw0PdzCdvwqmRR9cwmgXtTGdoB+9yYh0DwOKae+CoLzsVNk+pvkSvjtxeXcPef9Q7bTFzR+i55dg/S3Y8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571071; c=relaxed/simple;
	bh=b8eMKjSR/BcsH3tfbQxqbB8WS7Rtv1WSqwxg+baMWkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vACJNwk1lOy/F4RmeJ1U7a8pSZOun+JL8RanSGWOkVVUbP+NYTlB+GwCrJBRIYJDMWSZh6xNcfVVOxt2RVI+dXefyy95nIUG7ZxKgEZCc6Lh4u4Rk3YphNdXOLjCxZQ8BMFDeQiXXT8vwDFsMkDLmUPtBL0ZS8+SPKTRMsqcJTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SWh7z55U; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWh7z55U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9LIqvmb8EQKw8fSMdoggbNwr7dmV5adNT6sBhViSKARXU5bsZtjYRCDfbe3hKdH8tDM1lgHL/P8s+2sh7nryeR/8LBsgn4uj5GAUKdVh7L+swymJAJtLuGUbV6lKUyjbUzqYOUj/BStVMRI1cNbF31cGn2Z0sG9hAaNRI9uo6rVjnhs7suRHvyPkx3SXT54RCyivZIvv/l1quB/AQFuJCPX8y6Ja0UXbmDzpSwIrkAb0uHDaY/7x4FJ6kJrxvj/Y3ftUygJSvcpRWfvVMWaCOfutpzNqYENC9TLGEGiLgIxaDWUIA/E0DK7vNVGXwVwszzKIkV0JUWqKm2DqK5pXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTIaFcnuiXhePi42TF0+ajq49nVI0AcwP6Lz9FqCMUo=;
 b=TRPg0p2OjuH3YESKeybls2IQlFhNG6sp8+XtEovQcB++azk5A8iLaD5hsIXVYkj9mhjGcclS+Z08t5AGXM6Ynp4TVcwHJYxZBw1J9KC3FPFhn6s2UTXMBYZPMcO8U80UGr2jmXrWYvo/XSpxZeX4zKJmvVhb6zjodVOSD7TRMaq5WUUu8UKs9lguqBBvRDOLDnTY3ulSs9nQ288EDQlrCwxuhsC/I5jC5Z2d/qSLcQ2P4cEr4a+ofms5nrHOwibIlupXFRhSNTju995HPwdej9u5sFgAjuDpydkOP3xzW5+wceoaw4CTNkvVzzM3QpdL9tNKJo1cgqaQ9PkJgkeYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTIaFcnuiXhePi42TF0+ajq49nVI0AcwP6Lz9FqCMUo=;
 b=SWh7z55Uc/DcVYXKaiwDaFds82nOWI/NokEreUK66hhoVxA46mBw8gehZ/oy0gYF5HN2c6GqUC4frUVdbKEYfEt3ya6rzxl33oywWMCL6v/bo7d+TfT0SXQmqA1NECUCCpOjnKJcgAxUFqnQ3736GLyy9utK+0mXjWEeYB/59Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:51:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:51:06 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [1/2] Bluetooth: ISO: Fix circular locking dependency warning
Date: Mon,  4 Mar 2024 18:50:49 +0200
Message-Id: <20240304165050.3430-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304165050.3430-1-iulia.tanasescu@nxp.com>
References: <20240304165050.3430-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6230d7-5a4c-4647-47cb-08dc3c6b4901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	//ysKPFm25XqBlltEx7sMupt8s1RoaWf50IxMyEbmOcbhbLlrx8uWlxXWlXoDe942Uoqz++U3s4dyeWxpu3sp23NHuCrKKjpZjpFjaud2MccaEv4RTDbj3fLW0Jdx1Rq57XqxSLVOtAgyiAOtau1LLQyVv8b0HIf7KbwG5OFvTmr03d6GxgaKBsdfAJ/kfws9F+PvIIMRiWdl11MmlzJw8HlC+VB1a2Ldfdlgpx76G8O4Dr5o94b9BxILFP1PEaInPBRRqlcvSPj2g3M4SMU+4f7WsFXmvCZTIWCTxm3etUFDSkFWRi+hf22V+Wd7AEtdxVoL/iuC08rhu7TsQiqGVCWmqPHeMEljTDqjjVihRrfPYibG4zrQatFtvFvpE4JDuBsH6I6D2tjNQeQZi+nF0PoOtPsoWqiEPziC5l99hSSw5e3Y2QPliBBKqxST2bL8x7LUqOm3kvJjmOlH4Rg20kraD3O1iFuQxFBydMnUjJtssqNrVSmTktSLzZrkYNZ7aPQ2MreNPikAAiqLM1j+K/dVybvrixAjlWnTk2CBpyx4WDOYIE8cX1QIX+j49DLncLmcLxJ4+z65cgd68G3ee+jJD2c744YSIF+cn1XWB8cy1QMy4rvf1fHc7mn27EDLrYqI+gzmeIpqmdNa/HKBq3cj8YhsyeYlgJEpFj/FhU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98imclkTF9DQfongwKayj0rxeGgw6EoPmNm0o1joLfuNZ9A0S1acCaygq+Ic?=
 =?us-ascii?Q?ENXPrx2w4q3z1lv8MYdbA5kn37l9nDFHfdiY8uN2UCRXQP67w/+NC58J7Gmf?=
 =?us-ascii?Q?xtluON/IMHe42Qg7xGTzzG5KKufe7SmTd7n6wPf3/1A28wjmI7VGeJhj7cgR?=
 =?us-ascii?Q?ihojb/AWl0XMj08LWOTRZB8aW8Pw5bBy3Pv7YMpvIsRMmRfv5VCd5aiBIvGH?=
 =?us-ascii?Q?6Ho0tB+qrEXU9Uu60/691kBAMUTg+Z1WnCOMitoq5FmmuTMc0vbPezKB+9va?=
 =?us-ascii?Q?HQNpJZ6djLXBK+ROprxBM6LibP4yME5HTEIiNhQ1EzC+ChbwAAGppCxc/Mtp?=
 =?us-ascii?Q?DkZZ0uMn2q/oyXv/tT+c4rn6Xc81uObxE/RUGX7OLPWWW5mWsEkSdY4KwSNa?=
 =?us-ascii?Q?YvUA8R4iIfPIGnX3hL8mAu4QHKG3+xnJZlj2b68ZHQpSBy3IOFcOF59rOK9b?=
 =?us-ascii?Q?DzeiyIP/IKuP+XRGfW2JJ1qfD7KQwNmxhuwyezAcJUGSCLz2NUDkgoMtiRw9?=
 =?us-ascii?Q?T2uDiL6n8Wb/Xtn9pPQDCe29iF6UrgxhYcPs4fIhblD1fmRxf67RXoviiTsW?=
 =?us-ascii?Q?0Df50KOxT9BTYQyLoNsSlfjDZRdNBjhxd3ieEfbalaWsXS/x25nIXaUkNybY?=
 =?us-ascii?Q?CUNOQWyv/dkS7Mm0lAc7Qw+g4uvxslwOFexK1KzCy1Y1DT/QwW/ngQPEUbu4?=
 =?us-ascii?Q?SpBq4LuNpOWxdwVSdbpyhS733Rdu02RjrXtMybkBGU6/1IBkFPZaInOybgEe?=
 =?us-ascii?Q?6HsvzepZdnQoM2foKNESAmwiqK4iz/6RqcSZ+qi6D/LRfYI8avU1LsM57rzN?=
 =?us-ascii?Q?RtZVYH5l7147so/WQS0yVA0XH6pBPDMu9950/N8QI0cL2or21GpGXWZ9rPeS?=
 =?us-ascii?Q?bQBsjspFyOj12rSFi/B7wrzZHAjO+0aixqD6chOoZ38O+pFET32YFd6QmoGr?=
 =?us-ascii?Q?HoH/Ie4xhZq9IWaOSGCg3Y+2cHYptJ1hL0RL0WJbQwWakmQulPl6XikQhJ0d?=
 =?us-ascii?Q?hA0Vzaf30CmaF+cmiRxDfdzWMDmBd0aWU9NW6mqJ69ZXFgzy1pM+NcGRsA7a?=
 =?us-ascii?Q?9FO2zMGHb3PxBipff+uOfXe7lv+r+Fq1P9NDYsXE0GDuHYG999izpHwGPyVu?=
 =?us-ascii?Q?UW39a4MwPpQgRD3CcKCVAxjy5zULJheXFhN9DmvmGxxXyV+Z+t+8liiP20DN?=
 =?us-ascii?Q?jszjntSMUHXynfy2C8GPOhPsjr4kg1+Om5HFLGiB9P/ZLLGWcJsuokR20EgR?=
 =?us-ascii?Q?7W1j/1d6GbBBM+1jB8TFJFIBrK62oFeeyLR2goM0FP4JuHMJG53JOhzPdyKi?=
 =?us-ascii?Q?9Pw8Ij8vuDBsxeweAaNLIPaZuBM2LKYz+Ib6IczCosbOqOnfcCBhXpmpOF0h?=
 =?us-ascii?Q?vG5S5aMudxM6te/hieSfc280uUynTbInFCmMOYQx/7ISzOZxGbdU/DFyzSVt?=
 =?us-ascii?Q?SDburrP+/xG+k+t2jggV233vIrnnkAhx3cs0z2O8jkRA7ruYDwANxxRQv8UA?=
 =?us-ascii?Q?/e/9aOuvlpIDDyqm/uj1CBNgcGp/676iBiRTnU/BLeeSlak8L592dns2WRNk?=
 =?us-ascii?Q?PjKR4R7iDwLFNvQeWkRAkqGwTMLbs0t8GifxvoWCkRCmJe8Pf5CIyKJZgIRn?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6230d7-5a4c-4647-47cb-08dc3c6b4901
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:51:06.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFUXQXkfBaoE34sAdCBrcZNI2oowatmQWEDP1vqmIm6tbQktl8GkB8odbEyjGSgChuTXRGxh0xado+gtmp3/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

This fixes the circular locking dependency warning caused
by iso_listen_bis acquiring the hdev lock while the socket
has been locked in the caller function.

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc5+ #1 Not tainted
------------------------------------------------------
iso-tester/2950 is trying to acquire lock:
ffff88817a048080 (&hdev->lock){+.+.}-{3:3}, at: iso_sock_listen+0x305/0x8d0

               but task is already holding lock:
ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
               at: iso_sock_listen+0x91/0x8d0

               which lock already depends on the new lock.

               the existing dependency chain (in reverse order) is:

 -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
        lock_sock_nested+0x3b/0xb0
        iso_connect_cis+0x185/0x540
        iso_sock_connect+0x445/0x7e0
        __sys_connect_file+0xd5/0x100
        __sys_connect+0x11e/0x150
        __x64_sys_connect+0x42/0x60
        do_syscall_64+0x8d/0x150
        entry_SYSCALL_64_after_hwframe+0x6e/0x76

-> #0 (&hdev->lock){+.+.}-{3:3}:
        __lock_acquire+0x208f/0x3720
        lock_acquire+0x16d/0x3f0
        __mutex_lock+0x155/0x1310
        mutex_lock_nested+0x1b/0x30
        iso_sock_listen+0x305/0x8d0
        __sys_listen+0x106/0x190
        __x64_sys_listen+0x30/0x40
        do_syscall_64+0x8d/0x150
        entry_SYSCALL_64_after_hwframe+0x6e/0x76

        other info that might help us debug this:

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
                                lock(&hdev->lock);
                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
   lock(&hdev->lock);

                *** DEADLOCK ***

1 lock held by iso-tester/2950:
0: ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
                at: iso_sock_listen+0x91/0x8d0

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 30c777c469f9..163b07db575d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1069,6 +1069,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
+/* This function requires the caller to hold sk lock */
 static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
@@ -1095,7 +1096,12 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	/* To avoid circular locking dependencies,
+	 * hdev should be locked first before sk.
+	 */
+	release_sock(sk);
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
@@ -1128,7 +1134,10 @@ static int iso_listen_bis(struct sock *sk)
 	hci_dev_put(hdev);
 
 unlock:
+	/* Unlock order should be in reverse from lock order. */
+	release_sock(sk);
 	hci_dev_unlock(hdev);
+	lock_sock(sk);
 	return err;
 }
 
-- 
2.39.2

