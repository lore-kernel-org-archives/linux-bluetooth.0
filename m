Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D81B85E2
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315344; cv=fail; b=G7p4luvwLKAlRo0dmBkr3oJpS2PkUE8T9+pnUsJh1tBRU97RBNbIbm7Arkj6tqI5vKFRGoh5aOE5qfRb6NDAqZhKW2gcx/7cTPbqB4BBsMYD73zbtEekAmJYGcYKEtHNleh1TLyY/3tfxGwFtHgTv+okN7huF18t9ihgam/pycg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315344; c=relaxed/simple;
	bh=SkoqDtaDENTZTUmqzKW+PnB0j/wTz9w/pQfPCVloMF0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eJdp6yhMTTE5uB4Np0qgo5M3QW296GYgR8OND+XykKW6d6lD+mW+VESNJRzgTeJKjmNJoA/PiySJeda1uekEbDDEg4jmzN4Co5BkU4RfTgZO3DzLLFEOVa49l3GvxbA9eDmbTwjEImi0+boY1qOopH57M5FIvZJrHXAsPGJFDi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTlBs5Z9; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTlBs5Z9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkqOvaYfztXBEKxVn/fVZm9ikuvvqDqRQtP3XVfWXtoxkQqbuEbw5bKQPk9NKJ1oXahxwsisDwQ9I3C7MHa9NJZ5a2rZp2SVcjNFTBQsVtP4ZwgmxTBtvcGCfIxiloTEAeHJCjmKMr0vzxikkW60m6Uq25NVoXFr1KRHrRIZ28Y9gIru9em0jyiu4bnTr2wFZg/0s/zQTY/aqPODflavMYpkTrAljK1+4TAXliwIJrUHj8QnE3mSR6O5kxeO9PbEXx7uJI2pZ2cPpP1nbgJ73YBAhoO/hy861XVfXHuEqHm15JCg96w89cklGtRHbRdfJ0arY2rb22XV19cXp2el0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAAFgOH0GruYWQmEik97QrqVjje/hxoPUylm1RJzrKA=;
 b=YgRedKV/Dbk4e7aQz3BQS4QXaqjuHz1hK7z8Sc5dzURXeDMF2I5PB5zQ0ugUckIoAT6udpTUfjN88cxaSUSPpQnlLtt4xaM9kYFeya+EKgKo8ACe1OPwbp+ztJuVK6N/ly0NifSLsKBczPfDU8Xji+bXXCjy3S1Z2XbRQWjBQXmofeGNNnblEKPepewTqYY2lhfkkRaEkqpc74u2MGOrOJJiR1Fk3l53iXOH1wm9jNsOtynsMpSkhzqzhneeEO3M9VElDE8hrG4S+IVN8fCe6+o7DC69Z0p6nUbU8d4xWPDay2Qb7Bdpq49seNTjEycCI75GZz5ZxwmUBIoghezQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAAFgOH0GruYWQmEik97QrqVjje/hxoPUylm1RJzrKA=;
 b=hTlBs5Z9cZY6WLB2wz366r05XxGYc81D7EyrJ83zIcofvW6sWRlOLmWq8cKZcKkCVWY6AArsthaJW78L/twNzxrVFOIOWKWnYcvwTmyRjsxjhLfVDEBG1baN5klZLbibTcQx1mQ7jpxzHRcpk0xlzWKJytmx6wI4Brrmt/D6gpSlq3slYW26f4hxAur555EIMoTFgF5whB4Kc7XgownZw5EeN20hrdJi86RL0z6cIXKNrNx6yuOAxotclIpQHb87gwoRLtj+LWoQlW5opg+kqhWos8qVOBHYJnFtEY+izrZAEeDimN5VdaLF4aLmZluJ8poju8ZKGD+7FhcHv8gJ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 4 Dec
 2024 12:28:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 12:28:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/3] Bluetooth: iso: Fix warnings
Date: Wed,  4 Dec 2024 14:28:46 +0200
Message-ID: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0041.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ff1f5d-f0e8-424e-1e07-08dd145f38cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLHYIvLtOZe8ZqNJWfZD/9vphqJfLxFCflivZo9Y8PGAcORyIRzZX09UV4MO?=
 =?us-ascii?Q?v/AFJFGHJlmXGCIgnJ0Umi0kzXb4es4yIWpZrmqZQkCfRbMYgIcO2tXhgeNv?=
 =?us-ascii?Q?NbgRCpmvlvBy7S6zppa6LjqJj0rIVLBDasn/ufivf5yaSxVqk0Vmp/xdQwWI?=
 =?us-ascii?Q?JjLQcWji0bGvp/XXv2c/DRdVF7XkwQ6OYQAbZyUit6/CfGBzdhA6+IHMGoUo?=
 =?us-ascii?Q?fVVohyApXwJvFnc3klSR/qdv5f6viZaFFB2nr3YyZ9S81CdUigG36n1JSy2C?=
 =?us-ascii?Q?fkS9tQykVusMV5p7a1fVZtrC2r2skKRT6hB8q6f+qJGAJODENNQw4a6F64q5?=
 =?us-ascii?Q?Eb66Y5W8xqXdUAzsYHoPHimKMBrEY2UIyviVb9Bv6xoRLcOc3/tGTRzuTJIt?=
 =?us-ascii?Q?2Q/lr2XWG1EcK8qxHBS0ba/wKWXQfDtntz/xiPnQfUxAjH1jc5HhrShxIQBs?=
 =?us-ascii?Q?mAC/6NFhM4tgBdIfjM5r8zCzdGM3ypNwlqYcHTDUcirN/CJIOiqnjqbRpDxZ?=
 =?us-ascii?Q?C6RYF5Dd9XHEJFqEFqmBYeGfXxO/TTqfuAuMrvyxoBOq9ebMEtL4VY0m1FPX?=
 =?us-ascii?Q?OouNlBWXLX4xUYvn++bk7rdARjYYLkMXUs8gr/jWUtGAlOS/e8OYs8b5GQNu?=
 =?us-ascii?Q?BuDY9VP0t4QI9R8PtYOXPHgIP9seOOvjXrzblJC8D4SYnTNzU341ss7LeOzs?=
 =?us-ascii?Q?wSMfOoYAzzXE27IzVf2/4nlxLnK/6vKbE2HBGprRncCG1vgPbIFVf5gmE/TV?=
 =?us-ascii?Q?ZDaFv+gl3FM4dO0WNhYVkZeJZcVUdkgcS9RKYDTyBRCwURO+K7W9vraTbzEN?=
 =?us-ascii?Q?Osq14KSi6sP4CqafH3CpPDHZpO99Sa2ySLCkyE7rUUV1shsy8GLz1B9jJRH/?=
 =?us-ascii?Q?TayphsO2nYoUtujN8gHnf0ki0ex3whAQPN4g00YU05t8ZGj1ANXRLMObus4C?=
 =?us-ascii?Q?SxcupEKTnmYQtfiN9zuWFfhsUrYok4cIkx00dGDpv+KLl9+pN61qFn6Qh0yy?=
 =?us-ascii?Q?Uv5SQtEGfctyOZvv3d7ilQwPN2G7Ox84I9iypMJAHva4bBKurjOzkADWOmfY?=
 =?us-ascii?Q?Ufitp9YLaW6hFkcr0ANv++CjgdWfqiCvjqIKHHuJaaZPJANZNKNz+EmzF1il?=
 =?us-ascii?Q?2FN+n+CpAvVRoTnWGBcU/SvfHDWqUq5Uv4eSSr3B/xLuJAt+YUeUhbuBxymv?=
 =?us-ascii?Q?/OwBSGC/bAfuPGb7Bb5Smq5ibWkrmwLBaX1pBXrVI7vH/FqC3cIBoPOsP7cr?=
 =?us-ascii?Q?NOQIDBt46A1BpEcMrBlJmfxv8l2RNH9HuBR2fHy7gf4hFGr0EJVNK8dnuEUY?=
 =?us-ascii?Q?Haw+DLP0yxfHREvN2LAB03hNX2xNAQzCcZLshOsG+M9Q4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0T/wubgT/q6O/NX7lNQVvVDhEiUIAvNHRhoN+2lFRic7mev/1PiNrf4kznh4?=
 =?us-ascii?Q?u1aNIG39FPAII5WivypSnCBHN3ZXERrObWekPlpJFZhfpYnd5ow3zXvov/SS?=
 =?us-ascii?Q?fzAxfwDhDNYKPH+Ss/uekl4ou0/Z6VezDZguLcMe0pHaMv9jY+kUBVl3sdve?=
 =?us-ascii?Q?1WKCzpLErG9ZWTFQ4a//dKKafXcxJa2nvOs94rAFlVOBGiy+J3qalqeC9EZK?=
 =?us-ascii?Q?NPY5MB4hCQb0gunuRdYpOqC1ON3AbdFt3PW0nISitid9n9Ajb1fcD169x7af?=
 =?us-ascii?Q?yrMGdzdBG/f7Ue3VGiRRyKtgFZmOjbS/3NlErABuNZk0D+7yTQ7dwtSttnkm?=
 =?us-ascii?Q?8fSo4ILd7FHrLbu2PCJE6QB7D43N1mNbHBkZQpeIq7QBaN5bI4l8QuV5c0yq?=
 =?us-ascii?Q?EcWBmUS7uf6yuAQ9mOb35xyxVYwoWh9Xq7X9UMjl0z/ikB2yB9G4VY1khjQ6?=
 =?us-ascii?Q?13+ZuvWwAY2qZ8s8O4AJHszIgFjvXkxNoDXuz4r9RvwQPWvX+0VWwmo6O7ow?=
 =?us-ascii?Q?g9ekOEi/2SPOA7/YC88FI84HuckxpPmPjkzaZHR83jO8gc2jfskTL34nmCF6?=
 =?us-ascii?Q?QesSly873bF4Sq0Wnvpw1xtYLO0QGxa7mFP+H4TmgfJXnsK/bLCswaaHwOUG?=
 =?us-ascii?Q?8WljdgfbRdrwTLnt5Llioec2t4cM0T187IoU2tO7cN+8Oqa9bfjH+za+9dJ4?=
 =?us-ascii?Q?IvOiPP/t6Ddk+a1rW0upOvv9DkQQyQP1zRcQfHx8TH/++Gk5OowEBaXdbjKb?=
 =?us-ascii?Q?q1FxAz4e2YrBKu0DotpnafG/9wL+H5HCu4tiVI2GI0s33NMPgdbuhK+0GKE3?=
 =?us-ascii?Q?F7GPMBP7JAqHx/WTFZ0sHRy09ZamcUGRw9HpMvv0T8tkQzslUvtsrgK20VYI?=
 =?us-ascii?Q?ugiaZMK9253EfUlyK/bEav+Xvrv+2F18RSbQ72osaCDEGCtMFNBdzLfeCILV?=
 =?us-ascii?Q?eo0eCBat/3xFsBm6IYcPeYMKQml76umCtSyq9SvxvKfRYQAKnMRUFptbuHCb?=
 =?us-ascii?Q?wTbtYXksdZ9OKt0a2yTSPEY8klJacdzpZi2UXNZWoAX4MsGaaV8sADdXlIA6?=
 =?us-ascii?Q?yhCz0NHKWnIJwLLONRG7C312hJY3HKV3+8iz57vKdTKij6CifBQEaGdeMzL8?=
 =?us-ascii?Q?xAdFCU4hceovT5dBq3tcTLOBYjwkk6fZM04sUF4EMhdpNQ5xesnWjrQ9lfQv?=
 =?us-ascii?Q?PBmhnyIJi1sd48LuQA3jyj5+SmCSyrMkNf6OvaImqIxvh3gcgd3a/pHUDUJK?=
 =?us-ascii?Q?KIian+ZPZgLJb9EFjQW6LslLf8fVV7sWctuFPp6+I2HfVexVK2zGCH6FINb8?=
 =?us-ascii?Q?G66Rha4B+J/6iz9bMlrV282hoen9p2p3Dh4xVSevolJw+igJ7yjvp3+C/wgB?=
 =?us-ascii?Q?Zu6Ym7QqncLhv0jpv4w1/zwunmx+F+M61+Q5qrnKAkz3MrIuLwKhYgyVvCYa?=
 =?us-ascii?Q?Cd31l1ry5RIk6w5ib6q0ZidkjQMti92IvJ8Vsk3FIxP4VCfSgV0vciJTmbq/?=
 =?us-ascii?Q?25yK2mcSYKjoH/ws80PH374jpGGgTxRPC494G8KpEyw2AdSL3mbaLmV2oPwy?=
 =?us-ascii?Q?z9211mGeyWuS5HCsBXx8RyTJt2X3xvZqcA52ZqlX3R1WYo/mJdVr13mTc5El?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ff1f5d-f0e8-424e-1e07-08dd145f38cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:28:56.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYhRjAmSgCe+3bVRfY3IucLDAia+IuMdr5tamJ0QiWcrOCcr9yOZbi5tnkfA9rMSPYlJyN32CGbaoppvMfiyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431

This adds some fixes for locking related warnings in the ISO module.

Iulia Tanasescu (3):
  Bluetooth: iso: Fix circular locking dependency warnings
  Bluetooth: iso: Always release hdev at the end of iso_listen_bis
  Bluetooth: iso: Fix recursive locking warning

 net/bluetooth/iso.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)


base-commit: 47ebf099106eb021cf7dd677720e6469a38785a5
-- 
2.40.1

