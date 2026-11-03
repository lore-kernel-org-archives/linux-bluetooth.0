Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737817;
	b=WfYdxCfc03RKAGy1zub5qhfkmkixFhZToc7OKCVHuIGMV1NAfRWe5EKjAgBqkGjahMIP
	 uDP62Y4ycQ+ihf7Wtt5/YrU5qIdJdI9c72rzY9LL/+2UGcExfNpaoYYCVhFhqVBBeIffu
	 F6uhEVuO7ZeVLdQLZ69z8nsNEJYDkiBSkhDnixKqoEETZx7qimRf8DC00r+L+AzpDEzBW
	 N7a4ZBdpqK/FwDimhABxqMwUapzTA34DLvxO7g+BHMYYJfrwbdds0wFOfVa/GBoWrwhLa
	 Y1E+rX5uuSUFq+Rwmf3TBWTSRjYzTQXUnUY6CcBQcS4I2LcTbr4HbuL3aE6feFR4DTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/SFRq0kk8JbvdVpLKL8oGuRuLqwMOFikwlzEC703eLk=;
	b=JzTfdILhWSmuuGnlczV24xUfxrVDvbE+AM14sYDdz45s0jyKBc+ylOOldmK7g3IJlMOz
	 N/S1HK0wJ96+HAIshfK4XRAjaxwYYNiya0GAkfSMK+eCFQYEMw2Y5NQ/cCWRm04ZGhy4b
	 w18Jz6K19uuQ1z4YzJpSoGrEugd2HbovuvE7bQ2KxUTQQf1rUjIiXA9h64L+Ur1GMasMJ
	 BrYOME0qC1sOX2MXJ9vBwyCQ+/isVnELTSI6123M1h1Tv9gmennkQ3bofwjUfZoccg9oB
	 ykIfqp9x0M8SHWtcRQLhaC6piEpYGPnklxpaYjUuQRjm3HmT/J6Z3fiviFOrNiadLkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JkvKXalk;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5913606A328
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5913606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JkvKXalk
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso3147645137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737815; x=1794342615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/SFRq0kk8JbvdVpLKL8oGuRuLqwMOFikwlzEC703eLk=;
        b=JkvKXalk7a2Sj1xSjAdr1o4cTURaLMt7FXD1ZJ6pV3uohoRgLJ9kBcU2kTgBCTYFsb
         wnyBETUJ+HbSaokY4oLc8/oxvH8NoVvo/OyMK6cz4jiV17UI19wGN9r/oCq/mYC7GYPM
         AEjhGUWhvjaYpNJoLnO5xj6bTo5I76hfurgtzbgsHy0DJBisxWmL7p1E5FzmhJc03XZj
         GfMeNo4zngiUQLGEK9DqvfkgRhW+QDY7amSGbYUYhE/9Nzn5nGYaek3gKQ91B7DXRw47
         XueXHtIkM8S3o8Q854Up4IV59FC11PxCBz8I+ttLI1vhWO3IqBDWAsOmJCkMQEkpV47y
         yqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737815; x=1794342615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/SFRq0kk8JbvdVpLKL8oGuRuLqwMOFikwlzEC703eLk=;
        b=u3kZm1I7zB3Zw5sNdDLTJs6jcQQVrSXiMFw+odxWg7Tzf8oIxXEiiAjjfN8tgXr8y7
         qFTwjhfwfPyvpQCZjz3UMhJeGB7p8kaoGCzXl+wv1NiNEfimeGW1bQOiELvNQef718cr
         YmLtvyEyUuHd2KmYYAIke7FdCnn6r8G+ZAfq/39Y9fVaeHbQ+zQdjISjnehJ5u5Lx6dW
         45BkGfPPaQnZsGVcvPvFy2xaNOok0sWJuT26lfwQzSkjtY/J1E8hFLeUTHx8MHrkkJyh
         Cts+G91R1ezhceFr2BU09icEsBLR+68r/g23ELnrxcZCJutF74bfYKbZSc/3KiY9feVH
         zfRg==
X-Gm-Message-State: APuU4Z8wXOQgFAhnL+wMDCdCvh1ZabHR0D5Kdd1ADBmW0N0VaYdUZoj2
	rkpVs6l69m+/A5ujKyTNp3IZD1O4wD3WBzyN+NLQa99sJn62prRPiJATFNANyg==
X-Gm-Gg: AYBFou1Amf66hCDrWX2BQcCqZWLWXI+cJHAmb7z1VE/puQPJbvnjY8wsD+GgQU1aqBW
	Hcw+r94sCL6uR+S18fYMTNPoyyGQlgEf8NI9ozN2Cmo91wYX0aJAH0iHRVRvVfmAA+fwGddmKhN
	GsZPKBkM/SkBZTNX4fC9GhRt+FPeDfrHCYYIah2J4DhW3VbVoBy1S3JfHQi92hPoIa7xYUTFx9Y
	qApvHsMPzhlx8VSQqBK0Wxt4DWHF+TeNbmQpCY163SrXAe1RLg0EOKlgI9Iwlur4I7tFd2DgbLH
	HQlOKnP3IR87pw4TQfRKiU2oJgok3f9qt2P7DJaDuRMEz6UMwjoSxqP/ETm+dE0ho64SN/+z80o
	E7XOaLlvCwHPAXw36PziIhn6Qkpo+32587fNz0lPF14inQMxfksoBlEmRcSbalkLZc+toqhHriA
	Awmdie/1AX3reN5U48yxgIXB39kOjd5neq1mzoRdVgyHIYfTxdoVQH0X5do7IL6O0R5/hNAQNGm
	O1VF+StiJ6rTVtIhV3EK/FVOGM7dx0nQc3Q6j16jifeaIzfB11ZL7xf8wRbWxs3Lf14EedRZHGu
	oeeKVWnnDup/Pi1dRqCxHN8Tig7eWz2cV/R369A37Y0HTQA+NnzFcA/LiY0F/2jRBMTKc8VcakV
	vZbTzFsAjtEQOpwsBuC/R3voix7xUOeSo+agLrs7N2/s3iru53wJguhY85q7y7axbXlQ9oG/v/h
	gweeg=
X-Received: by 2002:a05:6102:578c:b0:7cc:2086:34c9 with SMTP id ada2fe7eead31-7d07226dea4mr6462535137.2.1793737815446;
        Tue, 03 Nov 2026 12:30:15 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/7] shared/bap: Defer ASE state notifications until idle
Date: Tue,  3 Nov 2026 15:30:03 -0500
Message-ID: <20261103203011.3904290-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
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

While handling an ASE Control Point write, ASE state notifications are
deferred by BAP_PROCESS_TIMEOUT so they are not sent ahead of the CP
notification. This means the CP notification and the ASE state
notifications can be sent 10 ms apart, so a client that acts on the CP
notification may still see the old ASE state.

Fix this by deferring the ASE state notifications until the mainloop is
idle instead, which still sends them after the CP notification but in
the same mainloop cycle so they can be grouped into the same Notify
Multiple PDU. The deferral is scheduled after the state callbacks so any
I/O setup by them, e.g. a CIS loss, is processed first.
---
 src/shared/bap.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b1180b532b8d..24a43ba07b55 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -285,6 +285,7 @@ struct bt_bap_stream {
 	uint8_t old_state;
 	uint8_t state;
 	unsigned int state_id;
+	bool state_defer;
 	struct queue *pending_states;
 	bool no_cache_config;
 	bool client;
@@ -1841,17 +1842,32 @@ static void bap_ucast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	if (stream->client)
 		goto done;
 
-	if (!stream->bap->in_cp_write)
+	if (!stream->bap->in_cp_write) {
 		stream_notify_state(stream);
-	else if (!stream->state_id)
-		stream->state_id = timeout_add(BAP_PROCESS_TIMEOUT,
-						stream_notify_state,
-						bt_bap_stream_ref(stream),
-						bt_bap_stream_unref);
-	else /* If a state_id is already pending then queue the old one */
+	} else if (stream->state_id || stream->state_defer) {
+		/* If a notification is already pending then queue the old
+		 * state.
+		 */
 		queue_push_tail(stream->pending_states,
 				UINT_TO_PTR(ep->old_state));
-
+	} else {
+		/* Defer ASE state notifications until the mainloop is idle so
+		 * the CP notification is sent first while still allowing them
+		 * to be grouped into the same Notify Multiple PDU. This is
+		 * scheduled after the state callbacks so any I/O they setup,
+		 * e.g. on CIS loss, is processed first.
+		 */
+		stream->state_defer = true;
+		bt_bap_stream_ref(stream);
+		bap_stream_state_changed(stream);
+		stream->state_defer = false;
+		if (!stream->state_id)
+			stream->state_id = timeout_add(0, stream_notify_state,
+						bt_bap_stream_ref(stream),
+						bt_bap_stream_unref);
+		bt_bap_stream_unref(stream);
+		return;
+	}
 
 done:
 	bap_stream_state_changed(stream);
-- 
2.56.0

