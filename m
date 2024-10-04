Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C91D3580
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045345; cv=fail; b=pWpZQVFhTZwhk0yRZ4I+NVfgLfn7ITRxpkp3eidRdlRaJJFM09+e5uGPA3KkWafmGR0UfVdQ6MjbtkSx2UTZwymNJJL0SyQMgSlYFg4KRfp8Aj0vtC717Q09klIiTcE3owaW6xLTq5OaLMl+fYa+OusXP5Ki/qjkunXc8NMZQDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045345; c=relaxed/simple;
	bh=XvJGS03WSoBqcrI1qyXGZu8RPaYTP7hHdijfi3Ex1gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1h+RtyGAyoXl+qwTDb5lE+gyAa8XHzQd1doit6IJefTjPinoWkjTdUYU8bzdiW+QJ2SbCBpD8+XM02q7AOLkXezF4m/idClP3lgw6lCFC07fZPCB8U7u/A0TY/WZG1utdsNFwWeH74W+Sgma8EQ56cilwdk3RwQWA1NO/3FGw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S2xSd5Zi; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S2xSd5Zi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJGaPd56w0+OLyUHRrJdcJtJ9jhqKt82zVRX0yvd30LjifrUHQgc68yX0OP56WfzQu5WdFRnp6et+yZHBhVH1tAZdJeTG+Qi4tW5PiUyxFtTVlcmzSenilVQk6nauwYKVAoEHwV+p4g+a2Ws3RawqZGx2jHwSc7PTUdENMDMH/5RGYOw4i4cETGdapBAouj1PLt2xYAvSLRWowSUYtTLO3ee1S1g/UxnNhqxb3jZHzyQrbqUhYXHV4zQzry8mb97ea2JhpUr4tQwivTJcYEDVh+YxE8B31J+5kGYJB4dzAmzvmyiiEdXbMj+PS5SK3imoikGvlribZ7KzOhe+geakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjrT5vOa3/NpeVUschanLFV0HQj8JvghIvNFcWfaiIk=;
 b=Wri33zKr72aAQ+Jl4FXFF/27/OkeSCagiLje+rluIBSlCgO7RG8acZ5+tudRcz/ADtCKTW+TEeDSyM72uGA8psmRe1ds7XcxS7WNMHJVh3t7Yawu9UeWcXXeuuaFeMLTKstCtaPX5KJ6tuC9LabBMDopxiQT9VdaELl9Ws93LzhgZZSmBzOF9E6y58rEdKxCCcAcws3VETAQaZAeZSS+9pprpFeh6bVmPMHs5hlD0OOlpWpFbcPzI+fl2/Wls2s1GMa50xZ7GXRN5Lj/0ybWDMKWhu/6OLAOrYiJ+if92iEDSDbOAu5hsAPbgxG4coOCgU0Nr3sd0Pjmumx+YEqDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjrT5vOa3/NpeVUschanLFV0HQj8JvghIvNFcWfaiIk=;
 b=S2xSd5Zi9+Pad0UEXpll+q2EJ1PEENojMr+/9cNZXB37xLvrgwFSb1+DceREVTIKNg/jEHa+ZUlodWGFmjC5Z7h9GCVPBgEGq+O3YtvHGCn+BthweR5RZa0VuAddChUaxHPNZLFY3WIRjSgGszfkxUHaTkOmdKB8Mb0mpXwmm/QDRIW28H3Tfhx0yBdTi2wVJ30UUZgAQ3Rm7at0susaf1lWuGt/ChNAv+fjovDkjzHBNN7s81uMV+8wp4YEGbgM/ODpzGULOzyxXpn3yZIB0vYx4QLR4pJ5UwDZ+JuaYLackTQJ8VTUH59v4W9g4IBBlBIx7k9UN2uEtsPq6nQWag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:40 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:40 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/9] bap: Add helper function get_bis_from_stream
Date: Fri,  4 Oct 2024 15:35:15 +0300
Message-Id: <20241004123523.1012743-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2cbd8b-0f8d-41e2-9e27-08dce4710e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JEwiSsk/G7i6NOZlSRTHBGSXh1QTU6g7aLQ9Z6zI8P7tI8tp01bwu1m2xJSd?=
 =?us-ascii?Q?1zHbPqOqCgJBrOBsU9wg/DWgZAx1TWNElItkD+R0cA8UR60OdyUOpq5N7EsQ?=
 =?us-ascii?Q?YKXpIGNav2b08Koeeqbju3X0d0el8oMbOlEa9Fb2lQ498uVG+ta3ECRwKfby?=
 =?us-ascii?Q?7ni07bYH0bEl4mX3jVehagMfmNsX3K7LRcagxVdxHwfuEzfeE/3tDy/f45ka?=
 =?us-ascii?Q?DKd2cb1xcTMBaHkd1SLqziRhLPl/RZ2c8Xu84zfLRryg95o1r8AoWJg9rRhr?=
 =?us-ascii?Q?Q34zQmZM8aCNF96Q7Zvrc0aM4V+Z09WaKSUdLrdACDmt3w5+3ETPzGQgFgw9?=
 =?us-ascii?Q?iZlddZwulLQAp+j4CHehbHjJ6W8KsY/fVuX7tjMcVUk+Idu+mOOu0Pi7xusf?=
 =?us-ascii?Q?Nj4GpjmHH532QJxdmMQrL4Wpy7IOllxFCCNazRzQAnQmlrhGhiX3+8ETDUYo?=
 =?us-ascii?Q?OYaUJalBYKvmOv/x5H543GWMNy/sfKn/7+VYBdV7QT7KDJ4qcal7knfCn58t?=
 =?us-ascii?Q?nWs5aiG6Unia2ka4IKvHNWo2i91Ys+yumsgrFzDjREfQfdp2ZxXgs17m4foN?=
 =?us-ascii?Q?7QlgRtH8y0kY3J6znZHrsEFFUyrVpkhnzbprzjrlsM+gAdscx2DH4jKrbTsa?=
 =?us-ascii?Q?K6nml9JcPLNILv8crtchPlI2NnDZil2ULBT0BsHIH1CNXUXg72PD72z1Dmxm?=
 =?us-ascii?Q?ftuS8Rt9c5KubYDeLkIz0eFZMncw9Okba9OMQyrYNogeoNOrmbL605EuGbIi?=
 =?us-ascii?Q?QbRAPVXZfKE7iQuK+FY/ZyeGL9mnM3lkc5yKdk7DTnPmtpkwW4G8rmbIRa3G?=
 =?us-ascii?Q?WUvNH+dB7aw3Gn4tkQGpzLK/eO9TPwYTVP3obo9ZMCas+JKXv/iJ3u7t4VpY?=
 =?us-ascii?Q?VBb5CMt2wwZku2Wp9ZCxfsIXps3KmGTUgVj1ZLJhdJ+KeM/mUH9Hj4TG0iZN?=
 =?us-ascii?Q?cJCydekuEPHTsmYX7baw665DyaV+nuDGwbnEs06KHtl1BEYpU4Jh0bQN8y3l?=
 =?us-ascii?Q?RoXfqDuDS+BkTXSkFiJNNAy1/lWIZQaIWQP6JWXG530JXyBHM84jHDeS7c70?=
 =?us-ascii?Q?dT0SLdM6zzLsFx+r4EprWQYj4MFamNmdIzr9tBHNATLcYI7CGogVjGrPh0Lz?=
 =?us-ascii?Q?CiYZdEiO5KzTHUjo1FFWH4gfXJlGx4dHKZOuH8H+gBSQEU554ckW1fJHCINi?=
 =?us-ascii?Q?72WiCiTTJ/xQGCubhc5jKDvwRVWPSpMjOD7uaES9FWvnltqbDuHmng4dKy9J?=
 =?us-ascii?Q?MdvNc2rzz5xBq1rNNhmChxIC8/I4Ko4yLjLOQNJOT0Qaynl2VO2AA4OkP9Zi?=
 =?us-ascii?Q?PK0324g0nyxnx2BHOapkrWrlSWsnYyAjLEfjnjPBh4F8bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h9zfbH4qyhuIciX3iKZdnf4p7VsOx0Ko12H1Y0rXFCr55lJ2y/ZRRywjOd58?=
 =?us-ascii?Q?ng5TDr0UYtDKqI9zuhdAGSnvDvkSDcDGFRKyfk8yofIpCoHnbxQonLh9/TPl?=
 =?us-ascii?Q?M2pVJqEXOtGHuZBYgAcu6MZsFYcN0jldVJsBgy/wbD43NFQdRmeQy4Ms3F+p?=
 =?us-ascii?Q?5auN5P9UnJOzD6iQ7pD+fQlbK7an8GaH1nDqOwRoN3nQ0VXf1exD8PYm1RsB?=
 =?us-ascii?Q?bUnQg42b1cMhlk/KMLUuWcozQPHPJOzKHY4GGZ1oCdBA9Z4eVjkZ3Zb0b/BE?=
 =?us-ascii?Q?5zyO60xu42KBiWtT/Fbzd2ZBgQqyzNVMtD0whmZOfREzgPltYnIf1QwzNYi7?=
 =?us-ascii?Q?Z0JqQ3Ksc+K6i8axBQcuO5m4zfQG6aJhXLULg/xXVrBrg+9W1dVW89aMtnzX?=
 =?us-ascii?Q?sqMVT0dMK/l02RY6Mp7SzCMHURa317w1XkA6k0qy/fFDJf1q1DroyR7qJ+TT?=
 =?us-ascii?Q?0YmAKKRMIrGiET0Xw2FaTZZMtkceIDzNOxPGwow+lEB2OHYXfAC3zRjMzJp1?=
 =?us-ascii?Q?+zu33X9fZ82sobTu051iSkKFHf2KIE4JCnHfv9kJ7LuO784dmUJdk+4GPjWG?=
 =?us-ascii?Q?mMTN5rDY9+r/BTe+RdP2y1QwQHUX2fIIYTUEn2K1PbB8psxFnshuh5IvLzAx?=
 =?us-ascii?Q?ZyxTTbdNZAZGZIUgUXktyPJh3FJuBunbbYM8urAH4F4hPjvSlJWflHekMOnr?=
 =?us-ascii?Q?7n1qjbhGqEBKQ3ksoWrZkHYpZRRXWn+eqOjVtJ87Wxrjs6yjoi8y303XanLJ?=
 =?us-ascii?Q?Z5zOz4HBg41flJYBE9J4zzpaXskxAxHJbkEX9oViRyP3Xd1kWg80KYsJcw1M?=
 =?us-ascii?Q?uo8q1r8d1XZvYbPsb/KIOsEYRs1hbKFj65mrB8ouvgU7IgLECOTqtTRp0JQN?=
 =?us-ascii?Q?u1umqSnmvpWPYgp7Sl5I8vhIC5JifsMnSUkCBNg2PzP3QVyBMd89ISbr1NaJ?=
 =?us-ascii?Q?HEUr9m11zAQycXUTCz3b0OzZP+PpWU0xImgZKp1c5pcDfoReInXQiUIU7cPI?=
 =?us-ascii?Q?Ps07sRgnclOQd8V2MxiMTqUFkaTX2XvdyZdvNE1yaDMYSzk1AykYjV7Y0f0s?=
 =?us-ascii?Q?B37BE5vivDeDS1UGpW9ccTjWzKA0bKWMsEGPV9eHcmwQQe0UxaXfNwpQqg4z?=
 =?us-ascii?Q?7WVebtwWlkzavz3bou1iotWW91bpvImwF03Kyg9etOJzF+eUSAQpam6I7B6g?=
 =?us-ascii?Q?Q1OxSEZgWoXifyXJJfvVmeDjjvZtAayi+ImbNVl3H8OoOAieMWEia5eCrLU3?=
 =?us-ascii?Q?my6xu6A24kVvtfjmoKT6s1pRL89TkOLp1cSyzPVhzODWd0+6huofPV657A2P?=
 =?us-ascii?Q?/3GsioVhNujv8/QAvB7p7a0g5WH9BwHo+DY/R5oqkevns0jQuVBUCCF/7Xdp?=
 =?us-ascii?Q?ffmQZC4JGMNHSYbZaomEdLY35aWulKdbrAVguRI028jM0UUE+KehoHLLytj+?=
 =?us-ascii?Q?aGIq1s0NeVkNmUaOziWj6sR9svAa+RgkE75laqfnXbAN+uCO1B7+FiGira10?=
 =?us-ascii?Q?Ib3oaG7/uZ3RsbLRSiJFMlLX1HtViamWUjoTvnoacHggKJvnWeUI/L+ix+0r?=
 =?us-ascii?Q?Uaqey8Fo3Nwjjjp+4fBb5zrOU+MzFq6xuUA9P3Z/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2cbd8b-0f8d-41e2-9e27-08dce4710e85
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:40.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR3js8D8RvMfJ3vaqQv0bKfb1grDAxKw15qwR1VRlqihNHa2Jq+o1WhZi3q2pyMk3VeA/jay/OxOCFD+ZdSIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963

This function receives a bt_bap_stream as a parameter and returns
a number, representing the index of the BIS for which the stream
was created.
---
 profiles/audio/bap.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 100acca57..b48fe2c2f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -994,6 +994,30 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static int get_bis_from_stream(struct bt_bap_stream *stream)
+{
+	char *path;
+	int bis_index = 1;
+	int s_err;
+	const char *strbis = NULL;
+
+	path = bt_bap_stream_get_user_data(stream);
+
+	strbis = strstr(path, "/bis");
+	if (strbis == NULL) {
+		DBG("bis index cannot be found");
+		return 0;
+	}
+
+	s_err = sscanf(strbis, "/bis%d", &bis_index);
+	if (s_err == -1) {
+		DBG("sscanf error");
+		return 0;
+	}
+
+	return bis_index;
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
@@ -3055,10 +3079,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	struct bap_data *data = btd_service_get_user_data(btd_service);
 	struct sockaddr_iso_bc iso_bc_addr;
 	struct bt_iso_qos qos;
-	char *path;
-	int bis_index = 1;
-	int s_err;
-	const char *strbis = NULL;
+	int bis_index = get_bis_from_stream(setup->stream);
 
 	DBG("PA Sync done");
 
@@ -3078,19 +3099,6 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	 * transports in the same BIG to be acquired or tell when to do the
 	 * bt_io_bcast_accept by other means
 	 */
-	path = bt_bap_stream_get_user_data(setup->stream);
-
-	strbis = strstr(path, "/bis");
-	if (strbis == NULL) {
-		DBG("bis index cannot be found");
-		return;
-	}
-
-	s_err = sscanf(strbis, "/bis%d", &bis_index);
-	if (s_err == -1) {
-		DBG("sscanf error");
-		return;
-	}
 
 	DBG("Do BIG Sync with BIS %d", bis_index);
 
-- 
2.40.1

