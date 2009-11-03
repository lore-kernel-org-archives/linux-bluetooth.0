Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH net-next] iwmc3200bt: Add iwmc3200 bluetooth driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomasw@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com
In-Reply-To: <1ba2fa240911030012x324e4a1esee3aa3916fbb3594@mail.gmail.com>
References: <1257204990-18669-1-git-send-email-tomas.winkler@intel.com>
	 <1257213310.3420.16.camel@localhost.localdomain>
	 <1ba2fa240911030012x324e4a1esee3aa3916fbb3594@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Nov 2009 17:56:56 +0900
Message-Id: <1257238616.3420.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> > so I removed all the unneeded parties from this thread since there is no
> > point in spamming everybody with this.
> >
> >>vl_sdio.o
> >>  btmrvl-y                     := btmrvl_main.o
> >>  btmrvl-$(CONFIG_DEBUG_FS)    += btmrvl_debugfs.o
> >>
> >> +obj-$(CONFIG_BT_IWMC3200)    += iwmc3200bt.o
> >> +
> >
> > sort this one before the Marvell driver since it is a one file only
> > driver.
> >
> No problem
> 
> >> + *  Based on  drivers/bluetooth/btsdio.c
> >> + *  Copyright (C) 2007  Cambridge Silicon Radio Ltd.
> >> + *  Copyright (C) 2007  Marcel Holtmann <marcel@holtmann.org>
> >
> > You mean "based on" or "90% copied" ;)
> >
> 
> Right, we've tried actually to use btsdio but we differ in few key points,
> actually we coudn't locate and working HW with btsdio to try if our
> changes break it
> If someone know such device please let me know.

I have a Toshiba/Socket Bluetooth card that is Type-B that does work
according to the specs. You can still get them on eBay.

And once we have a clean driver, I will look into how we might be able
to drive the Intel device via the generic driver plus some quirks.

> >> +#ifdef CONFIG_BT_IWMC3200_DEBUG
> >> +#define IBT_DBG(func, fmt, arg...) \
> >> +     dev_dbg(&((func)->dev), "%s: " fmt "\n" , __func__ , ## arg)
> >> +#define IBT_ERR(func, fmt, arg...) \
> >> +     dev_err(&((func)->dev), "%s: " fmt "\n" , __func__ , ## arg)
> >> +#define IBT_DUMP(func, buf, size) do {                                       \
> >> +     char prefix_str[30 + 1];                                        \
> >> +     scnprintf(prefix_str, 30, "%s %s",                              \
> >> +             dev_driver_string(&((func)->dev)),                      \
> >> +             dev_name(&((func)->dev)));                              \
> >> +     print_hex_dump(KERN_DEBUG, prefix_str, DUMP_PREFIX_OFFSET,      \
> >> +                     16, 1, buf, size, false);                       \
> >> +} while (0)
> >> +
> >> +#define VD "-d"
> >> +#else
> >> +#define IBT_DBG(func, fmt, arg...)
> >> +#define IBT_ERR(func, fmt, arg...)
> >> +#define IBT_DUMP(func, buf, size)
> >> +#define VD
> >> +#endif /* CONFIG_BT_IWMC3200_DEBUG */
> >> +
> >> +#ifdef REPOSITORY_LABEL
> >> +#define RL REPOSITORY_LABEL
> >> +#else
> >> +#define RL local
> >> +#endif
> >
> > All of this debug stuff has to go away. It is really not needed and
> > BT_DBG with dynamic_printk support seems more than enough.
> 
> 
> Personally I prefer using dev_dbg in device driver then inventing it
> again with pr_debug.

I am open for suggestions, but these either happen in the Bluetooth core
or you use dev_dbg directly. Until then BT_DBG is your friend,

Also the ifdef DEBUG around IBT_ERR and IBT_DUMP is pretty bad since
dev_dbg can handle that by itself these days if not mistaken.

> >> +#define IWMCBT_VERSION "0.1.6"
> >> +
> >> +#define DRIVER_VERSION IWMCBT_VERSION "-"  __stringify(RL) VD
> >
> > This one needs to be removed too. I don't care about the repository
> > label in upstream.
> 
> See what I can do somehow I need to also maintain  it internally

That is really not an upstream problem. Also please do like all other
Bluetooth drivers do.

#define VERSION "0.1.6"

Everything else is useless for us and too bloated.

> >> +#define IWMC_BT_SDIO_DEVID (0x1406)
> >> +
> >> +static const struct sdio_device_id btsdio_table[] = {
> >> +     /* IWMC3200BT (0x1406) */
> >> +     { SDIO_DEVICE(SDIO_VENDOR_ID_INTEL, 0x1406)},
> >> +     { }     /* Terminating entry */
> >> +};
> >
> > This is pointless. Just use the numbers directly. and put a proper
> > comment above SDIO_DEVICE with hardware this is. Also no need to repeat
> > the number in that comment.
> 
> This is what we agreed up, VENDOR ID is defined, device id is inline

This is how I want you to do it:

static const struct sdio_device_id iwmc3200bt_table[] = {
      /* Intel MultiCom 3200 Bluetooth device */
     { SDIO_DEVICE(SDIO_VENDOR_ID_INTEL, 0x1406)},

     { }     /* Terminating entry */
};

No extra define that we don't use and no cryptic comment. The comment is
for the developers to understand what device this is for.

> >> +
> >> +MODULE_DEVICE_TABLE(sdio, btsdio_table);
> >> +
> >> +struct btsdio_data {
> >> +     struct hci_dev   *hdev;
> >> +     struct sdio_func *func;
> >> +
> >> +     struct work_struct work;
> >> +
> >> +     struct sk_buff_head txq;
> >> +     unsigned char tx_buf[2048];
> >> +     unsigned char rx_buf[2048];
> >> +};
> >
> > I know that you guys copied btsdio driver, but if you change the name,
> > then also change the internal structure names. So this these should be
> > called iwmc3200_data and etc.
> 
> Right, I just would like to postpone it for now for easier alignment with btsdio

It is one way or the other. Either we find a way to merge this into
btsdio.c or you name the structures properly. Also if I ever wanna undo
it then sed is my friend :)

Regards

Marcel


