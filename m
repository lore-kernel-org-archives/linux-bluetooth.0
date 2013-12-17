Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387231516-4127-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387231516-4127-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1387231516-4127-3-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Tue, 17 Dec 2013 11:19:11 +0200
Message-ID: <CABBYNZKMECuAd2WBQ8-FE5OO9Qtp0g=iKTBA3zV8JOa6cxAN9w@mail.gmail.com>
Subject: Re: [PATCH_v2 3/6] bnep: Add bnep_new and bnep_free api's
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Dec 17, 2013 at 12:05 AM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> Refacoring connect and disconnect mechanisms. It would be more
> convinient for caller to maintain just bnep connection reference
> and delete whenever it is not required.
> ---
>  profiles/network/bnep.c | 37 +++++++++++++++++++++++++++++++++++++
>  profiles/network/bnep.h |  5 +++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 08037e6..d7d8832 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -71,6 +71,7 @@ struct bnep_conn {
>         GIOChannel      *io;
>         uint16_t        src;
>         uint16_t        dst;
> +       bdaddr_t        dst_addr;
>         guint   attempts;
>         guint   setup_to;
>         void    *data;
> @@ -246,6 +247,42 @@ int bnep_if_down(const char *devname)
>         return 0;
>  }
>
> +struct bnep_conn *bnep_new(uint16_t src, uint16_t dst,
> +                                               const bdaddr_t *dst_addr)

I would change the order of the parameters, also do not use bdaddr_t
otherwise you wont be able to do unit tests with it, something like
bnep_new(int fd, uint16_t local_role, uint16_t remote_role) looks
better, but perhaps you gonna need the MTU as well.

> +{
> +       struct bnep_conn *bc;
> +
> +       DBG("");
> +
> +       if (!dst_addr)
> +               return NULL;
> +
> +       bc = g_new0(struct bnep_conn, 1);
> +       if (!bc)
> +               return NULL;

No need to check the return of g_new0, if it fails it will exit so
this code will never be triggered.
