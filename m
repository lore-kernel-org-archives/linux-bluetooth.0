Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527601;
	b=kN4nfm0nvv/6OOg4vTHgn8jvwfCzlwBgSRgorlCqUVNx8EMDs/5hD3MiRAq5dk+ilNwM
	 PRcU10qnqlu/i47ZCcISImLvYcc9IoTaXwE5OQL7ndT/z47y4tJLRgvnfb9ipofHaWpv+
	 RHpVZzhzjtchh56rMapjFVAmmdQ2VpSDjHXW2A9TOD7FgfWioZbBemkjS3mqFc0hCrIgu
	 iYuZvvTjxNKfiGlk9GHPt3yUK3+A/sf43gQHnYlSHI3d1y1fJ1Qo1dZdBEfgYo2jmpvtg
	 6U1kfDtt0EFAP3Uu5py6Bo7h8VSUJCD0DZZ04hHfRyBmeBCwE9gEFvxWnYz9PWwSr4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EHuEUm5lurPlRo3c0vApVwcfsxVlYCchTM9Uw/PvieE=;
	b=3F2nn79D6KlM1FLVcfilnyDs27gzBkGHQQ3bVbqHjSrs3AmhAcoSroqnkXfoh9Y1JVmf
	 Of8e2hDe/XevbRF1j3oLS/tuhIUvR1zKzFSnIN3b9J+2vzcGFOIrzxy4Sn4oEko6LgQDI
	 ZKt3/cj61dG3nZ9YcGoB/rGwE4iJFKy2eKYlx61VhuEHIjNmJqoIvs+y05WYGcOTA+EBa
	 +wXYFq/o8vzY1/ijf/TXoCHAFF7YFKOgCBypkGJBNPerMiVTbNI2RtVkg/7bKRp2C4KeV
	 RWhdL6SwLbYJdNAffQnsfO1WOoOBc+7Trfo0VP2Im5AFG7TLAQ3FKz4qU8KrWks1Xqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=KYyEUthe;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA399606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA399606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=KYyEUthe
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so16470915e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795527599; x=1796132399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHuEUm5lurPlRo3c0vApVwcfsxVlYCchTM9Uw/PvieE=;
        b=KYyEUthebZO8OBTr9K7LyeFcIVEz4S3pVwW/sT4zCwznE8UZJ0AcoHi+Qriw3bj2Ex
         0nRkFKLTRIAgidI6FDFlLEz/ZlCZorMvBKir4Xf9SmbCeWPp00jLeLxWOXuetgCxPCpW
         Ss9SkIdQsDCHMpErmqXoS+Ojj3OCTILomtgI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527599; x=1796132399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHuEUm5lurPlRo3c0vApVwcfsxVlYCchTM9Uw/PvieE=;
        b=vOltoqrYQqxsd37mAYXJ2PsOj7aW9jgud1ixBQNH5+d4mHbOwbDaFG6/s1FV5+PrmD
         7QY2VoIYTm45IwP84GTydswOu4bqDpgiG0S3syrxgnktUYQhITM0G2uMbqywicvxy2aQ
         nIK48UKzjb0+8/SmssCoRjPhGjho/qHouwxsTkTbsGPZIIVC8hBACh6TpfczENBeVfyn
         dlEezR5+UcuY1K3BSzxcGrKbXGse8TxSA1K4PPwLrltVNL36yPvJf0u3AKHih+/5EGVM
         WiwVxgoTZ3C2jplKCKImWRPLRWGELy+OZ4gAos5DCKmxG2lAhjTS9EeU3GCuDUY50hPm
         vflg==
X-Gm-Message-State: APuU4Z9Ot9EJEsCC6lbxORUfak55+9pjQBvxDuh1hj8sRcPkXzXnnE1B
	sTrKMiRixFipq9RBXCSLgWaNnhC1H4ia9cQ0QviV+9jFZU8EpWlSEtce8AC/eSJluxgJfXYfpAW
	isDHq
X-Gm-Gg: AZFdTZekHbRN+3655EPd1bApV1G9YQaDX02LNzPFAAyB1KMt854pxGtC8FhwLU84C2i
	/CY41zMaqNL9CBA7vV8qKoZlQ65Oscc9dmijC6DruU6JFV84hydAGjH4k8srE99iGrp8+bjVXOJ
	rFfs4eFmVa/E7OmNylALcrCL2xUGe2E9UO8HqruUEmRkS3ha5yjQgY0uiWke9YR8BeNGcWojo9k
	t0wP5OCZkpmY4tCI0fD8+Y8r9PTMSw4c2MCXT4oJRL1tayxuNIS7Hl5prqmho9bKPi27DTVMO9W
	K2qBE6cxyh2xGCNB6TWgwqGUcSSX0wcf9qT5QRKP26dicLOej03baEZChUlusp2I07T2VDNF4Eo
	WMnwh5cx8WikTCVkviDxFXEcfcnps9KyL2riXcPV+XTDXEjXzaxtzr2xG1f92I9atpvLF9h4CNn
	QUujzFBcZof3ljZ2Xb0t20b1IzSZVeTiWRXO8dm1t5J+DPnmIIN/+wzr3D/kWbmRN9iMcX74tUZ
	oeuR/W/pZWZINDsOL4rcL/56R+KSvCVE7bPxo87c+nXQY1ETh5hMPEdZWseS+mqj5A3atF/EiQV
	fXA5cDl2KVSTcZKNVgEVn+oRLnltSnElmf+h9AFdoUhzS+MULJk=
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id 5b1f17b1804b1-4bb88819bcdmr293324535e9.31.1795527599235;
        Tue, 24 Nov 2026 05:39:59 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm491626385e9.3.2026.11.24.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:39:59 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] avrcp: Check what the remote uses instead of its AVRCP version
Date: Tue, 24 Nov 2026 14:39:54 +0100
Message-ID: <20261124133954.4009535-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
References: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The version in the remote's SDP record does not tell which commands
it uses. Android phones such as the Nexus 6P show AVRCP 1.3 in their
controller record but set the absolute volume and register for
EVENT_VOLUME_CHANGED, and the Huawei Nova 7 registers for it without
a controller record that passes avrcp_volume_supported(). Both lose
absolute volume control.

Accept SetAbsoluteVolume and notify EVENT_VOLUME_CHANGED whenever the
remote uses them: the registration already tells whether to notify.
Ask any remote for its capabilities and register the events it
reports, connect browsing on the feature bit alone, and drop the
version checks before SetAddressedPlayer and player settings, which
exist only for players and settings the remote reported. Sending
SetAbsoluteVolume still requires category 2 when VolumeCategory is set.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f7c988ec0..b550c3b2a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1740,10 +1740,10 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-/* SetAbsoluteVolume requires at least version 1.4 and a category-2 */
+/* SetAbsoluteVolume requires a category-2 */
 static bool avrcp_volume_supported(struct avrcp_data *data)
 {
-	if (!data || data->version < 0x0104)
+	if (!data)
 		return false;
 
 	if (btd_opts.avrcp.volume_category &&
@@ -1763,11 +1763,6 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	if (len != 1)
 		goto err;
 
-	if (!avrcp_volume_supported(session->target)) {
-		error("SetAbsoluteVolume not supported");
-		goto err;
-	}
-
 	volume = pdu->params[0] = pdu->params[0] & 0x7F;
 
 	media_transport_set_a2dp_volume(session->dev, volume);
@@ -3084,8 +3079,7 @@ static void avrcp_set_addressed_player(struct avrcp *session,
 static void set_addressed_player(struct avrcp *session,
 					struct avrcp_player *player)
 {
-	if (!player || !player->id || player->addressed ||
-				session->controller->version < 0x0104)
+	if (!player || !player->id || player->addressed)
 		return;
 
 	/* Set player as addressed */
@@ -3137,9 +3131,6 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	if (session == NULL)
 		return false;
 
-	if (session->controller->version < 0x0103)
-		return false;
-
 	set_ct_player(session, player);
 
 	attr = attr_to_val(key);
@@ -4369,9 +4360,6 @@ static void target_init(struct avrcp *session)
 		media_transport_set_a2dp_volume(session->dev, init_volume);
 	}
 
-	if (target->version < 0x0104)
-		return;
-
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
 		avrcp_get_capabilities(session);
@@ -4415,14 +4403,8 @@ static void controller_init(struct avrcp *session)
 			return;
 	}
 
-	if (controller->version < 0x0103)
-		return;
-
 	avrcp_get_capabilities(session);
 
-	if (controller->version < 0x0104)
-		return;
-
 	if (!(controller->features & AVRCP_FEATURE_BROWSING))
 		return;
 
@@ -4837,10 +4819,8 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!avrcp_volume_supported(session->target)) {
-			error("EVENT_VOLUME_CHANGED not supported");
+		if (!session->target)
 			return -ENOTSUP;
-		}
 		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
 								&volume);
 	}
-- 
2.43.0

