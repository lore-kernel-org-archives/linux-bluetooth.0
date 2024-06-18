Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE31459FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706813; cv=fail; b=e0ZJQMd5pl2OY9kilQe2AS4i0vSB51tQe4oSc2yWcTX2JKCepPsJdcFJe5TAiGQzzxcGpoDM2R3+2WFl7MtOfbbSI+5qL00nA3jW91eGCAzseOm55Lef7bpmYd9jsGtMwWgkbC7DwIs8N5U/X/w3LPu4GVj4FQvf2YZyOA9/DMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706813; c=relaxed/simple;
	bh=ERIS6gW9IWfqJ6+qiw81tgqgFARGLoTojZyIZQgGxsI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=duDl9hi/6OtYpqMxMFOR2O6Pw5Jy6QdKe8Kmel7y0HXiZCLT7M343EOOPeRq/C89IuKOwltkTs5DA5BcV/lhnJ5jg5YWa2Og4Xv0ysGHZFMoa1GEztwXKERFlOUKKKa3lzSw/bPdv+ubsmmViKVjKuSfrvvgqkw5h3tbMl8e2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZZbbtKgx; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZZbbtKgx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxfV1jA6tniCFx1uCe7jia1ukao9yxtRuAGfiaN8bbMOZygksys0Zt9CQr8E8U+cKonPAWLBe5pvMu0mcLVRgmTOXRrfx2tOzpNfbCzjA43s+aRElgaVQlBnggxV275vTUI8sIe1buv3i3oOOHmeRzXpq71YczNrECW+OSaQXtj+k7za50XmS2PczxjXwZfeme2Z05goBW+9awMPzmXbGqy0fsKnasWtkUbMYgw2lzVetdnEO9/2cjxhpnESVdBaFf2p+sbsK6KOGy4Q4T6gByQsh1YO/+oRqi/n+8IKAk0vFqabxMUuFb/fbRiIAMcSxBxFiF79ZBnTxeUYWYO51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3crIMLrts8yTnfQKI17QP5grHqSnJ1CsBP4O4G2Fj7Y=;
 b=UAD+ZFUw81kE9RHbcTitAkq7JDDG+yPe2ViUaBEaa9mtPkP9OII2vlSfAiSTjiJE19V8JbTnfvDM2ckI/t5o1YjVcT7EL2BXKeJeevZNkj5kxrn2ex8jfhTQHRRcaDcZv69bRTn96COBHyXYNi9YSmUUYxa3LthjyQWGUpraGRAnzTodZ/f5gYz7duyZltqBhRHUtQh0S9mJ6tFplv8zRubQPXtmrgyQ0O4T8Q49245m5Pgey4EnAia5LiBOgd4yfu11baLUswBXnMIGGDrp7sWUUGMKquuoqqbeHmu+wB+IDbUTi9Uj86axu8YQnNeqNPN63QwJBrB2JjKE1xc7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3crIMLrts8yTnfQKI17QP5grHqSnJ1CsBP4O4G2Fj7Y=;
 b=ZZbbtKgx9I2ChDHhzOxangNQYFpD5wTG8Qlwodz+gYuUlk+wLIMG6G4scO1gn/uobVMCLJ2yuLu3/G/pu1HpriixX2pPrfXYS4Dyhpn+Zo83mvKWmKd50hoaLjTpxgMNLuYduMkfnSnwRcU6gWmIuulKhPCkT/fCmmXaZDFmMHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8723.eurprd04.prod.outlook.com (2603:10a6:20b:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 10:33:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:33:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Check socket flag instead of hcon
Date: Tue, 18 Jun 2024 13:33:23 +0300
Message-Id: <20240618103324.15645-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e12af2-ef51-48ed-3da9-08dc8f8217b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f2LbKHHjweQIFj5tMf4xHsB80XGcFKtNa3qGl1ZrZrmOjGsdvSjSaj7rK1ai?=
 =?us-ascii?Q?8pO4eKWYsy1TJn/xrpLKAUp+ApC6HKYUfA0zce9IXh1qVfGHnghKWhu8zxJf?=
 =?us-ascii?Q?YVuqBVbGPFwMd1X9IzyRg1LrvYozU9knjzPke8VAjEQQ/tQk177F0LTVSS3D?=
 =?us-ascii?Q?doQfE43b63M/KncihQYcEaFMMWXFlp7KQtwrwQm7F2nyhc3Hl1YEvAOeyK0k?=
 =?us-ascii?Q?KfEnsDzXNPgCLn3apn4rNfDkrkVvkelKBxLyGLNn1jIlntSnL0qk7YSFcCAz?=
 =?us-ascii?Q?YaH4nhJR5UfayIMnbh7521kPP6jnUVrArVIzjKH1t3m9wiz6EHnRoEGxFfj7?=
 =?us-ascii?Q?maXPlrHnaMOQl1+qyWuBLIYt5/pa/nGBkSE8/+0x6WMRqMXx0FwJO3Zineua?=
 =?us-ascii?Q?EDDyH7ljSFdFARwLRLLTskdLersuZ7dKxxIteraxHkG1OJ6oDrGicGJz5XJl?=
 =?us-ascii?Q?ECwX7CbiNwLrPLp3l/azE5LaRa/KgqsAOPk8OMDfjM+I6DzY2xESAOghOZyk?=
 =?us-ascii?Q?zx7hwMEWzCEvreePkyIB9nC2ERulGOx/1GJJRxo62KkiTIDtjR0Mv0GcLsnU?=
 =?us-ascii?Q?anums3kJ+QcIuel4BUbS5wJ1y94/2wv1/XOju/bCeTlUxA5ovAFusuaHCDYj?=
 =?us-ascii?Q?Jo5tBcqz2ivOCCSEzZHPYcNpCin4tpAR/bnATJmF+XlN6tqN25LrYio29euO?=
 =?us-ascii?Q?3gixSu53JDJBmI3tDD16q5XU31ln7rnVL3CfkT3kO7cLTUtj8I9nGqJf1LlS?=
 =?us-ascii?Q?X9+5DrUgfVLakDebgjNcG95AM59r7R42Uch7vm7lve/hrEZcQpGP1DWm898k?=
 =?us-ascii?Q?aFDiFv3f7RGGRQ3/EQsj1+Z7+qFKix7ahTXzM0fd/Uvbhh7wPqLpDDOz3QN3?=
 =?us-ascii?Q?twtWlFeV1EeVimQsvNA1e7CTobsbCZEYKVu0bYo9XSTPApFvGKsf70N2U3Yl?=
 =?us-ascii?Q?EYhhaEW49NcjtaV4iaImanOYsgykmlVj1dYzXmlP6+TtNMFpID7m6GTRQbHV?=
 =?us-ascii?Q?iuqO5QFvHNuT4tPRYgSUAZsDxhSoq7mNEv27hJmUB9t6NG9OqgSNgMKOcfRy?=
 =?us-ascii?Q?+jGV+zZzQ/KOhSXw/Ji9xC2Jk5FtRjlL7ETWlrpYxjl0cEk5GTq0SE2CVem9?=
 =?us-ascii?Q?lesaEKpD13yBPYuX2Ov7qD/QS0bNboMvCewO5iNsOXWFgaEp0bXzdJmPu8L6?=
 =?us-ascii?Q?0nUDVhUf0ebTmFsI8gzvDZJxUgkVOEp+lQbYPGALq4Stogvey3GQ7mH+bN7r?=
 =?us-ascii?Q?WdEA9pJmOrVmZIiNFpjKRnMGYVFDZ+EXuFkgE2GXskruEqBs4OUE90UelaEe?=
 =?us-ascii?Q?uL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgF13JtZhcrHpWQh6egqC63cDk6IGtsI65K/caOSqGzXa17ELU8GbnNSr3FM?=
 =?us-ascii?Q?jPcYtav79uye7GaxeZkksMHg3VHh9wtuETNZReIGM5wH9jF0uFxPcuLSAMJk?=
 =?us-ascii?Q?JfAOJz3J33cWLnGBSNGNQT9P7BRKP94oZkBZC4BiE/QMJPdDU2K28Hz2TwJK?=
 =?us-ascii?Q?60xvucPlX5RCwtTB7LTV0ip0DSLCMCR99+XXLpGFATmR02xkOYDF59SnkivE?=
 =?us-ascii?Q?zgQu/PZUQOXNLylnwEow2Uoiy9gn8iRwkfSnKpqYqOkbu8P1Wf8qkoEAdCLW?=
 =?us-ascii?Q?f6xlPpb0rSGhL9uMC13OGZKx2Dz3ztGNYFXQ/xebOzc85pgBEGYwoJhs5hXw?=
 =?us-ascii?Q?cCWg6a81d8OIWGovOVqSPX0U99c9jgczstiApL6wHXafimwZNX3UR7VUWqkx?=
 =?us-ascii?Q?95dMeS/v9i/e2hHGZYyIGasJKW5iX0PwVWYvsmCaoAcKoDgm/5dc5+dT7vvX?=
 =?us-ascii?Q?eTSXwYaTEIz5ykLRISGdK39NZ+xG+4IgjbE/kMQw/GO6k8BhdjCct6orkcc9?=
 =?us-ascii?Q?O134iKUuzjmPst3bY5Xdf6P/MvPIrOwrJ6i7YhI2cr1NdfFgYO9RetfrH0nE?=
 =?us-ascii?Q?H7QZUd1D3Tfflp/LbfhIlSr9v2urmh/OTuqACUeSWdb09q14xbrV0fYOlpdu?=
 =?us-ascii?Q?Ev+Nk+VHiSGF9tfyBYluj/xrAVnRT6yCqGpT23wTQ+Aw/j5gOvuqQoH3orNH?=
 =?us-ascii?Q?y+wqsAcxf19yHx5TUH9Q5wpL14I9LwG5MFg+I6nNvi1Dfr2EobMnTj9gKf+2?=
 =?us-ascii?Q?LVHE4wt8csG8MFu1pm72SsUPnSupUo0PSkmO4OoCFKivvFwX8avsb2QWXoU+?=
 =?us-ascii?Q?aq3amdgJ5NlPsScHvbzOel2TcrSn7u15fh8vSHU6dE/UbXFDyg7WaUu9IrCW?=
 =?us-ascii?Q?fUSgDVv3t4UbXN77Qf7wybh1KErBGQiNYKxD5sIEZqPlMLZGZ8J477x37YTl?=
 =?us-ascii?Q?KM15C2qfjMK017KzcUHizHLQegTCGy/xvPD7/9DesZeE1iF1Tzg8PTgJp2Lp?=
 =?us-ascii?Q?sZ7Aq64I8qmfezVH5Gth+4XyN3PEV6ntGv8D2J4CaWZhl4WZA4vz6aU0r2bA?=
 =?us-ascii?Q?2N7NgIfSoRrzQhREJ8BOAaXO7aDZaEGp6RLAfj04JH8OS1aQNT+U6VLBR7z/?=
 =?us-ascii?Q?vdD7Iq58OiBae7PERj+tmJUp65ALwC+WOUKFIIq7bzlmwp5mwGjfuZ8Zlxrp?=
 =?us-ascii?Q?IszWGRDf9Qcj+QGZ+xYd4lp/cMk/CQ8TWcuvzcdmHxjiquCyfTOVSCqYJSQP?=
 =?us-ascii?Q?mBamnxeg9zJKJ6Bv22vXITzBXQB51mNgiEtZYVtjMs8moqFjxlDuJTaCYF61?=
 =?us-ascii?Q?SJhKO7jeDxbvzJBHz2DYgtMRoA/C+BUqVUd2iMQ9epnrSrXbgKiHm/EHCxPS?=
 =?us-ascii?Q?TqQqc+eYKQNnDf/G4hQHDQ69pVzHYvHi/lbNKt4nrsYZzq2XzKaMwC8pLEl4?=
 =?us-ascii?Q?vNlkAfH+uuTlSqEUs3ty3o75iODwaq7qB3zh9+uTEXV7YbE3QnAXBQQIC6VD?=
 =?us-ascii?Q?97anDpYP0I6/IguSitW8nXvgoUDhhzdc6ovUwQQcMz25M5mLcQKTndKmuJYq?=
 =?us-ascii?Q?q0nBGnDYtWpWd5bHioOd/QGHVMgRzgrCNL1bkvXjM+guIuJZ7reONM6WnZOC?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e12af2-ef51-48ed-3da9-08dc8f8217b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 10:33:28.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 660ydWLEIm0Zl82nEKfmJgsTqHbJee7muYUcTUaZmziiCBzUbYbAeNxMbcaIM2LFQfxfwTAV1n12o26dzHAR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8723

This fixes the following Smatch static checker warning:

net/bluetooth/iso.c:1364 iso_sock_recvmsg()
error: we previously assumed 'pi->conn->hcon' could be null (line 1359)

net/bluetooth/iso.c
1347 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
1348                             size_t len, int flags)
1349 {
1350         struct sock *sk = sock->sk;
1351         struct iso_pinfo *pi = iso_pi(sk);
1352
1353         BT_DBG("sk %p", sk);
1354
1355         if (test_and_clear_bit(BT_SK_DEFER_SETUP,
                                      &bt_sk(sk)->flags)) {
1356                 lock_sock(sk);
1357                 switch (sk->sk_state) {
1358                 case BT_CONNECT2:
1359                         if (pi->conn->hcon &&
                                     ^^^^^^^^^^^^^^ If ->hcon is NULL

1360                             test_bit(HCI_CONN_PA_SYNC,
                                         &pi->conn->hcon->flags)) {
1361                                 iso_conn_big_sync(sk);
1362                                 sk->sk_state = BT_LISTEN;
1363                         } else {
--> 1364                         iso_conn_defer_accept(pi->conn->hcon);
                                                       ^^^^^^^^^^^^^^
                                                       then we're toast

1365                                 sk->sk_state = BT_CONFIG;
1366                         }
1367                         release_sock(sk);
1368                         return 0;
1369                 case BT_CONNECTED:
1370                         if (test_bit(BT_SK_PA_SYNC,

Iulia Tanasescu (1):
  Bluetooth: ISO: Check socket flag instead of hcon

 net/bluetooth/iso.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


base-commit: e3203b17771757fdcd259d6378673f1590e36694
-- 
2.39.2

