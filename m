Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1257213310.3420.16.camel@localhost.localdomain>
References: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
	 <1257213310.3420.16.camel@localhost.localdomain>
Date: Tue, 3 Nov 2009 10:12:42 +0200
Message-ID: <1ba2fa240911030012x324e4a1esee3aa3916fbb3594@mail.gmail.com>
Subject: Re: [PATCH net-next] iwmc3200bt: Add iwmc3200 bluetooth driver
From: Tomas Winkler <tomasw@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 3, 2009 at 3:55 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Tomas,
>
> so I removed all the unneeded parties from this thread since there is no
> point in spamming everybody with this.
>
>>vl_sdio.o
>> =C2=A0btmrvl-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 :=3D btmrvl_main.o
>> =C2=A0btmrvl-$(CONFIG_DEBUG_FS) =C2=A0 =C2=A0+=3D btmrvl_debugfs.o
>>
>> +obj-$(CONFIG_BT_IWMC3200) =C2=A0 =C2=A0+=3D iwmc3200bt.o
>> +
>
> sort this one before the Marvell driver since it is a one file only
> driver.
>
No problem

>> + * =C2=A0Based on =C2=A0drivers/bluetooth/btsdio.c
>> + * =C2=A0Copyright (C) 2007 =C2=A0Cambridge Silicon Radio Ltd.
>> + * =C2=A0Copyright (C) 2007 =C2=A0Marcel Holtmann <marcel@holtmann.org>
>
> You mean "based on" or "90% copied" ;)
>

Right, we've tried actually to use btsdio but we differ in few key points,
actually we coudn't locate and working HW with btsdio to try if our
changes break it
If someone know such device please let me know.

>> +#ifdef CONFIG_BT_IWMC3200_DEBUG
>> +#define IBT_DBG(func, fmt, arg...) \
>> + =C2=A0 =C2=A0 dev_dbg(&((func)->dev), "%s: " fmt "\n" , __func__ , ## =
arg)
>> +#define IBT_ERR(func, fmt, arg...) \
>> + =C2=A0 =C2=A0 dev_err(&((func)->dev), "%s: " fmt "\n" , __func__ , ## =
arg)
>> +#define IBT_DUMP(func, buf, size) do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> + =C2=A0 =C2=A0 char prefix_str[30 + 1]; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> + =C2=A0 =C2=A0 scnprintf(prefix_str, 30, "%s %s", =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_driver_string(&((func)->=
dev)), =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name(&((func)->dev))); =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
>> + =C2=A0 =C2=A0 print_hex_dump(KERN_DEBUG, prefix_str, DUMP_PREFIX_OFFSE=
T, =C2=A0 =C2=A0 =C2=A0\
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
16, 1, buf, size, false); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
>> +} while (0)
>> +
>> +#define VD "-d"
>> +#else
>> +#define IBT_DBG(func, fmt, arg...)
>> +#define IBT_ERR(func, fmt, arg...)
>> +#define IBT_DUMP(func, buf, size)
>> +#define VD
>> +#endif /* CONFIG_BT_IWMC3200_DEBUG */
>> +
>> +#ifdef REPOSITORY_LABEL
>> +#define RL REPOSITORY_LABEL
>> +#else
>> +#define RL local
>> +#endif
>
> All of this debug stuff has to go away. It is really not needed and
> BT_DBG with dynamic_printk support seems more than enough.


Personally I prefer using dev_dbg in device driver then inventing it
again with pr_debug.

>
>> +#define IWMCBT_VERSION "0.1.6"
>> +
>> +#define DRIVER_VERSION IWMCBT_VERSION "-" =C2=A0__stringify(RL) VD
>
> This one needs to be removed too. I don't care about the repository
> label in upstream.

See what I can do somehow I need to also maintain  it internally
>
>> +#define IWMC_BT_SDIO_DEVID (0x1406)
>> +
>> +static const struct sdio_device_id btsdio_table[] =3D {
>> + =C2=A0 =C2=A0 /* IWMC3200BT (0x1406) */
>> + =C2=A0 =C2=A0 { SDIO_DEVICE(SDIO_VENDOR_ID_INTEL, 0x1406)},
>> + =C2=A0 =C2=A0 { } =C2=A0 =C2=A0 /* Terminating entry */
>> +};
>
> This is pointless. Just use the numbers directly. and put a proper
> comment above SDIO_DEVICE with hardware this is. Also no need to repeat
> the number in that comment.

This is what we agreed up, VENDOR ID is defined, device id is inline

>
>> +
>> +MODULE_DEVICE_TABLE(sdio, btsdio_table);
>> +
>> +struct btsdio_data {
>> + =C2=A0 =C2=A0 struct hci_dev =C2=A0 *hdev;
>> + =C2=A0 =C2=A0 struct sdio_func *func;
>> +
>> + =C2=A0 =C2=A0 struct work_struct work;
>> +
>> + =C2=A0 =C2=A0 struct sk_buff_head txq;
>> + =C2=A0 =C2=A0 unsigned char tx_buf[2048];
>> + =C2=A0 =C2=A0 unsigned char rx_buf[2048];
>> +};
>
> I know that you guys copied btsdio driver, but if you change the name,
> then also change the internal structure names. So this these should be
> called iwmc3200_data and etc.

Right, I just would like to postpone it for now for easier alignment with b=
tsdio

>
> Also I prefer that we allocate tx_buf and rx_buf so that they are
> ensured to be aligned and we don't have to play alignment tricks during
> the packet sending and receiving.

Correct, that's something on the list.

>

>> +#ifdef CONFIG_BT_IWMC3200_DEBUG
>> +static char *type_names[] =3D {
>> + =C2=A0 =C2=A0 "Illegal",
>> + =C2=A0 =C2=A0 "HCI_COMMAND_PKT",
>> + =C2=A0 =C2=A0 "HCI_ACLDATA_PKT",
>> + =C2=A0 =C2=A0 "HCI_SCODATA_PKT",
>> + =C2=A0 =C2=A0 "HCI_EVENT_PKT"
>> +};
>> +#endif /* CONFIG_BT_IWMC3200_DEBUG =C2=A0*/
>
> No unneeded debug extras please. This is a Bluetooth HCI driver. It is
> really not that complicated.
>

This can go

> <snip>
>
> I need the debug cleanup first, before continuing looking at the rest of
> the driver.

>> +MODULE_ALIAS("ibtsdio");
>
> We are not using module aliases here. So that can be removed.

No problem this can be removed now


Thanks for the review, will send updated patch soon
Tomas
