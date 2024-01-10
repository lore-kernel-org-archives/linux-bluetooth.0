Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA64C63A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsIcFYeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg73PeoRgr/PwCm+9QuyRMAs8yNxc0TymzyvvuckTd72N23lZI5b+bVqV9yXhB5ol4+DFKuD4NxxbHlCeqcYxJhKmHojqJjX6d9smpG79Py5+NHLCUqeXCsdUzYw3nRfkeqxvG3XhJ23Hti5BrGKNX/qozitwKB4oU3Rj5lxPK2l0A8TAXO2EV94Mk428P6a6HMTyaIHOeBfjTkKKn1d7VV504ozwMZB3xXJklk2TVOP0+4Fsz2YRuZ4FMUd838EF0weIJ6OaUkN1eZqNNY96n3rdwL9orjuBeh95SOLXc5mshKnFAMoEUP32N5z6M40AQ1xpG3zzDPkgdUslVRFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=d+uCq8aPVXzFD/416OIyVccyW4fHxGhAdhqlKwDwOphweYg5CB3eYfjOYXFadoSBd29Qw3lPhIE7u8DVbjo9aJll/GVbAjmEB5J86CEeggDgsXTMULtwmLxRCFmlRzqXk/kAx6tRImHe35Jdqkxof3J6YU4KjYLoMvGP9qlyLGPPX7kJhd59nL+PAwOl0WlRFLd93n9KPaOtXBOkK2IlUWmi+iX0d+/smR4pB2x6J6PlkD1XA0f9ZhQrFfH7cC4w3+htZqWNztgH+yF+1yxEwRMx0OqnrFXNG99/OL6WEI+QlaAMRHYgs+c0RMJLyL86NUN8fjMa0JIgr8t0ndYt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=SsIcFYeEq8eoru0KGAWnkauC8kZHK0qtZgDLXL6xe21DfZPCh/19Sv0U5dTjGSNmugt3ny1scaVRzQDoyzIMd3gT/tCIVBCN4z0jL/d5naxwqddCtGvanHr5kXAnWdYPbX79VeQMjP9KGqmwwfyb+mtrImst83yakVle95IKl5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:11:14 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:11:14 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v4 3/3] client/player.c:Adjust the SDU on locations
Date: Wed, 10 Jan 2024 18:11:00 +0200
Message-Id: <20240110161100.106191-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110161100.106191-1-silviu.barbulescu@nxp.com>
References: <20240110161100.106191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bea851c-69d4-4766-65af-08dc11f6c4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JvfQ8+34YETqDTPNQ5U1sMpEVGNqgHY3jagCXXF83eTmARgNLiqiEfFvZsScbW5T4YLh+eghEsirDe4VzJbP/Jb/2PVSzlI+Ov/zwvqKij6I8jjnBdo6mlz2O3VbxYN/HrE3oT7cBIarqDZiTbK3MXpo3ST9CMu28Rs/WWy8vtF9Y6Rl4wt3n34NmCCUF+wiN6jVatnJLFn+I1iEO/4Pi1YuYZ+y/jJHffIFWhQlVl2RjTTUhlED+arjpdkMgoV/nhQnnt3yimelQSGk4G1AKtqy4ga8vuaXAnzkgJ67dCA0CoCkctGfRwVR9f1haOsyAahSBblfDkXzwJeW+8wF32Vhmm1bI1e/YEX6IaIGF149nPACpfmH0FIGdsD1op93wZrNKITzvkpfcxRHlJ2S9aCTxv9+UL7LySYRRb4QJAfTHbu4Yd79713Udsrx+2OTnhBZFc3IjFv+0zog/GA/gwSzjxSYN+odYJEJ6OWMO0qFUluPi1YmeBRZaMAkxW4rMgvzWaaySs1jICU//NacrlTC7dwXAQNOgyNrlpuhEAnsgBlW6+KbL7hrRnJ+uhXo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(36756003)(8676002)(4326008)(83380400001)(38100700002)(2616005)(1076003)(26005)(6512007)(66556008)(6666004)(6506007)(6916009)(6486002)(66476007)(66946007)(316002)(478600001)(41300700001)(5660300002)(4744005)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mQGpIvoJr7Q1MFYQ4s1uN7tlMxPC5n+pFbVj8TBnZ8h8BTj3aGcoGa3HSwO?=
 =?us-ascii?Q?kFp5RZ6+PDl8Wra5fTUTuGlU7yaD5BqgpYmAd0KsAjJKB27hmiagYCQY1CxH?=
 =?us-ascii?Q?LoMVAy+ArmjqRloSnuOaL0yu3u2eC91vO0TLOiGprfcrMlXm8bQBfDIFyFCm?=
 =?us-ascii?Q?nKe4iPFPLy4fwwcdItdm7FODOmPAxRU4Hs7lcNJNTX5zcaAIlIMTzlF3veA6?=
 =?us-ascii?Q?mn+bXmnHds1PpJKm4biuLZvkg3pqfvL4TMIiX3ITPt5dxaMEWyrCoOU5YkId?=
 =?us-ascii?Q?wsqTDfmo3lgCcZRjbiw/lr0Q57uzNdR9xSeMpbVnTyqn6+b7owCBEV9huCPW?=
 =?us-ascii?Q?nyT9xWecOTxwplXG5ZHuKYBoFkKTfGxwqTFMHIDd9BR6RM0+JJwOSeoocpzv?=
 =?us-ascii?Q?UOMpj4hTdDbGbMaNCW+MvG2DcVk/xXcVx4vplSpo6lc7P6hDFP/s+9+X3LKT?=
 =?us-ascii?Q?YpoQBI3/Cilt77K+WGIUKJ0x9MxfVDU7pI7TwbPSnWnlIALSKNOJ3RqgCMCp?=
 =?us-ascii?Q?qBFxEGHUcT3uXIwdZTyQhBxJbGpbX62K9Ek/4NaKOxs3HihXdAedewessAho?=
 =?us-ascii?Q?amKqZpyIRSHgemHNWuwSCljKVRMNlhGWvQC2Upub2Ayf9ieakzNiTTzcyc95?=
 =?us-ascii?Q?LPewiXHo2E9R7Tih6REL9RwWcSXzFCWZTw5qUotJHVVyqTaqE5K34629ElY8?=
 =?us-ascii?Q?YRbavBbxTMeSjLI4fpdDu3oU0/ZGSubPyC2279OpUWv4flQdAQ5XUBUzsxNZ?=
 =?us-ascii?Q?y7zoKXyfVwFtnHlftGtQs0g5VBXTpzgTAtS3vnxabViOj6kcTRGxzxHatvBd?=
 =?us-ascii?Q?0Tpcz4fC0TTh4Kv99COBByWMrWoaSSDgJA2AJwDNvcJWS+kB+/4GnbmFWuHd?=
 =?us-ascii?Q?FhDD78qs5lrtkx/jM3NBSH7uCT+3Z7eSIZ+wgcxRhQBLWHlmQ40stWwAS3oA?=
 =?us-ascii?Q?TDfXA+BCMDEP8D+2P4MmcpojaNJEsniEWZST7mV1IqkUYtmKhGXRHRz9sqMd?=
 =?us-ascii?Q?q6YKijILJPbqNkJcuu4dnUZG+8HKQcyruzARvyunqzE8yspqIde9Dn9idBxm?=
 =?us-ascii?Q?lAGxFX23TmVfGMvQeyWxkTxcWzw7b4KzSj+F18N948EuBcrlpPvQBYvloyso?=
 =?us-ascii?Q?31wmF2U9yRkL+d7tE4aBFfJD9zS61FDv8gjmpffm/mhavZPxVm3ymrVQjTg2?=
 =?us-ascii?Q?1cJeY85y9UMbOEQAFQVg1WR1aOAF3zX8tfHxnmKjHPTZEmB7qbRseiohS7mn?=
 =?us-ascii?Q?FBXvw+ltcSEWJZPjtzkyOr9XofXn0xWkqZDRQkt6BnCmG1dUrYw00q6topa5?=
 =?us-ascii?Q?/W4M7dB2lNjtsPmYSFKERzkGFXcyMRXAFlKIbAxEB/9zCq5AKb1XgGd/5tED?=
 =?us-ascii?Q?ThsGJmcCBW/p0j4/H3lEylbjXg4okRnBPIIhtKzPowH06ApxmxeSS1yNN0vK?=
 =?us-ascii?Q?BhoKIIZTLz/OtEdArCdPcfMcCeI3ljHnm7YfJhJ8RPb1rG3jiOMcVTmm36pq?=
 =?us-ascii?Q?yCb9Xhd1e12VISo3TRP/nNvdG2fXAeXsOO63qXWn6ljvkNyTtDheenxycb/o?=
 =?us-ascii?Q?qeKBZdlZFKbDkNczET74g8v5xVVL+9gInwICa73132K0bULDrojzVGI8bruX?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea851c-69d4-4766-65af-08dc11f6c4e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:11:14.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4vHxa1kuV4whclQZr6xqZlwFfvRaSape8XIcF/2nFtNL4UKN9BppwPH9txIiaaM3VMX3rFHQcVlgKx0wS8bePR1S3G8EovfwIbMnIOi2uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863

Adjust the SDU size based on the locations number of
locations for broadcast BISes.

---
 client/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/player.c b/client/player.c
index fc5ebd602..c892dc6df 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2882,6 +2882,7 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 	char *endptr = NULL;
 	int value;
 	uint32_t location;
+	uint8_t channels = 1;
 
 	value = strtol(input, &endptr, 0);
 
@@ -2899,6 +2900,13 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 		iov_append(&cfg->caps, ltv, sizeof(ltv));
 	}
 
+	/* Adjust the SDU size based on the number of
+	 * locations/channels that is being requested.
+	 */
+	channels = __builtin_popcount(location);
+	if (channels > 1)
+		cfg->qos.sdu *= channels;
+
 	/* Add metadata */
 	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
 			endpoint_set_metadata_cfg, cfg);
-- 
2.39.2

