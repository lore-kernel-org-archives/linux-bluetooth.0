Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB7364933
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868719; cv=pass; b=Re9C9AGAX36QQkYXqN7wfK0oO41AsZn3Qeb/LTMS7qvp7u93Rk09Ts/x1EpDDYsGc0IHkEGscLz4AeFkiI5ksH2zO7cA2lwDfmZu3jb/nU6z2CAjtkIBu6pEpboT2j+mVEOvK/v7YEjhM3OF30LxM1iIe1r/nYcpErkAAqkMyXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868719; c=relaxed/simple;
	bh=RAq1lU1nZGXtmKsB+4GiWguBRte8A7ylWtmoC9UBRQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBh+IMCl7vv4QvjzT460iG46UDoxAd/1xKrUOrsSZFUM5CkkC205g4WgJJWaRXjizuVq2K1CyywNhcmqyCv0dNgQ/ESunqV6hzRr2tyMf3FxBPU3LfP6nebgkWNclfdOA+N8MLajjxd+egsFUI4F1C8qsdzN9aY+8RFuqrksryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfVFVkD2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfVFVkD2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69565156c06so10080a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 04:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781868715; cv=none;
        d=google.com; s=arc-20260327;
        b=LdyENPGMXezSszt1k7PwBuV4oLm1Vrse7VOHiFXtw2sio7tiSXSkeb9WxgH2bPTI4/
         ysfY32cvaGLgHJgTENrUI7G9kSv1yMZIajhYHjwwL/QnMTDkfnhkUYpeAeIemoVrf2tu
         fa3XG/bUpvPkzWpTdObSLfZ6meXSrmLxlZZzXn6fefOMhGBn3ZxpFLI6/4NFJUdGjmBE
         5gt38tQvEDKOGEKzZk1HglJvKYKwHnto12s2vuCgROvC/sUjQOBIdCxQww4SwNn1P4ms
         A+wGm/v8dDvWjlkIUXYs4ip0i1Iim+tbNiMCiHN1QYXtxljLNaX2jghxvJgMPlqFh7T5
         dRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltTJFGawoPzU3KwkccSWgKxAp4slzrgEWJAKt7B785c=;
        fh=H4Ro2RgzVOAEDDopVYAA5BOsmVMDokaQpzIyI8thqug=;
        b=hlzmuWWA+/Cbhi+GNv3pKv4O0okkTN7hLfZZWZjLMGd+dbkrXFUPE/2QE04tLH9qWn
         iODjI4QRIjjh/Zj5xvFZIWblBhzehoctPcBLIduzyPg8lCzplMvOvTmlWuGj+VAEdy/8
         vPl/h7jsH2EiHanIigmj+6a/5RxClFwhBeHI7LveJpkblDAFgVMxaqX7rZXQEyqsP9a4
         E1SFwifdx0pUOm4x0QU5Z/e5xKNud+T03bAux6ZXCvOWX583kzPYv7P9SPEEFqXy+8wx
         iAn9ZiNuuB80vkTcazSdt/sC4XOqHUZCyZzFRrpUgUfkCSdOoh1KI8XeinE+NkmOs8SE
         XQnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781868715; x=1782473515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ltTJFGawoPzU3KwkccSWgKxAp4slzrgEWJAKt7B785c=;
        b=kfVFVkD2TIfRaft+uAasSEFkhHl3vgGf9EAtX118z7w3LlvV+LG5quS5tBIrhkZyrx
         QAfNuGKvkYik8wx2fDuBjjCXTGc69dKCyJIcS2VWugHchWmb/8HTrqCtjrpc4f8ylERw
         4aubj87tzJNrLXFz0cvLN8bix4PvgdV8EaBAjVXS53xCQmQ+yxvSvn/w8FOz1TIbXGTO
         KLXq1rXCEq0NHs+wPf0QdtxOD/rUOIOL54gl9CXM4mlJ5mDn2feGD5x9i2OrYfnCMw2L
         EsZam/QD7el5U1jS5VeKZJsEVHomwi4sNepowP0pvjnPs80Jcp5aM6eE3gx1wZ0XWMbj
         LUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781868715; x=1782473515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltTJFGawoPzU3KwkccSWgKxAp4slzrgEWJAKt7B785c=;
        b=DtJGxVQxt/hq3SmYJk83uUa2wZp5rvyzxI969CzawpDpnoZH2ybEuwXCIaCY0rO+rB
         Ew377ax7QGBRX7X8Oz+iyKuDWwgCBxnfALNOVxxcHkRFo6GfzOwRdne9GFWRB2YBddif
         fjf9kO1/aVems3p1AXKOqoJ8CfdQqblqkLBR5KKMMQMN8qLMcpnkKv/Dnme8WW653bgb
         N+g+d9kmx8qbvXcBzHhY/QavyOM0qzpdngyWEzCFgVndT9bLpNUVTXVN6OgjgNOv4YJ2
         aInDO9ObG8cOmErHY0iqTXBxtwwQ3S4PE40EYq4mVF54qrWc6MnHQxcvnj34t6wIswjh
         K9YQ==
X-Gm-Message-State: AOJu0YzhoJAv8b+q4bVVuGGG27hk5+F9Jol4t7cqvaaiAcT3GqHb4J1/
	wwNUVEewAqmGwO7tbrP0Q1p0r9uYbWsjD0d2wMm8v/W8LV8iXB6owFi2oAjvvIKSoWyVS/1lw5F
	Nhw3eLOEm0PnUDZWk9DHsSoacaAyR9cG8wl91WXZLXMyyIqkOL8nGPlj3
X-Gm-Gg: AfdE7cm2uthRlU0dzoVCTkG5VlcFy/ba2gfHryhtTSWvUEWaXVDkDm6jfIBSwdPg9Ah
	cXBwRo6HTug4iqoDRpTydEcZBOqhRsGbBKjMczzpbSwZ3rz4HFx/xxTFbZikRjMlGnmWySYEtla
	oAzb5rnigUpXm6Voopyd+3bb5HspRVyuJWkfs2Vn7gAa5zFufW/r+1C6LKezLKyxEssW8ZIF/5m
	BhMBo6RYxn+MlP+k9T0mk+/KYTjQi2KZLcZllGVvaUhnskYfkfS9pIbeXma4WCPlqxubYootXmW
	zvjGO+v8NUVN5npmxnjRP2W2ZvUgEU4QaeFdJXM2DQOimcDgN1xHkoQADlNqK8Y=
X-Received: by 2002:a05:6402:a519:20b0:693:17e4:c6b0 with SMTP id
 4fb4d7f45d1cf-69749bcb938mr19688a12.9.1781868714215; Fri, 19 Jun 2026
 04:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a1541c7.820a0220.e7972.000a.GAE@google.com>
In-Reply-To: <6a1541c7.820a0220.e7972.000a.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 19 Jun 2026 13:31:18 +0200
X-Gm-Features: AVVi8CfPAtNEU7qPb10Ke1D0kZouBWL-Ng425h06h5XOBVRf4bIDwGDHWleW3Vs
Message-ID: <CAG48ez3F-o0A24m1zsxcPXnxCTeEjfwWJEGRBCw6MQhckza3CQ@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in bnep_add_connection
To: syzbot <syzbot+604a39147226ba42d117@syzkaller.appspotmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 8:46=E2=80=AFAM syzbot
<syzbot+604a39147226ba42d117@syzkaller.appspotmail.com> wrote:
> BUG: KASAN: slab-use-after-free in strnlen+0x66/0x90 lib/string.c:432
> Read of size 1 at addr ffff8880126e8120 by task syz.0.0/5330
>
> CPU: 0 UID: 0 PID: 5330 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(fu=
ll)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
>  print_report+0x58/0x70 mm/kasan/report.c:482
>  kasan_report+0x117/0x150 mm/kasan/report.c:595
>  strnlen+0x66/0x90 lib/string.c:432
>  strnlen include/linux/fortify-string.h:231 [inline]
>  __fortify_strlen include/linux/fortify-string.h:267 [inline]
>  strcpy include/linux/fortify-string.h:794 [inline]
>  bnep_add_connection+0x90c/0xca0 net/bluetooth/bnep/core.c:649
>  do_bnep_sock_ioctl+0x40b/0x650 net/bluetooth/bnep/sock.c:83
>  sock_do_ioctl+0x101/0x320 net/socket.c:1313
>  sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
>  vfs_ioctl fs/ioctl.c:51 [inline]

Funny that syzbot found this ancient bug ten days after the fix landed
in a subsystem tree...
This is fixed by commit 59e932ded949fa6f0340bf7c6d7818f962fa4fd2.

#syz fix: Bluetooth: bnep: Fix UAF read of dev->name
