Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B21DBB2E
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375706; cv=none; b=gj8lYfN+jOASNN8FBNLlwlWTnCvL95GB1DRTbMuKaD/fQjhbE9BrxmrSBzOAIPtZgrQ6Ow/3CU2Xwj4rVV6o0ZD1DnSf3kYosi6FacIiFjkPd/u+Z1+U8js/gk8vPHzgPZzZo4xqfy9XVeF9YZvEF6/2glPHvfyz1r5vUxoUelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375706; c=relaxed/simple;
	bh=hMHxKJhT8OfhQfFslOfr2gqj8jinciNWcX20RzSKgu4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TbKccGch+Gn+IeNA5IRzX9bbc4bjIMzv7OJdb5VjmrphK2vp0E+NP4owlQpxOXyUMh8V7hVvBjWT5jez2/UYHFv/gxp+1UFFWPjX0ezCKRfQFvRF7TemEYWLAvrQJ7NTaiUKLO7tmi8WV5gHVsx3QScOXhvIhLrvsC2x3AmJh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Un2LgNjJ; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Un2LgNjJ"
Received: from github.com (hubbernetes-node-4258e3c.ash1-iad.github.net [10.56.200.22])
	by smtp.github.com (Postfix) with ESMTPA id 76BD86003BD
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746375703;
	bh=A7bU6N4znaxsgccQYRMHQx5tf3vGuh7Vw8pHCHjRujc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Un2LgNjJaI5d4FSkcv/N5wvB39f9FgUfMPw5UevDWBh8JdEXHGxcm8QHDt/Zz6c4a
	 KVbsEbETptrte8oBOBJ5laD4pIdCtdhfoOcKkxkYeIW52ZMPdMsHiMzRWIBFFWwB/H
	 0BQNr1iTdS2H2oRC6l3YD/LhvG7Q243M5DuZd4Rg=
Date: Sun, 04 May 2025 09:21:43 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959452/000000-df2813@github.com>
Subject: [bluez/bluez] 0d49b7: org.bluez.MediaEndpoint: removing BAP streams
 with...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/959452
  Home:   https://github.com/bluez/bluez
  Commit: 0d49b7b52e337aa7c321f3be54be3d1a624c1910
      https://github.com/bluez/bluez/commit/0d49b7b52e337aa7c321f3be54be3=
d1a624c1910
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.


  Commit: 1a2bba8fd9ba5b4eb04429f3ff0f27eef6bcdd02
      https://github.com/bluez/bluez/commit/1a2bba8fd9ba5b4eb04429f3ff0f2=
7eef6bcdd02
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: add client role Reconfigure

Add a simple way for the sound server to reconfigure a BAP unicast
endpoint, by calling org.bluez.MediaEndpoint.Reconfigure().

This shall destroy all streams of the endpoint, and restart the
SelectProperties() configuration flow from the beginning.

Since it may be necessary to reconfigure multiple endpoints at once to
correctly make bidirectional CIS, add Defer argument to just mark eps
for configuration.

In future, org.bluez.MediaEndpoint.SetConfiguration() could be changed
to handle unicast in the same way as broadcast: only create streams.
This allows sound server to have full control over stream configuration
itself, and not rely on bt_bap_select().


  Commit: 31d5af8edb59a17d063ab7aaad4f333201a39ae3
      https://github.com/bluez/bluez/commit/31d5af8edb59a17d063ab7aaad4f3=
33201a39ae3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: bap_abort_stream_req() should cancel also current req

After bap_abort_stream_req() no req callbacks for stream shall be
called, so it has to fail also the currently in-flight request.


  Commit: ba48521f82aea25c7435ce6efa0f996c2122828b
      https://github.com/bluez/bluez/commit/ba48521f82aea25c7435ce6efa0f9=
96c2122828b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: fix ucast client ASE usage

The ucast client stream design has issues:

* Assuming lpac & rpac pair uniquely identifies a stream.  False for
  AC6(i) and other multi-stream configs.

* No way for ASE in Config state be configured with different codec.

* Assuming ASE enters idle state at end of stream life cycle.  False for
  some devices like Sony headsets, which always cache codec config so
  RELEASING -> CONFIG always, never RELEASING -> IDLE, so ASE never go
  IDLE again.

* Assuming Unicast Client upper layer always creates streams for all
  non-idle ASEs.  False, as when switching between duplex & sink-only
  modes, only some streams shall be used regardless of whether Server is
  caching config or not.

In practice, these currently prevent reconfiguring ASEs on devices which
cache codec config, and multi-stream configs work only accidentally (and
fail if server does Config codec itself, like some devices do).

Minimally fixed design for Unicast Client streams:

Streams correspond 1-to-1 to ASEs in non-IDLE state.

Track explicitly which streams upper level is using:

- bt_bap_stream_new() always makes new stream with client_active=3Dtrue
- bt_bap_stream_discard() releases stream and marks client_active=3Dfalse=


Streams (ASEs) with no active client may be reused when upper level asks
for a new stream.

Streams with no active client may have their lpac changed.  The
need_reconfig state is a bit ugly, but not really avoidable.

Streams with no active client shall be ignored when constructing
bidirectional CIS pairs.

Streams shall clear transport and detach io on RELEASING. (cf BAP v1.0.2
=C2=A75.6.6). Also unlink them since QoS is gone at that point.

Streams shall have transport only for >=3D QOS state.  (Server streams
work differently, which makes sense since upper level cannot acquire
them before they are pending.)


  Commit: 108fca0463ffe61e2722aa8230409ffd67d99ffc
      https://github.com/bluez/bluez/commit/108fca0463ffe61e2722aa8230409=
ffd67d99ffc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: discard stream when no longer in use

Indicate to lower layer that the stream will not be used any more.


  Commit: 526a8a3bbd2c7975f97419a0c125f40d2d50816b
      https://github.com/bluez/bluez/commit/526a8a3bbd2c7975f97419a0c125f=
40d2d50816b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: do not try QoS before links are updated & io created

In setup config, QoS must be done after corresponding bap_state
callback, because stream links are updated only at that point.  If the
ASE was in CONFIG state before reconfiguration, this gets done in wrong
order.

Track explicitly that bap_state() is done after bt_bap_stream_config(),
before proceeding to QoS.


  Commit: 06fad072cc121feb3d225e09ff3c91a115ffe52d
      https://github.com/bluez/bluez/commit/06fad072cc121feb3d225e09ff3c9=
1a115ffe52d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add ready callback for setup configuration

Operations like SetConfiguration need to wait until setup configuration
finishes. Abstract this to a setup_config() callback emitted on QoS
completion or failure, instead of hardcoding DBus reply.


  Commit: 0d8fa7cda8b46df482fb09dc792f25ab5a89cf9d
      https://github.com/bluez/bluez/commit/0d8fa7cda8b46df482fb09dc792f2=
5ab5a89cf9d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  bap: support removing streams with ClearConfiguration()

Implement removing streams via ClearConfiguration().


  Commit: 5390d89c2ff888e07e92664c3be843ca16c2232f
      https://github.com/bluez/bluez/commit/5390d89c2ff888e07e92664c3be84=
3ca16c2232f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add callback at the end of ucast client select/config

Restructure pac_select() and add a callback that is called when all
setups reach QoS.


  Commit: 03ca2dc546f8d5114b7ab71c64802e3834c955ab
      https://github.com/bluez/bluez/commit/03ca2dc546f8d5114b7ab71c64802=
e3834c955ab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: implement Reconfigure()

Add Reconfigure() on a BAP unicast endpoint, which triggers its
reconfiguration or marks it for reconfiguration.

First, all associated streams are closed. After that, endpoints marked
for reconfiguration are reconfigured using the same flow as in the
initial configuration.


  Commit: df2813147498eb7dc7ed82978c6e16a8421c1337
      https://github.com/bluez/bluez/commit/df2813147498eb7dc7ed82978c6e1=
6a8421c1337
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-04 (Sun, 04 May 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: delay recreating IO after ongoing configuration

Delay creating IO if setup reconfiguration is ongoing.

TODO: this is not fully right, also new stream QoS should be delayed if
CIG is active, so that it doesn't get assigned into a new CIG which
controllers may not support


Compare: https://github.com/bluez/bluez/compare/0d49b7b52e33%5E...df28131=
47498

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
