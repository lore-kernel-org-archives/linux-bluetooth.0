Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414352;
	b=QnHeo+n/sQcidoasqzSuuqK3EtcSyFMKaWNnR0lsSQ4vf5MIeg90ezDt2vt6gSADXvX5
	 yxhZ6Tosnp0tv6iUsgZE6AHpSB5eLi6NEP1vcIhmCAHw/ugEmFnmFQTYToFUSL9rbdei5
	 QOAkN7H42EfDaI+tQ7V31W7vHBuh/IfI46hd7N0FVppMk2DJ8pQhEIw1LVCIV3A0T5F/H
	 x7cFJTLVSbW2XOrMTilWsq42idTU6Pa9NlRh9cG5ypVlKYTUDNvwPgk1Xefr12WVAAWcp
	 Ns0kXXhjt9XpZSAsDWqD1uX6u8hBIFaSEOpH+qlsq6RKGfPp5dXjw0HACib78Gc3Oxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
	b=K1z16UaS1DPPoDaevXUzSmnPMXXNGIAIpLTb/42KBuZ2PLZKBopC2FVN8BCC7gmfLqnX
	 wINe0U+UKfNPykuAA12U/frlqMmALR2Bpfm6Q0O2gUcLJJRwb5a8CeXaaJNspoUCHazpe
	 fKKiNmZSD8/IiZhxVRrV9gzcKCjMN/yi7oyStl105IET2/qJmjXG1i5cSHTp7MNA4KGFd
	 oSHSyQLuPQr4O9ct7/tvKsmqsdpV0ze45B0MlKzmFXmbOgNLIXZPiekSgnKn02PeoT0qh
	 Rwt/QII586nnucOyqtQN4anveHncLXf6IeFK4u+kBfXf8MiigpFn/33F99G6UInvPYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYg8DSVy;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC501606A88F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC501606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYg8DSVy
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eae1276409so1365045e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414351; x=1795019151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
        b=zYg8DSVyLXM0VPglEELMNqhcTk6Z8JwHcUO7kOhmbhJP5P6rxcgm/Ye28qQFpX/Vzd
         Cpt48+0d1JukNl8aZukVYE1sz5qpHHy8xLMezQvCBRYXrq8b9d74gAb0cTFStNXXR7wc
         qPyiLgdNNlaaXstlwVUkp6sr2FIFITTz49hJEuB0li0WUFY60XgXW2pDdDJQpI/Sv2+a
         JQGrNgq0JTC8qY9ZY5jwUfnBdlN+kBCR4rJwzfKRdBBACqzgg7jl27wHgh6cCmA9gYso
         3B5K5a2+QWMTurzKmAJhOK5FLfFK2piPsXTkkhpMIAeRuHKteLOVX+YdUTeQuls5Goyl
         +Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414351; x=1795019151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6xJLMVjhu6ba56vyU4hGa82jcVeKd5AgZpL5C096FSc=;
        b=zOCgrPzCWVQFm+hXXKnZb6YXIY0uG+OFcggXVmovKpYmKSbuNo3sbNeEm8qFqUMWNU
         0OUZsLl5jCUC1v/DpWSHW5yf8rY7X2ftb0ywDRhTLfObTwlG4Bmb+jPOnwzc2fyMUTQm
         MXl6NenEqxUs3P+KwdRqlT1vxSbDO6LGpdEYYsHejFzDzFeU+LGb3EmXa+Th/syDnvGW
         UkqSELTNxOJDzCwZEkBPb1FRtOiRMTQEggS69CpkBPBenpntGmFlNjuQfIKVEXLaWFu9
         y8ZLPr6vpQeHPntbsMhrvIEGSv7cbtrYngy/M3MAb5StGzsrUTIbpnWT+7TWP8jdsPnD
         sR5w==
X-Gm-Message-State: APuU4Z+CGkl/lGI8Emj+jBzTl59DuJyFNbtPG2xGr3+gejWNVpungUNo
	kUvEUQknNqvbZEeKZc3RsvEPoMm5chvcAAhCzs8C5p34/gXSqGuTAQfBIP0tYg==
X-Gm-Gg: AYBFou29PJo3VL1llKcYPyCdJ9DYhUGhbUpME2sSJn5qSiWi/SEdZam7HL2CdyDWo2f
	vX2/iFqa33xhYCgxyiq2PRSs0rNEe4Bn+xkBZ8DUlggSDgTvBSdI+QLHaIs2rZrnNBpoQfeF+di
	zDT+/VLZ18wCzExLZLQSQFtDjo47ArM2/6q/FgJv4z1ON3MpOtJct3pXUrdDgOtLAIAO8Vddaao
	f8oedRaMa6iXRGdghOpQThy5fdaK5xW54KqN1yVeH+xcMK2WykMElL+eYQRcusbHHwq2C2IpdMS
	1ibG90Y/xlEaNy1dLCV4LYIA2GJsd8hIBhn+P+d5YVRp9hFWaZSR7OXpgqXJ3wVYTcKkETfVd/M
	gN3NPJNzJOhG9+euw/Y0iOPK8sGH/S7iYkzgs6pn9/OUK2zWiFGAhlHZ7YWl7C7LA81qr5LpoeQ
	7UrFVqODK1gjTSu0jDJJptUd1XiZVKvfgbKjvYRclcbQSqKRHeVEyiozCb/S2xcRRg40RyihSfe
	fMg0+UUq1ZLW+/uavBbPFsrZ9Dl74xZLewfBwEqJIZ4CCRAJdqdi3dYzDtAsS86uqR2why+kubt
	j9FmfybtlXDcbCO1kX2szJp5qGgs8cAm4WpShA9Vckc7n6GkufFkKcAgI1GDT6CCnD/PFmdnc2R
	x4S0Ok/5Sgi4puolRDez+TXxhEpeEttslHYjKGwrlqnXtYito9eCoAwM6E3R8B0PWqjvm3luWGZ
	aobC4=
X-Received: by 2002:a05:6123:2e7:b0:5ea:c11b:432c with SMTP id 71dfb90a1353d-5ee1c44ab83mr1201958e0c.15.1794414350750;
        Wed, 11 Nov 2026 08:25:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] transport: Hand the owner over to a link still streaming
Date: Wed, 11 Nov 2026 11:25:24 -0500
Message-ID: <e6caad1206aa8461a3773aa420f5a525f1654402.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

From: Kannan J <kannan.j@intel.com>

As a server, when the client enables both ASEs of a bidirectional CIS
the audio server acquires one transport and its link gets the same
owner. The client may then disable only one of the ASEs, e.g. the
Source ASE when the microphone is closed, while the Sink ASE keeps
streaming over the same CIS. Removing the owner of the disabled
transport then also cleared it from the link and freed it, and
suspending the transport set the link, no longer owned, to idle as
well:

  bap.c:ascs_ase_cp_write() Receiver Stop Ready
  transport.c:media_transport_remove_owner() fd1 Owner :1.1213
  transport.c:linked_transport_remove_owner() fd0 Owner :1.1213
  transport.c:transport_set_state() fd1: ACTIVE -> IDLE
  transport.c:transport_set_state() fd0: ACTIVE -> IDLE
  > org.bluez.MediaTransport1.Release
  < org.bluez.Error.NotAuthorized

The audio server stopped the stream of the Sink ASE, which kept
receiving data, and acquired it again on its next metadata update.

As a server, when a transport leaves streaming while a link sharing
its owner is still enabled, hand the owner over to the link and only
suspend the transport, so the link keeps its owner and its state.
---
 profiles/audio/transport.c | 53 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 285db0d37554..39378ca19815 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2431,6 +2431,53 @@ done:
 	return FALSE;
 }
 
+static bool match_link_shares_owner(const void *data, const void *user_data)
+{
+	struct bt_bap_stream *link = (void *)data;
+	struct media_transport *transport;
+
+	if (!bap_link_enabled(link))
+		return false;
+
+	transport = find_transport_by_bap_stream(link);
+
+	return transport && transport->owner == user_data;
+}
+
+/* As a server, the client disables each ASE of a shared CIS on its own, so a
+ * link still enabled keeps streaming and takes over the owner they shared.
+ */
+static bool bap_handover_owner(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct media_owner *owner = transport->owner;
+	struct bt_bap_stream *stream;
+	struct media_transport *link;
+
+	if (!owner || !owner->watch || !bap->linked || bap->desync ||
+				bt_bap_stream_is_client(bap->stream))
+		return false;
+
+	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
+				match_link_shares_owner, owner);
+	if (!stream)
+		return false;
+
+	link = find_transport_by_bap_stream(stream);
+
+	DBG("Transport %s Owner %s handed over to %s", transport->path,
+						owner->name, link->path);
+
+	transport->owner = NULL;
+	if (owner->transport == transport)
+		owner->transport = link;
+
+	/* The link now has its own owner, so it keeps its state */
+	media_transport_suspend(transport, NULL);
+
+	return true;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -2460,7 +2507,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
@@ -2480,7 +2528,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_RELEASING:
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			return;
-		transport_update_playing(transport, FALSE);
+		if (!bap_handover_owner(transport))
+			transport_update_playing(transport, FALSE);
 		goto done;
 	}
 
-- 
2.56.0

