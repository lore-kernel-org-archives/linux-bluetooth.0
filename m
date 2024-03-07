Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3112D753
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819930; cv=fail; b=aIrLMHI1v2gd63t8w1zi7chiz0+HDapZSloJNcLYvHe8eDjZ9eOjNI4cgJd4eHumDOwY78YHKl96bu325YqqXsc/H6NN5Qr3dzTF3ZWQjQwyVBLtTSPtpGgOyehjEc33MWR+Dnw2Jki/0NBPuvZa76dn3HUNXuuLNmJQ+9Gy2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819930; c=relaxed/simple;
	bh=l3toDbqNW2xamIbZoj3+YPaIimhqeZKUU+emtR0vZqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUH7SDaCLtcacVjaMs77ky7Y3PgXWp4QHVHYxGnAWqc7S6zjAo5Bb7EC6lQ16FoiesWVv3vw0nmNAWeQx8nYih1MtF9ICXT3AOv8FDqMHXn7jkpNfvzAb7UJ/7uK1t5CYPqbnD9WMTG0KvGtB8byUt+JhPcz8pEp3JUe/23mH3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YeUgyPp4; arc=fail smtp.client-ip=40.107.15.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YeUgyPp4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6ua0K/GYXCUm/Eh3foltSp9e57FSJQraHwwGk9uzFEVsMdveO480eO7yefqAztaq/v6Y9X8KXWQIu87a/w+mGYFL35kFq6iHLwsli9b+KRYnrTXRriDqye5h7ikl6L8fXDeenJRqZ/pz8ADG7PTNwz4TmoFGSreef0o8OaSfnzQhi4WVkZLw1PxvpYYFAUkHoIhQFi3k9HH2FTxaaRM9Wf8q1khhVkqChGOtWqnUKKvvELYUDjNQ5lUwpw8aAHGhh1SMPk9wiASa3hUpeIgIVQKskEUsdeNKQhAt5wCSP58hSyZO1wJNKjkKGG0aylKxfGwwVwxlCDBbY9lEGGl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTLlvV3lDAfHLtQMNVrPDzNZKrtubuWYnZIqo/ddJeQ=;
 b=hh7MF5LTN+H3Nvntfddo1yJgHzSzBnpQnFqLDb5wtEw4GFSIUB+BVF/AjgWxznxbsFjpf/Tss1pCwBNbmwFNTUq5dpkdd5dDQC8RjqNxpaixilalJh7+TajLIfUwC8EnbF8QbOy2lQQrIx6N+oMbMHM5Xet9gC0vPj3xfiANTxZXM82AOp35+zTTWGSBLV3aAHRwLomwY1H3U3TeH2d7XZ6M1kOV8+bHg9uuZecm0fwQUZ94d7jpMkgrRoyr+RX8Im6wUKISwt40x0BHyIsQxIBO6+8fkSUJ4F5aQL10XLvc8lh+CCRo1RcKm/U0PMq4vEAkWXP5WJrmrlwY3yDVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTLlvV3lDAfHLtQMNVrPDzNZKrtubuWYnZIqo/ddJeQ=;
 b=YeUgyPp41svztuUC/pPPO1P+8HjV99xCSlZ0aoly890y53ZiLPHP5c/9QZGeTtheeS7Sp8haut5gOW3sf6CynxJOtbE22imhLprHAlHoB3FqInAr78sPnR8t0MSxC8Ihn+uFL6uSLaHFGdmvZfqYbGQ3PO6S7UIL5YA0q6mRewI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:58:46 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 13:58:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/2] Bluetooth: ISO: Fix circular locking dependency warning
Date: Thu,  7 Mar 2024 15:58:33 +0200
Message-Id: <20240307135834.3941-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307135834.3941-1-iulia.tanasescu@nxp.com>
References: <20240307135834.3941-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:803:118::16) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: f46b422d-58a6-43af-2873-08dc3eaeb4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VWy3eksVtQh3DF/2p08Ba6u1DxYOkhCGgOEAMIwvrTg0TDKzlLdkCWaqfyY9p0uBgt1/26HEqROyggCErj7uvvDoHCBtcGS1raQCaBYz1MDq95NZZaTIRgRJma0Xyk4VwKyjHPdaLruWrmoeNh89rBa1TeIwJPBQRKqAnRA0SHmBSDtjYyggCV78tLxdBCozIfO2R56MiHvz5RTcrA0Og8bLMZzDkeZu+BPxzaGzfYXocbSOcwD/bpfTbrLYYaaT/iob/y+zTXUr2TcJBjiEmljC40TrGBbHVKS5xG15LUMTV02BuYTcilVGaZ1jpnGLrJUa2lRnlOjb3QLMmH46blUtwTgVStAGb3r2v1sS7lyLcNtUDY8F/eAR4Z2GKBftcyOyMuQ0vHRKZFVg+/wanhCll0VXRmW/Q9lkos88wvtHBapUyuUDZVpEt/DkRohnj405t91sVOL2DcH+LYcpmn3DCASFLS5BzUCOybaqJsAArl4CFDfreIriJ6AQiCe1Zm0J1M5q8gpqqKQVoee9o9bbqdOGKPsFJe+TTW8wU9XUBANk+q/+R5DYvSnH7yqAMfqwqByAHKU+6G2k2aBVhuEBrgA00dCX7tj0c3e3d7SEfaD5xK5t0bWrMbUr+xALwszkEOD2tXd+/+Apa7+mE6toiwMKcrvRac40+VQ9Q5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S22DAvdmnvVGkrr9HJsoMTBBHU+KF3kzESVW6hDNqs6q74wOnXjqOPuyV5nq?=
 =?us-ascii?Q?YglfVg3EnRw182Qcr9qfQ1SZv+EyLKhqe9tQTW9O6TC/aNqKyV1z5UI+h3Z4?=
 =?us-ascii?Q?Lg6C5ZD3MIUHQyXZJtm4aVBXp0U6ulcQyLuNtwoi2yWodlnR4Lo7RTYxFplS?=
 =?us-ascii?Q?9udLEFnMxY7oHmjc5ZuJ9++yGozwk5+k0KZCYVc2LT9E5eO5mXDE/h9qt/mc?=
 =?us-ascii?Q?WqDCTTA8GOzuEcpWlQ2LnMzUf566bhHuy191vnGHH9gJdV6BXFCfb6Y7rEvN?=
 =?us-ascii?Q?l+vu+j8hYEDaup4YNPuci+zXgppV+dnl2E3MFsSyLvtlPWonal//B/dUNve9?=
 =?us-ascii?Q?ZnbE1wRbjDlNljnGG4Cl+K3xEkwIYtP9EJEAJIiI7arWkabq88QxkA9jQL1F?=
 =?us-ascii?Q?N8VrL1rGQbtBnbn2KjIMcbFLWJwmdUejvwUFqw92LezxlpL3FynXO+tGe2yA?=
 =?us-ascii?Q?YE3SHtCpxo/oAlN+pEQpDKY9w5zobG6v6LN3iOauoQJeBMVpHXCyS5wTGYAK?=
 =?us-ascii?Q?H4DtIp/inooMjSIKUmCwx+frGRcqX8NycRNS8e7tFo1Y+9WrN8Ok0EV0GBnT?=
 =?us-ascii?Q?jd6Z0I0XcxhE0/H623gHO+4Q73ZMf6Z7ijx5tWIWsUER0g2+2pMybmqvBlrr?=
 =?us-ascii?Q?ZWUbNr2Ma3tRsWWK4/9vAjWPuLKrPe6JFqjaFdR9BEpL02Z/4Y1iOFhH9C8T?=
 =?us-ascii?Q?59WPAdraZhYm2uOYE2Ygttpen9aIG1REw46u8BhkLC2boRou1Zqw4ZvZG0mO?=
 =?us-ascii?Q?UoH6nbcJE4TyWh7kScYYPsaWUGTdDWrb+oNAMnYMqihjGttRm9lbY+jEYQSF?=
 =?us-ascii?Q?32llIJ7g5lcpmgWq3BtcQT87Ph+z9PXONJE1i2C63DyAilu8MWnpE65dUPGx?=
 =?us-ascii?Q?lWQsrfIj7d5WtfxqI90FVA/7/JPK6+zhUDVdODBaGxs33xggRPvl2p4z9oYF?=
 =?us-ascii?Q?RLObucfRt2Bo+ap7TPoczGZvNEaANYA2hG9IyDQbmP1IFA8MnJf1AI01nEh6?=
 =?us-ascii?Q?8OQ1NOKbRRr34Ad91AFwID84dKV+BwBbUkhOOoWYRAy0mNqjd3FpC1L1G10y?=
 =?us-ascii?Q?0ALHOKMl5TS6iiTjo53Si1VSunQ0oJp9qXv5h7VBpE6XOe4KM9kuUrxXTJjV?=
 =?us-ascii?Q?LHrK+wiq9z+o7xv0RhuBbf4bkKjxd39dGj4dvciNfmh8IOEwY62vWFhwMqJK?=
 =?us-ascii?Q?osmZyp3rsELXy/f1Bvh8prXvzJwl4fv9ujyMOHfKqZGc5ZXqWDjkSYwKAmNV?=
 =?us-ascii?Q?mw8Tu8lEb/tYRnGuv7aDhYtRg3hOBGOURQ4P0DMrXCKZCsUguRYOK+Vi8Odq?=
 =?us-ascii?Q?TFBB32DiwTezKYN/d98uGUbvHeT/jAjVSQzvWe1RXtFoBPVfNebjfzYIms20?=
 =?us-ascii?Q?hCfO461miuYqw6UFkK+Qve6me0P8AobBUJj0JpA1mBeGlxprhyK7h6eKL/DR?=
 =?us-ascii?Q?6hBa85GTXcCoS6EsBc2LV8z6sy/IGzTEm20s0J6+WIaVZGTXRwzQMRLMVW8G?=
 =?us-ascii?Q?gW4xlofCbbUssukogRvo+v00tD4q7SZiBgPFh4H0DKlHU6NAmeNl6tmTAL9J?=
 =?us-ascii?Q?DGVV3jtsH8aYt2qL9VuluMhVPsu4n5cuoXNkuhhO9nXMSvlyTupDBCqIy9GN?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46b422d-58a6-43af-2873-08dc3eaeb4e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:58:46.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhjukVzflwDaummlBskzEPOJW0dWhwikFFC61P6X7n/HBUauNL9Ud1Z4WoBzqJskjqnNXEXchyvSl5ggxmceyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424

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
 net/bluetooth/iso.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8af75d37b14c..d1608387fd85 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1069,6 +1069,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
 	return err;
 }
 
+/* This function requires the caller to hold sk lock */
 static int iso_listen_bis(struct sock *sk)
 {
 	struct hci_dev *hdev;
@@ -1095,7 +1096,15 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
+	/* Prevent sk from being freed whilst unlocked */
+	sock_hold(sk);
+
+	/* To avoid circular locking dependencies,
+	 * hdev should be locked first before sk.
+	 */
+	release_sock(sk);
 	hci_dev_lock(hdev);
+	lock_sock(sk);
 
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
@@ -1128,7 +1137,13 @@ static int iso_listen_bis(struct sock *sk)
 	hci_dev_put(hdev);
 
 unlock:
+	/* Unlock order should be in reverse from lock order. */
+	release_sock(sk);
 	hci_dev_unlock(hdev);
+	lock_sock(sk);
+
+	sock_put(sk);
+
 	return err;
 }
 
-- 
2.39.2

