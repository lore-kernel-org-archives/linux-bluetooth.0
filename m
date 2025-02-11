Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012026.outbound.protection.outlook.com [52.101.71.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDA26BD81
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283585; cv=fail; b=cdNuX4CbqIlXxPUTwSIu2HnEZalvf7vL+JsgpD+5dPfwgqsCozi80GRYfJO2+kKAuQYNvHUfjUyUlI9dxjc7NEfEXOer3WFuECeKbXy/XYYM9Rf2O2bxpjHDPxsGcC7ol7nwZcde+oT27rF5DtGXc/wcrZREgCF+DxGW2RuDwmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283585; c=relaxed/simple;
	bh=ukNZ9AHVt78p8nA1Yn6+o7pUNAgKEU+SbYiLXG2HYu4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KnuaN11oNEyMay26br6dg6tcaQMmR/Dtker2op7mSqB06ikHgwOo0lFsAUGyBQH9ISjLb/mQBvIXeQEFTgrqWfzQ7cuTR1VK8WHB49cwoOs1XOGTwayb3bb4tDSsqZ0LmzzOQaGBbZHGd6qkaIivL/shLoNhbkjNoMKEfKYKNWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AJ8A/TCv; arc=fail smtp.client-ip=52.101.71.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJ8A/TCv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UChRhR0sFXNDUwQ3xvHv/SWjH95shncZRs/i16QcIYiAVe2AGenZ9DmunaxzWDAOIsDMCS29FhRls1aDj+68gBt+jh/tVGZp2bH39Dd0TVUBMIJElRR2ShhBu4RXEI/HgklOqm1MOmd/fQSVfFdHjCsjZ2u16+vKNSVItOKnZZ6aH99B/9dlwScnJkFTQb5ocME/XoRZJGkuo046UXIMmiFOdR/6lD2/ZRRl9aTAUmSzY246fuwRjwEaF2zdDBv5IHP+w9R8JkcmFatl3clJgIChOI0cNf/Q2LtpARTQOgekJKW5ftwYGnfbhF/nNxSKh0eqmeIU6eJlDWBY791XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/GlGl5gEDdUxvr5aS0vE13k5AUzH+E9l1tBX+TgO8Q=;
 b=bUVPdJ9aET6F1DkKq8j3QtJ2bcvqNiwwYV2NL0uuu5fossUdBpfMEnEfc3YQQ71RhqZHTmL60CE1xhPYx6DIYE/S66ErLasNtARAIRgMBXQRlN+BOVcxDmei0mIeP3Vtl+YfMhW2uOpaVsoTQGHnPElsMLQ9g+RzEaxsyymXFeyvX6CZCuoXV7EYkf/KTu9heWNB+50tRB4bKlcZfMpNxGXV3ttauj4OVmb52hJ93P4MehULn22Mplv71SKqQxcVysrVTKOy8g6GsD6sbOL9y8CDf5NZirKdlBI5DqDdYeOv59DT0YJESkzysEa7JnD2QRgyR6dEmJjr+BNzGMmaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/GlGl5gEDdUxvr5aS0vE13k5AUzH+E9l1tBX+TgO8Q=;
 b=AJ8A/TCvzoby/V3jO+CX7jhzSFvfhWOdMyMPgggIdsSZMvZipucF8qrm9ZZ8epRR3gL7erl6urYCdP0v2vhy1a0Gl2aTy4VfjRmd7nRxcYC9qZf/nZP6bvI+MbEvdjYiT0GYbEJsxvZxC9iHHzER4FnDd+S2Ncx3ObCC1UUmjKDdD9gYV9oIvOv6lfnamoGe1AdpENKcQnkUmtoNUJ72OFZo09ulgtwzE3A6MS921UGnrGG4yLdQDxRW2JqAB/ryOUS80/zwmcYf3XJy/reL8iSw9foE76mSBGNaud/GHjG22YSHcAkcgFQylajuC/LxW0JhvxGCmL4HrRyJIJ3/1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 14:19:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%2]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 14:19:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bass: Register bap attached/detached callbacks
Date: Tue, 11 Feb 2025 16:19:34 +0200
Message-ID: <20250211141936.23372-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e43936-30a3-432d-3948-08dd4aa71f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVnelu5k5QYckKzlbKg60Z6FDRh85VZaxdoejf0+8VpWvpX0U3hXlBzL80dD?=
 =?us-ascii?Q?jjJr/bITS4nv8mlV7FgRXKrA4Pe0H976c5ftROu3V+jxKbEiFBqR7bf4Yhy+?=
 =?us-ascii?Q?VjYiWYgV2IYDJyvzrFnrbJOGt/Bmdc64ZgM/bF9UI9nAumYZfCebXofclLqQ?=
 =?us-ascii?Q?Rw3/o3NL+TdeH1UtR0C23ywOSSpTI4RG5rtbyKLYzWUX3GZg2e7JLzWlesXs?=
 =?us-ascii?Q?WKVtdiFWikvsw8mzc9NAciTrOAtDyNyCDYJItGlgiOL28R0DNU8Y6Yk/VcYC?=
 =?us-ascii?Q?IttbKxUZkLu5vlvxg95tiKu53zCrekG2RLh58sCleyvtlnzlwjVYJRfx+JuX?=
 =?us-ascii?Q?+snbUK1JI+de2VT8n/Hs0WBgUe0KnYlWTnd9ovC59gMRtOGqdhkkQW2EjK8B?=
 =?us-ascii?Q?5NBRx+82OK97MX66N/HKw+x/hkOCs0v5hOKMxnCjjOcP2zW7JIcQ5n34ZMV3?=
 =?us-ascii?Q?C+CeoZZwxsYtPz8w3kP5lplF9fj+RvVHd6g7msvt96wsvj9ieqnB1QiZCloQ?=
 =?us-ascii?Q?tEyw47iJWZAht1io04Mmv7Xfla2Ve7FtbaCFIEG3aUNZR9Tjg3jsbRdvZ5ee?=
 =?us-ascii?Q?LBEkts31QIH/h/7eEBWmI1IvwhgaPKmDiA4TZy+8JSrzzNFABNHtqgGEHIHc?=
 =?us-ascii?Q?d3ZGxOxIWyvecsKcApH5Mi4QknPJP2yknEVUcIJIMHxvp3/X5yuUMTdjJmLM?=
 =?us-ascii?Q?5WltzeJXiTPrV8OkUkZkXDUCQfS3k8p51iMKjgIocJYJOht8SP7l5gFQy8cu?=
 =?us-ascii?Q?sNrUg/mw70gW0Hrd2iKoHq6MdIt39kd0xXU9avkPVrMdqdhTQX+e3N1T6VpI?=
 =?us-ascii?Q?qbVCWON1uzGr5KTRwMF+IKGjQVVk7utGIkKye/vub4OQ58Z4aCZ3EDXW4Ik2?=
 =?us-ascii?Q?CzLA2eMQJ7i3MDUeyVAvO3xilr9f3Rg9JAUKplHCHHPqZ3KVj0tYHJapDCTI?=
 =?us-ascii?Q?yTM9t4k4W4axkbrE/hsAvLhNnnXISlELJ/HA0QVzwbL964lYIIfgTT5udJUP?=
 =?us-ascii?Q?v74+tJZ0OcJSLawZReDa6jmgB8KpCc38sKE+cPqUCft/cFwM7Gf1FUo3vroa?=
 =?us-ascii?Q?WK9U9okC8IkL5SIH1EykgI3hbXcxk5XAz5Fo77M5JVQsPTZfEvb1H4vX7+hy?=
 =?us-ascii?Q?EjbjP3d4CIJumRDpbjFs1MHuNVzvC50/tLI9jApiI5JPder87ruP5omm6zJh?=
 =?us-ascii?Q?tY2qfncR7UYvK9CMp/pRJpV014WL+mago0VUt5ovHHvHPSM96D7QFcMeJ1tq?=
 =?us-ascii?Q?k080M9r06BW/ZhwBBapqMDQaU3pYe2aCN00gwbDKzw2nJkYLM1rEJRDcl/Br?=
 =?us-ascii?Q?MzjwcX2nVxgNj9qKlLOrgbE4r5ZFCe/TS2Irc27I5cH41xnEwGgtBR9PUyxW?=
 =?us-ascii?Q?DFrtnCBxpwa5BXlUzLbFcyK6xpA2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wd+pbG0BTvBYiU51OzkVksv89hS0AuA5NS2e/j/3ZiX4z/ihsgh2L6kOCNCJ?=
 =?us-ascii?Q?ZZwNvz+greyuqvYoTwhLF14lzBa/du7cYwQ4DMpjh9eJiUcpEmYM87vnolxx?=
 =?us-ascii?Q?0ETQw3Pz+dYgxn2gypUQ8Cr+G3eo5bGmCeLVlMEfE4tPzbaEKgRk4az5KSEd?=
 =?us-ascii?Q?3WKxUPhF4KOn3rhcU/nu5Icu6KtePW1V0O2y+M/dFfc7ZUQwzYx9hADAqRfe?=
 =?us-ascii?Q?sPelYOTstwmwzBkvbNal2Gc3r26JoWLR663jNL/noIph6FsHouAivxzwRZBY?=
 =?us-ascii?Q?FBjTlx8E8Wkj1zs0NxohVgUi/QBHIpkltduooA7xH35/ypcyeKSt13SjWRbd?=
 =?us-ascii?Q?zEwbarqyW0kLqT6o82NI14qwEgCEhB5t83rJam1mfSjRsBJnW0QqDAZaProB?=
 =?us-ascii?Q?zSentk/xz6eu/Bd1C+xI0TF0Ywv8o9gMGQjZC3JxLkxA/5HbfSFcBh55JvKc?=
 =?us-ascii?Q?12oCX7gmEJadKH2xBSB9x4b9JNP+Bun/umT8jbQ2PhJ3Hky0SXzsA7dHy+s4?=
 =?us-ascii?Q?MPIQWDwivHBZieO5i5IVG9xiG54WuD8Yp1lGYmFB4jX/RxNy25QSB9a5YQvl?=
 =?us-ascii?Q?oeKogDSzjcBAJyxRc0Qg89tdbnFczFFhoYyC2yP1BCjMdt1LkVrsBsOAaX/D?=
 =?us-ascii?Q?PEiR05p/WhAeWl+JGrc4SN4v/xXJZ3DAzQcjUJKQH97ovXyL1CiCMRfzAcrs?=
 =?us-ascii?Q?Ld25SipytTHt3sz4RFd4h2DYYEAc5n7zPXBFDbFDIFbTLI5h5CtK5YEwtmKB?=
 =?us-ascii?Q?wdk/ohRr89RPgk0/wS9y2jdLOHJaW/4IxMEg4QlzInHfKX5V/S5imjkt3PH9?=
 =?us-ascii?Q?z3u6a3/9yATa65NclGKyvIBHO6DanAT+WBHvLQDikV2Z9EiACuhEblWd6Ewv?=
 =?us-ascii?Q?dH/hEtjx+fB6JPAn8/WNVtoX5jFzlS/+beNvErms5u6KL8xYVynuRKYCBp47?=
 =?us-ascii?Q?o+ZziK/+uWDxSdShHyEJhXy9TWZtg42W++NXeXmuSH2FKq5dnuRV9Nx1CqEB?=
 =?us-ascii?Q?aaQAN1TF3P4t6MsDzJwdSVEIG6KbdRUmoA24EzR9puPPF2L94FWOJpUt/2p0?=
 =?us-ascii?Q?KzGZQscx+UaxZCsTOU9/3mJmOG1RDY/W2IS5CbNh+08vXNoE3hdUC/XE3kQH?=
 =?us-ascii?Q?2xW5oHdgz/sxGs0oN9R/keXhTUOvgYR9E7D2x4CU8mNb/jt0tS89UE+tMlMH?=
 =?us-ascii?Q?1AFH67VehjyO4MxBnlSUu2PsUcAyfpoUC/CiwQiZvgneE3iCQF3Q3t7OJFDX?=
 =?us-ascii?Q?ARUgKT7H1mb7yKq7P+xEofQGB90u5isQGuh1X09++Du8SJoUjBLtWLUHaJLP?=
 =?us-ascii?Q?6Xe/w04Ig+B10yD2ejuEFPG5FOMPs2/JR8CqPprJ5t8VBfrvVra4ZaZdKIaG?=
 =?us-ascii?Q?TMGMHlzADKiysS51hcfQox/inFcnx8Ap957rIYwNX+Gli3xDy6SV2ihUjVUd?=
 =?us-ascii?Q?ByI9mYV9bmKRFTLrJ7IYrUNUIbloTaSABwKcUDMixOlvUVBjVXmoSa9EptrC?=
 =?us-ascii?Q?JUMM4+lN8TaSk8UIvRJRwN5M5eRWVz32m8wiqUKA1fN61STZVki8pvNRN3dE?=
 =?us-ascii?Q?NaB7XMQsm83jiYRySrVhWUJEVhzWKvVZrZqLMCTi1k7Y6W7Xj5k7oMtugSWo?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e43936-30a3-432d-3948-08dd4aa71f5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:19:40.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJaeMHCsAYTFkkR5qbeYLrYi7iOBgKhw14ux2lDbZeo0Bq3WMBXAh+u0LznHxXHu1c1O5/SS+xijHQ4FJ6sKcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229

This removes the bass_bcast_probe and bass_bcast_remove APIs, in order to
decouple the BASS and BAP plugins.

Instead, since the BASS Server (BAP Scan Delegator) implementation needs
to reference the bap session, BASS registers bap attached/detached
callbacks with shared/bap.

- After receiving a request from a Broadcast Assistant, the BASS Server
creates a device for the Broadcaster and adds the UUID to probe.

- The service is probed inside the BAP plugin, where a new bt_bap session
is attached. The service is set as user data beforehand.

- The bt_bap session is notified in the BASS bap_attached callback. The
reference to the service is accessible from the user data.

- The BASS Server takes ownership for the service by setting its user
data. This way, short-lived PA sync will be skipped inside BAP, and the
BASS Server will handle long-lived PA sync and stream configuration.

- When the bt_bap session is removed, it will be notified in the
bap_detached callback.

Iulia Tanasescu (1):
  bass: Register bap attached/detached callbacks

 profiles/audio/bap.c  | 53 ++++++++++++++++++++++++++++++-------------
 profiles/audio/bass.c | 46 +++++++++++++++++++++----------------
 profiles/audio/bass.h |  5 +---
 3 files changed, 64 insertions(+), 40 deletions(-)


base-commit: d3e40e82afba8bbc24df8c23272fbf8a68e6ed67
-- 
2.43.0

