Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2933BBD0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514942; cv=fail; b=foY9XEWVTx48vRczgvZb6LW/yjiWA8S/zEAh12WqtfnjoCgcB6uzZh5WDiUxSdHxveYr1gvvZXULYQZ+/k8cyNs2DScQ7U44d/UACIxVxDKlWicxILHhoN9OBt/wqoe4ngHNvVkwkF82HyEfSxuuhKlnvApMdjag4fKRu1dfsgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514942; c=relaxed/simple;
	bh=/BlKyd5xfpmcZ47yqXMCKxNwc8ISde8O0WwwXW9a77s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPBGnYYG/ntd0FTGAz1Woc/3LyYookwfrMCxK9IIaw+xKfpWw2Sfml4zVcy+Cz+FEI0fySjLhdYFdzfH/XDZ5cNtFFAArJBWnCLjY59fT8j1lt29D4FKODuz5EnkJjX/I5UKji5Egt1dr+aLzXZhb7zXGBHjhd0i3GEoUrh54N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kY7dMa8z; arc=fail smtp.client-ip=40.107.14.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kY7dMa8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtLgjxn7Fv2FooivcHyXgPMslRAuAUSG7V8TooqaBCvFCOsJ7zNNzba+xMK3Ce3kM0u8qZvjySFJ+t8J0my+TXPt0vOikkA28H2UPChMSPbBwbJiUwZMnNyfJC86bOK17n+Vy1CgRVn53eubqKWUcf3A9oCbyF7/fvFahZwxVWvSLTqzEIhzeuvCchPRe71RtqlIjt/QnDfpB4EFNbhVkszsf6HHQCnCvEpNO9+6pz643njwZ1+i+LOX8LhNA0RWURJxbyn4cvXyuOI6d4OY6koNjbUNnQA5U2ZheR6XN35PrFTORdj6MtvkqdW4pfdqdX6+pO8VYlZ9hnNbV6XrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A03KZW8Z6+p+NIZ5EB5mp6EQbCg8ciAyJgOvEbJuPag=;
 b=cQgWM5E/HpLjpv6V0uQqaxND6g/Wg9w9RxXP7gBrWOwo/Vq7BnNmqar10UDp7pYCsnEK+dR2l5b+rsCcZndiXuPHQ2gQA+/CQw9vVkAl6y5h7d/5MGR7EVjtJDpzWWiQgmMaHPPVbWLNhBWT9mzflITtntBPqOK+E0nlsMHeu9RK0Uy51M5zN0ocupPrTDa/cAu/KcdtJ0lKDIF8n356qNcf3tO3P3j9jz/lOP/RusOXi3/DNH9z0CQKSaHiaZgRHZSt3nR46JlfKEcJcF5YGpQA94IgmhwZP0yWaskaBUfg8N2ABVscuvAkdGXa2Y0CKOlu2aylHLejhGw22UWYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A03KZW8Z6+p+NIZ5EB5mp6EQbCg8ciAyJgOvEbJuPag=;
 b=kY7dMa8zfC9waEqM44C6OYfpEx65NH/3c8o4+Cveok+Qo4uZRBFIg+ZKH0GSR1aAqxVLZo9LoPqszYeR9kSmV0pVwKcEhIvKssPJTVX/o/j8bbVV5NWxlDCgMX47Wc9xP5j/f7H7VbX9fSvVV+DqlGWJBKjlRs/tQxKd/n2rG7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:15 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:15 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 4/5] player.c: Remove bt_shell_noninteractive_quit on commands
Date: Fri, 15 Mar 2024 17:01:57 +0200
Message-Id: <20240315150158.79715-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 833c3ae9-bde0-40c2-9c59-08dc4500e6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9jlKTPUEMfsVE347ZvrnWMCwxJPh4aXdLG7VwLonK17Gj4rsjYZY2rh7O6Z9ywNbv+OdFqHUABpXwuPE7zaNPufT1tTRWhoGLBCfEJgUlRUpMG7ArpeTol5niut7fXp2bmaMHUb1N2EhW+bxRUGR0mODhhFihCk/S1nRWNuTQrp6v7P4cdHPBZNWZ2rWJkLT39iaRHvpOgHDGxEDnH/ykBi8aQeVSp83J15bu20Ou1hyoGukEuIIZo4/LLJjbd/a1OBZX628MwrKhlMJJKllJ5sc2rayFQ84j9i5HM+kU/dJQXcV0lNsd420MVSliwyGolTfxQcXDuVP2bar3ZaSDThQUGahBBxr7RztUQPmJuUsjg2ubSb+CrxR4S8XokHM9sjRklAQTmB2y2wm/XFYlUWty1AdNFZZQ9Y2Ji7MhvBfUtXoTfS6H0sEH5m1A5J10CqKiFHuD35fALshxYAJDATJiQkcpDtdevJdkMdSLHII0oGrRLfIJMyayrraN0Nvk9QQQrg1tSAp02Jt/Ky08Pk109/Y/8lY7VMythsSgO207mWYxo21BQ3ayr5NLk7N2m1aypTtjjIge4hrOR78/qWiDGSeQf74UcABqz/ot03CxtEI1lfrCLrF9G32mTJkqqvtSxYOKVVTmWlhcIAGkg3N/yLWOWHMBi7q7eh3Ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJ0eN7Rl0Rm/ubsgCffzvAezn7VnAvBV0+mc3j7lltelpSu5co+Cqh3j56Hz?=
 =?us-ascii?Q?Mgl8b734aOfMe7usWHa8slzyS7Po9uXDlhWxm3o5iKv1n61g4qNMcpAIKd6o?=
 =?us-ascii?Q?FBuV/7aqQEJHLP6gt59lN76F2DETcRbooqV/MK5SumJ1g4sSRdF8WYVjUp4k?=
 =?us-ascii?Q?MnzE78R2gdlor//pI9hHYrwYWlolJcaOgwe8rQIaYz0R2FW+yNrEjk8KZtiK?=
 =?us-ascii?Q?ZnuP9ZWk6jSPKbNWnuup+6d5XRIcnM868Ke+XqzJe4SZXHzgtfkj4FZMISVL?=
 =?us-ascii?Q?hn/DzHuCpTFRsThuryfOK944U0FWM7lEu4oNOL64oV1JzOPlTWelgWffvRKV?=
 =?us-ascii?Q?7lUkYD+zzgySa/LwobA6Qq5uFhE6Stx4mB3VXQH5g7K25vvPFnTHMqE0RXJt?=
 =?us-ascii?Q?sdj9BDtOny8861PqGu7Uo7N4aCOuGLRLLS5+z/TwQbeWX+5elnEVUMIak4tT?=
 =?us-ascii?Q?JLZhys+hMzOVgkr9hCjtOJBKV6wIKZYI7ozwLuqF0G9yKdFm4MvCw5uZFNcw?=
 =?us-ascii?Q?Lj/2djYT7xxtLAe/2xe2Fgfuu4VGmxFldxg/pY8V3ZoYQsZo4BdbTOPyhXAY?=
 =?us-ascii?Q?RX0f+6Wo/ax32rEbClh+CRxMDIkYcRhZRGalIzDUPAHT3jNoMdGVVPkZXOTX?=
 =?us-ascii?Q?YtCuboB2+O3jZSa+TBQ8h0VOOLNk+2fwrnVjY1AVJoAyzapAiof3lTxBwZ/V?=
 =?us-ascii?Q?99aiQbtpxYGhnASLWOl3DLY0C+4O8bhVuw6ud6KtUb3QNthWZldc6Vy5kf3z?=
 =?us-ascii?Q?U6ecOJb2THKn5uJQT7YH6aYCy/6w+Kcvftt4d5l8hJwFql8AgIRmr43PGy5G?=
 =?us-ascii?Q?fXQXUGVzBn1vYsiyAnrepvb6k8gZYeNQVri6t8C5TxFW//OzRlvZiC1hL2Us?=
 =?us-ascii?Q?ss+Ri+gUDWu6TGoZlboGOoyzMUSg9tY7UIQLtk0FwgxAa6t02cyvUppdCJ+W?=
 =?us-ascii?Q?XCuMoNVBeWIz2f1Z5Jh0VCP4Y2nm/BonRK+zLTXt5efo1tjB4hlEN7wWasW8?=
 =?us-ascii?Q?GrC+IbEQx3RhBXXHbPLZkx+QyPkooeVebWB7vZ6M9K3z86UHKKwho6lcfPsN?=
 =?us-ascii?Q?MiJAlXCm1pWyZ8TvdFFFSB195NqunJSPS3lJ5LeMtMjABuEFNtaDQcjpNDAC?=
 =?us-ascii?Q?BokuQvSrCGFn3oxfMrLGywNLIUMjSfes0RqvwfdvuyRDQX+purgp89oHpjb6?=
 =?us-ascii?Q?ANgk6PSyA+kbTJLUNNeT7jyMhr3A5bKvdF9ZFSNjxRL6ehXzg81hfXIWqapP?=
 =?us-ascii?Q?7WXNeUAoN9CTRpjuAWTj6mqUVE8WXj0jYi28tRu7w3XP1VQ7FIYRdfiltuxn?=
 =?us-ascii?Q?dm4vkjpPxJNvXMrmuu1Ke5ngUfd7g0zMWTel9513lD/98nCFLvihkZnrsAiY?=
 =?us-ascii?Q?NZU6xNXiVJYJrY360qPfrZjHZza1wBz8lxCEaF0//fhPCzpF5vby+zNv6WTP?=
 =?us-ascii?Q?/1f3CqQ/WlDxXZ+mc6XY+qHuCQVDFGHEV7qTCehBJCHLVpc6IzkTdm/dAkxo?=
 =?us-ascii?Q?mvyQLU1el8YQZPHUz/ZiLwHiE3i+SWDI2NOcwHDZcl5euChhxSCxBCO6yXrc?=
 =?us-ascii?Q?NWW1hO2TCcCA11Ttr+f3Cw3U6i+BZMUFHMbjrvY1Vvf7TU4YkeOxXIEDqwpg?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833c3ae9-bde0-40c2-9c59-08dc4500e6e8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:15.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JktV8pAq9vF8iEc5Xeld2QgUemNrQz6CW1FB1CkMpXtMWbEtvxBBtLDIaqn96AYlFPZlzM8NuBOQc6y4BPRZHpuVnFDgrdV62Pjo26YEfrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

cmd_acquire_transport and cmd_release_transport should not call
bt_shell_noninteractive_quit, this will be called on acquire_reply
respectively release_reply.
Only on replay the acquire\release process is finished

---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index c754af33d..f3f8c15eb 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4895,7 +4895,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 		transport_acquire(proxy, false);
 	}
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	return;
 }
 
 static void release_reply(DBusMessage *message, void *user_data)
@@ -4947,7 +4947,7 @@ static void cmd_release_transport(int argc, char *argv[])
 		}
 	}
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	return;
 }
 
 static int open_file(const char *filename, int flags)
-- 
2.39.2

