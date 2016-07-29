Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160728162147.29986-1-mathew.j.martineau@linux.intel.com>
References: <20160728162147.29986-1-mathew.j.martineau@linux.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 Jul 2016 14:11:44 +0300
Message-ID: <CABBYNZ+_rMYB_mRhC2+wxytv=O=K3BNcK05yZooGrAQA=4ZpEA@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix recevied/received typos
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Jul 28, 2016 at 7:21 PM, Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
> ---
>
> While fixing this, I noticed that ubcsp.{c,h} are the only source files
> without proper Unix line endings. It's an easy fix but a lot of
> churn. Let me know if I should submit a patch for that.
>
> Mat
>
> ---
>  tools/l2test.c  | 2 +-
>  tools/scotest.c | 2 +-
>  tools/ubcsp.c   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/l2test.c b/tools/l2test.c
> index d4e3ae6..1819423 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -830,7 +830,7 @@ static void dump_mode(int sk)
>                         return;
>                 }
>
> -               syslog(LOG_INFO, "Recevied %d bytes", len);
> +               syslog(LOG_INFO, "Received %d bytes", len);
>                 hexdump(buf, len);
>         }
>  }
> diff --git a/tools/scotest.c b/tools/scotest.c
> index 596e403..f894c24 100644
> --- a/tools/scotest.c
> +++ b/tools/scotest.c
> @@ -265,7 +265,7 @@ static void dump_mode(int sk)
>
>         syslog(LOG_INFO,"Receiving ...");
>         while ((len = read(sk, buf, data_size)) > 0)
> -               syslog(LOG_INFO, "Recevied %d bytes", len);
> +               syslog(LOG_INFO, "Received %d bytes", len);
>  }
>
>  static void recv_mode(int sk)
> diff --git a/tools/ubcsp.c b/tools/ubcsp.c
> index b3f883a..cd17d48 100644
> --- a/tools/ubcsp.c
> +++ b/tools/ubcsp.c
> @@ -351,14 +351,14 @@ bad_match_loop:
>
>  /*****************************************************************************/
>  /**                                                                         **/
> -/** ubcsp_recevied_packet                                                   **/
> +/** ubcsp_received_packet                                                   **/
>  /**                                                                         **/
>  /** This function is called when we have a SLIP END octet and a full        **/
>  /** packet header and possibly data in the receive packet                   **/
>  /**                                                                         **/
>  /*****************************************************************************/
>
> -static uint8 ubcsp_recevied_packet (void)
> +static uint8 ubcsp_received_packet (void)
>  {
>         static uint8
>                 receive_crc,
> @@ -1107,7 +1107,7 @@ uint8 ubcsp_poll (uint8 *activity)
>                                 {
>                                         /* process the received packet */
>
> -                                       *activity |= ubcsp_recevied_packet ();
> +                                       *activity |= ubcsp_received_packet ();
>
>                                         if (*activity & UBCSP_PACKET_ACK)
>                                         {
> --
> 2.9.2

Doesn't apply:

Applying: tools: Fix recevied/received typos
error: patch failed: tools/ubcsp.c:351
error: tools/ubcsp.c: patch does not apply
Patch failed at 0002 tools: Fix recevied/received typos


-- 
Luiz Augusto von Dentz
