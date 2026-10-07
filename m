Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2A35DA61
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402738; cv=none; b=AfqbRs+nYpseJ0bxDfZ+wxE47N9nJh+Kyh5BMIuG1NTfG7RQb1H/Ozp7HkykbIo2NQ+ibkqeMIkkPCpZznYPiWcIKOcidIrdtrVdIrpb3bTSI4GUX+QslPTIAU9d9LzBvXNEE9hpzGLG4NFxrOabev3Yu5zqcOMPK0DhB7vOkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402738; c=relaxed/simple;
	bh=IoyHQsJfk9nmfT2Aveiglj8IiuuCyY0eHtpbFvGstmo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LJxXjakiu0cXWc9UgZtldWy2Dwcg8IJpNwk8I/iucMwsxsYpCVWvPEjBF83hq3bCHDBr7ybH+AwO7lTozmFRJaUd4Wgvx+wWUy0fS98hYIN3xc4kvSHnMzZCQIISChTe3alasoTVXopfw0RQyh/le/CQzebUTUBw7lq2PaaZXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0Gy04C8; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0Gy04C8"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5e189660cbdso3267382e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402735; x=1792007535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RQ+nFqmXWP3Yaq8fLicAugKROCa/ptq+5Eb5BTrd5wY=;
        b=A0Gy04C8mZfEA6MfjYF71ycdeN4ruRdyQvT/bPNdy9hkFmY/8ErvnRwI9viQ1p9X9Y
         Khs2Mk5uudD6YhqAwdgq6mK6xvvnlejawGFWQkHJyGplEVK6ydS+e06DacMNJvFMxcvF
         dv6iCuDriB9LAiap4f4aqZYZwC428tSVkRy3jsbCLvV1yQPwWf8lh82xihH08ncP44bR
         nP9BHV9jL6ATh1y+Sq8aKoGDE7ZVx+/kIf9DM5BN8G9LWG9rE55BKdUZCaPkEcmwjuZj
         BmpIlkx8pnbgMDREExl/o/lbklrZRp6ZQ11Vif7o8TUnZLRJOu0LqAoKcYQjfagfx7Rl
         mClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402735; x=1792007535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RQ+nFqmXWP3Yaq8fLicAugKROCa/ptq+5Eb5BTrd5wY=;
        b=DQEOT0Uoy7smJUA06p/ktmycI3CrFDmDKe/dnfEi7/PlYoCd/hRDQyI3ZuwUcCe3nd
         7ySbjv62U/SxKUQcQL0tHQSGvvDMnzPp+A0JWbTROlUzmLxLJpSmn0ZcYnZomgoNat63
         k1i4UQCMl4pA0UBW9rrYCLV2lacWbgu0WkdDh0erPW92NYtXVlWBRtA3/wORMY2aIbWu
         3L6nUO7da8e03PlRKFp4jU6UvH4GpdnHxhycfNmLsgBOpFDELgUUw/0XcwdvMnAZ/epJ
         MKGtWCnw7CO5eHbSkC1+TSKI8IlpIyImvV6OA0+AXuZT1ne8rQxnsdgkdhcyIXmYUw0m
         RKdA==
X-Gm-Message-State: AFq9FYIaK0af6PFAeC+nGl2GYCkKEBUAlsxpm+88VXOW7BUU8tFnJudN
	/+xASQ4fMPlsCUr7XOGr3AGrMM24Gl/nJKjVP9SMxeVpVehanKeKke/lMWSuJhZiWVyAKw==
X-Gm-Gg: AYBFou2I7ld24C8MNxCVmIQQ1okAWgKNSGQ2w08oHExcvRpYXFW3un2qb46Fvmji68b
	3UHb+qVf9qg9iP/pORgmaQnlNj1S0OM7INHKjkVtxGyMW66IpLAzCKfzizJPewULL32zLCfZH8p
	B9+jT7pqYLxd9hN5MQ8YYtLfetL+MdkW2UT5o8NDmr/JjglY46anEaJGrxGh2VWRaTNXeSe9FY1
	LBDmPwnJrlrlxacjygzaZf3B/cYemQ7LDwJ54bKPRIY46BlRjZ3XO2oHg3fCvRw8ZAV+K4ZbuJs
	p/WqI3Et+UvFLlZxVkqC6ATSwbOZNQFfS68vzRV5NgCd5R4GnHZyGZCKyCuwFp5gNtfGtn1xgAh
	RIfJ82YjQH+zavIqDINiCITbrxXahdNbou6ScQFqeSjukNgI7pZf2fNpsJ1GpRULa8pjOhhBr2P
	8q8So4K93tThpUGUhJn575/3kdN0HVn93iPuaIAyOsjrKP5VG/v7aLXmgFyDamoclAR8yNrUOZV
	Ccx4pkOFswE39yjdGLJEvwt2cre6XmYuzktzg+e4LqRoHH9kupscEqtxy4Y/b1DqGl/wQkSy4Y=
X-Received: by 2002:a05:6122:f92:b0:5d4:acd5:2835 with SMTP id 71dfb90a1353d-5e6d2d2333amr1286493e0c.15.1791402735523;
        Wed, 07 Oct 2026 12:52:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c409aa8fsm2775177e0c.4.2026.10.07.12.52.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:52:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] a2dp: Fix UAF after rejected SetConfiguration
Date: Wed,  7 Oct 2026 15:52:04 -0400
Message-ID: <20261007195206.350586-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduardo Alves <eduardoalves8006@gmail.com>

When the MediaEndpoint1 rejects SetConfiguration, auto_config() calls
setconf_cb() with an error and avdtp frees the avdtp_stream, but the
a2dp_stream wrapping it is left on sep->streams with a dangling stream
pointer. The next stream configured on the same session finds it in
a2dp_config() and reads the freed avdtp_stream:

  ERROR: AddressSanitizer: heap-use-after-free
  READ of size 4
    #0 avdtp_stream_get_state profiles/audio/avdtp.c:3952
    #1 a2dp_config profiles/audio/a2dp.c:3282
    #2 select_complete profiles/audio/source.c:200
    #3 finalize_select profiles/audio/a2dp.c:486
  freed by thread T0 here:
    #1 stream_free profiles/audio/avdtp.c:747
    #2 setconf_cb profiles/audio/avdtp.c:1504
    #3 auto_config profiles/audio/a2dp.c:752
    #4 endpoint_setconf_cb profiles/audio/a2dp.c:768

Fix it by destroying the a2dp_stream when the configuration is
rejected, which also drops the session reference it holds.

This can be reproduced with test-functional using two VMs over btvirt,
where the A2DP Sink endpoint replies to SetConfiguration with an error
and the sink then connects to the source on the same session.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3c991de6acb7..08a9e1c96e4f 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -748,9 +748,17 @@ static gboolean auto_config(gpointer data)
 	}
 
 done:
-	if (setup->setconf_cb)
+	if (setup->setconf_cb) {
+		/* Rejecting the configuration frees the avdtp_stream */
+		if (setup->err)
+			a2dp_stream_destroy(setup->sep, setup->stream);
+
 		setup->setconf_cb(setup->session, setup->stream, setup->err);
 
+		if (setup->err)
+			setup->stream = NULL;
+	}
+
 	finalize_config(setup);
 
 	setup_error_set(setup, NULL);
-- 
2.55.0

