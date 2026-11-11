Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414355;
	b=vS0npm/s9gIfHWDMUpP9zoI75kam6KhN5LNv93jI1n5nwNsNAZUsjhz/EUblCX0+UEFD
	 ToiY8W0QqW56uFl3MqyYeOILN38z2T79su2ECQgMo21mb8yPR72/QSZeGghpPhB+sUR3/
	 xjLlrp7H5xhl33vcNHMXSRbw4XqjQxJFZNOA40CzHnYpMkbAckDUfk2KoJ5PEzgOduOv2
	 fCONGAqyxaeu+BloW2MRFFF0srKTOPIGMPzt7Klf0lQoniTZhff4GAHGfGzX/QCofghu3
	 eaBdcSsH6jANMe2T5MT4DJ3t/pDp134MwLzN8fuFnuMJrT2fe6bz4RconWk4crOOK4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CPP/rR011VT6bdJzYa419gpLljLdhtV7exTDs8nqGHI=;
	b=qZaJlILhWqtTFCReE4rPg5UoJlLIkqyoEHVdzvCn2B1NyzpfRHRtiq9tidOqjHtOmFYT
	 tVqtFKogrRIAOsFGHYnLPjaVXotzZjU7ant2+8pcgMosTn5QQtau/W8tAeixpgAidAf77
	 GjsLVZ/9vjOXs1WC//340LbLdqnc0tmy/a//hKPAVESnr6KhXsooH5QkBvpceuzn8SLNf
	 0srFhFu1Xce6cspm/QsVZimnW1s9imTcbdd8MEG4C3xk9bA6jQZXcVRWpq9CarxLDhrqO
	 gO0mdFOhulJD3LfhbR+CbcJsIbMp4azR7VDpLmhTdYHRtIwG8/pyQqkQY+sscrMGUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUZIlkbw;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684C606A894
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6684C606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUZIlkbw
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e9528732b4so2003297e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414354; x=1795019154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CPP/rR011VT6bdJzYa419gpLljLdhtV7exTDs8nqGHI=;
        b=nUZIlkbw5jWYTgK+VyfpTDe2R8P/lc7DgbhALRqI8u4J7whhmhBtKa+BY5N2vTdG0z
         Ziubwk+v03SxP5HVBKqp4D8B41t920IAyNVGRutfhbz+Bfh0OCoyWKXoak7Fm/JcLao9
         pSLcCuYnA58wt2zjrXUB8Z5alpD6EvsECxFJJRV82Xs5MCTH/pCIp1Q1t3DajVnvR4Nn
         mrLEsH6fJM6liVLTPJDidFpEP/ljoemse1pB7Z8j2Ev4wWfPYdOIFU8UOcD/26mUsc44
         YNIgdw9EQ6j+Zr1fAbHuPpxLIDcmZEdATh18/mX6oWvJYi2wk674bNvaEVzEPzU+QJU0
         Wdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414354; x=1795019154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CPP/rR011VT6bdJzYa419gpLljLdhtV7exTDs8nqGHI=;
        b=dgcGLe9skotMTYC5lB0wOAb7UXEkpE/42oh0XmGOZCBur2ekJSjsb5qdoyIV1IgeD+
         Hx6COMY3wTv5umSnYO4Gc/Xc60Y3hl/44wokALxHvomSroOta2La8fLYnOXFOD6msiDn
         D5hC/IPczV4Dm1fAU6VQx+w/fctnyqDPR4oUW0Rqn1L+3IAtwva5k+azqFVC2UmhZ+NT
         bKNoxnxQVNyUquujm2ihE+oH5DNm84odeRnoE+IZvXfhwk/HyVHCWY6E0NmKq5p6DBhi
         XOpIxZYywAaWK+Oik7djzVgzPKmNlHA91zh+2Phjy/FeEt8myWmhUV1iZlFiLAzZheMe
         RMXw==
X-Gm-Message-State: APuU4Z98Y60tX+cwWhl60kI/STUHtccaifw42MzmQI3htvfMSUiVPyI/
	EUiUQMq4eCa1m5eZM0QPpL03VGlL0V3AyAT/F8RHrEWRm2KJ+5O6r5rMjTuO/Q==
X-Gm-Gg: AYBFou3mSr9Jfvw/V7jo/UDdQHocs4vvB7yAox+WUll9HL8xUG1TwDm/mfUdqHsdpBx
	4n5jYXBJNGMiByxFShX+XYPEbUwFB9XOPpUAtHgYl/K1jjyybaMp84avWA4zzgdyzoqSbZxvcKq
	IT0g9DB5Z29qqvRwIQ32oBs9WqSwCMzRjAff0z1NDeYpistBXJ+xZAJk+BWKXmscafH0CxuMRGc
	qH0GuK5KyWburiJMjmmQtTtJ6y+tGp1fprJJ+4A1mCvPyELU2xZs5g9S/da1gLUVTyxwMmvrpPq
	EXOi4bxeVp95hVYSoloiCH91Co/PSCPzW+O3J75aPMQ7Ddr99xHtnBPMBrIb0guvi/vEsz4ZhQI
	+lQArljw0YKvg2yaegilu6S7HUQ9rhvj0WvetzJYG2qUCCI5hSl13EJ0nn8YidT9yr7vkEBu4a6
	5GYAeKVNYrjpjBGnhsLbQVs73L+ZViR3FNNb2azkOCuf9eFQEp6UjxF27AOdZYwQQjMOLdl97lI
	/UlMAnOBcpjOsIWTvLF78UYeh72EgNY7mKRt9bpVNXdYDn9gludJAnVs9Eg6b5TGzwFe+VNZGS4
	hNXmFAfvU5cwTAz607ULIBIM5Zmx904m7NRLUG0Cj33RufCbcGClXK96m/NsiHQfqNfHjTrHiLm
	thFeiYju6kHkH88UOZgYupLys8wwBi0HnSYy6KDivpggi3myGKwGIp3dNhDXVh2lBJY5I9acrLR
	ulo84=
X-Received: by 2002:a05:6122:4d0e:b0:5ea:cc3c:9449 with SMTP id 71dfb90a1353d-5ee1c48ac3amr1270356e0c.19.1794414354552;
        Wed, 11 Nov 2026 08:25:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/8] transport: Don't hand the owner over while releasing
Date: Wed, 11 Nov 2026 11:25:27 -0500
Message-ID: <6cdc89f8101db17c443fadd37dc35d4fe5197674.1794414122.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As a server, handing the owner over to a link still streaming also
happened when the audio server released the transport. Release sets the
transport to suspending before disabling its ASE, and disabling a Sink
ASE reaches the handover synchronously, before the request of Release
is installed. The handover cleared the owner of the transport, so the
removal of the owner by Release did nothing, and the link, which kept
the owner, was left owned and never moved to idle:

  transport_set_state() fd0: ACTIVE -> SUSPENDING
  bap_handover_owner() fd1 Owner :1.2 handed over to fd0
  transport_set_state() fd1: SUSPENDING -> IDLE

Don't hand the owner over when the transport is being released, as
Release removes the owner itself, nor when the owner has a request
pending, as it would stay with the link although it was made through
the transport, which is the one that completes it.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 496eb379b700..632f88572a47 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2458,8 +2458,12 @@ static bool bap_handover_owner(struct media_transport *transport)
 	struct bt_bap_stream *stream;
 	struct media_transport *link;
 
-	if (!owner || !owner->watch || !bap->linked || bap->desync ||
-				bt_bap_stream_is_client(bap->stream))
+	/* A pending request is answered through its transport, and a transport
+	 * being released has its owner removed by Release itself.
+	 */
+	if (!owner || owner->pending || !owner->watch || !bap->linked ||
+			bap->desync || bt_bap_stream_is_client(bap->stream) ||
+			transport->state == TRANSPORT_STATE_SUSPENDING)
 		return false;
 
 	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
-- 
2.56.0

