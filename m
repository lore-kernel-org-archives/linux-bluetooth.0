Return-Path: <cyrus@holtmann.org>
Message-ID: <4EFB50C2.4070600@gmail.com>
Date: Wed, 28 Dec 2011 18:24:18 +0100
From: Rene Herman <rene.herman@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <padovan@profusion.mobi>,
 Andre Guedes <andre.guedes@openbossa.org>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth] linux-3.x regression (bisected)
References: <4EF3BACA.1080405@gmail.com> <CACJA=fVezGGcgAtbzG=+ouWq0PiHbgXN1YPwL+VDUphWS7wnrw@mail.gmail.com> <4EFA1EB8.9090005@gmail.com> <20111227203008.GA13870@joana> <4EFA447C.3030906@gmail.com> <20111228012248.GC13870@joana> <20111228012850.GD13870@joana> <4EFA7696.6060506@gmail.com> <20111228155225.GA23292@joana> <1325090923.1965.282.camel@aeonflux>
In-Reply-To: <1325090923.1965.282.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 28-12-11 17:48, Marcel Holtmann wrote:

> The correct patch would be something like this:
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 919e3c0..b6eb9c5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -711,7 +711,8 @@ static void hci_cc_read_local_ext_features(struct hci_dev *h
>          if (rp->status)
>                  return;
>
> -       memcpy(hdev->extfeatures, rp->features, 8);
> +       if (rp->page == 1)
> +               memcpy(hdev->extfeatures, rp->features, 8);
>
>          hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
>   }
>
> The current patch is actually fully broken anyway. So besides switching
> LE on when requesting page 0, you will also switch it off when
> requesting any other page and it accidentally returns 0x00 since we
> unconditionally overwrite it.

Don't know anything about pages, but... I can confirm that the above 
works for me as well.

Rene.
