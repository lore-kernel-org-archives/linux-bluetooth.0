Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA61C07E7
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736308; cv=none; b=ZRgFn2zEnVxLEhWPNwmHxB9R6iqIOUwW+wUqQC7bgR63oux51p6dwjWIEuFFvJbtYKDD416+KPlu1AkbFI9qMt2BrtXsp1Uct+V1JHdjEPskehC3DeiNIAcdJvC6N5HmIpVmV8NJkC+RAl+bT73pQhBZoGst+gyaCEnfRMwCwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736308; c=relaxed/simple;
	bh=v8l5N0k/I3ZrgdOwA9CBYfhTvzz84BzsCj3okfKmtDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6GPR2nenEfRzKMSFoKJjTr4q3XyuY4goYVhOtE8jaqpfnkaJoRmFwt+SJ124jaopC0nOxWRUc68zqsyLZKmtufYhVMXKoTWKaR+5K0bU9X02o/0v3F4dIOewKmUWBbGEPCzogmQ2TkLx1yWdsnzuQwBKvIJ2RjOhnbfXLt8ul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M24b/Bes; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M24b/Bes"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso33777791fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730736303; x=1731341103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8l5N0k/I3ZrgdOwA9CBYfhTvzz84BzsCj3okfKmtDc=;
        b=M24b/Besyv6FI6JscOFKxwQoWCd28ngc0RSowHeRyw1pjsQjwJWfCblxYaAyKbJs6R
         q+9FI14qg0qoYX2pqSM8QukHigDWAZepegmBBJKx3zFrocYs2ylQtvWlM9AxRDJdy2+E
         FQZ1PKAyo2zoReklqAbMhZOwGK0f9JupTBBNjZSVk2cASrnH1PBKD2HNWOwwKD9GToPD
         RYEaARZOYIpiAE0sYB90lrLXWWpp+rrxYK1ip0g+AuujV3og9j22DyAyDpK1rwccb9oV
         ROaenQdOgulm0pkDLNMl4LUDDP0ZhJbt67t2aCyJGgwoP4P8Ac4lIWe8OY2ryZDvhvz6
         sFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736303; x=1731341103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8l5N0k/I3ZrgdOwA9CBYfhTvzz84BzsCj3okfKmtDc=;
        b=qJMVYCffzTOx3rpkpLxkT8BzBAhd7wNRS4OVr5Y/wCowCFN6lPpwjCDkYe8XSz2B4u
         66w4KvxmFKX1eLkYW4A7VQrS9i4Qxz9xYPuC7ELh2+to7PGGRLCe1ek83U/8PfYkHn63
         8Bz5JntjqqD9YBphRn8eEQPiv984BSbRJhBAx1cmKKVPnRiHIQDB+r/LcFG+Zf8JMRug
         /9jeTfElvAbcV68xMpAMABhM9IQj8BHhjXCs6v4c8+BTyF74gND0x4z5mPTw9Tm6UosO
         6AoQlE48V2p1n3zqdNyb2Ac4lH7mFWCG7ZBPqBNcsSCVCjeRBsbuMauT/m1rqtAhIDrB
         7siQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzHzLeiNN3VV78I7bN+RFm/2HrlajpUpWgqiZQQlxrp2HaxjoaSvqdIAXWMdq1XitkJ+rrcyxe9iLHbfjsDnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUqPM+mMYXL9pol2x2i2Yd2tm/QfLoB4SDiEEXIZl2J/KtM3F
	7EJ/LAULEduPGfUBsybFlWL20ogOYFkD+GmkvZ0A1N+z/p/0xZQZrExpOmphu2wkdsqVZfJHB/j
	pc6nHHLm6yzwdFNthZVwYXpR39oY=
X-Google-Smtp-Source: AGHT+IHuDtQIAJJkXoPMEK341XJl/ZsmRmHSeyAJ9xXBPLwSrcyUm0fi8DveFN68w3E+1VjbT7X+ceIpr5ehPGrQfxc=
X-Received: by 2002:a05:651c:548:b0:2fb:4c5c:3f7d with SMTP id
 38308e7fff4ca-2fd058fc750mr108701741fa.5.1730736303114; Mon, 04 Nov 2024
 08:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru> <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru> <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
 <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com>
 <2554961e-37b3-477a-8a78-724dfb092c02@yandex.ru> <CABBYNZKNzVyKS7Fb4hnSf7xJmaXRzQxqHqc-7GtfKa7X=g_KBw@mail.gmail.com>
 <75c7867e-b733-4f8e-a4a0-1792a15393a7@yandex.ru>
In-Reply-To: <75c7867e-b733-4f8e-a4a0-1792a15393a7@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Nov 2024 11:04:49 -0500
Message-ID: <CABBYNZJVLejrstAPtZT4BSDPMqDJ2aK+js-7TPxZxbMAw_ujFA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 4, 2024 at 9:58=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> On 11/4/24 5:06 PM, Luiz Augusto von Dentz wrote:
>
> > Weird, this was not reproduced by syzbot when I asked it to test, how
> > are you reproducing this?
>
> This is not regular, looks like a race, and I'm not sure how many runs
> are required to reproduce. Anyway we can't blame syzbot just because
> it was unable to reproduce some weird thing.

But how you reproducing, or you just running syzbot test over and over
locally? Anyway I will look into how we can actually unregister the
likes of bnep net_dev in a more direct manner rather than doing via
bnep kthread.

> Dmitry
>


--=20
Luiz Augusto von Dentz
