Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3B1CACE9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767793; cv=fail; b=bEXjRuXs6vnq7s9sy/baQhqvBmyo1WeZbrE3PpxTZnYMAwLXqsfR28nwWtD1tqKDkK8EQSVn109A5rJ2rihfFCH+aea7hTpSKPtPGInrB/QKrlWC8bEN2ZBcVKefESN3kXRY/Ttv4fjsm/nU9kYD0S7+OoTBy2F1CnFf6rA9I6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767793; c=relaxed/simple;
	bh=riagUk8Xxr0Cktzk4sHScUpvK/r5x0fMe64DRNDzWgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZpSn+Qukpi2/6YCtGqolbFe5tGU6l2G81FjcsZNQOnqArMA3Y8L9IvsXQaanslMxFtNNmTsE//i4XY54wqKpTEZXcGQSHeo0VrwOpyu8ypHySFycqzZj0+rZk0MgS6W7mJZ1kO236VEuX+WObPWB7gKSKwNkFiCNgpPyk2WRrN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bJEGPmbL; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJEGPmbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq7zjcnEW+VQJjdQXtmaMbXX+t1Y32QhcJQhtXcQxXY7eJPab+6UAKNnKzBEDguiZda/c7AU34M+MnjivS07enIfyJQCqkqWwFKbTOH2pHQnFrhBsannGGrHBgFmnne4Xg5C6MCf6MTEEYyNZCLZ2z3+MPeQGV/wRteQXSlR2qNHlLddPlYEExnQPArMM6L95mW+H6+wEcYLiDwfYDdEIeEk+pgD3k8WyaPvfkKlU6hbOvvPyuW1AwPGoZ8A+qVKqME9IgM8HHfaqToxk8KFcYjZjYW8PhpT3hejrcMjlnhfIDjbE09MoLLyY89t2lTZ/A/qeM8obLoLoAYIJt9eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NhqylQQdv+u6MmA4OBs5PD9do0FH9Ogit451oRFxG8=;
 b=ipNEs8MFOrBj41NJrs+Ft3XykHYD64e9H3CVe9sx+rlHY3/oKkkrYeO7iPgXdoAyB+fgaeaifpBkmc5j5PFlyG73+iZDPSX92S8UvfUxw5wzx1Z3OP0xNhJO/fMEsmA5ilBtFdkBRe/AgNuLuuFnfD14EkR53mNkxGKTOYxSfLEUFzhZjeTDqRXi+iNm0tVWCLoxxk6HVnX2qAdsoIotThawWuMo7/noTe0iDrffVuMqgGre6oLy1DUV7qWkQBvBp6vjtT5U8YZFn3eA6PnnWGg73hZIprbb5yioMNYngOaIuEdAqMIRxZIO/ojHIQqKNGTXMZZtwI0sjzySJgeNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NhqylQQdv+u6MmA4OBs5PD9do0FH9Ogit451oRFxG8=;
 b=bJEGPmbLoUhlbSHrK/vPDyBy/g3QwsCCIZhNlAutp7plnoiszyCRmJTuQx8/VcjTnYS8HLq7ebVUMsX9D4EL2RmrFIEDhqQ8NtouBw4Thj/1TSk6w580S4CJPYWS6vQa0OFk1SYSeey1fhgWEZA5uFifzWqZUOiiRL6P2Yfozfm3rA92J7YduCL/EJ37uqeOi9eGjof5TSjNse/FYmwXfumH0sAkOLQFxUrofmfb68fV4kS1Co6rWoY/XZ/ZKk3EBmqBAG2wBUx2XQSSQ8Z2onQKDkJXCSdXGomZnC24tOVvvkm46Hq4iscmSYjuoDTx19MXeLPtDzwLtZLIk8+E1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:06 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 09/14] doc/media: Update Links property for broadcast
Date: Thu, 24 Oct 2024 14:02:18 +0300
Message-ID: <20241024110223.77254-10-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fbcb76-b0e3-40da-daf3-08dcf41b7011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWuOjT0ZKuK3NpMm3mzA0DS3qdtKd5GXHw83Z8IIGxdvNo+jFsGQ1WSlbhqQ?=
 =?us-ascii?Q?O8sMAE3PDbXTM9LMeMz2iGwqvCzouR3r2unLlgbc9Hrgakm5F76DuC7/ebYj?=
 =?us-ascii?Q?OYhoLLZ1Ywpt0UuRy9qB4z9dkuP+h6FnHUVq8b1JKQP2U1B60TP7JQgk+0UZ?=
 =?us-ascii?Q?oDEEn93g87+C480dJrDgO8lmWd2ugDlnEsy/RR84Pgv7jjBm6Zfugenj/dZz?=
 =?us-ascii?Q?0heKgwTo7DQVHNmOadgRYzM9rN525qD+/A7JNJy5GiTDh15Kxnu7TImevr1f?=
 =?us-ascii?Q?eNMlBVGbGTGH9U5lHxv0DTvAoAnby0XPLcsHizUwEHUWia8y8XsoYafDPbjL?=
 =?us-ascii?Q?GQpV1B++96JS+5r+ZJHmaKih50et39jEGaYVpEUf4+WYFiba+HcBvcltUXgT?=
 =?us-ascii?Q?o4movZLMjIYh32EO38+Wfy7oM5WdrMVbGqOubvr93EClHlcvC2KRtgRRSiJR?=
 =?us-ascii?Q?XlEOX1+oBFruH4oUEdXtPbJpzs9BSvj4Q7ZRNqLfEbGWgG2lrR5CJ179tnyI?=
 =?us-ascii?Q?uGUVyUMJR3RTGrMcIe4TVHqLUBbqgprOPpwCo8O6obs4aEL5mvcPkEwgWV0G?=
 =?us-ascii?Q?hacIO/BvC6YApE7buIxciJcBreptESavIxGmdwQwdQANz/HdVnm78rXQkzb+?=
 =?us-ascii?Q?zlkU7dVV0NGYQG4qBwMAbeWkcqLx/o+dVSgU05Kkmcpx/oW7RKDBQHuKzmse?=
 =?us-ascii?Q?oNscYYlh6lO6CQVLRJif5gVXXKoD3Mylo9CvMBgY4zAPPobDi7p3fcusBnYG?=
 =?us-ascii?Q?2EXeoGQxreGcxEACImMtg77MqXJEr67PiCZvv6Ao7LLNO+KXrrLqn04qM0UI?=
 =?us-ascii?Q?9rqNvRONi3r8EyZEMzhaHTY7yJoTg2PKwrdtkAPa0q9NK/c6U0wvSX0xdbsn?=
 =?us-ascii?Q?e3QK1Sr+lB5TsPgIHfMrijS6I1jY09Of8MRNjXDuzwiBJwXg3pyR1VmSSFJR?=
 =?us-ascii?Q?7Lgp4yOcc3XlZ292GfyApwwV7pyp5HOJQFK4f8nql3Yt0aH4lL8m2xFLGkIn?=
 =?us-ascii?Q?4shOfAeaNH8B1MLwM8Yq2yN+68Nhuzq/csNb0US2Hr3yOYHCppQ098Q3LhWW?=
 =?us-ascii?Q?4dd7whFAlTm1fZmx0jL7eRh4vPRq+69cEFa06UwNpn/B83XKNWf9g9FjygPV?=
 =?us-ascii?Q?45KC3FHdTtvCpFWy6lUbFj9f46Mu/L/SecUYJ25P/y/wABonEkTuprJL7Ng9?=
 =?us-ascii?Q?L5i+iA8cT5zcKCZrYdR39viVPCN7IxamSrljEKN7dSVnXAJA088RKPnHhe/B?=
 =?us-ascii?Q?wkTVRtjlXxUnvVjcP+dP58Bvx5TIpD8MMpJ3Men+SCY/mpDWNgQhQRbrXvUI?=
 =?us-ascii?Q?DBVaP6rht5DyjTD7/SNPcuMSe2oXyUmdlgiUtMG88W9S110NQAab+fc3xWA3?=
 =?us-ascii?Q?Gq+aOIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQ1tzCsf17V7QhFjGDdeArsTYp6dqzYwFbvhEom/LzcVREeoaLvrzzzM6A16?=
 =?us-ascii?Q?A4O2iUkK2x7VnlEGI7MNSn+5VSEQzcrkF6xW5t/SS/Dp9QUS6WuHse1wTX5g?=
 =?us-ascii?Q?DAEFhpZaFHMC8XINsdyrRHfNnfc2U1b3QLDoEpD+d692ETeFiXSFfwOFG7Ir?=
 =?us-ascii?Q?b39+7VFA7ssuZaslhGrh9cJfy/pK80iwMls7Gc+0MCMjgPA8zGW/hOaQeZpg?=
 =?us-ascii?Q?Jx4Us/0YSRwW4dK3y1Dd5fgGBK1DBTdm15ut8mdhVG3kuk0dr3hGlvonxQug?=
 =?us-ascii?Q?ZLLSRe5qBZO+Gg0ruMjF6SovSdWI6Nsg4L8rvf08LQ2zv4aPzELwyiPx6Ljq?=
 =?us-ascii?Q?9J8xh2iblRm3TlyTU9SG5KUDMysHRfgboZmZLRA0i66MuZB0Mu68o/425zYX?=
 =?us-ascii?Q?Wn7PikAOrgMfv1mD+mii5aCkne1mJIIFw0AIzLTDlcTJmtmX6Es8Ts7SxwQ3?=
 =?us-ascii?Q?acCoyaGD1tvb/4zTvb7R/lPfVibUCykzXDfkNRo3i9YIopEkU0I6feeSpaVO?=
 =?us-ascii?Q?hEGZofdHJ6UkjkyQO4FoDSDyE7rhdTzc8GCI1cmqpWFcA9Cm94bYFzWf7+lZ?=
 =?us-ascii?Q?a791pNXAcnBNzGVcp+139x0sCXaJNnkNpJdGiZi/kmyYdd3o/xCErSTM541/?=
 =?us-ascii?Q?XEJ0VvwOkRRSbz8AFNAWVVKSOqsRQuSqQcv7ThoDC+2+uAkUF0oemT4GHEXv?=
 =?us-ascii?Q?yIW396yciOmPgCKNE4Nwnmdjren4ay1aVCldJFbJVkExsVdCIZJmjjXAaM+b?=
 =?us-ascii?Q?0Xvpli2I4D7FY/HfrTppe4Y9vBrwS4qYlBvXAzBTO541vXUQFjor8hrnO5aW?=
 =?us-ascii?Q?R1n1Y5B03VWIQWHIS6FmEoWOAHXYXso6x8Z/Y1jHE7N/bWGpWoGnDRp0a9RZ?=
 =?us-ascii?Q?v9EmZVD5v77gulyXDWB1jt4jTV2ZyzQd9L1Et4KbjRN/LjVvUNeyeLQfHBkj?=
 =?us-ascii?Q?z01dFmpYveh/FduBAHDlwSrwOvVBl0dq5GYCOZ3FVc3aBApkHyQoI4Z5w2cZ?=
 =?us-ascii?Q?1yZZnaVoIUXshte7YBjnugNZ8cWbuN7b+ftXpOqpaH5dHk31U4MJRFEmFKNF?=
 =?us-ascii?Q?IMEifIR68VauBBoeaCQLBmPvdCVhTkJwWneE559Icv/CNVg5T8TmFknqBy7j?=
 =?us-ascii?Q?LkbftVHgWSC7aSU2Z8NlzCwqY2tTspEvUl02Zk/cqzquvSYsiDee+jbng+k9?=
 =?us-ascii?Q?CuszS+4HbhP7UKeowd9OHjF9h8nGFSUhaZrNYvYeUMU6JE5n2H8PT1ZVBOKH?=
 =?us-ascii?Q?TCznJdVKsgmRPEMYIoib1yLzBk2HhI9peokYXZNPgrqu4MfJL9ulgCzfzyp8?=
 =?us-ascii?Q?3Qtuyc8HbOlmS0T682Nb3iphZtcAX5Zczaz8i0KYtd6JwEBCOsfARl3Q/UEl?=
 =?us-ascii?Q?tMEcQOe1S0K31I1WjScV/bKh4NwuxIwU8ocm4neYoTYtetpHxNzGtZro70Dk?=
 =?us-ascii?Q?Epbi0LeQzS4c33YSIQ7/V1ouxwgv1/SxolSohzAQYDxZVGi6NsFeRO3QMfpO?=
 =?us-ascii?Q?AkPAGNBQnYGwaG9sWhrRZeACKBpkr9eQ5pcEMBEQlyePK98NtMs3WpIGodxc?=
 =?us-ascii?Q?inK8IBCy07TYxhM6z/VpdEH+0CGLwSKKqq43SYsk7Z9JGb2lM79kj6uoz9+q?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fbcb76-b0e3-40da-daf3-08dcf41b7011
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:06.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAcQ9o3aLjU9cfLf7JbgCTio9XYBOks7AZG0V/xlRpS7Os0er7BdZMc15VoSVKA5oz1yq0hQk9n7qP9zr6r/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This adds details about the "Links" property for broadcast.
---
 doc/org.bluez.MediaTransport.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 4d998b2a8..2173e0177 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -149,6 +149,9 @@ array{object} Links [readonly, optional, ISO only, experimental]
 
 	Linked transport objects which the transport is associated with.
 
+	For Broadcast transports, the property is writable and it is
+	not optional.
+
 dict QoS [readwrite, optional, ISO only, experimental]
 ``````````````````````````````````````````````````````
 
-- 
2.43.0

