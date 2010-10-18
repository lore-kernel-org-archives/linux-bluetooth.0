Return-Path: <cyrus@holtmann.org>
From: "Savoy, Pavan" <pavan_savoy@ti.com>
To: "Savoy, Pavan" <pavan_savoy@ti.com>,
        "padovan@profusion.mobi"
	<padovan@profusion.mobi>,
        "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 18 Oct 2010 23:02:20 +0530
Subject: RE: [PATCH] Bluetooth: btwilink driver
Message-ID: <19F8576C6E063C45BE387C64729E739404AA4E7565@dbde02.ent.ti.com>
References: <1287176299-19313-1-git-send-email-pavan_savoy@ti.com>
In-Reply-To: <1287176299-19313-1-git-send-email-pavan_savoy@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



> -----Original Message-----
> From: Savoy, Pavan
> Sent: Friday, October 15, 2010 3:58 PM
> To: padovan@profusion.mobi; marcel@holtmann.org
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Savoy,
> Pavan
> Subject: [PATCH] Bluetooth: btwilink driver
>
> From: Pavan Savoy <pavan_savoy@ti.com>
>
> Gustavo, Marcel,

Hope you had a nice weekend :)
Any comments on this patch?

As you might notice, I no longer register to HCI from module_init and have =
it
as a platform device driver and register to HCI inside the probe.

> Renaming the patch, since the driver is renamed to btwilink.
> Thanks for the comments,
> Please review and provide your comments on this version of patch,
>
> -- patch description --
>
> This is the bluetooth protocol driver for the TI WiLink7 chipsets.
> Texas Instrument's WiLink chipsets combine wireless technologies
> like BT, FM, GPS and WLAN onto a single chip.
>
> This Bluetooth driver works on top of the TI_ST shared transport
> line discipline driver which also allows other drivers like
> FM V4L2 and GPS character driver to make use of the same UART interface.
>
> Kconfig and Makefile modifications to enable the Bluetooth
> driver for Texas Instrument's WiLink 7 chipset.
>
> Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
> ---
>  drivers/bluetooth/Kconfig    |   10 +
>  drivers/bluetooth/Makefile   |    1 +
>  drivers/bluetooth/btwilink.c |  424
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/bluetooth/btwilink.c
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 02deef4..e0d67dd 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -219,4 +219,14 @@ config BT_ATH3K
>         Say Y here to compile support for "Atheros firmware download driv=
er"
>         into the kernel or say M to compile it as module (ath3k).
>
> +config BT_WILINK
> +     tristate "BlueZ bluetooth driver for TI ST"
> +     depends on TI_ST
> +     help
> +       This enables the Bluetooth driver for Texas Instrument's BT/FM/GP=
S
> +       combo devices. This makes use of shared transport line discipline
> +       core driver to communicate with the BT core of the combo chip.
> +
> +       Say Y here to compile support for Texas Instrument's WiLink7 driv=
er
> +       into the kernel or say M to compile it as module.
>  endmenu
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 71bdf13..f4460f4 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_BT_HCIBTSDIO)  +=3D btsdio.o
>  obj-$(CONFIG_BT_ATH3K)               +=3D ath3k.o
>  obj-$(CONFIG_BT_MRVL)                +=3D btmrvl.o
>  obj-$(CONFIG_BT_MRVL_SDIO)   +=3D btmrvl_sdio.o
> +obj-$(CONFIG_BT_WILINK)              +=3D btwilink.o
>
>  btmrvl-y                     :=3D btmrvl_main.o
>  btmrvl-$(CONFIG_DEBUG_FS)    +=3D btmrvl_debugfs.o
> diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> new file mode 100644
> index 0000000..f67791f
> --- /dev/null
> +++ b/drivers/bluetooth/btwilink.c
> @@ -0,0 +1,424 @@
> +/*
> + *  Texas Instrument's Bluetooth Driver For Shared Transport.
> + *
> + *  Bluetooth Driver acts as interface between HCI CORE and
> + *  TI Shared Transport Layer.
> + *
> + *  Copyright (C) 2009-2010 Texas Instruments
> + *  Author: Raja Mani <raja_mani@ti.com>
> + *   Pavan Savoy <pavan_savoy@ti.com>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include <linux/ti_wilink_st.h>
> +
> +/* Bluetooth Driver Version */
> +#define VERSION               "1.0"
> +
> +/* Defines number of seconds to wait for reg completion
> + * callback getting called from ST (in case,registration
> + * with ST returns PENDING status)
> + */
> +#define BT_REGISTER_TIMEOUT   6000   /* 6 sec */
> +
> +/**
> + * struct ti_st - BT driver operation structure
> + * @hdev: hci device pointer which binds to bt driver
> + * @flags: used locally,to maintain various BT driver status
> + * @streg_cbdata: to hold ST registration callback status
> + * @st_write: write function pointer of ST driver
> + * @wait_reg_completion - completion sync between ti_st_open
> + *   and ti_st_registration_completion_cb.
> + */
> +struct ti_st {
> +     struct hci_dev *hdev;
> +     char streg_cbdata;
> +     long (*st_write) (struct sk_buff *);
> +     struct completion wait_reg_completion;
> +};
> +
> +static int reset;
> +
> +/* Increments HCI counters based on pocket ID (cmd,acl,sco) */
> +static inline void ti_st_tx_complete(struct ti_st *hst, int pkt_type)
> +{
> +     struct hci_dev *hdev;
> +     hdev =3D hst->hdev;
> +
> +     /* Update HCI stat counters */
> +     switch (pkt_type) {
> +     case HCI_COMMAND_PKT:
> +             hdev->stat.cmd_tx++;
> +             break;
> +
> +     case HCI_ACLDATA_PKT:
> +             hdev->stat.acl_tx++;
> +             break;
> +
> +     case HCI_SCODATA_PKT:
> +             hdev->stat.sco_tx++;
> +             break;
> +     }
> +}
> +
> +/* ------- Interfaces to Shared Transport ------ */
> +
> +/* Called by ST layer to indicate protocol registration completion
> + * status.ti_st_open() function will wait for signal from this
> + * API when st_register() function returns ST_PENDING.
> + */
> +static void st_registration_completion_cb(void *priv_data, char data)
> +{
> +     struct ti_st *lhst =3D (struct ti_st *)priv_data;
> +     /* ti_st_open() function needs value of 'data' to know
> +      * the registration status(success/fail),So have a back
> +      * up of it.
> +      */
> +     lhst->streg_cbdata =3D data;
> +
> +     /* Got a feedback from ST for BT driver registration
> +      * request.Wackup ti_st_open() function to continue
> +      * it's open operation.
> +      */
> +     complete(&lhst->wait_reg_completion);
> +}
> +
> +/* Called by Shared Transport layer when receive data is
> + * available */
> +static long st_receive(void *priv_data, struct sk_buff *skb)
> +{
> +     int err;
> +     struct ti_st *lhst =3D (struct ti_st *)priv_data;
> +
> +     if (!skb)
> +             return -EFAULT;
> +
> +     if (!lhst) {
> +             kfree_skb(skb);
> +             return -EFAULT;
> +     }
> +
> +     skb->dev =3D (struct net_device *)lhst->hdev;
> +
> +     /* Forward skb to HCI CORE layer */
> +     err =3D hci_recv_frame(skb);
> +     if (err) {
> +             kfree_skb(skb);
> +             BT_ERR("Unable to push skb to HCI CORE(%d)", err);
> +             return err;
> +     }
> +
> +     lhst->hdev->stat.byte_rx +=3D skb->len;
> +     return 0;
> +}
> +
> +/* ------- Interfaces to HCI layer ------ */
> +/* protocol structure registered with shared transport */
> +static struct st_proto_s ti_st_proto =3D {
> +     .type =3D ST_BT,
> +     .recv =3D st_receive,
> +     .reg_complete_cb =3D st_registration_completion_cb,
> +     .priv_data =3D NULL,
> +};
> +
> +/* Called from HCI core to initialize the device */
> +static int ti_st_open(struct hci_dev *hdev)
> +{
> +     unsigned long timeleft;
> +     struct ti_st *hst;
> +     int err;
> +
> +     BT_DBG("%s %p", hdev->name, hdev);
> +
> +     /* provide contexts for callbacks from ST */
> +     hst =3D hdev->driver_data;
> +     ti_st_proto.priv_data =3D hst;
> +
> +     err =3D st_register(&ti_st_proto);
> +     if (err =3D=3D -EINPROGRESS) {
> +             /* Prepare wait-for-completion handler data structures.
> +              * Needed to syncronize this and st_registration_completion=
_cb()
> +              * functions.
> +              */
> +             init_completion(&hst->wait_reg_completion);
> +
> +             /* Reset ST registration callback status flag , this value
> +              * will be updated in ti_st_registration_completion_cb()
> +              * function whenever it called from ST driver.
> +              */
> +             hst->streg_cbdata =3D -EINPROGRESS;
> +
> +             /* ST is busy with other protocol registration(may be busy =
with
> +              * firmware download).So,Wait till the registration callbac=
k
> +              * (passed as a argument to st_register() function) getting
> +              * called from ST.
> +              */
> +             BT_DBG(" waiting for reg completion signal from ST");
> +
> +             timeleft =3D wait_for_completion_timeout
> +                     (&hst->wait_reg_completion,
> +                      msecs_to_jiffies(BT_REGISTER_TIMEOUT));
> +             if (!timeleft) {
> +                     BT_ERR("Timeout(%d sec),didn't get reg"
> +                                     "completion signal from ST",
> +                                     BT_REGISTER_TIMEOUT / 1000);
> +                     return -ETIMEDOUT;
> +             }
> +
> +             /* Is ST registration callback called with ERROR value? */
> +             if (hst->streg_cbdata !=3D 0) {
> +                     BT_ERR("ST reg completion CB called with invalid"
> +                                     "status %d", hst->streg_cbdata);
> +                     return -EAGAIN;
> +             }
> +             err =3D 0;
> +     } else if (err =3D=3D -EPERM) {
> +             BT_ERR("st_register failed %d", err);
> +             return -EAGAIN;
> +     }
> +
> +     /* Do we have proper ST write function? */
> +     if (ti_st_proto.write !=3D NULL) {
> +             /* We need this pointer for sending any Bluetooth pkts */
> +             hst->st_write =3D ti_st_proto.write;
> +     } else {
> +             BT_ERR("failed to get ST write func pointer");
> +
> +             /* Undo registration with ST */
> +             err =3D st_unregister(ST_BT);
> +             if (err)
> +                     BT_ERR("st_unregister failed %d", err);
> +
> +             hst->st_write =3D NULL;
> +             return -EAGAIN;
> +     }
> +
> +     /* Registration with ST layer is completed successfully,
> +      * now chip is ready to accept commands from HCI CORE.
> +      * Mark HCI Device flag as RUNNING
> +      */
> +     set_bit(HCI_RUNNING, &hdev->flags);
> +     return err;
> +}
> +
> +/* Close device */
> +static int ti_st_close(struct hci_dev *hdev)
> +{
> +     int err =3D 0;
> +     struct ti_st *hst;
> +
> +     hst =3D hdev->driver_data;
> +
> +     /* Clear HCI device RUNNING flag */
> +     if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
> +             BT_ERR("HCI not RUNNING?");
> +
> +     /* continue to unregister from transport */
> +     err =3D st_unregister(ST_BT);
> +     if (err)
> +             BT_ERR("st_unregister failed %d", err);
> +
> +     hst->st_write =3D NULL;
> +     return err;
> +}
> +
> +/* Called from HCI CORE , Sends frames to Shared Transport */
> +static int ti_st_send_frame(struct sk_buff *skb)
> +{
> +     struct hci_dev *hdev;
> +     struct ti_st *hst;
> +     long len;
> +
> +     if (!skb)
> +             return -ENOMEM;
> +
> +     hdev =3D (struct hci_dev *)skb->dev;
> +     if (!hdev)
> +             return -ENODEV;
> +
> +     if (!test_bit(HCI_RUNNING, &hdev->flags))
> +             return -EBUSY;
> +
> +     hst =3D (struct ti_st *)hdev->driver_data;
> +
> +     /* Prepend skb with frame type */
> +     memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
> +
> +     BT_DBG(" %s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type,
> +                     skb->len);
> +
> +     /* Insert skb to shared transport layer's transmit queue.
> +      * Freeing skb memory is taken care in shared transport layer,
> +      * so don't free skb memory here.
> +      */
> +     if (!hst->st_write) {
> +             kfree_skb(skb);
> +             BT_ERR(" Can't write to ST, st_write null?");
> +             return -EAGAIN;
> +     }
> +
> +     len =3D hst->st_write(skb);
> +     if (len < 0) {
> +             kfree_skb(skb);
> +             BT_ERR(" ST write failed (%ld)", len);
> +             return -EAGAIN;
> +     }
> +
> +     /* ST accepted our skb. So, Go ahead and do rest */
> +     hdev->stat.byte_tx +=3D len;
> +     ti_st_tx_complete(hst, bt_cb(skb)->pkt_type);
> +
> +     return 0;
> +}
> +
> +static void ti_st_destruct(struct hci_dev *hdev)
> +{
> +     if (!hdev)
> +             BT_ERR("Destruct called with invalid HCI Device"
> +                             "(hdev=3DNULL)");
> +
> +     BT_DBG("%s", hdev->name);
> +
> +     /* free ti_st memory */
> +     kfree(hdev->driver_data);
> +     return;
> +}
> +
> +/* Creates new HCI device */
> +static int ti_st_register_dev(struct ti_st *hst)
> +{
> +     struct hci_dev *hdev;
> +
> +     /* Initialize and register HCI device */
> +     hdev =3D hci_alloc_dev();
> +     if (!hdev)
> +             return -ENOMEM;
> +
> +     BT_DBG(" HCI device allocated. hdev=3D %p", hdev);
> +
> +     hst->hdev =3D hdev;
> +     hdev->bus =3D HCI_UART;
> +     hdev->driver_data =3D hst;
> +     hdev->open =3D ti_st_open;
> +     hdev->close =3D ti_st_close;
> +     hdev->flush =3D NULL;
> +     hdev->send =3D ti_st_send_frame;
> +     hdev->destruct =3D ti_st_destruct;
> +     hdev->owner =3D THIS_MODULE;
> +
> +     if (reset)
> +             set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
> +
> +     if (hci_register_dev(hdev) < 0) {
> +             BT_ERR("Can't register HCI device");
> +             hci_free_dev(hdev);
> +             return -ENODEV;
> +     }
> +
> +     BT_DBG(" HCI device registered. hdev=3D %p", hdev);
> +     return 0;
> +}
> +
> +
> +static int bt_ti_probe(struct platform_device *pdev)
> +{
> +     int err;
> +     static struct ti_st *hst;
> +     err =3D 0;
> +
> +     BT_DBG(" Bluetooth Driver Version %s", VERSION);
> +
> +     hst =3D kzalloc(sizeof(struct ti_st), GFP_KERNEL);
> +     if (!hst) {
> +             BT_ERR("Can't allocate control structure");
> +             return -ENOMEM;
> +     }
> +
> +     /* Expose "hciX" device to user space */
> +     err =3D ti_st_register_dev(hst);
> +     if (err) {
> +             kfree(hst);
> +             BT_ERR("Unable to expose hciX device(%d)", err);
> +             return err;
> +     }
> +
> +     dev_set_drvdata(&pdev->dev, hst);
> +     return err;
> +}
> +
> +static int bt_ti_remove(struct platform_device *pdev)
> +{
> +     struct ti_st *hst;
> +
> +     hst =3D dev_get_drvdata(&pdev->dev);
> +     /* Deallocate local resource's memory  */
> +     if (hst) {
> +             struct hci_dev *hdev =3D hst->hdev;
> +             if (!hdev) {
> +                     BT_ERR("Invalid hdev memory");
> +                     kfree(hst);
> +             } else {
> +                     ti_st_close(hdev);
> +                     hci_unregister_dev(hdev);
> +                     /* Free HCI device memory */
> +                     hci_free_dev(hdev);
> +             }
> +     }
> +     return 0;
> +}
> +
> +static struct platform_driver btwilink_driver =3D {
> +     .probe =3D bt_ti_probe,
> +     .remove =3D bt_ti_remove,
> +     .driver =3D {
> +             .name =3D "btwilink",
> +             .owner =3D THIS_MODULE,
> +     },
> +};
> +
> +/* ------- Module Init/Exit interfaces ------ */
> +static int __init bt_drv_init(void)
> +{
> +     long ret;
> +
> +     ret =3D platform_driver_register(&btwilink_driver);
> +     if (ret !=3D 0) {
> +             BT_ERR("btwilink platform drv registration failed");
> +             return -EPERM;
> +     }
> +     return 0;
> +}
> +
> +static void __exit bt_drv_exit(void)
> +{
> +     platform_driver_unregister(&btwilink_driver);
> +}
> +
> +module_init(bt_drv_init);
> +module_exit(bt_drv_exit);
> +
> +/* ------ Module Info ------ */
> +
> +module_param(reset, bool, 0644);
> +MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
> +MODULE_AUTHOR("Raja Mani <raja_mani@ti.com>");
> +MODULE_DESCRIPTION("Bluetooth Driver for TI Shared Transport" VERSION);
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> --
> 1.6.5
