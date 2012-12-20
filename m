Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121220093840.GA21122@aemeltch-MOBL1>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
	<20121220080447.GA561@x220>
	<CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
	<20121220091943.GA5862@x220>
	<CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
	<20121220093840.GA21122@aemeltch-MOBL1>
Date: Thu, 20 Dec 2012 11:51:20 +0100
Message-ID: <CAFOXTdcCKHLWz-N5-dvgZJkz99HPY65DpVq-NQsGZ7mcSUwutQ@mail.gmail.com>
Subject: Re: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 20, 2012 at 10:38 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> The patch is below:
>
> commit 7a7f1e7c857959f5298020969741e389f21edbae
> Author: Hemant Gupta <hemant.gupta@stericsson.com>
> Date:   Mon Jan 16 13:34:29 2012 +0530
>
>     Bluetooth: Send correct response to IO Capability Request
>
>     This patch sends correct IO Capability response to remote device
>     in case Local Device supports KeyBoardDisplay IO Capability as
>     this capability is not valid as per BT spec for IO capability
>     Request Reply Command.
>     This capability is mapped to DisplayYesNo which is in accordance
>     with BT spec.
>
>     Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>     Acked-by: Marcel Holtmann <marcel@holtmann.org>
>     Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 6fb9016..041a35e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2965,7 +2965,10 @@ static inline void hci_io_capa_request_evt(struct
> hci_dev *hdev, struct sk_buff
>                 struct hci_cp_io_capability_reply cp;
>
>                 bacpy(&cp.bdaddr, &ev->bdaddr);
> -               cp.capability = conn->io_capability;
> +               /* Change the IO capability from KeyboardDisplay
> +                * to DisplayYesNo as it is not supported by BT spec. */
> +               cp.capability = (conn->io_capability == 0x04) ?
> +                                               0x01 :
> conn->io_capability;
>                 conn->auth_type = hci_get_auth_req(conn);
>                 cp.authentication = conn->auth_type;

Interesting. This patch is present in the sources for 3.5.7 kernel
that I have. But somehow it does not work. Fixing simple-agent did
work though.

Andrei
