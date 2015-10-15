Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>
Subject: RE: [PATCH 3/4] Bluetooth: btmrvl: add debug mask debugfs parameter
Date: Thu, 15 Oct 2015 14:28:31 +0000
Message-ID: <077dc110335348af9ffa5ccbde75d356@SC-EXCH04.marvell.com>
References: <1444836883-14701-1-git-send-email-akarwar@marvell.com>
 <1444836883-14701-3-git-send-email-akarwar@marvell.com>
 <E8843A7E-047C-474C-9B26-F5B0F8F0EDE0@holtmann.org>
In-Reply-To: <E8843A7E-047C-474C-9B26-F5B0F8F0EDE0@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, October 15, 2015 4:34 AM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; Zhaoyang Liu
> Subject: Re: [PATCH 3/4] Bluetooth: btmrvl: add debug mask debugfs
> parameter
>=20
> Hi Amitkumar,
>=20
> > This patch adds support for debug mask read/write operations via
> > debugfs. It is useful during debugging driver logs.
> >
> > Examples:
> >
> > Read current debug mask:
> > cat /sys/kernel/debug/bluetooth/hci0/config/debug_mask
> >
> > Update debug mask:
> > echo 0xff > /sys/kernel/debug/bluetooth/hci0/config/debug_mask
> >
> > Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
> > Signed-off-by: Cathy Luo <cluo@marvell.com>
> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> > ---
> > drivers/bluetooth/btmrvl_debugfs.c | 51
> > ++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btmrvl_debugfs.c
> > b/drivers/bluetooth/btmrvl_debugfs.c
> > index 1828ed8..af52b03 100644
> > --- a/drivers/bluetooth/btmrvl_debugfs.c
> > +++ b/drivers/bluetooth/btmrvl_debugfs.c
> > @@ -196,6 +196,55 @@ static const struct file_operations
> btmrvl_fwdump_fops =3D {
> > 	.llseek =3D default_llseek,
> > };
> >
> > +/* Proc debug_mask file read handler.
> > + * This function is called when the 'debug_mask' file is opened for
> > +reading
> > + * This function can be used read driver debugging mask value.
> > + */
> > +static ssize_t btmrvl_debug_mask_read(struct file *file, char __user
> *ubuf,
> > +				      size_t count, loff_t *ppos) {
> > +	struct btmrvl_private *priv =3D file->private_data;
> > +	char buf[32];
> > +	int ret;
> > +
> > +	ret =3D snprintf(buf, sizeof(buf) - 1, "debug mask=3D0x%08x\n",
> > +		       priv->adapter->debug_mask);
>=20
> the file is already called debug mask, no need to prefix the file
> content with some key=3Dval thing. Just return the value.
>=20

Sure. We will remove redundant string "debug_mask=3D".

Regards,
Amitkumar
