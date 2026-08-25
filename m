Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1192E06E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667676; cv=pass; b=K0C6L6diztR/HwnjL+qG312NL2QhSRbyhiZ79hX+ds2p5w3PGSv0i5TmAumC3A7yD1pfUha+yLlZdNmX69x2qBUes8anXqSnLh4LKsoqtIWoi8EGhVaXBy007vUiPew8K+iSWmeBXodSDS+axNu4c5YgBt5CRyf0nFvwpjVsUkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667676; c=relaxed/simple;
	bh=2orKxO4pWoTq2PfZ8OyYknJUrxJHgG2OTeGZgrlEFMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBYa2my93jBUPwrKOkJRZHTPdeYhCAELeTwsBDQv1db5yYxdJyufQ8HrRAl62IEzxTGlV1oW9YShPm2d/+0OZ7cb1l4OomwOEQhEIi7P178167z+lsWxCuTU8Rw1+xQn9WqBUjgrj6Ah41fBw7YYtnjC7ELiGR7HXBUXVScDkTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fikJEpj2; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fikJEpj2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66d06b5f023so3353317d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 07:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787667673; cv=none;
        d=google.com; s=arc-20260327;
        b=sRvH4BLbtlV2DqyuGct+oJVcE9ImMTThXhZ1MmumM9Usq7x9rcvw/NBHR5nWQ66eNp
         hlSh8hNHs6USm7SNRsfaVeBFhuuVaO7lE/tyTu/LWkuN5h/4Lt95T8yIFa+20aNCe49Y
         DdYRF6GHaYa6nt0SsGDm5E3IOjvGX2p1NZ4IxFOVODmG4tM38wL/MvXgZEirt8tY3Qy4
         jSrLVrM++qVFypyBVuv6LmlpY8xlSDsL9sNCgI1aKWbjOUxgy9IfAuNit/yECO1dxbQO
         lne6gQBFoBoucWcJUzddwOxS0WLEkCSsNSzwpnIocNV16PI0XBySbZRdOSI2W59pWcKc
         9ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAXs3s68hpKRUihdMzQZDHMm1r1yUY9Wh5zKmwcRi5g=;
        fh=J5Hm0uSHAbwxoMnjiIT/zLvDKph+pW90E0QHUkq0PRY=;
        b=S68sqxEtYMQndvPEsE3+P+GbGrrQZErOs7nbRh5grP3urU2G52xcOdvAHE1FNOhrui
         Xoe3NibECMnZfO/aBMZ1m3jbTqnslXxbe2v12jf6LYHPv8w5n/T04cyHwCCfiygTd2zZ
         N6apUYEErcP+l/P5dPIR66Z67gEvzOPHaoTchPv1DWSpRbMKp2MZ8+ah1YhJfL6C9zo1
         wnAql2c1kHSAa01fLRPI4gCmm49Lzwmq9yDUVdZGd58uqh4aeMswgZS89xfCaGxfzIXd
         Zx3iQpMC30PdI/XoMFVWfuYBiydRGTU8awZTBxpvKZ8lk7r0qbOKGSXaMoSUwViMX7nO
         PguQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787667673; x=1788272473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lAXs3s68hpKRUihdMzQZDHMm1r1yUY9Wh5zKmwcRi5g=;
        b=fikJEpj2LXBJI5sG74r9KWfeRJqMPWKeIPXwikWIKk9XBpAvEkV10OjiRU0wHjmPC8
         rtlZNIoGUAIQYHaazlOrK+rIaNq/em2I57gMFKzp36j8z1Nz0eSTyQV1XDBoGcdaMMWi
         4qEffbId/cpf0SFadK492zTPg0ajn2+MPr7e9QX4Yw1mCTV95cis7EdbWFurJZRr9MOp
         DfdPFHO1VmvNRr3lrkK0pijO54/8vonG8CuYAaAFQPNlVc77C4QVp61Vx1kSzdFvMDuq
         q8YvaUvbz0UROOtBAGQ5e1Ua3K6+/UphRl/040ZXiZY4RJlWt+btjUJAbxFk21rmkQTj
         zWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667673; x=1788272473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAXs3s68hpKRUihdMzQZDHMm1r1yUY9Wh5zKmwcRi5g=;
        b=Db70htRPTsC9wNUi4Ga/EEE70uGKaVKyPldNllGJMBwXYQqRzZro3Q2oyp4tZ9cRJU
         55v4AFRITtsFkX7r8ktIKH0EsUcl8YWPHBZdMCv+Vb8vZf5LpXkBZRS8t/TZFTfRaul9
         Awbk8qSikc8qksVuu9ERLtyJwUB8cUZjKEUuwXBEmBvYn3abm+1WMs1ZO6qm7w03EIp5
         dBCV8rUBKSUDGrddZ89ElACpxdkU8DLdi52l8GIvZyxlXs5T/oL3zeFxj/Mu+cjX6dbb
         4L90ZQc2fztdPkqcaoCoMO71e473fWWod30MPTRQ9h+X2f+y9l98ISwglztiMF+wicVq
         DWAA==
X-Forwarded-Encrypted: i=1; AHgh+RpDe1K3Tp8tFXV1wra/pkP9TioTiGb5D+T8AdPr2RYWk1eurWua10pOvQHfoyFjbK4wVOwxQgdqHQlalSHOy4A=@vger.kernel.org
X-Gm-Message-State: AFuF++mZe/Etb5miQMOYNJ7bn7EHGOInkwLZWFtaFQx90BxQbj1+EOpw
	XrJiVW5DhhFcdUCcrekTR9HseUB44x+4xxGBNz/eyDs1O7nv6rxRGt7H/O0h4Zt5ceNMg9q15Y5
	v3HUfBPS38N/4xJRtHu34jvm1k9W0MrB2sf2n
X-Gm-Gg: AR+sD104RyKGM/YEH1MqaNSM96jaDYEugpIlaf0dYq1rziFihL6v8uSwQnvanFrP4dk
	h6z0kSljbwd/UjqmKr5Wl+HMLrZK6K5SIOrPoITudIMMCCNo1Z+8fSOsN8PZeOaxeteAVqvZjAk
	4bPJ/JgDFf8+QkZcHHrbPvyzkoKyYrYZcad47mysHEq+gWJuQzMXl/rbgo0oqUoXyma/nTEItc8
	MshlAb8xbWakUD6LxFRmVrVT4ts9PWqNxxz7v+4Pi3y7VNBYWsPGdmwpnwebc0Q4dz88XG/+f2X
	WTTUPwwW2zF00Z4k7ZwBCaaVzg+kuFxElzT4/j3b2ghlLaEzIoGLfk0zy30g2SeZFYi2HjbbJDV
	lvlPvcLTeU4MbqlVwwXHzgJQMdiQU
X-Received: by 2002:a53:e64b:0:b0:66c:c1d7:4c5b with SMTP id
 956f58d0204a3-66ce49d807cmr8829323d50.16.1787667667341; Tue, 25 Aug 2026
 07:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOZc4kvLV-FPcGX87FqjSKsXxa885Gk9MfD7NtapoaqhCB7uLA@mail.gmail.com>
In-Reply-To: <CAOZc4kvLV-FPcGX87FqjSKsXxa885Gk9MfD7NtapoaqhCB7uLA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Aug 2026 10:20:54 -0400
X-Gm-Features: AcwNN1UCoWDyfw-W8-uWtimVKD1pIv_kN8-Cq43uaZuVc1jr_G5zTZImocucoQI
Message-ID: <CABBYNZKM9O6nDqZ6KbA5gzUiSmjpb5u4JL+9UwB7qequSBwkzQ@mail.gmail.com>
Subject: Re: Heap buffer overflow in adv_monitor.c via uint8_t truncation of
 pattern count
To: BUGPWN <vuln.bugpwn@gmail.com>
Cc: security@bluez.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 25, 2026 at 7:38=E2=80=AFAM BUGPWN <vuln.bugpwn@gmail.com> wrot=
e:
>
> Summary
> -------
>
> bluetoothd contains a heap buffer overflow (CWE-131 / CWE-190, incorrect
> size calculation via integer truncation) in
> merged_pattern_send_add_pattern() and merged_pattern_send_add_pattern_rss=
i()
> (src/adv_monitor.c). Any local, unprivileged D-Bus client can trigger thi=
s
> against a root-owned bluetoothd process by registering a malicious
> org.bluez.AdvertisementMonitor1 object with a crafted number of Patterns
> entries; no special D-Bus permission is required (see "Reachability"
> below).
>
> Confirmed against current git HEAD:
>   commit efd216fe280ba5dd38d1b6084f64784bf1328731 (2026-07-16)

Nope, one would need to enable experimental in order to access
org.bluez.AdvertisingMonitor1, so while the problem exists, you will
need root to enable experimental.

Btw, adding linux-bluetooth like made this public in the process.

>
> Vulnerable code
> ---------------
>
> src/adv_monitor.c:1105-1137 (merged_pattern_send_add_pattern; the RSSI
> variant merged_pattern_send_add_pattern_rssi at :1140-1180 has the same
> bug with a different struct):
>
>     static bool merged_pattern_send_add_pattern(
>                 struct adv_monitor_merged_pattern *merged_pattern)
>     {
>         struct mgmt_cp_add_adv_monitor *cp =3D NULL;
>         uint8_t pattern_count, cp_len;
>         const struct queue_entry *e;
>         bool success =3D true;
>
>         pattern_count =3D queue_length(merged_pattern->patterns);
>         cp_len =3D sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_p=
attern);
>
>         cp =3D malloc0(cp_len);
>         if (!cp)
>             return false;
>
>         for (e =3D queue_get_entries(merged_pattern->patterns); e; e =3D =
e->next) {
>             struct bt_ad_pattern *pattern =3D e->data;
>
>             memcpy(&cp->patterns[cp->pattern_count++], pattern,
>                                 sizeof(*pattern));
>         }
>         ...
>
> queue_length() (src/shared/queue.h:52) returns an unsigned int: the real,
> untruncated number of patterns. The truncation happens only at the
> assignment `pattern_count =3D queue_length(...)` into the uint8_t local.
> `cp_len` is computed from that already-truncated `pattern_count`, but the
> for-loop that follows is bounded by the real linked-list traversal
> (e =3D e->next), independent of `cp_len`/`pattern_count`; it always write=
s
> one 34-byte struct mgmt_adv_pattern per real entry in the queue.
>
> lib/bluetooth/mgmt.h:
>   struct mgmt_adv_pattern { uint8_t ad_type, offset, length; uint8_t
>     value[31]; } __packed;              -> sizeof =3D=3D 34
>   struct mgmt_cp_add_adv_monitor { uint8_t pattern_count; struct
>     mgmt_adv_pattern patterns[0]; } __packed;   -> sizeof =3D=3D 1
>
> With exactly N =3D 256 * k patterns (any k >=3D 1): pattern_count =3D N m=
od 256
> =3D=3D 0, so cp_len =3D 1 + 0*34 =3D 1. malloc0(1) allocates a 1-byte buf=
fer, while
> the loop writes all N real entries (N * 34 bytes) into it; with N=3D256,
> that is an 8704-byte heap write past a 1-byte allocation, with
> attacker-controlled content.
>
> parse_patterns() (src/adv_monitor.c:888-967, read in full) places no uppe=
r
> bound on the number of entries accepted in the D-Bus "Patterns" array
> property; it never checks the count against
> manager->max_num_patterns (which is read from the kernel via
> MGMT_OP_READ_ADV_MONITOR_FEATURES but never used for validation).
>
>
> Reachability (local, unprivileged)
> -----------------------------------
>
> src/bluetooth.conf (installed as
> /usr/share/dbus-1/system.d/bluetooth.conf on a typical distro; verified
> identical on our test system) contains:
>
>     <policy context=3D"default">
>         <allow send_destination=3D"org.bluez"/>
>     </policy>
>
> This is the fallback policy applied to any D-Bus connection that isn't
> root; it permits calling any method on org.bluez, including
> org.bluez.AdvertisementMonitorManager1.RegisterMonitor(). bluetoothd runs
> as root. So this is a heap-corruption primitive in a root daemon,
> triggerable by any local, unprivileged user, not merely a DoS.
>
> Call chain from the D-Bus entry point to the vulnerable code (confirmed
> via gdb backtrace on a real crash, see "Proof of concept"):
>
>   gdbus/client.c: get_managed_objects_reply() -> parse_managed_objects()
>   -> parse_interfaces() -> parse_properties() -> proxy_added()
>   -> src/adv_monitor.c: monitor_proxy_added_cb() (:1240)
>   -> merged_pattern_add() (:368)
>   -> merged_pattern_send_add() (:1187)
>   -> merged_pattern_send_add_pattern() (:1105), the vulnerable function
>
> A malicious local process registers an AdvertisementMonitorManager1 app
> (RegisterMonitor), exposes a single org.bluez.AdvertisementMonitor1 objec=
t
> under it with Type=3D"or_patterns" and a Patterns array of 256 entries
> (each just {offset=3D0, ad_type=3D0x09, value=3D[1 byte]}, the minimum
> bt_ad_pattern_new() (src/shared/ad.c:1304-1327) accepts; it rejects
> len=3D=3D0). bluetoothd reads this back via GetManagedObjects()/
> Properties.GetAll() as part of handling RegisterMonitor(), reaching the
> vulnerable code without any further action from the caller.
>
> Note: AdvertisementMonitorManager1 is an "[experimental]" D-Bus interface=
;
> it is only exposed when bluetoothd is started with -E/--experimental.
> We have not checked how commonly distros enable this by default; several
> do ship it enabled (it backs bluetoothctl's `monitor` submenu and is used
> for BLE presence/proximity features).

Ok, it is called experimental for a reason. I'm not sure why anyone
would risk shipping with it enabled, and the fact that bluetoothctl
has a menu for it doesn't mean it should be enabled either. Also if it
is distro-specific, then the distro itself would be vulnerable, not
the stack. It is still a bug even behind experimental, but since it's
only reachable after enabling experimental, not stating this upfront
is very misleading.

>
> Proof of concept
> -----------------
>
> We compiled bluetoothd directly from this repository (unmodified sources;
> ./bootstrap && ./configure --disable-systemd --disable-udev
> --disable-obex --disable-client --disable-cups --disable-manpages
> --disable-datafiles && make) and drove the attack from a small Python
> script (adapted from the repo's own test/example-adv-monitor, using the
> async reply_handler/error_handler D-Bus API: a synchronous
> RegisterMonitor() call deadlocks, since bluetoothd calls back into the
> caller's own GetManagedObjects() before replying), run as a normal
> non-root user against bluetoothd running as root via a virtual HCI
> controller (/dev/vhci) for a test adapter.
>
> 1. Built with AddressSanitizer:
>
>    =3D=3D174053=3D=3DERROR: AddressSanitizer: heap-buffer-overflow ...
>    WRITE of size 34 at ... thread T0
>        ...
>    allocated by thread T0 here:
>        #0 calloc
>        #1 merged_pattern_send_add_pattern src/adv_monitor.c:1116
>        #2 merged_pattern_send_add src/adv_monitor.c:1187
>        #3 merged_pattern_add src/adv_monitor.c:368
>        #4 monitor_proxy_added_cb src/adv_monitor.c:1240
>        #5 proxy_added gdbus/client.c:411
>        #6 parse_properties gdbus/client.c:1201
>        #7 parse_interfaces gdbus/client.c:1226
>        #8 parse_managed_objects gdbus/client.c:1318
>        #9 get_managed_objects_reply gdbus/client.c:1339
>
>    0x7b4822642b91 is located 0 bytes after 1-byte region
>    [0x7b4822642b90,0x7b4822642b91)
>    SUMMARY: AddressSanitizer: heap-buffer-overflow src/adv_monitor.c:1123
>    in merged_pattern_send_add_pattern
>
>    ASan confirms the exact 1-byte allocation predicted above, with the
>    overflow detected at the very first out-of-bounds byte. bluetoothd
>    terminates via SIGABRT (exit 134).
>
> 2. Built without ASan, with realistic distro hardening flags only
>    (-O2 -fstack-protector-strong -D_FORTIFY_SOURCE=3D2 -Wl,-z,relro,-z,no=
w
>    -pie), to observe the real (uninstrumented) glibc heap corruption. We
>    ran the identical attack (256 patterns) three times and captured core
>    dumps; each run produced a DIFFERENT crash signature:
>
>    Run 1: SIGSEGV, inside the loop itself (memcpy, adv_monitor.c:1123).
>      gdb shows cp->pattern_count =3D=3D 0x60 (96) at crash time: 96 write=
s
>      (~3.3 KB) succeeded before the overflow reached and corrupted an
>      adjacent struct queue_entry {void *data; struct queue_entry *next;}
>      (16 bytes, src/shared/queue.c) belonging to the SAME queue the loop
>      is iterating; `p *e` shows {data =3D 0x0, next =3D 0x900000000000000=
},
>      i.e. the node's own `data` pointer got zeroed and `next` was
>      overwritten with attacker-supplied bytes, immediately dereferenced
>      by the loop's own `e =3D e->next`.
>
>    Run 2: SIGABRT. The loop completes all 256 writes without crashing
>      (reaches adv_monitor.c:1127, mgmt_send()); the crash happens later,
>      inside sysmalloc() (malloc.c:2610) during an unrelated calloc(40)
>      for a GLib IO watch: "Fatal glibc error: ... assertion failed" on
>      the heap's top chunk: the overflow had corrupted the top-chunk
>      size sentinel.
>
>    Run 3: SIGABRT, again after the loop completes, this time inside
>      _int_malloc() (malloc.c:4211) on an unrelated malloc(7): "malloc():
>      invalid size (unsorted)": a corrupted size field on a chunk in the
>      unsorted bin.
>
>    All three are genuine glibc heap-metadata/application-pointer
>    corruption, not simply walking off into unmapped memory. The heap
>    layout at the moment of the vulnerable allocation is evidently not
>    fully deterministic run-to-run for an identical payload (likely due
>    to concurrent D-Bus/GLib activity affecting what else is live on the
>    heap), which we note as a data point for your own severity assessment.
>    We have not attempted to go beyond this characterization to build a
>    working exploit (no attempt made to control heap layout, target a
>    specific security-relevant object, or defeat ASLR).
>
> We're happy to share the PoC scripts/harness; let us know your preferred
> format given your no-attachments preference.
>
>
> Impact
> ------
>
> - Reliable local crash of bluetoothd (a root-owned daemon),
> triggerable via a single D-Bus call
>   by any local, unprivileged user, with no special permission,
> capability, or prior interaction
>   with Bluetooth hardware required: src/bluetooth.conf's default D-Bus
> policy allows this to any
>   local user.

Not true; it first requires enabling experimental, which requires root
privileges.

> - Genuine heap-memory corruption on an uninstrumented build, not
> merely a crash on unmapped
>   memory. Confirmed across 3 test runs, each hitting a different
> corruption path (an adjacent
>   application-level linked-list node, the heap's top-chunk sentinel,
> and an unsorted-bin chunk's
>   size field; see "Proof of concept" above). The overflow content is
> attacker-controlled.
>
>
> Next step we have not taken but could: attempt to control the heap
> layout (e.g. by pre-allocating
> same-size objects before triggering the overflow) so the corruption
> lands on a chosen,
> security-relevant structure instead of our own throwaway queue_entry
> nodes, to determine whether
> this can be turned into a controlled write primitive rather than a crash.
>
> Reporter
> --------
>
> BUG|PWN & Sadoc ADONON
> vuln.bugpwn@gmail.com
>
>
> --
> Vuln @ BUG|PWN Team
> Email: vuln.bugpwn@gmail.com
> Twitter
> Linkedin
>


--=20
Luiz Augusto von Dentz
