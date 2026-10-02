Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126103E51FC
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971232; cv=none; b=OooGflxFubwegO3wKCPTda/VH+zQX8GFbh1QbISAz2xofkjjKeK2/vDTSJvFkuAbNZkgzk6Z3sO1CGEmlTFvO99B2ho23Jys3MT9rlPPDA76zOe9ESclNfZ5uJub/1scy3jYdIPyGGbpa10S1/e6/TA10V8mKxv/cs4f8/M4jOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971232; c=relaxed/simple;
	bh=TnLbqHu7hZk5AUcux5mvOHmMzTwiL19goOXH3tx+S4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESZ8jXMsd8aXoIm1FB9KJDtjg7oAFbSC+hhXKNaFlYyT9YibkgOnyVP/bckWfW42YVfIij+eZnbiW76WH8vE6rlZjOPcSueY9s4qaRwnX8aqB5HH19/XnafPPoIgZ76++NAR6hO5YiStCD6ZDedpHg2xigbhcohnCltuNjwYbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=aq1tiQPC; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="aq1tiQPC"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-34ca2d54925so276519eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790971230; x=1791576030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuxIxJbBIpx1OAiNphA+yHHl0huEQVvnjzWRLX6bF+c=;
        b=aq1tiQPC3EoUvpOgVqadQZw3Sdce4vYhUMAHxCWDg0ESHyofloVMboQew4lulxtJhG
         SgOHJoNRcBZ6ZnAAECEMG+Ql1xy5NtsatS5RQmW2lWqMWGO7xL1+vTINzpX/cm5wld0P
         2pmjzTP7TiccZ9rJWx2UkaeL/pgFZKel+xRHaLfWLd3EPAEjQ4X31CVwxo2MowS+vzO4
         tC4lJrYSNt5q7Aj+RTSH6/eLaxkRBb13z2nlVoeqm9KltwXuHCitlo31f4bxp0IyObYZ
         G7R5jOPpfAEZv5EaNd5DB++8U3N22FtionNRD+2i4acO+3g6FiNsAR+KVubrpryPfkWb
         bmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971230; x=1791576030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuxIxJbBIpx1OAiNphA+yHHl0huEQVvnjzWRLX6bF+c=;
        b=EAXkwykZK2bsUtAUe2kF4W2byMajZFtzZchFHCvdRdGuILT7gsx11pkpoG1wepCj39
         AD7BO1Fs7Sf9Ua3X61UrH6t/W/kXkOXRluFhrg2R7YeE5Yb/mVqf6NB/WirSQgfbL3EM
         Cc+UtfNzJDkJG6kKortd3ZkTTwfvZQAWML1U8lw3xVpsglzVDuwDBBxnSaRP9dQ1ho3q
         Mc1oG4XXR0H4sX9SiVDtSHRF44t3tUyqYJXvjLT81d93Bx0scGvlu4gn8vFFDsUHKVkG
         stgfM1r+vKONBj5a/3q7rzmUi18AKb81D26XuBbAitI/nnyggvti+if/M3nOtTqu5Ad0
         FWnQ==
X-Gm-Message-State: AFq9FYKTWd/8uCuhzNUp4WFL9UbrvISXsE4HaSAeeg/X7lQ0jswmDflE
	zsc4YU7yIUrs7DDdSjlU7LsWpI5zRB4A+BD0M/vQi+n8LspC62wlCPwX/zBW0b8U9qNfT8h0zhn
	jgQQR/4I=
X-Gm-Gg: AYBFou1e1vQ6Ri6KmFIHCLznRQDOm793IrmTb2ug6vmx6Dt7pIsLWi4lF6qJ8TuZRbS
	ZXNHgg3KHcNVIs/XKW5xeitAUIa25Y+aErDuWHIG7dUH5gNth6DoBJkBTRM0VOvb4IUCxB/vQrf
	P/t9v88wk+jbQDym+zEegmGRmGZ+2ZPZZ00sA6aO1oAigQFE5TzwrpuDIcgFV2DAzy++9gSMKvn
	uOAcia3VkPAAnrfrSqPDBBJRbjrBp0DDw42AfKQSs7GxsD+2g7vhVFZp6Uv69o6E+uYfkgptoED
	YfrdJtMDzwfTACTxgAdx8jLsRpIXev7gUk9+fLwUbD7LMPylfJBTGUY3NHSYKIeNzzmkfGjnro4
	QEvCNbooRVdy6rrKV0WanYckwgXivJq1t2oFspVIhM4APK8FSEVLgasqDAqfYM+k+wTD3FwZh1Q
	6jeI0/Up+u4fJziZ4jC+k8RQbWb0HkUDD/fufmbJURfxbfPAjcXnSNu457NyzkFtyZ6GcNMPZ1w
	geYEzB8RzTtCBT/G0elv6g9+K81G23rsbGyHz78ISEweFSVt/j72SngT3JSXG1WTFd3J+9tiWdT
	HMvKWVNwG6ejsZQYa3unWlHOSDnfaWCFDd4fNfkm
X-Received: by 2002:a05:693c:8809:20b0:314:267f:46e2 with SMTP id 5a478bee46e88-351114743e7mr691014eec.20.1790971229553;
        Fri, 02 Oct 2026 13:00:29 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35105835bf8sm6269508eec.9.2026.10.02.13.00.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:00:29 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ] monitor: Fix legacy SCAN_RSP PDU type names
Date: Fri,  2 Oct 2026 13:00:25 -0700
Message-ID: <20261002200025.4418-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The names of the two legacy scan response event types are swapped. A
scan response keeps the properties of the advertisement it answers, so
0x1b, which has the connectable bit set, is the response to ADV_IND and
0x1a is the response to ADV_SCAN_IND, as listed in Core Specification
Vol 4, Part E, 7.7.65.13, Table 7.1.

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5.5
---
 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 8450347fc..5b289ad9f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13074,10 +13074,10 @@ static void print_legacy_adv_report_pdu(uint16_t flags)
 		str = "ADV_DIRECT_IND";
 		break;
 	case 0x1a:
-		str = "SCAN_RSP to an ADV_IND";
+		str = "SCAN_RSP to an ADV_SCAN_IND";
 		break;
 	case 0x1b:
-		str = "SCAN_RSP to an ADV_SCAN_IND";
+		str = "SCAN_RSP to an ADV_IND";
 		break;
 	default:
 		str = "Reserved";
-- 
2.54.0 (Apple Git-157)

