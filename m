Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A8C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C547207DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgFSGCS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:02:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:62658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgFSGCR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 02:02:17 -0400
IronPort-SDR: nkjL9Zaku2r7rx9bwAzeSBRYClOqHoQVcPGLwdbm69gdyJLYnqVB+4lNkn+ONFOjNaGT6Kl6VS
 PTeAALcNoE7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="160959305"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="160959305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:02:16 -0700
IronPort-SDR: Cri10xhoXyryAsw8EPxLQblO0+GwKcCJIGArw5xtGo1VwaIsuNSg5f00lhC9FZgy02/ylGxvb9
 aM4pT+eeJ00g==
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="299948784"
Received: from han1-mobl3.jf.intel.com ([10.255.228.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:02:16 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 2/2] midi: Fix random empty timestamp_high value
Date:   Thu, 18 Jun 2020 23:01:53 -0700
Message-Id: <20200619060153.65114-2-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619060153.65114-1-tedd.an@linux.intel.com>
References: <20200619060153.65114-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The timestamp_high value is assigned from the monotonic time but there
is a chance that the value becomes zero becuase it reads the value
between bit8 and bit13.

This patch makes sure the timestamp_high value get a non-zero value.
---
 profiles/midi/libmidi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index cc5f079e7..fd40b038b 100644
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

