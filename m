Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330D4644E
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475083; cv=none; b=kjraSJ+7Tkwo8ieYPcCP0iB1KEZ3il5axArmh+FAZ14i6chaMdsPif/zMZ+0KdC3RIUBXLExBSKMX/XgYdyAkN49Jb+f4AnBAPJ2fRXxBunMzqySb1rDad8okzyd9+4nqb8TMOIhZ/mNXO2tyZSkJQrx2L/mJmHPV6TGspSFhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475083; c=relaxed/simple;
	bh=8mzLShjVx9yxfsk6ndndnOwQ8UUV5QSG9kPmM7NMPZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfnI1tOzqLW4/ZUI5c/0K/na23GdpWoldJErGJYtPNW+WcO3m0RVHs+zcAODfo+p9ivOAU9EHCqZmzEJQAFsZ66n/+UGpbfiVoNtBRii2WN+s1xXO4EGypdS61bURj+QNMrCoQVHfu6G6K7en1VkCfEhC0OrPt1O7/daytl+IXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5hcPJOU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5hcPJOU"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so19039591fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730475078; x=1731079878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mzLShjVx9yxfsk6ndndnOwQ8UUV5QSG9kPmM7NMPZA=;
        b=N5hcPJOU4YGtgQtdizrGYhebqnQRFq0P0Uv2ItG4e75kAOb0KsUCtwhSWDBkwsry15
         KkxwJTYRNrpgmWfxeEHxUmEjbjMRqmmsY6WJe6uimgQxhi2pf5+C4sinMFNRnXBsGcgl
         f1uSQNTKmGwKodhrbX5BCV4Z4AY/cES/S2iPz/TpjJ9rH7/8w27eP9g4XH4+7DKzqUZG
         lR6qyXk35ZxgAkFKuj0iBGtXIHnf1AiCWyPW+vymvErXObuK3SBaJYpy5J+DFzD/j1KX
         NKBoq5S7j2F6+cv8/rfAry4BxH6abgc4xUSvwzQBhZZyEcADyVSq7nw+N7fi+C/mrHOk
         kUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475078; x=1731079878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mzLShjVx9yxfsk6ndndnOwQ8UUV5QSG9kPmM7NMPZA=;
        b=BX60hEWVGNG/6RcQJQEmIGK216gnXSVStoTONVa/+kUAn+Ez6PbZj4LgrY79EtF7Cy
         XeMtGfJ8XEDOqR1lVuQGX1QDAmPcJ9YSh4Ct3d3pWekMq9thsVSpWhuCj+OzSPR6m410
         yaLdTWJmQO+fyZ7shwMi5sGZmTMoIS6H7rl9TtWbAYJSDowZZOYXC5TQ6HTvmBHfGDp3
         rnaz3SCk7sUruA9RFai/Mvgu3Po6ZRpRMHbpn2EVuawEjZpKwRNLkw99Pk6hYXeI+y4W
         kck+jngdrWdcjAMnA7U+BTS6ZxDQC0e9RZY851awRU7sIAg9/8FXPLr6NENXkBvFulZC
         duuA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TYHGpXp4AEcwKdMG4xU1Dd08twVtUvm4OacYbxa+tKZz8ygbiARQfAFsMlMa7whHkKYaDGFb1o1OSXdddO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYe0V2dXm0DLJo6ECJHPlRp0Gog+Y2nIDKOdg27COqxe5EGwOa
	rSYpLbEM2f/N5kMu6NC0HZPICJWcaF6Ix9+P9llDYqy2oKD2PidbH5dJgko830I8ON6wAC/KyYx
	nJdd0Tm58vw00K9vCvx2lemoylpE=
X-Google-Smtp-Source: AGHT+IHabEBRix0XkB8orhDVa7W3soWDndFapnqnOEZtLOuSfp/ZSEB53btY2/rTsLqCMfFMzWPeTgH86ZedqG2F/U8=
X-Received: by 2002:a2e:a90c:0:b0:2fb:6027:7bfd with SMTP id
 38308e7fff4ca-2fdf4688e1bmr36769781fa.27.1730475077595; Fri, 01 Nov 2024
 08:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru> <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru>
In-Reply-To: <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Nov 2024 11:31:04 -0400
Message-ID: <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Nov 1, 2024 at 11:17=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> On 11/1/24 6:12 PM, Luiz Augusto von Dentz wrote:
>
> > There is no Tested-by thus why I assumed it wasn't tested by syzbot yet=
.
>
> Ugh. Until today I've assumed that Tested-by: is applicable to human-driv=
en
> testing only :-).

Nope, in fact it is very handy to have syzbot test your changes since
it may hit other problems as well.

> Dmitry
>


--=20
Luiz Augusto von Dentz
