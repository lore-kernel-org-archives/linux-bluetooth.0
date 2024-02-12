Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710D38F99
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733964; cv=none; b=E1DNfwnvM3U9qyoLXBPrHINnVSY+PRJO4OipAHB8qIXKuYmpz/G4YG2tM9v5acGG5Fe9pD6MOuvwJvXU+pfqTRxVke2mAhXqIMrperlljqOad93Dmc9QWz9/Acd00lbZmhCPX53NgZJaAlTVWSJ1TomRVa/mxUgAnewIN7XCdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733964; c=relaxed/simple;
	bh=UkHd/GmH09GQBsYpAgBPGTOK55u0Pd+g0aye5wazMcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND+vyArImDPAZQHSVZ/ROJpZV5e26ZWTp3+qzGiX9+b53jUVXf+noUkiZImYvIJ7vSXN/RhK6q8Gs2jXvenCN8DqGpIbiFgCehiHeSH44GMm6PpeGXepTOLqjNbhWeXKKSuG0HIMhnTkzLEEdxiXjUCgZn7Ntd7Z5nEOvj6+DI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjbN9oPP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjbN9oPP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5ce88b51cso754135ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 02:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707733961; x=1708338761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVlNJZ/Jdf69a5rljlmZldBDpMdBRinviHNt5piQvy0=;
        b=RjbN9oPPOAYDAuYRdE82ouuA3p7vuMFvyRPhO/zSZBIQVP3MrLHZR23e1d5mHHw1Si
         1zHWWSrX6QZKmb/m0uw3dwc91WWOZneKXyJpRAxWE7Aq1Ny8jXMyjIUD+IuXcVCsDLeX
         +NElBjKgZS7WYtyAZISqAiBmbjvKk3Dt+x+EX4BfgMquEQQSri26kQo/GP4EqZDGKd49
         Nzp2OBgM2vuzjfS9vmNHxeUtm+1cLIMfiT/UichN+P+0BXcUQkHsNMRihl8ICowcSLTM
         akk28dej9VRDS0YXnVt1cDYhue2sile7+WZgU4o7SfJjQO+Cyy6ZeNa5ZVKNCNxyYVJF
         cc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733961; x=1708338761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVlNJZ/Jdf69a5rljlmZldBDpMdBRinviHNt5piQvy0=;
        b=X2aHv3jDXhfio8/x9PLW7yJODe2RuFzeOenetqjGzxTPlTEzxFZ5vAihS3vPOZNL7f
         NxYNQyWDzAi88/ZFxEIkQDGJs/lxQ6qwPqSIXNK1ozT59vBuKrFE8vndldOAur7jd6S7
         jazlv6hlOHiBcSZ+RmEJ68ba4fYVhUczQkMtXgnZJIylYzYiobHgNvhTAkSHEMjoD6Cw
         pyoHVUZcobhhc2DUm1f52Kg24fhorcPJS/G7rSt3B/qkOT2pkIzxIoU+0PceutDmZWk8
         igrn5NDvcbV6OHu2cDXoQzfXXI51cWiv+kSes88cfr5NHY00BzlAAOLr8Lir6ojlPfzZ
         iDGg==
X-Gm-Message-State: AOJu0YyyfVQZ0k+ACv6mFELbEkQMAsAbAlNLF5JIOoL4nY8MYuNSieRz
	GKuFriigncsgl+01+xUwmX76BiOsSmUg2Y9kPbdICATP8CN693iZDDMza1bWhR8sux2YFjRI5vj
	w+8/sRQOQ7eBhYrG+lcTgp8S8IXEZz24/Yr2E
X-Google-Smtp-Source: AGHT+IGdlMaFd/BdT6RBgHhSi1OWBqayl0lNXuYCbxRDZ9tYdjTq3zOaOOG89twPSQVa3gRMaSCc9qpJ6Ji32VuPl50=
X-Received: by 2002:a17:902:e149:b0:1d9:4c70:9731 with SMTP id
 d9-20020a170902e14900b001d94c709731mr213050pla.29.1707733961356; Mon, 12 Feb
 2024 02:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a135c0060a2260b3@google.com> <000000000000d4a29506111827e7@google.com>
In-Reply-To: <000000000000d4a29506111827e7@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 12 Feb 2024 11:32:29 +0100
Message-ID: <CANp29Y7+q_Jo65YHbReU9AYJfU=e6sZqNxxTOhgzgDTC04OY+A@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
To: syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, dvyukov@google.com, 
	edumazet@google.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	william.xuanziyang@huawei.com, willy@infradead.org, wzhmmmmm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks reasonable, judging by the commit title.

#syz fix: ida: Fix crash in ida_free when the bitmap is empty


On Sun, Feb 11, 2024 at 10:55=E2=80=AFAM syzbot
<syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Thu Dec 21 16:53:57 2023 +0000
>
>     ida: Fix crash in ida_free when the bitmap is empty
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12fc6ba218=
0000
> start commit:   b46ae77f6787 Merge tag 'xfs-6.7-fixes-3' of git://git.ker=
n..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6ae1a4ee971a7=
305
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D51baee846ddab52=
d5230
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D127837cce80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12779dc8e8000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: ida: Fix crash in ida_free when the bitmap is empty
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000d4a29506111827e7%40google.com.
