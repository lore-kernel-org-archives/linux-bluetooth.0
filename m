Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1390838375-25264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CAJdJm_P5JwjNhRuqz0gFYJ7QZMPmcHNVSvSa+SAQ11ftM8z0WQ@mail.gmail.com>
	<1390838375-25264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 27 Jan 2014 10:41:41 -0800
Message-ID: <CABBYNZKvqzGQ_HcD3ZtSxMDz5SOvtphFSJ-5G70TposwoDjYcA@mail.gmail.com>
Subject: Re: [PATCHv2] avctp: Fix unchecked return value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jan 27, 2014 at 7:59 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Refactor code so that ioctl() return value is checked.
> ---
>  profiles/audio/avctp.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 6fd1454..bf44f9c 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1027,27 +1027,54 @@ static int uinput_create(char *name)
>                 err = -errno;
>                 error("Can't write device information: %s (%d)",
>                                                 strerror(-err), -err);
> -               close(fd);
> -               return err;
> +               goto fail;
> +       }
> +
> +       if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0) {
> +               err = -errno;
> +               error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
> +               goto fail;
>         }
>
> -       ioctl(fd, UI_SET_EVBIT, EV_KEY);
> -       ioctl(fd, UI_SET_EVBIT, EV_REL);
> -       ioctl(fd, UI_SET_EVBIT, EV_REP);
> -       ioctl(fd, UI_SET_EVBIT, EV_SYN);
> +       if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0) {
> +               err = -errno;
> +               error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
> +               goto fail;
> +       }
>
> -       for (i = 0; key_map[i].name != NULL; i++)
> -               ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> +       if (ioctl(fd, UI_SET_EVBIT, EV_REP) < 0) {
> +               err = -errno;
> +               error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
> +               goto fail;
> +       }
> +
> +       if (ioctl(fd, UI_SET_EVBIT, EV_SYN) < 0) {
> +               err = -errno;
> +               error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
> +               goto fail;
> +       }
> +
> +       for (i = 0; key_map[i].name != NULL; i++) {
> +               if (ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput) < 0) {
> +                       err = -errno;
> +                       error("ioctl UI_SET_KEYBIT: %s (%d)", strerror(-err),
> +                                                                       -err);
> +                       goto fail;
> +               }
> +       }
>
>         if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
>                 err = -errno;
>                 error("Can't create uinput device: %s (%d)",
>                                                 strerror(-err), -err);
> -               close(fd);
> -               return err;
> +               goto fail;
>         }
>
>         return fd;
> +
> +fail:
> +       close(fd);
> +       return err;
>  }
>
>  static void init_uinput(struct avctp *session)
> --
> 1.8.3.2

I start to wonder if there is a better way to set those bits...


-- 
Luiz Augusto von Dentz
