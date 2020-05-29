Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 05:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3ED2074B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 05:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7KQVVzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgE2FbL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 01:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2FbL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 01:31:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1DC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 22:31:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n7so1733822ybh.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EPgk7zabpyB5rlEgy6P4j0ZSI9fA9lptxyM7WLNbnX8=;
        b=C7KQVVzLCZXBOIzajuqP4RY59K46jLNuij3fL5a/NKF1285zopDIAywj98j8qEF0Dj
         na7V5jEnWg5W2DoqTK4k9H2/cpwFaVwxH96rXtp9OrimCodUzHoLb2G+gWacTniA512L
         RY8rUceXYJzcimNVZGnM6T6sNwzna+buSChEa/T+U/rFyFNhUmqoKwo1h6rWhIhED+3e
         aZhM5jisGiUv/LINgfR1lNRI7QNXuA5NtBzWZiKRb7XpK4dZPmaQ/l/bZOSYAe8foI/V
         3Iglx1KwuvDKKVQFZqcUENnVK7ZQ3yaLghU0eEI6RAtqWD3vgb9OhjLm/xMXe2m7IzQz
         LsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EPgk7zabpyB5rlEgy6P4j0ZSI9fA9lptxyM7WLNbnX8=;
        b=tMNvfdD0HHezvUKC5gTT6bbxRoxFJOy7C8O7UODWDW5uDQGXX0aWeEItpQCbUFxm6N
         bJveKorEXFvB5NjxHDbDsUgCXZyhpZgFU3dYbAIAChl7lBFv0GKn2TUD/bJyeHr5Syeo
         vDhejVj0HS9pU6SAKrO1j2B62xRwZUrA06sSoXImNZzi6/uHq5i511lXXjlkebhYI2nn
         5acuNAdBj4ik3RHVoWXFK90NAU4qrY7233Jpw11OdIdPwOCJ3CoUH5r4EaWjjuCfy7td
         GtR2n1Da746Pw0u+JiE3ocTyZQYrX8jWH8t0mYwJ1XVcW3BG/jFhFS/+8kvhmMZUVLp9
         0Low==
X-Gm-Message-State: AOAM530AbvWdMjoIu3gx/lfrx68Z539vhY9z8iDmtBwCBPbLOxGmx3vB
        fQrithX382oHcZse+gnRznGkS8fPJS9ys/fKuVylxi3Lnq8EGQNlZAnWIUKJ8apvp8rXNS2du8b
        nknnY16vsOMtEsgnhD2UM0V4pVlaevQ7DVI0rK9VdS2rWat0v3S4c61ZaFZNWHgBNIFPyMc1Pje
        3q
X-Google-Smtp-Source: ABdhPJwdOyPMiL2xU67Kf9Zxsh1ynAIvFoM2YHwRlfG/w6Qk2HOt6bJlMY528S/XVrMgRG1E5LcKPo7Buf7S
X-Received: by 2002:a25:3295:: with SMTP id y143mr1023987yby.321.1590730269983;
 Thu, 28 May 2020 22:31:09 -0700 (PDT)
Date:   Fri, 29 May 2020 13:31:04 +0800
Message-Id: <20200529133023.Bluez.v3.1.I804fb280949e4ce5cd9d0fce544a6f1a0592d11b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [Bluez PATCH v3] audio/avrcp: Fix media player passthrough bitmask
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Michael Sun <michaelfsun@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adjust the values of the passthrough bitmask with the declared
keys in avctp.c:key_map, according to section 6.10.2.1 of the
AVRCP specification.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v3:
- Use table to map the passthrough bitmask instead of hardcoding

Changes in v2:
- Fix the mix-up between the first 4 and the last 4 bits of each
octet

 profiles/audio/avctp.c | 11 +++++
 profiles/audio/avctp.h | 11 +++++
 profiles/audio/avrcp.c | 93 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 058b44a8b..7307eaa9e 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -2222,3 +2222,14 @@ bool avctp_is_initiator(struct avctp *session)
 {
 	return session->initiator;
 }
+
+bool avctp_supports_avc(uint8_t avc)
+{
+	int i;
+
+	for (i = 0; key_map[i].name != NULL; i++) {
+		if (key_map[i].avc == avc)
+			return true;
+	}
+	return false;
+}
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 68a273561..c3cd49d88 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -54,7 +54,12 @@
 #define AVC_DOWN			0x02
 #define AVC_LEFT			0x03
 #define AVC_RIGHT			0x04
+#define AVC_RIGHT_UP			0x05
+#define AVC_RIGHT_DOWN			0x06
+#define AVC_LEFT_UP			0x07
+#define AVC_LEFT_DOWN			0x08
 #define AVC_ROOT_MENU			0x09
+#define AVC_SETUP_MENU			0x0a
 #define AVC_CONTENTS_MENU		0x0b
 #define AVC_FAVORITE_MENU		0x0c
 #define AVC_EXIT			0x0d
@@ -72,9 +77,11 @@
 #define AVC_9				0x29
 #define AVC_DOT				0x2a
 #define AVC_ENTER			0x2b
+#define AVC_CLEAR			0x2c
 #define AVC_CHANNEL_UP			0x30
 #define AVC_CHANNEL_DOWN		0x31
 #define AVC_CHANNEL_PREVIOUS		0x32
+#define AVC_SOUND_SELECT		0x33
 #define AVC_INPUT_SELECT		0x34
 #define AVC_INFO			0x35
 #define AVC_HELP			0x36
@@ -95,6 +102,8 @@
 #define AVC_FORWARD			0x4b
 #define AVC_BACKWARD			0x4c
 #define AVC_LIST			0x4d
+#define AVC_ANGLE			0x50
+#define AVC_SUBPICTURE			0x51
 #define AVC_F1				0x71
 #define AVC_F2				0x72
 #define AVC_F3				0x73
@@ -108,6 +117,7 @@
 #define AVC_GREEN			0x7b
 #define AVC_BLUE			0x7c
 #define AVC_YELLOW			0x7c
+#define AVC_VENDOR_UNIQUE		0x7e
 
 struct avctp;
 
@@ -183,3 +193,4 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 int avctp_send_browsing_req(struct avctp *session,
 				uint8_t *operands, size_t operand_count,
 				avctp_browsing_rsp_cb func, void *user_data);
+bool avctp_supports_avc(uint8_t avc);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 773ccdb60..fa97a3a89 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -293,15 +293,75 @@ struct control_pdu_handler {
 							uint8_t transaction);
 };
 
+static struct {
+	uint8_t feature_bit;
+	uint8_t avc;
+} passthrough_map[] = {
+	{ 0, AVC_SELECT },
+	{ 1, AVC_UP },
+	{ 2, AVC_DOWN },
+	{ 3, AVC_LEFT },
+	{ 4, AVC_RIGHT },
+	{ 5, AVC_RIGHT_UP },
+	{ 6, AVC_RIGHT_DOWN },
+	{ 7, AVC_LEFT_UP },
+	{ 8, AVC_LEFT_DOWN },
+	{ 9, AVC_ROOT_MENU },
+	{ 10, AVC_SETUP_MENU },
+	{ 11, AVC_CONTENTS_MENU },
+	{ 12, AVC_FAVORITE_MENU },
+	{ 13, AVC_EXIT },
+	{ 14, AVC_0 },
+	{ 15, AVC_1 },
+	{ 16, AVC_2 },
+	{ 17, AVC_3 },
+	{ 18, AVC_4 },
+	{ 19, AVC_5 },
+	{ 20, AVC_6 },
+	{ 21, AVC_7 },
+	{ 22, AVC_8 },
+	{ 23, AVC_9 },
+	{ 24, AVC_DOT },
+	{ 25, AVC_ENTER },
+	{ 26, AVC_CLEAR },
+	{ 27, AVC_CHANNEL_UP },
+	{ 28, AVC_CHANNEL_DOWN },
+	{ 29, AVC_CHANNEL_PREVIOUS },
+	{ 30, AVC_SOUND_SELECT },
+	{ 31, AVC_INPUT_SELECT },
+	{ 32, AVC_INFO },
+	{ 33, AVC_HELP },
+	{ 34, AVC_PAGE_UP },
+	{ 35, AVC_PAGE_DOWN },
+	{ 36, AVC_POWER },
+	{ 37, AVC_VOLUME_UP },
+	{ 38, AVC_VOLUME_DOWN },
+	{ 39, AVC_MUTE },
+	{ 40, AVC_PLAY },
+	{ 41, AVC_STOP },
+	{ 42, AVC_PAUSE },
+	{ 43, AVC_RECORD },
+	{ 44, AVC_REWIND },
+	{ 45, AVC_FAST_FORWARD },
+	{ 46, AVC_EJECT },
+	{ 47, AVC_FORWARD },
+	{ 48, AVC_BACKWARD },
+	{ 49, AVC_ANGLE },
+	{ 50, AVC_SUBPICTURE },
+	{ 51, AVC_F1 },
+	{ 52, AVC_F2 },
+	{ 53, AVC_F3 },
+	{ 54, AVC_F4 },
+	{ 55, AVC_F5 },
+	{ 56, AVC_VENDOR_UNIQUE },
+	{ 0xff, 0xff }
+};
+
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
-/* Default feature bit mask for media player as per avctp.c:key_map */
-static const uint8_t features[16] = {
-				0xF8, 0xBF, 0xFF, 0xBF, 0x1F,
-				0xFB, 0x3F, 0x60, 0x00, 0x00,
-				0x00, 0x00, 0x00, 0x00, 0x00,
-				0x00 };
+/* Default feature bit mask for media player */
+static uint8_t default_features[16];
 
 /* Company IDs supported by this device */
 static uint32_t company_ids[] = {
@@ -490,6 +550,22 @@ static sdp_record_t *avrcp_tg_record(void)
 	return record;
 }
 
+static void populate_default_features(void)
+{
+	int i;
+
+	for (i = 0; passthrough_map[i].feature_bit != 0xff; i++) {
+		if (avctp_supports_avc(passthrough_map[i].avc)) {
+			uint8_t bit = passthrough_map[i].feature_bit;
+
+			default_features[bit >> 3] |= (1 << (bit & 7));
+		}
+	}
+
+	/* supports at least AVRCP 1.4 */
+	default_features[7] |= (1 << 2);
+}
+
 static unsigned int attr_get_max_val(uint8_t attr)
 {
 	switch (attr) {
@@ -1913,7 +1989,8 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		item->subtype = htonl(0x01); /* Audio Book */
 		item->status = player_get_status(player);
 		/* Assign Default Feature Bit Mask */
-		memcpy(&item->features, &features, sizeof(features));
+		memcpy(&item->features, &default_features,
+					sizeof(default_features));
 
 		item->charset = htons(AVRCP_CHARSET_UTF8);
 
@@ -4578,6 +4655,8 @@ static int avrcp_init(void)
 	btd_profile_register(&avrcp_controller_profile);
 	btd_profile_register(&avrcp_target_profile);
 
+	populate_default_features();
+
 	return 0;
 }
 
-- 
2.27.0.rc2.251.g90737beb825-goog

