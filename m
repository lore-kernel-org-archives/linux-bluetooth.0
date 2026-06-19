Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE10337B81
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878842; cv=none; b=MP+07WDYv4dZLETTXWZ2+2J5Jta4OjFsKKGvgiTN1u8chryYuG/BLl+qBjg8QHmkFaFz5tuiXp0FzneWov9sYuTuLmnnmRxTCp6bV225bEXQNG+DB75Oo2OMctGi5Pp/kkFGYNL4sJNWkwcEzM0Yn6Ehf66FYlu5Bxl+WsJvLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878842; c=relaxed/simple;
	bh=gJs7xtR7xm1gIzB99bRuyJh0Tdg/gw9Rplvwc1PxAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azRvh8V1LGiv4M46YDSBDwNOIY8TOvmvCzOvwekN7BCuDhHBQ3JWuWX56DWiRHu914U3YTAbwgN21yWevOOpeF3cLWzncxpZ+JbwOVs8/8nf9EqgrD49ISrmQpuPGwqSntWV/XRFMhUDRVbNrt9fOCteg+xtqF10fVSUmNNmR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MXeiP+XL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MXeiP+XL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-519defad0d9so13125041cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781878841; x=1782483641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbcGH9ITMmOI3YSas2gsikCqBTKnvtgdWwDyBNbyusg=;
        b=MXeiP+XLsA04Kun2neJfM9Bs3uAi43aetm8HtOTvx65bVsnsSncUqXiVkN6F5O/5HT
         xcY0cQlZxH2LqVMuRe3YFh7NTzLaU7yVNIOzBaCCTtNI4ztaXOroqEoVFTjEecupVo/0
         tCrEF6NNbJiZi4E8/z9Vo5m+sf1mGmMeWyw14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781878841; x=1782483641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbcGH9ITMmOI3YSas2gsikCqBTKnvtgdWwDyBNbyusg=;
        b=KNFzmW+MVSeCCG2nAlFB0sO04D6Z3f8ZSqVq0GYLT0g/D1g+vGPWp3fcYumM3Q537N
         tx4HTIwJm93JBorHLpoHD+gQGjzVfjf+ObsCl/cDXoruiOZhRGcm9fKwyD7N5yuNwNxO
         yTPoWyAVRzznYZbXJFA8P6wCwp14qJbTMltZYJOHS1m45xXGovDH1hxoed13W2Lgyua1
         9kF94KQHHt+pGfysMQj+DoCmlndG4m4pYwi8PRdN4VGzvYRL8bkHf5Oy/rs8p+/OnEOQ
         HxYRyrOInFEBKFC3j61qDQJDmvRKjTo9Zq4qviwl5QnrRV/kT32jeR8gmFJVxkPPWQvO
         KsYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XD6d6hrJau8o71if0A/tyhVDcGbPKDvlDn3RbqR4DAiQRyiUD0D9MXkMD1+08336fe3ylPzdkJiCuxQ4ek+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYP/wEIjsfN4lvjCffVIj+mM2QuX1PUbdKWfW243Tz6mw+9bkC
	Zsvm/Sj7Vufthx/Tq9mSFiULmE87qRe+G28/ndljKowh1NSGuxoTo9dYLJoFOFmHNP/OVTFf+70
	e/eeyjw==
X-Gm-Gg: AfdE7cnr3/dFxdGQxmCRXbM0NCZ+4Q6snvwRHI1XMQ93ygafRjErrPc3k6bbCab6lp0
	ArzBGVz6nne47xuAvksSQ5su4Gt7FUOv0zFMvhT4fStlLIIyyr4evST/7Ra2Rsbg0fTkC9iV+1W
	aJ27vjWId4WIpLwKQ72SjtfrreRU8Q2gQZY8Elld/+dIxXEUjzMvxsdTzCAiyCxRVj9o7RfCeZI
	qAkhwvYUmJM3+pYdREE0WfPaBAP+cr6cM/8dzxP4IAy48tjiZdcD0Qv19ZUgdXQBNDLjrRBupLf
	T872OeZVT88r/1Ftt6VzIwlEbGut+ycKDcPKfTW0YaZVjtjIX2+VZY3evAZvITLq+zmX9gvQWcA
	tSKTm9C5RY5j7oGUwnVnR652iX/65GyIaXIcUjPqATgBiwiJpGkPWeZcyDN+6Uoj5C5sqP4KgnY
	ciNm4rIFyYA/vN80dda38F4bZkgQOzhQtFny5U+bc6/L9D97tJjQg=
X-Received: by 2002:a05:622a:aac1:10b0:519:edf2:1ada with SMTP id d75a77b69052e-519edf21fdemr29042141cf.32.1781878840543;
        Fri, 19 Jun 2026 07:20:40 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e4e11f68sm21039441cf.1.2026.06.19.07.20.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:20:40 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519ed52bcc6so186251cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 07:20:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dlNPgdCDiX0DuaD7V+VlFyscsZPbvED2Yp2J6xyJgsm/x2Sdjmek50IRvNr9IqWKn09RnBMR+PhPHERjwzzM=@vger.kernel.org
X-Received: by 2002:ac8:7d8e:0:b0:516:4f62:85ec with SMTP id
 d75a77b69052e-519e8d1f14dmr7406931cf.17.1781878838041; Fri, 19 Jun 2026
 07:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
 <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com> <87tsqyirsn.wl-tiwai@suse.de>
In-Reply-To: <87tsqyirsn.wl-tiwai@suse.de>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 19 Jun 2026 23:20:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BtO7vL_A2i84CoF1Dk7Bmp_DZQJgoNAB-HyGA89=XDUQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfvj7Tldb-rRHpdw6zA1vefldpMM6jJzOD0R18t-VmMpCoygqlJxAYuFRA
Message-ID: <CAAFQd5BtO7vL_A2i84CoF1Dk7Bmp_DZQJgoNAB-HyGA89=XDUQ@mail.gmail.com>
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

[Resending without HTML... Damn Gmail]

On Fri, Jun 19, 2026 at 10:27=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Wed, 10 Jun 2026 08:52:31 +0200,
> Sean Wang wrote:
> >
> > Hi,
> >
> > On Tue, Jun 9, 2026 at 7:19=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > Every once in a while we see a hung btmtksdio_flush() task:
> > >
> > >  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> > >  __cancel_work_timer+0x3f4/0x460
> > >  cancel_work_sync+0x1c/0x2c
> > >  btmtksdio_flush+0x2c/0x40
> > >  hci_dev_open_sync+0x10c4/0x2190
> > >  [..]
> > >
> > > It all boils down to incorrect time_is_before_jiffies() usage in
> > > btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> > > to be terminated if running for longer than 5*HZ.  However the
> > > timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> > > evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> > > timeout has occurred.  Using OR with time_is_before_jiffies(txrx_time=
out)
> > > means that:
> > > - before the 5-second timeout: the condition is `int_status || false`=
,
> > >   so it loops as long as there are pending interrupts.
> > > - after the 5-second timeout: the condition becomes `int_status || tr=
ue`,
> > >   which is always true.
> > >
> > > When the loop becomes infinite btmtksdio_txrx_work() loop never
> > > terminates and never releases the SDIO host.
> > >
> > > Fix loop termination condition to actually enforce a 5*HZ timeout.
> > >
> > > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service t=
o work")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  drivers/bluetooth/btmtksdio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtks=
dio.c
> > > index 5b0fab7b89b5..c6f80c419e90 100644
> > > --- a/drivers/bluetooth/btmtksdio.c
> > > +++ b/drivers/bluetooth/btmtksdio.c
> > > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struc=
t *work)
> > >                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
> > >                                 bdev->hdev->stat.err_rx++;
> > >                 }
> > > -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> > > +       } while (int_status && time_is_after_jiffies(txrx_timeout));
> >
> > yes, loop continues only while there is interrupt work and the timeout
> > deadline is still in the future
>
> I stumbled on this while backporting to distro kernels, and I wonder
> whether this change is correct.
>
> IIUC, this essentially makes the loop exiting right after the first
> cycle; the patch changed from time_is_before_jiffies() to *_after_*(),
> not only the logical OR to AND, and *_after_*() returns false, so the
> whole condition becomes false, too.

The intention is for the loop to keep running as long as there is
still an interrupt left to handle (int_status !=3D 0) and the timeout
has not elapsed (jiffies < txrx_timeout).

Note that time_is_after_jiffies(x) returns true if x > jiffies (or jiffies =
< x):

/**
 * time_is_after_jiffies - return true if a is after jiffies
 * @a: time (unsigned long) to compare to jiffies
 *
 * Return: %true is time a is after jiffies, otherwise %false.
 */
#define time_is_after_jiffies(a) time_before(jiffies, a)

Or am I missing something?

Best,
Tomasz
