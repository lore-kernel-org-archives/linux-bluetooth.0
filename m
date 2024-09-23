Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334219CC25
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102265; cv=none; b=kJW7N0mY0NiyyF1eebC5kcFCDJtRHCLWj4BH07ZbjGhkzoq1diu6edHa3j8/QNSj9ObridLuFs96DNSt25vgL5dPUB+9Auyne2k6q+xCaBK4eH0EwGEWH/q2mGtqBIQqHyOc9VDK+i3d9BeyuCcyxG4tPyNnIbS/2fHlz0BetUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102265; c=relaxed/simple;
	bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M966ChvUzNmWNmROxXcod+d5XqMwXnvdvdmqfcsbVAqPIdntJSfon53xjAiDXoNVogRYX8m93hYBNbps+wMXlqV+yHwNkZ+7UnWDgaW/N9/usxks1vdFubJY9v+AhcO8WQZwy+oJe5EMtZBIr63HpOhgeWSvOfJhA16hpEVSoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SzMWsMf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SzMWsMf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so3060144a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Sep 2024 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727102263; x=1727707063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
        b=2SzMWsMfN5D7Y/np4xeJu38ASmOaKhZ1hOInPpxU5Yg5N//QKIxFgYwQ0j/j8jYFa4
         5kVhlA/wVCxe2nGyz8jciBlf5B9wuqA/n4ISbFp4Q0vGY2FwH0PXCjg45FfREwdQctdl
         aXggO60R3/5RJfKN9c5RD32S1elV2pqlHunr4n5/bcmsb8yiXHzRXJL3c6S0o6IgQnLK
         Y3+SIYMZGqZwpWs7LsKd2Eq2aqSdg1ywjzPctJ3eZghiwbzXbCgsWB4BRyV1ixyCzjKt
         m6mEw58HyPu2ADWOieWSnF96SchOnKEYcNwZL8oIsyOYCTaeUlgcWDqTULOOEJfun+SX
         Murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102263; x=1727707063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q4bkQZz0QbFeCOrZjNmq4/pkxAmVL8jtqt9aIsJQnE=;
        b=J3vMO/LacezXU2cZRYqD92BCHfrk512Z4p4C8Nza/e2EprmWKMEAWkUUHRFS0F6wyo
         HbgpAFohQLVIeVBNZupHwtKr+goKcEFg0pA+uIQPV7vmoLTLZmHe/YWcI5+0HynKJuHM
         IwA2XxoCbF2RKQjDMJnDuS+cVfatK3ci2RqXPNnfFvhk0oxbQSknvrzEE274Gt168qer
         DtRmSxK4HxVL62O3VcLARCrcAX2aYHOKwpuZP0nvIVH45YjgNj9qv0w0ds4sa4xqlpBr
         y2Gluh7S16jldq6uCatJNsd+iRNIMTlxfB2qggJ7QS6wHDOvAjYBtwbwvx97d22evXgB
         rb9A==
X-Forwarded-Encrypted: i=1; AJvYcCU992DkCSQaeD466a0xaqEm/0BxSt2Tvl1+ChUYnzmuj7brHTUhBIlD6UNCkC1XmoJpSrPSU0EvoANp39x5BKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojXebVl7+7QepjybNu8Gy6CE+qLAHrDfh5bGYCDDYw7gCQkEt
	qnCxZe6nRd45cbokvj6mZkuP4gPRSycxMhBnOSwXXF1Rc3TvQO1TZYzWjTB6HuA1rFF7nl411ld
	A4MRGNLAcq6s5bL7AwKoQNAinY9JxPlCp0DoT
X-Google-Smtp-Source: AGHT+IGWwQZQsy5Guu3o98POq+AGr1eJj9tMkp9fHC9z6xm75qjki3shHEORiT/wrhcmlxMuWLEkk/zNRep8v4JHyiE=
X-Received: by 2002:a05:6a20:c996:b0:1c0:e9dd:1197 with SMTP id
 adf61e73a8af0-1d30a948939mr12714448637.22.1727102263138; Mon, 23 Sep 2024
 07:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
In-Reply-To: <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 23 Sep 2024 16:37:28 +0200
Message-ID: <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hillf,
>
> On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> > >
> > > Maybe something like the following would be a better approach:
> > >
> > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> >
> > If your idea is not bad, boy, feel free to win Tested-by from syzbot wi=
th it.
>
> Is there a way to quickly check a patch with syzbot?

You can send a `#syz test` command in a reply to syzbot and attach the
patch-to-test to the email message.

See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-=
patches

--=20
Aleksandr

>
> --
> Luiz Augusto von Dentz
>
