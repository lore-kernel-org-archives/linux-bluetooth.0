Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012069.outbound.protection.outlook.com [52.103.33.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D722D9EEF
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775038; cv=fail; b=B/aLDGzB74nR+hVhB9jeujCF+x/YPNqGdNo80LyLawgNEa9XSekHLIymH81cJTbzV8D+i5N12P7pccF2sTtw8sPO3qgPrQ3XDKh68MblFcucHZ0XK73SXupfWluwd50PsDdpCvzV6qOY3bysv4bGnhtqn1z/yH2sG59zVyxtbuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775038; c=relaxed/simple;
	bh=tqP6m9SrGKjHsNU4LYA5DJH10vol2Q7DMv+RC6I7u7w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A3C4LflqemmJo02trOiDLkcLN6m+cn8b9b/jqLJCMMuGfI9ExUZe4p9CvdBwa70Ytfetru6UOtwahl+/UJ/lEEFfPBwjNXXHiESHMqWEpmv0aqDaKWclsU+Zpc62ZflgslfCz27EzoSgbIF2tMn3WpDGHyELjXc2l/2rIpYzXpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com; spf=pass smtp.mailfrom=msn.com; dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b=KHdKQAhr; arc=fail smtp.client-ip=52.103.33.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="KHdKQAhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARN8KvnC8BuU0uGnxS6Yc1dWCY6k161xIsRo+uSEGLS0M4XguCt0CGcQqjvGCKml9at6YJRSyqhVmwdismrCHpYy898BxvI7i98L1srPAHd84FS6glSU0sxx7qaTlcE/OiEYhwlvdJ6MXV2cXUKpmhCDZdMSdOPlbNJ0IRHsxyzq6FQlyiuUMxd2vxYZfgMFqfvZwKvsPc+x4h5w8ZBMwrG7CAxBdaHICwyFq9Co76cegenCv3yx6qQZLe1/cJDKT9SNXHCHXfsgoOSSagMzbiUpAhsWFk9Qb5lzgYJh2uYPQczwTbyPH+x03y97drw0sEHoa/eFKPZa7mysbvnhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yWkL7psoEKyGKEOVhiciSakIILShHke+ctUSuCG3rE=;
 b=FfMffjRPeg+X4MixqytYO/HeDEu/5S0A4wc6t7TD3oOhPWhCMZ5x9bcCXYoMjzBCbf3efsw20CNXVoXc4jeTBmKJ5cQFR/CSi05KoUPMq3wneiTyIWcLTAMXvztY/211op5Ops+/q9xs7ejylHfF55/Qi38x2u1Ch4lLMDlz/EvqwJRHzGTOkPAZcQDLoLAfXecfi8pSpZ1fviNdlOnB6DZ372L8QojurFYySEaRZuEknSYdwHYj0LXDFROv6LuMsCU2gMPealA9jmL5rJ97JbeKjktd6hmoGaj4NW4odgsjMRgS5nOsJSJfHZ3X6ffUZxjePCN9+COdXxj4pcyRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yWkL7psoEKyGKEOVhiciSakIILShHke+ctUSuCG3rE=;
 b=KHdKQAhrBLbKtWsKHvtcooc9YwM0vAfuvRjm3IPIWtYS5nBQs2PAKRkFnZYW8Ke678s4tkWEj27yDGQefsRxnYWM2GVDTrt5/umEFFpqUS4TOVXO7kh8cghv+ZbfWtxalNV7rhGxnQYs31LCkEBI7xrkhZ08XDN32npIo2mTQxTxL7je7VDMXZWMlk4b5TPuj+mQe+f5gZHTemR0N8MH/SHUQwReDPv+O+KL0ct7D4pmvWCyBy4ymNXdYTqm15ft/wINSi00g2GY8f+/dUWsV8anx0Cxrjd+SWISfXjOKskOGzmQOJ3tVn0hJuErfFuP9S8WZ9o/wZYqGmBqplS8cw==
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com (2603:10a6:10:cf::16)
 by AM7PR05MB6791.eurprd05.prod.outlook.com (2603:10a6:20b:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:23:54 +0000
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::448d:14c8:4ce1:5b58]) by DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::448d:14c8:4ce1:5b58%5]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 14:23:54 +0000
From: Pete Beardmore <pete.beardmore@msn.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pete Beardmore <pete.beardmore@msn.com>
Subject: [PATCH BlueZ 0/1] Fix failure to register bt transport
Date: Tue, 24 Jun 2025 15:23:43 +0100
Message-ID:
 <DBBPR05MB62836AA5E235A13B44F962C88A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To DBBPR05MB6283.eurprd05.prod.outlook.com
 (2603:10a6:10:cf::16)
X-Microsoft-Original-Message-ID:
 <20250624142344.626518-1-pete.beardmore@msn.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR05MB6283:EE_|AM7PR05MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 9512384f-ed76-4f3e-7e86-08ddb32abf86
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799009|7092599006|5072599009|15080799009|19110799006|12121999007|40105399003|52005399003|440099028|10035399007|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0vdCH+Iht48TPbfYPq2nKfR7mrQZpeaqiVi9U3f0AtPaNQK7qHKnSNcnn2G?=
 =?us-ascii?Q?XvXjJ43rURSnHedffGXAW58nPVuV9qhBvcCtOkxk9R5gnJMes/8WJk+3L81/?=
 =?us-ascii?Q?8/U0TvKKwj9efqQ4LAqy7hjU96U6uXeFjrE6TvRJzmXBy0LPvMsm41x/PsCG?=
 =?us-ascii?Q?swMSjcO5X+msTeL7Ijn8M5fnGkazR29yKwjzTx66RfyDYRfxwtZq+RxYVQRB?=
 =?us-ascii?Q?VfteLthksHoGPnsr/L73c4+8inYqgNz+az9+j+bPJPLTHh1JjfEpGSHZ2sNn?=
 =?us-ascii?Q?ECLy4J/LAgmI07mEVDsCA4QLbs2DE09BhkvLFeIEcBXvDYScnV5VMKaG08oJ?=
 =?us-ascii?Q?9UmelIQIbARC+xcPZd8sAmTRWFHHPwVWyMH+GxZ58gLrnEauAKrGsbG/4gyv?=
 =?us-ascii?Q?IiY9iMbKhYSfnbdilTVZBQTyAvNUuAEAzONjFQ+IaJ47XbqYN4LUJ3Rrjm7h?=
 =?us-ascii?Q?4Xk0yutDsFHpRuET7OGuqK+0242Ce1PDSD3Acl/rXjX5Pjt4jg20hr/p41cc?=
 =?us-ascii?Q?2wdQaTmFroRlFaMPUemZ5chyHdLhwNJB5UdNKsWM8LRd93JxOl3CG0euo96G?=
 =?us-ascii?Q?f7HmtIk91c3QoKCZjSl4sRUlsQ6ScNgGCp1q/z3baOD5HzAIsvkHawbUGjDO?=
 =?us-ascii?Q?SmNhchWwtbdn4rGFaFV2vmdW6nNTpWklobQWNSPe1g0awYuWRvq08F4S8XBj?=
 =?us-ascii?Q?uyJu7cXz/4M68/M98hPiWpwPtDFD5fpilTqvaNfAZ0dy49NTjqNTQbjWzOOa?=
 =?us-ascii?Q?2bQoPZeeDPU1ZTGVl9uhPGC7ruc2zqLCPh4VTPCC4FVXCRXdMf/EniGOvhMT?=
 =?us-ascii?Q?AO/WXBSWB+Hi+CEWLZbdOZqULOXM6p8gg1BNm/pKLzsqDTWJoObn5hjqR8pV?=
 =?us-ascii?Q?gFf9z9Pz6vH7kvmwbVpI/GmUgkWFeqZcAycKCfDZrsDKBPezWK2s9raSk7IQ?=
 =?us-ascii?Q?RmAtTQCAA/YwxsoDt3ENmsllnRerF0YZg0vNRnlRQPIfBQ7LqAJvwi9UYIWd?=
 =?us-ascii?Q?4McqqKj47T5GXihdI3KAA5UrSTcM/6vSJiXHhoWXCh1vbEEHNS/4+Uxfb11k?=
 =?us-ascii?Q?uZNNEIXlCXlzbZiNKbhqi85uD2OOGURhxdYaMzJ+aEIRYmqQPGr0M3YY4mi7?=
 =?us-ascii?Q?DfVsIKY1aBrbmped6WY3g/Ns7XN0JVsKOP3IdKcmwP+AA4+xNjFv1JsMo5iR?=
 =?us-ascii?Q?lFTLWt4kHprp+WDVeXGjnipbVKeD2qrfDYZCSHhMvHd98Wn4X2tDwY7lKyyU?=
 =?us-ascii?Q?8xSJCIc/rlq04HCXbld4vJ/8B8gcKnMpSfKXXt9hrKqQS9X0fxR+ZyDXagkP?=
 =?us-ascii?Q?1lEbQ1wj+c/oPIANWc4RQbecjNddixsLfZhPgP3v7kHq7g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zSAxg7OgBZa31gSpbctmwfGRIdK/h0a7FaPqoL87W5rVgcumt/fpjLFocVE?=
 =?us-ascii?Q?SKD1008EEmMgQx5v+8mYigdrTVhM8kbv4WloTVg3+yb5QtZ42w7iZ2bnHwsd?=
 =?us-ascii?Q?yaQa0blgFOu3FKxf7mvPidK6civkODXFePlBXEHjN7R32AIugya5Z5KpHd0B?=
 =?us-ascii?Q?lMmuF+CSMh7CWQ2sQg7T/03tPJGrwDXL80GmaORUNV22/g252pSi8FcBhMkZ?=
 =?us-ascii?Q?6oaz96VXo4chH6QwJMU7BuWpoYdF/WgU+FjcLimK6iOkYXt2f+I6D49cVo18?=
 =?us-ascii?Q?aHZOpVshMt5dVnHqj06ZQ3AwMx3NtNYNUGoFooWiMfsArpw/COjmsIoxuqmB?=
 =?us-ascii?Q?/s16v5CyxTFiHbXNNYTyWJeNf0uO46Uh9t3/3Yzr9eP0dvPw6mu+wRIm38iP?=
 =?us-ascii?Q?Q3cAXAYWUflUfQLTwWePWMzdpzod1t1qTOgM41U5QOFY+duM1pF2aH/znC92?=
 =?us-ascii?Q?fZQBBg98mddGmA1kAvjZ1WSXPq8YSrrXaSWYmZCkuoer9KR680ZgPBi3Lt+A?=
 =?us-ascii?Q?D0523Few7V/a/S0osHsz7Ypfi53JRLSkZzBM43IkIs4bc4ZB9ITPzoBX7ep9?=
 =?us-ascii?Q?rZB8gYn9ESM+mcDyHuimU7kPBperp3evd1oT86VSqrB3EHHxLh7wPjmmlO4S?=
 =?us-ascii?Q?Do8H0g5fUewl5FyefSpkCkHhKrdNHkxkiUBrFhYT2i7ZL5bu68ioOdaoA0OU?=
 =?us-ascii?Q?B0nX0ip/TypJs85jzh8t0zLeQVDqPdqUwifaTtVVxIfdjM8XCSRl2APYvRh/?=
 =?us-ascii?Q?Qlmdsc5GF3+RGkjAC3rFVy+9O4PgLi5YKT85BhgklI7/rGS5UC5W/RtBytOH?=
 =?us-ascii?Q?/Ct8pMuwtbZE07OlB3VZaQnee9Z2tpTRNR30PAne+AQ08p7RxH6Ft4bPS+hw?=
 =?us-ascii?Q?75RXsaM+Ebs7Yu7FubhGMaHEXPBq40FWpTF2x62ZHvhXzN+Tx6AXpDzjLaMS?=
 =?us-ascii?Q?Jo/Dtk1WtT2/Bl722Lh9UMs3dtHMYnxKcBViD2ckN+QxfY4g1SjtNDoMR5xr?=
 =?us-ascii?Q?kLo8RG2iV/zE/f/nvbudqQMp2rYyVEO9++vF+PKW1uacKyRAU8zBousu1idT?=
 =?us-ascii?Q?DQwrCuh63qY6gRIBCk4ox5yQGXQFcspQRIZwObMTXlgpUEsJM5hVy0BCdZf1?=
 =?us-ascii?Q?+CK9E5LHstxhz15Ax3AgPPgbPS1mb5qZYrjUpwVLe7QB0aqC4c38+6L9P+2M?=
 =?us-ascii?Q?GSph9MIeosKr12KYPJXqBr8wXk+z8BQCRyOlDGiCSmnDD5JGp3l6aY5WAyQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-64219.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9512384f-ed76-4f3e-7e86-08ddb32abf86
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB6283.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:23:54.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6791

Regurgitating the single commit message:

On initial logind update, the internal 'active' state is FALSE. Where
querying the current state (`sd_uid_get_state`) returns 'active' we do
NOT want to short-circuit the update to the internal state value and
ultimate transport initialisation.

---

I am guessing that this was a typo in the initial implementation
[obexd: Unregister profiles when the user is inactive](https://github.com/bluez/bluez/commit/765356e80262a20c359ec7722a5590232442d0d3)
which is where I landed having bisected for the error:
```
obexd[188706]: obexd/src/server.c:obex_server_init() No transport driver registered
obexd[188706]: obex_server_init failed
```
in my distro (ArchLinux)'s latest 5.83 version. I went from working bt
file transfer to not working post upgrade. Dropping back to 5.82
resolved the issue and I went from there.

I haven't seen any other complaints about this yet, which leads me to
speculate that IFF one upgrades, reboots (yuck!) and the systemd USER
SPACE obexd service is thus loaded prior to login, then the mechanism
that the implementation was aiming for (new seat detection) kicks in
and the internal active state is correctly set and the bt transport
initialised. This just didn't happen in my scenario.

Pete Beardmore (1):
  obexd: Fix failure to register bt transport

 obexd/src/logind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.50.0

