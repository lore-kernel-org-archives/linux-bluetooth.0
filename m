Return-Path: <SRS0=nBj1=AW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jul 2020 11:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7AA2065F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jul 2020 11:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMgxq6Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGKLuo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgGKLuo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jul 2020 07:50:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7BC08C5DD
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2020 04:50:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so8835753ejn.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2020 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkW096i9+5eJN3hC9xnduzvQMW/1zVfzh2PG2TAfy8M=;
        b=eMgxq6ZoWFzYQoKI3cTKexXvHnPBVTGlPr9Oo9Q3zhkHhbK7ChUOZATS6lbMNL6lRb
         x36o661wz3NACkCf9kIXoNJP6WktfEed1fw18HulFD8W+LdYVS2TdleN8jYU/NoZIIH2
         l/fDMfUyHKTnht0xPu+izxNxFwFVfHS/MKoxXCpwnO+tVkZoJo/TDk+qsTkz9YnPT09y
         M26LtxU+mg8wDSGUy5TyhUbi8FQxvLYTX2CqmLjrCrPhGz+Wp4zWFAPzSxMYn5lfNXIa
         9xviThxuVv0kwqkduMr1Jj8A3SHpL2ETmCTNPNwuT3zzUoDkarcSaRdxusIvrRKNPLoV
         u+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KkW096i9+5eJN3hC9xnduzvQMW/1zVfzh2PG2TAfy8M=;
        b=a97uCAiN135cuigNw+eNbwtHaq3/ZtB+ZH2VX+kkEvtJUgt27kD5O7iNB/SFGovqy3
         54KL3PuqUGEucMWsdmoN5Q9Rm0doYheN/vkGn017/oUhhnwQYYwNVW2BNW/s4owmux1Q
         7zAUEWIAoLrK/OxCnMjezk4TqHDAy7lM7mDVrOcHzb8m665PDZ9VT9tnRxvFMZ3dFVey
         Iv2SOANNfsweFq0IbaBSO4YtrQVUoHWv7Wo8FLKvqHyBeTSNANU6hSyw/J29I5pl1tvC
         TrIwl8liIV9Alo3KS415R9oHKw9yM3VInQZlkOkbXHLD2kZ9RXUpXwRiI8EFZJBr9i+q
         vUXA==
X-Gm-Message-State: AOAM533N10VYesTU3skNr4My9QR9TbmVmzwG6qy+hbTLqjWhkHeVPB62
        HQXcLXZAgRBzngiGk1VE/jeKn8yx
X-Google-Smtp-Source: ABdhPJw4aq4c7+W4Mo80DxFnzU/SqcTew2qkvtzdGQJ3aHi73puH/kliYhhFOENkWsuneyrMubPBuA==
X-Received: by 2002:a17:907:9484:: with SMTP id dm4mr68635641ejc.56.1594468242158;
        Sat, 11 Jul 2020 04:50:42 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id d26sm5425462ejw.89.2020.07.11.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 04:50:41 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH BlueZ] audio/avrcp: Always update transport volume regardless of player
Date:   Sat, 11 Jul 2020 13:50:31 +0200
Message-Id: <20200711115031.123793-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

`Volume` is a special property that not only exists on players but also
on the transport (see org.bluez.MediaTransport1). A player is not
attached when the controller does not support FEATURE_CATEGORY_1, which
is common on headphones without media browsing capabilities.

On such audio devices (headphones, in-ears and the like) Absolute Volume
is not available unless an external player is registered
(org.bluez.Media1.RegisterPlayer) and the device sends a volume event
back after that to set a2dp->volume in transport.c to a valid value
(causing volume_exists to finally return true).

This [1] mail thread denoting the same issue has a solution to at least
request capabilities from the controller, but the proposed player object
is not created on category 2 devices. Any notifications received on
AVRCP_EVENT_VOLUME_CHANGED (avrcp_volume_changed) that is subsequently
registered, or handling the result of avrcp_set_volume in
avrcp_handle_set_volume will be ignored unless said player is present.

This issue is not addressed by adding a fake player but instead dealing
with the fact that volume is "special" and available on the transport
regardless of the existence of a player. This is confirmed in
avrcp_get_capabilities_resp as well which requires a player to register
any event except AVRCP_EVENT_VOLUME_CHANGED.

The applied solution moves media_transport_update_device_volume out of
the player and into avrcp_volume_changed/avrcp_handle_set_volume where
it is unconditionally called. These functions are the only users of
avrcp_player->set_volume.

Note that the volume member of media_player is never used which seems a
result of updating from org.bluez.MediaPlayer1 to
org.mpris.MediaPlayer2.Player in
15e421737ccc4696ed567edcc24d178aedb47854, where the volume property [2]
is left out.

[1]: https://marc.info/?l=linux-bluetooth&m=145337574806153
[2]: https://specifications.freedesktop.org/mpris-spec/2.2/Player_Interface.html#Property:Volume

---
Hi,

This is is a resend from an earlier mail that didn't comply with the
contributor guidelines. Seeing that the topic of AVRCP volume is brought
up recently it is about time to repair it and hereby send it again.

I still have an incomplete patch lying around that synchronizes Volume
on org.mpris.MediaPlayer2.Player back when this patch was written 6
months ago. It'll require some time to get back in to it and finalize
it, let me know if that's desired.

- Marijn Suijten

 profiles/audio/avrcp.c | 12 ++++++++----
 profiles/audio/media.c | 16 ----------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e2428250e..8370c8a44 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3625,12 +3625,13 @@ static void avrcp_volume_changed(struct avrcp *session,
 	struct avrcp_player *player = target_get_player(session);
 	uint8_t volume;
 
-	if (!player)
-		return;
-
 	volume = pdu->params[1] & 0x7F;
 
-	player->cb->set_volume(volume, session->dev, player->user_data);
+	/* Always update the transport volume, which is separate from the player */
+	media_transport_update_device_volume(session->dev, volume);
+
+	if (player)
+		player->cb->set_volume(volume, session->dev, player->user_data);
 }
 
 static void avrcp_status_changed(struct avrcp *session,
@@ -4378,6 +4379,9 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 
 	volume = pdu->params[0] & 0x7F;
 
+	/* Always update the transport volume, which is separate from the player */
+	media_transport_update_device_volume(session->dev, volume);
+
 	if (player != NULL)
 		player->cb->set_volume(volume, session->dev, player->user_data);
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 993ecb3b3..a0173fdd4 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1202,27 +1202,11 @@ static uint32_t get_duration(void *user_data)
 static void set_volume(uint8_t volume, struct btd_device *dev, void *user_data)
 {
 	struct media_player *mp = user_data;
-	GSList *l;
 
 	if (mp->volume == volume)
 		return;
 
 	mp->volume = volume;
-
-	for (l = mp->adapter->endpoints; l; l = l->next) {
-		struct media_endpoint *endpoint = l->data;
-		struct media_transport *transport;
-
-		/* Volume is A2DP only */
-		if (endpoint->sep == NULL)
-			continue;
-
-		transport = find_device_transport(endpoint, dev);
-		if (transport == NULL)
-			continue;
-
-		media_transport_update_volume(transport, volume);
-	}
 }
 
 static bool media_player_send(struct media_player *mp, const char *name)
-- 
2.27.0

