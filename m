Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65815489871
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065474; cv=none; b=FF2vTVgI16r7nLT/R0PX1R1uCn8/XmuFwtboW8h9prQ7x0ERpOpkMW8WkyQh2rmHqPKaAcWdblU3IXzZKQAKXcN4ePm0ItBMk0knaGdtqhb0IMOzjanlOpwgP264CtDHm/V8L+w6HguecmTVKWxrWE7gyWw9/OJhrL7BSeYG0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065474; c=relaxed/simple;
	bh=SwUHrF5QDiAmDhGvt3O8aaZ3wY0cneWpEU7Xi+6Yhhc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Lqi7E4jlDEhckI/nEHujA3g6pO5jh0COqsfNYZJQXJo2+7k60KX7iDxP0zT2mFom+Ddh86k8ZsqEMWzHcEa002mNYOe8QmyLGhIg30gL1ttHBqg/2sfgppP08SnDcEurcrM7hmc7GT0AJnoyiM6PBxa8uWK2RaVIi/VkQ4lrjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jmqNmDK3; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jmqNmDK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065471;
	bh=IyxAcGmvHfa5tCZ5n62EUH8d+0sUayt9g0nkufIYEOg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jmqNmDK3wrqgLtu1WNju+y4VORFTXafZomkBYuKo/BFouNfbPMDfgzo9a3Xdu7c51
	 q8eiTb/uuyVYju8N4V8XTSyg8/n94LhfhgI0hiftXFTqJ5bKeY4bHiFWqhDeqZ5eQ7
	 3Z7Rc3jPnPAdkVUNH1EJEFZG7yJH2SMk5kfmTL4s=
Received: from github.com (hubbernetes-node-1691b26.va3-iad.github.net [10.48.139.15])
	by smtp.github.com (Postfix) with ESMTPA id 7D448500909
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:37:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:37:51 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cd10ad-1b9a0e@github.com>
Subject: [bluez/bluez] e977e8: battery: Add component battery objects
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
  Commit: e977e8042755773b587faca107b87f24b651765f
      https://github.com/bluez/bluez/commit/e977e8042755773b587faca107b87=
f24b651765f
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/battery.c
    M src/battery.h

  Log Message:
  -----------
  battery: Add component battery objects

Allow one Bluetooth device to export multiple Battery1 objects while
keeping the legacy aggregate object at the device path.

Component objects expose their parent Device1 path, a stable identifier,
an optional percentage, and an optional charging state. Extend
BatteryProvider1 handling with the same semantics so external providers c=
an
publish multiple batteries too.

Keep component objects and their new properties behind the experimental
D-Bus flag while the API is being established.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 1f0812f0b47e36c6d807e797e69cd3fb9654f89e
      https://github.com/bluez/bluez/commit/1f0812f0b47e36c6d807e797e69cd=
3fb9654f89e
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/org.bluez.Battery.rst
    M doc/org.bluez.BatteryProvider.rst

  Log Message:
  -----------
  doc: Document component battery objects

Describe the experimental component Battery1 properties, their opaque
object paths, and how BatteryProvider1 implementations publish several
batteries for one device.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 738a389928f67ebc915acf5468ed44f24ec4ccb1
      https://github.com/bluez/bluez/commit/738a389928f67ebc915acf5468ed4=
4f24ec4ccb1
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M Makefile.plugins
    M doc/test-coverage.txt
    A profiles/fastpair/fastpair.c
    A profiles/fastpair/message-stream.c
    A profiles/fastpair/message-stream.h
    A unit/test-fastpair.c

  Log Message:
  -----------
  fastpair: Add Message Stream battery profile

Connect to the experimental Fast Pair Message Stream service advertised b=
y
compatible BR/EDR devices and parse its 16-bit-length framed messages.

The Message Stream specification defines a fixed endpoint UUID over RFCOM=
M
and a separate L2CAP PSM transport. This implementation supports the RFCO=
MM
variant; L2CAP support is left for future work:

https://developers.google.com/nearby/fast-pair/specifications/extensions/=
messagestream

Publish left, right, and case values as component Battery1 objects. The
Device Information extension defines the battery update message. Its thre=
e
component bytes use the Battery Notification encoding:

https://developers.google.com/nearby/fast-pair/specifications/extensions/=
deviceinformation
https://developers.google.com/nearby/fast-pair/specifications/extensions/=
batterynotification

Include unknown percentage and charging-state transitions. Decode unknown=

levels using the generic Battery Notification status bit while treating t=
he
TWS-specific case value 0xff as unavailable, as required for hearables:

https://developers.google.com/nearby/fast-pair/specifications/devicefeatu=
rerequirement/devicefeaturerequirement_hearables

If only the Message Stream is lost, invalidate its values and reconnect.
Use exponential backoff and reset it only after a battery-producing strea=
m
remains stable. Remove the objects once the BR/EDR bearer disappears.

Keep pending connection callbacks alive through cancellation and ignore
callbacks for detached or superseded channels.

Assisted-by: Codex:gpt-5.6-sol


  Commit: e7963702fb3dcc054bfddc6923ff5ba90b63e575
      https://github.com/bluez/bluez/commit/e7963702fb3dcc054bfddc6923ff5=
ba90b63e575
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.tools
    A test/test-fastpair

  Log Message:
  -----------
  test: Add Fast Pair Message Stream tool

Add a standalone profile client that prints Fast Pair Message Stream fram=
es
and can optionally publish left, right, and case values through
BatteryProvider1.

Publish dynamic component lifecycle signals, scope providers per adapter,=

and invalidate measurements when a stream closes. Warn users to disable t=
he
built-in Fast Pair plugin when using the external profile.

Assisted-by: Codex:gpt-5.6-sol


  Commit: a79a955d4a8ab504e4fd53d5dabc24a696ab8ff9
      https://github.com/bluez/bluez/commit/a79a955d4a8ab504e4fd53d5dabc2=
4a696ab8ff9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/bluetooth.service.in

  Log Message:
  -----------
  bluetooth.service: Fix ConfigurationDirectory warning

When running "systemctl start bluetooth.service" on some systems, this
error would appear:
systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the =
mode is different. (File system: 755 ConfigurationDirectoryMode: 555)

ConfigurationDirectoryMode was mistakenly thought to help sandbox the
daemon, but the service configuration already sets ProtectSystem=3Dstrict=

but "If [ProtectSystem is] set to "strict" the entire file system
hierarchy is mounted read-only", so bluetoothd can't write to
/etc/bluetooth anyway.

Fixes: 00cfb36e20e3 ("bluetooth.service: Set ConfigurationDirectoryMode")=

Closes: https://github.com/bluez/bluez/issues/414


  Commit: a9cfc988dd35c625906f21229d5f94a61f17e8c0
      https://github.com/bluez/bluez/commit/a9cfc988dd35c625906f21229d5f9=
4a61f17e8c0
  Author: Dan Halbert <halbert@adafruit.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Keep primary flag on re-insert

discovery_parse_services() passes the primary argument on the first
gatt_db_insert_service() call, but passes false on the retry that follows=

gatt_db_clear_range(). A primary service whose newly discovered record
collides with a cached one is therefore stored, and exported on D-Bus, as=

a secondary service with org.bluez.GattService1.Primary =3D false.

Before commit fac14943fa25 the two calls used the correct true or false
flag: discover_primary_cb() used true and discover_secondary_cb() used fa=
lse.

Fixes: fac14943fa25 ("shared/gatt-client: Consolidate code parsing servic=
es")
Assisted-by: Claude:claude-opus-5
Assisted-by: Claude:claude-fable-5-1


  Commit: 7ac7aa092096c3dec0ce455f5f379c81aa4a9273
      https://github.com/bluez/bluez/commit/7ac7aa092096c3dec0ce455f5f379=
c81aa4a9273
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp-player.c

  Log Message:
  -----------
  media: fix wrong argument to lp_get_uid() in avrcp-player

In track_changed(), lp_get_uid() is passed struct local_player although
player_link is expected, which is ASAN crash.  It takes void * since
it's avrcp_player_cb callback function, so wasn't caught by compiler.

Pass the right object. Fixes AddressSanitizer: heap-buffer-overflow


  Commit: 74bc1ca27a7c1efcf236fd63e9e5c238fa524c80
      https://github.com/bluez/bluez/commit/74bc1ca27a7c1efcf236fd63e9e5c=
238fa524c80
  Author: Paul Menzel <pmenzel@molgen.mpg.de>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.obexd
    M obexd/plugins/phonebook-dummy.c
    M obexd/plugins/phonebook-ebook.c
    M obexd/plugins/phonebook-tracker.c
    A obexd/plugins/phonebook.c
    M obexd/plugins/phonebook.h

  Log Message:
  -----------
  obexd: Reference count the phonebook back-end setup and teardown

Stopping obexd on Debian sid/unstable with *bluez* 5.87-1 logs a GObject
critical:

    obexd[10687]: Terminating
    systemd[1804]: Stopping obex.service - Bluetooth OBEX service...
    obexd[10687]: g_object_unref: assertion 'G_IS_OBJECT (object)' failed=

    systemd[1804]: Stopped obex.service - Bluetooth OBEX service.

Two builtin plugins use the phonebook back-end: pbap (pbap_init() at
obexd/plugins/pbap.c:962, pbap_exit() at :1002) and irmc (irmc_init() at
obexd/plugins/irmc.c:446, irmc_exit() at :473). Each calls phonebook_init=
()
when it is loaded and phonebook_exit() when it is unloaded, but neither t=
he
callers nor the back-end track ownership of the singleton they share.
plugin_init() therefore sets the back-end up twice and plugin_cleanup()
tears it down twice. A gdb trace of the shutdown path confirms both pairs=

of calls.

The dummy back-end tolerates this by accident: phonebook_init() bails out=

early when root_folder is already set, and the second phonebook_exit() on=
ly
repeats a g_free()/NULL assignment. The ebook back-end, which Debian buil=
ds
(*bluez-obexd* depends on *libebook-1.2* and *libedataserver*), does not.=

Its phonebook_init() stores three GObject references in static variables
and phonebook_exit() unconditionally drops all three, so the second
teardown unrefs objects that were already finalized. The registry and the=

address book are effectively singletons in evolution-data-server and mere=
ly
gain a second reference, but e_book_client_connect_sync() hands back a
fresh client on every call, so the first client leaks and the second one =
is
unreffed twice =E2=80=93 hence a single critical rather than three.

Put the ownership tracking in one place instead of duplicating it in ever=
y
back-end: phonebook_init() and phonebook_exit() now live in a new shared
obexd/plugins/phonebook.c and reference count the back-end, so only the
first init and the last exit reach it. The back-end entry points are
renamed to phonebook_driver_init()/phonebook_driver_exit() so that they
cannot be called directly by mistake.

Assisted-by: Claude Code:claude-opus-5


  Commit: dca0f10fd560f8095493021ca2ac20236fde026e
      https://github.com/bluez/bluez/commit/dca0f10fd560f8095493021ca2ac2=
0236fde026e
  Author: Chad Spensky <chad@allthenticate.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: clamp max_len in print_packet

print_packet() derives the snprintf() bound for the packet text from the
terminal width and never bounds it against the space left in line[]:

	char line[LINE_MAX], ts_str[96], pid_str[140];
	int col =3D num_columns();
	...
	int max_len =3D col - len - extra_len - ts_len - 3;

	if (max_len <=3D 0) {
		extra =3D NULL;
		max_len =3D col - len - ts_len - 3;
	}

	n =3D snprintf(line + pos, max_len + 1, "%s%s",
					label ? ": " : "", text);

max_len can leave range in both directions, and either aborts under
_FORTIFY_SOURCE with "*** buffer overflow detected ***: terminated":

 - The existing max_len <=3D 0 recovery drops extra and recomputes, but i=
f
   the prefix alone exceeds the column budget the result is still
   negative, and max_len + 1 then underflows when converted to size_t.
   len includes the "comm[pid]: " prefix built from struct ucred, which
   is only present when reading from the monitor socket, so this is
   reachable at ordinary widths. On a host with a large kernel.pid_max
   the pid is 7 digits, so a long process name plus a long label is
   enough and btmon dies mid-capture. Replaying the same traffic from a
   btsnoop file never reproduces it, because there is no ucred and hence
   no prefix.

 - col larger than sizeof(line) makes max_len + 1 exceed the remaining
   buffer. LINE_MAX raised the bar but did not remove it.

A negative max_len is also used to index line[] when truncating the
text, writing before the start of the buffer, so this is an
out-of-bounds write and not only an abort.

The check only triggers at _FORTIFY_SOURCE=3D3; at =3D2 the runtime pos
offset defeats __builtin_object_size and the check is elided, which is
why this is mostly seen on distributions defaulting to =3D3.

Clamp max_len to the space remaining in line[], and only write the
ellipsis when there is room for it.

Reproduced and verified by building the current logic and the patched
logic with -O2 -D_FORTIFY_SOURCE=3D3 and replaying a capture at a range o=
f
terminal widths:

	cols   before   after
	  10   abort    ok
	  20   abort    ok
	  40   abort    ok
	  80   ok       ok
	 200   ok       ok
	2000   ok       ok
	3000   abort    ok
	5000   abort    ok

Reported-at: https://github.com/bluez/bluez/issues/1104


  Commit: 58495d652deafc1c4d782c5192e9fe889bb7c9a3
      https://github.com/bluez/bluez/commit/58495d652deafc1c4d782c5192e9f=
e889bb7c9a3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: make AdminPolicy state per-adapter

Fix AdminPolicy D-Bus updates being emitted on the wrong adapter path
by removing the single global policy context and moving to per-adapter
policy objects.

Changes include:
- track policy contexts in a policy queue keyed by adapter pointer
- keep per-adapter device lists inside each policy context
- emit ServiceAllowList changes using the callback's adapter context
- scope device affected updates to the current adapter only
- clean up probe/remove lifecycle so adapters are registered and torn
  down independently
- remove remaining global policy_data/devices coupling

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 640a1227d02e1abaa73db29360012f6342e6f5f5
      https://github.com/bluez/bluez/commit/640a1227d02e1abaa73db29360012=
f6342e6f5f5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M client/admin.c
    M client/admin.h
    M client/main.c

  Log Message:
  -----------
  client/bluetoothctl: make admin.allow controller-aware

Teach admin.allow to target the selected default controller.

Replace single cached AdminPolicy proxies with per-controller proxy
lookup keyed by controller object path, so controller selection changes
are respected.

Export controller default helpers from main.c for reuse by admin.c.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 006aea02ce42606def8c6ce65a7452ea2416ae4e
      https://github.com/bluez/bluez/commit/006aea02ce42606def8c6ce65a745=
2ea2416ae4e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  src/adapter: enforce allowlist for local services

Apply admin allowlist to adapter/server service startup and
registration, and reapply policy dynamically when allowlist changes.

- Gate adapter profile probe by allowlist-derived UUID policy
- Reapply active adapter profiles on allowlist updates (stop
  disallowed, start newly allowed)
- Block SDP service registration when UUID is not allowed
- Reapply existing local SDP registrations at runtime by removing
  services that become disallowed
- Map both a2dp-source and a2dp-sink admin policy checks to
  ADVANCED_AUDIO_UUID (0x110d). This keeps A2DP profile infrastructure
  enabled when the A2DP class UUID is allowed, while specific local
  Audio Source/Sink records remain filtered by their own UUID allowlist
  checks

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 301a500789ad543d7f83724b1e9285699aab1364
      https://github.com/bluez/bluez/commit/301a500789ad543d7f83724b1e928=
5699aab1364
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: reapply allowlist on policy updates

Invoke adapter allowlist reapply after SetServiceAllowList updates
so runtime state follows policy changes immediately.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 37cbd0b79deb4840ac48f7da6b1cf9d7f63b6198
      https://github.com/bluez/bluez/commit/37cbd0b79deb4840ac48f7da6b1cf=
9d7f63b6198
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicySet.rst
    M doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc: describe admin allowlist runtime enforcement

Document that ServiceAllowList now also governs local adapter/server
startup and registration, and that allowlist updates are applied
immediately on initialized adapters.

Clarify ServiceAllowList status semantics for both remote profile
connection policy and local server policy.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 02b839af0b4c8f981f7500d34d411e9ecb034b9f
      https://github.com/bluez/bluez/commit/02b839af0b4c8f981f7500d34d411=
e9ecb034b9f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/device.c

  Log Message:
  -----------
  device: unify admin allowlist checks for device services

Consolidate device-side admin policy handling into one coherent model so
incoming and outgoing A2DP behavior follows the configured allowlist
consistently.

Why:
- The initial profile-aware adapter mapping fixed role-inverted A2DP case=
s
  for some paths, but device-side service gating still used mixed criteri=
a.
- Host-initiated Connect() could evaluate A2DP services with the wrong UU=
ID
  perspective, leading to valid flows being blocked (or blocked flows bei=
ng
  considered valid) under partial allowlists.

What changed:
- Use direct UUID allowlist checks for device service eligibility updates=
.
- Add A2DP role-aware mapping for device policy UUID selection:
  - a2dp-sink -> A2DP Source UUID (110a)
  - a2dp-source -> A2DP Sink UUID (110b)
- Apply the same policy UUID resolution in:
  - btd_device_all_services_allowed()
  - btd_device_update_allowed_services()

Result:
- Device-service policy decisions now align with intended local A2DP role=

  semantics for both remote-initiated and host-initiated connection paths=
.
- Admin allowlist enforcement remains strict while eliminating the observ=
ed
  false block during host->remote A2DP connect attempts.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: da088621411a0ab55e9983eb72c32fa3eb18846c
      https://github.com/bluez/bluez/commit/da088621411a0ab55e9983eb72c32=
fa3eb18846c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/media.c

  Log Message:
  -----------
  profiles/audio: make A2DP admin allowlist enforcement role-safe

Unify audio-side allowlist enforcement so A2DP behavior remains correct
across dynamic policy updates, reconnects, and role-specific endpoint
negotiation.

Why:
- Dynamic allowlist reapply could leave stale A2DP role state and danglin=
g
  role lists, leading to invalid reuse and instability during subsequent
  signaling/SEP handling.
- Policy enforcement happening late (at SetConfiguration time) allowed
  blocked roles to remain visible during capability negotiation, which ca=
used
  retry/disconnect behavior until session managers were restarted.

What changed:
- Harden A2DP server role removal bookkeeping:
  - clear source_enabled/sink_enabled flags on remove
  - clear server->sources/server->sinks list heads after free
  - unregister shared server only when both roles are disabled
- Enforce admin policy at SEP negotiation boundaries:
  - add role-aware helper mapping local SEP type to policy UUID
  - reject blocked roles in Get_Capability path
  - reject blocked roles early in Set_Configuration path
- Keep endpoint registration resilient when partial allowlists block spec=
ific
  A2DP records, so allowed endpoints continue to register.

Result:
- A2DP policy decisions are consistent with local role semantics.
- Blocked roles are filtered earlier and more predictably.
- Runtime policy transitions are stable, without requiring daemon/session=

  manager restarts to recover expected reconnect behavior.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 1b9a0eca8cdf6889a288e1a59f39e9452e7737f7
      https://github.com/bluez/bluez/commit/1b9a0eca8cdf6889a288e1a59f39e=
9452e7737f7
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix integer overflow and 3 CI VLA wanings

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.

Fix CI warnings: Variable length array is used, use malloc/free instead.


Compare: https://github.com/bluez/bluez/compare/cd10ada1b16e...1b9a0eca8c=
df

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
