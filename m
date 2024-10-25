Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD61F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858958; cv=fail; b=d8ho0EXDkjLmTJngseFpt57rFvxwy6pojrN7ruzdpTa/l9YvbdQfyN0Ewvbv8MCJMrFCA3GNCsCFI+TYDIHtK6R/RaR4537pDtNfUOoICO08sVJRIAh05f23bXF3h1tllXFzLwJSzt8fBK3pMyMvSkgSTzfBx1PGU4ym/5ZnAhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858958; c=relaxed/simple;
	bh=RBkN4v8HbOrapJSD7ZWet5Tdlo6IkOvkm2+1rTmxx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uz7OrHolCPtN/Iv7nvsZH1EcLhDXUR7BGWC6q7CpPjPfV98sJk+U+I9apefKJ+C1GN4kmM4ifOWeGqh221g7za88k0G5Xvzvwty41CVbdDR3px1Bmy4OYsW/lfx9R0ziHQuZC8ApWH8jiYaCVcuU9wIeI8ymvbXvmF694CxtTo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U9IXOfsU; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9IXOfsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3wBftEUpuQgqEwp6gEXHTUlbxvncxT9Ns/2a9BDhNhZVR2AbdmKVsHeqTR7i2E6rLNGlbcm/234h0CDe1bs9o5C41TGBNCDpwnxKacNN9fMGGjr1Iv6+GIwGVPYiSk0zg6AEJTzeI5ukCANyZVwOBxPjtkUsyz+7+5FNPx7oU25AkDSA2fAAziW4iKYKFkurTwvgosgNGaTwXHll8SH1QRL3QhESn75IZAJS2V2Cq/hpZdgqxXFsJ/zjzqHBNGr68JrF/9SnqykQQ6PQWNUqCcSo2VAkF+8fgYgLCJteAybCdK6C7ub+had9qzst1dfxT0IcGpzFGcTRKWfwI5s1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW2MlkTctZWRz39nmD/nTbjenO9cNqJ5OKsAgyabizQ=;
 b=IpQ+a7FTxwXEmDk8ydX4w5SATTllnNa8ND3u0jOE4m6eGYD3dfSUL29E0udLaVdyykezgFUSd9Al3sjZzKYHic54hIlr3sqIYXXba9UrbjQK1RVqDeywNjneKOlM+3YikUF2uW5QN8ghlVWfnECk4jdAaLifdNy+1DnYNW3mE8f4YMwPeE9rOoej6Fk4bv+PmA2AvDktV6Fs/Z01eysmk1CS04H/RMVsI7mknHuELW9XpugyUErux14BSryJ6ec258dWxkayVTlcVWPLIpXvWP7rrglloW6EMEHC8BV1dFseOpQcm0V/f0IExBJlpTvNXZsHrQFYa6kqdp1yU+GbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW2MlkTctZWRz39nmD/nTbjenO9cNqJ5OKsAgyabizQ=;
 b=U9IXOfsU94yKzK2S8p0NNsmwE1po5/PXFMhWth9T+bZoATBHDOD/v43lBD820JRivbZ39+GqJeXMNWkylLSNaArUjwholuuA1tLDQRst9virTSvfCVV7HyXh/OvJkUI2YSWh9jvz5JcRv5L/xhsirTlmezQXNLYc4HT7MF7VCmGJuqpQcgXm+m6vj9uPY4JDofcTKYca3/rUshMOYm1bpjUjS0wevxhVbA0y+yNhVW4OqQt8fWaKmpBA9q0aiKqr2Z8YrZnVJJ6G05aTDniQMW0SuV0tL+AUOQ3JZu+IxY825dt2MBbkPmgeVvkiDfAm5+xGzF6cctOxOtlETsz2Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:27 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:27 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 07/14] transport: Unset transport owner before owner free
Date: Fri, 25 Oct 2024 15:21:39 +0300
Message-ID: <20241025122146.17925-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c344a5-6411-48af-38e6-08dcf4efb05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0hoItHEVn6qfQutj9ZA9WjPmKRcwkgKCwswLd+4karkRBB96muwz8ndhCE2?=
 =?us-ascii?Q?9d+B/s8fysl6W9D0cyYvfWtVlKTJVxt209sCTX9S2Dz+jsV/ijKtL3TD8xkc?=
 =?us-ascii?Q?jJR1HcI4YxyVUQMfpdy1CLFjdAb1+iKOo05SLyjMZJPW3/EwMgB8pwNYoAGY?=
 =?us-ascii?Q?4LBF68qOY450buE0lagpMDOVyOyih2lvXwVdhg0ckTKT9vrv3RnRVRrldw96?=
 =?us-ascii?Q?A9aaEc2FLf+9YqEbLG9OuX0anMIBpHZ4U028AmEzdwYjdPsiejMGw8Bj8mUg?=
 =?us-ascii?Q?RNNf5ICmTTs1uKVZFKTRSDmmTvnAti/IOIau/95HCm1EGVEoD+NepI3AUJ0l?=
 =?us-ascii?Q?RBXFJ4lxECy8t505QI2gRvFhT6VrAaNH6XrbtouogOhJD4CTWhu4PPsS1szO?=
 =?us-ascii?Q?AvpzJqvhpHdBoXNSf5aZcUy5AXwTfxNxKUYLveww7j9A7Ld04J+SI9MwG/Mt?=
 =?us-ascii?Q?jg8N4RI7WnJjcHEytv6FsSrLBuILwuZWMOwDKAjKO5wWNKN0n7LxcSt2JiZ9?=
 =?us-ascii?Q?nQJhbl7GQqpRsMZQKdNMWwstV1mvkZ2JCuZY4SppvVCIJZGJAbYpTntVW3hg?=
 =?us-ascii?Q?DeWK4bpHIBvPuOOol4PRzAB03Z8wXkXAXSZg5DvXiWDeWpZHss1x6eMyfsC+?=
 =?us-ascii?Q?8MimfOC4N0F7WwtByg+zPxDxTlHXCw8VlwHBR2W81Cty6n2nznf52c2zQ2dT?=
 =?us-ascii?Q?/6pLztwfBxnkDpO3xko8jrsZUSAlwWTsBnHttJMmws7UR+T2XjahdZVp+x+1?=
 =?us-ascii?Q?Mmb44i1nV20bOa8nbEfoGw7Ga8ctE480dht/BYhiiZanI0gtsE6QbGyJeTvf?=
 =?us-ascii?Q?CRMPaCcUVn/aJ6QfamhOP78E0qmL3lOXehAVLFgKlwMaNzwgM+wWIUaW7Nu+?=
 =?us-ascii?Q?DcI+9UYis9TKsE62+nIgHC20ejDXG8nKMvN3Dwlan2RIxjuSUw23nSprVQVY?=
 =?us-ascii?Q?H53PQ5VFrIaK0cpFpmdDVxMUfFIMKjIom6W0QE7L7aMkjjU2F8rhxHdq73gq?=
 =?us-ascii?Q?97UVAT3IXfjzp7ckUdzT66Hbkze/pAi15LaVk8tiIAz7yQpEqyq0vPK1RGP2?=
 =?us-ascii?Q?mapVxytF8bajd9F2TgXx+oN4V2MhTshrwWSc0grA/AOI6r+YrgIZWyYzt5nF?=
 =?us-ascii?Q?APhqN/OygOo+YIAYCzKF2fOzTsMlwXzXhcjjOh2qSSfRBZosssyxbSxzAQ3D?=
 =?us-ascii?Q?lum2KaId7XFn9HHjp3jWaLTKYZP/5z2h04q9LX59SciCPU12VzIqY9/ZbsG2?=
 =?us-ascii?Q?jfqWjLUKI9qamlVedLJMf8yq1AqdiTUajt2RcdguRAzKGx480ACiogyM2U6n?=
 =?us-ascii?Q?DStRdyZr7xW04Q96UaSnGeDue0HPjGEIL5t6b35ksTuxZ1whi23eLvnZL399?=
 =?us-ascii?Q?OGS6Dx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puc0i1bTS1kkzTKgMr7hTcuo50sbG2N6P+T70KTfSVifjzMT8jU2pOLFWKq/?=
 =?us-ascii?Q?Io9neV81q84nFqw66lVhJbVnqZpFFjkR1agOkcZwJxG5N4LHyvvVUth1LjjG?=
 =?us-ascii?Q?Kb/y/995grXza0Rpq7m4q2cSs0eKo6XtjWeKJ1tIiIXfLHeAmTcwwUghUGzt?=
 =?us-ascii?Q?H0xDKIVUmTiap63DB7Df7UZrbiZ4WpMV4VRq0EBgW6teF0lvLmllL+Xbh6yP?=
 =?us-ascii?Q?mdVFU8lEDK7Aa0CF8cDTDkQ7NoJ4By94nBrrvuo9UirYfhPFtlZB5h6/P4I6?=
 =?us-ascii?Q?eiI09XQtt9mAedTS9DqPwhLIAXIGf2FBl4jEldAEroWVXH07C1pk+oChnUcH?=
 =?us-ascii?Q?bSXAqJtwGn11MYuxWfX/ineOkmSv3vHHF2wxuPsCsh4RStkvHK93qvnTGd32?=
 =?us-ascii?Q?vy2wQZpeAktKv1/qaSKLrhDL1fCozc7cxSa9mPIgQeobstdO9JYu0sY1n5PS?=
 =?us-ascii?Q?aLgyfQ36yEymkuVkz1jYe7RwUxBnV8QlNiW+n5/P5Q69xONBAAD8qN2eC7zC?=
 =?us-ascii?Q?crqoAfdvz1NwPlIqZyx9BrGjNP6DfvNbwKheUex3QGp254tOlXCqZ5Z4+DcP?=
 =?us-ascii?Q?eY2YHKjeCya2bs6fr0SXiEn+sVCOMw6PlwODKhFC4dWgVHwnesB/lo3N8lDJ?=
 =?us-ascii?Q?vPJLpDVd0yN6MXo7IbHst4MRqbYxa9E6+f1GkHo3B1k23EK1ygOXlImlHn/b?=
 =?us-ascii?Q?Hpxw00exBGwKnjp5cR7xihiI1UuUL0nnsZnaeqG/VDoKpFQxZQaiUhyX71X2?=
 =?us-ascii?Q?iWU4ykOtlDPgB3jnNCh94eQFFPcsw4l5MByhnPWP3Dk/E8AbzxMU7ryzelxE?=
 =?us-ascii?Q?FVrVzcAo0X5vmhoY0ITHyroMlvGHyqRZEgmJ4cXAl1D0IZN+i+kDX/mzP6fz?=
 =?us-ascii?Q?pqfE+KC6XKH5MIYBDzxN2Ki3uS5oEaRk644dKeMPBLqWfJHXk4jwcuarzAp6?=
 =?us-ascii?Q?LfNYIYK2sshL+8uvCC7IWZ/uVVELm9kL8BQlNIHCYH/PCYMlMhrnI2d2hYtX?=
 =?us-ascii?Q?6r8Pu9jmFMoQgZpRQ66UqT6tBLsucMJHYfrspuP4VscunsCPpZwfwK5Ziipb?=
 =?us-ascii?Q?ZmTGmxQkz8XFayG8nIUs8rPqbX4fYNvl4DLl6y+5EKWp+7lnL9Fj/v9x9nwF?=
 =?us-ascii?Q?T04Y9i1OXiHEpeAwGTqQFmbD6ycIDin9OIxXdK2kd8cqsF5HJHXSFe/3d55c?=
 =?us-ascii?Q?OOadu4omxOdYiXSE/FJbKAAM3D13xaDtZm4obql5JaBj1cyFt7zkZu4Xh1wF?=
 =?us-ascii?Q?cBLIhvEKQf0aaGoEHqOu54eGESbobUGhVdjmwjVFUBZ0FwkDAZt3o95tRa7J?=
 =?us-ascii?Q?szNT1Rrtea1wION9V8oBFvnLhYadk1OXOtwUTQO1MY8dQbVqwfWch3HiHfQP?=
 =?us-ascii?Q?ZM7mVeNwCe97vJY+JMZzzOox8ksJQzS64Nu+iaR9di+qOcNp7gC7vcU62Wu6?=
 =?us-ascii?Q?LdIp2SleoYgDHm5y4KTEIJ2TX0jGuDTGnlkxFbXFjGTtA3cUF86OHUAbUsKP?=
 =?us-ascii?Q?8dpxAFVdu819Z2/AwpT9/T11LWIwvwskzNeEnqmKUl2RgrQtSdOXT7auoIMc?=
 =?us-ascii?Q?6zO6fkEqck2sbxD0obCGm0E8lsUP6uGO0rP4Rh95wCdfFLP0kMRXIfvaFBsJ?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c344a5-6411-48af-38e6-08dcf4efb05a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:27.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chJIzLXWSMI0Lrq4Zoaf3w0qe/hux8KvflNogKbmw8j+4MulzaRDgVVeo768gjB3BR2DpG1cNbbg713AAGTIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This sets the transport owner back to NULL, before the owner object
is freed.
---
 profiles/audio/transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d71013077..dafd1c471 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -287,10 +287,15 @@ static void media_owner_remove(struct media_owner *owner)
 
 static void media_owner_free(struct media_owner *owner)
 {
+	struct media_transport *transport = owner->transport;
+
 	DBG("Owner %s", owner->name);
 
 	media_owner_remove(owner);
 
+	if (transport)
+		transport->owner = NULL;
+
 	g_free(owner->name);
 	g_free(owner);
 }
-- 
2.43.0

