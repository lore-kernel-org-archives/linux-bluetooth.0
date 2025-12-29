Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D926056D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004939; cv=fail; b=tOePduNyNTH+phsZjACmJtAN3dTeAbVm3dFLw9v+NnJCSZ40z8fudWoD5t5ADxTe5lWFbd0gC+v4vOzE+hQnUw92ityU/YSye73Od+MA4UITTJBGD89ddq/IUM9TMoUu8LZbyjSXza308fKpPyNfDU0x9JVotgHT7QU80gL10sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004939; c=relaxed/simple;
	bh=GgWzu6F656DWELIi+uYLQ2hc8LRAZfOJmL3PpRzIaBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2qdNXUyXKyavQOH7hFeqQR6XUk8VTu+NOpARmQoW4liM8I/ff1Hd3kII8jSk0u1FVzqdZzGyR0xirFn4Demc7+DEBJfnCUJkfCXlVTaCsbDFOF8zIxsk+KIkRmGsxt0+xELL/gaslZwX9KGsbAXeCpG8+MN0MUOFnAhJhyStDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fWi9MUvE; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fWi9MUvE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+tPNbI/TODjSIWLvLBnM4ApvtgC71UjvQLD2VaXN6TfYwPTKPwbn3MJt4JguGb4tUGFBVO9xNej8sVe6tz7q/rxCnluiulkK5qwSqywimHJfNBCwy6L9aRjqi9qY2mcgIlp0ODIBaoaCDrdOal8qVLVp2LZ7m6lOqMwwx/V5v/ZbcAU61lLRxCZt80jz8LCjlwUi8G1tkZ7QCaJxojC4IGOXvL6dwgv8laVPMzNzrWbHMfAUiMIj1p+jyo7CA7h0zOfduA+Vzms2aOXVhsXro1W0E8v0hMwTlkVW0XHC8vUHbkYOxRjXyQi5oORD+JVh+YRDQ1syv0DiJyqUCOnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dsmAemKLBepqIFLpbi7QqiN71/oou0kW9bQDNJOT6U=;
 b=eloDvBfXCFGiB2NJA3krjC/McS/FOpTEBSva7vrcNFBazYCkM+W0xWGi8/PWSNncFVZZhfmfSWUj8mROF+FhpJxIF2hmS+0Db5UXgPS51EDSEZ389cQYNRPat0qM7ZVt5J117V4jjLQbgQstPYdTZwBlH16REY4jL1Cy38h4EL236gSQu8wcAjO7QltQ8QXAZozy8xllf8ozjHnz7mYowKymPThtX2g5ZwFl83z6meVAG1yPTCpeyvrO5O+33bNXD04EoBKJsihchwEOCBoIQjD/LXkMbFKEIHRd+VV546Hohohi35th+/edVbUk6RHfjRaCEZ+DNa2DtDhCQCy0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dsmAemKLBepqIFLpbi7QqiN71/oou0kW9bQDNJOT6U=;
 b=fWi9MUvEoTu5mIyZAzT7RTS7ekPcRqup4DrXJ6xPKywDZvtloDlyagbiPFLQ8baLM94GcpoNmOYj7RcqQbQAEiNjsxJet2jYR7SiSCWU8oC/K0sMUkK/jlkvg1+3lfTWiE3+Qr6dGdihA5GC4Gd9d5tkZVqt/4fDmnGXZkMzpt7VfcHMgQ/UC99FZBFQfZCBkb4GG+a2U0R29krxsjhuOrlXXnxt9h06cSSsyjEsg9iFaubyLFnTUlFroh5UvAK1A+euCnXWcn1MM3roGrHUC1FfjJRN4EtcoisrVxcIeDiqiON4WhvGVCD6n9FUOKk+N24+/xyK4oJzNXkKlXo2pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 10:42:14 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 10:42:14 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v3 1/1] Enhanced or Legacy Accept Synchronous Connection Request command
Date: Mon, 29 Dec 2025 16:16:30 +0530
Message-Id: <20251229104630.2734644-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251229104630.2734644-1-mahesh.talewad@nxp.com>
References: <20251229104630.2734644-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf2895e-92d7-4b9f-360e-08de46c6ede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3yEWxbefZvf9ZcDzIis2LMBH98qLVvxGu3fowgwSyODGQ36HDFL3APXGBzc?=
 =?us-ascii?Q?8TTdcBkoTzo7Ji2xjI0Fa1l4VaVVUiLo5Lojw8rcvPgmhb43DBC5GUGX2IY+?=
 =?us-ascii?Q?RGk8c4WtspniDJtwRp1lJ5siPwHjj7xoRTnBPeo2C+XDWanvY1iqsn+VMztp?=
 =?us-ascii?Q?Gvn6K+NrBzarPKOthEhJWy21vsglwtecgalWk8UH0wKzBNGh7ryT9tT9JH4p?=
 =?us-ascii?Q?9RUH3c/xedEFVEGRCbRKPuBcpm0lQCY5hqJwM0cP/FKgPLv+1IXnIQ+sbDej?=
 =?us-ascii?Q?wBMmP6rScsKemDRQanE6aeyQjtaNN+o4w+NIktcQQLQTAc1xBLTMCFUUhy+J?=
 =?us-ascii?Q?gsa1cZUPpLLqA6K7k86uvCkCmLunQTJ+kHE2hhf4HXn4T6SsibYHLcG+8r3B?=
 =?us-ascii?Q?rTkqhw0Dz/aJtrHK+UcrOXrcs5T1rsZvMcE1Tk03THcMkpsRm/3V6kk3eLTD?=
 =?us-ascii?Q?DH+D8rRHt4v5hyZbxDICe7S9wijHIJ9enbF3/N8TfxDS0zRTZFn5a2odDLxY?=
 =?us-ascii?Q?fP8BUrKIOrXjdUK+//q4K1D9T/d9fnWqnEP6OuYAm/J381zOMvWPR5vgv4TQ?=
 =?us-ascii?Q?X0iGuAbZsbYGH4SQ/mhzc3IfdgNK8Luc9NrRm7vNL87p1pCJFJ5a6v8Gp0KC?=
 =?us-ascii?Q?M2vX97F8btKbTvGTzwsM7zIYmCxYW1y5ocmeUHj7jR0vz3984muncLuEoCHh?=
 =?us-ascii?Q?XZF+R6hN/aRFkCDm2Y+dUQW3KM8vKzNSg7VyTAIBMonVXTHz6+jOV4WWFX1i?=
 =?us-ascii?Q?/6mJQu9wBEruHxofBKeKQoymNMRB1O1vseYFZzPCAk3+C72J+SOvWmt6PWfr?=
 =?us-ascii?Q?ABujVBQ+Tpg4rU5YkNNSSyZUdtJF4G1sSdmLTOWXkzn9uJCGOt6HTEgDd1TC?=
 =?us-ascii?Q?+EHPnZd1saWrvRDmnEQxULo+RAzIRvXMG5JNYbA5qoxFNrPKlZbtDmo2G64r?=
 =?us-ascii?Q?LsCIGCp/rPYGy4FRCGZ0/I2/ugMViz4oYvnZk4qCJhoJshWbwN4soBw9Fbbt?=
 =?us-ascii?Q?wCh/9TkZVmOMMoqEw2FoMn8tlMFuRePsueg572fDfuf/Fs+PKnqRaK7ujqDh?=
 =?us-ascii?Q?/4TP89dYFjaEP1OTLc1j/A2xrK3iCK/qZidBZZTK3x0xNY3euqJYSH2XATp3?=
 =?us-ascii?Q?sum/wjK8kUJ19EBuVnwuJ1ubAAVUDJTgS+akZaeq5YPzVaHd51ItWAI/gi3k?=
 =?us-ascii?Q?NahOp4UBx+fkDwMpCxDkJNQCUtLVAo6LPArzTWppzcwbAuTs3AvA3h+HFmou?=
 =?us-ascii?Q?BSMu6NNW9qmARsKD0hg8jw0qnj2QjpJHjVV3YL3F5WxqBb84o/MYyjR1Knxw?=
 =?us-ascii?Q?tCNnwAbwwuLz1PhKI0QpHmCzPdTzCetVBPv8JxECmrfxegCONgW5Z9k85t+X?=
 =?us-ascii?Q?VjyTenwgA1BolHXxg3TdM9euC3pQgEwSuSJ1sxXm735joQ/FZ3Sm53VPjFnr?=
 =?us-ascii?Q?bJ9x0fSJElL+2wIMgwQt4udEiPNSceZ/XCxV0PLn5i58wTJMUliwzJHCR6Z8?=
 =?us-ascii?Q?heBm5x60lIVMbgOn6oQap8OvUjSH2rteC18D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebc01AwKjti2sUAwyKUG+aURP1MlwQpTNMB93aMFZXEwJrS5GAwT5Oy33LSf?=
 =?us-ascii?Q?Q+qJzhZLqP9f/xqomgn/DYorppU6//IX8O4xPSM9kZ1w3ztOFFI3DL7tEnTh?=
 =?us-ascii?Q?91bgS5E7q7nZCGMSRP5EoIZ5MtxRPJyge/rEHueM3EYyRHZrylVGoHnPQPvt?=
 =?us-ascii?Q?UGJ6q24OJs6SWizLic2gemdj7in6MSka0dRerOqGI6/6YJYJzuFWLMIbL/ew?=
 =?us-ascii?Q?UxxN/aikmNeEIsT14zb8sbwht4zoyLXSKWkEmoYqmPJjiBx0j8040A8QwVcC?=
 =?us-ascii?Q?MtsfMCowwJ10Ut/aLtpJB21pEeKD2kJPbHVw/YrBlBEz8cyqM74mOxfpCcxk?=
 =?us-ascii?Q?ayVUZ4NJU4N4AasGA/XjH7Z48ZG8BoPc1mZT7ByAWNOvSNyO19js8ghcZbSa?=
 =?us-ascii?Q?pXIkkWco6zMB0JlGDWdRByaGNkFA8HQIu1QqmNUNhjtUP2Ez1a8CQbiMCvUK?=
 =?us-ascii?Q?mX6YKeZGwAV7a6b0dEPy6mtZYemZYkSGcOos+R0rDJtIamGIDajlTlHfUqWK?=
 =?us-ascii?Q?wkWWe13H5w1dzdl2DhNZfvhVaktRontKYYk6LS/b7ukj6TXC9bern+cUuPHn?=
 =?us-ascii?Q?OBy/zjXIfkRaIZ26f6Xm6qMeW8phH/dMAZEvJiKnmbwds5lghZlibwxtU3yy?=
 =?us-ascii?Q?ULmoDmBegogPsiFAr8bpzvC1Pg2NelIjNZV4L7ha5oo3MLx6MT1OXnTtWE71?=
 =?us-ascii?Q?tY4s7pgCY3g6uirbgZQcLSoPMEVyiyLqvHttCnurMEDUhtvGGPdrOj6cVFKx?=
 =?us-ascii?Q?p/pZt18OZtkvVLQ7BhVBPCuPbSyRBX6Vk9tTL637GOzDVcS+QEzPzfImeMjt?=
 =?us-ascii?Q?Sdj8KzvmHRo3w0cvU5lGg/5pPIyUOISQaLlyOIm8M/prFtlzkFw1ry/mVqTZ?=
 =?us-ascii?Q?2WYp4G6T+LdVJP993p/M8+XjxKOGgom7o7h9D/YW6EHoFDy/Pk++D+4E+sMc?=
 =?us-ascii?Q?XOhTQ6mjIyTtIEecVcf8KIYOJuce4wf3Df/n3XZz7e4jCSkXYSs0jkvblwI3?=
 =?us-ascii?Q?nq4sMyyaBveN9lDT7PgQ9A+NI3+3B12J12xtr8uuL2YlKS1tZBE8PrEdJwPj?=
 =?us-ascii?Q?1QPfhN9X8T2tzXNLlX15PjIeNfrrVt0ISra2l1WeYjKfZ/6+P0nkv19TVKpy?=
 =?us-ascii?Q?Nlmsl8/TlffIgjSocthRbN1AqcK9Q6QDVvArDUd3ytsOzlS8/SwgnzX/MpDK?=
 =?us-ascii?Q?WAZTppXoVVVjDnTrs6yJFb5YYDsMY6A5ISqAst8RiCssnEQNxLMPSetfSMMH?=
 =?us-ascii?Q?EaiNPKB18mRnze62JqQHnSPUPY7U6DtLuvuwd1/x+NQmwje2nC0Jfl+2IKth?=
 =?us-ascii?Q?D37FjrsZOCU3gfZ//URcgacDG5bkH5heBQS4rSp/bQH97eEBuUpiU78grM05?=
 =?us-ascii?Q?fzb5Q2JfUcZgMTI3k4DJOGzyTWw7Gx6en8vZ9GjNE6mKjXDjeWYPlhPF0kMZ?=
 =?us-ascii?Q?Ugk7REWrdgt4PUeCxuK3tRZq7JQStyA96rnUffis6LhGZBIXsIWASF8VlOlC?=
 =?us-ascii?Q?RPoXjP0rH8yPYZ+Da8ienxeIScms8SaGA1GKC52K6gAqQGFVmQizVXOO/6i1?=
 =?us-ascii?Q?cvljEYc6p/g81jtnWMl56NiDuoqSmSef4IySxQCJEGGKkPKx4dUON2x70Y9o?=
 =?us-ascii?Q?SpDLhY0AvVn+vBPQZM0u14jUq54EPwcNbFUkJF9bASHWPYEpfJIEw3McuCe/?=
 =?us-ascii?Q?Keaer3BLWdO1MSOPpWKM+jnLl0CfVOpiMnY8FQTyDovHMZVi7vfjizXLVvLZ?=
 =?us-ascii?Q?Ukl5bTMZNg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf2895e-92d7-4b9f-360e-08de46c6ede2
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:42:14.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6KdvPfb2z3dvzOBytwUUXE66KyBmQKZt/1AiEJkcuPEqtZzwYtYDNtHi/PW08/dEEgVTtAfUZ53wDHPyWiWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

In current implementaion kernel is sending legacy sco command
['Accept Synchronous Connection Request command'] always even
though controller supports enhanced synchronous connection
command.

In this commit, we have implemented the code in such a way that
when Connect request for eSco is received, if controller supports
enhanced synchronous connection command then it will go for
'Enhanced Accept Synchronous Connection Request command' or else
it will go for legacy command['Accept Synchronous Connection
Request command'].

btmon trace:
> HCI Event: Connect Request (0x04) plen 10
		Address: 10:EC:81:61:71:67
		Class: 0x000000
		  Major class: Miscellaneous
		  Minor class: 0x00
		Link type: eSCO (0x02)
< HCI Command: Enhanced Accept Synchronous Connection
Request (0x01|0x003e) plen 63
		Address: 10:EC:81:61:71:67
		Transmit bandwidth: 8000
		Receive bandwidth: 8000
		Transmit Coding Format:
		  Codec: mSBC (0x05)
		Receive Coding Format:
		  Codec: mSBC (0x05)
		Transmit Codec Frame Size: 60
		Receive Codec Frame Size: 60
		Input Coding Format:
		  Codec: Linear PCM (0x04)
		Output Coding Format:
		  Codec: Linear PCM (0x04)
		Input Coded Data Size: 16
		Output Coded Data Size: 16
		Input PCM Data Format: 2's complement
		Output PCM Data Format: 2's complement
		Input PCM Sample Payload MSB Position: 0
		Output PCM Sample Payload MSB Position: 0
		Input Data Path: HCI
		Output Data Path: HCI
		Input Transport Unit Size: 1
		Output Transport Unit Size: 1
		Max latency: 13
		Packet type: 0x0380
		  3-EV3 may not be used
		  2-EV5 may not be used
		  3-EV5 may not be used
		Retransmission effort: Optimize for link quality (0x02)
> HCI Event: Command Status (0x0f) plen 4
	  Enhanced Accept Synchronous Connection
Request (0x01|0x003e) ncmd 1
		Status: Success (0x00)
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
		Status: Success (0x00)
		Handle: 8
		Address: 10:EC:81:61:71:67
		Link type: eSCO (0x02)
		Transmission interval: 0x0c
		Retransmission window: 0x04
		RX packet length: 60
		TX packet length: 60
		Air mode: Transparent (0x03)

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 include/net/bluetooth/hci.h      | 34 ++++++++++++++
 include/net/bluetooth/hci_sync.h |  9 ++++
 net/bluetooth/hci_event.c        | 27 ++++++-----
 net/bluetooth/hci_sync.c         | 78 ++++++++++++++++++++++++++++++++
 net/bluetooth/sco.c              | 34 ++------------
 5 files changed, 141 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index db76c2d1eeaa..accfa36e7f2c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -939,6 +939,40 @@ struct hci_cp_accept_sync_conn_req {
 	__le16   pkt_type;
 } __packed;
 
+#define HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ	0x043E
+struct hci_coding_format_en_accpt_sync {
+	__u8    id;
+	__le16  cid;
+	__le16  vid;
+} __packed;
+
+struct hci_cp_enhanced_accept_sync_conn_req {
+	bdaddr_t bdaddr;
+	__le32	tx_bandwidth;
+	__le32	rx_bandwidth;
+	struct	hci_coding_format_en_accpt_sync tx_coding_format;
+	struct	hci_coding_format_en_accpt_sync rx_coding_format;
+	__le16	tx_codec_frame_size;
+	__le16	rx_codec_frame_size;
+	__le32	in_bandwidth;
+	__le32	out_bandwidth;
+	struct	hci_coding_format_en_accpt_sync in_coding_format;
+	struct	hci_coding_format_en_accpt_sync out_coding_format;
+	__le16	in_coded_data_size;
+	__le16	out_coded_data_size;
+	__u8	in_pcm_data_format;
+	__u8	out_pcm_data_format;
+	__u8	in_pcm_sample_payload_msb_pos;
+	__u8	out_pcm_sample_payload_msb_pos;
+	__u8	in_data_path;
+	__u8	out_data_path;
+	__u8	in_transport_unit_size;
+	__u8	out_transport_unit_size;
+	__le16	max_latency;
+	__le16	pkt_type;
+	__u8	retrans_effort;
+} __packed;
+
 #define HCI_OP_REJECT_SYNC_CONN_REQ	0x042a
 struct hci_cp_reject_sync_conn_req {
 	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 73e494b2591d..c739fc6a3d9e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -194,3 +194,12 @@ int hci_le_read_remote_features(struct hci_conn *conn);
 
 int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type);
 int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys);
+
+struct esco_params {
+	u16 pkt_type;
+	u16 max_latency;
+	u8  retrans_effort;
+};
+
+void hci_cmd_accept_sync_conn_req(struct hci_conn *conn, u16 setting);
+void hci_cmd_enhanced_accept_sync_conn_req(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 467710a42d45..7b1bfdea6715 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3347,20 +3347,25 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else if (!(flags & HCI_PROTO_DEFER)) {
-		struct hci_cp_accept_sync_conn_req cp;
-		conn->state = BT_CONNECT;
+		if (!enhanced_sync_conn_capable(hdev)) {
+			struct hci_cp_accept_sync_conn_req cp;
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
+			conn->state = BT_CONNECT;
+
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
-		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.max_latency    = cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+			cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.max_latency    = cpu_to_le16(0xffff);
+			cp.content_format = cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
 
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp),
-			     &cp);
+			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			conn->state = BT_CONNECT;
+			hci_cmd_enhanced_accept_sync_conn_req(conn);
+		}
 	} else {
 		conn->state = BT_CONNECT2;
 		hci_connect_cfm(conn, 0);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab0b68faa61c..8e23ac585c2c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7519,3 +7519,81 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 	return hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
 				       le_phy_update_complete);
 }
+
+void hci_cmd_accept_sync_conn_req(struct hci_conn *conn, u16 setting)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_accept_sync_conn_req cp;
+
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.content_format = cpu_to_le16(setting);
+
+	switch (setting & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		if (conn->pkt_type & ESCO_2EV3)
+			cp.max_latency = cpu_to_le16(0x0008);
+		else
+			cp.max_latency = cpu_to_le16(0x000D);
+		cp.retrans_effort = 0x02;
+		break;
+	case SCO_AIRMODE_CVSD:
+		cp.max_latency = cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+		break;
+	default:
+		/* use CVSD settings as fallback */
+		cp.max_latency = cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+		break;
+	}
+
+	hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+}
+
+static const struct esco_params esco_params_msbc[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,   0x02 }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,   0x02 }, /* T1 */
+};
+
+void hci_cmd_enhanced_accept_sync_conn_req(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_enhanced_accept_sync_conn_req cp;
+	const struct esco_params *param;
+
+	memset(&cp, 0x00, sizeof(cp));
+
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.tx_coding_format.id = 0x05;
+	cp.rx_coding_format.id = 0x05;
+	cp.tx_codec_frame_size = __cpu_to_le16(60);
+	cp.rx_codec_frame_size = __cpu_to_le16(60);
+	cp.in_bandwidth = __cpu_to_le32(32000);
+	cp.out_bandwidth = __cpu_to_le32(32000);
+	cp.in_coding_format.id = 0x04;
+	cp.out_coding_format.id = 0x04;
+	cp.in_coded_data_size = __cpu_to_le16(16);
+	cp.out_coded_data_size = __cpu_to_le16(16);
+	cp.in_pcm_data_format = 2;
+	cp.out_pcm_data_format = 2;
+	cp.in_pcm_sample_payload_msb_pos = 0;
+	cp.out_pcm_sample_payload_msb_pos = 0;
+	cp.in_data_path = conn->codec.data_path;
+	cp.out_data_path = conn->codec.data_path;
+	cp.in_transport_unit_size = 1;
+	cp.out_transport_unit_size = 1;
+
+	param = &esco_params_msbc[conn->attempt];
+
+	cp.max_latency = __cpu_to_le16(param->max_latency);
+	cp.pkt_type = __cpu_to_le16(param->pkt_type);
+	cp.retrans_effort = param->retrans_effort;
+
+	hci_send_cmd(hdev, HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 87ba90336e80..278b611d6e20 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -847,36 +847,10 @@ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else {
-		struct hci_cp_accept_sync_conn_req cp;
-
-		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
-
-		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.content_format = cpu_to_le16(setting);
-
-		switch (setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_TRANSP:
-			if (conn->pkt_type & ESCO_2EV3)
-				cp.max_latency = cpu_to_le16(0x0008);
-			else
-				cp.max_latency = cpu_to_le16(0x000D);
-			cp.retrans_effort = 0x02;
-			break;
-		case SCO_AIRMODE_CVSD:
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
-		default:
-			/* use CVSD settings as fallback */
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
-		}
-
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
-			     sizeof(cp), &cp);
+		if (!enhanced_sync_conn_capable(hdev))
+			hci_cmd_accept_sync_conn_req(conn, setting);
+		else
+			hci_cmd_enhanced_accept_sync_conn_req(conn);
 	}
 }
 
-- 
2.34.1

