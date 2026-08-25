Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71443955EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657929; cv=pass; b=ehM6abXJIi0OTNznYfNJPHQLWh6YCGBXasRBDGP64dzCyBuiiqezZiKY7j436j1lho8zgQ4G10qyBkKVzfx2HaMfwsnr+xBBjV+UbxTs6pz23Bgb8yxwtVH2VjPenKuY6sjAQsIKkdSbsR2d18NnBBfWDOQTCjfw5TQVio0F/w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657929; c=relaxed/simple;
	bh=TtSlciKWHuqUMm/HbLYaFdBHSg88MuBBRuFp7PXaDTk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CAaKOTxTUSvi5AbhwWh4ItXsZ1LZYR99UFFJ0famhNUegAcCVKNlnjnGyh5+Pxx2AiPFC9P06q4QobQDvtb9gP1sGhBwRjx9zaX9pzgZW7lIObzg8vRGB05+xH86MM4Ntq0HVhTtMRXEHoXwOXrci/Up/Jrf1ZTkUME2Ajvf/oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osF7tjWw; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osF7tjWw"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-77bf3334d14so2172324137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 04:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787657927; cv=none;
        d=google.com; s=arc-20260327;
        b=XIwnlTX6Xtm0QgCnvCd48DuNfoU7RBoUG2hpRrkQ8hjCPVLsa7Ik3YCCarxngYQ1Rz
         WuQfxLy1mZsT8a93a3cmpt4m/7Ki6UGPu9k2Kl4zYoP2nJtJlmaU5WJ4tQ3NvNwLm1K4
         AykVW9Qgj24kUh+iRX8XAhOsfyt2Tu11SSbFLvIviSVPJzWCZ6WN+v1Fmd9TGztxkjSD
         3UlZkw9ebCScEq/Mvd7W+6Jkmt84KE6AFlWNhjpB9OO1h7nXI7cIxqwV9gSY6+BhXv++
         wM/j415hkwlMwk52Zzlk1/pyuCX72AtKnflDfMGoI8A5jGb3tZbD2orB6CIip69CL3G7
         1auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7RbIZZhDiMllASc+8FVsq+X1SweTqb2zXsXr2qINov8=;
        fh=9ttIwnCQFfOteE4frefQDlDgxEJxCpDm2t5HCB2pVhA=;
        b=GAKj1s5ztx7ibSIQVpzFjtKUIr2MirJWb9aMJjJik5ghBZK3NsARVx0T5EhD3MBlgG
         I2jIoaIM16BhmaBIMlGFKs1WOn61YumXnOZvZiOh2W0bdEqV8ZwHuCPoThsc58SFnFlV
         mscMXTtsbGxiRVFamEPTajiDGFZpENCvZDHW540jXG9d83DdLbLLnEEjnKtpDTJtFc4R
         6DNkqe8pEt8Sl+h96T10gTj9/Npw1OosR7EbRO366B7cEXJx37JjKFNj2DmWSJtgSofG
         A4d9tQvBgasqPztvPwFvYTjaRjN4VvGP+3kJtpLoSWCwHoGkxq55A/dVBr7jfJfv3nj6
         u+Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657927; x=1788262727; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RbIZZhDiMllASc+8FVsq+X1SweTqb2zXsXr2qINov8=;
        b=osF7tjWwEpoKWS1TQ0K0CpGu25GPaMwU7RN12pKjDARoYATH70hh4+VgnxULwSJQWS
         jtXW9GSYpzZNHNrTVsrPPQNn+OBiHTBTOqBjVH+9ZzjPouNCZ3t/ezxOyDmxrFlNqnUz
         Asb27IIV6RqTn5LimJbXxMpw242rgORxFZbemsZde0RV1Jzks/dY1xYbaOJCjuN5i5IN
         zgM3VcSXxdJ/wr8v4pnkcXXIpw8iKjRIpAgeAh3b16JMO1Gs1ocUOR71dcr3AmexUIq1
         NPAv4yk9O+ix5yQZf3CN/U3V5snvTrlprqiPxxJmyNwYnpxbkdTjyyisKIB6PwN+n5jL
         ufvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657927; x=1788262727;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7RbIZZhDiMllASc+8FVsq+X1SweTqb2zXsXr2qINov8=;
        b=nr1hVkjArqpZPdP/0qniFHEniLx1f4OTstke7vCOHnF6/BAiE51Fm/ut5nNj459shP
         ZzuISK8Pg8WTtkbXykLRuxNay3auqmOwQpRatH6GzAauHR25TGbT8UEvU33O57JzPjcq
         vXMXYSZrWYJMA96MNEE1uDKNtoyS+mJQr6YdzUwnZ+5KW+/ZsSsvOBoPNdybyQesvrr9
         w5z2pSZXVuFr73O3FYFjjaX6aNeF3m4yG5gUkSuKz1Rk01hwH+DUik4T2NPip4oKeZfW
         e00EJ4cJ+0/17VHwjdzeHIfXa/SkBIprzQGH3BCnxH/IXQ570rowEeiqKzA5L/YzzbhB
         DtHA==
X-Gm-Message-State: AFuF++lQsCWz7b84vhutOQQbYwiVjyyjPGdIU2IUtoViFDeuKnS1dkkS
	clMGX8izLqWw3/56AabU/WTECn/jFXUCRyoBlphby67KqOH7z/YhYWH0XBTTi+h+3d7B86vYlkV
	/Ibrkx1PU1cjXMJ/ZdJTgjB3MteotMEBEeAtM
X-Gm-Gg: AR+sD12PXvMO7w/cH+pjRLXcwFuq8KUip5+bKvJKOqBJq0ahNpvEVLB9xGgEhXdZgYo
	5vQeMuTFsQJZegG7hr5sCzO61IiMkP3iMycE7PgpKtP1oZe6HDBe30L3XvwzMWxDSFKQ+JTf+y3
	lttxEJhaDfXM4ise4DLDBX0A/oPzAwGgxhDosZGJNpNoGEGZ6EOnbcsc2/1SJ5U2XHfS6l2QnEI
	1RMiQU9UccWHQo6K9V+Ygln2HJDQmTluVrPZJfhgEQ81/3d0Q4UWkEpxF0j1y+68XM9XBmbQnIH
	zEy2+kr8vmtaF8KdzswUucASbDKxdK6ru5GqRqUMWqx6Y3U38Wc9yxYUahTGvBK2yqIv+LN9lbT
	+xUKrKg66oIleWlGYAyp3ncqkBn5D5b/1
X-Received: by 2002:a05:6102:3fa8:b0:77b:b14e:b6d7 with SMTP id
 ada2fe7eead31-77bd1e9b8dfmr9481237137.7.1787657926518; Tue, 25 Aug 2026
 04:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: BUGPWN <vuln.bugpwn@gmail.com>
Date: Tue, 25 Aug 2026 12:38:35 +0100
X-Gm-Features: AcwNN1V8Jc0L_rSmpk4dPIv7atVdCf74Js6WfPd1zNmF2ttWdouNISVR67PuDlU
Message-ID: <CAOZc4kvLV-FPcGX87FqjSKsXxa885Gk9MfD7NtapoaqhCB7uLA@mail.gmail.com>
Subject: Heap buffer overflow in adv_monitor.c via uint8_t truncation of
 pattern count
To: security@bluez.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary
-------

bluetoothd contains a heap buffer overflow (CWE-131 / CWE-190, incorrect
size calculation via integer truncation) in
merged_pattern_send_add_pattern() and merged_pattern_send_add_pattern_rssi()
(src/adv_monitor.c). Any local, unprivileged D-Bus client can trigger this
against a root-owned bluetoothd process by registering a malicious
org.bluez.AdvertisementMonitor1 object with a crafted number of Patterns
entries; no special D-Bus permission is required (see "Reachability"
below).

Confirmed against current git HEAD:
  commit efd216fe280ba5dd38d1b6084f64784bf1328731 (2026-07-16)


Vulnerable code
---------------

src/adv_monitor.c:1105-1137 (merged_pattern_send_add_pattern; the RSSI
variant merged_pattern_send_add_pattern_rssi at :1140-1180 has the same
bug with a different struct):

    static bool merged_pattern_send_add_pattern(
                struct adv_monitor_merged_pattern *merged_pattern)
    {
        struct mgmt_cp_add_adv_monitor *cp = NULL;
        uint8_t pattern_count, cp_len;
        const struct queue_entry *e;
        bool success = true;

        pattern_count = queue_length(merged_pattern->patterns);
        cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);

        cp = malloc0(cp_len);
        if (!cp)
            return false;

        for (e = queue_get_entries(merged_pattern->patterns); e; e = e->next) {
            struct bt_ad_pattern *pattern = e->data;

            memcpy(&cp->patterns[cp->pattern_count++], pattern,
                                sizeof(*pattern));
        }
        ...

queue_length() (src/shared/queue.h:52) returns an unsigned int: the real,
untruncated number of patterns. The truncation happens only at the
assignment `pattern_count = queue_length(...)` into the uint8_t local.
`cp_len` is computed from that already-truncated `pattern_count`, but the
for-loop that follows is bounded by the real linked-list traversal
(e = e->next), independent of `cp_len`/`pattern_count`; it always writes
one 34-byte struct mgmt_adv_pattern per real entry in the queue.

lib/bluetooth/mgmt.h:
  struct mgmt_adv_pattern { uint8_t ad_type, offset, length; uint8_t
    value[31]; } __packed;              -> sizeof == 34
  struct mgmt_cp_add_adv_monitor { uint8_t pattern_count; struct
    mgmt_adv_pattern patterns[0]; } __packed;   -> sizeof == 1

With exactly N = 256 * k patterns (any k >= 1): pattern_count = N mod 256
== 0, so cp_len = 1 + 0*34 = 1. malloc0(1) allocates a 1-byte buffer, while
the loop writes all N real entries (N * 34 bytes) into it; with N=256,
that is an 8704-byte heap write past a 1-byte allocation, with
attacker-controlled content.

parse_patterns() (src/adv_monitor.c:888-967, read in full) places no upper
bound on the number of entries accepted in the D-Bus "Patterns" array
property; it never checks the count against
manager->max_num_patterns (which is read from the kernel via
MGMT_OP_READ_ADV_MONITOR_FEATURES but never used for validation).


Reachability (local, unprivileged)
-----------------------------------

src/bluetooth.conf (installed as
/usr/share/dbus-1/system.d/bluetooth.conf on a typical distro; verified
identical on our test system) contains:

    <policy context="default">
        <allow send_destination="org.bluez"/>
    </policy>

This is the fallback policy applied to any D-Bus connection that isn't
root; it permits calling any method on org.bluez, including
org.bluez.AdvertisementMonitorManager1.RegisterMonitor(). bluetoothd runs
as root. So this is a heap-corruption primitive in a root daemon,
triggerable by any local, unprivileged user, not merely a DoS.

Call chain from the D-Bus entry point to the vulnerable code (confirmed
via gdb backtrace on a real crash, see "Proof of concept"):

  gdbus/client.c: get_managed_objects_reply() -> parse_managed_objects()
  -> parse_interfaces() -> parse_properties() -> proxy_added()
  -> src/adv_monitor.c: monitor_proxy_added_cb() (:1240)
  -> merged_pattern_add() (:368)
  -> merged_pattern_send_add() (:1187)
  -> merged_pattern_send_add_pattern() (:1105), the vulnerable function

A malicious local process registers an AdvertisementMonitorManager1 app
(RegisterMonitor), exposes a single org.bluez.AdvertisementMonitor1 object
under it with Type="or_patterns" and a Patterns array of 256 entries
(each just {offset=0, ad_type=0x09, value=[1 byte]}, the minimum
bt_ad_pattern_new() (src/shared/ad.c:1304-1327) accepts; it rejects
len==0). bluetoothd reads this back via GetManagedObjects()/
Properties.GetAll() as part of handling RegisterMonitor(), reaching the
vulnerable code without any further action from the caller.

Note: AdvertisementMonitorManager1 is an "[experimental]" D-Bus interface;
it is only exposed when bluetoothd is started with -E/--experimental.
We have not checked how commonly distros enable this by default; several
do ship it enabled (it backs bluetoothctl's `monitor` submenu and is used
for BLE presence/proximity features).


Proof of concept
-----------------

We compiled bluetoothd directly from this repository (unmodified sources;
./bootstrap && ./configure --disable-systemd --disable-udev
--disable-obex --disable-client --disable-cups --disable-manpages
--disable-datafiles && make) and drove the attack from a small Python
script (adapted from the repo's own test/example-adv-monitor, using the
async reply_handler/error_handler D-Bus API: a synchronous
RegisterMonitor() call deadlocks, since bluetoothd calls back into the
caller's own GetManagedObjects() before replying), run as a normal
non-root user against bluetoothd running as root via a virtual HCI
controller (/dev/vhci) for a test adapter.

1. Built with AddressSanitizer:

   ==174053==ERROR: AddressSanitizer: heap-buffer-overflow ...
   WRITE of size 34 at ... thread T0
       ...
   allocated by thread T0 here:
       #0 calloc
       #1 merged_pattern_send_add_pattern src/adv_monitor.c:1116
       #2 merged_pattern_send_add src/adv_monitor.c:1187
       #3 merged_pattern_add src/adv_monitor.c:368
       #4 monitor_proxy_added_cb src/adv_monitor.c:1240
       #5 proxy_added gdbus/client.c:411
       #6 parse_properties gdbus/client.c:1201
       #7 parse_interfaces gdbus/client.c:1226
       #8 parse_managed_objects gdbus/client.c:1318
       #9 get_managed_objects_reply gdbus/client.c:1339

   0x7b4822642b91 is located 0 bytes after 1-byte region
   [0x7b4822642b90,0x7b4822642b91)
   SUMMARY: AddressSanitizer: heap-buffer-overflow src/adv_monitor.c:1123
   in merged_pattern_send_add_pattern

   ASan confirms the exact 1-byte allocation predicted above, with the
   overflow detected at the very first out-of-bounds byte. bluetoothd
   terminates via SIGABRT (exit 134).

2. Built without ASan, with realistic distro hardening flags only
   (-O2 -fstack-protector-strong -D_FORTIFY_SOURCE=2 -Wl,-z,relro,-z,now
   -pie), to observe the real (uninstrumented) glibc heap corruption. We
   ran the identical attack (256 patterns) three times and captured core
   dumps; each run produced a DIFFERENT crash signature:

   Run 1: SIGSEGV, inside the loop itself (memcpy, adv_monitor.c:1123).
     gdb shows cp->pattern_count == 0x60 (96) at crash time: 96 writes
     (~3.3 KB) succeeded before the overflow reached and corrupted an
     adjacent struct queue_entry {void *data; struct queue_entry *next;}
     (16 bytes, src/shared/queue.c) belonging to the SAME queue the loop
     is iterating; `p *e` shows {data = 0x0, next = 0x900000000000000},
     i.e. the node's own `data` pointer got zeroed and `next` was
     overwritten with attacker-supplied bytes, immediately dereferenced
     by the loop's own `e = e->next`.

   Run 2: SIGABRT. The loop completes all 256 writes without crashing
     (reaches adv_monitor.c:1127, mgmt_send()); the crash happens later,
     inside sysmalloc() (malloc.c:2610) during an unrelated calloc(40)
     for a GLib IO watch: "Fatal glibc error: ... assertion failed" on
     the heap's top chunk: the overflow had corrupted the top-chunk
     size sentinel.

   Run 3: SIGABRT, again after the loop completes, this time inside
     _int_malloc() (malloc.c:4211) on an unrelated malloc(7): "malloc():
     invalid size (unsorted)": a corrupted size field on a chunk in the
     unsorted bin.

   All three are genuine glibc heap-metadata/application-pointer
   corruption, not simply walking off into unmapped memory. The heap
   layout at the moment of the vulnerable allocation is evidently not
   fully deterministic run-to-run for an identical payload (likely due
   to concurrent D-Bus/GLib activity affecting what else is live on the
   heap), which we note as a data point for your own severity assessment.
   We have not attempted to go beyond this characterization to build a
   working exploit (no attempt made to control heap layout, target a
   specific security-relevant object, or defeat ASLR).

We're happy to share the PoC scripts/harness; let us know your preferred
format given your no-attachments preference.


Impact
------

- Reliable local crash of bluetoothd (a root-owned daemon),
triggerable via a single D-Bus call
  by any local, unprivileged user, with no special permission,
capability, or prior interaction
  with Bluetooth hardware required: src/bluetooth.conf's default D-Bus
policy allows this to any
  local user.

- Genuine heap-memory corruption on an uninstrumented build, not
merely a crash on unmapped
  memory. Confirmed across 3 test runs, each hitting a different
corruption path (an adjacent
  application-level linked-list node, the heap's top-chunk sentinel,
and an unsorted-bin chunk's
  size field; see "Proof of concept" above). The overflow content is
attacker-controlled.


Next step we have not taken but could: attempt to control the heap
layout (e.g. by pre-allocating
same-size objects before triggering the overflow) so the corruption
lands on a chosen,
security-relevant structure instead of our own throwaway queue_entry
nodes, to determine whether
this can be turned into a controlled write primitive rather than a crash.

Reporter
--------

BUG|PWN & Sadoc ADONON
vuln.bugpwn@gmail.com


-- 
Vuln @ BUG|PWN Team
Email: vuln.bugpwn@gmail.com
Twitter
Linkedin
