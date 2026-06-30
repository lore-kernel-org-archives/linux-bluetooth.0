Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64A149DF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848131; cv=pass; b=jXeUhemPr1muoo1MeiJE1Ea9ghUk1IhLXeq1UUG84+lZB8Nxkw0s0WqQfe0U1ezSaTERhYOQU/JscMaaBTJbtKlV2pUzoWNtQ8dEnZkSZSmR7ARu4fViq3UjTkra1cv9D9+3ReEhVUpmxPfq2VqT7Kw9AAhFvpo2I7kKUeAVPRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848131; c=relaxed/simple;
	bh=P+fEJEIZPyP+xOSvKPSY1utsc9fEx4yFDskO55ILDM0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NnLUAGVSVfRaI+vUyvgZg8pWL6ZlcXdjwOu2v6Q+b60+tk4iqS+AmXyNPZpUeyfu9I25G8mO9DPlpiNwmgBp6DBZZpiK+K6d77j08Zscol5OcaDtwyV+DkBKjCzlSM2VX7XlUThF+8kv7Qxk4QinS6A4dkuN/6lXLxuIU8beL0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSBn1lPc; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSBn1lPc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so39080005e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782848128; cv=none;
        d=google.com; s=arc-20260327;
        b=Y93R4ZhUmEZxvjNzks/eKq8tbRf6yl3ZshvZUILSKg9spV9Kq9qyyFFxk+GdCnpeCX
         LMgFvWuWrD1jZuaDfiw+cAGGv6VrXS9G+crgFeEmZw2kk9L5Zpf9JWPTP/XDKwgGIjEq
         7ilHPRv8Zi4DehG+k9DUgi7YvI8ioK2jZsJeMHpu3M1msA9HzHVp4RBTeCS9KEmQcFQE
         qGqYWbY57Ea6P0B8ansjYaAR8NIjag2rFaaUfOz+aJZISmzGmxyUY0Dowk1OkacBw/yi
         vTprskQ7QW5nLh0YjJYZZqiNXYD8BO8HKzDhjib1nD5eM2RvspqbwcsFMlxob0KVc+HH
         ggqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CzpTZr480p7V0MaUtJeFZBHfP22/xOys/yE+npjBWdM=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=stbzPozNKjBY2mEn6DuW3Y/fmUO+H+sv+kBAUw9eDykjMhgedtOPWo7x24aHeI+CmV
         RjiV6qelCn9qm+jNzP4vdQFovBgP2eP52SH8kwwBty/XsFH07WboYnIKvhoW8LnDOcYo
         cUduLuB5xzWnf3GVCxyu2cZEMi/tEYwBfhVJM8ivEUYXNDfPO8mUNz9tRnx6bjzfmnP+
         nMWXITcuEjQvEg0JY2eWeZv2ey7d8WfRdKTqjR2xGzp8NS2+IWZnVfDv+lF0uChQCNcs
         DVhRxvtwWVezoO6lGDZ8WrFgI4CVpaoNJLChxi+KGRK0uPWJz1qlQBmgL5bQl5ZGjzXx
         tTdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782848128; x=1783452928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CzpTZr480p7V0MaUtJeFZBHfP22/xOys/yE+npjBWdM=;
        b=dSBn1lPcWrg3I4S/fEJJeguDN+cRAg+OQHgxuKkktW5Toy4Fr9sf/GZ2I00X1hk890
         PwHKa9/lC5WqrSFMpf7dBXi21oQMK608hZO6UQ5DfTaq8hAwLhvELmsK8e2dh0aDcMO8
         7n5Z+PjP4n23dwGgDtp5B8hr/9PAb28cUyIfNgDVI2P3cMhfo9Fwps0+lvk4zw/KLseA
         UES9uxHB/WN8lu2GsxGLYS9WLKbuEIX9f5GwBn07NXJ6S6TiokpqVLpUEburoZCvvJQ5
         61Dd2Dow8SxWpPgS9f8Bgimt4EFCpt6LXpmt9W+oq2psBvI1byLq2ScuF1iCQYp/nhqC
         VvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848128; x=1783452928;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzpTZr480p7V0MaUtJeFZBHfP22/xOys/yE+npjBWdM=;
        b=skiGJXxDbhTDJL5cB5CAI5GHiDQTh3lXBSQoHg4yoDPTUB3pxEUvWxqBVgvIa34qGc
         gxfvC4SReXMSHvr/HI1mm7DhwfUar2ZLCNf0tNo6vuV7A/tK7c8yNzhj80TF+9q9QKVB
         fAERbaM4pkltrB+wswjleJdpPcxtOE/kecaThpWljpA/svp+T9w+fQfPJ59WfUx4PpxB
         xs5Dpc3w2HFyu7ahWSssMcwC+z9U9kTDs5uSIpSb3GIVUPmqqLCec/AYaQgzFOZ+u6pp
         MiZKi7nq3CEQfD7cVpl4IsM+wknMWlqV6+HnXZLCeRrZBHRDYxCB0CfxxqbBrv4PXs3S
         nWiQ==
X-Gm-Message-State: AOJu0YyvdZXCRZysku3+mMXmCjZr6L3aChIHPU0PvpGlUlIy7R5mnOMj
	Sb0ezEIeEaUj1MVvraEolLpV6aQZcOb8oNFeA66gMtVh1eg+aoolsGrWRehHxa5Vj2ZxWNBitmp
	Tu9VvVCb84RDbRXRk12DqT4KYVJr1QNQ=
X-Gm-Gg: AfdE7cnGlkDqLeterbrbwm3Fd8cj/+HZD8Y4cLy2VnQbhOdxAhzEf+gjzI97sGPrkbe
	GTPu6va/Ux2PRnQlHC/F+QcSPUo3oHGz/4F30fWFx2JMOGZvnCUlAD1dG4/v+iMn7suHjK/YJTn
	mFzRCZjgFmYttwW0jM7EscPj0n4gPHMTuxTQwWPvn3i+HLR72j/xobQV8p/qcH3Kj6f1EOBVkmw
	PRDEEvBa5tdov/lnCTYIein0zNxXJ6d/CYeROjrUk5RdK9Ga9Eda9gvGD+RK5Q4ImqJNNi1SU5E
	54Xo9wZoyea4PQ==
X-Received: by 2002:a05:600c:8889:10b0:493:bf84:53d8 with SMTP id
 5b1f17b1804b1-493bf84541amr1471755e9.9.1782848127576; Tue, 30 Jun 2026
 12:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: LocalHost <localhost.detect@gmail.com>
Date: Wed, 1 Jul 2026 04:35:15 +0900
X-Gm-Features: AVVi8Cfv9feFlRKQLYxQa27yYRhABoj62IknmbSWI6Z9_GYezTRkdqQ4jxkLGa8
Message-ID: <CAOpx92cQMiAR2BX5UeDdF5F8nqbkFAgo0yihDo+PVjobYVmTVw@mail.gmail.com>
Subject: Bluetooth: ISO: validate fragment length in ISO_END reassembly path
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a missing length bounds check in the ISO_END reassembly branch
of iso_recv() that allows a kernel crash (DoS) via crafted HCI ISO
fragments.

The initial candidate was identified using a custom AI-assisted code
analysis tool I developed. All subsequent verification, data-flow
tracing, guard analysis, and impact assessment were performed manually
by reviewing the source code.

Affected: net/bluetooth/iso.c
Impact: remote/adjacent-triggerable kernel crash (DoS). This is NOT
controlled memory corruption -- see "Impact" below.

SUMMARY

iso_recv() reassembles fragmented HCI ISO data frames into a
per-connection buffer conn->rx_skb sized to the total frame length
declared in the ISO_START header. The ISO_CONT branch validates each
fragment against the remaining buffer capacity (conn->rx_len); the
sibling ISO_END branch does not. An ISO_END fragment whose length
exceeds conn->rx_len reaches skb_put() with an oversized length,
tripping skb_over_panic() (kernel BUG/panic) -- a denial of service.

ROOT CAUSE

In net/bluetooth/iso.c, the ISO_START branch allocates the reassembly
skb to the declared total length and records the remaining capacity:

```
conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);   /* iso.c:2594 */
...
conn->rx_len = len - skb->len;                   /* iso.c:2602 */
```

The ISO_CONT branch correctly rejects an oversized fragment before
appending it:

```
case ISO_CONT:
    ...
    if (skb->len > conn->rx_len) {               /* iso.c:2622 */
        BT_ERR("Fragment is too long (len %d, expected %d)", ...);
        kfree_skb(conn->rx_skb);
        conn->rx_skb = NULL;
        conn->rx_len = 0;
        goto drop;
    }
    skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
                              skb->len);
    conn->rx_len -= skb->len;
    break;
```

The sibling ISO_END branch is missing the equivalent
skb->len > conn->rx_len guard -- it only checks for a zero rx_len:

```
case ISO_END:
    if (!conn->rx_len) {                         /* iso.c:2637 */
        BT_ERR("Unexpected end frame (len %d)", skb->len);
        goto drop;
    }

    skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
                              skb->len);          /* iso.c:2642 */
    conn->rx_len -= skb->len;                     /* iso.c:2644 */
    ...
```

If an ISO_END fragment arrives with skb->len > conn->rx_len (i.e.
larger than the remaining tailroom of rx_skb), skb_put(conn->rx_skb,
skb->len) advances the tail past the end of the allocation. skb_put()
detects skb->tail > skb->end and calls skb_over_panic(), which BUG()s.

REACHABILITY

pb is derived from hci_iso_flags_pb(flags) (iso.c:2524) and the
fragment length from the ISO data header. A peer that supplies HCI ISO
data -- a malicious/compromised controller, or an over-the-air
broadcaster to a host performing broadcast ISO/BIS sync -- can send:

1. ISO_START declaring a small total length (e.g. 16), with a short
first fragment, so rx_skb is allocated small and rx_len is small.
2. ISO_END with skb->len greater than the remaining rx_len.

The ISO_END branch appends without bounds-checking, skb_put() fires
skb_over_panic(), kernel panics.

The practical attack surface depends on how aggressively the local
controller validates incoming ISO PDU segmentation before forwarding
to the host. A compromised controller (e.g. malicious USB dongle
firmware) can trivially set the PB flag and fragment length. For a
purely over-the-air attacker, reachability depends on the controller
passing fragments through without re-validating their lengths --
common in low-cost BIS receivers, and consistent with the threat model
of prior BlueZ ISO/L2CAP issues.

IMPACT (deliberately not overstated)

The reachable, reliable outcome is a kernel crash (DoS):

- For any ISO_END length that exceeds the skb's true tailroom
(skb->end), skb_put() calls skb_over_panic() -> BUG() BEFORE the
skb_copy_from_linear_data() memcpy executes (skb_put() is fully
evaluated before its return value is passed to the copy). The result
is a panic, not an attacker-controlled write.
- This is NOT a controlled heap overflow / RCE primitive: reaching the
adjacent slab object requires skb->tail > skb->end, which is exactly
the condition skb_over_panic() traps. The two are mutually exclusive
-- the panic always wins.
- The conn->rx_len -= skb->len line would underflow the u32 counter,
but it sits after the skb_put() panic and is therefore unreachable
in the overflow case (noted only for completeness, not as additional
impact).

A note on PoCs circulating for this issue: an ASan model that
re-implements skb_put() without its tail > end check will report an
out-of-bounds write. That is an artifact of the model; the real kernel
skb_put() panics first. The honest impact is remote/adjacent-
triggerable DoS.

SUGGESTED FIX

Mirror the ISO_CONT guard in the ISO_END branch:

```
case ISO_END:
    if (!conn->rx_len) {
        BT_ERR("Unexpected end frame (len %d)", skb->len);
        goto drop;
    }
```

- if (skb->len > conn->rx_len) {
- `BT_ERR("End fragment is too long (len %d, expected %d)",`
- `skb->len, conn->rx_len);`
- `kfree_skb(conn->rx_skb);`
- `conn->rx_skb = NULL;`
- `conn->rx_len = 0;`
- `goto drop;`
- }

    skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
    skb->len);
    conn->rx_len -= skb->len;


A zero-length ISO_END fragment is not an out-of-bounds case (skb_put
with size 0 is a no-op and iso_recv() is invoked once per packet, so
there is no loop), but it leaves conn->rx_skb/conn->rx_len in an
unterminated state. If preferred, the guard can also cover it:
if (!skb->len || skb->len > conn->rx_len).

NOTES

- Line numbers are from the current net/bluetooth tree; approximate.
- Discovered via AI-assisted code analysis; the data-flow chain
(hci_isodata_packet -> iso_recv -> ISO_END), the ISO_CONT/ISO_END
asymmetry, and the skb_put()/skb_over_panic() behavior were
verified manually.
- A reproducer (ASan model) is available upon request.

Thanks.
