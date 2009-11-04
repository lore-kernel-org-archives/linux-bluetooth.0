Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1256653711-17959-1-git-send-email-david.vrabel@csr.com>
References: <1256143300-16149-1-git-send-email-david.vrabel@csr.com>
	 <1256653711-17959-1-git-send-email-david.vrabel@csr.com>
Date: Wed, 4 Nov 2009 12:56:46 +0200
Message-ID: <1ba2fa240911040256p3645aac6sea271919f1e6e651@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: don't DMA to stack in btsdio driver
From: Tomas Winkler <tomasw@gmail.com>
To: David Vrabel <david.vrabel@csr.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Oct 27, 2009 at 4:28 PM, David Vrabel <david.vrabel@csr.com> wrote:
> sdio_read() may use DMA so read the Type-A header into a kmalloc'd
> buffer instead of an on-stack buffer (which results in a DMA API
> warning).
>
> Signed-off-by: David Vrabel <david.vrabel@csr.com>
> ---
> Apply this instead, it frees the header buffer.
>
> David
>
> =C2=A0drivers/bluetooth/btsdio.c | =C2=A0 35 ++++++++++++++++++++++------=
-------
> =C2=A01 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index 7e29827..59d0d3b 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -54,6 +54,7 @@ MODULE_DEVICE_TABLE(sdio, btsdio_table);
> =C2=A0struct btsdio_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_dev =C2=A0 *hdev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdio_func *func;
> + =C2=A0 =C2=A0 =C2=A0 u8 *hdr_buf;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct work;
>
> @@ -122,7 +123,7 @@ static void btsdio_work(struct work_struct *work)
>
> =C2=A0static int btsdio_rx_packet(struct btsdio_data *data)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 u8 hdr[4] __attribute__ ((aligned(4)));
> + =C2=A0 =C2=A0 =C2=A0 u8 *hdr =3D data->hdr_buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sk_buff *skb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err, len;
>
> @@ -292,6 +293,7 @@ static void btsdio_destruct(struct hci_dev *hdev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG("%s", hdev->name);
>
> + =C2=A0 =C2=A0 =C2=A0 kfree(data->hdr_buf);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(data);
> =C2=A0}
>
> @@ -299,9 +301,9 @@ static int btsdio_probe(struct sdio_func *func,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct sdio_device_id *id)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct btsdio_data *data;
> - =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev;
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev =3D NULL;

This kind of assignments prevent useful warning from compiler, maybe
it's better to stage
the error bailout.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sdio_func_tuple *tuple =3D func->tuples=
;
> - =C2=A0 =C2=A0 =C2=A0 int err;
> + =C2=A0 =C2=A0 =C2=A0 int err =3D -ENOMEM;
You are assuming no other code  between 2 allocations, it's seems to
me error prone.
>

Thanks
Tomas
