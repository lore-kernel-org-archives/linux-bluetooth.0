Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0239CD0C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478466; cv=none; b=qhF1PKbFTTWa80qoqTTog8X0bqG/FE0qFGwCKcsBKNo2d5XaI2Ce+1sc5vxsA51Qsr5VbWQDsZReuNqqDfiN5AKnNrfXIZ9vvhlrtl+Za94cbOgjbXPjZ1/DLhAMepem/h32cuoICU/SiOlodT47U5YHj9MfV2FxfnyWKmaYk7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478466; c=relaxed/simple;
	bh=bEA8Nm53Swi/E9n4RsY3dj0wuxrJQAnmDrSAnZz3pYc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HxYntN9UrwOjdtCccNoebNuPy6cCD5vFcngsQY9WCFBRas4YaH1Cr8hbTfTjDQ+Vo2lmSYXIsE3OnAikqRUd1+0WAqP0xFGpAJGIOYJfWlrw2+jtiRbpEuY+pDh3brbEzs3Hh/m3yQC3Z7gYl5MJiHwjs99OLG/5cAfjP9+vPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=R5ogntfM; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="R5ogntfM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791478463;
	bh=VfUFqiylKDH9GlvZOINkBmy3WSpK/6qTGWKb/gHPL9M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R5ogntfMNz2PttlZH57jSC+itp6Fg5t3u5TQMtETcSqlW+JYf8vgXL20iOXRq+0N0
	 i9IJFiBAYqd9udyMx9gK+duDN9NOcUiYppR68VCqyW/dNSJ2wPsMl8X+UqNBGpa/Nj
	 E2ibu8AiH+Xt3B9HY3sLR7YzMNw35aBbWwqPLZnMjD/4fKmNC1iY/cUGlN/+phMK7Z
	 Kd1XKK97Ofld7zKv6BFOpJa0U2e5+ebuMOzqfXzLax35tKRhcuxh8CCsg0AwFkSZ72
	 QT6aWH/GSkz7PTzKK91psUMGFWUKdV8Rsj+26FpGTFh6TuB1D90ro4fpKh2wE2vwnz
	 JnSbVbZqmvUgg==
Received: from github.com (hubbernetes-node-4554f61.ash1-iad.github.net [10.56.158.26])
	by smtp.github.com (Postfix) with ESMTPA id 811D53610DC
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:54:23 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:54:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d84171-866b0b@github.com>
Subject: [bluez/bluez] ef5413: a2dp: Fix UAF after rejected SetConfiguration
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ef54133c69e9e2c50ebae1212ee400ed8a6dc34c
      https://github.com/bluez/bluez/commit/ef54133c69e9e2c50ebae1212ee400ed8a6dc34c
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


  Commit: 79aedd33f8faed29c9e53d6bd245f3c2a552d5d4
      https://github.com/bluez/bluez/commit/79aedd33f8faed29c9e53d6bd245f3c2a552d5d4
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


  Commit: ab5df7ba30190636b85f23c5a0798e7707748047
      https://github.com/bluez/bluez/commit/ab5df7ba30190636b85f23c5a0798e7707748047
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


  Commit: 1baa0a2aef3b4f931c59885f15788e10bc76b2c9
      https://github.com/bluez/bluez/commit/1baa0a2aef3b4f931c59885f15788e10bc76b2c9
  Author: Hui Peng <benquike@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Prevent integer underflow in string attribute length calculation

In lib/bluetooth/sdp.c, attribute string length calculations subtract
sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
underflows in 32-bit integer arithmetic to a negative/huge length value,
passing invalid sizes to memory allocation and length extraction
functions.

Add explicit lower-bound guards checking d->unitSize > (int)sizeof(uint8_t)
to ensure that when d->unitSize <= sizeof(uint8_t), the calculated string
length is safely set to 0.

Assisted-by: Antigravity


  Commit: ae23df052290d4add0981091515a33b229e223cc
      https://github.com/bluez/bluez/commit/ae23df052290d4add0981091515a33b229e223cc
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M src/shared/mgmt.c

  Log Message:
  -----------
  shared/mgmt: Fix notify leak in mgmt_unregister()

mgmt_unregister() called from a notification callback takes the entry
off notify_list and marks it removed instead of freeing it.
process_notify() frees the removed entries still on notify_list once
the walk is done, so this one is never freed and its destroy callback
never runs.

If the callback unregisters the next entry rather than its own, this
is also a use-after-free: queue_foreach() has already saved that
entry's queue node, and queue_remove_if() frees it. That is the crash
fixed for mgmt_unregister_index() by commit 872729a91632
("shared/mgmt: Fix crash when removing index"), still present in
mgmt_unregister().

Leave the entry on the list while notifying, as mgmt_unregister_index()
and mgmt_unregister_all() do, and let process_notify() free it.
Unregistering an entry that is already marked removed now returns
false, since it is no longer registered; for an entry marked by
mgmt_unregister_index() or mgmt_unregister_all(), mgmt_unregister()
used to return true, take it off the list and leak it. No caller
checks the return value.

mgmt-tester, mesh-tester and userchan-tester unregister from event
callbacks, and under ASan each reports these entries as leaked, for
example userchan-tester:

  Direct leak of 80 byte(s) in 2 object(s) allocated from:
    #0 in malloc
    #1 in util_malloc src/shared/util.c:46
    #2 in mgmt_register src/shared/mgmt.c:974
    #3 in test_open_success tools/userchan-tester.c:275

Fixes: 872729a91632 ("shared/mgmt: Fix crash when removing index")


  Commit: 6f5eeb402d3b1d448acd4e448a682409cc1a9a2a
      https://github.com/bluez/bluez/commit/6f5eeb402d3b1d448acd4e448a682409cc1a9a2a
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M unit/test-mgmt.c

  Log Message:
  -----------
  unit/test-mgmt: Test unregistering from callbacks

Add /mgmt/unregister/3 to /5, where a notification callback
unregisters its own entry, the next entry, or another entry followed
by mgmt_unregister_all(). The unregistered entry must not be notified
again, its destroy callback must not run inside the notification and
must have run once by the next idle callback, and unregistering it
again must fail.

Add /mgmt/unregister/6, which unregisters outside a notification: the
entry is destroyed at once and unregistering it again fails.

Without the previous patch, /4 faults under ASan (heap-use-after-free
in queue_foreach()), /3 never destroys the entry, and /5 gets true for
an entry already marked removed.


  Commit: 866b0b8b162f52fa8a5452d2017093806ba1b570
      https://github.com/bluez/bluez/commit/866b0b8b162f52fa8a5452d2017093806ba1b570
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M unit/test-mgmt.c

  Log Message:
  -----------
  unit/test-mgmt: Convert to use tester

Teardown is deferred to an idle callback so the mgmt instance is not
freed from within its own callbacks, and the unregister test checks
that ran after the main loop returned now run from that teardown.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/d84171e6cd68...866b0b8b162f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
