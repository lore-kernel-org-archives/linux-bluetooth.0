Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794245727;
	b=sUfQRieOXYHEYDenykblxIPt3vSv0nGdDCUcc0c8Xsy1MVscFP0GhIIWHoY28dZsqT8B
	 9bv78TQG4wqMdOZw5Q9sdcBbfIsEx5H72VFaKTSXeyRSvs62aVdiaS4/w3tcnrH7fd5ks
	 2od4waAcvJSpDNVkjftq/tAyPEmRdkEtoJiN0kBAzXFONgKQElsRJmZVTRtqXZlaTxAro
	 7hsKg7csR1ToWr+4TEZAHyQEb/rHCtOGiLWQKaDBWj/yukYJXbsiEKNwtFNUVWvj24zR2
	 qa+LMFWT2/VzrTWcNh/QQCy+CLtLlDkLQoRRplVmAugWvffF5/+3u1A1Yod54x1NRIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l7ipEMJZfKt5QXH9IG6GaoWGg4lbzb6pAGJlboFPwcQ=;
	b=1EKCMAAJstLtJR92CT1c7wk4FepE8+nt7GGtkVdblwObDKVQWwwgj81mLvBqQWYcLC7h
	 iYxiqTU9JW6FOmeTGU4fGsaPdxede0O2Bsqd5uf81nHckePmAaxayUAB0Cwlj0JX1jRNO
	 ySV28QsFwdhxcCCBeYdL0no2j04rkwQ3kPbnPCDrc9086nKbTcchj3NL+MJqEwg7AVeJJ
	 0j2jz9JxESG1AZ4QedaAivScwpwWAXB1FdGZa6PsZsqj5UEogZlpu1tctfO9WthSAPROw
	 51xjSjJ+c/CMvUYXcFxXxPdeWQnlplxdej9XyAk2bed8sG4rJIytuCgLmxVPQKJYbIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="cbZFyu/y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBA606A321
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 17:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FBA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cbZFyu/y
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-53ec92375d2so426277b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794245725; cv=none;
        d=google.com; s=arc-20260327;
        b=H+myG9EyyXUG/F879GdGrtNhICgjw/gB1dEOqCh2wpyb9kK82bs2V8SIaINIxh7OuG
         5zSWlCdeytIk+cXfvPi//SaTwB9gFA9fUJ8fGfC9qMNgzIXk4akkeW1xrQsVSl0Lme6m
         3JjPSKBIRrCI0d0o4nVEWooV7tY5hpvIAjVga4iiT5j2WYAP2dtRsKNKP/bc2NzYy6rj
         hJL/czX6V4oGOtF0ZYEmdRgmJBCFbNnvHO2w7urTsCF9+eqKWdb/6DsiT29i30WzZ//M
         KgRwvVk0d6bzIo8oZiDyrww/LjeETYpNemvhFdhWyyDO1x/uugsygWDrsjda6JLO5cnY
         J+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l7ipEMJZfKt5QXH9IG6GaoWGg4lbzb6pAGJlboFPwcQ=;
        fh=kGj5RQNHM8t1Tv+xqwQdih4syLCOTZn88PwKG9KYmCQ=;
        b=D1V4kdC14+yGaJOXBJjDc5FPp+XsqHqLKYel2ZjWYightzWy0eo7ImLeTMLKpsrqPJ
         //CxTWDeHCWONXtqBSQIOH7h+jy7mbJQvRkduZSoGGGzwqy5qs3mGSKZ5zjLso5m2vdB
         W0qDJaGecM7+axZeTQxU72HjfDhvxCVssqx7dj+/FuRRTDIajHldLfipZp9Wk1hFV6io
         F2SYyLHDAB9UhEGU+KjBVoEAcf4HOptIdsI20BAxThXufhyWHdmLDN/4risSu2E2FCoq
         a53fEquPTypcBolSzGKfE3pl3EDWI2+TgJCLfuFqZmO/g8zSfHyu0HgOj6TNG8yhEAdd
         aK3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794245725; x=1794850525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l7ipEMJZfKt5QXH9IG6GaoWGg4lbzb6pAGJlboFPwcQ=;
        b=cbZFyu/ympslBuIh6poY9KgizLvO6DKdEPXkeitWX7ov3Kg0Xvt+1xuf9Scdzdj9B+
         8Uu0LNK2toOcHGGI0rUbxA497Q4cfiM61anQzlSptrUhEiYbfiHdVPiSrn1fAYWM7gyv
         htRSdojLNw6tC7b3uulCFaAuYEP9TupJnrP2kgBJVVH+ykuxv+pLc3Qm5LJhG5+J4/ac
         NMZg3aL2rqnnq42zaNIdq0hABRZemd77f9NVA6g9hyAbg3bP/zEGajOmLHB1pIcC28ln
         YzqWQWQh7xy2tcNi3zrmajgt9OwTm/9E/ox5mX21sFYf15dOgycdkH+CFal+g6C+rWjP
         Ke7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794245725; x=1794850525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l7ipEMJZfKt5QXH9IG6GaoWGg4lbzb6pAGJlboFPwcQ=;
        b=kmpSMAtTSQ0oAJjdEesgN9F36o8+kLLoJHARS5iqhuJXFyLzZMXHOdfu5NyqEIRgz6
         wjRhIXa3bpOw27K0Pyewdbntd8kLtZCs+LpeHlQoDJSSwW/et06G6LfSp6tjGpSAtkug
         IjuvMVwKTcvJJA7vWOWHfgpsVZnOpuXZt47jDQ+EnHkoxwTvLl6Da1opXME9EdERJ7ht
         dNXWcHr7HnCBQbEdpVK5U4Hd0kRO0tJBsSp8SVokdpLWg78J1j0g8MoK1advtI38J1NV
         p9qJgTHTi/5t/2O3pf82Svd5big7xLJYRMeSgox0umySSB3u1axwyHKjFsJ75T7h+/A4
         fAng==
X-Forwarded-Encrypted: i=1; AL+hErHh7V0GohqLCsSPa5qOT+Wg7qAu+qQuna2IH5kUSv3IDnl03UyVw/L5KFNLbDx1oz7axMF2HEyLUDCzfKDrG5I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Bb43UGniNaqUosf/BruwI7U5zyl0UAuxRMWBMxzJDvEjaBAJg
	5RLEmQM5whFMVgsxsgIPwmGODyMWfSJ6B6AqGLWzt9HN54hrUofWr8rlqHOWp36bEk1cC49h8ct
	7qUSn34dcr/aaSVdNF1qY4Fhscbycu63N8yjLu+ZH
X-Gm-Gg: AYBFou35VM79CGIuFYdI4QyQvcFRQzdyEJf/aYaaZ0f/kDVC145ZgrAH828g3lzXUl+
	4RUttVbiLmrONiQisV9vbN8N3F2kr5QCz6mpBtEG8PW6TSRLTCHTkmQlS6YHH9aC3hzZRfeVJ8U
	ewORziShCNhvYnYxA+BgXYkwzmyhtXV6B6czyuY5lkguIKdpr1diTxL60b6Fsx3Ontf9pvDTcAk
	lwqU7xjK0oKSs3z3kdDaRDwh25WUGyKzIBU75U7sB0WXn96PE1BMt6fQEhUV9SCbHIL8EWMthT8
	gIXqtbVeMTwgVvVVopvSPBmQr5q7bzSyaweIy7t+4LZEMQwKuePU9buK5TikTBH763yX1sdIAbL
	mrUTC8Y05aOIaWRnnZQG5c0+48B4TIiuV3jAS8M/N1vuNbFPWTm6MaR/0XGvaASaxtamG+BiBGp
	AqYBetV1NN1IfZU8g3kg9dEA6C62/35fsO3FApPFyupVNnovVp8Tat5tYecYAa0GTN9WTpajPL1
	uAI6ej6
X-Received: by 2002:a05:6808:1829:b0:543:50ad:baae with SMTP id
 5614622812f47-5683ce02157mr265411b6e.63.1794245725006; Mon, 09 Nov 2026
 09:35:25 -0800 (PST)
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
In-Reply-To: <20261108202849.2e5c40a630e66dd39334a915@linux-foundation.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 9 Nov 2026 18:35:13 +0100
X-Gm-Features: AclHuK-hI9rJRz-mT5ngogTQCjiUzkrA1dTOphNK2ymjlIr9_nFY1-IjXf1wnBo
Message-ID: <CANp29Y5m+47Y5n3Y8WvCEm2UgzGBOnpMK2eqY4aO1L+hQb1yNg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [bluetooth?] BUG: unable to handle kernel NULL
 pointer dereference in __refill_objects_node
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+73e34786d639a8eb1324@syzkaller.appspotmail.com>, 
	bsegall@google.com, david@kernel.org, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com, 
	liam@infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@kernel.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:28=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sun, 08 Nov 2026 19:58:37 -0800 syzbot <syzbot+73e34786d639a8eb1324@sy=
zkaller.appspotmail.com> wrote:
>
> > syzbot found the following issue on:
> > AI-generated root cause summary:
> > In mm/slub.c, __refill_objects_node() replenishes percpu sheaves by det=
aching a
> > freelist from a partial slab via get_freelist_nofreeze() and iterating =
through
> > the freelist pointers in a while (count && refilled < max) loop. Becaus=
e the
> > loop condition only checks count and refilled rather than validating th=
at object
> > is non-NULL, a prematurely terminated or corrupted freelist (where fewe=
r objects
> > are linked in slab->freelist than the expected count =3D slab->objects =
-
> > slab->inuse) causes object to become NULL before count reaches zero. On=
 the
> > subsequent iteration, get_freepointer() dereferences NULL + s->offset (=
offset
> > 0x400 for kmalloc-2k), resulting in an immediate kernel NULL pointer de=
reference
> > crash at address 0x0000000000000400.
> >
> > full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3D73e34=
786d639a8eb1324
>
> Thanks.
>
> : This looks like a bad syzkaller test, not a Bluetooth bug. The
> : reproducer runs as root, opens the active PCI device's resource0
> : (mode 0600), and maps its register space writable. It then places
> : syscall arguments inside that mapping. On this GCE VM,
> : 0000:00:02.0 is the NVMe controller; its BAR contains live control
> : registers and queue doorbells.

Yeah, it's unfortunately a known problem.. Sorry for the noise.

I've just sent a PR[1] to prevent syzkaller from manipulating those interfa=
ces.
[1] https://github.com/google/syzkaller/pull/8111

> :
> : Both crash logs show NVMe completion ID and generation-counter
> : errors immediately before the SLUB fault. During minimization, the
> : same program produced crashes in several unrelated kernel paths,
> : including runs without the Bluetooth operation. This points to
> : disruption of the active NVMe device and subsequent corruption,
> : rather than a demonstrated SLUB or Bluetooth defect.
> :
> : The logs do not show the precise MMIO access or establish how the
> : freelist was damaged. Please rerun with the resource0 mapping
> : removed and the read buffer in ordinary memory. If the SLUB fault
> : persists without the NVMe errors, we can investigate it as a
> : separate kernel bug.
>
