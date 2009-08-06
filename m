Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zhu Lan <mtcb47@motorola.com>
Subject: [PATCH] Modify PBAP SDP record.
Date: Thu,  6 Aug 2009 13:03:04 -0700
Message-Id: <1249588984-9043-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Zhu Lan <mtcb47@motorola.com>

Fix to pass PTS case TC_SDAS_BV_03_I(since PTS3.2 update2).
The code tried to append the UINT type value to the supported
respositories.  However, the wrong function sdp_seq_alloc()
was used. This function adds 2 redundant bytes (SDP_SEQ8 as
0x35, seq) ahead of 0x08, so that latest PTS IOPT will fail.
According to spec, PBAP attributes should report 0x08 0x01
or 0x08 0x03 right after 0x0314. The correct function to use
is sdp_data_alloc(), with clean 0x08 0x01 appended as
SDP_ATTR_SUPPORTED_REPOSITORIES.
---
 tools/sdptool.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 5fddb82..c1fdcd4 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1829,7 +1829,7 @@ static int add_pbap(sdp_session_t *session, svc_info_t *si)
 	sdp_record_t record;
 	uint8_t chan = si->channel ? si->channel : 19;
 	sdp_data_t *channel;
-	uint8_t formats[] = {0x03};
+	uint8_t formats[] = {0x01};
 	void *dtds[sizeof(formats)], *values[sizeof(formats)];
 	int i;
 	uint8_t dtd = SDP_UINT8;
@@ -1869,12 +1869,7 @@ static int add_pbap(sdp_session_t *session, svc_info_t *si)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(&record, aproto);
 
-
-	for (i = 0; i < sizeof(formats); i++) {
-		dtds[i] = &dtd;
-		values[i] = &formats[i];
-	}
-	sflist = sdp_seq_alloc(dtds, values, sizeof(formats));
+	sflist = sdp_data_alloc(dtd,formats);
 	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_REPOSITORIES, sflist);
 
 	sdp_set_info_attr(&record, "OBEX Phonebook Access Server", 0, 0);
-- 
1.6.2.3

