Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4992848BE
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777757; cv=none; b=EdanNNX6pUVAJbviGuaxH/PRwGjfUb6rp9F+/h3BhPD9Ww1Ux0P4dD3GmZaCT/SsSLfLM8ArqSMLcGqMb7vSsMUtRBLENrjCVoQ3a/MjLBaFo4rygf88pPeVhaCGAc3hCxGSFrfROool8I3J3idzcsOpbi9TfYoJ8r3Z50RdbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777757; c=relaxed/simple;
	bh=eDOvG/o3KcxvRl18HC+5/tOsSaEddzo8taiayMRF6yk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U+pT1y+npXKww9zdFJhkIcdhSGdB0kFKQPFyKVSBSAHeRpozhPfVkB9wfYKl1PbN8wP3kGdRgFOsrHVVwbWI0HBPJTl6pRdMSEUvJhrP58Ftgl6GsMFE0S6KXXoJNGlvloy9FgM0v5ne9s97GQ2DK7xrb4dJFpa7sRwynzGJIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SkA6nnea; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SkA6nnea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789777754;
	bh=wNX3qaFj4j7OU/SPIEc9+NOxu0zEDz0tf5UZ+61Bd/M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SkA6nnea5JkPKmz+6CPOQifIPgnDn8fqmFEg97sHzDhW3Zo8okFKeiMihtnDWteJ1
	 RTm3M4oWNIhv15yL+XcSV3aNq9lnmEyqA9ITLi84GWU/+J8KK6hT/wXKo+oNLua2mH
	 ANqVc/XqGA/n+nEu87uy/Ira07QNODziCo6kbfQw=
Received: from github.com (hubbernetes-node-a8826d9.ash1-iad.github.net [10.56.172.30])
	by smtp.github.com (Postfix) with ESMTPA id 98828520750
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:29:14 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:29:14 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169068/000000-a53f4a@github.com>
Subject: [bluez/bluez] a53f4a: bap: Fix use-after-free of device referenced by
 se...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1169068
  Home:   https://github.com/bluez/bluez
  Commit: a53f4a113e82bceb82f09dad1189030ad725165d
      https://github.com/bluez/bluez/commit/a53f4a113e82bceb82f09dad1189030ad725165d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-19 (Sat, 19 Sep 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use-after-free of device referenced by session

bap_attached() creates bap_data that are not bound to btd_service, and
can outlive the device (eg if ATT POLLHUP -> bap_detached is late).
This then crashes when accessing bap_data::device later.

Fix by having bap_data hold btd_device_ref(). This is similar to what
avdtp.c etc. do.

Remove no-op assign to ep->data->device in ep_register_bcast() +
bap_bcast_probe() -- these just assign the same device pointer.

Log:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7d6513de0208
READ of size 8 at 0x7d6513de0208 thread T0
    #0 0x5594209b7e9b in device_get_adapter src/device.c:6917
    #1 0x55942086020e in find_cig_session profiles/audio/bap.c:2500
    #2 0x559420a3f070 in queue_find src/shared/queue.c:230
    #3 0x559420866cd3 in find_cig_enumerate profiles/audio/bap.c:2539
    #4 0x559420866cd3 in bap_update_cigs_cb profiles/audio/bap.c:2688
    #5 0x7ff515a46b9a
    #6 0x7ff515a481d6
    #7 0x7ff515a48576 in g_main_loop_run
    #8 0x559420b9af48 in mainloop_run src/shared/mainloop-glib.c:65
    #9 0x559420b9b87a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #10 0x5594207192ba in main src/main.c:1713

0x7d6513de0208 is located 392 bytes inside of 752-byte region [0x7d6513de0080,0x7d6513de0370)
freed by thread T0 here:
    #0 0x7ff515d2d3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x559420a29a39 in remove_interface gdbus/object.c:742

previously allocated by thread T0 here:
    #0 0x7ff515d2e40f in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:74
    #1 0x5594209cd302 in device_new src/device.c:5008

Assisted-by: opencode:qwen3.8-flash-next



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
