Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428930887-25519-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1428930887-25519-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Mon, 4 May 2015 15:56:38 +0200
Message-ID: <CAMv5Gbd_kfJBxSRpLb32oRQgFSUb8vO4YLJ7hrdukGOpSDuvnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/bnep: Update bnep header with BNEPGETSUPPFEAT
 and setup response
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On 13 April 2015 at 15:14, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> This patch updates bnep header with get bnep supported features ioctl
> and bnep setup response flag.
> ---
>  lib/bnep.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/bnep.h b/lib/bnep.h
> index aa46852..e7c2c87 100644
> --- a/lib/bnep.h
> +++ b/lib/bnep.h
> @@ -126,6 +126,9 @@ struct bnep_ext_hdr {
>  #define BNEPCONNDEL    _IOW('B', 201, int)
>  #define BNEPGETCONNLIST        _IOR('B', 210, int)
>  #define BNEPGETCONNINFO        _IOR('B', 211, int)
> +#define BNEPGETSUPPFEAT        _IOR('B', 212, int)
> +
> +#define BNEP_SETUP_RESPONSE    0
>
>  struct bnep_connadd_req {
>         int      sock;          /* Connected socket */
> --
> 2.1.0
>
