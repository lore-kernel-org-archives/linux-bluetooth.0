Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B121F30BB
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880810; cv=none; b=MqHdZRRlVq//Wk20j8eaHzbXIUOLxbZJ7pf5LZa0p+QCjJt0y11/nhUphZjdj2QuytyUlFjtGu+ovhRGgJ+pjrKhYGSVFDRwakCqXmI4ZcRCxwWNS8Dt3HwGzWHtiP++OgOPTQLdiHpXtK7y1eukwRGgQRIiRD3RHsiXybXE9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880810; c=relaxed/simple;
	bh=IDlu9n3OLeJ5duMNxqd8I4MTVuzqBDGkDqPg20cC17o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3pp44W8UxzFE9GeO5ddW8rAQ7itIjgbsmTN1uZi5sami6ZWN3GVQ6Xk7YdN2NU1vmYbD6w2kFiazIC3WsCspoRx01Hndk7/jzSpxliXcJIromWUgKKudJV/ZdNPHZmJ9K58VKFEorXHs9wp6Gc9BmAuDG17kRQ6MKWLsQNUHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8PS3S3r; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8PS3S3r"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91562bf6c12so254250585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781880808; x=1782485608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIGBVuVVm03R19snYPTC5iI7SwI4WcfAC4ZQNabDd18=;
        b=S8PS3S3ryvgQK4psRMhe8Px5Gg6Lkqcdd9w2ygKHL2CXjD1DOYWj3JwLzzPr6Rq0rf
         FcES2Lj9/SKvEi1lXy8L98kQ5e4jIiXtDVAXOuvjyDn/oZWwi3gOQuVW+4FnwND0LHPR
         wWhMsWZBfC77XiJ5S0Li1d604oE73izTVMOIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880808; x=1782485608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIGBVuVVm03R19snYPTC5iI7SwI4WcfAC4ZQNabDd18=;
        b=FmNz6FdsFWMg6FCxAuP0Eal6iE0T07jVbhJvyTYkApJtuHO+ZSLefa3G/dIc9vX+Ek
         mwFy8qupbBuc8JsAqol27noBW3H5SyYX+OH3c0C4/+9J28wqhDcR246WMVr84lI73yB8
         3IBsnzNGFekZ8JHY9KV8o08GfXswkOabISOtapWxXQhQrn83By76tZZruIE7pwE9Ovl5
         IfUcrbT7J3/wwB0cYrDzreY7IQ9zEZ/n9AahCb6MXLiSQCRnBogbGpmOcvCDfkvnznzk
         q4RkKECMBwXMoJLpE3w3PAqzuXZx+vHfa4otMGlny4xhRGjsVAkSHQitkR1mcBd4PJs6
         bcDQ==
X-Forwarded-Encrypted: i=1; AFNElJ81mk3XhEFB3aTzqfLcCsbDFZaYneyW++/YsDCr5nTNE1dWF11wZAxDtdoK4hV/l5/l1u9eyc1MVOm8xVg8OUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlXjZIEpBIB3ZEXEn06u4bw6aVR5w/Ve6BFXGof2hJ2z8DjFi
	O1sp0Cd9ZXE+Wtyyd7ieTj53UUoWYdw/xOefmeNB3lg2C29/JfkJjv5TTN4GfObiSphlBsMFIuJ
	RKjlwOA==
X-Gm-Gg: AfdE7cmqtR58GMHMjduBzVQxBSLgENeYPc6tFdjoqpXVurHNG66wZgz76PGUS8JR+/y
	8mj8RrT1qFZvaj/mEFfy0991wcfoTA5sb68dNnBQaN0Uw+JQ2dAd/1pya7kKICJVVU+OUPgz0wS
	+mdUyiP4hZG4EUDiGxo4/N4FFmNBuQmeBus4OjQ/h/oCY1UMOaH473gAxOciQA8llvEOG15JUbP
	MWawOGA/SPi0cDYNg6Iyl5bGdtd/G6+AmzyA+EVLGghD1X8fV5bdQNtLkXg0JsJM/0GwRr/7nUU
	vjuNOnevITmW3XfgnSYuuBJynaPvSFKPXWl0fPO3DzFBc9TXHYFY0UkRGuwHx6yM07rebbo+ezQ
	4sGYQzlr4IYM8AbKg0497jr8Qbr1DLnAKeYb2thjIoEHLcwAsJ1WykuFAZdYLCI0cD7Yg+y2glp
	txTSyBPPY/KBVim+HQvZFM2rthtLV87qP0f9W+R3ajCVM+iuMi2sM=
X-Received: by 2002:a05:620a:7084:b0:916:10f6:765c with SMTP id af79cd13be357-920d3f3c02dmr406223285a.48.1781880807714;
        Fri, 19 Jun 2026 07:53:27 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a496a8easm262234485a.36.2026.06.19.07.53.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:53:27 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51765531803so303481cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 07:53:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+R52U5vU43kt3M/1o3IfV7Z6oLFw9HktP7A9bNzGA0iJvRLCuDRomv7zIa23BEXbwpFno7iBU8yM3267Ymido=@vger.kernel.org
X-Received: by 2002:ac8:5e0d:0:b0:50f:b69a:f4a8 with SMTP id
 d75a77b69052e-519e890ed52mr6854591cf.7.1781880805032; Fri, 19 Jun 2026
 07:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
 <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
 <87tsqyirsn.wl-tiwai@suse.de> <CAAFQd5DyDQo9vBH80YYQBW7Bgf64F1m9q44-jhf1cc75XYpftA@mail.gmail.com>
 <87jyruiomq.wl-tiwai@suse.de>
In-Reply-To: <87jyruiomq.wl-tiwai@suse.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 19 Jun 2026 23:53:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDH3LynVPUxS3Wj7xQoUMcOWfxk8cRhXaHyEY-dj5fDA@mail.gmail.com>
X-Gm-Features: AVVi8CcjnxCeHWkLS06U6AojxhWztkixD9Fe53sN6dMUH6hUtZPXwg6RxFcRCjE
Message-ID: <CAAFQd5DDH3LynVPUxS3Wj7xQoUMcOWfxk8cRhXaHyEY-dj5fDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
To: Takashi Iwai <tiwai@suse.de>
Cc: Sean Wang <sean.wang@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 11:36=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Fri, 19 Jun 2026 16:17:31 +0200,
> Tomasz Figa wrote:
> >
> >
> > On Fri, Jun 19, 2026 at 10:27=E2=80=AFPM Takashi Iwai <tiwai@suse.de> w=
rote:
> > >
> > > On Wed, 10 Jun 2026 08:52:31 +0200,
> > > Sean Wang wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Jun 9, 2026 at 7:19=E2=80=AFAM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > > >
> > > > > Every once in a while we see a hung btmtksdio_flush() task:
> > > > >
> > > > >  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> > > > >  __cancel_work_timer+0x3f4/0x460
> > > > >  cancel_work_sync+0x1c/0x2c
> > > > >  btmtksdio_flush+0x2c/0x40
> > > > >  hci_dev_open_sync+0x10c4/0x2190
> > > > >  [..]
> > > > >
> > > > > It all boils down to incorrect time_is_before_jiffies() usage in
> > > > > btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expecte=
d
> > > > > to be terminated if running for longer than 5*HZ.  However the
> > > > > timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5=
*HZ)
> > > > > evaluates to true when old_jiffies + 5*HZ is in the past i.e. whe=
n a
> > > > > timeout has occurred.  Using OR with time_is_before_jiffies
> > (txrx_timeout)
> > > > > means that:
> > > > > - before the 5-second timeout: the condition is `int_status || fa=
lse`,
> > > > >   so it loops as long as there are pending interrupts.
> > > > > - after the 5-second timeout: the condition becomes `int_status |=
| true
> > `,
> > > > >   which is always true.
> > > > >
> > > > > When the loop becomes infinite btmtksdio_txrx_work() loop never
> > > > > terminates and never releases the SDIO host.
> > > > >
> > > > > Fix loop termination condition to actually enforce a 5*HZ timeout=
.
> > > > >
> > > > > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt servi=
ce to
> > work")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > ---
> > > > >  drivers/bluetooth/btmtksdio.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/
> > btmtksdio.c
> > > > > index 5b0fab7b89b5..c6f80c419e90 100644
> > > > > --- a/drivers/bluetooth/btmtksdio.c
> > > > > +++ b/drivers/bluetooth/btmtksdio.c
> > > > > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_s=
truct
> > *work)
> > > > >                         if (btmtksdio_rx_packet(bdev, rx_size) < =
0)
> > > > >                                 bdev->hdev->stat.err_rx++;
> > > > >                 }
> > > > > -       } while (int_status || time_is_before_jiffies(txrx_timeou=
t));
> > > > > +       } while (int_status && time_is_after_jiffies(txrx_timeout=
));
> > > >
> > > > yes, loop continues only while there is interrupt work and the time=
out
> > > > deadline is still in the future
> > >
> > > I stumbled on this while backporting to distro kernels, and I wonder
> > > whether this change is correct.
> > >
> > > IIUC, this essentially makes the loop exiting right after the first
> > > cycle; the patch changed from time_is_before_jiffies() to *_after_*()=
,
> > > not only the logical OR to AND, and *_after_*() returns false, so the
> > > whole condition becomes false, too.
> >
> > The intention is for the loop to keep running as long as there is still=
 an
> > interrupt left to handle (int_status !=3D 0) and the timeout has not el=
apsed
> > (jiffies < txrx_timeout).
> >
> > Note that time_is_after_jiffies(x) returns true if x > jiffies (or jiff=
ies <
> > x):
> >
> >     /**
> >      * time_is_after_jiffies - return true if a is after jiffies
> >      * @a: time (unsigned long) to compare to jiffies
> >      *
> >      * Return: %true is time a is after jiffies, otherwise %false.
> >      */
> >     #define time_is_after_jiffies(a) time_before(jiffies, a)
> >
> > Or am I missing something?
>
> Doh, scratch my comment.  It's enough confusing about time_after() vs
> time_is_after_jiffies().  Too hot here to review something today :-<
>
> Sorry for the noise!

Haha, no worries, it got me too! (In our internal discussion with
Sergey) I had to look up the definition and think about it for quite a
while to ensure it was really what we needed. ;)

Best,
Tomasz
