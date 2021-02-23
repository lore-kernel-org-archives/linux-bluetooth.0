Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C108A64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBWTE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:19070 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhBWTE1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:27 -0500
IronPort-SDR: G+zXqgL58ymRB77nmpEz44wxVmgWK/cV9FLOR7/xM7q8nPzIst8OPb+01yQLm5N3rmqinxjY+5
 xSAvS7SKDrhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="246335927"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="246335927"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:45 -0800
IronPort-SDR: rFkaxglkSnE0P0GxuM5tb0bmuH4sbeKWiKcsLIP2J1bgNUoVZcQSrXLE7mcdgSiu9VudTaWd7U
 wrFFhn/GaKgg==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432831075"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:45 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 3/6] peripheral: Cleanup deprecated symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:49 -0800
Message-Id: <20210223190252.483784-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210223190252.483784-1-brian.gix@intel.com>
References: <20210223190252.483784-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 peripheral/efivars.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/peripheral/efivars.c b/peripheral/efivars.c
index 74fceed3e..987572b63 100644
--- a/peripheral/efivars.c
+++ b/peripheral/efivars.c
@@ -98,8 +98,7 @@ int efivars_write(const char *name, uint32_t attributes,
 	if (!buf)
 		return -ENOMEM;
 
-	fd = open(pathname, O_CREAT | O_WRONLY | O_TRUNC | O_CLOEXEC,
-				S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+	fd = open(pathname, O_CREAT | O_WRONLY | O_TRUNC | O_CLOEXEC, 0644);
 	if (fd < 0) {
 		free(buf);
 		return -EIO;
-- 
2.25.4

