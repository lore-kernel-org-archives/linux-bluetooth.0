Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657335FF6C
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843480; cv=none; b=UtzEUktijQAuoEMSfl8GPpXIgWHOj4kj/DeDAhmBWOaHg+6m6gERBTyFC3kALMKDRtIoVIEuOZyjgI61N+YglPhB6QEAGGGXw8IxvCQqurWnDRY7tQ9YW+abalQz4JdG2qIJUudG9Nej9CzeM3hchwcGfvZskitMydAaQEdTbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843480; c=relaxed/simple;
	bh=5nas4cQ3E9fsgBUOUljglGLmu273dOQvratkjwytbio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxVb4T+S76eIvcCCRiBSdLPCmI6NRjorWlwHIwte25FpjUfTNjuvBbaCRT4kgFzScbuaCLHv1OuWyUwUjVvg9FeFgosScUjlT/mLSirjXo3BGLbI6WiQY3rNZFrCo6qtLJDWk3mSOfatro6uRCksGeMRsTyhjxSCuKWBtmQCLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEJRZfsV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEJRZfsV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e82ea30faso762195e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789843477; x=1790448277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=74Oxz/onbGgKLp6041V1rJ/cPPrS5kf5f1XrZ70Ms5M=;
        b=iEJRZfsVOW4Pk/IuNKX6Tl6nMkKTzpYwWIUwuUqwCp0QaBSLH2mxePHj4zO5yXvR/D
         Wx+MhnNkWDz8jlzF1l9AyS/mqAI1ps9rZ9D6eoCq6z1cVDU/sBje31FoSxkwXKsW0oEf
         EvKcBiNVbv+2XmivRq0a2+NeJesx6w1Xg88CmBPPKsQpsE26gtL+ChcZniqmrYIaldQp
         sLpHHpLJZ/1/a0iDay91jzcD8OHz6mwNITNePsQYbqFZUprHdJ5bmIeaRYd8YTfJqukE
         QAbuW106cy39gIwar7KELC1UKzXgZ9/9aJ6wOQ5fUa7cU4WFulbPnJgjA3T4nNavNfKa
         0Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789843477; x=1790448277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74Oxz/onbGgKLp6041V1rJ/cPPrS5kf5f1XrZ70Ms5M=;
        b=2QVks3n0EYDOtnfhgeaij2rdvwhdbldn3r+82f/zxMRKSME24iio1aM2vo57GyJonE
         aJCc8tYpgv1t1dI3AaBoSBG035+94PBjSSCjvGgBlyz11AcFL+V1mFFVX+HN1ev8OdpF
         0nr9ex4h0uqSoki2UkFanikxNtM+HZoxrgemHAF54YlzQLmILS3aUZlRWDM2qPWecAi6
         5cL0TWMFq98laG9YNEABlkmj/LTD1Q8N7Ia0aofFaJtl+LBWceco2Hqprfaqg46LMGxd
         EXQUG7q+HhKE2eVGFuiWH/sVFa0BG6dvht8+4x4t7W1kObVO4gKI5isxgsKDiSTET6cH
         RKvg==
X-Gm-Message-State: AFuF++m3xPcRviap+cwaQluSruH8/1uKFPj3n+RBUHHQcHX+HNnq04/L
	gYDYoRyK1h8ic2RkD96ABfmc/w2HTcB28C5xXftqVpjxS5X1zPCCxr7lmmVOY+5k
X-Gm-Gg: AYBFou3sUc9uol7PsGGvdVkA8RqyCjuWcwC110TGcwiqXUE53RndZBP5o3SuQcAFowg
	dMtkyblIgQfFl2ElwMcoiVt2QEfj2hNQ8zNwChoWlXaCraoIFoIakQpM5Jx4xs6nM87+hDL5oLI
	ON1ZwmL928qZnwaLEJvK7E+24WqyBrufLRXrnDqbPuMgEmQa4hTRCXfdMz3c9bTHeLVQWmYKYCD
	FGGDYRE3Ws5SfQMPDnPxk0tOGUXAx5OrVF+troLqG2gYi/jIWtpVzhjy3q+2MvRN2xHLuWmVl7t
	fHX9nbw0ZXCYl4CfiuWSOfTnNDYTLCypIicmtUzpx60eA0qwTUelhwIVImn64TXq5nwyyu62BaN
	2qhAu1Lh+DQljYZ4FLUk8GUgFw73g2MKNLBBC4/4lHO2Ewk2u0PcfE27HFC/TGdIgbWcSwlbtMh
	jkQnPg6COmc7ke1Egdl0Rc8PDz+/04qINTjokm061mgBm8Udntrj7WCGHvsWXWWcs3Njy2Hh/49
	NTbxs78Ecm+uSxE1uPvS0Fr1UtEPZhup7ogLAl6+7Xvko3003vBcrk=
X-Received: by 2002:a05:600c:354e:b0:49e:479b:c13b with SMTP id 5b1f17b1804b1-49fc7dff668mr72658655e9.1.1789843477044;
        Sat, 19 Sep 2026 11:44:37 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd8bf159sm79386795e9.10.2026.09.19.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:44:36 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: [PATCH BlueZ] a2dp: Fix crash on NULL stream in transport_cb
Date: Sat, 19 Sep 2026 20:44:35 +0200
Message-ID: <20260919184435.102408-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

transport_cb() runs from bt_io_accept() and begins by confirming that
the a2dp_setup it was handed still exists:

	if (!g_slist_find(setups, setup)) {
		warn("bt_io_accept: setup %p no longer valid", setup);
		...
	}

That establishes the lifetime of the setup, not of the stream it
points at. Several paths in a2dp.c clear setup->stream while leaving
the setup itself on the list, so by the time the accept completes the
setup can be valid and its stream NULL. confirm_cb() already refuses
to start the accept when setup->stream is NULL; nothing re-checks it
when the accept completes, and it is then passed on unchecked:

	if (!avdtp_stream_set_transport(setup->stream,
					g_io_channel_unix_get_fd(io),
					imtu, omtu))

and avdtp_stream_set_transport() dereferences it immediately:

	gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, ...)
	{
		GIOChannel *io = g_io_channel_unix_new(fd);

		if (stream != stream->session->pending_open) {

Observed as a crash on a QCA9377 (13d3:3503) whose controller stops
answering HCI during audio use. From the retained core, %r13 held NULL
and the faulting instruction was the first field load off it:

  bluetoothd[398112]: segfault at 10 ip 0000635d944b47e5 sp 00007ffefcba28d0 \
      error 4 in bluetoothd[367e5,635d944a3000+f3000]

  r13  0x0
  => 0x635d944b47e5:  mov 0x10(%r13),%rdi

With the check in place and the daemon logging before it bails, the
guard fired four times in 19 days of ordinary use on the same machine
(once on 2026-08-26, three times on 2026-09-02, across two daemon
lifetimes and three distinct setup pointers). Each of those is an
accept that completed after the stream had been cleared; unpatched,
each is the dereference above.

Check the stream immediately before it is used, so every existing path
keeps its current behaviour up to the point that was previously
unsafe. In particular a bt_io_accept() error or a bt_io_get() failure
still reports the real I/O error rather than this secondary lifecycle
condition.

commit 125a2e237e7c ("a2dp: Fix possible crash when accepting stream
transport") previously hardened this same asynchronous accept window
against the whole setup disappearing while the accept was pending.
This covers the remaining case where the setup survives and its stream
does not.

commit 90a600895d80 ("avdtp: Handle case where remote send L2CAP
connect ahead of Open") also changed avdtp_stream_set_transport()
itself, to handle a transport arriving before Open. The function still
dereferences stream before reaching that handling, so it does not
cover a NULL argument from transport_cb().
---
Context, not part of the change: the crash was recorded on a QCA9377
(13d3:3503) laptop under Ubuntu 24.04 / bluez 5.72-0ubuntu5.5 and the
site was resolved from the stripped distro binary, then checked against
a retained core. The record, including the four logged firings of this
guard and the crash-site method, is public:
https://github.com/ivoitovych/qca9377-bt-hang  (patches/bluez/README.md)

 profiles/audio/a2dp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2672,6 +2672,11 @@
 		goto drop;
 	}

+	if (!setup->stream) {
+		error("bt_io_accept: setup %p has no stream", setup);
+		goto drop;
+	}
+
 	if (!avdtp_stream_set_transport(setup->stream,
 					g_io_channel_unix_get_fd(io),
 					imtu, omtu))
--
2.43.0
