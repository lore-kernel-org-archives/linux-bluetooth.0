Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771882D7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629468; cv=fail; b=d6Z0c6AFzhEd5snSOgAD2cBwtxmk2d+Cy6f6ydaJ9yGIkUwqXHPtPw87mx+nB1Edh5f9HczkbE3IpS7lJo8HdTkyD0Ob7iOnhPmG1SMfeJE+wNFuabVgyYD3cCurraAThMe9ILaQI41UwXXDo49ALl6dB0hd9t0n70mpLVqxBLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629468; c=relaxed/simple;
	bh=cq07RZWCCJr9WcSjjywnkDUz/r6xMuO6qdxc6zOUm3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mg70SloZDCpEtzbnKBiy74EUK232Cu6vHna+zPv0GOKxxjb4rQYOk84cVA9N+QabTdiEYkL8bNDOttKA/kzI88GENAw4TZ6eGhqyWRmtc2XfAuyUaVDcEpu8r886alcfXAyX84GKTG2BXrNOBGQWBviH0VZTmHkU+YnzdxqcYTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K4aayVlW; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K4aayVlW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRZ/RPBzcMIIxf172TTWBBi+thP8/vp65i2RSQ4iaeuZwE+M7AzDJo5s+jJReSxGUttztGUj39qMmlTxwGg7arT4lcf3bI1kqtoH+RrUYqPySHqAeUrhBmiuzOas9l+Qn6Mf7L17C2z3723p1g7KcUIMUxKmhZB4tj8VW0GU3HmHWi22B/Jg7wi6a9QKbDW0ZzJFD4e9pKYW4UtdQaLc6v+8pUxa7Azsnw+qrDB5qAq+uc4RcoE+UjLgzWheZ6Ri/oy3GrSbsG1zfMTwvEXpjXCWDalS1pBPq7MoJozAThQ9ZweTfjmmzgvBxNb7ACvjuP3BmKbuup0j5S1gvFdzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s87yWYOocYHfdoe5TSnkYD3DkXqyt7MlvHqQPI+pnRs=;
 b=FXOeUtJgP/LF/Ve/duH/JPc8Dwaa6PK0iNJ/2kQFDdSVNIpzHiFcefjdMJEh5+W5wijPHE3CYW3xmU/BG9MfFSg5D1jiS0tfAKsOtZ/6LsLtMp84n2I8fEeorOqJhp2dt09WZIpDO8cUdwRErdq3h2LcgzPXTM6aMO5SvTQo0kVWPQBH+UKkhkjCfP7JuBlaAKTr+ioULhmr0sLnGG5krfqPX9cyTbSSLx1q3bHAlfKvZ7TICAIpf60kOeWIhtlb5l7gliwpF77upe61dDH9k3bFF9m7dzNe6Y6F+rA1nPk4a+qntmPZg0oV/E/gpg5x42NyhfB5At+A4bGsFQuDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s87yWYOocYHfdoe5TSnkYD3DkXqyt7MlvHqQPI+pnRs=;
 b=K4aayVlWC+2BvBIejyHqKiCLDWorc9RraXL4nOeZEICDXXVOe/a0mOmPRjRrdzM0gZ9MPGxuafBpW+LiavmmUwOk3XXGJtjCZqxTbF1ZYkmGMpO/0jqGbVraUDP1eXx4xW4qjvGpGPFHKWOkUOBhwNhtQslq6eoX/iWjZ38T1+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:44:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:44:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/4] shared/bap: Set bcast stream metadata
Date: Tue, 30 Jan 2024 17:44:10 +0200
Message-Id: <20240130154412.3157-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
References: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0261.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 51332ca0-abc6-409f-5353-08dc21aa5526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pbP0HgZEX9vo7f6oldcRtF1FaUIWGciSWSiWH88q4p5/n5niUzuFiTab+8w8+rnuEgaXU9FjdbRazGKMnq3nt9Git5mb6A9fmDBlfCIv7FJLcdddhE4R5Vd44ondSWryycvFEJJ9uoEs/3VIv4mRHmb54BJU094lOGwSI9miXwpKlIsKdVzyvDbuwLKcKu0Q6LoSMyVQDzmyoD/TyfewWFQ8f/nXsIz+9G464HzgZDcksG5T3GQBE3YNfKdnYfyroi6jjVfpZW5CvHTvHBJLW/yRGKK4y+pEQqCI1xi5qSTwVsyKZX3uzHLjcvlbVWOdDej3C1mz2p+p+FhzZ/btlCOPTU2DAOMA0CpV4g9qKedgiw4GfExm0mzY57SOmgIMyeEQLqfaxTJ1XN+kO+L008YSE/LZ4D+4e8WIxUF9aary6IwHsxDlVsR4Orsje2OKIlxqCjLDmpyKExo50ToE0UnVl0zMTlItFx47JELkB4Ah1WGbhOqmjI4v85qX+QOHSndQBv4kodtu4IVlDibbtUnj/bwOFNP87jIIgdbfo17FTjQ3/f/ZpF5xTuy//CkT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(2616005)(41300700001)(83380400001)(26005)(6666004)(478600001)(6512007)(6506007)(6486002)(2906002)(66556008)(66476007)(38100700002)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gVfwEBR4SEB1CCCQSizj3q0bWehdNP/77Uc/fXMstaiS5Th6uO0Os6VBFdPz?=
 =?us-ascii?Q?z4YVc6tojVHL05jUqEVG7p4Nzk42dM/tyBhJxiNtcUC1GAFYHrI9N7nE+EnV?=
 =?us-ascii?Q?4NHj7vTumOAmvB8xvHqVU/QdHK5i0tPiTTlsQv3J2AYWRoHUKE/lJW2WgtmK?=
 =?us-ascii?Q?tGXGnoZppgktSMp0lRhZ9ALWzJdFInM4k8/3OVCxBk+ueFhn9z740add12CA?=
 =?us-ascii?Q?waCpxqgo0pAVOsl5Z3g8vsDFb9hpfQHADgXD7cn/y+UpPwYxH1eD5cj7f0b4?=
 =?us-ascii?Q?DnQiq8Vw3Gl80zLc6GsrW2oTeMCqjoof457MPNwlleAHB4ROH8fozQdBsWAJ?=
 =?us-ascii?Q?QSsCPOHVcDVVZq+Z1+7He5ZfT+FsFcHBGZ01ETnjdCpNwP3au9CyThi9wDxh?=
 =?us-ascii?Q?AHfUuhqUKKfxEH2OTn23GtwY8+Ybmyv1wmIMbxfPLqy7/71gV1ta67MFga0m?=
 =?us-ascii?Q?aTSSRTo/e8lwCSgOc4dTrMYcz/a23OPDjMIdVTCsMXpLmhFwtea5JHbPi1M5?=
 =?us-ascii?Q?CcPEpnE82XHWqijvtZkYRBni93UgfFZN6LKI8OK1JgddsMHSECCykHUcwP0U?=
 =?us-ascii?Q?mBOiioRJwReAcB6eASqcFKx8/41v1PzsK1xPHPgSX6+jen5ok4yi6xCo3XZ5?=
 =?us-ascii?Q?0wS0EEqyrSKE0BowySVRVKnTWLx2kRtXpoveBPovVLMOmoUoPlP1uLj5C/oN?=
 =?us-ascii?Q?Gzla6I6A0abQu4QCY6mjBt0baqk/MCk6JF9gg6IgU80qDEQ6i2kDrxaKOyiF?=
 =?us-ascii?Q?2iyPM2sUZ0+RteMHAB5LN2bM2O//RakRiCI05xAlC1sAmVR01PmrGLxXFaL6?=
 =?us-ascii?Q?CKul9uGgPRu36CAjbNOZXDuU8SSzqMBpaXTHMBA+ww7O4PDOuMjh+VLnJRxB?=
 =?us-ascii?Q?yWFxSO0gdKvZm+ORpIUynv2tXxzbtM60jHnoIesVe2VLst/FLvhb3GyLmVA0?=
 =?us-ascii?Q?aoa8Usmf5Onk89d3YnsDbh1l8R3XBexi/BNcNCOVel6Epg+G/34gG0iQ1ylJ?=
 =?us-ascii?Q?7Bx6BLVjFoRysHUzFPSvqWdwCTKRGXeFaqnaaoiSkZCiHxoywa8ZT1xp9Wmn?=
 =?us-ascii?Q?MY9mn5w9RnPJcUjvW0f2jgA3Z/GOb6KUysffbVZ/YMmb4KaqSm8jD2nUVmnE?=
 =?us-ascii?Q?T4ac34Efmdbk7TQiX5nqU5rHUQwX1WKikPjdYwplvUKdKeDjb4/VIxOoTwrl?=
 =?us-ascii?Q?LyIy0ALAJLM5hf75PsVsf6w+lXU11y43lik82DepkeuKl2GcBQwEe8vUFGsW?=
 =?us-ascii?Q?LO514kZeyVERQXe6Kol+037hGE/dZI/TYJwIjjJlEnqVXvjUX9lYQOCIEJSA?=
 =?us-ascii?Q?03f62Eb2k9gbSDN0vxlrETbMIKsLmyyzTDKtBZFVQU6+xO8+dJe9w0dEAyyY?=
 =?us-ascii?Q?EgGkAT+4KBrrZ+0bOFHvHcLmQD1Nw+HazAFGuubqPvfRBIMBa9u4zyn4hZSZ?=
 =?us-ascii?Q?5htxNJn4+ibsx2dPVqnMg4bewaXDtFddrQJEGoKCeu3G6kNmaib7LYMCJXXg?=
 =?us-ascii?Q?UUs7RUL5gX/MGRwabMOtJMS9Hfe1fi+ksbat+EJou7mXyvQQIASLCq6NUeoE?=
 =?us-ascii?Q?h35FJAVZtpn30lhHtCf57Ma6y4kO9IRtNvwg8arB4q2BPgFjhFLrTLd2DQ9g?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51332ca0-abc6-409f-5353-08dc21aa5526
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:44:23.7444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXpRvknTG3QIUMxsOXcwJe4p9KHisaHfKLiRIJAkgqGZqnD/nC260wvEVO7ZZrTIPwiInCEHbBQ/tmLapfqT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

This updates bt_bap_stream_metadata to handle broadcast streams,
by setting stream medatada.
---
 src/shared/bap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 06cac5bb3..851d6a5fa 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -5114,13 +5114,21 @@ unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
 	if (!stream)
 		return 0;
 
-	if (!stream->client) {
-		stream_metadata(stream, metadata, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		if (!stream->client) {
+			stream_metadata(stream, metadata, NULL);
+			return 0;
+		}
+		return bap_stream_metadata(stream, BT_ASCS_METADATA,
+				metadata, func,	user_data);
+	case BT_BAP_STREAM_TYPE_BCAST:
+		util_iov_free(stream->meta, 1);
+		stream->meta = util_iov_dup(metadata, 1);
+		return 1;
+	default:
 		return 0;
 	}
-
-	return bap_stream_metadata(stream, BT_ASCS_METADATA, metadata, func,
-								user_data);
 }
 
 unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
-- 
2.39.2

