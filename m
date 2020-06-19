Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9903AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED2020809
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 06:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFSGCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:02:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:62658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgFSGCR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 02:02:17 -0400
IronPort-SDR: GKXkgBj8BqMtQ9z+ZLcTyXSC0LnfNbNh3twvHRShGUBanc/U1/3XhUss1AcZ0VOYLrHQlbTa3/
 VxTGsCZnHrpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="160959304"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="160959304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:02:16 -0700
IronPort-SDR: ya9aubVcVbEmltdD1cyVhWk6pi0VBuGXcn6SpJbgKjFRHKUKXU3dJIygpxh5kz7S5e2uan5j3i
 KD3NPB8veiBQ==
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="299948780"
Received: from han1-mobl3.jf.intel.com ([10.255.228.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:02:16 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 1/2] midi: Fix SysEx parser in MIDI plugin
Date:   Thu, 18 Jun 2020 23:01:52 -0700
Message-Id: <20200619060153.65114-1-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The SysEx end of message parser didn't consider the fact that
timestampsLow are in the stream and it might have the EOX (F7)
byte as well.

Fix that by always assuming the first system message byte is
the timestampLow.

Future work would involve support other type of system message
bytes, such as real-time.
---
 profiles/midi/libmidi.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index 4b4df799f..cc5f079e7 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -331,6 +331,24 @@ static size_t handle_end_of_sysex(struct midi_read_parser *parser,
 	return sysex_length + 1; /* +1 because of timestampLow */
 }
 
+/* Searches the end of a SysEx message that contains a timestampLow
+ * before the SysEx end byte. Returns the number of bytes of valid
+ * SysEx payload in the buffer.
+ */
+static size_t sysex_eox_len(const uint8_t *data, size_t size)
+{
+	size_t i = 0;
+
+	MIDI_ASSERT(size > 0);
+
+	if (data[i] == 0xF0)
+		i++;
+
+	/* search for timestamp low */
+	while (i < size && !(data[i++] & 0x80));
+
+	return (i < size && data[i] == 0xF7) ? i : 0;
+}
 
 
 size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
@@ -368,14 +386,13 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
 
 		/* System Common Messages */
 	case 0xF0: /* SysEx Start */ {
-		uint8_t *pos;
+		size_t sysex_length;
 
 		/* cleanup Running Status Message */
 		parser->rstatus = 0;
 
-		/* Avoid parsing if SysEx is contained in one BLE packet */
-		if ((pos = memchr(data + i, 0xF7, size - i))) {
-			const size_t sysex_length = pos - (data + i);
+		/* Search for End of SysEx message in one BLE message */
+		if ((sysex_length = sysex_eox_len(data + i, size - i)) > 0) {
 			midi_size = handle_end_of_sysex(parser, ev, data + i,
 			                                sysex_length);
 		} else {
@@ -424,10 +441,9 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
 
 		/* Check for SysEx messages */
 		if (parser->sysex_stream.len > 0) {
-			uint8_t *pos;
+			size_t sysex_length;
 
-			if ((pos = memchr(data + i, 0xF7, size - i))) {
-				const size_t sysex_length = pos - (data + i);
+			if ((sysex_length = sysex_eox_len(data + i, size - i)) > 0) {
 				midi_size = handle_end_of_sysex(parser, ev, data + i,
 				                                sysex_length);
 			} else {
-- 
2.25.4

