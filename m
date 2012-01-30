Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327926130-26149-2-git-send-email-andre.guedes@openbossa.org>
References: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
	<1327926130-26149-2-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 30 Jan 2012 14:36:55 -0200
Message-ID: <CAA37ikaw7_=4CzEm=+-XZSK-asKYprbJ-QagHrLPocJyFqjxjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Use GFP_KERNEL in hci_chan_create()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Jan 30, 2012 at 10:22 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> This function is called in process context only, so it should use
> GFP_KERNEL to allocate memory.
>
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9ec7b8e..7b38a0b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -945,7 +945,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
>
>        BT_DBG("%s conn %p", hdev->name, conn);
>
> -       chan = kzalloc(sizeof(struct hci_chan), GFP_ATOMIC);
> +       chan = kzalloc(sizeof(struct hci_chan), GFP_KERNEL);
>        if (!chan)
>                return NULL;
>

The two patches to use GFP_KERNEL seem ok to me and that's the path
Padovan and Marcel wanted to go, of course, now that we run in process
context.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
