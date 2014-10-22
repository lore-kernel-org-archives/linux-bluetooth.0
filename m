Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413976251-32402-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413976251-32402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1413976251-32402-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Wed, 22 Oct 2014 14:55:54 +0200
Message-ID: <CAMv5Gbck+=b9kY-s+gd3shJsLUDAEZib5dKGM09ZBWkP==ufFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] bnep: Return errno instead of -1 and print error
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On 22 October 2014 13:10, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Make code consistent with the rest returning -errno and printing error
> message.
> ---
>  profiles/network/bnep.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 4cf38d9..09d4b65 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -231,7 +231,7 @@ static int bnep_if_down(const char *devname)
>         if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
>                 err = -errno;
>                 error("bnep: Could not bring down %s: %s(%d)",
> -                               devname, strerror(-err), -err);
> +                                               devname, strerror(-err), -err);

Why don't you fix this indention in first patch ? (this line is added
in previous patch)

>         }
>
>         close(sk);
> @@ -520,7 +520,7 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>  {
>         int ifindex;
>         struct ifreq ifr;
> -       int sk, err;
> +       int sk, err = 0;
>
>         if (!devname || !bridge)
>                 return -EINVAL;
> @@ -535,16 +535,16 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
>         strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
>         ifr.ifr_ifindex = ifindex;
>
> -       err = ioctl(sk, SIOCBRDELIF, &ifr);
> +       if (ioctl(sk, SIOCBRDELIF, &ifr) < 0) {
> +               err = -errno;
> +               error("bnep: Can't delete %s from the bridge %s: %s(%d)",
> +                                       devname, bridge, strerror(-err), -err);
> +       } else
> +               info("bridge %s: interface %s removed", bridge, devname);
>
>         close(sk);
>
> -       if (err < 0)
> -               return err;
> -
> -       info("bridge %s: interface %s removed", bridge, devname);
> -
> -       return 0;
> +       return err;
>  }
>
>  int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR,
Grzegorz
