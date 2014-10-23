Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413984870-24023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CAMv5Gbck+=b9kY-s+gd3shJsLUDAEZib5dKGM09ZBWkP==ufFw@mail.gmail.com>
	<1413984870-24023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 23 Oct 2014 13:23:48 +0300
Message-ID: <CABBYNZ+3-qxfn-cTJDBV2tWv16rtHyUnRtVj+QJ4Gs-d-H6c9A@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] bnep: Add error print and return errno instead of -1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 22, 2014 at 4:34 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  profiles/network/bnep.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 927367c..f8fcd1f 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -219,7 +219,7 @@ static int bnep_if_up(const char *devname)
>  static int bnep_if_down(const char *devname)
>  {
>         struct ifreq ifr;
> -       int sk, err;
> +       int sk, err = 0;
>
>         sk = socket(AF_INET, SOCK_DGRAM, 0);
>
> @@ -229,16 +229,15 @@ static int bnep_if_down(const char *devname)
>         ifr.ifr_flags &= ~IFF_UP;
>
>         /* Bring down the interface */
> -       err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
> +       if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
> +               err = -errno;
> +               error("bnep: Could not bring down %s: %s(%d)",
> +                                               devname, strerror(-err), -err);
> +       }
>
>         close(sk);
>
> -       if (err < 0) {
> -               error("bnep: Could not bring down %s", devname);
> -               return err;
> -       }
> -
> -       return 0;
> +       return err;
>  }
>
>  static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
> --
> 1.9.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
