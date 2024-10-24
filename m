Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A81CACCE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767779; cv=fail; b=OklHqMaBlGKDUI547F6h/TMp9/mSrj3a2JCWUF/idOzeqT59UoL9D34PpXxHJFYrgYg8xeX2CP8nZSH08Rza+7rszNAHO0dsabtvpWPk2NAeNEMZHyLQpNCQYAzrgmfnCcwygnU0vff8kwvoP3pXuDRP4tVi7Wb3zTrYgDW61to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767779; c=relaxed/simple;
	bh=vGoYHrV9It3hSCFhh0q5y6vymuna8Qe7Qal+Y+1Ry5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAtAfEiOs2REe95aA97JP4/KQZogeY1ewymdHSZA4D0vA4CaEZRaHvpk963QWT4QcuWiOO4J01hJb17GjYP/lyAS4eNXq1WqJAR2V1l9i6NcTgrwNrYiSg1pdegl6HX8UQq3uX4vVEPoEwe7Siho9IlOkT7/Z2EDvnpSsiueoQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B286stF/; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B286stF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og2bSSwssZ1c94h//NB6fpJ3eJXtiaaojxyZsUQVqJZwICgiFR9LHEPZmCyMo1MNGA5WNuQ4bAw/u+IvYNttoLcZpmj4ePiMpxLYY9bSqznR2q9sZohuaGCOWvtajGeHaoFcBEX7RdKLl/g4cTlQOx0IzsjxyGBra++Igq5a8ZfByScuzgY5LNu84XvOlirlvmGvinLvDadgNJwmtpq20wYv3eV8l9d7j5tAxhRg6K9PrVtNwODc+VcYOno6pNOp1j0Me7sIsozHtO+5mTZVLpVcB/04jNg1E6PXIXnDia+hu3x7rNUJ6OqXc2RpXqlN0ViLzOGZ1sV0PX3jSW3MHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwtOVH5eehtjp/++jGhxfvvjytHVqR+38TKX8bsnJdc=;
 b=ouitVyBwRVhPEmp6io4tqUjQ+deGbowLEGgk1SCD01WbBwbVOLXA6Qz1xjjkT4C5FgM6frejqjDGRhD36aH8nM6yd5IcKInhmSolcttuDGu3hqakZCnOhR0OZHxgGdx9QvdXZz5orm5glbxcYZ7JwI3lOgebHQR4zfk6OUMlxCBpSc3Zehv1tREND/KnXpZTICujly3zmKcUkbVcW2IAqx75n5/x3rSVhbbkSpsWwWjI30lCon47z5LNm8NVYJMpOhaRwFmyPEjo3b69WQg6DXCDSfAE95iUDjiq+BXbZk21c99lqr4q0TWIJOVYP0kFl639yF6TrzS6B+hT4IYdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwtOVH5eehtjp/++jGhxfvvjytHVqR+38TKX8bsnJdc=;
 b=B286stF/ws8cidl74L9EFJb13D4dXLvFrtPcGr0qHhxxJWUXoy6kEzsaC69EBiJ4XwEBo5sWhHrczsCWAcTnfUlzS/gS3Kh+Cucy+3R2M1gYt8UqN5RK2+0DLHVBJ8NKalGRacSYPviPxzMXAAg2kJPrCgD64OD0tm3yNRSj9ioyvX7aO0+C21zmrmjxdb/ZRYC6+BOa2l/+cytjzK6wZ3fCrVtTbwjwzu6H6Qc6iKzpTrFknsoX0SsWJZl52Bc++LIDLqXyJkW4IWvrrt2JMO5FXrNrW4PiO9Vym3/KwqZgwyfvMA8G0weJdJdoCTaCbK+vfcvID0B16uaUvGHprg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:02:52 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:02:52 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 01/14] shared/bap: Allow multiple links per stream
Date: Thu, 24 Oct 2024 14:02:10 +0300
Message-ID: <20241024110223.77254-2-iulia.tanasescu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac12da1-13a4-497e-bd39-08dcf41b67c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ZFhdFUbEhXPHurTj+YdszQN8PNCoYqNAS+gtQ7FFG1F7+/BIhIWMrcuX1su?=
 =?us-ascii?Q?XOdK0n2ZJujni5q66nrolpcoPJLTSwn7FkU1QoY/Wl+rivyDJd27Q6BlMRuT?=
 =?us-ascii?Q?ucd00Xe275WS/30e9Pjd7FS4NbJ1I87WqwOKZ/F73dzCQ0F6NTw83fE1aSO3?=
 =?us-ascii?Q?fP8YxPP8uUZA1cVB1IJvQWkSGJlSEL0INnEt+xMnECpjXaZ+Q4xVodEqQWFr?=
 =?us-ascii?Q?xo0k+lQfejYwezgt0sXAlk2e21cBuuHfUy28PcZ8dn99ZnSS3+e3d1DfjhTm?=
 =?us-ascii?Q?CJSD+NTF7IFF175A+jqZ+zFjwnQyLOiyujiEAtHt3Hk3qA2mJTO4AiQaW4sq?=
 =?us-ascii?Q?jtbWlpZzj1A0DB8YS6PVJXApHEOXQYFrSOaxaLKMGX8W6FgxEw0qeLoXFNiq?=
 =?us-ascii?Q?dltszlHy1uZZDjCIOGX7YBkBA+UA6JAxXQF8r+aaq51p0HpD9p66BFyxXwuP?=
 =?us-ascii?Q?a0oYpV7XYfRMP4r9vIvdTxaFoPnLgMYmyHIJSH+w0eEC0lV2Xl+a5g+vcE4B?=
 =?us-ascii?Q?w+1mMvAJgl9S3mviT7LE9QsERXpfigwNz374S7rHTr06dQ5pMfl11zR3iBkP?=
 =?us-ascii?Q?NQXuk0LEhd1sxgBudU+vk5LsuTweQhV58bVyi+tpcmhYz4KPIPhCz30Kwsac?=
 =?us-ascii?Q?bjXC1xS0WqB+Dwc2oi87ftzLR5KrgAxjS221Zyvhf/eip09A8CYAv4SEnJj8?=
 =?us-ascii?Q?VB1bEQTImOfb5TeWF1ZQtrGP2TF7M4zEEvG+G0uSCMGBkhbvRw9lOH1Zfmzc?=
 =?us-ascii?Q?zl/9ePG6nWfbzBCLOAy6CaXWpPQ53+FT4Pg6TdElvnJ2B8/6gt0GwGUDQ/B4?=
 =?us-ascii?Q?OsfpA4tzCX5w7qkijdlnHlXVNh9yJc8H7qPcQo4J9iJxHGcdsoJFpFASyFcR?=
 =?us-ascii?Q?ws87Xjwv9Q/jIssa5hJS1q60jf54F9CS/kvweNOJ3rlhM4A4Ak0NE9buNJdT?=
 =?us-ascii?Q?aBnh7gqhafkv1Q+tm2OzAVAICRZURhaw1wz0dj2vZxgZvf0kf7YidSErwgmQ?=
 =?us-ascii?Q?HXf/BBZmNJ6xKhXJIA0VTcYVoc9Wa5R8JNxm12x9LllHHm3oHXnqrv79ARmJ?=
 =?us-ascii?Q?nA4rN4Vffvss5jf3/C0l/fc4L+vx54WFJ+yLz+7WTyV+tCACNYLWRoalc25n?=
 =?us-ascii?Q?Zl/boEOO6ewbD3GuD0RNbPqPTQdhN0CQWTImN+RbvwGJAMrjjiBja9Q+XGYK?=
 =?us-ascii?Q?IAMb7PJs8lrEw7HOXZRcKjvqNaEBGGHPBW/uBTQ9eBQSAxQMLogqNRmM7NWQ?=
 =?us-ascii?Q?+DR38LytY7wGjwOSNonvOABvuVNTilum7wOwcKUQZdEVQ6EgCHggMTmdxZAb?=
 =?us-ascii?Q?/yfq9WvezonGFXSQnQo4F+BuO/CZHKKKc2v+D1xNyc10oINKpiW3uXhuQscU?=
 =?us-ascii?Q?z1cOZFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQcFkoutC4NOAU4+858RFj+wZodOa8FrhnZtFYAE1w+c2GHNhbDxIhszA4LI?=
 =?us-ascii?Q?/PfTcRVO9xHuM2H6Ql3CR3qc+YHHsQ1yw8D3QkTCNsqWF3MJGOhIFWwmzrg4?=
 =?us-ascii?Q?dzvOxvHtrH5zVWXdATHtgj5o+hOEZqk0crQ+ERu0Tnj0UphYqQK9mJWv3AKD?=
 =?us-ascii?Q?8pI61I160jovcyk57ymGlvc8knZHxrv5AnZ4LD9NJyMeuxOtbV2gpv7LnHFP?=
 =?us-ascii?Q?vnff+Xsj4/SgISNvW9GD4rWnrEBAPbu0I/ta3llx+ge39Cg+zuj4XOacMdx4?=
 =?us-ascii?Q?O6V2sMxImC4t1ifgcl+QBBdgiJ0oZQIZiGUcwWgERV9GqvjHRl7ODtMc0nGT?=
 =?us-ascii?Q?QjfkpOpaTqKdbl1MuPywmITXsgOe63FxYh3sCPZCSAVOYLXuBg5ZAlheWnGE?=
 =?us-ascii?Q?a+qrlCY6dTY3ySMNJK2XefdE/p7ytq0UicHyijNozJSRQPul6D+TkMyk6ve4?=
 =?us-ascii?Q?gCmumgwVwByE5Q8XZlBv6HdudAgcXTsqneswEaC4lNevpZrE22qVjI6vsyvY?=
 =?us-ascii?Q?RB0hgjL+U7mBwqvEMXZvvBTi9/2lih9rmy99Io3yI+OiVbXM6bsup72C3Iin?=
 =?us-ascii?Q?9EhKU8kcleZi9g2QKgGUPepHPv4Vmt9Mi4SBOfS4hZdQG9HhGmGknSomXLD6?=
 =?us-ascii?Q?dpG3DNLhBiWzWQxAKgQDzyhM6P21rD3U8N3ogGHS5tVBlrWlTWEfZbaacuMa?=
 =?us-ascii?Q?fe9CAyPwWzE1oOA2QHaZEuejzflIiWnJ/iE5siDLSjBRCG9rWYjHxmSbfRaf?=
 =?us-ascii?Q?XUIiyKvIIgVslG34+UdDveigtvqrXJy1+Z24P70QO2quzzjP0k3q73TKorry?=
 =?us-ascii?Q?F6bs4HxTsiWWdFgou9UZBrT9TYZR/txIFDxk3OYg9bJOaxdaxW+KPJMe3Na+?=
 =?us-ascii?Q?4fYpEo/OS7ZvBPEsmvhrBq7hf4DcFyRWa/MwCVvHmZKb/58vf849J0+GvDAA?=
 =?us-ascii?Q?DxZBlzptG0El2CTQwayCK3XZhpM+vQN6v+LX9FLJcRnRWrvJx+Ou59AdI7C3?=
 =?us-ascii?Q?fU4Fnkko5w/mohPOqtjzH62pZg/03BE2speC/R0PS4aMpOSpqEYE5eCmpYXi?=
 =?us-ascii?Q?1zDGaLkD/ZZsuEQ+Ya/Am4N03QS+PsHDJdvGzewMYFQppHlIdv856HSYzcmw?=
 =?us-ascii?Q?X0Rur6joDfX8L6Xp1P09Nne6rDLvL8EDh6dk4KsyTAX+nFNfcUVnge2mYMwE?=
 =?us-ascii?Q?mcjxXOIJyOLeM5E1rOAy+6VQ8b8+7IRgp43/Ec3CSxGKVWD5w3xcTUrtH9XG?=
 =?us-ascii?Q?xUHeqQTCpWk4o9pdeCMalhoR2bgSCnIj0MowFlwSQro8rwrYsW26cTHhvH3i?=
 =?us-ascii?Q?pVPhehzDzfI3zVtsxT850XTpODybp3qYbANMDh0kiQhzVJ9RRYFfRlwvRWZp?=
 =?us-ascii?Q?dZuWtfH1GYGRPQ8SpwgAC/ODhB+i38S13YOrZoP8O8/nR5tZZSbcAgqRO1cL?=
 =?us-ascii?Q?Mw9Sj5wzSWJGXBykaVTGykKjuA2MiH5AvCeyFdXHZauoqfGod4C0ECbD94Mm?=
 =?us-ascii?Q?EBMwQUwZ8NjQbkqSBnxVv1oWMKdk/5ZcdSokVcs4CYDpZssGsLTJMwJMlJ6y?=
 =?us-ascii?Q?ySSyjAZrPn+ZsPNWVYbjF0J824Z6K38Y1BOT7RBKqTm705p0SfDXhJVJT2/M?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac12da1-13a4-497e-bd39-08dcf41b67c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:02:52.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c+QPECeKMpQbmaMKNv5DbGDIWMLw1pDry1T3qIcByliMelLTGk4lrkdmF/1Cclaf83zTJ8EtipQpF9YRQ8m0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This commit adds support to link multiple streams together, creating
the foundation for implementing broadcast links: for Broadcast Sinks,
the user could select multiple streams to receive audio from. All
selected streams need to be linked together and considered when
creating BIG sync.
---
 profiles/audio/transport.c |  38 ++++++--------
 src/shared/bap.c           | 104 +++++++++++++++++++++++++++++--------
 src/shared/bap.h           |   2 +-
 3 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 68192bae6..d71013077 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -330,12 +330,9 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked) {
-		struct bt_bap_stream *link;
-
-		link = bt_bap_stream_io_get_link(bap->stream);
-		linked_transport_remove_owner(link, owner);
-	}
+	if (bap && bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_remove_owner, owner);
 }
 
 static void media_transport_remove_owner(struct media_transport *transport)
@@ -581,12 +578,9 @@ static void transport_bap_set_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked) {
-		struct bt_bap_stream *link;
-
-		link = bt_bap_stream_io_get_link(bap->stream);
-		linked_transport_set_owner(link, owner);
-	}
+	if (bap && bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_set_owner, owner);
 }
 
 static void media_transport_set_owner(struct media_transport *transport,
@@ -1129,14 +1123,14 @@ static gboolean get_links(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_OBJECT_PATH_AS_STRING,
 					&array);
 
-	append_link(link, &array);
+	queue_foreach(links, append_link, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -1572,15 +1566,15 @@ static bool match_link_transport(const void *data, const void *user_data)
 static void bap_update_links(const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 
-	if (bap->linked == (!!link))
+	if (bap->linked == !queue_isempty(links))
 		return;
 
-	bap->linked = link ? true : false;
+	bap->linked = !queue_isempty(links);
 
 	/* Check if the links transport has been create yet */
-	if (bap->linked && !match_link_transport(link, NULL)) {
+	if (bap->linked && !queue_find(links, match_link_transport, NULL)) {
 		bap->linked = false;
 		return;
 	}
@@ -1757,15 +1751,13 @@ static void transport_bap_set_state(struct media_transport *transport,
 					transport_state_t state)
 {
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link;
 
 	if (!bap->linked)
 		return;
 
-	link = bt_bap_stream_io_get_link(bap->stream);
-
-	/* Update link */
-	link_set_state(link, UINT_TO_PTR(state));
+	/* Update links */
+	queue_foreach(bt_bap_stream_io_get_links(bap->stream), link_set_state,
+							UINT_TO_PTR(state));
 }
 
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 00c3b9ff6..1b70df4d5 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,7 +262,7 @@ struct bt_bap_stream {
 	struct iovec *cc;
 	struct iovec *meta;
 	struct bt_bap_qos qos;
-	struct bt_bap_stream *link;
+	struct queue *links;
 	struct bt_bap_stream_io *io;
 	const struct bt_bap_stream_ops *ops;
 	uint8_t old_state;
@@ -1101,6 +1101,14 @@ static void stream_io_unref(struct bt_bap_stream_io *io)
 	stream_io_free(io);
 }
 
+static void bap_stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_stream *link = user_data;
+
+	queue_remove(stream->links, link);
+}
+
 static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
@@ -1110,8 +1118,8 @@ static void bap_stream_free(void *data)
 	if (stream->ep)
 		stream->ep->stream = NULL;
 
-	if (stream->link)
-		stream->link->link = NULL;
+	queue_foreach(stream->links, bap_stream_unlink, stream);
+	queue_destroy(stream->links, NULL);
 
 	stream_io_unref(stream->io);
 	util_iov_free(stream->cc, 1);
@@ -1246,6 +1254,17 @@ static void bap_stream_update_io_links(struct bt_bap_stream *stream)
 	queue_find(bap->streams, bap_stream_io_link, stream);
 }
 
+static bool match_stream_io(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+	const struct bt_bap_stream_io *io = user_data;
+
+	if (!stream->io)
+		return false;
+
+	return stream->io == io;
+}
+
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1259,7 +1278,7 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	io = stream->io;
 	stream->io = NULL;
 
-	link = stream->link;
+	link = queue_find(stream->links, match_stream_io, io);
 	if (link) {
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
@@ -1803,6 +1822,14 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static void bap_stream_enable_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct iovec *metadata = user_data;
+
+	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
+}
+
 static unsigned int bap_ucast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -1821,9 +1848,7 @@ static unsigned int bap_ucast_enable(struct bt_bap_stream *stream,
 	if (!ret || !enable_links)
 		return ret;
 
-	if (stream->link)
-		bap_stream_metadata(stream->link, BT_ASCS_ENABLE, data,
-					NULL, NULL);
+	queue_foreach(stream->links, bap_stream_enable_link, data);
 
 	return ret;
 }
@@ -1872,6 +1897,13 @@ static unsigned int bap_ucast_start(struct bt_bap_stream *stream,
 	return req->id;
 }
 
+static void bap_stream_disable_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_disable(stream, false, NULL, NULL);
+}
+
 static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -1895,7 +1927,7 @@ static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 	}
 
 	if (disable_links)
-		bt_bap_stream_disable(stream->link, false, NULL, NULL);
+		queue_foreach(stream->links, bap_stream_disable_link, NULL);
 
 	return req->id;
 }
@@ -2327,18 +2359,30 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 	return stream_io_ref(sio);
 }
 
+static void stream_find_io(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_stream_io **io = user_data;
+
+	if (*io)
+		return;
+
+	*io = stream->io;
+}
+
 static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 {
+	struct bt_bap_stream_io *io = NULL;
+
 	if (!stream)
 		return NULL;
 
 	if (stream->io)
 		return stream->io;
 
-	if (stream->link)
-		return stream->link->io;
+	queue_foreach(stream->links, stream_find_io, &io);
 
-	return NULL;
+	return io;
 }
 
 static bool stream_io_disconnected(struct io *io, void *user_data);
@@ -5846,8 +5890,7 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	if (stream->link)
-		bap_stream_set_io(stream->link, INT_TO_PTR(fd));
+	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5902,7 +5945,8 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 
 	bap = stream->bap;
 
-	if (stream->link || link->link)
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
 		return -EALREADY;
 
 	if (stream->client != link->client ||
@@ -5911,8 +5955,14 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
-	stream->link = link;
-	link->link = stream;
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
 
 	/* Link IOs if already set on stream/link */
 	if (stream->io && !link->io)
@@ -5925,12 +5975,12 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	return 0;
 }
 
-struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream)
+struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream)
 {
 	if (!stream)
 		return NULL;
 
-	return stream->link;
+	return stream->links;
 }
 
 static void bap_stream_get_in_qos(void *data, void *user_data)
@@ -5973,11 +6023,11 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	switch (stream->ep->dir) {
 	case BT_BAP_SOURCE:
 		bap_stream_get_in_qos(stream, in);
-		bap_stream_get_out_qos(stream->link, out);
+		queue_foreach(stream->links, bap_stream_get_out_qos, out);
 		break;
 	case BT_BAP_SINK:
 		bap_stream_get_out_qos(stream, out);
-		bap_stream_get_in_qos(stream->link, in);
+		queue_foreach(stream->links, bap_stream_get_in_qos, in);
 		break;
 	default:
 		return false;
@@ -5988,6 +6038,14 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	return in && out;
 }
 
+static void bap_stream_get_dir(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *dir = user_data;
+
+	*dir |= stream->ep->dir;
+}
+
 uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 {
 	uint8_t dir;
@@ -6007,8 +6065,7 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 
 	}
 
-	if (stream->link)
-		dir |= stream->link->ep->dir;
+	queue_foreach(stream->links, bap_stream_get_dir, &dir);
 
 	return dir;
 }
@@ -6043,7 +6100,8 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 		return -EINVAL;
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
-	bap_stream_io_connecting(stream->link, INT_TO_PTR(fd));
+
+	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
 
 	return 0;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index bf928bc2d..cd5ea2eba 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -231,7 +231,7 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
 
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 					struct bt_bap_stream *link);
-struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream);
+struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream);
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
 					struct bt_bap_qos **out);
-- 
2.43.0

