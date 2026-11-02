Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657574;
	b=LseqzVUfHkp+dLJkk+4gJa/ooR+e3sBq/PHtiLzVpRWyNGIHWoKLjHyu0JjOuqDK7vRb
	 OLp9vI1afR1vzII4JJTCsM02irbtgsdp9LLF22GxWeb3q63F+wPiA7mm5OG7nLjuG/3u2
	 cHT1NfMz9TJ+cMveDg+sBsg0SmzniiPQzYUZnUM6OFBK/8nNmLkH3uHoAfCucW8l9UHAg
	 YLl/hOAKTnAckfHvbkY6erL4Pea/uOVBUtpZZv+WRsot+8wWshvtK/Jj84386h2Adk1Pf
	 469tVbkJYGXtbCZpUZlUbo6CiBoccHqJPl9wpgXxpUVGLrAvZROn/ck5Xw4m5kUomgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v3rM3cfccMZ2aie5BUH39pXwz2HmJ/pubiH7nn5cWWw=;
	b=rVD7XGrryiSbWt7sHmNiEx1R+x+zy373NCAXcag50ZtZcUe4MT48eKyHP2PzcvrWfPVb
	 /nK9dipxUVILTuDlr5V/t9QzOY5MECbz0tVdpVPwVugb1XICRABmLvVVSqLYkuRKVL38Y
	 LMgswmlz6SYdsb9vsSk7etNNZ/6zNkeSDb27ORWIMVRgslgRddRYCQaALcjvce00BQ7M+
	 Z/qboP/dIWEHNhI+bpT3StOmRGYmlxX+bqlgnvWW9fBE2B2lqSr6AP/43fqOs5E45Qc6e
	 kT81fcSG0xFEAZHyID5PhGt+lgom0p+AO/igYl7QFEx4aBzXhFiOFfB5Df2YymUCn4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBTZQeEd;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07B606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 22:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B07B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBTZQeEd
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so26897955e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657573; x=1794262373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3rM3cfccMZ2aie5BUH39pXwz2HmJ/pubiH7nn5cWWw=;
        b=sBTZQeEdVCQYcD0H90mku0dXYpq6JpHezGiIzOoJWFMrhqfxzUHmQp6Lj2n46HbAtn
         msTmmeCPAg2Matb6VWz7qh+dp8SMGKXCZQ0KJHOiJ1P8NmlBlsCcU927ti+hF4FxIGQG
         +EoYNKhAAwrQMD61EZjeCtWqkjRveTA4Bx36EZxb/IVeeo2bGXx4ElXeE7EBZdTjex9d
         9b5d11rgtW084vfc+KkfyBYnvsh7nSD7d6tENXtI/S0IdXuU/FvxyF1tw4WxdTFeeFd9
         HbCtiqUr5lm0Pj+upg2nbPaeDWSN6fS7X+Gyc37IXukiSaXe5PqH6cDWGt60nwridUHT
         utVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657573; x=1794262373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v3rM3cfccMZ2aie5BUH39pXwz2HmJ/pubiH7nn5cWWw=;
        b=LuDoQ/Ypk6/Jroa+VCEEIaVvVDfknhtY4/i1QvHShBU56FjHXLRcxqrW0vU7IjPuqc
         U2OEzTN3al4HaPEypvRs3nC2VTadbGJm/3M/VAeRt2qIkwgGT5w5iSj2ZvdslTwntHVo
         cK6fIMB1JHPM75oIyYZKFCy5PxZWKukFnHerQ0snI8B22Bf3tAgFRhja1GdCQRzmeR3X
         NorC8NItSyHCpe570E/7ndi6WxvpMIIRvjepzxpBl+1ZRb8ckRL2J7PpWMaO85ukzzup
         95qbzINe4m8xUlAerNALRzAw+XZ5+d9Vamkdc4IVWZzuU6kQXSZstkSPsR/qJGEd2Nrd
         4NFA==
X-Gm-Message-State: AFq9FYKhr8AMl/AMysarBP2RiHfgjJLamcbfj4XQ3zNgMfvKwHp5mWZh
	gNaUkhinSUHo19IdFAopHBWjVsGXHpeqocNkkH1drj4etu+iGEAeo1DLah8d/QQ7BFI=
X-Gm-Gg: AYBFou272Lhqy3SQteUFoYybBf9Z0gydj1j+aMye+V8jtaNs1p/QsFPddO2FFDfwj0/
	pF2MYUzwbUUuSclru6OEJC2Bepbyec9fYVHlHYbAX0AwE5qSljz632/LypSshcCCFmrJYhnsWeX
	iH7Gja5wfuT76X9AtHqHtipmB2KpXFdl5fYGsDut56daKMt0Sro0nPQBQQ8LfgbqSpHQ8BPNXDm
	O9HMOZwLyUkeDdilda7XGjWXiy2VJF4j2MWSLJ2/8ujB665CYojYce97/VlglHN/bRTkOi1Fvsq
	ulD9pREufHTObk130m0XMlduhSQLLi30c+X08KfALmcW33c/0MHNbYOpYzit9vWKl338Ppxj6f/
	nHFV7Q0kSBF9UHf4zyLadNy/JLnFECDyi2jn89KalfLF4PMBNJ3xTnrhlkHtdd7eV5QacRtxWGn
	q6v3bYIQcVnYklWsHtOmDCksquXcPRpGcIgLjdSNjI/eCOadLResbSG1l3jb4g3hrYNnnjjqFWs
	7/vSJ44egKOWBoqr8DTcYr1O1cGA8wGofJyvSBSx1AeHZoGMSy56AXfwFz9Z1JO8r5Q/FtGzUb5
	gaKtgjlIKsj2qGlTwnVSPoztDRMcwDB1Irgn/fvWk+Isjf7Qwd8ztijFWLQtlBspVRLQPfVr0lZ
	dH41Ud/Iv/u5LZ661m7mWF5unTulWFhlsE3BU73MtnYqb/Xm/CA==
X-Received: by 2002:a05:600c:34d1:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4ac12475a61mr263779945e9.0.1793657572711;
        Mon, 02 Nov 2026 14:12:52 -0800 (PST)
Received: from pop-os.. ([2a02:810d:478b:2e00:d078:1466:9ea1:3ace])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm207894205e9.4.2026.11.02.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:12:52 -0800 (PST)
From: RasmusML <rasmusml0501@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: RasmusML <rasmusml@hotmail.dk>
Subject: [PATCH BlueZ 1/2] profiles/midi: Fix running status across channels
Date: Mon,  2 Nov 2026 23:12:22 +0100
Message-ID: <20261102221223.16079-1-rasmusml0501@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: RasmusML <rasmusml@hotmail.dk>

When two MIDI messages of the same type but on different channels end
up in the same BLE-MIDI packet, read_ev_others() writes the second
status byte without the timestampLow byte that must precede every
status byte. A receiver then reads that status byte as the timestamp
and applies the following data bytes to the previous message's channel
through running status, e.g.:

  sent:    ch1 NoteOff 60, ch2 NoteOff 64, ch3 CC123, ch4 CC123
  packet:  B5 94 81 3C 00 82 40 00 94 B3 7B 00 B4 7B 00
  decoded: ch1 NoteOff 60, ch1 NoteOff 64, ch3 CC123, ch3 CC123

This happens because rstatus holds the ALSA event type, which carries
no channel, so the writer assumes running status while
snd_midi_event_decode() correctly emits a new status byte.

Fix this by decoding each message into a local buffer first and
appending timestampLow whenever the decoder actually wrote a status
byte. If the message does not fit, flush the packet and, if it relied
on running status, decode it again with a reset decoder so the new
packet starts with a full status byte. This replaces the -ENOMEM retry
path.

Closes: https://github.com/bluez/bluez/issues/2630
Assisted-by: Claude:claude-opus-5-5
---
 profiles/midi/libmidi.c | 59 +++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index ef33f7dfd..349f5f7b2 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -191,40 +191,47 @@ static void read_ev_sysex(struct midi_write_parser *parser, const snd_seq_event_
 static void read_ev_others(struct midi_write_parser *parser, const snd_seq_event_t *ev,
                            midi_read_ev_cb write_cb, void *user_data)
 {
-	int length;
+	uint8_t msg[MIDI_MSG_MAX_SIZE];
+	long length;
+	bool status;
 
-	/* check for running status */
-	if (parser->rstatus != ev->type) {
+	/* running status only ever continues the same event type */
+	if (parser->rstatus != ev->type)
 		snd_midi_event_reset_decode(parser->midi_ev);
-		append_timestamp_low(parser);
-	}
 
-	/* each midi message has timestampLow byte to follow */
-	length = snd_midi_event_decode(parser->midi_ev,
-	                               parser->midi_stream.data +
-	                               parser->midi_stream.len,
-	                               parser_get_available_size(parser),
-	                               ev);
-
-	if (length == -ENOMEM) {
-		/* remove previously added timestampLow */
-		if (parser->rstatus != ev->type)
-			parser->midi_stream.len--;
+	length = snd_midi_event_decode(parser->midi_ev, msg, sizeof(msg), ev);
+	if (length <= 0)
+		return;
+
+	/*
+	 * The decoder leaves the status byte out only when it repeats the
+	 * previous one, channel included, and every status byte it does write
+	 * needs a timestampLow before it. Decide that from the decoded message,
+	 * not from the event type: two note-ons on different channels share a
+	 * type but not a status byte.
+	 */
+	status = msg[0] & 0x80;
+
+	if (parser_get_available_size(parser) < (size_t) length + status) {
 		write_cb(parser, user_data);
-		/* cleanup state for next packet */
-		snd_midi_event_reset_decode(parser->midi_ev);
 		midi_write_reset(parser);
 		append_timestamp_high_maybe(parser);
-		append_timestamp_low(parser);
-		length = snd_midi_event_decode(parser->midi_ev,
-		                               parser->midi_stream.data +
-		                               parser->midi_stream.len,
-		                               parser_get_available_size(parser),
-		                               ev);
+
+		/* a new packet cannot continue running status */
+		if (!status) {
+			snd_midi_event_reset_decode(parser->midi_ev);
+			length = snd_midi_event_decode(parser->midi_ev, msg,
+							sizeof(msg), ev);
+			if (length <= 0)
+				return;
+			status = true;
+		}
 	}
 
-	if (length > 0)
-		parser->midi_stream.len += length;
+	if (status)
+		append_timestamp_low(parser);
+
+	buffer_append_data(&parser->midi_stream, msg, length);
 }
 
 void midi_read_ev(struct midi_write_parser *parser, const snd_seq_event_t *ev,
-- 
2.43.0

