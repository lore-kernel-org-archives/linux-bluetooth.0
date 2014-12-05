Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417783707-3519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417783707-3519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 5 Dec 2014 17:03:27 +0200
Message-ID: <CABBYNZJGMZRiP4B-9L8YnqDia-dvxKU4FD_CPqgMUEKEtNrzCQ@mail.gmail.com>
Subject: Re: [PATCHv2] monitor: Fix RFCOMM parity type mask
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Dec 5, 2014 at 2:48 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fix RFCOMM RPN parity type bit according to Spec. GSM 07.10 version
> 6.3.0. (PT1 - PT2 indicates the parity type).
> ---
>         *v2: Fixed parity type bits
>
>  monitor/rfcomm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index fe3afb7..4ba61c8 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -67,7 +67,7 @@ static char *cr_str[] = {
>  #define GET_RPN_DB(parity)     (parity & 0x03)
>  #define GET_RPN_SB(parity)     ((parity & 0x04) >> 2)
>  #define GET_RPN_PARITY(parity) ((parity & 0x08) >> 3)
> -#define GET_RPN_PTYPE(parity)  ((parity & 0x03) >> 3)
> +#define GET_RPN_PTYPE(parity)  ((parity & 0x30) >> 4)
>  #define GET_RPN_XIN(io)                (io & 0x01)
>  #define GET_RPN_XOUT(io)       ((io & 0x02) >> 1)
>  #define GET_RPN_RTRI(io)       ((io & 0x04) >> 2)
> --
> 1.9.1

Pushed, thanks.


-- 
Luiz Augusto von Dentz
