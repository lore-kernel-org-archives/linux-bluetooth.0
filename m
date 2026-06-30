Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26B202F71
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848036; cv=pass; b=Ud6+9/ul/JUl0QSJt1WBukar7GqxE/6OZY+/4wK01lFm/fKMgko7wSQAtFUWV9yDIfVfRzkJGVGCK2KcWxp6VfRpef2KSlxVzJh5q4DUzmo31NP7vWQCxHjTUtC5+abSEwKNveGQNgEvLw+lsw6IEK3y00sOTW1rkHGqfxGW36w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848036; c=relaxed/simple;
	bh=RWpuP1HOANd3Mw9LUIgxvKsgox/WnpchLIpwxpd/rBQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=neEjak+v3gJ4czfIVFaxm2hKjwCBfWLvT8/pUWtydm32uXMo/9JAEeV7PrI3LxK2STOMtV1WrFZJjM9JHermHnVd8kHKyIc0GTxTpVd3L3qfJSl9ka1S8BvY6bdmSS54eWgLmahIO80Wb99R5BMD8dd78knDFxTpQTztNqlXruk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YF9S91kA; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF9S91kA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47248615e4dso3222713f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782848033; cv=none;
        d=google.com; s=arc-20260327;
        b=lJucYauOaQNhyZh2QgThFOXiVVVq+qDTHkFRr0Lil0Rv2wQWBMcVJTQzYuuo80cIxD
         xjGnpvcZGUYY4jlPizVgu6Gx3VTCn1FLy/UjeWrhlgJ4c/vAyWIZ9XQ9aylZ7q8tkInH
         9sGwwwDhzkKiWhzwy9SKfsR9H5/NSGDybgkMlV0GHfcnjiHKQ3vk9v7VbOZDvDk0M0Za
         3x9jZe5zVXet6p4ljarRo7DykjkdK2fXZiJPoLCD6czKKJxZy1b8tIsTZC3WQCdNJbWg
         ST+OKfYdNZMAUZQqbcmcBQEKLlhmFz2IrNwhfKe+X/iq9TnS3ytPGosIwMb+tYd+Zv2b
         yCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NUUH1p4sJ7WqPdD8mr/jyFqmyFX9fLUZS4OT3W1zTpg=;
        fh=v4Z3N2Htbr8NtGqMLkQjkIE/EbeUcf6lhEWEAm07n3g=;
        b=XnFqNiEEf3LIEKOmBzKI7MQukuZ2ms0pGJgTIUBMklEqh39yEy7mv4Op5kHTGI3shJ
         j7y9ffTzgSBiVL88ckENkh06NfeWc4jzzfScTrWEIcD052oWP5dqcPK8l9hEEgjIl8Ol
         ZQp3lcgGoEuZ9nmYJbLfT/xfqFo8DaCnIDfftB0gfp/EjHB1EU2/LekOudlrcclwxfGc
         WiknGl0p8B5ixAkBG7BKydlyPrD+eb1NG+O7+biGuUu9ORFMjTwPoihCTQPEjo+h6wII
         Qor5vBUBUiIEZWobJe5PCeg6HSvSM3cbgbOUhAEO+eMn+O6KNoImk8j3a/bU/fmZWC6B
         ipyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782848033; x=1783452833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NUUH1p4sJ7WqPdD8mr/jyFqmyFX9fLUZS4OT3W1zTpg=;
        b=YF9S91kAOUA8Yqv3TSXMGW/i2nu7D3eAQG73GsFQvs6czbeQMmlRIuXMWGAFaEfLup
         sG7ZvC0lPdNsNMKRVjfBiySP/nVnOssMdbqtqucv77AunDhlnPdOk9YN7DVcNmvxtQjm
         PUsXTsPeZCqs7hyBBJFVxpvy8eZlX+IWD/ZjS9/6Uar4tT/Qr2VJjivn1rW9q5LQg2kp
         iS7bL9sL+/BeC6RHDDG3v3gRCNtc8thMv9CUBt/JdGapWy9x+wGKG5Zu5ISLczMKxyK+
         ueBwuD1f2IHe0pzdf9DzNMNeGYnKRPz0mQv6hBJ4D2lBD7rszmE2p05CDvl4irB6gNOP
         cDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782848033; x=1783452833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUUH1p4sJ7WqPdD8mr/jyFqmyFX9fLUZS4OT3W1zTpg=;
        b=SHs8JlOzQVDpREWxwj03iV72aUc3YBb28YiVB7VFwUVzyT+td2hiNll2gtaxbvi6hc
         1culoivZjLiQITe7rLQWddrH1k/1V/aRqPGHyZt7EK3Skh+VGf0ADvn5eM1fpOBKPlkX
         CYgopZLQLt2SK3pe2kWQQDJUrP3gAwFWxNW9DXUE70Ysx2APNgiwyqO4rDgi81Xqdg6j
         kRedHnlbYxQjb2QF08XgJ58hlNtb6Xt3/GyzOZMOl0N417qEMgD0sYFjsp/I7Q59Shj6
         gmnj9jHJUiFKvLYeQpfZQi002NIeRH6x9GDVXKPNAVfIrDNbUZJtuF0KIlyfvjuQDvD5
         3wPA==
X-Gm-Message-State: AOJu0YwNP/w3p1rq4jAhg7pnJjSZyCil46mWqqMKY+UtWFSj1jYIgjTW
	xggLTXZfuK+DrEWTjAx6tg5x/5Msee6quz7LY1djyNlcKcPUZ6NBmjtn+FfuivrxTm0wWp3b2W9
	c4YLiRIlGVic2Vet6vy4IKDJloroTj4/P3/eTQorTwQ==
X-Gm-Gg: AfdE7clfVgy1tArtCA551RMwwJiG41DeuXfbESohD8YWvNzfNKVQPA97fTkwkIywTqX
	NLzs3EWQcHlLlkrtetjnxQoF+UE2AAuEq0q/ktvgj2x30FTWv6a7BTlLep4Zp2Lm696t42n1RmJ
	XXcuMtRIpxGxSYL+yj9Hy/reHJQxk7Cmz7iiem2cKlfMhz2WxAcb2j0sM+vJhH09XlibEDCfEav
	Qv34TSkUSCXxRQz7UHR2P472AOE0LyZTNdinck7DKCX6/qoydpw3jffarOXV1UPEkrE/24AUNSD
	34aEuYYO276eMQ==
X-Received: by 2002:a05:6000:2510:b0:470:c049:b444 with SMTP id
 ffacd0b85a97d-47654b115a0mr2774203f8f.0.1782848032690; Tue, 30 Jun 2026
 12:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: LocalHost <localhost.detect@gmail.com>
Date: Wed, 1 Jul 2026 04:33:41 +0900
X-Gm-Features: AVVi8CesiUgqWaklt7W1S8NKLOpzsL1K-ahiN4GrQBRQ48VQ5Beua4ugW7eTIEs
Message-ID: <CAOpx92dGSe4pFZTvNpZsAQzzsQfH2XxaVtaSBdFtCpht3wLTRw@mail.gmail.com>
Subject: RFCOMM/HIDP: validate skb length before accessing frame header
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a missing minimum-length check in rfcomm_recv_frame() and the
HIDP frame handlers (hidp_recv_ctrl_frame / hidp_recv_intr_frame) that
allows a connected Bluetooth peer to crash the kernel by sending a
zero-length L2CAP frame.

The initial candidate was identified using a custom AI-assisted code
analysis tool I developed. All subsequent verification, data-flow
tracing, guard analysis, and impact assessment were performed manually
by reviewing the source code.

Affected: net/bluetooth/rfcomm/core.c, net/bluetooth/hidp/core.c
Impact: remote/adjacent kernel crash (DoS) via established session.

SUMMARY

rfcomm_recv_frame() and the HIDP ctrl/intr handlers dereference the
first byte(s) of an incoming L2CAP frame and unconditionally call
skb_pull() without verifying that the skb contains sufficient data.
A connected peer sending a zero-length frame triggers an out-of-bounds
read and an unsigned skb->len underflow (0 -> 0xFFFFFFFF), crashing
the kernel.

This is the same anti-pattern in two subsystems -- both sit directly
on L2CAP and trust that incoming frames are non-empty.

ROOT CAUSE: RFCOMM (rfcomm/core.c:1769-1797)

rfcomm_recv_frame() casts skb->data to a 3-byte struct rfcomm_hdr and
immediately dereferences it:

```
struct rfcomm_hdr *hdr = (void *) skb->data;
...
dlci = __get_dlci(hdr->addr);       /* data[0] */
type = __get_type(hdr->ctrl);       /* data[1] -- OOB if len < 2 */

/* Trim FCS */
skb->len--; skb->tail--;            /* underflow if len == 0 */
fcs = *(u8 *)skb_tail_pointer(skb); /* OOB read */
```

There is no "if (skb->len < RFCOMM_HDR_SIZE)" guard. For a 0-byte
frame, skb->len-- underflows the unsigned 32-bit field to 0xFFFFFFFF,
and the subsequent skb_pull(skb, 3|4) leaves skb->len enormous,
propagating into downstream parsers.

The caller rfcomm_process_rx() (core.c:1964-1976) dequeues skbs from
the L2CAP socket receive queue and calls only skb_linearize() (which
succeeds on empty skbs) before passing them to rfcomm_recv_frame()
with no length floor.

ROOT CAUSE: HIDP (hidp/core.c:560-623)

hidp_recv_ctrl_frame() and hidp_recv_intr_frame() perform the
identical pattern:

```
hdr = skb->data[0];          /* OOB if len == 0 */
skb_pull(skb, 1);            /* underflow if len == 0 */
```

Neither handler checks skb->len before accessing skb->data[0]. The
caller hidp_session_run() (core.c:1254-1273) dequeues from the
ctrl/intr socket receive queues with only skb_linearize() -- no
minimum-length validation.

REACHABILITY

Both RFCOMM and HIDP sit on L2CAP Basic mode sockets. The L2CAP data
channel dispatch (l2cap_core.c, L2CAP_MODE_BASIC case) checks only
chan->imtu < skb->len (upper bound) before passing the frame up. A
zero-length L2CAP B-frame (lh->len = 0 in the L2CAP header) passes
this check (imtu < 0 is false) and reaches the RFCOMM/HIDP handlers
with skb->len == 0.

A connected/paired Bluetooth peer with an established RFCOMM or HIDP
session can send such a frame.

IMPACT

The reliable outcome is a kernel crash (DoS):

- The underflowed skb->len (~4 billion) defeats downstream length
checks (pskb_may_pull, skb_pull_data -- these compare against the
corrupted huge length and pass), causing subsequent parsers to read
far past the buffer boundary until a page fault triggers a kernel
oops.
- The consistent, reliable impact is DoS. There is no deterministic
information leak -- any path that might echo data back (e.g.
RFCOMM_TEST, HIDP report_return) depends on uncontrolled adjacent
heap bytes passing FCS/type gates (~0.003% probability per attempt).

SUGGESTED FIX

RFCOMM (rfcomm/core.c), top of rfcomm_recv_frame():

```
+ if (skb->len < sizeof(*hdr) + 1) {  /* header + FCS */
+     kfree_skb(skb);
+     return s;
+ }
```

HIDP (hidp/core.c), top of hidp_recv_ctrl_frame() and
hidp_recv_intr_frame():

```
+ if (!skb->len) {
+     kfree_skb(skb);
+     return;
+ }
```

NOTES

- Line numbers are from the current net/bluetooth tree; approximate.
- Both fixes are one-shot guards consistent with similar checks
throughout the Bluetooth stack (e.g. l2cap_sig_channel checks
skb->len < L2CAP_CMD_HDR_SIZE before processing).
- A reproducer (ASan model of the underflow and OOB read) is
available upon request.

Thanks.
