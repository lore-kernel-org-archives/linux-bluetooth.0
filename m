Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0A30AABE
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600315; cv=none; b=OPLqFNnmEiLc9iEaUNinoaK94n4/3wUQn8fZy9LY3RvAUwOI8UiOi6sTjv9JdLle5fs5/DtxzEY7MQZmzKXlKJxeU3QwCKicdz8E56UaV/xCBnuTifC9hKYHuq9BRlOjGJ8V2VGidyuuewgtT8nsY1E6Gjx5OpJZTd9zkghqwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600315; c=relaxed/simple;
	bh=9R4gUqq0mJuZ35mGDls8CP8pQCotv9h1QSIDDMiw2Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOhAW23qxNs8i6lOHlyl3ER9GYgq6NsjHjLAp5QQgIDvqSjQ8KCjWgGXkhXm9s2EsxML74R4AVQoUPaVXCo3PlFbj0G7usAmpQ5w5Ouk9SRxbYsyHFp4oNvf8sESzJN9/FsXpdMRMftylEWyOKhoDTbd0XR8Gtic/DbI0s/XDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew-cash.com; spf=pass smtp.mailfrom=matthew-cash.com; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew-cash.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthew-cash.com
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LonZF-1xKMJ126N1-00ZzLr; Sun, 28 Jun
 2026 00:45:12 +0200
From: Matthew Cash <matthew@matthew-cash.com>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Cash <matthew@matthew-cash.com>
Subject: [PATCH BlueZ v2] profiles/midi: Fix zero timestampHigh
Date: Sat, 27 Jun 2026 15:44:44 -0700
Message-ID: <20260627224444.531788-1-matthew@matthew-cash.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LGUY7giVDTv3vTs76u8iAxv+hPM5UkHI9g3Rm2khgmsl7JGsnKk
 D9nUTIMkdppdjVCkOnGEAef8WRGOTGuGRu4XHWw4MunfHu5rHRpOZFWSrDuN1qLwR3aTJaJ
 orNE228U3Mh3igRrxfNhs7bX9UPXJFYq1j2N8Ty0xl8rbsihB53tjQu35Keu7Ji47A09juI
 micZO28jOLm7xloCPCHZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eZnrMi/mMyQ=;6K/Jb/jsJCIlGCB5/wV/vhPidM/
 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

BLE-MIDI timestampHigh can legitimately be zero. The MIDI parser used
timestamp_high == 0 to decide whether it had already consumed the packet
header, so packets starting with 0x80 0x80 caused the next running-status
payload byte to be consumed as another timestamp header.

Track whether timestampHigh has been read separately from its value so
packed MIDI events with zero timestampHigh are parsed correctly.
---
 profiles/midi/libmidi.c | 5 ++++-
 profiles/midi/libmidi.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index 6f2914a8c..ef33f7dfd 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -110,6 +110,7 @@ int midi_read_init(struct midi_read_parser *parser)
 	parser->timestamp = 0;
 	parser->timestamp_low = 0;
 	parser->timestamp_high = 0;
+	parser->timestamp_high_set = false;
 
 	parser->sysex_stream.data = malloc(MIDI_SYSEX_MAX_SIZE);
 	if (!parser->sysex_stream.data)
@@ -355,8 +356,10 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
 	size_t i = 0;
 	bool err = false;
 
-	if (parser->timestamp_high == 0)
+	if (!parser->timestamp_high_set) {
 		parser->timestamp_high = data[i++] & 0x3F;
+		parser->timestamp_high_set = true;
+	}
 
 	snd_midi_event_reset_encode(parser->midi_ev);
 
diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
index 41f522dd4..bcfac2063 100644
--- a/profiles/midi/libmidi.h
+++ b/profiles/midi/libmidi.h
@@ -83,6 +83,7 @@ struct midi_read_parser {
 	int16_t timestamp;               /* last MIDI-BLE timestamp */
 	int8_t timestamp_low;            /* MIDI-BLE timestampLow from the current packet */
 	int8_t timestamp_high;           /* MIDI-BLE timestampHigh from the current packet */
+	bool timestamp_high_set;         /* timestampHigh read */
 	struct midi_buffer sysex_stream; /* SysEx stream */
 	snd_midi_event_t *midi_ev;       /* midi<->seq event */
 };
@@ -100,6 +101,7 @@ static inline void midi_read_reset(struct midi_read_parser *parser)
 	parser->rstatus = 0;
 	parser->timestamp_low = 0;
 	parser->timestamp_high = 0;
+	parser->timestamp_high_set = false;
 }
 
 /* Parses raw BLE-MIDI messages and populates a sequencer event representing the
-- 
2.54.0

