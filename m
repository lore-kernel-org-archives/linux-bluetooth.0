Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC20C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIWKwQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIWKwD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:52:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2124.outbound.protection.outlook.com [40.107.105.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE28E6DC0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2G4X1xsHUkaDbDRDsO6Mex6AuR7ZgAUJrmt9GtaZABBqmrciD3lZfWj1lWF878cWzblro7Hri51+1O/sgLpkN0wdgU1dHd3MD1t6G1jQ5/fBbNMwWcEqvW8cOjNNyIJAZNrfM50VP0lrZzgbwHpEgxSYOvCvhT/nhYJ1z4LPaB32XMkFmqwjcTfdhAEYITI5U/fSBrkKYBnyZtT/b/2hefP0bz03alus6Es3CEKUSqO33ExU9s+hQsDNwEdSPZNWMY6JQE/YsNcJ47TNZ4kdVESIYSYbIvRGi+DEVeTsxJOFua2idXVoRMoX8Xi5JRAFUBzmH3qfIuMDmULL+uuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3+hMbm3cTSXugM51pLIqBXjw+p/nBjYEDyQ0bPg38A=;
 b=Res7/YxykyaK9w+qNzX63QaLHQj4KPzZZFDa4OtnrWDZvxKHBrAGn4d8Mj4F3AbTayx+9yiX1PMnsV93GVDIcV4l0rNEyfscIqx22lezVGjHW4quKWWU2ov+1ON2vB82vi2RZ/KRXq7TbbLuTS+ulZpDuFOKgNQv1YdZnxtG9AF/I3f4N3UPhBNTBk6ufVizLQifpbNRuozkBH1JbyuBCLwxQOGCJ03DLjWyddPYNuRuhXW4lR+Sj0ZCTKtvvk6govqydSJ4EtE75WVmCfBcefRFPBl0lTZPp+aRDoDIaJZWd0VX72X8+hsGP2KekQmyy4TtAdKpudKRIm+O4hyDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3+hMbm3cTSXugM51pLIqBXjw+p/nBjYEDyQ0bPg38A=;
 b=RIIsciaqtHv89vfFkbm8sphZHoyKq5m0d+UDKHZ/zZ/vIjKREFTG3humfrce/cHmK58vrtMxvlP3c/T28wV+JSzYT4/S45kCQ2c65bo/AhC2DiW7fzb/jVuFoI2tIHugqMNrFLs4Gia630TlE+xa58UXqHI3RWMHfxi7tM/DbGQ=
Received: from GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::28) by
 DU2PR07MB8152.eurprd07.prod.outlook.com (2603:10a6:10:275::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.7; Fri, 23 Sep 2022 10:51:59 +0000
Received: from HE1EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::6e) by GV3P280CA0003.outlook.office365.com
 (2603:10a6:150:b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Fri, 23 Sep 2022 10:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT003.mail.protection.outlook.com (10.152.10.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:51:58 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:51:57 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/3] tools: fix printf format strings
Date:   Fri, 23 Sep 2022 12:51:41 +0200
Message-ID: <20220923105141.20176-3-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923105141.20176-1-ceggers@arri.de>
References: <20220923105141.20176-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR02FT003:EE_|DU2PR07MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9929d2-fadb-4186-a7c4-08da9d51a393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4ppycmGtSF1wVHXUa9jt/1a1NVz7lj6T5U5NB+LqmW0d9YDrEUO3vMztLVdh0ouMxIoPc5wgbhjhh7XSUYLCWGeogyoKm97sYnSjidyn9qGKHgoPKJZkmhPj+epTkLxDIpJKSu1w3tOwwyGQOx52FgftdTLt4h0bv7zxyGzpxoi27ffonXlCuqDjHpyTIUOJjHlAuNsDdKvVnGoeW9V0Eq/ppue4mBnM1HLhQzrCfg8xXIICqXSVARZpDixaGFjBGfdZj/iEkOqLTJNKQ2c9R5Y3I/Fu9D+e+97/5dASj4JoKYG4J6mes0QvZEy7HyE11RQBnRyHgD3DXfAQ9kGC6TLV0HMTF8tLbxGSYo+8/DOi8CQ11X2U/SunvFO8zdpJlzEo/PRH4axpEBz7UK5SkKhdjAauJ/HLzULUvy2uLqzUqLerybb+WKb7cZerM0YClbm3peLn1j7ovZYQcrnLkMY+okZU8NXsdc9zlsYcGoMyyxfRnakXf8X2qK+gaXIGkNoVsiWiZpsAlqUBu0cPoSWzWK5anPnGUvPhByQP2u0uAF1TVG45iEs7vFjPjXNHHT8Imllj+QVo6dWVCjIglx9dlV7CEBAk01bFuiV+56vLBXtrK7R5bK6fzJT3LmH73dpgFfA6VCftZUowH2MoT44JfpERr7a34oVciRUOEfQA1SHLC3uUzfyhQMYOlb6QPbeUGC19ah9qvrCxdlGEVC5KSzlAQ6SmoqG40f4IzrqMbcPOQ1S7Qv4s7ELjCb6GDHjLwtIKIJ9kWsMBIe9Wg==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(82740400003)(26005)(86362001)(4326008)(8676002)(6916009)(36756003)(41300700001)(426003)(70586007)(82310400005)(356005)(316002)(5660300002)(4744005)(2906002)(8936002)(47076005)(83380400001)(81166007)(6666004)(7696005)(107886003)(478600001)(70206006)(16526019)(186003)(36860700001)(2616005)(1076003)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:51:58.7840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9929d2-fadb-4186-a7c4-08da9d51a393
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT003.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8152
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

time_t is 64 bit (long long) on many 32 bit platforms (e.g. ARM) now
---
 tools/l2test.c | 5 +++--
 tools/rctest.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index fbaca747eaaa..5aae4b687518 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -893,8 +893,9 @@ static void recv_mode(int sk)
 					timestamp = 0;
 					memset(ts, 0, sizeof(ts));
 				} else {
-					sprintf(ts, "[%ld.%ld] ",
-							tv.tv_sec, tv.tv_usec);
+					sprintf(ts, "[%lld.%lld] ",
+							(long long)tv.tv_sec,
+							(long long)tv.tv_usec);
 				}
 			}
 
diff --git a/tools/rctest.c b/tools/rctest.c
index 9eb8210d6eb2..269503701e6b 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -500,8 +500,9 @@ static void recv_mode(int sk)
 					timestamp = 0;
 					memset(ts, 0, sizeof(ts));
 				} else {
-					sprintf(ts, "[%ld.%ld] ",
-							tv.tv_sec, tv.tv_usec);
+					sprintf(ts, "[%lld.%lld] ",
+							(long long)tv.tv_sec,
+							(long long)tv.tv_usec);
 				}
 			}
 
-- 
2.35.3

