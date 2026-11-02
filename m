Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657596;
	b=CvA8etdqJAP78dYalJOAGlG89hcYhda1M4dQlwLZo7+s782FMMAcLjvNWGH6WQ5agtmG
	 HB+ItRsmQm2hMwam2B55Qn5aOOnF1Bmj8GLUyPK92Lz5MBVKnT5sNxEwpozlPMUXVmjYM
	 2KWqwC5fl1XQawPmkI3YyGx+LsjmuJrSgaioJNNTCm6+cYxSUKzg8SVSCxctLZrH0ZFjj
	 jlkQDQRB0Myk7y3bJcC6enrjHSwTiWR3ebyuPgY/eMEEhmRYSSJLnpVerzSVsA5Qy4YaB
	 /Amr3YcikDjSGqkJ/YbBYDdNXEQU4WQ2EMCNKioU5GchIV1fnrYf4AZJadWVkdW4QUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=smWY0rwFNPwgx/jGhdDbJOXQyoaMMjm51SWzV+xWcKA=;
	b=oEjOTFOYMCq0bZg+DbJagSe2hMvJHFPQRaTCHdQeK9Vm7t2EXLN1Y4oU4h77rEHE1hdT
	 PpxP6L6CVR6zKXBORrjvbhERJ6mZMBP8uaKO8D7HGTzDaryzX44vDKSrnD1v8M15vm/MX
	 M4kJmnJiqWJKsdunHGSLUHre6YKSPctZqPuzes0J0rRZ4ZtXoFvftMZMDbVyso0nCAvUK
	 Mv+73Lk+BFN4COhrv9vsPh0ciM9E1ig5/FIQtdSdX6sj/K+d1Fq7B19xnQHxvuveiCfIa
	 DVSsdb+Eaw3J+l0ji37lRwjdFHSjVsMYn9FLNMXRO8V02awZIMaiI53coxj0todcFDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPjIKOov;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C458606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 22:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C458606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FPjIKOov
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2167786f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657594; x=1794262394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=smWY0rwFNPwgx/jGhdDbJOXQyoaMMjm51SWzV+xWcKA=;
        b=FPjIKOovbDFCZvlX2Aj1Yh5SAT82evrSzEQ1WeOHiw9pIY+d6owhgZc/XF4SzXn7Eg
         lnqYxuUwXK0Lcg8WGcpNaIbBthCrL0woQTA98sBAbL1OCC04VamqfN1g1jMwCt/tsuqH
         TqP5L+zqby+9bX0M5z7VeCjAsRlYB/WUmpu/z5vhEdpiu1CX7XS9YiBEvaUekuxRuHNU
         gXJxpEEey5r6xp5/Q29PxjjIu9J7SB2Djva/yaP1pZIA+eGOGI0L9TJPOkfL9VzQSlSq
         yYSVYQWeC5YQr7WM1YGKbk/J6M490LXxFyPLkEklOtd0ltTX5A5pnTGbsnaMACaXbU+0
         4rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657594; x=1794262394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=smWY0rwFNPwgx/jGhdDbJOXQyoaMMjm51SWzV+xWcKA=;
        b=TmMWvFjGviewAN8oTqGYqsRv5UBvDNw53J7fLkgV1kU2K4+TL7R/TeGLsxLz84tCOV
         20DpBCNr3Fk21raD1X8tTyj3PxyGBOUvBLxrM0EYUuCXD4QwuNBY5U3Oe2GDMu5DWugY
         pjdyEXbjbacntidAWzKOXQiwIHmHlsFaXpZ+YoZapBPQ8hYHqu4CJulwXe0t57mRDzC3
         skwCQJTlgWyeGUa9Fkcan02U4H7xofmwrhmVj/N1FMob4ZY+8iyiH8ayd5fy2e5txO35
         CAkcOttMUzl0689iaOqlGOUn7q6Y2YVIOz7zxcQvwkWiBFzigRT43fLNWWgEKNEWUFsb
         3Muw==
X-Gm-Message-State: AFq9FYJsqv9BNEofN9l7vFY9twLiakwsCBg4neJmL3piAyCMb97Jq0KS
	rinEvdGV5GIhDv6Ae49W+RF80safllbugUOZG9epyjO2S+oEGOMUKsRhvg37XqWesN0=
X-Gm-Gg: AYBFou09DmwexeiVXCLAMFohQUsCFpoHbFN5HRpIksLWRyBIVxVYk8VJfAZqmPFMFDH
	AGypLSLKqYE8M5Xga10MUcdyfj2BA+iIa65uEtnY4PGkZ4UBIHJOMHjhm03UNHdsmbrnNuKfMEz
	dScpMMilcvzTekjBddrFaHrfJY44XrPNP7JXw1DKuof3hwZhXXdXSC7JQZicsO6jNkSe6/aSFKW
	cJEmQMljfsPkSyF+kvu6eZmC05Elfq4iqSY3KKBmK6E9w6j7IsiFzjzQAdawIUPGQHF8JU6zAkC
	RBE2FuDlcUqlx593bYiv3iUMmlaImzPrPwNBxR9dnOX3u87C/lfreI4I0oZoMOrlzgaTaY8Hi8J
	zrMP7Azq7PV9pc4Fx8f50vH7l5hLs71ag3w6i2lYIKcsZR9kHtQvs6T6OKyBPrDr+DqiJF2DlcU
	qibsPitgIJJSQAfuFSmz9bAtjO+P/ybAQilFwYJESpNW13bph0mk1/ObO4NHSIIkwsQSxMe3Fm0
	hDYZNkDW2uJrquHNdS3YnIqYGR4i2VIa4CBhNwtHWfL9IrfYfR0S9MOToPZvYAoa2nWN/RT2ME9
	ZonZdE7V9jjOWvLUY2i6I+y99J5/7u1HMobYFBiJltwUsMzwylfxdHUqmPkOgD2irm1Tl0KIOCP
	XG/gSCV3RzlXrSAxfnf1iM+/ah3xPX9jWXP9mvUlbrVz5USUDKA==
X-Received: by 2002:a05:600c:a4c:b0:4a2:967:dfb8 with SMTP id 5b1f17b1804b1-4ac1765d7d7mr261754655e9.20.1793657594572;
        Mon, 02 Nov 2026 14:13:14 -0800 (PST)
Received: from pop-os.. ([2a02:810d:478b:2e00:d078:1466:9ea1:3ace])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad5ff8sm207894205e9.4.2026.11.02.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:13:14 -0800 (PST)
From: RasmusML <rasmusml0501@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: RasmusML <rasmusml@hotmail.dk>
Subject: [PATCH BlueZ 2/2] unit/test-midi: Add multi-channel writer test
Date: Mon,  2 Nov 2026 23:12:23 +0100
Message-ID: <20261102221223.16079-2-rasmusml0501@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102221223.16079-1-rasmusml0501@gmail.com>
References: <20261102221223.16079-1-rasmusml0501@gmail.com>
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

Add a writer test with messages of the same type on different channels
for Note On, Note Off, Control Change and Pitch Bend. Each of these
needs its own status byte preceded by timestampLow, and running status
must only be used when the channel matches too.

The existing writer tests use a single channel for every event, which
is why the missing timestampLow was not caught before.

Assisted-by: Claude:claude-opus-5-5
---
 unit/test-midi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/unit/test-midi.c b/unit/test-midi.c
index 702133e59..79cb03123 100644
--- a/unit/test-midi.c
+++ b/unit/test-midi.c
@@ -525,6 +525,24 @@ static const snd_seq_event_t event5_expect[] = {
 
 static const struct midi_write_test midi5 = BLE_WRITE_TEST_INIT(event5, event5_expect);
 
+/*
+ * Same event type on different channels: each needs its own status byte and
+ * timestampLow, so running status must not carry over between them.
+ */
+static const snd_seq_event_t event6[] = {
+	NOTE_EVENT(NOTEON, 0, 60, 100),       /* Note On */
+	NOTE_EVENT(NOTEON, 1, 64, 100),       /* Note On, other channel */
+	NOTE_EVENT(NOTEON, 1, 67, 100),       /* Note On, running status */
+	NOTE_EVENT(NOTEOFF, 0, 60, 0),        /* Note Off */
+	NOTE_EVENT(NOTEOFF, 1, 64, 0),        /* Note Off, other channel */
+	CONTROL_EVENT(CONTROLLER, 2, 0, 123), /* All Notes Off */
+	CONTROL_EVENT(CONTROLLER, 3, 0, 123), /* All Notes Off, other channel */
+	CONTROL_EVENT(PITCHBEND, 4, 0, 0),    /* Pitch Bend */
+	CONTROL_EVENT(PITCHBEND, 5, 0, 0),    /* Pitch Bend, other channel */
+};
+
+static const struct midi_write_test midi6 = BLE_WRITE_TEST_INIT_BASIC(event6);
+
 struct midi_data {
 	size_t events_tested;
 	const struct midi_write_test *midi_test;
@@ -618,6 +636,8 @@ int main(int argc, char *argv[])
 	           &midi4, NULL, test_midi_writer, NULL);
 	tester_add("Split ALSA SysEx events to raw BLE packets",
 	           &midi5, NULL, test_midi_writer, NULL);
+	tester_add("ALSA Seq events on several channels to Raw BLE packets",
+			&midi6, NULL, test_midi_writer, NULL);
 
 	return tester_run();
 }
-- 
2.43.0

