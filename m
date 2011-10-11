Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318359533-7640-1-git-send-email-padovan@profusion.mobi>
References: <1318359533-7640-1-git-send-email-padovan@profusion.mobi>
Date: Tue, 11 Oct 2011 16:33:44 -0300
Message-ID: <CAKT1EBf7fXR61TRGoKx6N0kKerXdmewphL-yu3J6vJjqbehNkA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix permission of enable_le param
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Oct 11, 2011 at 3:58 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>
> With 0444 it is impossible to change the param, changing it to 0644.
>
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d7d96b6..0e57634 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3104,5 +3104,5 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
>        kfree_skb(skb);
>  }
>
> -module_param(enable_le, bool, 0444);
> +module_param(enable_le, bool, 0644);
>  MODULE_PARM_DESC(enable_le, "Enable LE support");
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

If you allow changing the "enable_le" parameter dynamically it is also
necessary check the controller features and update the LE host
supported bit(if necessary).
I am afraid that allowing to change it dynamically will break the
consistency: what is gonna happen with the active operations(discovery
& connections)?

In our backlog we were planning to check LE host supported bit to
allow/block LE connections or any other feature related to LE.

BR,
Claudio.
