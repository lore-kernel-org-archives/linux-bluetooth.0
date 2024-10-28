Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0E1DE2CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127880; cv=none; b=ZR/5TtwxGZ0nyzlwnF1QJ7aTDCdgymOSIX8E97+GdiLbxRWMVNRG1ggS1O4oNukdNVmjSRySdMQNO6S5ConXp5XqoU4GNCp9VBbNHCNmgSYkXoeVteBRGoNdrE468/9YkwfAzLHXHl3xaL90Fd0GCLYv5ZEr7hWuIyopDcaAH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127880; c=relaxed/simple;
	bh=y14zLqKQA7KGv5Rh1L1qEIv9XGWkw/cEsEEi77mDlm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Od2DbAkQs+nbYiIwyvFcZodf4lNN+nLxgPGNMwLX1jCUdQaevpE6x1kxKsQdUCOHphT8NuXcrCKMC+0c6AHFXFd7Nhq7+PP2NvbbiW0owdVrrqR7BVD1PUb9+9zK1QgZP0Df004ymLsTf/J41+Tos53eV3L50HSF4mABwpsgBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUx8g9dZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUx8g9dZ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so41947891fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730127876; x=1730732676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkG/js8BcANsL/wgDsYRzcmWd04CR6lCPIcNLPCLc4Q=;
        b=WUx8g9dZ53DCtpII1xn43XoJdzMv5B5s1mUFcMzTaBad66p1h7TrBeUZv92npFJW4s
         uz1dXww9yonR7zrmXGMacjkwW+OJ6rg2Np3+YeKe1C2rAUHIfwAR3p6+lrh16xXsg9iR
         IQc7vG7SPRcZI8RNEkWQG02tDF2V20v/zrT6iQ0TIgf7BPxJHRE6a43XHO6G3xzd0TMv
         91Y8M/vWPfDiWFhAva2i7G2MPf2bjeTfc5cTtivvCcSH0zq89ESMM+KYy4UCVZkt2QqH
         uNXDj0GMenMIVHyyNWqWGOh9i4ZYGvC4GdfcsgY1g+L7RSQ4Cb3pBlXkaHYWLJS0VzCJ
         nTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127876; x=1730732676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkG/js8BcANsL/wgDsYRzcmWd04CR6lCPIcNLPCLc4Q=;
        b=rAzDvnQMYSvxOwPRbBcJkh7mp+j4HQezcqPmVRb40D+oBmIT3155EWszwl3vLZrLMp
         Vup+x+VeEZ0LYQXNy//RAe9nr8uCeU+KKlcnQFAi5wuHG/bb+EHE+Zt4HPHX+4AIwMSu
         Ja8uNaLlIRpWPatGmvKE17sle4dImfYHAePvGRTYaMDIZYgofVpdBmDEMbSZg+JMgDev
         YMUN/LnT84Dlk4gwO99c6CNWeTdYmq2JsiVGJaZD9GJaTytvGb8vLD6ow1x0LGQmmyT6
         ifnw5OHgXdBUeHgN9YFSCtTCLCqWB67dk6VJ/z11V8JF2enusLKfQq44Z/+5rWWyLH9+
         ZuXw==
X-Gm-Message-State: AOJu0YzDBhMeA9EdTmTjt0daijHGSZJo/r6QdhQF9kADNJqSdLtT7W2y
	udWowtQLb5UkfkX/g83ylAxfiwQViry6v2qwMZAEZfr6Kk27PgOGhLSOTKq9YwAMbCY2H/+S9gO
	HUSTx0Oi+8ju7M/WdPyPYwGRPZY8=
X-Google-Smtp-Source: AGHT+IHY1z8pqPA/2604CkzxtezioU3Rdv3cbTxifnVNXsY55wjqwswkdx7b8TwTjgpASrXPKe+wwkXTnioWfplZvvs=
X-Received: by 2002:a2e:b88d:0:b0:2fb:3d86:d932 with SMTP id
 38308e7fff4ca-2fcbdfaea70mr30774981fa.12.1730127875539; Mon, 28 Oct 2024
 08:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com> <20241025202141.158946-2-daniel.beer@igorinstitute.com>
In-Reply-To: <20241025202141.158946-2-daniel.beer@igorinstitute.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 11:04:20 -0400
Message-ID: <CABBYNZLjNgTe6E0f6oKuap+VLttiaGse3_vP3ZYFxiO7mmNfog@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] source: clean up outstanding AVDTP requests if
 the stream goes away.
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Oct 25, 2024 at 4:30=E2=80=AFPM Daniel Beer
<daniel.beer@igorinstitute.com> wrote:
>
> If the stream goes IDLE while we have an outstanding request, connect_id
> stays non-zero and is never cleared via a completion callback. As a
> consequence, the profile on this device will never be connected
> successfully again until BlueZ restarts.
> ---
>  profiles/audio/source.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/profiles/audio/source.c b/profiles/audio/source.c
> index 9fac352c8..db777e86d 100644
> --- a/profiles/audio/source.c
> +++ b/profiles/audio/source.c
> @@ -134,6 +134,11 @@ static void stream_state_changed(struct avdtp_stream=
 *stream,
>         case AVDTP_STATE_IDLE:
>                 btd_service_disconnecting_complete(source->service, 0);
>
> +               if (source->connect_id > 0) {
> +                       a2dp_cancel(source->connect_id);
> +                       source->connect_id =3D 0;
> +               }
> +

Is this really happening or is more of a fix based on disconnect_id?
If that really is happening then we need to fix the sink as well since
it appears to be doing the same, that said connect_id may be set with
a2dp_discover which can happen in AVDTP_STATE_IDLE so in theory that
can still be ongoing, anyway this code hasn't change in very long time
so I wonder if this is sort of workaround to specific model or
use-case we haven't tried before?

>                 if (source->disconnect_id > 0) {
>                         a2dp_cancel(source->disconnect_id);
>                         source->disconnect_id =3D 0;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
