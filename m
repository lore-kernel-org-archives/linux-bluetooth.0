Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387463983-6373-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1387463983-6373-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Thu, 19 Dec 2013 17:33:34 +0200
Message-ID: <CABBYNZ+t_w8f+c7V4GLtYsm6jGFM2SSowFeRtk2LFRuPPXjKcQ@mail.gmail.com>
Subject: Re: [PATCH_v6 2/5] bnep: Rename struct bnep_conn to struct bnep for
 better readability
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Thu, Dec 19, 2013 at 4:39 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> ---
>  profiles/network/bnep.c | 80 ++++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 08037e6..02e2647 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -67,7 +67,7 @@ struct __service_16 {
>         uint16_t src;
>  } __attribute__ ((packed));
>
> -struct bnep_conn {
> +struct bnep {
>         GIOChannel      *io;
>         uint16_t        src;
>         uint16_t        dst;
> @@ -77,17 +77,17 @@ struct bnep_conn {
>         bnep_connect_cb conn_cb;
>  };
>
> -static void free_bnep_connect(struct bnep_conn *bc)
> +static void free_bnep_connect(struct bnep *b)

I guess if you want to be consist you should name the var session here as well.


-- 
Luiz Augusto von Dentz
