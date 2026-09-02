Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C33603E0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369360; cv=none; b=SduarUV/mHK/W8BsfCqwviOKlaNzyE23acaHBBuenhjYbPbATZdIn2Rg4/7yWFrueUM8dxmTajFDxN28MpT0qzG0tH5USZPs+dqK5o2V3VSyJUpAQV1EbGwgHJ8krt6y6fIo/jDi+BkpxTUV2Rph3bZkFW8cT0YpROkzNmaPnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369360; c=relaxed/simple;
	bh=OtKZ/nkcK14nbzb9tInWKscP/4L77iH2p4IUkIvJDZA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AoXGLgP1pjy6gnKcCk44YaGU4AaevKCRz9t+yTr1AjqtPAhrgwiSsI3ajx9ydc9hRTGrH9L1DIquRIxQi1D3JSQ6BaiBVKuibznJiluw9cPvJCGD4joxF34CqeCuftKkMjuaz2FyWa4TL9m5RYzyvaRjd9fD4wvfsF1e60PtEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RH62cjMg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RH62cjMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788369357;
	bh=Y9ESXi1r27fcpOPiOPZmmWlvg9z/nbe84JbJ/onKOk8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RH62cjMgHs+eh41hPn6yX7ijAKw+yv3r8F4X8D5Bauuksmo2pCQhJSugZePkx7OUi
	 CdI7nj1sLogt+dJbLuzELVjZw+5J5iUJeqfge7qwTxGdK6rY8sp0nKRmtakoOaoIKR
	 Om0/BUKSZuEhSDU03/lmZ9VzlfnJUgHH715zO+So=
Received: from github.com (hubbernetes-node-60413e9.ash1-iad.github.net [10.56.184.34])
	by smtp.github.com (Postfix) with ESMTPA id C16406015F6
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:15:57 -0700 (PDT)
Date: Wed, 02 Sep 2026 10:15:57 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3a2d54-ed3d4c@github.com>
Subject: [bluez/bluez] a909d5: shared/bap: Fix use-after-free in bt_bap_detach
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a909d5d303cb1c656c2e85150070796317f0cc8c
      https://github.com/bluez/bluez/commit/a909d5d303cb1c656c2e851500707=
96317f0cc8c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix use-after-free in bt_bap_detach

bt_bap_detach() invoked the pending request's completion callback via
bap_req_detach(bap->req) before clearing bap->req. Since the completion
callback (req->func) can trigger synchronous cleanup that re-enters
bt_bap_stream_cancel() for the same stream, and bt_bap_stream_cancel()
frees bap->req whenever it still matches the request being canceled,
the request could be freed while bap_req_complete() was still executing
on it, causing bap_req_complete() to dereference the now-freed request
once the callback returned.

Clear bap->req before invoking the completion callback, matching the
pattern already used by bap_abort_stream_req(), the ASE IDLE state
handler and bap_cp_notify(), so a reentrant cancel no longer finds a
stale bap->req to free.

Assisted-by: Claude:claude-sonnet-5


  Commit: a03665b6dd20e3b62501867c0dcc7ca6f74d7ae9
      https://github.com/bluez/bluez/commit/a03665b6dd20e3b62501867c0dcc7=
ca6f74d7ae9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix use-after-free when replacing a linked transport's owner=


linked_transport_set_owner() unconditionally overwrote a linked
transport's owner pointer. If that transport already had a different
owner assigned (e.g. its own Acquire request was still pending when the
paired transport's owner was set), the previous media_owner was
orphaned: its D-Bus disconnect watch stayed registered and its
->transport back-pointer kept pointing at the transport. Once the
transport was later destroyed, the still-registered watch would
eventually fire media_owner_exit() and dereference the freed transport.

Tear down any pre-existing, different owner via
media_transport_remove_owner() before assigning the new one, so its
pending request is replied to, its watch is removed and the owner is
freed instead of leaked. Since media_transport_remove_owner() itself
recurses into linked_transport_remove_owner() for linked streams, also
guard linked_transport_remove_owner() so it only clears a transport's
owner when it still matches the owner being removed, preventing it
from clobbering an owner that was already reassigned during that
recursion.

Assisted-by: Claude:claude-sonnet-5


  Commit: a8d453d26ea4d513d5edf68d30287bcbfc411a60
      https://github.com/bluez/bluez/commit/a8d453d26ea4d513d5edf68d30287=
bcbfc411a60
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Add org.bluez.ChannelSounding1.rst to EXTRA_DIST

The Channel Sounding documentation added doc/org.bluez.ChannelSounding1.5=

to man_MANS and manual_pages, but never added the doc/org.bluez.*.rst
source it is generated from to EXTRA_DIST.

As a result the .rst is missing from the distribution tarball, and
building the man page from an unpacked tarball fails.

Add it alongside the other doc/org.bluez.*.rst entries.


  Commit: cd3afe6bdf355f36b5ce00db14f832bd0880c09c
      https://github.com/bluez/bluez/commit/cd3afe6bdf355f36b5ce00db14f83=
2bd0880c09c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Ranging1.rst

  Log Message:
  -----------
  doc: Add org.bluez.Ranging1 documentation

Document org.bluez.Ranging1 interface, which
exposes the Distance estimate computed by an
external ranging provider registered via
RangingProviderManager.


  Commit: 0654aa95ce0849edaf41cffedd6ca309df1ff951
      https://github.com/bluez/bluez/commit/0654aa95ce0849edaf41cffedd6ca=
309df1ff951
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.RangingProvider1.rst

  Log Message:
  -----------
  doc: Add org.bluez.RangingProvider1 documentation

Document org.bluez.RangingProvider1 interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.


  Commit: da77259717e4f5f2ce0bf3b5693871130c313015
      https://github.com/bluez/bluez/commit/da77259717e4f5f2ce0bf3b569387=
1130c313015
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.RangingProviderManager1.rst

  Log Message:
  -----------
  doc: Add org.bluez.RangingProviderManager1 documentation

Document org.bluez.RangingProviderManager1 interface,
used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterRangingProvider/UnregisterRangingProvider


  Commit: 8b294de8067370055ca4fabedb49b8cdcd926da0
      https://github.com/bluez/bluez/commit/8b294de8067370055ca4fabedb49b=
8cdcd926da0
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: Modify bluetoothctl-cs documentation

Add documentation for the register_provider and
unregister_provider cs menu options.


  Commit: 03d93165d9e180e7bf7e87892b04c7e7d16f8d94
      https://github.com/bluez/bluez/commit/03d93165d9e180e7bf7e87892b04c=
7e7d16f8d94
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.am
    M src/adapter.c
    A src/ranging.c
    A src/ranging.h

  Log Message:
  -----------
  src: Add Ranging provider D-Bus API

Introduce org.bluez.Ranging1 and
org.bluez.RangingProvider1/RangingProviderManager1
D-Bus interfaces.

External providers can register a root path
via RegisterRangingProvider and expose per-device
RangingProvider objects; updates to their Distance
property are mirrored onto exported Ranging objects,
emitting a PropertiesChanged signal.

A provider invalidating Distance leaves the last estimate in place
rather than reporting 0 mm, and objects exposed outside the
registered root path are rejected on an exact path boundary so that
a provider rooted at /org/example cannot claim /org/example_other.

The Ranging provider manager is wired into the adapter lifecycle,
created on adapter setup and destroyed on adapter removal. Removing
a device also drops any Ranging interface exported for it, so the
device object path does not linger on the bus with only Ranging
left on it.


  Commit: 71cd7d370f7cd61d9f6ddfc048e8da495ec881ab
      https://github.com/bluez/bluez/commit/71cd7d370f7cd61d9f6ddfc048e8d=
a495ec881ab
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M client/cs.c
    M client/cs.h
    M client/main.c

  Log Message:
  -----------
  client: Add ranging distance display support to bluetoothctl

Track org.bluez.Ranging1 proxies and append/remove them
on InterfacesAdded/InterfacesRemoved.

Print the Distance property on PropertiesChanged, and show it
under the info option alongside the Battery Percentage and the
newly added CS Session Active property.

Add register_provider and unregister_provider options as a
reference implementation. The estimate is derived only from Mode 1
and Mode 3 RTT samples; procedures without any such step report no
distance rather than a made up one.

The RangingProviderManager1 of the default controller is resolved
from a tracked proxy list, so it is picked up regardless of the
order the adapter and manager proxies arrive in and follows a later
"select".


  Commit: ed3d4c3f91b2a1a73ff8b8ffc6a1e83d34488dfd
      https://github.com/bluez/bluez/commit/ed3d4c3f91b2a1a73ff8b8ffc6a1e=
83d34488dfd
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M Makefile.tools
    A test/example-ranging-provider

  Log Message:
  -----------
  test: Add Python Ranging Provider example

This patch introduces test/example-ranging-provider which implements
a simple D-Bus client application for the ranging profile.

It is a wiring skeleton rather than a ranging implementation: it
registers as a provider, exports a RangingProvider object per device
seen on ChannelSounding1 and reports a fixed placeholder distance.


Compare: https://github.com/bluez/bluez/compare/3a2d543c4c21...ed3d4c3f91=
b2

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
