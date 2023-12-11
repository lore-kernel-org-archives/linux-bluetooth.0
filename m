Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/shY9Mg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEBB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 00:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702282976; x=1733818976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i86niv1nqiMIApRSykL6cnQkSDRcfNNPYZ2lRUuTGfU=;
  b=F/shY9Mgn0Ei1IbhaQCr4QuGkjSUWE/gLRjbaicxTXsKm3fTrsvz4J7l
   thw4CLpXfYuVIJN791t9Xs+eCe8F/Pairlx8rFRF6F+GrBHWZQZZPUmIY
   SQTdtWcHI3UGUQjUlMzO2mJ4vb2BLJpI4voOWtwr8KikhoEvP9X9zntFE
   hLvXVWYig2rjVy447VQcMTsRXawEGvyzbprrSN/mP38aSPvbym96aECnX
   3HLPid/Co5571UfFveB6QnKffrCo/XMxJXHwdk7HbgJ/Wah7WiavYfmLj
   lebcNIQdMJ8LQKY6UnXP8OZzHiHPBVtpmbNR8Y+41/hW/MqLaZauPNC8J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1422652"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1422652"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 00:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776582596"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="776582596"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2023 00:22:54 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH] shared/bap: Update Available context for source
Date: Mon, 11 Dec 2023 14:05:07 +0530
Message-Id: <20231211083507.3363494-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Available Context of sink was getting updated instead of source.
---
 src/shared/bap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a1495ca84bcc..e9d7072ef3be 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2599,13 +2599,13 @@ static void pacs_add_source_supported_context(struct bt_pacs *pacs,
 
 static void pacs_add_source_context(struct bt_pacs *pacs, uint16_t context)
 {
-	context |= pacs->supported_sink_context_value;
+	context |= pacs->supported_source_context_value;
 
 	/* Check if context value needs updating */
-	if (context == pacs->sink_context_value)
+	if (context == pacs->source_context_value)
 		return;
 
-	pacs->sink_context_value = context;
+	pacs->source_context_value = context;
 
 	pacs_context_changed(pacs);
 }
-- 
2.34.1

