Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617E4A2E2E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415604; cv=none; b=KP/CcN1BrilFYg3bp7ZGAtQpseeT6vpSKfYy/vgnZssIRlV4PNi1sLfdsEoX1QUGm5n5d1+cRgLbicB/iMbI2Qr59/JnV+fenMYI/EETjb0ZNljrdft3M2pshZ6+0wxSjtdLx2fWR0ECZQtj2vlBpGsL8zJgQoXzrCrh5EFEgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415604; c=relaxed/simple;
	bh=rr6lR4DCvUj5rAX2Q3Xs7HNKLfdcq6XCONyQfVTriWw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gm0fdi07AZQQPp3odgUTZvjVdHpc2zwyXw6WDvDtZjIPOc284ORGNG5Xp8fJpUUuhKvFW7kcnhRLKWnaNgYrTKTov3Vt4KKUvL5EjmeNTtaMCY1QtYfIa+C1ecpWhSIko0sQPZjxi00qOwRlWPrUk11ViJsbsWdLGLN02fmqosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=FMSNhee6; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="FMSNhee6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791415600;
	bh=4DhNqpyvzbTSHetSbwjX1NAX9Np1c5LuzyG8qfAnUOQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FMSNhee6wpJtvbltWPVOXRlMJbU4YuTgLetBIgmtyjr2xMBStOB1N6f3wZkHepJ2K
	 3UCs0crxzPz7pH5jWI1ti3mK9tIruPT9pssEyG4tmk2Qk3RU6QwGegUJSvKkhRItsu
	 Rn1/4tak4CNt3Ogsp8hgvVcAwf9reLA8NWeJfm4gwbxlgCstXaYK3IEtgDOlT4U5Pe
	 pJszUNijyGc/M7iv3YUGft08D80TD7OpaFThT/c8MrY6D1QyFjhDixToN33tdR7mkF
	 5y0FrX84dbbvOWMP+drmssWStRaF4JLzpPL88AyhraPr8ntJZtKf0tNBP7BqeDbdFP
	 RUIcodkOQv+HA==
Received: from github.com (hubbernetes-node-43e6f55.ac4-iad.github.net [10.52.202.80])
	by smtp.github.com (Postfix) with ESMTPA id E2FC54009C
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 16:26:40 -0700 (PDT)
Date: Wed, 07 Oct 2026 16:26:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181105/000000-1f2db3@github.com>
Subject: [bluez/bluez] fab688: a2dp: Fix UAF after rejected SetConfiguration
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

  Branch: refs/heads/1181105
  Home:   https://github.com/bluez/bluez
  Commit: fab68859150e4f12c30c8353f80f42c52fb75620
      https://github.com/bluez/bluez/commit/fab68859150e4f12c30c8353f80f42c52fb75620
  Author: Eduardo Alves <eduardoalves8006@gmail.com>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix UAF after rejected SetConfiguration

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


  Commit: f398a94c46f6e23680d04a0565e316c57b39cd1e
      https://github.com/bluez/bluez/commit/f398a94c46f6e23680d04a0565e316c57b39cd1e
  Author: Eduardo Alves <eduardoalves8006@gmail.com>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/media.c

  Log Message:
  -----------
  a2dp: Fix crash on NULL session in auto_config

If the AVDTP channel is disconnected while bluetoothd is still waiting
for the MediaEndpoint1 to reply to SetConfiguration, channel_free()
sets setup->session to NULL but the setup stays alive since the pending
endpoint request holds a reference to it. Once the endpoint replies, or
the call times out and the request is canceled, endpoint_setconf_cb()
calls auto_config() which passes the NULL session to avdtp_get_device()
and then dereferences the resulting NULL device:

  bluetoothd[820]: profiles/audio/media.c:endpoint_reply() Endpoint
    replied with an error: org.freedesktop.DBus.Error.NoReply
  kernel: bluetoothd[820]: segfault at 1a0 ip 00005633dd741323
    sp 00007ffe51923650 error 4 in bluetoothd

  #0  auto_config (data=0x56340361a120) at profiles/audio/a2dp.c:723
  #1  endpoint_setconf_cb (setup=...) at profiles/audio/a2dp.c:768
  #2  media_endpoint_cancel (request=...) at profiles/audio/media.c:208
  #3  media_endpoint_cancel_all () at profiles/audio/media.c:216
  #4  clear_endpoint () at profiles/audio/media.c:379
  #5  endpoint_reply (user_data=...) at profiles/audio/media.c:407

  (gdb) p *setup
  $1 = {chan = 0x0, session = 0x0, ...,
        setconf_cb = 0x5633dd74c780 <setconf_cb>, ..., ref = 2}

Commit 14750a2e48f4 ("audio/a2dp: Fix Access session device only when
its valid") fixed the same crash, but commit 77932f2dac1a
("profiles/audio: add nullity checks") moved avdtp_get_device() back
ahead of the checks. Just reordering is not enough though: the
a2dp_stream is still on sep->streams, so the aborted check passes and
setconf_cb() would then be called with a NULL session as well.

Fix it by making finalize_all() abort the pending Set Configuration
while the session is still valid: clearing the endpoint configuration
sends ClearConfiguration, removes the MediaTransport created for the
request and cancels the request, so auto_config() rejects the
configuration and frees the pending avdtp_stream and a2dp_stream, both
previously leaked together with the session reference held by the
latter. If no request is pending, the configuration is rejected
directly. auto_config() bails out when setup->session is NULL, as it
may still run from idle, and setconf_cb is cleared once called so it
cannot be called twice.

Removing a transport now cancels the endpoint requests pending for it,
so a late reply is ignored instead of leaving the transport registered,
which made the next connection fail with "Resource temporarily
unavailable".

Assisted-by: Claude:claude-opus-5-5


  Commit: 1f2db341a50abb90f70ceccfa553071833049e87
      https://github.com/bluez/bluez/commit/1f2db341a50abb90f70ceccfa553071833049e87
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M doc/functional-a2dp.rst
    M test/functional/test_a2dp.py

  Log Message:
  -----------
  test: Cover A2DP disconnection during SetConfiguration

Add test_a2dp_disconnect_during_setconf, where the source disconnects
while the sink endpoint has not replied to SetConfiguration yet, and
the late reply, either accepting or rejecting, must be ignored and the
stream configured again on reconnection.

Assisted-by: Claude:claude-opus-5-5


Compare: https://github.com/bluez/bluez/compare/fab68859150e%5E...1f2db341a50a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
