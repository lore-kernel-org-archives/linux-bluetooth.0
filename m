Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794578237;
	b=ZVteQOcHOI3Z/CDvSATCIsAffn5JbR0VEgFAXJFq6gIdf9S2hnsbR4g9lTArBzB3SprO
	 wzivgttugBej2qn8wvH5sSNRQE0Fmn9CysNGRcgdGYnxLFS8XubfohcuN44A8AtpfqwId
	 7EP443jWTCFYSCXmdaXo5gwFGoS5GUIRdBazyFr5nnddYu2lbDF4q5EeaY2n5mZ79rH1H
	 wgHPgyeTp40rBC9kglemM8pp2wMOmkoTSaXEpNHmRnTZlZLHNAknOzAvQo1XS08v6Mysj
	 Y30xVNiG1g9flfmdARJ2SHL7fTYm7dBUidFzQg/RXibYU4zDI7Pk3RQLgNgqMo0EVeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oyg73YpJiMIbGke9EcWnaG6kp5irY/WfHZ5cN6Nkeyw=;
	b=Xnc4+wkRbYvJIO28eBt4y9TrocAe05bDH2N2Su1ZRpINnqGKr+A1zYMqa09FCduMPoG3
	 6J7qtfu5+l4//R5VtMZyqzdgRLFS4v3UmwtDNwYC1rzIPVtGhuRL+9QrqgQi+Tvmq1HDr
	 EmzfpQDhxysXjgE3ia8dlqGVaGKwEsz/mACMF7h6oRMO/GezDJ77/dR8LjBWrpAT3ruwp
	 tyqRHUBj0J1QwOjv4ua5SlOvQ3NdnXi7/eCEIOt120qw2VoDMgg4VY6qLacDQuIP7TXfG
	 CMdWYT1dhbso9IORNimx3uUNUobBOrIsr59AwmPcY3PMmkkwi2/lYX2/Sqntf0z5l0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoST7inr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92B606A8A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 13:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E92B606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoST7inr
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8439fe796ebso1391355a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794578236; cv=none;
        d=google.com; s=arc-20260327;
        b=iXxfrgiuDwl2F9fM5s4pcrsZWsDV4geoa1nAcQ3u9eIECCGU1vpyp8Q7Nwe9CHqpAR
         +uCDoA1qZ1CqdqNIxqidthSAL8Wx3ww+igqvh+Urh5EQz6Vxb+P+2mgqEOw8wa1fAaSv
         jetetHbQn/QktYCoeOORle6d6nFrhdNDdjEQJ73E60Fo+cuDIfpWP73HwfP8lmYU9XNR
         qz4PFH/TLlMujGz+NBoRRn/SMQ+U1tM2ghovfPlyxLjcfKQwRqN09wmaa20TH9dESLiv
         PyyvcEVoUHksMpPJJ7La3+gCqmSoTPfhiETmtywRw+bQm74Xj7PyE7MawB0EaBi9dKGL
         /zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oyg73YpJiMIbGke9EcWnaG6kp5irY/WfHZ5cN6Nkeyw=;
        fh=nKx/2xJScyS+IgZwQCcrduIKtpsi3+xJybKyEw2etdY=;
        b=UCRsWq99PMa8XN+9JFpwp3pYH/bjfTITMVdQ63orecmzcdplRmYkJjEeIkjiMfKuya
         r5kskqvatzZsC5q/V+4UXpX2NROfdbyX7DKviibaLic8QgCVV2xCp9eBsyx2x08XAuXn
         BK/mvFmMX/b1YUccM62lPr3UMExEAASGoOIDy0txAFDvLriO7dmxI4hDxQMMUuEf9ps0
         X5XbqW+HRgTdsDbghDtyzpT2ygJWmibVGMZiYGugsXDCreAJA2vrupG5mxARncuGXzpE
         iUkwobGPmM/L4NzWRZMphWa8ttQ1H7bB+Qtnc3U/D72E/Of8sSp0XX0mzFCDi6Z2g7RO
         kQWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794578236; x=1795183036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oyg73YpJiMIbGke9EcWnaG6kp5irY/WfHZ5cN6Nkeyw=;
        b=MoST7inrZQ5+goYt7YZKnNNrtWkfPHcmZt49NCUxGt2+Dit9tS0JgvCKZflB43x9/w
         AsNMb29fZgNMMnMP34a+jRwQgGF6tC3sQ9YPxFvadAIzV7HD4Q0uH/vphiO4apI/SZVF
         x9c2YNRuc/ijhPfaL+dmFhqWXoOvC0tWOt+rukisSGcpdpI5VPeI5mIfX3vtQcftIMBv
         XDmfokpviVaGKM7c5K3cCW7o9PYCIeTkS0VfM2CtLUjXPhX9JjnZ9fGvJul88MjKvQBK
         gHA/8kigOygY0RbdOOQ/vnO3gZJ2AMsmh6qFDzWIGiQusaJLEG++pDhyMnn4x129/s49
         lArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794578236; x=1795183036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyg73YpJiMIbGke9EcWnaG6kp5irY/WfHZ5cN6Nkeyw=;
        b=cKJqIyTZMZQpMrAEs68GjRVQfv1C5ocKQp3nUa6uZpykZ8bkeuBUYdkahTIgnOVRCF
         wQrLTT8irYty5jYDPwPSJySJwf4ejAaJ7bcmIMrnjZhueZo7P8W4llLeXbQUKuiC9ywD
         32DGJrMJ41BCsYzdDOE0OmYwri93GHfGEqFlISenrTNo7bM4J8yGogjgKjbDtm2BjVvr
         Fqarl4LHv0qIUOmt2+xV/fgg4z17679eozolR30QheFVjj3rzdBHqXo6/q5Vj3rCctFO
         AOM3qcYk39doFjsNK6u/tCnWdvS+tRBHZP4/kfEE2QfEFAQWdKKoEyunUiO5MYf7Sbud
         e4Nw==
X-Forwarded-Encrypted: i=1; AL+hErEZGleurDffJyiZlaCyj613Mt+L3HfTECqrxYb3y+flTiwSMHaJI+O4fVfedIpPz+kB5V6FURfQ0r+YRjRA2mk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ovm6UR2+sVXYoN3E4ecKH2YJwuBYSB9cx67sVlPdMTTAh9bsK
	ZnwYzWsNNbeOQlRMha7Kw4MN/+Qu2U2KvYajWC8O9F+vXI/+6YkixATnTxmj2y7emcwc9k2ZU9D
	pAARy4Wl6tZ1GXKmVGsix3KGJLoSTa+pSaJPucYCS7t70pIL0luKrMYPE
X-Gm-Gg: AYBFou0zHF/TS+7frwcmk3K3syS5VgJhAjYfwj5Nsu3n3qtrRF4dH7+tuwCobFKevnw
	9wejRfEP1RiXyWYO/RJz7XkP7G/B8si1aX2wovO/RC+ECEyFlE067mYiCduU5pVd3AMfKia65wM
	zUi1QVxET9AW9XBBApni/5GOsm69aX/W7XvWGAYij6b4TIJgF7ipTyw4eJim8DUaZ9lvqkie448
	WONaTzTzpJID3Js+HvNoywNgHcEO6HbTm38u42bs7AIXVcNp+FQOWZrW6leP5HKkoInYeAJ8416
	kAkSVJ98HOEkz6tGxg/d+dAz4csrgAvJTn5ZQV5EDhNZygHfoO46X+ZuGiSGs8qVsfe3spFYYKj
	0Ymp2YoND+Og4a8voIiSWxM7wrywI7Zoqbn85kg+ZmqcVrWO7/PltNKD8UudkOUDDrwPw2IhLhV
	Mm3rVlG07n8i3HxSJktYvV67IvYGpLXUi4ql81YXUO9NHb3UVGTOtBBSpPZ3FAf072TPn8JtwBd
	n9AdzuH
X-Received: by 2002:a05:6808:3013:b0:56e:3380:1225 with SMTP id
 5614622812f47-56e64e03a5dmr1929551b6e.45.1794578235590; Fri, 13 Nov 2026
 05:57:15 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6af144ed.f50b2b3a.2c0de7.0010.GAE@google.com> <20261108202849.2e5c40a630e66dd39334a915@linux-foundation.org>
 <CANp29Y5m+47Y5n3Y8WvCEm2UgzGBOnpMK2eqY4aO1L+hQb1yNg@mail.gmail.com>
In-Reply-To: <CANp29Y5m+47Y5n3Y8WvCEm2UgzGBOnpMK2eqY4aO1L+hQb1yNg@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 13 Nov 2026 14:57:04 +0100
X-Gm-Features: AclHuK8GcatdsmJoXEjM9GYaBuZWdVQ-CUCU6-fQDT0msNyCcFfz9P5ZWrsfBG8
Message-ID: <CANp29Y5C+fex78EryCG-yO7Ex3ait1-LwOpEwZG5k_5T0z7iPQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [bluetooth?] BUG: unable to handle kernel NULL
 pointer dereference in __refill_objects_node
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:35=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com>=
 wrote:
>
> On Mon, Nov 9, 2026 at 5:28=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Sun, 08 Nov 2026 19:58:37 -0800 syzbot <syzbot+73e34786d639a8eb1324@=
syzkaller.appspotmail.com> wrote:
> >
> > > syzbot found the following issue on:
> > > AI-generated root cause summary:
> > > In mm/slub.c, __refill_objects_node() replenishes percpu sheaves by d=
etaching a
> > > freelist from a partial slab via get_freelist_nofreeze() and iteratin=
g through
> > > the freelist pointers in a while (count && refilled < max) loop. Beca=
use the
> > > loop condition only checks count and refilled rather than validating =
that object
> > > is non-NULL, a prematurely terminated or corrupted freelist (where fe=
wer objects
> > > are linked in slab->freelist than the expected count =3D slab->object=
s -
> > > slab->inuse) causes object to become NULL before count reaches zero. =
On the
> > > subsequent iteration, get_freepointer() dereferences NULL + s->offset=
 (offset
> > > 0x400 for kmalloc-2k), resulting in an immediate kernel NULL pointer =
dereference
> > > crash at address 0x0000000000000400.
> > >
> > > full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3D73e=
34786d639a8eb1324
> >
> > Thanks.
> >
> > : This looks like a bad syzkaller test, not a Bluetooth bug. The
> > : reproducer runs as root, opens the active PCI device's resource0
> > : (mode 0600), and maps its register space writable. It then places
> > : syscall arguments inside that mapping. On this GCE VM,
> > : 0000:00:02.0 is the NVMe controller; its BAR contains live control
> > : registers and queue doorbells.
>
> Yeah, it's unfortunately a known problem.. Sorry for the noise.
>
> I've just sent a PR[1] to prevent syzkaller from manipulating those inter=
faces.
> [1] https://github.com/google/syzkaller/pull/8111

That PR is merged and deployed, so the bot should stop triggering the bug.

Let's close the issue:
#syz invalid

>
> > :
> > : Both crash logs show NVMe completion ID and generation-counter
> > : errors immediately before the SLUB fault. During minimization, the
> > : same program produced crashes in several unrelated kernel paths,
> > : including runs without the Bluetooth operation. This points to
> > : disruption of the active NVMe device and subsequent corruption,
> > : rather than a demonstrated SLUB or Bluetooth defect.
> > :
> > : The logs do not show the precise MMIO access or establish how the
> > : freelist was damaged. Please rerun with the resource0 mapping
> > : removed and the read buffer in ordinary memory. If the SLUB fault
> > : persists without the NVMe errors, we can investigate it as a
> > : separate kernel bug.
> >
