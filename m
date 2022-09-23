Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F0C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiIWKwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiIWKwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:52:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C705E6DC1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0NyMoyTv8GFFUYqMc17bsERpO4vFC177c4K6m+atsONKzOJsuF6Dr6QIApsWLP+zzpNucdlXqId8XthWx9E+tfEZuBDgo3uEaas2PhTszkQAJ7FNYhb9UvcHkfF/iSTGNDObI9lSs0N81VjtG06vYAqp/V2cnwnc51iQ41fI4ieFSDNi6UZXZx5N5+nRrDHjPF7a59VXRElzJKfem/9khAP9X/VMoSxrw57IgFvCujYdvup7mD5d2gHxTNFNfRk/3ZYaFnQHp9/caMdfoese+1Hp/sIH1bBMgm5+WmWercHFstW3p4UypwxCwLiVdXGcDCZXovG0xXDSlSz+YHKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50xMhpPO3Rg7XAYyeNB99HP0gHgE0G9QHClArr/M2Sk=;
 b=WEo9z+aqX40HhJNbqqDCcLJjYR1cADoYIEAbaTYVKsojzQQfR0t0AK01OGnhbRi19J6i1I9Nn4KgVY18jwhKzUa6emekxgwHsL5CRTyQ4Tv5miiIcSWqAHyYspugsXoA9bvq7bL3O3KTRgViHz6FZL3/zmu1o10WgL7VO/QlVd4fK8Yk0xhJQeqhs61uPVdU2l5zF4/crS1x+XdVvM4GyPfOmfyS55zsZlJWEPPip8UXDdBOprGBzvpoyljtn/S8Vr1dWCAOmIVIUipKS1C/ibk3BIFtHCel6E2T4nnzX1/2MqdvIN+twj4UAzbTwE6YvAnl/M3YiCL6A3yTeT9xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50xMhpPO3Rg7XAYyeNB99HP0gHgE0G9QHClArr/M2Sk=;
 b=y1r1GvDllZX3tzwRAvJDuQMf11Z3EKnmEVtYON1IhvINfpIZhLz4XNiFJ6jYnqryRqxTAcMZ32tS+gX3muo4R80cIkV/LUKb5Kj/y0f7qMWJOyXiCXP7nqOjhVCmDgpTUWZj+dgDy9xLJWLt+CYVxeh7AvboYypU1A4NxS/Fb5g=
Received: from GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7) by
 AM7PR07MB6961.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:51:57 +0000
Received: from HE1EUR02FT065.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::8b) by GV3P280CA0011.outlook.office365.com
 (2603:10a6:150:b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Fri, 23 Sep 2022 10:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT065.mail.protection.outlook.com (10.152.11.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:51:56 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:51:55 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/3] monitor: fix printf format strings
Date:   Fri, 23 Sep 2022 12:51:40 +0200
Message-ID: <20220923105141.20176-2-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923105141.20176-1-ceggers@arri.de>
References: <20220923105141.20176-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR02FT065:EE_|AM7PR07MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: cb370287-dce5-4d28-1bc6-08da9d51a263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKq3Ecl0s1r+IhdiozL7Ffz4JicPB96aNCFRzKY56rZJg2qqyh741gZvNakKsqQPSEjB0KplexjAP/kcQnrFGfvDDyfqBQ48PsDPYX14DQspt+wMd6foNYc3MoM37SjoR8xv/re8MiQ3NEUF//5nQcjT9VVfJkLo2mrVl46Nf+ztzH8f3w3TMlbKul1KgrcTYkqt2cwGqC2JFi9D7HC+CECHz/9Y4TzmpyHFbHE5cuyIfT+a3tjgofs88KP7aQWSeNBH9bVElR0I5pn1X/9ubYyu1lWkUllGQS0olqvda7/Uf9hPK/ihFEC47Y4ihaWBK+mjIWvINaDXM0ZWLcgLVMqJkqeBLcp8cTzP17GcREslskboZNWBvA4r4h+eOy6TGNMiOafg3pZu3HgyJeFrPCHZv70R1aSsfRnN/AxPhILdF6MRPCw/cL4lvAIidvYCFpMiWv+/r2rr2ZlDebSWQyzdosC31jPZ1t45bbobwplpfTKsUm82wzEl44MmvUn6Quw77VSCoJY+V3NJZ7vuG24Ea80n15h0sbXH01ivjVXKjxmX0qubmFhF+g7cJrmmSqtSKEeSbXIRFNcH+0AAmkcrijZtBu6BmzKmeq57/pgb4J5RzCZLEt8W3ljVxd/eTRJ4VeNgSXgB7EXagqKPv/u6bTIjbxvOAyFXBsJ7a+ELP13GYCcQHsVMw9JhVe9+k62OIFFJJoy0fTasQVzMWjkbuyTrwFDdkdd3xFFL21CkI1ubXKrJVo9FK5I9OtC58dlsO6XulCCi18J6HVV2oA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39850400004)(346002)(451199015)(46966006)(36840700001)(26005)(6916009)(107886003)(36756003)(2906002)(7696005)(6666004)(1076003)(16526019)(186003)(2616005)(86362001)(70586007)(83380400001)(70206006)(4326008)(426003)(336012)(316002)(41300700001)(40480700001)(8676002)(8936002)(5660300002)(36860700001)(47076005)(81166007)(82310400005)(478600001)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:51:56.7933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb370287-dce5-4d28-1bc6-08da9d51a263
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT065.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6961
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

time_t is 64 bit (long long) on many 32 bit platforms (e.g. ARM) now
---
 monitor/analyze.c | 21 ++++++++++++---------
 monitor/packet.c  | 10 ++++++----
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index ac23e13bbd42..50e7e5542793 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -172,15 +172,18 @@ static void conn_destroy(void *data)
 	print_field("%lu RX packets", conn->rx_num);
 	print_field("%lu TX packets", conn->tx_num);
 	print_field("%lu TX completed packets", conn->tx_num_comp);
-	print_field("%ld msec min latency",
-			conn->tx_lat_min.tv_sec * 1000 +
-			conn->tx_lat_min.tv_usec / 1000);
-	print_field("%ld msec max latency",
-			conn->tx_lat_max.tv_sec * 1000 +
-			conn->tx_lat_max.tv_usec / 1000);
-	print_field("%ld msec median latency",
-			conn->tx_lat_med.tv_sec * 1000 +
-			conn->tx_lat_med.tv_usec / 1000);
+	print_field("%lld msec min latency",
+			(long long)
+			(conn->tx_lat_min.tv_sec * 1000 +
+			conn->tx_lat_min.tv_usec / 1000));
+	print_field("%lld msec max latency",
+			(long long)
+			(conn->tx_lat_max.tv_sec * 1000 +
+			conn->tx_lat_max.tv_usec / 1000));
+	print_field("%lld msec median latency",
+			(long long)
+			(conn->tx_lat_med.tv_sec * 1000 +
+			conn->tx_lat_med.tv_usec / 1000));
 	print_field("%u octets TX min packet size", conn->tx_pkt_min);
 	print_field("%u octets TX max packet size", conn->tx_pkt_max);
 	print_field("%u octets TX median packet size", conn->tx_pkt_med);
diff --git a/monitor/packet.c b/monitor/packet.c
index 1344fd5b2503..1a41498e9c52 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -384,8 +384,9 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		}
 
 		if (filter_mask & PACKET_FILTER_SHOW_TIME) {
-			n = sprintf(ts_str + ts_pos, " %02d:%02d:%02d.%06lu",
-				tm.tm_hour, tm.tm_min, tm.tm_sec, tv->tv_usec);
+			n = sprintf(ts_str + ts_pos, " %02d:%02d:%02d.%06llu",
+				tm.tm_hour, tm.tm_min, tm.tm_sec,
+				(long long)tv->tv_usec);
 			if (n > 0) {
 				ts_pos += n;
 				ts_len += n;
@@ -393,8 +394,9 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		}
 
 		if (filter_mask & PACKET_FILTER_SHOW_TIME_OFFSET) {
-			n = sprintf(ts_str + ts_pos, " %lu.%06lu",
-					tv->tv_sec - time_offset, tv->tv_usec);
+			n = sprintf(ts_str + ts_pos, " %llu.%06llu",
+				(long long)(tv->tv_sec - time_offset),
+				(long long)tv->tv_usec);
 			if (n > 0) {
 				ts_pos += n;
 				ts_len += n;
-- 
2.35.3

