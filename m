Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02989445
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192313; cv=fail; b=raQnSQ+D2GZCW5KX9Sbzcwud0R7mVwtr2SBn+6A9xewxvMEmlLs/QkdVmx/c7BAgei8O7OeiJsTKkXRTEF/fcOqsXOFmZnxMNmtvMxVutL0Tm9hXbklbeUJnITAkvKTyziRXixP8arzS5ohznwYH68P6W3UVhbdSIjOMjfEFtWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192313; c=relaxed/simple;
	bh=B2M848IHVA9n2BKN0dl/gPYEZ2suMA6nhNTl5ew4MlU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RMQVpop8Got76xGqNf+M8fdWShr9wBp5TaGJWKdTtyZXecx0CcILJHPVWUgVZaFdkl/7/S7zlcwxHbvJCrD0rqQzHlBvNM2694LwDk85WcTXigH5UF3U2YbQOqAOo7fEn3s0jzU8eLckd0/9tcNXl6K/0WXmwKzWuNUigcxA0oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zdp5u6fq; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zdp5u6fq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wouj9qJqrx1QmmZfF2dewThFYlU/r/Tz4Ggc8vpzjCRB+hbFNdzvmTSNW7weZ4wwc5jrDekCcPxJk3fJlCLr3kKIf0mW2Nk0m401vNuMJFZJj8/0ETj5N5r1zF/mp3jCnBRe43oHxsuSqHyF1oJ26Z/fALq2GEN2KvUjFyhANmZa6Dl5IJp3KGGO125Wp7HTebXWskiF1beI+H8EcvIOZxeQFPZDpskHR9aMaT5ti2/E2U3m1tZ+FIZgD39HO3RWAHL1Q5RdUCrU9Q9WY3zIS9NviEdeote2RI1/kcvzn1XZwK8ibMZV+51/iBqKmNijfvQvGZtIVYBoh9csDi1cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlnXjQvqrOTXW+wi/bZBT0g8AMqVocTihnF0ljLCAus=;
 b=lemCdzMxiIS0zRyPT9dGTL33GNRt5eHQFinywPI8w2oUr0TZGC4mWKx0uugwQBH87muza2JVUCasUNTOh/TeMqPi0wIPlp9pjjr/8+fJCmCHmAxyDVJzY6d6XEp5k8nh1fmTNxMIpCQL5xMUdOX6j/UzexYTobguj4Hg44drDllFTkPPyTO6mwtjOfuhJRmelFwGWOOnE5RNlWME36/BwlhBkFM/5dCM1LLBz7wf9jhdl/ygW0G61qDk8HUHtKndeq5EMh4xOxH/bfzGZXcl4nR0G3Tkin8vF5UnHJte45c6GwgQVySAzkMiY9PsCoflkzSQqSB7hb44VR+5XHDghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlnXjQvqrOTXW+wi/bZBT0g8AMqVocTihnF0ljLCAus=;
 b=Zdp5u6fq3qfjN+IrrrLdy8fU08C6qKrAlVl3b6K+CW7pB89bSGbDgw26fJPe/DcXjZdyy9DO0748Aon32qqQRzkp+wfDDFXPH0t/mVEelPnidZpFQo2SYT6vbC3t6I5H+dEk2WB2/XF8HA28HACYrU7BSYAxC8bwXmNFDwgEV5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:45:08 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:45:07 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_event: Fix setting of unicast qos interval
Date: Mon, 15 Apr 2024 17:44:29 +0300
Message-Id: <20240415144430.34450-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GV1PR04MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9a639a-8317-4b1f-b198-08dc5d5aa4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jhw+TdiUz+y5Z5BCgjnggOV1Bq+JK+Ebu8QxGuiwHz7+rkGTOulDWJhy7H4pJmNj9zNFZfee5hYAJcLAXpDmB2ULhczthauvJ2kU5rXSlIOSKB1BKTyEXyIY1EwN2O51gLlhZhHl7iBYuA79lCNIOuAVGVwHBk3/oYXWymVgDa31xjVJry1ACG/dyF296nm++ws2jUhkV3dL9Irsl4qa493gmotSP9o37Ejqivsv6lPCpc9rwP/KyOGL1yfLPIrKCya7YsmqV4F+02zuouuu/t7b2AfWlR5ivAyByV0kuEDQ/8uZYoWqrvCndRu3JDUMUk63HUiHgyALllKjwOiOT3L6gZcDiXlkzpIrr7VVMQrlgZWn5n89Lg3t/EbOkon8Sid7NfQmUM5Jih6UQPbJDbK9DN6H/77AnjJErFKwPkHQPHRqZ1w0yZAPfW6LYZlJwxwZKFcGGQtNx8lMdCfhLpd778efL8200ZkN94MUdg3WLyL+pWfo2G7T9EPDBwu+tCHyf+LFNvABOZUFcpeG9lsilsvNV8WbLuLR0EY0Pn32oArdPAVOmDYcvp+/4aB4rq9RaKEPiT5lK6snwob+zL3jprUBOVgH71KTkmR5XF/cMguJSs2eglwgPeU20r6lLXV/YnQcLeLqkTsGT5I9ie79oeWfaXU/uBpyIrpCUUmPtREf0TPpeotF98jWxWKQYpzcbh2FbsdghwsumSVAOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+6wmOiFoZexikcMEKTGKQIyiaMqt7i5LeN6lOmvPkY/JZ8zUwP5nmSioP17?=
 =?us-ascii?Q?ZqenDIhrPuC6+42nLD+73wbvN3IpbIUVq11jeWrdZjl9GNPp+8Zz7FH/sYcF?=
 =?us-ascii?Q?capEZRqFFUu8up53nashRXA9Jaw7LD1vPUW05Z4dS9PqIRf8SjJbOZSiTLSO?=
 =?us-ascii?Q?qwW69t8rzXQF5WIMOueV0k2lhJo88A2QYoaAUYAzyHg1BBiDrvTEaE4lz8rl?=
 =?us-ascii?Q?yPAfuLzei4eVgqkCdcM95+bRkqsz5iuzZSSkN7q92jWuPCeqS5DA14y8LUZh?=
 =?us-ascii?Q?9uY6KG9uw4eb1EJEMYhCVNi3oGlU++fnaLJeeB3a+51+gCDpqNSasOdxTYpJ?=
 =?us-ascii?Q?neg5z20EcfHY1NRAPf117p8Dd9tmcPt4lKCtMDoRN4hu1Lp7uQgSJPqLBEJw?=
 =?us-ascii?Q?yE5NgPsjVqjlkLLUoyXHqsSqYch8xCnhGmr+4hihvIFcoDKTh2wZVBoHcF94?=
 =?us-ascii?Q?6AzdJn3onkInAoa7yA2plbuDUQ39fJ9a7IW6ljzV/B/wVzK8GLEgqiIUwUOX?=
 =?us-ascii?Q?4jPCKVI6dk/wqGiDVr9rDlPMKUWQil98LNZoNnhh18k/isp5/m6LOKrBpwDx?=
 =?us-ascii?Q?83jTCubZfkv14wxDH17BwHWWlA1ovRnNxOLQw1FuUOO0JGfJv96gbc3ZeFC1?=
 =?us-ascii?Q?KHtqbIMr5HOuDB6p7BHNqAAbDeKdC+OUNF7YPOINdUlQTbWwszVCv6245nuY?=
 =?us-ascii?Q?cUkELXZg+U7GDBMpXIuHQ4BtE5gMU7oCUnbCLgHbDxLgDjRjaDm4BXSuCImW?=
 =?us-ascii?Q?LMDAANYMdvUl+/akG5utnUlcHCxTWEiKqudTb5bu3xnO6QfiwHY6Su58IYV0?=
 =?us-ascii?Q?8Br+wqMqCJZbclRiSlG6vdN06yM4ebAOexjONJpNtPHSVxqASn6JtuEg+FBY?=
 =?us-ascii?Q?rXwITEbNsOaw9GE0K6drUrHgQ/6S65TSbIuu/McA/B7FqHtLuvQDga656tz4?=
 =?us-ascii?Q?rI2srrWlzgDYTp305aTFKMW+ytAs4SPPLkS5LSNKcwDg3481HGK8WWOq5INb?=
 =?us-ascii?Q?TEETQmo92ovCVtUPsKbNKNEL4VDy7WPLX3K72ZdRam7FOvVrN2eXQEloOWFO?=
 =?us-ascii?Q?Wl42bix1kbrY3zSYO3TJJ/fW7EnttDx5mzh9Ya0kLrGQXU86IEVLQ40nLsi1?=
 =?us-ascii?Q?9zxC9mo2ucQN9nbIt+48MGKY5aAGhdyxTjoh0biFQIWy+OrEkEV1Y2oB3Mm6?=
 =?us-ascii?Q?4K+AQBCwjSvLnUVYqxoOXLmcf0ODSPpFG2uURIZyFG/OZRtg4z931Yp/k5iQ?=
 =?us-ascii?Q?kia97BYk9BY3eYs3EYrGlB9JOjdDjAn5+Hgab9bL2QgGOFxlkJ0DfSlPm1fC?=
 =?us-ascii?Q?gsgKaEKt482t+nX96YDmJ10pcQvlg4NBv6zyvVZfHy1O8eyDh9i3YicxjrTQ?=
 =?us-ascii?Q?WKovo95vNxB+MMB2QIgbC4sSk2ZtIvVuz/aplDQM4HsDNbiBXO37C98VTwgV?=
 =?us-ascii?Q?ordqeUfUVnptEwcMJKI7KicWwV4q7s4ieois4B9gubGVWx8NDwmDSl+ShboL?=
 =?us-ascii?Q?hePgaOYGQ1i0oQDHuGoyCPbNWrdG8UgW2A0h2uSiRhIYjxVJi3aiwhPJN+nd?=
 =?us-ascii?Q?bW7hjs6AYTDKleYysIvRDqxZemEUG2VQBLPZn/if?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a639a-8317-4b1f-b198-08dc5d5aa4d1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:45:07.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llaA8k696kuZXo8mR8ZCG2OWfpoacLy5TeBJycDY+u+4rptEvL8UQt5IN7CgdCsKOhoTJMIBYysZHZUuM9UCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9151

qos->ucast interval reffers to the SDU interval, and should not
be set to the interval value reported by the LE CIS Established
event since the latter reffers to the ISO interval. These two
interval are not the same thing:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G

Isochronous interval:
The time between two consecutive BIS or CIS events (designated
ISO_Interval in the Link Layer)

SDU interval:
The nominal time between two consecutive SDUs that are sent or
received by the upper layer.

Vlad Pruteanu (1):
  Bluetooth: hci_event: Fix setting of unicast qos interval

 net/bluetooth/hci_event.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.40.1

