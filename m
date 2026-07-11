Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3B24336D
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753354; cv=none; b=uhcyAbdrGY6ES2tmaY4hUdM/VMyhmtQY5OKXq/hwKWcLqPnnC5HdxPAP4K1AzgNF3LhrJnqkHIzEf2/HBdRJQ9H+WHI76t2bJDHXdAaTRoBWFbjNo+BMS2qI8OpDR/WDezQs7se57UPaIVzWd3ssUMcUtN0oFY2TyR8BVRbgEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753354; c=relaxed/simple;
	bh=VtKxWqbiXbhMNgJQHW4nIRt7TYv1yvAheELP3zFmHc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wr746rwXuOSvLo2QCUJNbpFrgqPsahSGkidotTamJNEmj6aD3rR+IJfNyXZBVyF0Az/ZN/6fNhS9767unZflvKm+C63Ug69Jx1LzwzMvXrT7/MUS3Mg62xMZBrnG0sOGXHPDt1vn/ZkcwWu9BKF+GSf+6K1OA+Ob7IJNFbU0Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIN9U6gI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIN9U6gI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso900892a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783753352; x=1784358152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzzgPbKZnUxRMuwgtVzZmHRbIDPrjvANDg5ZO73w1tI=;
        b=DIN9U6gISFHeh/osNtboTB0JEoHGrc42H9VJUmiXcTHKr+lokh/YnKQOVo+pC+t57E
         cJxXIU4l4xgcysru5ARWjSlxj3gONvWYkfrVaVoYxaFTZ0yoxlbiYVIMUQH0tXdmnz7w
         eEJUKBsYkap+Jm6WVrxGs70tDKsvWxthPcAsp9xEaP2+pRezk4E9GQ6x4V6/23PGSNqe
         TAFFNkEY6Wo0JjTdbwhLldDWa4fhFmnwGwfhM6rYaiDAFYSDkKIhfjomAQO4+nwwE6ok
         bdVyXGxczvLEJ0UHA4sBI2RLpOT0BHYxB/B56mOY8ncqsy6L1iczE1PaDTa17yx4HI7d
         TwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783753352; x=1784358152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzzgPbKZnUxRMuwgtVzZmHRbIDPrjvANDg5ZO73w1tI=;
        b=NRpNgBCollU+rgYV6scw3TcqWpqxI3S0ro35GUx3uVdxkiEXUZg6R4MDeYBy7CrOlR
         3jptIKtIICmW3R/VcLLjasCbKVtm53Ufwfo4lfbTHRIwgddWfwUdaHVeHAh8ufwxm5sy
         jh2egzqSjYu/WUhShHT8vSpEk3lYE7P15r755IKCxFn03iJu8GQA1FFBgV+LHqGHhMqo
         Asqvi/FjCr+QLJmTU6RPVgL4AsWERWAkIffTEAqSS63amPJXVOjpXAuFVKYSxk4uYn/p
         F5VpPYiItIhSd5kVMDKINgA5P/67fkwGszEsxXGawZUmHGKlwp/cBYrLQtH0OrlMivlI
         GuDw==
X-Gm-Message-State: AOJu0YxvZgSTMadf2i3TdN0ehqwTyf0dvy7FVBeaVy4Yl0gAXB+kqw3U
	kCxsNb71ODWAUflUnb8Sr+6I2oomf2gNOAxZbFTjx5M1gCt26i3CwbvoYpyuo0fA
X-Gm-Gg: AfdE7cnjcqzCaI5qLiUwefeNIKGkrXeNS5xmLu65TLfkzAMkHKu1pJ52/0S6O9L533y
	mK0FnWQuj7BW3vzIub0+5yHewJPjmq94UsQYD5Xq7L/1frUl9A1sHGMxrvdQkgzaGL4+A7KsjV0
	eHJ+U+ivOIBUz9szNPy4X1TD8Bzl8Gc0Te1g1dD+GKaWOWLCJ4XzxK6qqaaDhWhB775aO/IvKht
	EUz+vLOmzLI6lORPuSE/BZ+Nb7S7DJ3SuupzNq5R4GPI/7BULpLN0aXE0WGGanG2uHbiZM4vNs1
	lR0Oly/MLbAUiRMVp81b0Bwk7HXo5HEVos9AflXhpWVfAyEB2rAo1Pkw7cs/ZNDkEYHWVLGJHih
	1imU4BwNjLcjxBSRXID8oj87Bv4oY65hTyia+OtCKuEfbfNzrQ9bR2sdbIJ3avM84U7dGtiLOJJ
	j7CoPEAFQixHtBXIw3g9sAx+62MkhKre4msxHS/VwIvimtP6y4gryFlQbu1757GAf3bG7gnARkC
	ILF6xp2Ykg47TL7aVYT8kEEtvnhXUeIARRumU18Hv7cem5HZ0fWGG9O1zLrnFU=
X-Received: by 2002:a05:6a00:4b55:b0:848:5bd5:6e86 with SMTP id d2e1a72fcca58-8488978c0d5mr1997328b3a.53.1783753351810;
        Sat, 11 Jul 2026 00:02:31 -0700 (PDT)
Received: from steamdeck (c-24-18-48-168.hsd1.wa.comcast.net. [24.18.48.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8494b279e8bsm167615b3a.33.2026.07.11.00.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 00:02:31 -0700 (PDT)
From: Ferose <ferose2@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Ferose <ferose2@gmail.com>
Subject: [PATCH BlueZ] shared/bap: Fix rejecting re-attach of the same fd
Date: Sat, 11 Jul 2026 00:02:30 -0700
Message-ID: <20260711070230.26553-1-ferose2@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the remote's STREAMING ASE notification arrives before
iso_connect_cb() fires, the race handler in bap_state()
(profiles/audio/bap.c) already attaches the io to the stream; the
comment there notes "Order of STREAMING and iso_connect_cb() is
nondeterministic". When iso_connect_cb() then calls
bt_bap_stream_set_io() with the same fd, the guard in
bap_ucast_set_io() sees an attached, non-connecting io and returns
false. iso_connect_cb() treats that as fatal:

  profiles/audio/bap.c:iso_connect_cb() Unable to set IO
  profiles/audio/transport.c:bap_state_changed() Unable to get stream IO

and tears down a CIS that btmon shows was established successfully
(CIS Established status 0, both ISO data paths set up). With a device
whose STREAMING notifications consistently win the race, streaming is
never possible.

Treat re-attaching the fd that is already attached as a no-op success,
without re-running the per-stream state actions (which would send a
duplicate Receiver Start Ready to a linked source ASE). Attaching a
different fd to a non-connecting io remains an error.

Fixes: https://github.com/bluez/bluez/issues/2223
---
 src/shared/bap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index db6f4f2..1660b8b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2589,9 +2589,18 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 
 static bool bap_ucast_set_io(struct bt_bap_stream *stream, int fd)
 {
-	if (!stream || (fd >= 0 && stream->io && !stream->io->connecting))
+	if (!stream)
 		return false;
 
+	/*
+	 * The STREAMING state handler may already have attached this io
+	 * if the remote's ASE notification raced ahead of iso_connect_cb
+	 * (see bap_state() in profiles/audio/bap.c). Re-attaching the
+	 * same fd is a no-op success; only a different fd is an error.
+	 */
+	if (fd >= 0 && stream->io && !stream->io->connecting)
+		return stream_io_get_fd(stream->io) == fd;
+
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
 	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
-- 
2.50.1

