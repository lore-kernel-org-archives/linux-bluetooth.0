Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D797C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B70320842
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 02:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbvpIYt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHECGL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHECGL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 22:06:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA53FC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 19:06:10 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z20so6482755qti.21
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 19:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OVuwt5e+xgXyzQNIFWeSxNVaCjdVa8/8Q/IXl45czd0=;
        b=dbvpIYt/WRicOqkDi68hfUiragxidL6czwd73bk3nvyY0rOh+cWD+TFos8g9FxeyXh
         U1tggJt7LZgD+4Ng934Gv/rd6PAGlwADBnlALJ5pR5Yafb3BpRp/zxz6vFtvexnGvqfv
         uPeK48kXWczEVEkxaVeA4sU6Bs/ytiO34j2vx6Ntpq2rvP76XPWqCTYZNfRY6D6gNz7n
         jwdDCIeW5PwbJiyxMRP7naX0TSgYEs0GRVoXFWmymVmQt/AikjcRXBSTBxC5PohBoZNR
         ONWrPfczQvP3atMQF3kkbR39hDlSCpoVEnjeV1FxaNQFbMci+2rbaeK0GEcjpELCaeG9
         fXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OVuwt5e+xgXyzQNIFWeSxNVaCjdVa8/8Q/IXl45czd0=;
        b=J/t9ThCoa4GCb28Ydt/LpQadKpr9LD6gDNx/frqDevYNyOp+K5YT2DyE/oW5JCsf59
         YuBQWK2ibHxyDj/U/LO6aiuiarYXM1Nl4ecnS/J2uLTn/xNA6FJWWUC63PKETQvN6med
         C1EXseKguW10RfsSH+tgQTJwo1EJvI9A6GpiWi8TvpDLTeCLtaQgUbunuSa77DJ03f+N
         AhWaBuFiMOxx317e4yJISuF3Ny+tVajfNmdYV8j9otpRxqnExYgeetTjoYG42BxIOlso
         IOKf6iDPDt7OxIhsERW/AEN/tRHrBAORj9/Vx1SMYqBiE3RyLEgbfcjepjPJWqkjOBr2
         +f6w==
X-Gm-Message-State: AOAM531lWNA1Bqu37ywIDXsYkJyNJECpFNR7ezP9qcvAvvUSiMGm/xQP
        vPxzOqaHSzd2+5HrVynuTBkTT7Wn8wiceHoBPRPbIyu7FL3rGgmaPHB0CUdhfeDqvm/EBiB1dVM
        AdVekRuw334HDNgoxxJp0DGxIEW5b4QstVlsZd6NL33xUQd3qxjdlYTa/VaBMYT74XALXSmZ66Y
        v91ceIoY/65uI=
X-Google-Smtp-Source: ABdhPJxqUNDS3jp47PGHBTNDk2sME/X0Dlti/WW9Pt4a9Oplcd3grM3DYayfzl9mAUjEJU4AicYM2meY8me25xNuGQ==
X-Received: by 2002:a05:6214:4e1:: with SMTP id cl1mr1325762qvb.147.1596593169940;
 Tue, 04 Aug 2020 19:06:09 -0700 (PDT)
Date:   Wed,  5 Aug 2020 10:05:36 +0800
Message-Id: <20200805100342.bluez.v3.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [bluez PATCH v3] avrcp: include all player settings in notif event
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Howard Chung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to AVRCP 1.6.2 spec section 6.7.2 table 6.39, all player
application settings should be returned to the CT and let CT to
determine which settings have changed. Currently bluez only returns
the changed attribute instead. This patch also addresses a potential
issue on which the number of application settings mismatches with
the actual number returned.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

Changes in v3:
- Rebase to master

Changes in v2:
- Fixed unused variables

 profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4e7ff75c0..5d0256c52 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -370,6 +370,7 @@ static uint32_t company_ids[] = {
 };
 
 static void avrcp_register_notification(struct avrcp *session, uint8_t event);
+static GList *player_list_settings(struct avrcp_player *player);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -744,6 +745,35 @@ static int play_status_to_val(const char *status)
 	return -EINVAL;
 }
 
+static uint16_t player_settings_changed(struct avrcp_player *player,
+						struct avrcp_header *pdu)
+{
+	GList *settings = player_list_settings(player);
+	int size = 2;
+
+	for (; settings; settings = settings->next) {
+		const char *key = settings->data;
+		int attr;
+		int val;
+
+		attr = attr_to_val(key);
+		if (attr < 0)
+			continue;
+
+		val = player_get_setting(player, attr);
+		if (val < 0)
+			continue;
+
+		pdu->params[size++] = attr;
+		pdu->params[size++] = val;
+	}
+
+	g_list_free(settings);
+
+	pdu->params[1] = (size - 2) >> 1;
+	return size;
+}
+
 void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 							const void *data)
 {
@@ -752,8 +782,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 	uint8_t code;
 	uint16_t size;
 	GSList *l;
-	int attr;
-	int val;
 
 	if (player->sessions == NULL)
 		return;
@@ -792,19 +820,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		size = 1;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		size = 2;
-		pdu->params[1] = 1;
-
-		attr = attr_to_val(data);
-		if (attr < 0)
-			return;
-
-		val = player_get_setting(player, attr);
-		if (val < 0)
-			return;
-
-		pdu->params[size++] = attr;
-		pdu->params[size++] = val;
+		size = player_settings_changed(player, pdu);
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		size = 5;
@@ -1597,7 +1613,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
 	int8_t volume;
-	GList *settings;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -1628,29 +1643,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		len = 1;
 		break;
 	case AVRCP_EVENT_SETTINGS_CHANGED:
-		len = 1;
-		settings = player_list_settings(player);
-
-		pdu->params[len++] = g_list_length(settings);
-		for (; settings; settings = settings->next) {
-			const char *key = settings->data;
-			int attr;
-			int val;
-
-			attr = attr_to_val(key);
-			if (attr < 0)
-				continue;
-
-			val = player_get_setting(player, attr);
-			if (val < 0)
-				continue;
-
-			pdu->params[len++] = attr;
-			pdu->params[len++] = val;
-		}
-
-		g_list_free(settings);
-
+		len = player_settings_changed(player, pdu);
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		len = 5;
-- 
2.28.0.163.g6104cc2f0b6-goog

