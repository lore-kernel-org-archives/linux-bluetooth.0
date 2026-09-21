Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82E4457B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023636; cv=none; b=ZJOL7Kuf55Kw+Y/OkhD6zKAVgwFCXs/CBNDa2/lUcgYMXwErBBNynYgZCun6h9ltztAwsePgc+v7qxWtvaUBR21EJboxkta0wqQxVwls3BVOFLe+mBWo7vgI3HDMy+C3G+xwsO1YzEhIt25g9+q8RRhpKQcXxlSv2euYwLiY9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023636; c=relaxed/simple;
	bh=EgoIqfAUxS5KW56KRCb+QeVsMshE/ZK3K8CR3CSbZk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3gcP6IH0/Rcj3vsazW/nOen1KH9UTC8zhxtWzhU5xcBn54w2MNeg4GdTVYEVCgKaHSzcrerjrM1R0fNl+GK0nu9y4ZUGIhKQoPzucXaWquLg3cm0c6kwuVtKxGmPj8sFggaH+iVLudPoAZWZ4q9EGWN3qaSsXuLlFECRToPbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPIykhwo; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPIykhwo"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so2607105e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023633; x=1790628433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtj7LYFb7b4TobSxy1rg3J32Q4+HIvbZ8g+Cdsc1860=;
        b=GPIykhwou2rwYtHYTUaTWWsDGz7HLpU4vVow8AWyA4IZ5kD1D2Za0Rho4mnfTXQraU
         yHHrg/Ox6cosoJOJ8oN0Vud/uKPfTZnvAmREJqRqm6OMS5fRPbw7nXZxdgKQx5kkjl/J
         YO2LqmnEBZ4pinmry2pUGC/DpnjOr5eB/CgdyYM3GCCiQy0Zo/JqIVkKecpsclFUmFuM
         zqA4nYHjDuDyV4t8/A6mxpremeOnGxT7CFJ7SVbm1J3GCASZfpKAgd3+FX59Sh6HdMxt
         0VyE54CrV4tw5oDl7Pmj2L+iIp90x4MVL9mBtgT9urIyuSvQB4gZbwOjRJ2NPSkV/pe1
         omEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023633; x=1790628433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtj7LYFb7b4TobSxy1rg3J32Q4+HIvbZ8g+Cdsc1860=;
        b=dRuieTntoUhCXrywi78yWHkKLm4La81xQ/veNJMtyVwMVpLAhW4iDyr551m3zWs+Qe
         Nuj+kLBVI7W6TMwXEO1Eg2icvK9WfuChzrFszpn6yHhStY2IWALGfGWo8W9BaUepwTuW
         cDO94Uh7Gd/deyhnPIsKyOu/1kqFotLA2foDoNZkW+XwARx0Zmyto/iB0+HexT+ke0z2
         F/v6WjgU2ryW/ggXWmCMKtwiLMfkBuThCPkH0znQQIMPrSiDgZ2SANKlojqUci8VAKUH
         HqZPk8l/SdekznI3Ij6otDaRL8kywqXMwSdeenzYgBGQiizkox8dc0AwTh3S85U+5l5l
         lysg==
X-Gm-Message-State: AFuF++mNiiiV4VCpR6SROuNWqcIFiT3UDA18rx3cdw6ZONdsjEAxjCJG
	p0q133gxJiM5iiqKoUwJ26b4e9z6zh+v6j9GvDnzBXINTOeW3UpNTkssNRVi3qAk
X-Gm-Gg: AYBFou2e5x9zcXCjj7ozvnHfxHgg70kFrL7lJ6LKd8lBe4eCZngHvylppLvTRD4Tw9g
	uhzuD/1rG5jh/1I5uGEWc6yhPLW9bbd/XyRAs52Yc38Npu5ni90s8htKbY7a9T3h42tGSfK+ldw
	i9eF2ezV2RMJHUygMQznPpUPjcXvFzis4/oxWeJYbueTAHzPyXOGadgYxeILYVH3L/n1ALT/FRb
	G47xvrrMOGvULmOUDb5wMjx37e1J39BAJSkpGXY1izBn9X4e1UyhIZ5rv8H5Ute1YPm8tmjhvT5
	tpBql4u0icjJk3dDgRcDEW2jUi8gkZYYfDxNvftTz+11SjqOI6W94axlNWaLfL6z/YrgWAYRis3
	wb+G/T/bhebcn0fJMeMWTkr5GnjoxQFYp54bBQloDpnvPOPk+0dOCW7i1m2M6e7SIh2eW00pxIM
	ulDNLilejTnNFUPiRCATiL+iZvVyDdPSXNw8QoBJaz9YwBodZsn3w7XMushvLfcqNgcpleW9bPP
	oOPtzJ6YAVMWd8VkQQ+e2w8iiWIwgewCfjbSuYsqZjCbxE0McV7mgk=
X-Received: by 2002:a05:600c:609b:b0:49c:f9b8:bae0 with SMTP id 5b1f17b1804b1-49fc7f2bdc8mr182304255e9.2.1790023632751;
        Mon, 21 Sep 2026 13:47:12 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8b97385sm19635135e9.2.2026.09.21.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:47:12 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Subject: [PATCH BlueZ v2] a2dp: Fix crash on NULL stream in transport_cb
Date: Mon, 21 Sep 2026 22:47:11 +0200
Message-ID: <20260921204711.211409-1-yaroslav.voytovych@gmail.com>
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

  bluetoothd[398112]: segfault at 10 ip 0000635d944b47e5 \
      sp 00007ffefcba28d0 error 4 in bluetoothd[367e5,635d944a3000+f3000]

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
v2: quoted code indented with spaces instead of tabs; the quoted fault
    lines re-wrapped to 75 columns. No change to the code.

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
