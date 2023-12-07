Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Vyj14fo4"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2C61AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 01:09:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR1wPrthshoF/SpJLcJ/yqI0bUGVh989dOi/XkaACBzaf3V/41z6mxck7+kfhNychCumvknG0/BxSIWO/nxiN3+QN9Jbb1wq49PtpDCW3ZimHvuxj1p5megsg+qYtGUhHIrdZkW/h4WSTpksy/vrParY9PKRFqxPwP+7PNnde2+iF+lC1pQmXgFB8XQB7rHcfUCs9ir68wNEXc/vFHxlnNt9cY/6i0jCEt4evD5KYajK7IUY7SSRPhJFxR26g9LuFXCBh9g7HdWOMF91WbJdQL+KfUO/94OaCTDhwuaNOhQhHjGL5RSqEdiLWpwzR4BoeA1ZRsWAZUCvR53QQgykgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbwxovbaFs7GesMWR1/33hTQWHArrH0wCqj67mU1u0E=;
 b=fDO0wJEb7i2HnTBcHFap+gRpIpnObbhNs2JpEorhVxfN1shBmb7SFFCUvvef7mXbj4BcJ05mcimTshVIcjttMIPi0aLoL7kMWs5LflczayHOJ01/NhcOjDTwOeFBJqA/7PZmnT9iTSOTSCuXWonlAE59WBYf7J6639WwySXPbIoTz/0CCiXSoH0hhHdEINj8NCxdaB2OVwdAgAB0NtOBZ2zqQpOR54kGlY2TA/hnd3Cyp8ebltyn+htdQTZfDf2J2ZZDaf5AU9lnTTJWy0ug2hSYvCJY4DnkfQWkVfE4FW27gfqqoh1qeysFLTApZH/v0j2X5OC8eS+t66QAiMI5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbwxovbaFs7GesMWR1/33hTQWHArrH0wCqj67mU1u0E=;
 b=Vyj14fo46iJqYW2t8DX0JN5QNoSqhP/moMoGGZNQ9n7QBlz35q6EboVUxOkXR205NcDs1yz04wLyEdYbzhXkZEZHqyLy8yJusPCF0jrsF3pYreNBPXZTbDeDh7QroiPRlovJaClKqhegNG3BoAAcL6URxoQAfagz15DPM48IGzI=
Received: from AS4P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::6)
 by AS8PR02MB9625.eurprd02.prod.outlook.com (2603:10a6:20b:5a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:09:31 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5df:cafe::1d) by AS4P250CA0001.outlook.office365.com
 (2603:10a6:20b:5df::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 09:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Thu, 7 Dec 2023 09:09:31 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 7 Dec
 2023 10:09:30 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 7 Dec 2023 10:09:30 +0100
Received: from pc51392-2240.se.axis.com (pc51392-2240.se.axis.com [10.85.128.86])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id ED2CFF617;
	Thu,  7 Dec 2023 10:09:30 +0100 (CET)
Received: by pc51392-2240.se.axis.com (Postfix, from userid 0)
	id B2F464256114; Thu,  7 Dec 2023 10:09:33 +0100 (CET)
From: Sebastian Forslund <sebastif@axis.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Sebastian Forslund <sebastif@axis.com>
Subject: [PATCH BlueZ v2] Pattern match on service- and manufacturer data
Date: Thu, 7 Dec 2023 10:09:02 +0100
Message-ID: <20231207090902.884270-1-sebastif@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207061900.194-1-sebastif@axis.com>
References: <20231207061900.194-1-sebastif@axis.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AS8PR02MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 68770163-0d80-4537-2651-08dbf7043928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mCPYk67KlMuAaJ/qGAkFBsnAV7KgFDLmOXIxdjegeSaLomFNv8XT/PzMy4g7c0l54Y6zM/NVovoM/Drvz906uLuUGoSbB3fGBNQ9IMTITjgmZJruwP3Xy6fF5DGTEN608ODsF23j2bWofkMR3wst/dSqLzOBZeBzEbfMzd8uSsUyGoueUzsACufQrrndRRDXl1TV1Hol5srCH1vCZCqt4s5RVXbjIl/9Ol5dOiQkNQhX2YhY2CTMzsXQZKwWy7NDKrYXPYcFlsF61pksUFD4SCko3UsVhG9inE00DBNgwR7J5ds7sssqPa1UshQtg7hEqnRJM2aKnbjXJwcYOXCclC+tmzI8FmhgOqyeFBa/gOzuJ13V4v5fnTCQ59Pwy7W2rZq1MlzkHZUd/8fq14ujUxGyBQ25OepCLN11RgXiYcYR/sEawnsLld/QCK5TDcE9qD1X0v6mQ1pIilfgQsC9jTQfqyzVGtXR3nyqJc39uHBXDKrFjkVpuIOg3fRp1a/9S37AOM9Sp3XDZSKj6PJXwbRkhbP/wdLaL6HrtI3pMypSJcKv79AzGV0lVXsf/aA6JvXFi3xunhd2UcZYuae6glRsVqx7GGVXseV+x7HR4h9sBJroTGQyBXctW3u2R3i+8sUlLg7apvu16TWFHMLqboRJ3xPAjlYWc3osj6xQzyOPzFWAZNlbEFZC+3av/eFdJZe/hGffEM/KO0oJsi4P+fZnKzCkOVLk3uJkdfSQQNLeRnt5Hppw3PSmebxnCjeGMRss6HXuHyYLYJ0Pw5R4iHubTB9e7A6skgl7K46BAiQ=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(40480700001)(3613699003)(4326008)(8936002)(8676002)(5660300002)(42186006)(316002)(70206006)(70586007)(40460700003)(47076005)(36860700001)(6916009)(478600001)(1076003)(2616005)(107886003)(966005)(36756003)(41300700001)(6666004)(336012)(6266002)(26005)(82740400003)(83380400001)(426003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:09:31.3607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68770163-0d80-4537-2651-08dbf7043928
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9625

When advertisement monitoring, manufacturer data and service data was
not being matched against. This made it so that advertisement monitoring
with or_patterns did not work that type of data.

We must start matching against the data in the manufacturer_data and
service_data queues. Run a different match-function depending on the
type of monitor that is being matched against.

Closes: https://github.com/bluez/bluez/issues/652
---

v1->v2: Pattern match using queue_find() instead of queue_foreach() so
        that iterations stop when a match is found. Shorten the name
        of the match functions

 src/shared/ad.c | 115 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 951c56c60..2d6fc628e 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1324,36 +1324,110 @@ struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset, size_t len,
 	return pattern;
 }
 
-static void pattern_ad_data_match(void *data, void *user_data)
+static bool match_manufacturer(const void *data, const void *user_data)
 {
-	struct bt_ad_data *ad_data = data;
-	struct pattern_match_info *info = user_data;
-	struct bt_ad_pattern *pattern;
+	const struct bt_ad_manufacturer_data *manufacturer_data = data;
+	const struct pattern_match_info *info = user_data;
+	const struct bt_ad_pattern *pattern;
+	uint8_t all_data[BT_AD_MAX_DATA_LEN];
+
+	if (!manufacturer_data || !info)
+		return false;
+
+	if (info->matched_pattern)
+		return false;
+
+	pattern = info->current_pattern;
+
+	if (!pattern || pattern->type != BT_AD_MANUFACTURER_DATA)
+		return false;
+
+	/* Take the manufacturer ID into account */
+	if (manufacturer_data->len + 2 < pattern->offset + pattern->len)
+		return false;
+
+	memcpy(&all_data[0], &manufacturer_data->manufacturer_id, 2);
+	memcpy(&all_data[2], manufacturer_data->data, manufacturer_data->len);
+
+	if (!memcmp(all_data + pattern->offset, pattern->data,
+							pattern->len)) {
+		return true;
+	}
+
+	return false;
+}
+
+static bool match_service(const void *data, const void *user_data)
+{
+	const struct bt_ad_service_data *service_data = data;
+	const struct pattern_match_info *info = user_data;
+	const struct bt_ad_pattern *pattern;
+
+	if (!service_data || !info)
+		return false;
+
+	if (info->matched_pattern)
+		return false;
+
+	pattern = info->current_pattern;
+
+	if (!pattern)
+		return false;
+
+	switch (pattern->type) {
+	case BT_AD_SERVICE_DATA16:
+	case BT_AD_SERVICE_DATA32:
+	case BT_AD_SERVICE_DATA128:
+		break;
+	default:
+		return false;
+	}
+
+	if (service_data->len < pattern->offset + pattern->len)
+		return false;
+
+	if (!memcmp(service_data->data + pattern->offset, pattern->data,
+							pattern->len)) {
+		return true;
+	}
+
+	return false;
+}
+
+static bool match_ad_data(const void *data, const void *user_data)
+{
+	const struct bt_ad_data *ad_data = data;
+	const struct pattern_match_info *info = user_data;
+	const struct bt_ad_pattern *pattern;
 
 	if (!ad_data || !info)
-		return;
+		return false;
 
 	if (info->matched_pattern)
-		return;
+		return false;
 
 	pattern = info->current_pattern;
 
 	if (!pattern || ad_data->type != pattern->type)
-		return;
+		return false;
 
 	if (ad_data->len < pattern->offset + pattern->len)
-		return;
+		return false;
 
 	if (!memcmp(ad_data->data + pattern->offset, pattern->data,
 								pattern->len)) {
-		info->matched_pattern = pattern;
+		return true;
 	}
+
+	return false;
 }
 
 static void pattern_match(void *data, void *user_data)
 {
 	struct bt_ad_pattern *pattern = data;
 	struct pattern_match_info *info = user_data;
+	struct bt_ad *ad;
+	void *matched = NULL;
 
 	if (!pattern || !info)
 		return;
@@ -1362,8 +1436,29 @@ static void pattern_match(void *data, void *user_data)
 		return;
 
 	info->current_pattern = pattern;
+	ad = info->ad;
+
+	if (!ad)
+		return;
+
+	switch (pattern->type) {
+	case BT_AD_MANUFACTURER_DATA:
+		matched = queue_find(ad->manufacturer_data, match_manufacturer,
+				user_data);
+		break;
+	case BT_AD_SERVICE_DATA16:
+	case BT_AD_SERVICE_DATA32:
+	case BT_AD_SERVICE_DATA128:
+		matched = queue_find(ad->service_data, match_service,
+				user_data);
+		break;
+	default:
+		matched = queue_find(ad->data, match_ad_data, user_data);
+		break;
+	}
 
-	bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);
+	if (matched)
+		info->matched_pattern = info->current_pattern;
 }
 
 struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
-- 
2.39.2

