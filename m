Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EF1624DD
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418853; cv=none; b=sAC7rN8G6XTaFs7IWMyUQb7DxPS8EKm3YENW9yrGyPxg0u3fqqMZRsPnr/jIet7kJMqDolIiK1ab7a/sWFfOF4d5qs8gDmapflQD6A1Fsmhf39rFJnvBsNtD5od/DhIDtgvJ7hTiAmtTr1eShtLhbpT7sECBdEWxqiK5IZXrtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418853; c=relaxed/simple;
	bh=EXefXxN+ZQkc4t2Yw6517mad+etwz4d3ybfHc8PmVpQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TwDftNnm3oEYVKJRJ6csUsVl6U18Ou3LSXzd9vGQKKH0Ob4l6K+Fi43iDkzgVNs+FbnJpGSiWUqEohcDmVzkzbNUtCNj8QDfId4vePPPYxkthedw0NRb1k7SlqcXFAzBV8TZPEmJZuG1nT3hZTde7ptyburBzBb1grgxj/MaCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TGeAnOTQ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TGeAnOTQ"
Received: from github.com (hubbernetes-node-7c57316.ac4-iad.github.net [10.52.125.35])
	by smtp.github.com (Postfix) with ESMTPA id 0BB4D70034E
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749418851;
	bh=S2M1T6tYjksp08VHZB1ZGLjXyDnNmisQvCQXgiv0O0o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TGeAnOTQ8628FKaVYqBNC8KxSnlpT5ltqlZ+8PnLrsx3D9Q2hNxL9VbtCq9ZFrP6X
	 MbpCt3uVkGUa9zv0DoWlDx4GAEKc3QYZnEuMQf3TVdQGUki+QywuiPJXNv9lYBw6cQ
	 gX15TsUYpYujLobzSQPe0RECJ+9+8ynweJ+sd4cc=
Date: Sun, 08 Jun 2025 14:40:51 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969627/000000-88da25@github.com>
Subject: [bluez/bluez] 4ca745: bap: do not try QoS before links are updated &
 io ...
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

  Branch: refs/heads/969627
  Home:   https://github.com/bluez/bluez
  Commit: 4ca7454a5df1d01c7b097fc77c56c1f95f316677
      https://github.com/bluez/bluez/commit/4ca7454a5df1d01c7b097fc77c56c=
1f95f316677
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

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


  Commit: 679156e0b2a08ba2d05e8026998adfa330ad77bf
      https://github.com/bluez/bluez/commit/679156e0b2a08ba2d05e8026998ad=
fa330ad77bf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: detach ucast io on RELEASING and unlink streams

When RELEASING, ucast stream QoS becomes invalid and client stream
transport can no longer be acquired.  Client shall close the CIS when
ASE is RELEASING (BAP v1.0.2 =C2=A75.6.6).

As client, detach IO when RELEASING. Clear the stream links, as the QoS
is no longer valid. Even if caching config the ASE may be reused for
different purpose, and stream will anyway be reconfigured & re-linked as
needed.

Also clear the stream transport, as it's not in acquirable state, and
its configuration may change after this. This makes BAP Client to have
existing transports only for streams that are >=3D QOS.  (BAP Server is
not changed here.)


  Commit: e8d4cf42a411b6bd84d3f5fd096f57155de7f42f
      https://github.com/bluez/bluez/commit/e8d4cf42a411b6bd84d3f5fd096f5=
7155de7f42f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: add client ASE reuse and upper level stream locking

Change ucast client stream design so that:

* upper level locks streams to indicate which ones it is using
* unused streams are reused when upper level wants a new stream
* only locked streams are used for bidi CIS linking
* streams (still) correspond 1-to-1 to non-idle ASEs

This fixes some issues:

* bap_ucast_stream_new() could pick a stream upper level is already
  using if lpac & rpac match (can occur with multi-stream AC 6(ii) etc)
* Avoids assuming ASE enters idle state at end of stream life cycle.
  This is False for some devices like Sony headsets, which always cache
  codec config so RELEASING -> CONFIG always, never RELEASING -> IDLE,
  so ASE never go IDLE again.
* Allows reconfiguring an ASE with different codec in this case.
* Allows upper level to only QoS some of the streams.

Reconfiguring ASE in QOS/CONFIG state with different codec here results
to need_reconfig=3Dtrue state, where ASE and stream configs do not match,=

and upper level needs to do bt_bap_stream_config() to sync them.


  Commit: 40ff600532d153a2f01b7dab2ca30379b5f5fcae
      https://github.com/bluez/bluez/commit/40ff600532d153a2f01b7dab2ca30=
379b5f5fcae
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: lock streams when used

Indicate to lower layer when we are using the streams.

When setup is freed, make sure the corresponding stream is released
after unlocking.


  Commit: 371659f5ef9edfb509bc177e5391edd02c63c4c1
      https://github.com/bluez/bluez/commit/371659f5ef9edfb509bc177e5391e=
dd02c63c4c1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add ready callback for setup configuration

Operations like SetConfiguration need to wait until setup configuration
finishes. Abstract this to a setup_config() callback emitted on QoS
completion or failure, instead of hardcoding DBus reply.


  Commit: 3e3ee481f96f765c0f9828366579e3f4440bfc7b
      https://github.com/bluez/bluez/commit/3e3ee481f96f765c0f9828366579e=
3f4440bfc7b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  bap: support removing streams with ClearConfiguration()

Implement removing streams via ClearConfiguration().


  Commit: f566fa2261d4938c4adb7bd383355c680e7964e0
      https://github.com/bluez/bluez/commit/f566fa2261d4938c4adb7bd383355=
c680e7964e0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add callback at the end of ucast client select/config

Restructure pac_select() and add a callback that is called when all
setups reach QoS.


  Commit: 9d67a1638c40db3a8775ed075e7d2653bd19f9c0
      https://github.com/bluez/bluez/commit/9d67a1638c40db3a8775ed075e7d2=
653bd19f9c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

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


  Commit: e06f50230431cb256a845059fcd297dea95153ce
      https://github.com/bluez/bluez/commit/e06f50230431cb256a845059fcd29=
7dea95153ce
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: don't show error when releasing stream

When stream is released, just set transport to not playing and don't
show error about missing io.


  Commit: 88da2514b7d1628c66b025f5cbe783a65e9bfa3d
      https://github.com/bluez/bluez/commit/88da2514b7d1628c66b025f5cbe78=
3a65e9bfa3d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: delay QoS & IO creation if CIG is busy or setups configuring

Unicast Client IO creation / activation should be done synchronously for
whole adapter, as active CIG has to be removed before it can be
reconfigured (Core v6.0 Sec 4.5.14.3).  Some adapters support only one
active CIG.

Move related logic to bap_update_cig*() which does QoS and IO creation
as needed by current state.

If CIG is active or setups are being configured or closed, delay
transitions to QoS and IO recreation until that completes.  Also delay
activating CIG (=3D enabling CIS) until setups have finished readying or
closing.

Operations are delayed within the same CIG, with the exception that
streams with unassigned CIG delay every CIG. This is because such
streams are likely meant to go to some existing CIG, so we must wait
them to be configurable before asking kernel to assign IDs.

Fixes race conditions:

* setup starts readying while CIG is active
* CIG is activated while a setup is readying
* new stream creates IO before old stream IO is recreated

These result to kernel assigning new streams to a different CIG
(problematic on controllers that can do only one) or CIS ID conflicts.


Compare: https://github.com/bluez/bluez/compare/4ca7454a5df1%5E...88da251=
4b7d1

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
