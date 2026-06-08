Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AE1DED49
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928825; cv=pass; b=gpjXEwiy7luirJb4LC6JsqgTe4G8z81UJ/XYQ7jChb15fXACsVZ6PxVpUDs0hSLDnLUmvAMwbVKBNAAJGSyC4vc+w9ONg4XJ0Mg1fomJCTXEeZJm1a7XBXtzvCKZdYqkRamFIUMFpP1TTbWNeIsK2kUASdWo/uIh0cFYVfI4JzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928825; c=relaxed/simple;
	bh=gv7PZz+kJFYWo62N6Bl/Dtq8oJlTmODv8TJH7Xq3Ox4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYtQ3vw9DIgcJ7WYlfhNGshmdKBZWzB160/KCuzaqe6Nya4hZoerXa129sjXKZGY31Z85lniTCIqLFoK+vy5y0Ae0/36I4/EoKytqin9Msl/ISI4zO7zeqFMjNAYvL6V2f2Ip7QnrmseC3xMQfF0YqSAtWAmd3iNogCt+DZ7zOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmLAlHQS; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmLAlHQS"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6604176b575so3864311d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 07:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780928823; cv=none;
        d=google.com; s=arc-20240605;
        b=H7K0/Q3YbhE9y07TWGYaRXD+0MjbxOkBY6hR1V/259fuxT0DHpHWDUieBcNHeTZJEx
         SxnrVxfLKWSGvfY5xDWO8jdnmybEnrAzWeTAGMN9v8+kSLIDpfKozzJiX+KRgDDxiFej
         /kkpo/+zKLd70L9uAOihJpP5HoZXArhAG8vRKcECIhqrYb/KX8uN3DZsgs0IpQiTVbBX
         em9Yg93cGSZA8Jljc+scxMibNpJ+TAV2xOPR5QW6LePX4PmUEFmPhom9bgJgRuZIf2KL
         q+SBnQ/FOLqhDH8sQpGbrvX2dtA4HmN/6RfTfwU5XInvBCECaOvePI85dH+GR5MKsxbq
         I+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K/AqGcMLTD+BJdmdVfsyo+NJlI4L7XUdCShrVn0/zHw=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=k30UA6327ChJexG6v8qQvnAxkxsllqLJsobt3g3aYTO/UMbmKDMMJP5FKYmnOcQ71l
         DDVYG9adofDqZrJHWmmLQqy1kSmV2S7bOKduG4L289EI3at/tyu8NOf0VrzKcEGhFhAW
         Xe55Y7Pwpb6btBESkwN9q//jqaqITOGp/OWZH7rXg+rfSFA76wzpYKd9XxyheF/QfOwN
         7fujGKJpW5q2GOY0T0RM7vIg09ksoc/rmjAP6i7y2Dd8EeXhcyRhgKXKP/nI1IvPsFx6
         2A7Pi3WQixkyzLDWAP7dZwKD+vSSVxpHFZBADQ1kJMonY4BTcXsEUvw48LGftbFCeKOP
         xT0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928823; x=1781533623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/AqGcMLTD+BJdmdVfsyo+NJlI4L7XUdCShrVn0/zHw=;
        b=hmLAlHQSWEzV/QnhKps4Hq02LpeleYMx+GzMJWbHr+xMgLITkpSefPKxZgL6ravpo/
         cixnUaAy3aOpoemZWPQrLPb8agM/y3LzyC17yeXlPSiyxi6m4uQFmzGE6RHeXN6VpY7D
         qsUJO4uT/tujvqmiDvdD1SF6tdtiYi5uGTU70B3e0ZqOlFbVBRkP8up1F2AH+Aw/gTi0
         vEoQdOcPuvd62K3HYk1gzbEIHGw9mbVtsS7p9SyNy1yG0MbTtGn9vVK91OHMBx61ioZT
         38zicyrCDCfkneZUMYKDrfgztF71I4FNB+sBItlOqqhCbdQY4XjivR5mis7YmqqAGWD3
         TXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928823; x=1781533623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/AqGcMLTD+BJdmdVfsyo+NJlI4L7XUdCShrVn0/zHw=;
        b=WDcmhjq1dQQKcXCr/IKfBHN0KYMVYrzKp8RP/lFgIg3jh13xMsLJEpGhWa3hF3RviK
         CyT5zgH9xFf+z41Xk1mx8rUORgSilNaPYIm9PzhAvssKl8FNAezuKkJKqzqhPfegym/0
         iZ4ScnTeKobsnJZPtr+MqUJGtT3BSSMALHXV73T7+tpXsz+0jqXAhouGOcEdo4pZv+7J
         lTf/KTIEb6dYLv1UXEVCKuxftgo2dT8PjxK1XHK0cPilBY0kUWcMhI/X5i0XQtbxmLyJ
         kAS9gc2IIrlAWLBYhFKFhPAA9OvfteubQ46Rvb42s5qvKHKHm/pzrcq+B8SEQ2U10XWO
         Pokg==
X-Gm-Message-State: AOJu0YwbmjXljqzQkZ2bxPMWrWev2/pi4IlLM4s4RYfR1tuErijXpj3P
	jJ0n3DwKNJkEJMv7TAFuj3YhxbOiQM5E9RWGzPlpBdKFozN7iKF8l8L2eiUEBlo34kVPN+y/00Y
	wEcIjkY9Q+MtiW9TvXIveFWfeLMxg8FA=
X-Gm-Gg: Acq92OEiQtI0CKjMakTdtfNryKeiBinBFrQaezvir4WfBD7vzXXuZxYxSaqeGNSykYR
	s6Swect8IWCf9oP/KTxQ/emO92OI1uN9gID3a7y5q89IpcUe/wHPh63Wjz3J7LBIJTg6sxbE3+6
	esPjbjm9uJljsSxfMGo2WVwkWMKwW7sgU7GWH/+1HtV3TiHWZ2T7aTIvfCQcUK1nbGU5w765rdU
	5j13fAMVyQuWx5X0r01NFFTW98GCWMextW1Ik06BCNKjj5q6OKjK+9hHICHVjeGyHJ1WzX1Pl1b
	r7QokqP8xANIASOKGZ0TvJ0kdT8RrgprK3XVsRYhmUrQ2WmFRm0Rka6QZynAcQGwfyDagLwLMv4
	smpDs
X-Received: by 2002:a53:d908:0:b0:660:9420:56c0 with SMTP id
 956f58d0204a3-66106f58309mr10003245d50.32.1780928822840; Mon, 08 Jun 2026
 07:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com> <20260608112923.3722754-2-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608112923.3722754-2-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 10:26:50 -0400
X-Gm-Features: AVVi8Cco5nCgjGem_4maJx2NMydeZ0hmjD984xVJoysyvzdD7NcGxf1t8MQnQXw
Message-ID: <CABBYNZKzQXiW1oB7JZQeMdxyk=8qmnUBKCk-CTLYY=D4evb+kw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] avdtp: Fix error handling for AVDTP_OPEN cmd
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 7:42=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> We have to return BAD_STATE when local SEP is available instead of
> BAD_ACP_SEID.
>
> This fixes: AVDTP/SNK/ACP/SIG/SMG/BI-26-C
> ---
>  profiles/audio/avdtp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 7cfc9a80d..6be6e99b4 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1771,13 +1771,14 @@ static gboolean avdtp_open_cmd(struct avdtp *sess=
ion, uint8_t transaction,
>                 return FALSE;
>         }
>
> -       stream =3D find_stream_by_lseid(session, req->acp_seid);
> -       if (!stream) {
> +       sep =3D find_local_sep_by_seid(session, req->acp_seid);
> +       if (!sep) {
>                 err =3D AVDTP_BAD_ACP_SEID;
>                 goto failed;
>         }
>
> -       if (stream->state !=3D AVDTP_STATE_CONFIGURED) {
> +       stream =3D find_stream_by_lsep(session, sep);
> +       if (!stream || stream->state !=3D AVDTP_STATE_CONFIGURED) {
>                 err =3D AVDTP_BAD_STATE;
>                 goto failed;
>         }

Looks valid but we should update avdtp-pts.rst with instructions on
how to pass AVDTP/SNK/ACP/SIG/SMG/BI-26-C then.

> @@ -1790,7 +1791,6 @@ static gboolean avdtp_open_cmd(struct avdtp *sessio=
n, uint8_t transaction,
>                                                         AVDTP_OPEN, NULL,=
 0);
>         }
>
> -       sep =3D stream->lsep;
>         if (sep->ind && sep->ind->open && !session->pending_open) {
>                 if (!sep->ind->open(session, sep, stream, &err,
>                                         sep->user_data))
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
