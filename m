Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A118A6D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749517; cv=none; b=koq107pOjmKVq1FcBN8TH59z10Voq1IAvp6uRBYW1g8ApdUK3TQxXZ3ux7j9rNgAdiL8OtyT3tb0dvv6gQuqa3izOi3KdSpe62bfGmF6GV0ES5HT8G11gCb/Di7O01YN3mj4WIFDNT3/wrquFyw0ODYxD8sugyH4Rah4bMH8ulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749517; c=relaxed/simple;
	bh=VEJvQ9zxqNJ70fE1u9gt7NyBP5tizpqzuQuTts+rYvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xc6V1yrYVkDruidu/m4Gw10gmrqul0tmYpbkl52eJky2oSUWV3LKz8fDMoq1BQuas3UlSq2jpEY/p5aLDKBFrEdOL6I+ytKIaAe3xmPtYp7pD2J9MKwlLR3fRIob5GHfxbAexNyfTkYMKYDQWZHRTFNLX0FYP85F14SX3LAmq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43B43EC61;
	Wed, 26 Aug 2026 13:05:11 +0000 (UTC)
Message-ID: <7a3a42decb4efb22d481bc10bd14ee221dfb9d20.camel@hadess.net>
Subject: Re: Heap buffer overflow in adv_monitor.c via uint8_t truncation of
 pattern count
From: Bastien Nocera <hadess@hadess.net>
To: BUGPWN <vuln.bugpwn@gmail.com>, security@bluez.org
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 26 Aug 2026 15:05:11 +0200
In-Reply-To: <CAOZc4kvLV-FPcGX87FqjSKsXxa885Gk9MfD7NtapoaqhCB7uLA@mail.gmail.com>
References: 
	<CAOZc4kvLV-FPcGX87FqjSKsXxa885Gk9MfD7NtapoaqhCB7uLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTF8Ybfbl3RqjiyIYdxkHZQ07/Klp4U3CE9ZLuI7eFHgwwUQgV0S733T/N2TV93URW54u2bM6eA+9FHgLdkrxehHAgRHfWwIrBIcKcuV+UfYc+B0geAnTAHaLmUeCoeEB1Lc5Se49M3b5J7mgqjF4a63kIeG7Bb9OaEeEDwYWRUEsReu3tMV0NJh+fVYJbRweY6H0Ki/LYd+roXTX5/+ws4mHNvpn5UoXYatAXJYv1qjxGGLPo/6MU4q3LH816qV5FAeduDBRm4bhYbKa5QN2V8qp0LNXtqCQ22ng8Yzb+L09EjTbhb5UwUhHSqDWCPhgSSav7KGRBIhBmgTvmO37/FjLsg5HASyFYulY0i+lsYYXmwRe7diH/i5QWQ9hW8AEwfMZPTRNTdW4uJ3Q3r4Xo7puCxx5u4+YMiOY68CfQyNZ/8083AFCE+FaNoIQpsQd0EiWpm7zv6mjdkMI6JJvlKBFe3Euxtoh+O2oRkR6Lt9yjDlKP9NuAZs5ajqnDhO52R/H4NkHvrxEl7yz6dGjXK5rvFbgjcApgaSoPM0ASXToHGtBojsGg5uRPLomU5tlRwuvG7e5N2eWyg5TC4BRRX1y+NcZTjcFnF9jRAFf/LQ4MQB9Y2CtBtw62ntEFaDyOO/+LYpfMvCd7QCJctf0ffIuM5QP6n/2/ZTpa5rDDFH0w
X-GND-State: clean



On Tue, 2026-08-25 at 12:38 +0100, BUGPWN wrote:
> Summary
> -------
>=20
> bluetoothd contains a heap buffer overflow (CWE-131 / CWE-190,
> incorrect
> size calculation via integer truncation) in
> merged_pattern_send_add_pattern() and
> merged_pattern_send_add_pattern_rssi()
> (src/adv_monitor.c). Any local, unprivileged D-Bus client can trigger
> this
> against a root-owned bluetoothd process by registering a malicious
> org.bluez.AdvertisementMonitor1 object with a crafted number of
> Patterns
> entries; no special D-Bus permission is required (see "Reachability"
> below).
>=20
> Confirmed against current git HEAD:
> =C2=A0 commit efd216fe280ba5dd38d1b6084f64784bf1328731 (2026-07-16)

It was fixed in:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5cf94acaea7=
18d1955d4bcc16dea57f31fae14ad
and:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D14347c86fb9=
99416959720fd844427d02e241ba8

And was originally reported to us in:
https://github.com/bluez/bluez/security/advisories/GHSA-hhgc-hfgf-8m4x
and with this one as a duplicate:
https://github.com/bluez/bluez/security/advisories/GHSA-rfcf-9fw3-m9qp

>=20
>=20
> Vulnerable code
> ---------------
>=20
> src/adv_monitor.c:1105-1137 (merged_pattern_send_add_pattern; the
> RSSI
> variant merged_pattern_send_add_pattern_rssi at :1140-1180 has the
> same
> bug with a different struct):
>=20
> =C2=A0=C2=A0=C2=A0 static bool merged_pattern_send_add_pattern(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct adv_monitor_merged_pattern *merged_pattern)
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mgmt_cp_add_adv_monitor=
 *cp =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t pattern_count, cp_len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct queue_entry *e;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool success =3D true;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pattern_count =3D queue_length=
(merged_pattern->patterns);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp_len =3D sizeof(*cp) + patte=
rn_count * sizeof(struct
> mgmt_adv_pattern);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp =3D malloc0(cp_len);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 false;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (e =3D queue_get_entries(m=
erged_pattern->patterns); e; e =3D
> e->next) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 bt_ad_pattern *pattern =3D e->data;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy=
(&cp->patterns[cp->pattern_count++], pattern,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*pattern));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>=20
> queue_length() (src/shared/queue.h:52) returns an unsigned int: the
> real,
> untruncated number of patterns. The truncation happens only at the
> assignment `pattern_count =3D queue_length(...)` into the uint8_t
> local.
> `cp_len` is computed from that already-truncated `pattern_count`, but
> the
> for-loop that follows is bounded by the real linked-list traversal
> (e =3D e->next), independent of `cp_len`/`pattern_count`; it always
> writes
> one 34-byte struct mgmt_adv_pattern per real entry in the queue.
>=20
> lib/bluetooth/mgmt.h:
> =C2=A0 struct mgmt_adv_pattern { uint8_t ad_type, offset, length; uint8_t
> =C2=A0=C2=A0=C2=A0 value[31]; } __packed;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> sizeof =3D=3D 34
> =C2=A0 struct mgmt_cp_add_adv_monitor { uint8_t pattern_count; struct
> =C2=A0=C2=A0=C2=A0 mgmt_adv_pattern patterns[0]; } __packed;=C2=A0=C2=A0 =
-> sizeof =3D=3D 1
>=20
> With exactly N =3D 256 * k patterns (any k >=3D 1): pattern_count =3D N m=
od
> 256
> =3D=3D 0, so cp_len =3D 1 + 0*34 =3D 1. malloc0(1) allocates a 1-byte buf=
fer,
> while
> the loop writes all N real entries (N * 34 bytes) into it; with
> N=3D256,
> that is an 8704-byte heap write past a 1-byte allocation, with
> attacker-controlled content.
>=20
> parse_patterns() (src/adv_monitor.c:888-967, read in full) places no
> upper
> bound on the number of entries accepted in the D-Bus "Patterns" array
> property; it never checks the count against
> manager->max_num_patterns (which is read from the kernel via
> MGMT_OP_READ_ADV_MONITOR_FEATURES but never used for validation).
>=20
>=20
> Reachability (local, unprivileged)
> -----------------------------------
>=20
> src/bluetooth.conf (installed as
> /usr/share/dbus-1/system.d/bluetooth.conf on a typical distro;
> verified
> identical on our test system) contains:
>=20
> =C2=A0=C2=A0=C2=A0 <policy context=3D"default">
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <allow send_destination=3D"org=
.bluez"/>
> =C2=A0=C2=A0=C2=A0 </policy>
>=20
> This is the fallback policy applied to any D-Bus connection that
> isn't
> root; it permits calling any method on org.bluez, including
> org.bluez.AdvertisementMonitorManager1.RegisterMonitor(). bluetoothd
> runs
> as root. So this is a heap-corruption primitive in a root daemon,
> triggerable by any local, unprivileged user, not merely a DoS.
>=20
> Call chain from the D-Bus entry point to the vulnerable code
> (confirmed
> via gdb backtrace on a real crash, see "Proof of concept"):
>=20
> =C2=A0 gdbus/client.c: get_managed_objects_reply() ->
> parse_managed_objects()
> =C2=A0 -> parse_interfaces() -> parse_properties() -> proxy_added()
> =C2=A0 -> src/adv_monitor.c: monitor_proxy_added_cb() (:1240)
> =C2=A0 -> merged_pattern_add() (:368)
> =C2=A0 -> merged_pattern_send_add() (:1187)
> =C2=A0 -> merged_pattern_send_add_pattern() (:1105), the vulnerable
> function
>=20
> A malicious local process registers an AdvertisementMonitorManager1
> app
> (RegisterMonitor), exposes a single org.bluez.AdvertisementMonitor1
> object
> under it with Type=3D"or_patterns" and a Patterns array of 256 entries
> (each just {offset=3D0, ad_type=3D0x09, value=3D[1 byte]}, the minimum
> bt_ad_pattern_new() (src/shared/ad.c:1304-1327) accepts; it rejects
> len=3D=3D0). bluetoothd reads this back via GetManagedObjects()/
> Properties.GetAll() as part of handling RegisterMonitor(), reaching
> the
> vulnerable code without any further action from the caller.
>=20
> Note: AdvertisementMonitorManager1 is an "[experimental]" D-Bus
> interface;
> it is only exposed when bluetoothd is started with -E/--experimental.
> We have not checked how commonly distros enable this by default;
> several
> do ship it enabled (it backs bluetoothctl's `monitor` submenu and is
> used
> for BLE presence/proximity features).
>=20
>=20
> Proof of concept
> -----------------
>=20
> We compiled bluetoothd directly from this repository (unmodified
> sources;
> ./bootstrap && ./configure --disable-systemd --disable-udev
> --disable-obex --disable-client --disable-cups --disable-manpages
> --disable-datafiles && make) and drove the attack from a small Python
> script (adapted from the repo's own test/example-adv-monitor, using
> the
> async reply_handler/error_handler D-Bus API: a synchronous
> RegisterMonitor() call deadlocks, since bluetoothd calls back into
> the
> caller's own GetManagedObjects() before replying), run as a normal
> non-root user against bluetoothd running as root via a virtual HCI
> controller (/dev/vhci) for a test adapter.
>=20
> 1. Built with AddressSanitizer:
>=20
> =C2=A0=C2=A0 =3D=3D174053=3D=3DERROR: AddressSanitizer: heap-buffer-overf=
low ...
> =C2=A0=C2=A0 WRITE of size 34 at ... thread T0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0 allocated by thread T0 here:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #0 calloc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #1 merged_pattern_send_add_pattern s=
rc/adv_monitor.c:1116
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #2 merged_pattern_send_add src/adv_m=
onitor.c:1187
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #3 merged_pattern_add src/adv_monito=
r.c:368
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #4 monitor_proxy_added_cb src/adv_mo=
nitor.c:1240
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #5 proxy_added gdbus/client.c:411
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #6 parse_properties gdbus/client.c:1=
201
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #7 parse_interfaces gdbus/client.c:1=
226
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #8 parse_managed_objects gdbus/clien=
t.c:1318
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #9 get_managed_objects_reply gdbus/c=
lient.c:1339
>=20
> =C2=A0=C2=A0 0x7b4822642b91 is located 0 bytes after 1-byte region
> =C2=A0=C2=A0 [0x7b4822642b90,0x7b4822642b91)
> =C2=A0=C2=A0 SUMMARY: AddressSanitizer: heap-buffer-overflow
> src/adv_monitor.c:1123
> =C2=A0=C2=A0 in merged_pattern_send_add_pattern
>=20
> =C2=A0=C2=A0 ASan confirms the exact 1-byte allocation predicted above, w=
ith
> the
> =C2=A0=C2=A0 overflow detected at the very first out-of-bounds byte. blue=
toothd
> =C2=A0=C2=A0 terminates via SIGABRT (exit 134).
>=20
> 2. Built without ASan, with realistic distro hardening flags only
> =C2=A0=C2=A0 (-O2 -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -Wl,-z,r=
elro,-
> z,now
> =C2=A0=C2=A0 -pie), to observe the real (uninstrumented) glibc heap corru=
ption.
> We
> =C2=A0=C2=A0 ran the identical attack (256 patterns) three times and capt=
ured
> core
> =C2=A0=C2=A0 dumps; each run produced a DIFFERENT crash signature:
>=20
> =C2=A0=C2=A0 Run 1: SIGSEGV, inside the loop itself (memcpy,
> adv_monitor.c:1123).
> =C2=A0=C2=A0=C2=A0=C2=A0 gdb shows cp->pattern_count =3D=3D 0x60 (96) at =
crash time: 96
> writes
> =C2=A0=C2=A0=C2=A0=C2=A0 (~3.3 KB) succeeded before the overflow reached =
and corrupted an
> =C2=A0=C2=A0=C2=A0=C2=A0 adjacent struct queue_entry {void *data; struct =
queue_entry
> *next;}
> =C2=A0=C2=A0=C2=A0=C2=A0 (16 bytes, src/shared/queue.c) belonging to the =
SAME queue the
> loop
> =C2=A0=C2=A0=C2=A0=C2=A0 is iterating; `p *e` shows {data =3D 0x0, next =
=3D
> 0x900000000000000},
> =C2=A0=C2=A0=C2=A0=C2=A0 i.e. the node's own `data` pointer got zeroed an=
d `next` was
> =C2=A0=C2=A0=C2=A0=C2=A0 overwritten with attacker-supplied bytes, immedi=
ately
> dereferenced
> =C2=A0=C2=A0=C2=A0=C2=A0 by the loop's own `e =3D e->next`.
>=20
> =C2=A0=C2=A0 Run 2: SIGABRT. The loop completes all 256 writes without cr=
ashing
> =C2=A0=C2=A0=C2=A0=C2=A0 (reaches adv_monitor.c:1127, mgmt_send()); the c=
rash happens
> later,
> =C2=A0=C2=A0=C2=A0=C2=A0 inside sysmalloc() (malloc.c:2610) during an unr=
elated
> calloc(40)
> =C2=A0=C2=A0=C2=A0=C2=A0 for a GLib IO watch: "Fatal glibc error: ... ass=
ertion failed"
> on
> =C2=A0=C2=A0=C2=A0=C2=A0 the heap's top chunk: the overflow had corrupted=
 the top-chunk
> =C2=A0=C2=A0=C2=A0=C2=A0 size sentinel.
>=20
> =C2=A0=C2=A0 Run 3: SIGABRT, again after the loop completes, this time in=
side
> =C2=A0=C2=A0=C2=A0=C2=A0 _int_malloc() (malloc.c:4211) on an unrelated ma=
lloc(7):
> "malloc():
> =C2=A0=C2=A0=C2=A0=C2=A0 invalid size (unsorted)": a corrupted size field=
 on a chunk in
> the
> =C2=A0=C2=A0=C2=A0=C2=A0 unsorted bin.
>=20
> =C2=A0=C2=A0 All three are genuine glibc heap-metadata/application-pointe=
r
> =C2=A0=C2=A0 corruption, not simply walking off into unmapped memory. The=
 heap
> =C2=A0=C2=A0 layout at the moment of the vulnerable allocation is evident=
ly not
> =C2=A0=C2=A0 fully deterministic run-to-run for an identical payload (lik=
ely
> due
> =C2=A0=C2=A0 to concurrent D-Bus/GLib activity affecting what else is liv=
e on
> the
> =C2=A0=C2=A0 heap), which we note as a data point for your own severity
> assessment.
> =C2=A0=C2=A0 We have not attempted to go beyond this characterization to =
build
> a
> =C2=A0=C2=A0 working exploit (no attempt made to control heap layout, tar=
get a
> =C2=A0=C2=A0 specific security-relevant object, or defeat ASLR).
>=20
> We're happy to share the PoC scripts/harness; let us know your
> preferred
> format given your no-attachments preference.
>=20
>=20
> Impact
> ------
>=20
> - Reliable local crash of bluetoothd (a root-owned daemon),
> triggerable via a single D-Bus call
> =C2=A0 by any local, unprivileged user, with no special permission,
> capability, or prior interaction
> =C2=A0 with Bluetooth hardware required: src/bluetooth.conf's default D-
> Bus
> policy allows this to any
> =C2=A0 local user.
>=20
> - Genuine heap-memory corruption on an uninstrumented build, not
> merely a crash on unmapped
> =C2=A0 memory. Confirmed across 3 test runs, each hitting a different
> corruption path (an adjacent
> =C2=A0 application-level linked-list node, the heap's top-chunk sentinel,
> and an unsorted-bin chunk's
> =C2=A0 size field; see "Proof of concept" above). The overflow content is
> attacker-controlled.
>=20
>=20
> Next step we have not taken but could: attempt to control the heap
> layout (e.g. by pre-allocating
> same-size objects before triggering the overflow) so the corruption
> lands on a chosen,
> security-relevant structure instead of our own throwaway queue_entry
> nodes, to determine whether
> this can be turned into a controlled write primitive rather than a
> crash.
>=20
> Reporter
> --------
>=20
> BUG|PWN & Sadoc ADONON
> vuln.bugpwn@gmail.com
>=20
