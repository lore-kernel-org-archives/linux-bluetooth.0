Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A693E316E
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869562; cv=none; b=XmtifTHThGIJtJod4/trnHJVc+YrC2kWCtGo6cxv2SmyqY0g8vlG9QWp59yzvpAAwiOQ5RNJk2hOWSai/VnI5LU2BIXE/0VCywPugxLWxqtn1uBNT4omgFF9rSZPsQvPR/le1LVhR+yXb9+IjOwd2ifoblJorYANshxDP0j7q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869562; c=relaxed/simple;
	bh=yeREwaArJrrnCEovfUrnWpi3oa2FLeo4lun0bowzGlA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q2FsY+Jy/YM9Gv8i/80q5mQ2sGU6s1DSCFuPFYEfy93cxeFeGMhKwUyf6hJCRd1CvVuFUZoATcONcdwgrCU5FUjmk9rFwVNLqwSbiUQxfhwRhfS9u05fMOa1fhZjAz3/dzW+t72sxfTnjDiNm8yfMZCCMDT0mxrvTA3Y8f2VvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=RLEpYJUH; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="RLEpYJUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790869559;
	bh=upBMhZaT819x75i7O6BO3EYEu2Yq1szoi9p4Ol0Gy9s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RLEpYJUHibOKxRjnY5+XZVk0qew4wlub3d3u7k/uCTPApaqnBjn6ufuI3ugmJEM9D
	 iu7y4BqxMb7YYtFu3sM5Gs27KM2Ne+m3i49EE+YJ9YMWnQs83tob79Re4zq993qCj8
	 3G3FL1MPDtiaPwN4gDicsn9wZAzhCfyLFcMF9DiUjEleIYa/nRS6xxnsqoEiQ+ajzZ
	 W3nmfAjXOJrLioDeM/3ZkDm6cJGgUa9oBtB/D+9txThu8iuYa3wjxIgaRknZohk0mJ
	 2Osw1igqy0mK3wXwsBaBeZi3IAOtTii/hXFCYWS2NiEjCzMoGkEioQlAT2MtRNjnnr
	 njOT7UNEuWefA==
Received: from github.com (hubbernetes-node-bd2b122.va3-iad.github.net [10.48.148.41])
	by smtp.github.com (Postfix) with ESMTPA id 9121F281353
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 08:45:59 -0700 (PDT)
Date: Thu, 01 Oct 2026 08:45:59 -0700
From: Eduardo de Souza Alves <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177732/000000-814917@github.com>
Subject: [bluez/bluez] 7d263c: a2dp: Fix UAF after rejected SetConfiguration
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

  Branch: refs/heads/1177732
  Home:   https://github.com/bluez/bluez
  Commit: 7d263ccc3d71d3e962b064606efab97f88863f49
      https://github.com/bluez/bluez/commit/7d263ccc3d71d3e962b064606efab97f88863f49
  Author: Eduardo Alves <eduardoalves8006@gmail.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

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


  Commit: 81491780ae3af461d199e85904d27d3b3b5aa94e
      https://github.com/bluez/bluez/commit/81491780ae3af461d199e85904d27d3b3b5aa94e
  Author: Eduardo Alves <eduardoalves8006@gmail.com>
  Date:   2026-10-01 (Thu, 01 Oct 2026)

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

Fix it by rejecting the pending Set Configuration in channel_free()
while the session is still valid, which also frees the pending
avdtp_stream and the a2dp_stream, both previously leaked together with
the session reference held by the latter, and by making auto_config()
bail out when setup->session is NULL, releasing its setup reference.
setconf_cb is cleared once called so it cannot be called twice.

channel_free() also clears the endpoint configuration, which sends
ClearConfiguration and removes the MediaTransport created for the
request. Otherwise a late successful reply leaves the transport
registered and the next connection fails with "Resource temporarily
unavailable". Since the transport may now be freed while the request
is pending, endpoint_remove_transport() resets the transport of the
pending requests so a late error reply does not free it twice.

The crash can be reproduced with test-functional using two VMs over
btvirt, where the A2DP Sink endpoint delays or never sends its
SetConfiguration reply and the A2DP Source disconnects meanwhile.

Assisted-by: Claude:claude-opus-5-5


Compare: https://github.com/bluez/bluez/compare/7d263ccc3d71%5E...81491780ae3a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
