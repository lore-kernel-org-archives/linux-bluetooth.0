Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390575403-30860-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1390575403-30860-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 24 Jan 2014 11:00:58 -0400
Message-ID: <CAJdJm_P5JwjNhRuqz0gFYJ7QZMPmcHNVSvSa+SAQ11ftM8z0WQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] avctp: Fix unchecked return value
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 24, 2014 at 10:56 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:

> -       for (i = 0; key_map[i].name != NULL; i++)
> +       for (i = 0; key_map[i].name != NULL; i++) {
>                 ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> +               err = -errno;
> +               error("ioctl UI_SET_KEYBIT: %s (%d)", strerror(-err), -err);
> +               goto fail;
> +       }

You seem to have missed the "if (ioctl(...) < 0)" above.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
