Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75930477E52
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363330; cv=pass; b=YirO/W+W+ZRkWpgVzUSs+BbP8jEU8m3rjCakMuM+fLim7qkYb9YnEQxSWL4Tv55the/Pg0Doaqizwy8kLrTMb1lALGN4DOYHBUYXhOK3QSH7s1Bk0497abeYFMGmD8lDvQMfw9X4puk24ZSdOBFFouMfExfSg/qeSVT3b69Zu84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363330; c=relaxed/simple;
	bh=6yX6rIatF65AXTF7VLh+c16smqDVEnutfSMKky/6+RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO7hWobIE4IBLsSYXnbHWzSvd7egGIxGRtIeyje4e22wDd+FsIjogVzMX83sfC93uE8ghB0Zuwb4SU7QQe2JdXYaN6XCfAocIK0SvsPmnOGrW/GGEP7ljFb3RgHDFZNycRi1H1A0tGSje6H+aF2UBuBhZYFXSqEmvJQrR2tqt4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKIdwGPm; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKIdwGPm"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-85dbc24d398so18909927b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788363325; cv=none;
        d=google.com; s=arc-20260327;
        b=VfQssZj/xU1vGllTmB819jGSGbjh8dALmlcKRDYjmVoCfnK+aDzh/9vaza9TPEsWdq
         IjiFtTxzBvtSKvGb2uB7aDM2MHsbjNh6BYLImyEeKfQbbdBOdO6g5l+yUibFRBkV8aTc
         j6sNdemlqfpMp1hk1f+3mIiSMtUndRudrBAZiWgwh50dru8oDrxbFwu53+JIms+L3g5H
         xakUk2yd0A7jKxgcO9YFurTzmkfZ+H/wPUstkVHDOZKBVQNkypd2W6O1yZVN2wwQQsbd
         ZPXPbCFmWZzJUCNA6WRD+Xq8vss2xJigpQ/zQ/4MOatG7S8Yf8dSDeHFUY0bVQ75ONWh
         yd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+u5bXX38nKR7Gv2xRsRraOYUsu+zleBIUl0eKi7Cxdc=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=FFiWSt8EACkzx+HF0ZF1NE1qggS3iN4RI0LJiEkirehdLnPiUhuPXZO9/9IA429Vem
         BnGzM9VzhYU/r0WQx6yyZg6WOVnfq5GGUkSlHvx85+M9y8OWI6EA6zV+aGxK/qPXiHKm
         0uoEz3Ko73QzCHbaLxcZL6qNpTTBy3bQrVREwGufpO6T6SC+22g/6jUNrTcAR7DixRpJ
         a6GpxjV20lZHLdUFXAg1wPrhVxotFP0lfaWxKc8Fyjc2zDBzIj1RcXiXiQv+3sE/rYZm
         4Nn/6qiuvo2iXg71aQmkk+eYafBTWm/8VYUCgip5Ri3j8CbsZO9MFLtNWrgignGSAGlN
         migQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363325; x=1788968125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+u5bXX38nKR7Gv2xRsRraOYUsu+zleBIUl0eKi7Cxdc=;
        b=bKIdwGPmulEXMTQApKqdvmTww8s7yg9HfV/jB+/bHXoTFY1/WSoOQEsWSaKFWmGE2i
         mjARMn7jGTwsoQmp88A/K06nI+GRAj/TbCQvdma7wvKtmWQ+/ubWjOMwZtHXEOqPg2CD
         mJbW713fhmbtR1Od4wY7R9eQ+U0sMh9CdZJnPGEMuC6/nelnrGhGFru6fevuyRq/cPOp
         FVMMREl4kGjqhNSqItSxFES6SiUacZVaxpH5EM13mT/uIz4czsbemqir9mwTF2oJ7Jzr
         HMK5tTBjYMDNdjkimdcku4hw8G97cNHj/xbR9iL6uDA7GVVMzZMUaaWRmLTas3B/X+su
         /V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363325; x=1788968125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+u5bXX38nKR7Gv2xRsRraOYUsu+zleBIUl0eKi7Cxdc=;
        b=gTW2aUHIFN9TNGlkQSAq82dQx+yl1zR9IebOODMX3PJR90mfIByJDGHTSQ0njvLl+0
         YjDjAtLIHR25KaqB/5G/5vMypMDrb8mlsGOR3FgxXWX4knNpQT2TuvbnmE1UGRo3BI3D
         IRBYQh9TC1Plfv/GMi1b4DEchxiyGkDi0LLuQCum2pBOm6oi+NBZTgiwARUQF6O0yfIJ
         JGMyur/Zoc7WyjFNhepD0DxTeCT84cHiJbq9d7BpTuVOG/JnMeARBFxhJ+e/tyuazQMd
         65GrQ0YD+eeOW+/X8TJ5Z+sR9RQKH4k1aNzfqwJI7jgsnycfYA54Km/pLoiq5FoPSoEi
         mGEQ==
X-Gm-Message-State: AFuF++nGKST2m/4/YEbMcwh0nZHY1zdPnIiF7xSTmQv9kCNBx8hOSNQf
	GEq5t/ZJgixYROEYNTHxdNo/9FgdkhjFukdOu44WV7njWFTCHXhH01yiRS/iDKCWJRYdgR2V9AL
	paIq0cRlHlGhv/ZvjhC+B8LDA/rCc4eHbqw6FuCXjaA==
X-Gm-Gg: AYBFou21esgZokReT9Z0IKB/mYQLX4GDQNIKBEj78XLuN4gkoyi1+i9zH9xR896TC1p
	x5p82OaSYa3b2V2xA+6OQHi7iREYLE5JrjMauFFy0oxO2+2XYy9c9ljquzFWSIRg6ybabuBFNYW
	eMUfeopKn7AjrbOG00d/MNFto3MmqWe4S3DQ0XY525BcaF6P7eCoeyPXNikoi9G40/cr5U8RWdH
	0ppkNtQ8A5YPrJDGE/PKy5H3n4RV5IaxcvHi2NE0znX7XxRLZQZ2ggBQdCyGUevkYPgAnYn4qOL
	p/GZA7EIE2mjTI0Y0be30raFnnHqrvWn+6fodgq4l9x2jP50nq0N6lkXjADe8G55+4Q0VITtqfx
	i34lQIRizu2Bv0fqOSj/PLIlfasg3KXo=
X-Received: by 2002:a05:690c:d94:b0:81c:eca8:dbaf with SMTP id
 00721157ae682-86c5435cec4mr32744727b3.31.1788363325383; Wed, 02 Sep 2026
 08:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831061144.7767-1-raghavendra.rao@collabora.com> <20260831061144.7767-3-raghavendra.rao@collabora.com>
In-Reply-To: <20260831061144.7767-3-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2026 11:35:14 -0400
X-Gm-Features: AcwNN1XsuAZYpc8uY_TT-Y7i4U_Hs_e3pJamuHVR1lQ6mEZJ_l6iACvPihaXGBM
Message-ID: <CABBYNZL=tUS6mW6FtKu2=BPqLqb6+CP6FE-S7LWLntPauxus2w@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/3] profiles/audio: Support MCS track position writes
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Mon, Aug 31, 2026 at 2:13=E2=80=AFAM raghu447 <raghavendra.rao@collabora=
.com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> This is needed to Pass PTS GMCS/SR/SP/BV-02-C test.
> ---
>  profiles/audio/mcp.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index 4df388a22..fc9d2dc73 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -835,8 +835,24 @@ static uint16_t mcs_playing_order_supported(void *da=
ta)
>
>  static bool mcs_set_track_position(void *data, int32_t value)
>  {
> -       /* TODO: add support to setting position in org.bluez.MediaPlayer=
 */
> -       return false;
> +       struct mcs_instance *mcs =3D data;
> +       struct player_link *p =3D mcs_get_active(mcs);
> +       int64_t position =3D value;
> +
> +       if (!p)
> +               return false;
> +
> +       if (value < 0) {
> +               int32_t duration =3D mcs_track_duration(mcs);
> +
> +               if (duration =3D=3D BT_MCS_DURATION_UNAVAILABLE)
> +                       return false;
> +
> +               position +=3D duration;
> +       }

Are the seek and position values in different units? We should
probably document why we are having to multiply it bellow.

> +       return local_player_seek(p->lp, (position * 10 -
> +                               local_player_get_position(p->lp)) * 1000)=
;
>  }
>
>  static bool mcs_set_playing_order(void *data, uint8_t value)
>


--=20
Luiz Augusto von Dentz
