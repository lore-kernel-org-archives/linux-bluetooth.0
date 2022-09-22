Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE0C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIVUjF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVUjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 16:39:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438C10FE36
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879143; x=1695415143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/8bFXfOWOYZHDmz6XJVqzOoNa/jh+Be6th6yI3AMG0=;
  b=cYMT3p45fPz+zy7HTCT6DPQhZV7erYeaVYn0CWsxZnE6+aOyCSqa+2Io
   Bv5VQfKCzB29R40ekK8XGRkmenpjry95fXwQtRUMkS+yUn9c0fmnCpjlu
   qMOwQA1tyHCaMUaFF8YO+DRJirVdTomeMWotir1xZsQWWcPxfA5GBgNJZ
   QPB3tL81UDL83wyGrR2qQ7xjYFh7u+kI8xUnAbRhJG+g4HG1V4a6OYHBz
   VtinPJfHEBY5Sr9YUuI1dEom8OtjGVWp0yFr008vWyeS9bVcISR8V8DQs
   CGT8KjmY7P+/0LkXCrQgQo18iVN+sVuWTWWZ+ktr06OM0nqHtzjN2rAQ8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301303195"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301303195"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865028669"
Received: from mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.23.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ 2/4] lib: Add defines of new MGMT opcodes and events
Date:   Thu, 22 Sep 2022 13:38:50 -0700
Message-Id: <20220922203852.494315-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922203852.494315-1-brian.gix@intel.com>
References: <20220922203852.494315-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Populated new opcodes and events into static mgmt_ev and mgmt_op string
arrays.
---
 lib/mgmt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 79b77d31a..796190cd9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1170,6 +1170,10 @@ static const char *mgmt_op[] = {
 	"Add Extended Advertisement Parameters",	/* 0x0054 */
 	"Add Extended Advertisement Data",
 	"Add Advertisement Patterns Monitor RSSI",
+	"Set Mesh Receiver",
+	"Read Mesh Features",
+	"Mesh Send",
+	"Mesh Send Cancel",
 };
 
 static const char *mgmt_ev[] = {
@@ -1222,6 +1226,8 @@ static const char *mgmt_ev[] = {
 	"Controller Resume",
 	"Advertisement Monitor Device Found",		/* 0x002f */
 	"Advertisement Monitor Device Lost",
+	"Mesh Packet Found",
+	"Mesh Packet Complete",
 };
 
 static const char *mgmt_status[] = {
-- 
2.37.3

