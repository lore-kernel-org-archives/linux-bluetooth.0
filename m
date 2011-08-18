Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313627847.10336.9.camel@THOR>
References: <1313627847.10336.9.camel@THOR>
Date: Thu, 18 Aug 2011 10:43:49 +0300
Message-ID: <CABBYNZJwn5CrY73-+kJK5jn9+B0V-Jx0Q+-NVH4BJVSLm7dDbA@mail.gmail.com>
Subject: Re: [RFC v2 1/5] Bluetooth: Only schedule LE tx links if LE-capable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Aug 18, 2011 at 3:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Only perform tx scheduling for LE links if the host controller
> is LE-capable.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/hci_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 815269b..47a31fa 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1995,7 +1995,9 @@ static void hci_tx_task(unsigned long arg)
>
>        hci_sched_esco(hdev);
>
> -       hci_sched_le(hdev);
> +       /* Only schedule le links if device is le-capable */
> +       if (lmp_le_capable(hdev))
> +               hci_sched_le(hdev);
>
>        /* Send next queued raw (unknown type) packet */
>        while ((skb = skb_dequeue(&hdev->raw_q)))
> --
> 1.7.4.1
>
>

Any reasons why you choose to not add the check inside hci_sched_le?

-- 
Luiz Augusto von Dentz
