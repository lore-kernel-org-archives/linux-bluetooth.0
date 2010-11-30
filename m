Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290763257-12382-1-git-send-email-pavan_savoy@ti.com>
References: <1290763257-12382-1-git-send-email-pavan_savoy@ti.com>
Date: Tue, 30 Nov 2010 12:59:52 +0530
Message-ID: <AANLkTi=mdgiYam+WpGPSrwKBbEy_08NOssaumPXPUy4Z@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: padovan@profusion.mobi, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavan Savoy <pavan_savoy@ti.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 26, 2010 at 2:50 PM,  <pavan_savoy@ti.com> wrote:
> From: Pavan Savoy <pavan_savoy@ti.com>
>
Marcel, Gustavo,

Please find some time to comment and also answer some of the
concerns I have below,

Thanks & Regards,
Pavan Savoy.

> comments attended to from v5 and v6,
>
> 1. Inside ti_st_open, I previously only checked for EINPROGRESS & EPERM,
> Now I handle for EINPROGRESS - which is not really an error and
> return during all other error cases.
>
> 2. _write is still a function pointer and not an exported function, I
> need to change the underlying driver's code for this.
> However, previous lkml comments on the underlying driver's code
> suggested it to be kept as a function pointer and not EXPORT.
> Gustavo, Marcel - Please comment on this.
> Is this absolutely required? If so why?
>
> 3. test_and_set_bit of HCI_RUNNING is done at beginning of
> ti_st_open, and did not see issues during firmware download.
> However ideally I would still like to set HCI_RUNNING once the firmware
> download is done, because I don't want to allow a _send_frame during
> firmware download - Marcel, Gustavo - Please comment.
>
> 4. test_and_clear of HCI_RUNNING now done @ beginning of close.
>
> 5. EAGAIN on failure of st_write is to suggest to try and write again.
> I have never this happen - However only if UART goes bad this case may
> occur.
>
> 6. ti_st_tx_complete is very similar to hci_ldisc's tx_complete - in
> fact the code is pretty much borrowed from there.
> Marcel, Gustavo - Please suggest where should it be done? If not here.
>
> 7. comments cleaned-up + hst memory leak fixed when hci_alloc_dev fails.
>
> 8. platform_driver registration inside module_init now is similar to
> other drivers.
>
> 9. Dan Carpenter's comments on leaking hst memory on failed
> hci_register_dev and empty space after quotes in debug statements
> fixed.
>
> Thanks for the comments...
> Sorry, for previously not being very clear on which comments were
> handled and which were not.
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
> =C2=A0drivers/bluetooth/Kconfig =C2=A0 =C2=A0| =C2=A0 10 ++
> =C2=A0drivers/bluetooth/Makefile =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0drivers/bluetooth/btwilink.c | =C2=A0363 ++++++++++++++++++++++++++=
++++++++++++++++
> =C2=A03 files changed, 374 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 drivers/bluetooth/btwilink.c
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 02deef4..8e0de9a 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -219,4 +219,14 @@ config BT_ATH3K
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here to compile support for "Athe=
ros firmware download driver"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0into the kernel or say M to compile it =
as module (ath3k).
>
> +config BT_WILINK
> + =C2=A0 =C2=A0 =C2=A0 tristate "Texas Instruments WiLink7 driver"
> + =C2=A0 =C2=A0 =C2=A0 depends on TI_ST
> + =C2=A0 =C2=A0 =C2=A0 help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 This enables the Bluetooth driver for Texas=
 Instrument's BT/FM/GPS
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 combo devices. This makes use of shared tra=
nsport line discipline
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 core driver to communicate with the BT core=
 of the combo chip.
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here to compile support for Texas Ins=
trument's WiLink7 driver
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 into the kernel or say M to compile it as m=
odule.
> =C2=A0endmenu
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 71bdf13..f4460f4 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_BT_HCIBTSDIO) =C2=A0 =C2=A0+=3D btsdio.o
> =C2=A0obj-$(CONFIG_BT_ATH3K) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D ath3k.o
> =C2=A0obj-$(CONFIG_BT_MRVL) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D btmrvl=
.o
> =C2=A0obj-$(CONFIG_BT_MRVL_SDIO) =C2=A0 =C2=A0 +=3D btmrvl_sdio.o
> +obj-$(CONFIG_BT_WILINK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0+=3D btwilink.o
>
> =C2=A0btmrvl-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 :=3D btmrvl_main.o
> =C2=A0btmrvl-$(CONFIG_DEBUG_FS) =C2=A0 =C2=A0 =C2=A0+=3D btmrvl_debugfs.o
> diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> new file mode 100644
> index 0000000..71e69f8
> --- /dev/null
> +++ b/drivers/bluetooth/btwilink.c
> @@ -0,0 +1,363 @@
> +/*
> + * =C2=A0Texas Instrument's Bluetooth Driver For Shared Transport.
> + *
> + * =C2=A0Bluetooth Driver acts as interface between HCI core and
> + * =C2=A0TI Shared Transport Layer.
> + *
> + * =C2=A0Copyright (C) 2009-2010 Texas Instruments
> + * =C2=A0Author: Raja Mani <raja_mani@ti.com>
> + * =C2=A0 =C2=A0 Pavan Savoy <pavan_savoy@ti.com>
> + *
> + * =C2=A0This program is free software; you can redistribute it and/or m=
odify
> + * =C2=A0it under the terms of the GNU General Public License version 2 =
as
> + * =C2=A0published by the Free Software Foundation.
> + *
> + * =C2=A0This program is distributed in the hope that it will be useful,
> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See =
the
> + * =C2=A0GNU General Public License for more details.
> + *
> + * =C2=A0You should have received a copy of the GNU General Public Licen=
se
> + * =C2=A0along with this program; if not, write to the Free Software
> + * =C2=A0Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =C2=A0=
02111-1307 =C2=A0USA
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
> +#define VERSION =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "1.0"
> +
> +/* Number of seconds to wait for registration completion
> + * when ST returns PENDING status.
> + */
> +#define BT_REGISTER_TIMEOUT =C2=A0 6000 =C2=A0 =C2=A0 /* 6 sec */
> +
> +/**
> + * struct ti_st - driver operation structure
> + * @hdev: hci device pointer which binds to bt driver
> + * @reg_status: ST registration callback status
> + * @st_write: write function provided by the ST driver
> + * =C2=A0 =C2=A0 to be used by the driver during send_frame.
> + * @wait_reg_completion - completion sync between ti_st_open
> + * =C2=A0 =C2=A0 and ti_st_registration_completion_cb.
> + */
> +struct ti_st {
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev;
> + =C2=A0 =C2=A0 =C2=A0 char reg_status;
> + =C2=A0 =C2=A0 =C2=A0 long (*st_write) (struct sk_buff *);
> + =C2=A0 =C2=A0 =C2=A0 struct completion wait_reg_completion;
> +};
> +
> +/* Increments HCI counters based on pocket ID (cmd,acl,sco) */
> +static inline void ti_st_tx_complete(struct ti_st *hst, int pkt_type)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev =3D hst->hdev;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Update HCI stat counters */
> + =C2=A0 =C2=A0 =C2=A0 switch (pkt_type) {
> + =C2=A0 =C2=A0 =C2=A0 case HCI_COMMAND_PKT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev->stat.cmd_tx++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case HCI_ACLDATA_PKT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev->stat.acl_tx++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 case HCI_SCODATA_PKT:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev->stat.sco_tx++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 }
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
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *lhst =3D priv_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Save registration status for use in ti_st_open(=
) */
> + =C2=A0 =C2=A0 =C2=A0 lhst->reg_status =3D data;
> + =C2=A0 =C2=A0 =C2=A0 /* complete the wait in ti_st_open() */
> + =C2=A0 =C2=A0 =C2=A0 complete(&lhst->wait_reg_completion);
> +}
> +
> +/* Called by Shared Transport layer when receive data is
> + * available */
> +static long st_receive(void *priv_data, struct sk_buff *skb)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *lhst =3D priv_data;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!skb)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!lhst) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 skb->dev =3D (void *) lhst->hdev;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Forward skb to HCI core layer */
> + =C2=A0 =C2=A0 =C2=A0 err =3D hci_recv_frame(skb);
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("Unable to push=
 skb to HCI core(%d)", err);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 lhst->hdev->stat.byte_rx +=3D skb->len;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +/* ------- Interfaces to HCI layer ------ */
> +/* protocol structure registered with shared transport */
> +static struct st_proto_s ti_st_proto =3D {
> + =C2=A0 =C2=A0 =C2=A0 .type =3D ST_BT,
> + =C2=A0 =C2=A0 =C2=A0 .recv =3D st_receive,
> + =C2=A0 =C2=A0 =C2=A0 .reg_complete_cb =3D st_registration_completion_cb=
,
> +};
> +
> +/* Called from HCI core to initialize the device */
> +static int ti_st_open(struct hci_dev *hdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long timeleft;
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *hst;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 BT_DBG("%s %p", hdev->name, hdev);
> + =C2=A0 =C2=A0 =C2=A0 if (test_and_set_bit(HCI_RUNNING, &hdev->flags)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("btwilink alrea=
dy opened");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* provide contexts for callbacks from ST */
> + =C2=A0 =C2=A0 =C2=A0 hst =3D hdev->driver_data;
> + =C2=A0 =C2=A0 =C2=A0 ti_st_proto.priv_data =3D hst;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D st_register(&ti_st_proto);
> + =C2=A0 =C2=A0 =C2=A0 if (err =3D=3D -EINPROGRESS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ST is busy with eit=
her protocol registration or firmware
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* download.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare wait-for-co=
mpletion handler data structures.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_completion(&hst->=
wait_reg_completion);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reset ST registrati=
on callback status flag , this value
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* will be update=
d in ti_st_registration_completion_cb()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* function whene=
ver it called from ST driver.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst->reg_status =3D -E=
INPROGRESS;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_DBG("waiting for re=
gistration completion signal from ST");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeleft =3D wait_for_=
completion_timeout
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (&hst->wait_reg_completion,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0msecs_to_jiffies(BT_REGISTER_TIMEOUT));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!timeleft) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 clear_bit(HCI_RUNNING, &hdev->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BT_ERR("Timeout(%d sec),didn't get reg "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "completion =
signal from ST",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_REGISTER_=
TIMEOUT / 1000);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -ETIMEDOUT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Is ST registration =
callback called with ERROR status? */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hst->reg_status !=
=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 clear_bit(HCI_RUNNING, &hdev->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BT_ERR("ST registration completed with invalid "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "status %d",=
 hst->reg_status);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EAGAIN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 } else if (err !=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bit(HCI_RUNNING,=
 &hdev->flags);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("st_register fa=
iled %d", err);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* ti_st_proto.write is filled up by the underlyin=
g shared
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* transport driver upon registration
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 hst->st_write =3D ti_st_proto.write;
> + =C2=A0 =C2=A0 =C2=A0 if (!hst->st_write) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("undefined ST w=
rite function");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bit(HCI_RUNNING,=
 &hdev->flags);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Undo registration w=
ith ST */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D st_unregister(=
ST_BT);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 BT_ERR("st_unregister() failed with error %d", err);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst->st_write =3D NULL=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +/* Close device */
> +static int ti_st_close(struct hci_dev *hdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int err;
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *hst =3D hdev->driver_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags)=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* continue to unregister from transport */
> + =C2=A0 =C2=A0 =C2=A0 err =3D st_unregister(ST_BT);
> + =C2=A0 =C2=A0 =C2=A0 if (err)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("st_unregister(=
) failed with error %d", err);
> +
> + =C2=A0 =C2=A0 =C2=A0 hst->st_write =3D NULL;
> +
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +static int ti_st_send_frame(struct sk_buff *skb)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev;
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *hst;
> + =C2=A0 =C2=A0 =C2=A0 long len;
> +
> + =C2=A0 =C2=A0 =C2=A0 hdev =3D (struct hci_dev *)skb->dev;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!test_bit(HCI_RUNNING, &hdev->flags))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
> +
> + =C2=A0 =C2=A0 =C2=A0 hst =3D hdev->driver_data;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Prepend skb with frame type */
> + =C2=A0 =C2=A0 =C2=A0 memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb=
)->pkt_type,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 skb->len);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Insert skb to shared transport layer's transmit=
 queue.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Freeing skb memory is taken care in shared=
 transport layer,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* so don't free skb memory here.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 len =3D hst->st_write(skb);
> + =C2=A0 =C2=A0 =C2=A0 if (len < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree_skb(skb);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("ST write faile=
d (%ld)", len);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Try Again, would on=
ly fail if UART has gone bad */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EAGAIN;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 /* ST accepted our skb. So, Go ahead and do rest *=
/
> + =C2=A0 =C2=A0 =C2=A0 hdev->stat.byte_tx +=3D len;
> + =C2=A0 =C2=A0 =C2=A0 ti_st_tx_complete(hst, bt_cb(skb)->pkt_type);
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static void ti_st_destruct(struct hci_dev *hdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 BT_DBG("%s", hdev->name);
> + =C2=A0 =C2=A0 =C2=A0 kfree(hdev->driver_data);
> +}
> +
> +static int bt_ti_probe(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 static struct ti_st *hst;
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev;
> + =C2=A0 =C2=A0 =C2=A0 int err;
> +
> + =C2=A0 =C2=A0 =C2=A0 hst =3D kzalloc(sizeof(struct ti_st), GFP_KERNEL);
> + =C2=A0 =C2=A0 =C2=A0 if (!hst)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Expose "hciX" device to user space */
> + =C2=A0 =C2=A0 =C2=A0 hdev =3D hci_alloc_dev();
> + =C2=A0 =C2=A0 =C2=A0 if (!hdev) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(hst);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 BT_DBG("hdev %p", hdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 hst->hdev =3D hdev;
> + =C2=A0 =C2=A0 =C2=A0 hdev->bus =3D HCI_UART;
> + =C2=A0 =C2=A0 =C2=A0 hdev->driver_data =3D hst;
> + =C2=A0 =C2=A0 =C2=A0 hdev->open =3D ti_st_open;
> + =C2=A0 =C2=A0 =C2=A0 hdev->close =3D ti_st_close;
> + =C2=A0 =C2=A0 =C2=A0 hdev->flush =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 hdev->send =3D ti_st_send_frame;
> + =C2=A0 =C2=A0 =C2=A0 hdev->destruct =3D ti_st_destruct;
> + =C2=A0 =C2=A0 =C2=A0 hdev->owner =3D THIS_MODULE;
> +
> + =C2=A0 =C2=A0 =C2=A0 err =3D hci_register_dev(hdev);
> + =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("Can't register=
 HCI device error %d", err);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(hst);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_free_dev(hdev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 BT_DBG("HCI device registered (hdev %p)", hdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_set_drvdata(&pdev->dev, hst);
> + =C2=A0 =C2=A0 =C2=A0 return err;
> +}
> +
> +static int bt_ti_remove(struct platform_device *pdev)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct hci_dev *hdev;
> + =C2=A0 =C2=A0 =C2=A0 struct ti_st *hst =3D dev_get_drvdata(&pdev->dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!hst)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;
> +
> + =C2=A0 =C2=A0 =C2=A0 hdev =3D hst->hdev;
> + =C2=A0 =C2=A0 =C2=A0 ti_st_close(hdev);
> + =C2=A0 =C2=A0 =C2=A0 hci_unregister_dev(hdev);
> +
> + =C2=A0 =C2=A0 =C2=A0 hci_free_dev(hdev);
> + =C2=A0 =C2=A0 =C2=A0 kfree(hst);
> +
> + =C2=A0 =C2=A0 =C2=A0 dev_set_drvdata(&pdev->dev, NULL);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static struct platform_driver btwilink_driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 .probe =3D bt_ti_probe,
> + =C2=A0 =C2=A0 =C2=A0 .remove =3D bt_ti_remove,
> + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "btwilink",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE=
,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +/* ------- Module Init/Exit interfaces ------ */
> +static int __init btwilink_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 BT_INFO("Bluetooth Driver for TI WiLink - Version =
%s", VERSION);
> +
> + =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&btwilink_driver);
> +}
> +
> +static void __exit btwilink_exit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&btwilink_driver);
> +}
> +
> +module_init(btwilink_init);
> +module_exit(btwilink_exit);
> +
> +/* ------ Module Info ------ */
> +
> +MODULE_AUTHOR("Raja Mani <raja_mani@ti.com>");
> +MODULE_DESCRIPTION("Bluetooth Driver for TI Shared Transport" VERSION);
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> --
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
