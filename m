Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C587C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiIWK1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIWK0n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:26:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599E12B5FC
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/uSEvzU0ec984lS8ppYDnm+/mtVzXY8qTSepfT9zHtHEdIZceKZhF8EOrbdgxXXfjGYs8cuY/a3LJXUJ65x59OmtoX7NdG7mWX8tk7l5cKMIXlfyiFTFAhT5cn5DKW2crmfkDq+9u1JZs/Z+/eEo2Jwu6rulLCijS2wcIqee8SD3QasNEZKTIbHddwqD8ZYgeecofyi31Pn5DoZXVmBJbF+k5UeBliizL9ArZZ3ryAwSyVUDBqvDQMUjTxQqHkILVvELOLkyYFlD6C1uo+vZhSFDObSw+5/84MCggg3eQ2BuWk5WP+lMnqSIKXRJZ2OZmrJTVDtUf1jfbJui3T4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20GxCM1TBI8yh9oi30c2x/QL5EPjeVyvmbAQDgsqlyY=;
 b=b+BQVIUpc9cs/PFqXohnPZru8mTpbwsOxySOpyauJMGoyj3hn/bDX0yP2WnpI74+n04BNWaZreg8TfgzE1XVYnkQtAPhN6m9Ohviqze1tiOgSaEvnTDPM4aiBJjqI216Fp/gsZLt/slN32FruVcRf5TIrOhZ0IA/ePXx/p5pf9IXwZElK9bjneeFuvCw1FOHO0Wsfa/Z/2KchEYdN17OUHQNuAVche8UA5GJI/j3iZRKxx1aSedB37aY7rCn9ft3f+OsBF6sOfppAmjFl82+mNQYSOI7eBpZHD/sz2sFkXfrJDK94/T30ZjUQdgvfELoPDXcCR97NBMKydliGfDYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20GxCM1TBI8yh9oi30c2x/QL5EPjeVyvmbAQDgsqlyY=;
 b=xG5JkPJd/XymP1Wbueuc+ngEqrHVP8NpIFM0Vkb0UG5NbfX8+KY/NZo/6gSWL2ay2YwF26YsVyTxZKFv2A31kiTK1WPPG1ehODg/p4Xzb3F7Sa9YRYs2vrrG07pz9oOnAVL9fj8I7fxSa6em2I6u2/dMe27U0zM5zURLiQcVgXo=
Received: from AS8PR07CA0056.eurprd07.prod.outlook.com (2603:10a6:20b:459::25)
 by AS8PR07MB7669.eurprd07.prod.outlook.com (2603:10a6:20b:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:26:40 +0000
Received: from AM5EUR02FT086.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:459:cafe::77) by AS8PR07CA0056.outlook.office365.com
 (2603:10a6:20b:459::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Fri, 23 Sep 2022 10:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT086.mail.protection.outlook.com (10.152.9.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.19 via Frontend Transport; Fri, 23 Sep 2022 10:26:39 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:26:38 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 5/9] advertising: parse_[min|max]_interval: reset value if iter is NULL
Date:   Fri, 23 Sep 2022 12:26:32 +0200
Message-ID: <20220923102632.10502-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT086:EE_|AS8PR07MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c38812c-0930-40b0-85c8-08da9d4e1a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jX8/Xp9C77PAgvbVVCThDQWnsvaJB1xg8JNHrFaX0tnvTo0TR7RA2XRGEWu4tJAblanRyQf+BVFEisNZH+DHxy5ADLPs2RxIrhVzTxm+GcCfy1F5Iwo1NpoxNZ5J9tfnyLAMzX8YkVcNQ3fmJsz33L30h67bG0KKo5P0KK6UUzRikP/azQAxkgNwmCYTU6aEtFnDMa95U4bL4kkRM8shWDPVls+8UMDMlQrXAWS1+T1P5Au9tJm43hIzdafe7/4dcbj5iX2m64MrqttARpKuKJNOii6NouW8h86HiSdjdfZVRKOFRqKnxTFDPd12e76wlpPs3AX3/zJ/aZK6AbkFekFVyj0/YTd8dV9jrbFmdzK+FE6m5LYk5OJy1/DdSo0g2Kul4ic7WH51TQ9Rhxj1ozIedzzVPuIUHQkcDLcQ7KcnioNjMTAtfH4RX8KLRR4LNYYUtJni2v9TZqr04qRuF69pahIr3KjJ7PpbchIdnaueVzVP2q11Vjf88Y7HbahDY/4GJ0ooRz4hya2HRnQILp5//qeS5/gOphrqtZSUvPintrjbUvalOVENF8Aq7xnNRyF5da7RgeF0M4D8UP/F7cP+XwLbXC2IvBOa/Tm6FZ6agQzPmfxWN2GrAhPZm94pxEY/Vxq9uW1w77XAPZHKUB69KnGaNmdFjcHTciPoQJ5hH5/zvjT3buUXz++v6YyJUDVnY1vuPbRu8HxwH6oY8AT4eBnuKe7DhDEpB0E2Py3lz7MgMTglcjmZI+B4Khn+HPh9+wvc2NaMTbM3wxjOp0BOQrgpmheNXfH825E9pOzDqKoFbsjEczSZvozz87n
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(46966006)(316002)(26005)(5660300002)(4744005)(2906002)(7696005)(70206006)(82310400005)(8676002)(107886003)(41300700001)(36756003)(6666004)(8936002)(4326008)(70586007)(40480700001)(83380400001)(186003)(426003)(336012)(6916009)(16526019)(86362001)(47076005)(2616005)(478600001)(36860700001)(82740400003)(1076003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:26:39.6505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c38812c-0930-40b0-85c8-08da9d4e1a15
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT086.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7669
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index fbfd90b4e300..25df2297b3c1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1120,8 +1120,10 @@ static bool parse_max_interval(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->max_interval = 0;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 		return false;
-- 
2.35.3

