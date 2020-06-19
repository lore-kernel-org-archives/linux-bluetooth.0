Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41090C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C4A21548
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 18:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgFSSfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:35:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:3425 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388046AbgFSSfJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 14:35:09 -0400
IronPort-SDR: UbyXNNBdMN3By+RzqX82d1W7P9OkG02m0U5x9Yor4oD5lwlDfbnaqNvfISelKoRmFUOEGomSdJ
 uxtK0urx/RTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="142134880"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="142134880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 11:35:06 -0700
IronPort-SDR: YbuptxrN76HaEXTGK1GHOICxy5tPkaU0Zjarz852CR/N1DVb4RpVGxveTriSOf6KeO+2xKTVc3
 q3qyonAQOGIg==
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="300155240"
Received: from han1-mobl3.jf.intel.com ([10.254.73.18])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 11:35:06 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2 2/2] midi: Fix random empty timestamp_high value
Date:   Fri, 19 Jun 2020 11:34:56 -0700
Message-Id: <20200619183456.38696-2-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619183456.38696-1-tedd.an@linux.intel.com>
References: <20200619183456.38696-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The timestamp_high value is assigned from the monotonic time but there
is a chance that the value becomes zero because it reads the value
between bit8 and bit13.

This patch makes sure the timestamp_high value get a non-zero value.
---
 profiles/midi/libmidi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index 7d57e7335..cb2787db1 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -77,8 +77,13 @@ inline static void append_timestamp_high_maybe(struct midi_write_parser *parser)
 	if (midi_write_has_data(parser))
 		return;
 
-	parser->rtime = g_get_monotonic_time() / 1000; /* convert µs to ms */
-	timestamp_high |= (parser->rtime & 0x1F80) >> 7;
+	/* Make sure timesampt_high is assigned a non-zero value */
+	do {
+		/* convert µs to ms */
+		parser->rtime = g_get_monotonic_time() / 1000;
+		timestamp_high |= (parser->rtime & 0x1F80) >> 7;
+	} while (timestamp_high == 0x80);
+
 	/* set timestampHigh */
 	buffer_append_byte(&parser->midi_stream, timestamp_high);
 }
-- 
2.25.4

