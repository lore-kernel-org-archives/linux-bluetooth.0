Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F8224D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782583359; cv=none; b=fmV/S4KA52dY0+qCVJAtpJQ2zmW75joTRyq5ApMxs2kAYufF5PMEE7YpJV6g6MjT5GwwQvzv0eNYe7pVdZKEMbVOAaEKtbornqvjpGB5iwNjFufDYRDuKPnCWg8aTEbt+MmLJc5HV4uaH9Q8GpScMmAvjQMNaPFrKIw96jTMBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782583359; c=relaxed/simple;
	bh=NA4Oi4Bxj+nA4JdxSVkw+ky57rK019lbvWmDH3z7QrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i419Yhts3FCuKdgBMZZLZ3FuhyVvwdqGMvZ19AZE+42yOaRSe1fT0vc2pAt7mDfgeSu1qr1vR0ww7phWMB8RnYZK+qIHyQxYlScbkxkXRI/hthRCPFFJY5VKw0UuoAfmeTgyhjw5S7Pp50BT3glK5ThBuBXcsAOYWpTY1ZYySf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew-cash.com; spf=pass smtp.mailfrom=matthew-cash.com; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthew-cash.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthew-cash.com
Received: from client.hidden.invalid by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Le6X4-1xTPRa0O5c-00iCTA; Sat, 27 Jun
 2026 19:57:26 +0200
From: Matthew Cash <matthew@matthew-cash.com>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Cash <matthew@matthew-cash.com>
Subject: [PATCH BlueZ] profiles/midi: Fix zero timestampHigh
Date: Sat, 27 Jun 2026 10:57:12 -0700
Message-ID: <20260627175712.228564-1-matthew@matthew-cash.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Kq9uGMI/BPwk/hSUxuh5+xx6LrMrlsKDPntNOZ1eEqYkcmzsM0P
 BwsZqxRJsMUtT+rGcQt0G0Re4eBzQTZJGdDzsyKqyq92HwLtMCjENamH99HmXSnirhiH59w
 S/KDqsnFaMGZdOtjdk2zYWXJazvN5AZbAVAKfTtKa8MG7qpNdJU5vUuCLBiUb0gITA5KAPr
 Or35c9/H7WFm9JplbN0Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y93wxsLZOAk=;bJPC1JrJnh2Iiw9hXUyrGfobepQ
 EgwvyN4yCVIWaiyqzGycdpk9Ee3d2pM9xiPcyVCL25U/g7Pw5WUJo1vfUT3xMqRjZ4sYr4bhb
 6e0G9E1pSmGnAd/Nluopd16QSYVdgt+74+nij1RBszsxIAg1bWroviUG0ZeU0s4a7egW8nPy0
 wVnIW2A9QcMwZbwhIl1jLOtKWEmrdobr7bio5QrGKC3k2E5eh+Q4pRh6Unzj0Cf5T2vvkhXiq
 MS1y/TMtHTdu6vRvCXyQbKT6sZUQGmIgvf2+ska3ljJRZrpL1jarxpNgoDEB3xpEA6fMP9vAO
 cLTbyfhOBpIH7Nwl7PEXzc7cFHqAkTyGPXF1muCXFLiz59echxCpiQ9TtuZzqd3RI8xU63jq5
 3KUqpF3SXrX57+Y6+HUE6bnSMj3kjYUYSGdLV+YDtLX+oEPgPjb2rytU1md1XTnVyilrGHIRe
 YKyOb4DYNrpge0hpJ2hIBxuBaIdfwCycrlx74L7uoI5SN9uk9XECknYycA9W22sfaVisKEgzN
 rcDrXq/uJFK5p8CmFBm6npdUHBmhDtaNBUTCuWDEho60vnMb7tgbQWopFP4ymOlgXIB26bfv4
 iWrKoVXuo/OEZYDxaOywHV45bpaLun0pv0pTHREqzBwhvg5t4DD9lazo3BnWeAWwMZVmWnMs7
 vmAVYYKDXO1tCQQLzliI8LWoLv8tdTwepiP4rYyAmIIkN8IhAJL3Nrs7BVLWTgUzlOeoG9A0J
 0T32bflK/3IGKhggssmctGyR0VOoMQNQ3C/Irtl/C2pW/21WHkZ/5ypl0mV+dYTPlE6L2z+W7
 P0EROncwy0ni+3XvDNPBpvZy+l9i3XLKJLlfTphNGZQ5v4Qg4KQ1fTWANJ7kJzrl7v8s/usJN
 aFy/9wIKv9J5az33rfohxH6iDBX4/94nSkzTKX2oCKho0JfS2ZWztE1ewI5dwOf0JkUExX02P
 MAWF0ZQqkapeVGW5na751+otpvFukNOib37AuyOH0zuUE7ZCFzM/sR7FQdH3NQ+wKcvSH48to
 9i//CqfORLhqTs8hw56X1922FJjElsI7aiww4RzR/m+PiJ9M44/A7KGkSYkMt1ohW8fl/c89b
 GbYSGbJp51rUNYw8fSwFiGRtZwO8t6HFeXq/7Z3n904z73o5T29ANr5r7IPP+8taEIOii9Pfv
 eCo53oL9pwJYDZkKtuTsX8wbj6MHGjKzbBSuiue7THfy0BiN/d5dHjDSKpf/9FwRBAYEi2uSp
 XaDGBNZoKs9BdWs6ln45xcRNVsz2t2MRotwM5EHbGdqfsj/8zYuxQOZBp8Q2RuFPG4zi7HNfW
 iNkHLQ70QSD8tch1EtvxBIf9T1Gu5gv3SO/Oajro63uJ0JcIQ9H1ihSX0tgMzmqAvKW9fDLEv
 95pCoI3HtD+Zi5jkyfnw/UQLiESMtevFXt5CIFRh67Z6Z0l8o1G5nS6JaKD9CjuDyb6VbgODd
 SU0VAvcZRzxFh2WpYhipIz0tBue2PGhfmeq4N62G/esXZIdz4mp4KEfInrGmhGOdhrWBLr/oP
 nXoPGH2Ed4ie35oF6u2dSXlDbyps19tKL+kzUD3QdmRsxx/3oUrox9Bllj5GG05N5yQ7OS2rT
 aHJOP4si6zTYMeW3gUQNGmlStddscflaoZ/0Z/CkM2qhyOHr+zWbc5Y3J2ZM0jjC7W9uCLWnl
 eHrw6/Yycwhi2WkZ8XJfPbIoG5DAzgPr42OOj4PUQR7q4bmvxIoQM+1+AxmJnEQLO9yVLGrp6
 3axM4uN922pFK8aPtSBi88yWkqQXIoNRwnjSZfBFyV+V3DmBPoFKl3wfUtH6oIeGuCC3YkR//
 DB5Akgxt/HvNE+gykr+UAxKvR1AJyQWGIl2rO5RStoJHxOocTRnufpJ1CVqVZ+jKs1WTnlCBA
 fJX2uY/hlXEpRnfDLzISq2j3wicB8LjgncG3u8=

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
index 41f522dd4..9d314cc11 100644
--- a/profiles/midi/libmidi.h
+++ b/profiles/midi/libmidi.h
@@ -83,6 +83,7 @@ struct midi_read_parser {
 	int16_t timestamp;               /* last MIDI-BLE timestamp */
 	int8_t timestamp_low;            /* MIDI-BLE timestampLow from the current packet */
 	int8_t timestamp_high;           /* MIDI-BLE timestampHigh from the current packet */
+	bool timestamp_high_set;         /* timestampHigh read for current packet */
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

