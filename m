Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A394
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305240; cv=fail; b=duL5ftzSq1lv8qTOfVfDddVvgXcLD2vaz0MNjEzXZPqdu2iZF1R07+nUKvpAKAqCh1LvuOZKnlcIwSJkOcwsBo7sBNar/2FR2AXFJbtm1cO8+J6WJE8hcJZI/aJcnfEpuHKeLpuqhma3kAxUSjU3SGYy1I0LHLoBizRaiR0MK2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305240; c=relaxed/simple;
	bh=rH1pzy/akupC9mKArPJGxqQ9bPfcXvPT5V/4GmdQVOg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GpLSKUtoL+klWdngzom3I5o+vcIrSYnBOnfNfpYMUwY85Nj4/ZsZtHJQ7Embr7y0Jba6iIPzE+nABYtIkBDSGJgfxFENOCOnlEj8lRQHU39aTjiGFd5R1mI6g2GbEJSRgUa92zszBzN6aZ9BF6JChb8J+f0pPckhg3HgQaWxtuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=loevkaDH; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="loevkaDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWiP+LTALJK99Ova3V7UhU69GFfvS3RZGy1mISiqj+9+ZSHCe51ak5M69p99r95Vml6utWV87rFaQoTvadRVji7ULm/1TF6OLQmmAOv9knqDZzz5aKVFqCjttIShb7NQ/ezDtnll1rSejBtBm5mNG+mST/PLgDAWulfL/rMf1/MK80CYL9AejOMMyASe0XCjYvv05cMSqRdsezbjqHxYw+hZeDARlBVq7lR7eRadfG+ERrsBHUigQz/t4TOrUB9MQffBTUzYDDKvzb0Njpsd79ergkSal3dHfAxhsRG2FkCbigx9VHlDtHeROmWVguhDrKNS2+mCJZpf2+T51uC4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KucIjK+Bc/nBADDEMTrod9VHKHXkJ0UV4DnB/wC5/Dw=;
 b=fT8thPofOAkokSaYFQUSvPHCFqbX3g28Sto79ox85NFr6YjYo7Hv1+wn0cZoC2K7ZFE2BgmbMYJtGKQHWTasoe94ox4i1Ekdnn8mxmQPdlPbg8UZn3U2h047eYT0ecE5KSZB6cc5RIkABAoObfvrW0Y3H0Msgd9JPWy41AhNV1wl1BVvwuYhsblQzRqRDIX4DX5vLXeUiZ8UMEMT8Ebns7kB8WdhpomV07KVzB+hoLAOiECkyWmOsFteTw2hQo1GFWazer21p+nJM+43+bOsm0qoFvbVrAlp0Nz8+9205BZfwBvsC7bhhs5Affrthow8jAXVl/40UoOtXUDOxuS+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KucIjK+Bc/nBADDEMTrod9VHKHXkJ0UV4DnB/wC5/Dw=;
 b=loevkaDHNsQzg8gHkYQMzUCbahNPn6uwY0XW+W6q7+NQmbx8YKHqE4QDurn7D/uAlxKbGPaTvKIXvXjQI6p7mmw6RJw2puInJ8TIui1ll1tcz3LJtSErcAbsKq24NeznIXBEVxTnKN8FsB9zi39247IOFmuOavRQcv8KZgYKfU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:35 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:34 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 0/6] Update Sink BASE management
Date: Fri,  1 Mar 2024 17:00:23 +0200
Message-Id: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::24) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f03dd6-675d-49ae-219c-08dc3a005905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYO3C47flvk1FFwRHFDMs9TwaKIYvcAyKpo/ip39800A8Em3fJCq8Xg8qtGNAtwrtU2AlwfIz46k+CpN0w14lBOuAAO/APYMiNulIDTjQ5EhH4RjldZpKXnd1iAXnBMPyUGt3XLUfEWk/Jv3/U/1jKVcuONfS2uyJ8kq+AE0kNwizEIvvyUP2ANww25lsqoqyv3xZ6pTYu82+QJVmehDKt1ZJd9eR6+h6ofOdAz9x6nKWtSiRfZsSGxJ/CjN5DeiXrQ1m/JkNe3lcUmNzaIBfka412p1Lj2X57JsjUliQ+uldJhPvMcg4DqN7knWfvwUZBuESFsNicMVYTCZ8Rt+QQ+HAPyBokGAMVv/z7IN7NxSTSicXz6M+Fr0fp9wmqyDiU/w2AhqPfUaZXhPkfYGGTurramd7HpyiCcV0UuOhq6ixMOCrGo6lq6GtE6fsil2eXCGX30xfzgADdGPSVblx6fMdF1ALhxiMfbQ0EEHr1O+xWBeiGR4ActOIVL0FNsN8FM0jFPlqGnDwWG3kSePQm6qzGiVSrCMskZUwuWrmCzBWJe89qGDqw5nv0xDaNwUgKEBKa+omtY0BG9fXQW+0LpFf6sagjCU8OZBf9HdUBn0IcQrMDOnXFp2rfn6opPz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLD2cpwDmnQOuzenJ1MEa5c4kIGaaKHCp1ffHAM89zfMNiAgNLA+3oMTaFQW?=
 =?us-ascii?Q?wR7feZu3dEIC3ZwsvLzOdmtDA+RkthqrJzy6X+go+/1oAKd+CBEN8mZ9g7tX?=
 =?us-ascii?Q?wuG4Wui9weBW6E9LzUTvNkkI91z51QeUTaNv1XbYaK3VvIJAdPPsHmfIVguq?=
 =?us-ascii?Q?riuYIfMfhyC1XdXJAECw2KmIcbKYi3xRQBdVHhDOB9OTS3Uevu+r8++sXEOK?=
 =?us-ascii?Q?hLbhX0OtE1LLTQnNa4lKxM7Mqfry7vugBLd9K784O3tRInYnMpsUg9Hm0y3v?=
 =?us-ascii?Q?xKe59/b6cK/0zp7C2rpEUw8wGaBLHh3cZ9IDaYy89cB9M2kd1+lv4XPg1CBR?=
 =?us-ascii?Q?b8lcJk+Ay2/eM0pIT/XmtwysMvz6Pc6/DTUpiwUS/ekVYAq28TjcHXzIjewE?=
 =?us-ascii?Q?JmXPf1x7kny2hhshAOLfpyeUxe85QjDXLPOm7EqXHhOI+vnnqwJzG+DQgdt+?=
 =?us-ascii?Q?aY1n3c+4pdXg6sZqrnF+KPpL+VkKO/fWlqiKLJDoxMfg96wKASNiqZC8Ne5Y?=
 =?us-ascii?Q?cvJ7BFKLpLdC9OCB57c1jyOpxYXA3V14sB7Mdkifloejb3vhjTE08kCqgBM4?=
 =?us-ascii?Q?0Ruhgq0S7ximmaqcyGdMG6yRAKLcYgq+5eMN2hlv7GCpLV0lKzt6YWVYQIuY?=
 =?us-ascii?Q?+M0o5mQaDl0nSM/A/1LWKHaeUZTRjyklW0eRtym2YhTvFtFtqCNcM/4oErhW?=
 =?us-ascii?Q?cjKFQphPYSGDXOuBeRsO4nvBNVL4UnrBEKz5LiC0yOL76wxECyFM+PfhQZ9d?=
 =?us-ascii?Q?Nru3b8gYJVMbNn/FE0KBOEpGqTh2n6l1UJeqIhT/MIx/Sklu0eI/vGZrE3Kh?=
 =?us-ascii?Q?4KISB7rpN0Hu1aPZI53V72rB8tIAgo8BF+jPSmbytRw6IeTRjso7BZ1em90d?=
 =?us-ascii?Q?iUYR/9K3MsvLUCfwHaJCA7ogjOnVNEzd/xMf7lq9AXYeD21+LCri5+gvq6JR?=
 =?us-ascii?Q?kYgTAsfYFUhAuE1Db2ow+Tuc+AnLjN2rUXFJTdI016JXmCKRoK9XAatoRr5f?=
 =?us-ascii?Q?pOgtZl/3sfI1Bzm3YFyh4cq5AGj2RpYid8glEEIqEwK+mb8WMVDtyH/lbOoL?=
 =?us-ascii?Q?pdoIIW+MuSmRrw4k4qevWNAQQrnszg3jBqv3cAP2kFrmar+e+rQ3ter0mc1v?=
 =?us-ascii?Q?u6JUHE8cxqJli5/tKltqaqTl/Y9pkAueiU7V7lYzFOscJqghS/pjIW9FKL3i?=
 =?us-ascii?Q?BOrwuhbJf+cZg+LMi9VKlrfZhgZuQmTuIzN/6ELREaPd+CZBQJEAYv/6/Mid?=
 =?us-ascii?Q?obUu++BVhcN2QxES6+A4pGkr93iGElb4iKOK0FoirTFUbxMk3bZmxlnAyfD9?=
 =?us-ascii?Q?/uPCeM6wMe3kScQI03YHmcyCacEx4JaSfK/rk7fHsHh9FJrac8JubavH4Se5?=
 =?us-ascii?Q?jiJLr4TaNyhg2BWe6Hriehj8UJz0t/CB1+R5fl1qCjMVcSAJbVcqDQOicMCs?=
 =?us-ascii?Q?/g+LPeCJC31FjPCIQyU3EB9eBxizA9WYjDtLW7ivagCDNX0wvxZGrDJoSENK?=
 =?us-ascii?Q?8L1AFZ5/PmlonkXotbJxVSe6ewxx2fAmK0XbeVflisKxfCY9kDpc/E5ZsWHf?=
 =?us-ascii?Q?hAkhLZy4+vHqNHXLU1wV+gZFx4sz7byU7Pcg7dgDLM5y66JiB7SyQTZUCjQH?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f03dd6-675d-49ae-219c-08dc3a005905
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:34.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si22OpC6AAak/R5KpRZXzISTjlL42YN5pQSRAr28eAoriO5w0R/XCdtGULNk1ionvZ/RsNx/JMrzwcwzkW3w4Ts7ToHhWjRwCuK+RuPMAdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch refactors the flow for the BAP Broadcast Sink.
After discovering a new Broadcast Source a short PA Sync will be tried.
Depending on the BASE information present in the PA and the local PACS 
capabilities of the Sink, one remote media endpoint will be created for 
each compatible BIS.
Configuring one of these endpoints results in creating a stream and a 
media transport for the corresponding BIS.

Idle timer.
This patch introduces an idle timer, responsible for processing PA Sync
requests. One request is possible at a time. When a broadcast source is
discovered a new request for short PA sync is enqueued. Also, when a
SetConfiguration is requested for an existing BAP broadcast source
endpoint another request is enqueued.
The timer runs periodically and peeks for requests. In case there is no 
request in progress the timer marks the already peeked request to 
pending and starts processing it. When the request is completed, it is 
removed from the timer's queue, so that the next request can be 
processed.

Andrei Istodorescu (6):
  shared/util: Add push LTV utilitary function
  shared/bap: Allow reading endpoint metadata and data
  shared/bap: Update local PACS for broadcast sink also
  shared/bap: Do stream configuration in bap_bcast_config
  shared/bap: Add API to add an observed BIS
  bap: Do PA Sync for each BAP Broadcast source discovered

 profiles/audio/bap.c | 656 +++++++++++++++++++++++++++----------------
 src/shared/bap.c     | 294 ++++++++++++++++++-
 src/shared/bap.h     |  13 +-
 src/shared/util.c    |  11 +-
 src/shared/util.h    |   4 +-
 5 files changed, 715 insertions(+), 263 deletions(-)


base-commit: 44d3f67277f83983e1e9697eda7b9aeb40ca231d
-- 
2.40.1

