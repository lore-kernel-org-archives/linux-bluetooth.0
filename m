Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>
Subject: RE: [PATCH 2/4] Bluetooth: btmrvl: add prints debug control support
Date: Thu, 15 Oct 2015 14:28:22 +0000
Message-ID: <152e24eb17f549d69c00456796931459@SC-EXCH04.marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
 <1444836883-14701-2-git-send-email-akarwar@marvell.com>
 <51C3944C-E51F-4554-9803-1DA1B561BDF8@holtmann.org>
In-Reply-To: <51C3944C-E51F-4554-9803-1DA1B561BDF8@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, October 15, 2015 4:32 AM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; Zhaoyang Liu
> Subject: Re: [PATCH 2/4] Bluetooth: btmrvl: add prints debug control
> support
>=20
> Hi Amitkumar,
>=20
> > This patch adds support for debugging print control in marvell
> > bluetooth driver. The debug level can be controlled by setting module
> > loading parameter debug_mask.
> >
> > Example:
> > insmod btmrvl.ko debug_mask=3D0x37
> >
> > Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> > Signed-off-by: Cathy Luo <cluo@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > drivers/bluetooth/btmrvl_drv.h  | 35
> > ++++++++++++++++++++++++++++++++++-
> > drivers/bluetooth/btmrvl_main.c | 18 ++++++++++++++++++
> > 2 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btmrvl_drv.h
> > b/drivers/bluetooth/btmrvl_drv.h index 27a9aac..1119d09 100644
> > --- a/drivers/bluetooth/btmrvl_drv.h
> > +++ b/drivers/bluetooth/btmrvl_drv.h
> > @@ -79,6 +79,7 @@ struct btmrvl_device { struct btmrvl_adapter {
> > 	void *hw_regs_buf;
> > 	u8 *hw_regs;
> > +	unsigned int debug_mask;
> > 	u32 int_count;
> > 	struct sk_buff_head tx_queue;
> > 	u8 psmode;
> > @@ -155,8 +156,40 @@ struct btmrvl_event {
> > 	u8 data[4];
> > } __packed;
> >
> > -/* Prototype of global function */
> > +/* marvell bluetooth driver debug level */ enum BTMRVL_DEBUG_LEVEL {
> > +	BTMRVL_DBG_MSG		=3D 0x00000001,
> > +	BTMRVL_DBG_FATAL	=3D 0x00000002,
> > +	BTMRVL_DBG_ERROR	=3D 0x00000004,
> > +	BTMRVL_DBG_DATA		=3D 0x00000008,
> > +	BTMRVL_DBG_CMD		=3D 0x00000010,
> > +	BTMRVL_DBG_EVENT	=3D 0x00000020,
> > +	BTMRVL_DBG_INTR		=3D 0x00000040,
> > +
> > +	BTMRVL_DBG_DAT_D	=3D 0x00010000,
> > +	BTMRVL_DBG_CMD_D	=3D 0x00020000,
> > +
> > +	BTMRVL_DBG_ENTRY	=3D 0x10000000,
> > +	BTMRVL_DBG_WARN		=3D 0x20000000,
> > +	BTMRVL_DBG_INFO		=3D 0x40000000,
> > +
> > +	BTMRVL_DBG_ANY		=3D 0xffffffff
> > +};
> >
> > +#define BTMRVL_DBG_DEFAULT_MASK		(BTMRVL_DBG_MSG | \
> > +					 BTMRVL_DBG_FATAL | \
> > +					 BTMRVL_DBG_ERROR)
> > +
> > +int btmrvl_log_allowed(struct btmrvl_adapter *adapter,
> > +		       enum BTMRVL_DEBUG_LEVEL level);
> > +
> > +#define btmrvl_dbg(adapter, dbg_mask, fmt, args...)		\
> > +do {								\
> > +	if (btmrvl_log_allowed(adapter, BTMRVL_DBG_##dbg_mask))	\
> > +		pr_info("btmrvl: " fmt "\n", ##args);		\
> > +} while (0)
> > +
> > +/* Prototype of global function */
> > int btmrvl_register_hdev(struct btmrvl_private *priv); struct
> > btmrvl_private *btmrvl_add_card(void *card); int
> > btmrvl_remove_card(struct btmrvl_private *priv); diff --git
> > a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> > index 61d2f39..8e53609 100644
> > --- a/drivers/bluetooth/btmrvl_main.c
> > +++ b/drivers/bluetooth/btmrvl_main.c
> > @@ -29,6 +29,23 @@
> >
> > #define VERSION "1.0"
> >
> > +static unsigned int debug_mask =3D BTMRVL_DBG_DEFAULT_MASK;
> > +module_param(debug_mask, uint, 0); MODULE_PARM_DESC(debug_mask,
> > +"bitmap for debug flags");
>=20
> I see no reason for this being a module parameter. I think you really
> want to have that via debugfs for reach adapter.
>=20

Agreed. I will remove this.

Regards,
Amitkumar
