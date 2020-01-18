Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F631C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 15:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FAD2469A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 15:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWp+HGtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgARPcC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 10:32:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40663 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgARPcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 10:32:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so25384257wrn.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2020 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62ihmKq6CLX5w748JZqL2llc9ZrPcXm92T6GrjcjYcM=;
        b=QWp+HGtSE2wV/OdsWSRwX+g824nLnfBR4WrYnCBAEtvCTat4Lfc1fVX6TMQ/Je4xGz
         SarsnwJxfEt1che4lwePFGry3mQDNDxjjoCyqYaf2Mb5+p+1QFAMqtkLu2RFFkP2Zl5R
         U08sV//hEfxOx2/JJk4GdvqkIXfszGTKLpK1OEIAL/o7ZKe/x6FRrY/Cwfd3VHmuuvcK
         Xukt8Ocbhly/m+bFChr3rOlRliSJ9ijkLoChdsXj8F3sg7EQJSnNM6BfJZ7Dt3MGlu9j
         7akPJsX2YnEwhdPrhhOgHkzsNd0lAy0GgZ9OWIvwaXdnF5BZNRODK0wC08ZP3YiM2ItN
         YiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62ihmKq6CLX5w748JZqL2llc9ZrPcXm92T6GrjcjYcM=;
        b=VBd23kY6KbMzQLfVOcbZQlPE6tlUdVVhdQbt6oLR7J2Rnoy2OSuHuF1qlzkpQV9bY+
         SQbbdHgLoShpezI9Rp+dvZS5P+BrhzJ1ZALlKPvIe1MHTtSeQ8SOA0uiYmpyLAbkwKqV
         ghG9cxo64SaiqDCEn5TRSLjnc0d/Y1Q9sC4dwOQiT3AIW7gA8bIuC0jbMDpv5xYNILUC
         ftf8jXzD5ynGVos01hxAd9/vEkt0ZQWVaQa2Uh5d0VQQj7ceZfsrGfK3YflxafXr09CH
         TxEZSKdwlaDomZQHzGE/76KV8ypK39ZU2jYcp8gKaDu5uq8s6njWA6HCvwp7PnNg2Wxw
         aslQ==
X-Gm-Message-State: APjAAAVs950eUGEKow82E3M6hRAK7j1NS9PB20ynidvcFSMhTMTIevBH
        yDj8xuYU5auMuP+mphlWlAK8WBpN
X-Google-Smtp-Source: APXvYqwp6XgJ9wtAJR4K5HUjXMgzgV3Z3otBxTobIxAkY8NY5pah6M5483ZZ5KqOQz/CzDZrzjU6ig==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr8918071wrn.404.1579361520186;
        Sat, 18 Jan 2020 07:32:00 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id s8sm37806956wrt.57.2020.01.18.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:31:59 -0800 (PST)
From:   Marijn Suijten <marijns95@gmail.com>
X-Google-Original-From: Marijn Suijten
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH] audio: avrcp: Always update transport volume regardless of player.
Date:   Sat, 18 Jan 2020 16:31:38 +0100
Message-Id: <20200118153138.240216-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marijn Suijten <marijns95@gmail.com>

`Volume` is a special property that not only exists on players but also
on the transport (see org.bluez.MediaTransport1). A player is not
attached when the controller does not support FEATURE_CATEGORY_1, which
is common on headphones without media browsing capabilities.

On such audio devices (headphones, in-ears and the like) Absolute Volume
is not available unless an external player is registered
(org.bluez.Media1.RegisterPlayer) _and_ the device sends a volume event
back after that to set a2dp->volume in transport.c to a valid value
(causing volume_exists to finally return true).

The mail thread https://marc.info/?l=linux-bluetooth&m=145337574806153
which denotes the same issue has a solution to at least request
capabilities from the controller, but any notifications received on
AVRCP_EVENT_VOLUME_CHANGED that is subsequently registered will be
ignored by avrcp_volume_changed unless a player is present.

This issue is not addressed by adding a fake player but instead dealing
with the fact that volume is "special" and available on the transport
regardless of the existence of a player. This can be seen in
avrcp_get_capabilities_resp as well which requires a player to register
any event except AVRCP_EVENT_VOLUME_CHANGED.

Updating the transport in avrcp_volume_changed and
avrcp_handle_set_volume leaves set_volume in media.c in an awkward state
since the call here becomes superfluous, which has thus been removed.
The volume member of the media_player is never used which seems a result
of updating from org.bluez.MediaPlayer1 to org.mpris.MediaPlayer2.Player
in 15e421737ccc4696ed567edcc24d178aedb47854, where the volume property:
https://specifications.freedesktop.org/mpris-spec/2.2/Player_Interface.html#Property:Volume
is left out.

Signed-off-by: Marijn Suijten <marijns95@gmail.com>
---
Hi,

I would have submitted a patch to 3-way synchronize the volume between
an AVRCP-connected device, the transport and the mpris player, but an
attempt thus far has shown my inability to properly and fully understand
the structure. Most notably it is not obvious to me how registered
applications work on the org.bluez.Media1 interface.

I assume the following scenarios need to be dealt with:

- The device running bluez plays back media to a bluetooth device
  (headphones, a (car) speaker, and the like). mpris-proxy is used to
  register an exposed mpris player to org.bluez.Media1.RegisterPlayer,
  and this should allow the player application to show and control the
  volume. Any change in volume should be sent to the AVRCP remote using
  avrcp_set_volume(notify=false) and reflected in the transport, which
  happens automatically when the remote confirms the volume using
  avrcp_handle_set_volume.

- The device running bluez receives an audio stream from a remote device
  (and usually plays that back on the attached speakers). In this case
  media information from the remote device is exposed on
  org.bluez.MediaPlayer1, and this is where my understanding stops: it
  looks like applications can register themselves on
  org.bluez.Media1.RegisterApplication, and in turn have bluez add or
  notify their ObjectManager with a new mpris player?

Finally, I mentioned in the patch that updating the transport volume in
set_volume on the media_player has now become superfluous. Or at least
that's what I assume, since there is always only a single transport
associated with an endpoint. set_volume iterates endpoints whereas
media_transport_update_device_volume iterates transports, both of which
should result in the same being updated (are there such cases with
multiple a2dp transports?), correct?

Thanks in advance for considering this patch, looking forward to your
replies/clarifications.

- Marijn Suijten

 profiles/audio/avrcp.c | 12 ++++++++----
 profiles/audio/media.c | 16 ----------------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6b3f685d2..7fb8af608 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3548,12 +3548,13 @@ static void avrcp_volume_changed(struct avrcp *session,
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
@@ -4296,6 +4297,9 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
 
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
2.25.0

