Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391812080-19529-2-git-send-email-andre.guedes@openbossa.org>
References: <1391812080-19529-1-git-send-email-andre.guedes@openbossa.org>
	<1391812080-19529-2-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 17 Feb 2014 14:02:35 +0200
Message-ID: <CABBYNZKbemvbzKNkbd5+tg_w=T1tVKe2OKs3yPJw19jHdz6HLQ@mail.gmail.com>
Subject: Re: [PATCH] btsnoop: Remove unused local function and macro
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sat, Feb 8, 2014 at 12:27 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> ---
>  tools/btsnoop.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/tools/btsnoop.c b/tools/btsnoop.c
> index a65d8c5..260dfdb 100644
> --- a/tools/btsnoop.c
> +++ b/tools/btsnoop.c
> @@ -40,19 +40,6 @@
>
>  #include "monitor/btsnoop.h"
>
> -static inline uint64_t ntoh64(uint64_t n)
> -{
> -       uint64_t h;
> -       uint64_t tmp = ntohl(n & 0x00000000ffffffff);
> -
> -       h = ntohl(n >> 32);
> -       h |= tmp << 32;
> -
> -       return h;
> -}
> -
> -#define hton64(x)     ntoh64(x)
> -
>  struct btsnoop_hdr {
>         uint8_t         id[8];          /* Identification Pattern */
>         uint32_t        version;        /* Version Number = 1 */
> --
> 1.8.5.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
