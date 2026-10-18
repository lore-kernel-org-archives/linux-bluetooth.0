Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86537F006
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298350; cv=none; b=Wjox1TiftvpfbvnWTVgM+dYn4IbDJkDj4Vt9GsUwbM0T/bD+OXQEMW+oiREdZu62Jt+oU2dEC0CRA0DJP3EomyjoOw8ymxLXK7fAmFisXcVUpUspkvPE0wsWX3+UyiSv/pKIijrVnxKKLIsrmXSZvsqbkdVKZXqyBLGEwI05yDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298350; c=relaxed/simple;
	bh=7v5Y+WuHB58BIfzuLW545jEjsXpULOzm8F1JKH2aE7M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tj+e7YUJWWl8t+mhk8MnlsQKoRh3soFdUUJUyrujYr09hG9iuGNhIqFjh9wYV271VQyl7HjW6sDsTosBqBjSV/j2XqQaUZP77LBHQpR8c7OZ3h1jhlzwOzZXlmUgyGNS0tENT8nZ9Fedboy3H2Z1B2Lv4T53bn+lT0jigGLkOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOQ9G06x; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOQ9G06x"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ca1ae18bfso33035b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792298348; x=1792903148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTiC4BZhPqRHolYgOgHlzJsaL4Tm6lgam+0dKN1GPhM=;
        b=EOQ9G06xiPXlg0mSFHl/nYCs+rGT1LC92KPYzeS3uell67/cS7mAjZLVaK9ZBhWpBS
         044C5E8vAMJnNKkmiCE6G/QHuMHs+BxYdi+CIMpv/TS8Md9lq8paPsNinepftO1MLbWA
         fEJnxZIM+GWfy8VmLK0/aRGauI1EhhlXFMbhca/sWQ0MpRPneXW8AZIw++foIbvxgEiI
         iAohaXk7FmAJTDPYcb8zGduZf+dPgAlU9Xo1sjRzQOuKsP0G6x7+fPJxO0nnSpsyiyYh
         ttbkSSUOiboAQwBgX5AeH8u2PID4X0kOBchtlfNkR11DuJXvOrvTlMnGaKDqZAjfybAj
         zx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792298348; x=1792903148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uTiC4BZhPqRHolYgOgHlzJsaL4Tm6lgam+0dKN1GPhM=;
        b=uXbp6cw01yU1tokvwctRUQKc3D7R6Pmjxk7dBrPA4mvkze01tseFvMmc7J9HQ0yCRA
         y7e+fC71QoQojSFP0egj6GoPKqsgp0VTHryrNC0bTSNtq0vWwQE+KZg1A9N+ExQsysEj
         f4vENasfcZKEwDSKNQ/x7iuhBNwWn3vaNqIsHe1YJFd4B4kCHxrxLdp/ECbmIrTi+lBu
         22Pqzu/G9aVgY4+s3tno0r95MWIjf0P8GGUW5cWh4rbCCnGt3tj0yID4S6q39wc3g8Bz
         IOww5YBiL+X/6wOghTHFkLhrxBA51kzCbug18qNLJXj+obVUZI+iUzdr313hypuPtF+L
         I+9g==
X-Gm-Message-State: AFq9FYLknvHXlYeSA41I4sFTEy0VU8V+rdvF3AiK34mLuLi4+M2maK+e
	4ScDn8FOviy/bCi8FT3LQ8u1yXpNBU7gzkRx2b78JnsI9LqMYxiJUOLXv13VK5x0Je0=
X-Gm-Gg: AYBFou166rpziUvvpZ4nNDlGImkRxNwpbCQbG5RyeAt7s/k9KmU8KqSRBqWihkz71Ag
	8rn7hFkq3U6tAv9YpWR1eVqerKoPwdpgd+CsmZCVNcO5AFQR7XAnPRFNoX8iVPgkUg+IV63yGZT
	0SkxGHYJ1AhGal+qBnBkWmX65k0a7g8WyUEAAHmqbFi7CvrNtV4bgR8GSoMr2LYu9WSXggqYFiB
	PN+5tonKFxU2IuoM8lUsSw7dIwD2jTto1Ab1fxEytytt6TLjE79TBQyI9IkQr198t30rIGLsFaI
	nO5d0kVkW/fOCx3skPbPxOiPV8JGlOFwG5kh19Fscf7RZrdXW8MQv2YVuM/sr0wn6Z7G+8PrXnZ
	NMuUqkR5tlz/S9tjbi9CSZZ1XbcHWJj68Clz7EASLbhnIV+Kvn7Cu7Xw0xISmSf3Y0irav4MA77
	K99eekeQTMnfOxjIWncppa9gvFJRToenxng9fo6kXlgo7o0DPWCcUEJfNOViDM+OVWyPKMHwMQX
	q18r7etcFnEqmzkDk/RYHEGzWN/2XE8qVFj0o4bpVm+r2f3nHzMMA==
X-Received: by 2002:a05:6808:3084:b0:4f4:ad37:ced3 with SMTP id 5614622812f47-53ccd3e9226mr4894335b6e.3.1792298348084;
        Sat, 17 Oct 2026 21:39:08 -0700 (PDT)
Received: from localhost.localdomain ([149.40.56.10])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388cb0afffsm5039338b6e.10.2026.10.17.21.39.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:39:06 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Remove duplicate check in transport_cb
Date: Sun, 18 Oct 2026 06:39:02 +0200
Message-ID: <20261018043903.1756818-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

transport_cb() checks setup->stream twice in a row: commit
0bed9886cff3 ("a2dp: Fix crash on NULL stream in transport_cb") and
commit d84171e6cd68 ("a2dp: Fix crash on NULL stream in transport_cb")
add the same check. Remove the second copy.
---
 profiles/audio/a2dp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 37f6d4ae1..cb1b3a980 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2749,11 +2749,6 @@ static void transport_cb(GIOChannel *io, GError *err, gpointer user_data)
 		goto drop;
 	}
 
-	if (!setup->stream) {
-		error("bt_io_accept: setup %p has no stream", setup);
-		goto drop;
-	}
-
 	if (!avdtp_stream_set_transport(setup->stream,
 					g_io_channel_unix_get_fd(io),
 					imtu, omtu))

base-commit: fa6ba55020dee3c3183041c854c347b4582448be
-- 
2.43.0

