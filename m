Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E92459C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564801; cv=pass; b=CxEMTuDWuHdgszWR4XRArf0rNuI4yXi5NICJhpDPRseRW0W6CV4cbBIlZoOzTPXdgITx7WUyhLWnmLwmTHlMoHd/aAARXvVirMozPJgJYmp34CTV6g2Y+kCMvDzaJiBXDeI5Q0nD3UmP7jPr+Mp+QEoBX+fW6wh3Mdk5AjQR08Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564801; c=relaxed/simple;
	bh=G8uHMCU6DkNS0Fyx01VMiS4DZIEmT2KHvMiahnvdKGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyV8KUMdgA3PUTbZ+y5QnsLO8MKZe3jQ4v9xmuubISP19vVSsxECLLPottNl30FiTa0Nc8fjxFM2czhIXg2O9YWrpPKLTt2pJ+DicyFdteixssuwLgcXTaOIxE6QbRRftP1PwEHBgFN2XN547dWBLM73aA7UL3fUrQfo3qBbeYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX3gdXG/; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX3gdXG/"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64c9ebd1369so5493896d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2026 11:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772564799; cv=none;
        d=google.com; s=arc-20240605;
        b=ei1O1vIQvXOvXol8fzkoFicAr9n1E1BSmsIu/rOwUhztaqj4i2wx6j1ZZDgF7+AcN9
         +8dUzMCxgsRhOzRPKIpvnmns10ZXy5fvXU61sLsjqo1h258zVSftBkrkTtA5jwtv+SOx
         5nGLu7jE8BxRKoY3EL4jBFbrozJrhBBCVfrUo8hdjIkb/TMeUouCKjZb+ZMJ/qvg9+qk
         jeSfCgugRUPfdsMVN7CaCEhdpIqGxGC35b2SNPE2USrm9LiawjDBrRiJlVdgthBYpxLZ
         4+HqoEzlefRndcqHtLEsksSZRjmxQS8S6B9fHYYQyl3bBgqdu1wYULLqBTGFrSzXOedy
         ALXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CumFuf11UIGRam/s8MbeEydEJtxmfbLsnbb5AxU2cO0=;
        fh=h0eQ6x2YQvNL1Vl3qWYaFuXONWZvTAzm4sX7XrpcDBk=;
        b=F1/CQwDZmx4cDfxABMMjm222aAZntuTFWQFcoMeGprY6ylOEDT8x2SwTQ/6GRl8ie8
         voLaRj677pP/Sytk6gjgX3vvVDV21l9rmmwZBH5SPyVOkGxRRKE97naS6qD2KfKWG8mw
         we2C54f9GnAKfzdsldNWRFG44PDhRyHUa9aFsKpIFBZsh/hDeQyBFeMKpxnx6PsDeoFd
         hb5SwjCJdlcLYJfLFmtvO0fGrpYt9XFmagQRMxArvvUUNpE+A+gZZpoxTv4LX7YG7EDY
         Ipyw7vSLuL3qLqDrv69H0b3cYE8TVZK2HLGcNt9otHjWcnCkhR4KA1J141mSUcc7Zqcp
         vtmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772564799; x=1773169599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CumFuf11UIGRam/s8MbeEydEJtxmfbLsnbb5AxU2cO0=;
        b=lX3gdXG/83+M6U7huVVRjUAbdqOfllUYOun27ICDBMxRAreBq0Yt9TKgK3boYBmVue
         jimkb/z9EdrAo4ESam3WL5KGiUdi7bFk61hDsnNJ5svAA9BGVub/26gdrXArVPWMRVAv
         XK5Hwh3nnd9AVGJFFjdVw/lrIxsqmeJ93TH6kk9351eKFL8FXZM3IJu3NASrna9GIC3j
         XlQ2WioJHbyeUWxAkQsj96Vi6+vamaUUlyAo95wahxAvckMeQTO0SdVv+kynPZ17anwe
         2vAir2AxIjPnqkMVN8NPzDVG44mdjwZVH3t/LiOYZxFRayroB55+OC1jE9XVdFPLYCrg
         i3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564799; x=1773169599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CumFuf11UIGRam/s8MbeEydEJtxmfbLsnbb5AxU2cO0=;
        b=lQqdy5DLaTf/3BTy3v/0DX61ZgZWNagJeLTp2kkrMM37oAYzvWKh6DxweJt6U/ftns
         7emJ05w48dbfMtxyEdTyXUFKOqB1PMmopNR5gzfukhroBStxkTifHGdU90udr8oXcrVY
         o+QgoaDCmGYSULkY9hFyh4NfWXFsHPU/XRM4Honah7qbmW35+POdFpRI2+xsgpSyOO2w
         6NpIcbIyfG8nyZ6xa0Umxox4S6mFKtZcfi7aOA+WkElviWPKerZBezUHLJcKj+YQ4oHh
         Yrg2hiLb5nmlEdaxBWPTjMRcq+k1nyIUL+YI9h7xqKtcCPhDVIqW8mmTTnf8dO0W8VU/
         BMkg==
X-Gm-Message-State: AOJu0YyN/ojfJkdrOw/EnObDUVLyorLTCGvn7Q+weBQqDG3Fd5DEomOn
	D0QJEMdfZLEVnCX1BffzqHqCnu1lCDrIjiZpjvDsbUaRZUxWYhNYsgD7kZAoQNAmR9TtHZkZNFa
	IG11qCUmmTMooj1AMzufj+8vagXvaRml6IdRc
X-Gm-Gg: ATEYQzwsMwSJ3hGIJHjGNNvPbZFuMfyrZf1t8p3j8cmqbZW4AhPAKwRQ/IICOBtCCX+
	w7m1g672kHhw+zWhw+gz6hF2X1LIpJVv3PlLiakKkqdcyBQBddjCFqNM3REZc2eNVAJ/ZAX3ssq
	RWCrSn93LBuZshB590y93JsCpREZRmkjOQzsAI0gUjU0ty/jywPSnPhkoD4rKSCVu98mRtfoNhQ
	4IgYCdLsNE7fFtUJpRwHzoeE2Ny2QgITNSjYlHWNESfJTfKud5U1T1lWOHHPh0tyQMltLUn9zAN
	Z58gS/YuMF8dwOjyJ1/6GESokhx6YMmJs+9P+Dn9q3M7MxYC+BtyaRKRlO0oTKGpKh2uNQ==
X-Received: by 2002:a05:690e:11ca:b0:64c:f740:cb3c with SMTP id
 956f58d0204a3-64cf740ce7dmr528128d50.12.1772564799361; Tue, 03 Mar 2026
 11:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302092203.12775-1-pvbozhko@salutedevices.com> <CABBYNZ+MZfgSbfcjH+CuKaK978FByLogXDvJh+m7frFPY-Gdvw@mail.gmail.com>
In-Reply-To: <CABBYNZ+MZfgSbfcjH+CuKaK978FByLogXDvJh+m7frFPY-Gdvw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Mar 2026 14:06:28 -0500
X-Gm-Features: AaiRm51EUX0EaL7RJZ00NPINLRFuIzGH0iXroJPsCHYxMh5h-_IWWAADpvjgOd0
Message-ID: <CABBYNZJ6S_s8GLrtRyanve3REVugTTRY0Aaqdk3o26iip3kWAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: fix EVENT_VOLUME_CHANGED not supported
To: Pavel Bozhko <pvbozhko@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Tue, Mar 3, 2026 at 1:57=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pavel,
>
> On Mon, Mar 2, 2026 at 4:23=E2=80=AFAM Pavel Bozhko <pvbozhko@salutedevic=
es.com> wrote:
> >
> > Some devices with AVRCP 1.3 may support remote volume
> > control=E2=80=94for example, certain TV models such as:
> > - LG webOS TV UM7450PLA
> > - Xiaomi Mi TV 4A 43
> > when they act as the audio source, provided that
> > Category 2 (Monitor/Amplifier) functionality is supported.
>
> Just because these device do this way doesn't mean they are compliant,
> afaik SetAbsoluteVolume and  EVENT_VOLUME_CHANGED were introduced in
> 1.4 so there is no way for 1.3 to support them.

Just confirmed, they don't appear in 1.3:

https://www.bluetooth.com/specifications/specs/a-v-remote-control-profile-1=
-3/

Maybe you are suggesting that we automatically bump their version if
we see such usage, while this could work there is also the possibility
of qualification tests to start to cover such behavior and require
failing, so we might need some setting if want to allow version
upgrade like this.

> > ---
> >  profiles/audio/avrcp.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 724b46c59..d501315b6 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -1765,10 +1765,11 @@ err:
> >         return AVC_CTYPE_REJECTED;
> >  }
> >
> > -/* SetAbsoluteVolume requires at least version 1.4 and a category-2 */
> > +/* SetAbsoluteVolume requires at least version 1.4 and or category-2 *=
/
> >  static bool avrcp_volume_supported(struct avrcp_data *data)
> >  {
> > -       if (!data || data->version < 0x0104)
> > +       if (!data || (data->version < 0x0104 &&
> > +               !(data->features & AVRCP_FEATURE_CATEGORY_2)))
> >                 return false;
> >
> >         if (btd_opts.avrcp.volume_category &&
> > @@ -4293,13 +4294,13 @@ static void target_init(struct avrcp *session)
> >                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> >                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
> >
> > -       if (target->version < 0x0104)
> > -               return;
> > -
> >         if (avrcp_volume_supported(target))
> >                 session->supported_events |=3D
> >                                 (1 << AVRCP_EVENT_VOLUME_CHANGED);
> >
> > +       if (target->version < 0x0104)
> > +               return;
> > +
> >         session->supported_events |=3D
> >                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHAN=
GED) |
> >                                 (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHA=
NGED);
> > --
> > 2.50.1 (Apple Git-155)
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
