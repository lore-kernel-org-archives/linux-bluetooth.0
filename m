Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>
Date: Thu, 3 Oct 2013 14:06:40 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: operate on 16-bit opcodes instead of
 ogf/ocf
Message-ID: <477F20668A386D41ADCC57781B1F70430F451FB266@SC-VEXCH1.marvell.com>
References: <1380824600-13655-1-git-send-email-bzhao@marvell.com>
 <CAJdJm_N1=a7URKmU8xOsOzOaYHKQdNXiR7VryeOc4+i2uf7RqQ@mail.gmail.com>
In-Reply-To: <CAJdJm_N1=a7URKmU8xOsOzOaYHKQdNXiR7VryeOc4+i2uf7RqQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Thanks for your comments.

> > -               if (ogf =3D=3D OGF) {
> > -                       BT_DBG("vendor event skipped: ogf 0x%4.4x ocf 0=
x%4.4x",
> > -                              ogf, ocf);
> > +               if ((opcode & 0xfc00) =3D=3D 0xfc00) {
> > +                       BT_DBG("vendor event skipped: opcode=3D%#4.4x",=
 opcode);
>=20
> I think you could use "if (hci_opcode_ogf(opcode) =3D=3D 0x3F)" to make i=
t
> more readable.

Sure, I will make that change in v2.

> > @@ -179,7 +176,7 @@ static int btmrvl_send_sync_cmd(struct btmrvl_priva=
te *priv, u16 cmd_no,
> >         }
> >
> >         hdr =3D (struct hci_command_hdr *)skb_put(skb, HCI_COMMAND_HDR_=
SIZE);
> > -       hdr->opcode =3D cpu_to_le16(hci_opcode_pack(OGF, cmd_no));
> > +       hdr->opcode =3D cpu_to_le16(opcode);
>=20
> Are you sure the callers of btmrvl_send_sync_cmd() do not need to be
> changed to pass an opcode instead of just the OCF?

Previously we pass the cmd_no which is the OCF bits to the function, and th=
e function packs it to opcode.

Now I changed the macros of the cmd_no from OCF to opcode as shown below, s=
o no change to the callers.

-/* Bluetooth commands  */
-#define BT_CMD_AUTO_SLEEP_MODE		0x23
-#define BT_CMD_HOST_SLEEP_CONFIG	0x59
-#define BT_CMD_HOST_SLEEP_ENABLE	0x5A
-#define BT_CMD_MODULE_CFG_REQ		0x5B
-#define BT_CMD_LOAD_CONFIG_DATA		0x61
+/* Vendor specific Bluetooth commands */
+#define BT_CMD_AUTO_SLEEP_MODE		0xFC23
+#define BT_CMD_HOST_SLEEP_CONFIG	0xFC59
+#define BT_CMD_HOST_SLEEP_ENABLE	0xFC5A
+#define BT_CMD_MODULE_CFG_REQ		0xFC5B
+#define BT_CMD_LOAD_CONFIG_DATA		0xFC61

Thanks,
Bing
