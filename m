Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC513AD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135486; cv=none; b=SrJ/ccCVD2UyUr/XEaDXO1aBj706Z0MicpGvq0QWuEAqpHmjYVnAM2YoCuAAMHT77EwGPnPnqEhEJN9lC7oU48yDSD7q3i6zHWVQgr7KcYJdyzTpn28Q+okmt8WMFgwpzFouIjfNru3asXf1JPIqpmzCIuLkiRZbHoKqD3AR+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135486; c=relaxed/simple;
	bh=vn+N8W9GvgDy4Pdpx/OBBQdTqNzTc2BgT55uV8OamxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBHjdlgekBO+e8ZZuOCTGUBdMz8ZxU6+JwcQifBxnDjG2lrxLfHQDvDMWlrCYRKIm3Kazl0o0L/40YfsLlk0RxU57aU7WVM1Uqjt9X3BQ04OwJ6cmUBZISqoo9CM/FL9s4h1fOw5BuVp9fOuFck8FTc+SosntBiA6voEae+hutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=qkJbtdIe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="qkJbtdIe"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3487370a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1730135483; x=1730740283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BHLUPcGa9hexwGkGD247QxGCfsLHvY9jhtMvleI0Wn0=;
        b=qkJbtdIeubzSMsUY8VByW9ixmgJCCZeOLLKZNm1McmgpTgXwe4enwWoPxLbgGt3g8A
         g2ZQJ09PvkUHM1XtCB7kyknOg8WpwkxFWe0On8BYM+NN/jsm89+Jcvzl5ePMOiGrqyR6
         WunsHSfDvawoO78InoM8mR/ocmgPmD4ob2Sxqb/Lthb0bE9GzFF/486Bg5ho1mdD2Dhn
         C/oClwxr0BsCH0gTyaJb9zMlPwj1ByYvqYSWA9J0iLfFcS3sPPECDBm4tjKk8Biit+a4
         fnHIWs9lZGlXSrt+FX1TTZgltK8S7IKDBRR+VcBrD1M3c5zSGbMi+p1RRktb6CZQZUMO
         tzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135483; x=1730740283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHLUPcGa9hexwGkGD247QxGCfsLHvY9jhtMvleI0Wn0=;
        b=X5yAjQ7/796ImJnK6SbE2j827h+FP/shw2yn/SFgb/yDkoba7yrrNSEfAwfCY7jzBj
         3w0bVrTu0LVZtbu7DopLx6YihvHi0IG0yUqrfb9rybZqVThYxZL6cJaKh7klCnbmS9ly
         GafjjtrypejUNIDY4agrfhbiLkgOGsuepDtJLsx+nPtnbA/Rq0Ci9C2faoqkdWsLVbQ9
         mw6cdwyj2e96pE5Sb4tuKd9cOH1ke4qPZDixDPgAOpxHnb2GIBrtlKsAV2Fr8hkt9+a+
         myIr0WRZ2/Gt41S43Av/OjLlUMa6oqVIq9cbgvcHq8pFfjTHF54CNHSjPYwDy/06LePB
         7ZiQ==
X-Gm-Message-State: AOJu0YxU99wCefH9M6QwMpxDU0KbQuX/BVG87cwZSB0D9FtMOxab4Ehx
	9F/MKLez92OXem/mGwD7ewV2KrH4HX9AVmsc78pbaWTGuHuehS6W64V6qoBGNj8=
X-Google-Smtp-Source: AGHT+IHKhHcEcF55bP60CglbHALS4t6R/g1Y4SbT5iBGLNA6o+KkvfK7D1Sabu3FBSOjKjg92p8fYA==
X-Received: by 2002:a05:6a20:4f19:b0:1d9:275b:4ee9 with SMTP id adf61e73a8af0-1d9a83ca160mr9161456637.15.1730135483333;
        Mon, 28 Oct 2024 10:11:23 -0700 (PDT)
Received: from localhost (118-92-78-251.dsl.dyn.ihug.co.nz. [118.92.78.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771a1fsm7523460a91.57.2024.10.28.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:11:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 06:11:19 +1300
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if
 the stream goes away.
Message-ID: <Zx/Ft7upRYfGVD4f@fermat.nev>
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
 <20241025202141.158946-2-daniel.beer@igorinstitute.com>
 <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>

On Mon, Oct 28, 2024 at 11:04:20AM -0400, Luiz Augusto von Dentz wrote:
> Hi Daniel,
> 
> On Fri, Oct 25, 2024 at 4:30 PM Daniel Beer
> <daniel.beer@igorinstitute.com> wrote:
> >
> > If the stream goes IDLE while we have an outstanding request, connect_id
> > stays non-zero and is never cleared via a completion callback. As a
> > consequence, the profile on this device will never be connected
> > successfully again until BlueZ restarts.
> > ---
> >  profiles/audio/source.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/profiles/audio/source.c b/profiles/audio/source.c
> > index 9fac352c8..db777e86d 100644
> > --- a/profiles/audio/source.c
> > +++ b/profiles/audio/source.c
> > @@ -134,6 +134,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
> >         case AVDTP_STATE_IDLE:
> >                 btd_service_disconnecting_complete(source->service, 0);
> >
> > +               if (source->connect_id > 0) {
> > +                       a2dp_cancel(source->connect_id);
> > +                       source->connect_id = 0;
> > +               }
> > +
> 
> Is this really happening or is more of a fix based on disconnect_id?
> If that really is happening then we need to fix the sink as well since
> it appears to be doing the same, that said connect_id may be set with
> a2dp_discover which can happen in AVDTP_STATE_IDLE so in theory that
> can still be ongoing, anyway this code hasn't change in very long time
> so I wonder if this is sort of workaround to specific model or
> use-case we haven't tried before?

Hi Luiz,

Yes, it is really happening, and yes, the same problem occurs in sink.c
(see patch 1/1). We have a client who can reproduce the issue in
automated testing with Bluetooth A2DP devices, and who has tested the
fix above.

The symptom we notice is that PulseAudio complains about a timeout
connecting the A2DP profile, which is never attempted because
{sink,source}_setup_stream() never appears to do anything. It returns
immediately on the first line test because connect_id is non-zero and
stays that way forever.

Immediately before the sink/source code stops working we see a
communication failure in which the connection is dropped while
a2dp_discover is ongoing.

Cheers,
Daniel

> >                 if (source->disconnect_id > 0) {
> >                         a2dp_cancel(source->disconnect_id);
> >                         source->disconnect_id = 0;
> > --
> > 2.43.0
> >
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

-- 
Daniel Beer
Director of Firmware Engineering at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
