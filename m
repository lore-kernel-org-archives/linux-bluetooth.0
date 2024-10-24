Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116122B642
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797906; cv=none; b=XJg+HcOvhU74WuufWWejcsumAljgtqqzBoMf3O45Wgwhnm6319EyDu63h8MTZW0tn814Q2SxKU14VQisqvTLhIVjNpvIkMYhWEcZC4g0TZSbDW1bIlDzFcmxl/ZBxx8p6HQPgoC2IDDAhPPRC/5CT9mk+D8bSOhhrwwQdBFGZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797906; c=relaxed/simple;
	bh=MXv+xBBeu+ccI9STbcqnEkbkww5eD7oxw/yME5ZMGoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6cNvk/RZUTtqjOaoAxYvcv0PArFPIUgsydL5nVA7jeUi0y+rWMyFTPICLzDfNYLuzm/kvEeL1Etb79rv/8f+mHAYS8z0YL4y9toHow5V+HH/qlnigtgvOu9FZvN+wSQDVaxbGnN2CMNDsAqn8gY5SFel1XI1AcYtPudVoIUrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwFR+eKK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwFR+eKK"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so13208791fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729797902; x=1730402702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heykgG0STshDLSkWqybEGBlUjt54oonFokG1fqROFjo=;
        b=HwFR+eKKBdetfHRlilCaa/+k0nMym/FNc7odSnnLS4u8MOu8iNR8VYHyTl20q+LGLX
         dI9oIPYoi4kIsbLlqIS2MJqo+a9JZihuQk5mGyf7f4HEDh95FhsNkSP7ZOHne8n/917w
         ntGhNudhjOil5FO5InE9CP5xe3ScxCo4uhYbpkDs/C6yqra6NTCRF5bdFtBl7LinMmIt
         tzOxAkZge7jJ8/Q5LVyfvS7hMKDzDw4t3QYbH5UNZUPnIf00/tRvPxnQFpRen0Lu0AHN
         m/S189MTWhnj6N3efSGw4FvUhj2VFITUYAPbDXZVW2Rkcbmjq2GFUupxDTzyrDya2MEf
         aFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729797902; x=1730402702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heykgG0STshDLSkWqybEGBlUjt54oonFokG1fqROFjo=;
        b=U6Zolzh9nx5RKZLDv7V4jQdjNYlY953W9OmRa0o94oqdE8SN/W2ODY7GjYvX1yekUz
         sG8S8yQeoLpE5rg/FWchTtG6I+2xwqwWAhQuKeKvI9WfV+H70AZitNokk2fUeC6nMifX
         0rA2VIalaapRPMRRZf4Q0ltPxvtOIXfZW9wNIy0GL3gSJEfdEz0QxQ+fZsu4b8F0BLcS
         i5nGC3U0SzmdiR48dV1z5raVK3zyFWdyECU86gBnaC7R3SKtkWi8i28zZVO+0bwvlZBU
         yKQiBzPus365r/SKGllCHRu4bEtK9nIL0haWDOZf7Z9yxReze+T6iT7wkT6P4v4cWIrc
         M0pg==
X-Gm-Message-State: AOJu0Yz/6Rw8yH8OQsnHF0mbQLm+QFp3ce/D4UBWCL5Z+/L54ewNDLHM
	ctf0qOxbV7Yzqrgu6FRyad3LDxkJz0zZ5oW7fyNCr7bExGv7gsoaQoEhqtabVc3UgxPu10eFLJn
	m2bOoOGt0WOL39yUFauBl6WPA03uGhA==
X-Google-Smtp-Source: AGHT+IEVOA6Zs9c7SiBGmSJfmeWegUD9NVYtJAdL4T9V/miVh7bYbv6J9ACEIs4sO6uHnfuoVeESj0Nd1PpDz/c4fbc=
X-Received: by 2002:a05:651c:b0a:b0:2fc:9550:d658 with SMTP id
 38308e7fff4ca-2fca822b384mr24019651fa.24.1729797901877; Thu, 24 Oct 2024
 12:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com> <20241024110223.77254-5-iulia.tanasescu@nxp.com>
In-Reply-To: <20241024110223.77254-5-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Oct 2024 15:24:46 -0400
Message-ID: <CABBYNZL+P7ik7wA4HQ9jCdHRJGdRcr8nHLCsEQUkLgC9dY4NaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/14] shared/bap: Use enabling state for bcast sink streams
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Oct 24, 2024 at 7:03=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This updates the stream state transition from CONFIG to ENABLING,
> on enable for Broadcast Sink streams. This is done to differentiate
> between streams discovered in the BASE after short-lived PA sync
> and streams that have been selected and enabled by the user.
> ---
>  profiles/audio/bap.c | 7 +++----
>  src/shared/bap.c     | 2 +-
>  unit/test-bap.c      | 7 ++++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index c45717ef2..4d250db52 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1020,7 +1020,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GE=
rror *err, void *user_data)
>         free(req);
>
>         if (bt_bap_stream_set_io(setup->stream, fd)) {
> -               bt_bap_stream_start(setup->stream, NULL, NULL);
>                 g_io_channel_set_close_on_unref(io, FALSE);
>                 return;
>         }
> @@ -2676,13 +2675,13 @@ static void bap_state_bcast_sink(struct bt_bap_st=
ream *stream,
>         case BT_BAP_STREAM_STATE_CONFIG:
>                 if (!setup)
>                         break;
> -               if (old_state =3D=3D
> -                               BT_BAP_STREAM_STATE_CONFIG)
> -                       setup_create_io(data, setup, stream, defer);
>                 if (old_state =3D=3D
>                                 BT_BAP_STREAM_STATE_STREAMING)
>                         setup_io_close(setup, NULL);
>                 break;

Since we are going with a state that is not documented in the spec for
broadcast then we should document what it means internally so latter
on someone don't assume it is a mistake or needs changing due to not
adhering to the spec.

> +       case BT_BAP_STREAM_STATE_ENABLING:
> +               setup_create_io(data, setup, stream, defer);
> +               break;
>         }
>  }
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 46ed490d1..6a2e12577 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2186,7 +2186,7 @@ static unsigned int bap_bcast_sink_enable(struct bt=
_bap_stream *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
>  {
> -       stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
>
>         return 1;
>  }
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index 9cfc8c403..0c190d7fe 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -6419,14 +6419,15 @@ static void bsnk_state_str(struct bt_bap_stream *=
stream, uint8_t old_state,
>
>                         /* Enable stream */
>                         bt_bap_stream_enable(stream, true, NULL, NULL, NU=
LL);
> -               } else if (old_state =3D=3D BT_BAP_STREAM_STATE_CONFIG) {
> -                       /* Start stream */
> -                       bt_bap_stream_start(stream, NULL, NULL);
>                 } else {
>                         /* Other state transitions are invalid */
>                         tester_test_failed();
>                 }
>
> +               break;
> +       case BT_BAP_STREAM_STATE_ENABLING:
> +               /* Start stream */
> +               bt_bap_stream_start(stream, NULL, NULL);
>                 break;
>         case BT_BAP_STREAM_STATE_STREAMING:
>                 queue_foreach(data->streams, stream_count_streaming, &num=
);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
