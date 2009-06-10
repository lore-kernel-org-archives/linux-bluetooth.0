Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 10 Jun 2009 14:18:30 -0700
Subject: RE: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
Message-ID: <477F20668A386D41ADCC57781B1F704301EDD86CDF@SC-VEXCH1.marvell.com>
References: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
	 <1244560807.3068.12.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301EDD86A59@SC-VEXCH1.marvell.com>
 <1244617643.3068.26.camel@localhost.localdomain>
In-Reply-To: <1244617643.3068.26.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Wednesday, June 10, 2009 12:07 AM
> To: Bing Zhao
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marve=
ll bluetooth devices
>
> Hi Bing,
>
> > > > This driver provides basic definitions and library functions to
> > > > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > > > combo chip.
> > >
> > > so I created a bluetooth-mrvl-2.6 tree with your patches and already =
a
> > > major collection of cleanup patches.
> >
> > Thanks for the cleanups.
> >
> > > The biggest problem right now is that your driver spits out casting
> > > warnings like crazy. This is not acceptable. So please send me a patc=
h
> > > to fix these based on bluetooth-mrvl-2.6.
> >
> > Could you please let me know how to catch these casting warnings? I'm u=
sing GCC 4.3.2 with sparse
> on x86 laptop (Fedora 8) but I couldn't get the warnings.
>
> let me guess, you are running a 32-bit kernel. Just run a 64-bit kernel
> and you will see them. I am using Fedora 10.

Yes, I'm running 32-bit kernel. I'll try to install a 64-bit system and fix=
 those warnings.

> I also have to compile this at least on one big endian machine. Will use
> my Quad G5 once I get home.
>
> > > I did fix the firmware non-sense you had in there, but I haven't had
> > > time to test it with real hardware. So please do so.
> >
> > Thanks for the fix and it works well.
>
> Good. I wasn't sure I did this right. Stupid driver_data is unsigned
> long and that requires casting :(
>
> > > Also I am considering to just remove all this Enter/Leave debug
> > > non-sense since it makes the code really hard to read.
> >
> > I can remove those Enter/Leave debug, if you prefer.
>
> Tell me what you need them for. I don't mind having the Enter part with
> BT_DBG since we are using that anyway to print debug information about
> the parameters we give to a function, but the Leave part is cluttering
> the code. Can you just follow the style the other drivers are using.

The whole btmrvl driver was ported from Marvell SD8688 Bluetooth reference =
driver. The Enter/Leave debug messages have been in there since very beginn=
ing. Sometimes these Enter/Leave things are useful for customers to debug w=
hen our reference driver is ported onto their own platform/OS.


To make it easier to upstream kernel, I'm sending a patch to remove all Ent=
er/Leave debug messages except for an Enter message with parameters passed =
in.

> And again, after that you are not done since the whole driver needs more
> cleanups. That is just in a shape I consider merging it upstream so we
> can start fixing it there. I still consider it a little bit too
> complicated for what is really needed to drive your hardware.

That's understood. Several items are remaining:

1) Proper handling of vendor commands/events
2) "rmmod" flag in exit_module()
3) more cleanups

Should you have any suggestions on any of these, I'd be happy to try.

> Regards
>
> Marcel
>


patch against bluetooth-mrvl-2.6.git tree:

>From 638a2d6f2dba0e1e23d2e2a61a15c48c36fd6b25 Mon Sep 17 00:00:00 2001
From: Bing Zhao <bzhao@marvell.com>
Date: Tue, 9 Jun 2009 19:20:19 -0700
Subject: [PATCH] Bluetooth: Remove Enter/Leave debug messages for Marvell d=
river

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---

 drivers/bluetooth/btmrvl_main.c |   84 +----------------------------
 drivers/bluetooth/btmrvl_sdio.c |  110 +----------------------------------=
---
 2 files changed, 6 insertions(+), 188 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_mai=
n.c
index 61168ec..c344300 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -32,8 +32,6 @@
  */
 void btmrvl_interrupt(struct btmrvl_private *priv)
 {
-       BT_DBG("Enter");
-
        priv->adapter->ps_state =3D PS_AWAKE;

        priv->adapter->wakeup_tries =3D 0;
@@ -41,8 +39,6 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
        priv->adapter->int_count++;

        wake_up_interruptible(&priv->main_thread.wait_q);
-
-       BT_DBG("Leave");
 }
 EXPORT_SYMBOL_GPL(btmrvl_interrupt);

@@ -52,8 +48,6 @@ void btmrvl_check_evtpkt(struct btmrvl_private *priv, str=
uct sk_buff *skb)
        struct hci_ev_cmd_complete *ec;
        u16 opcode, ocf;

-       BT_DBG("Enter");
-
        if (hdr->evt =3D=3D HCI_EV_CMD_COMPLETE) {
                ec =3D (void *) (skb->data + HCI_EVENT_HDR_SIZE);
                opcode =3D __le16_to_cpu(ec->opcode);
@@ -65,8 +59,6 @@ void btmrvl_check_evtpkt(struct btmrvl_private *priv, str=
uct sk_buff *skb)
                        wake_up_interruptible(&priv->adapter->cmd_wait_q);
                }
        }
-
-       BT_DBG("Leave");
 }
 EXPORT_SYMBOL_GPL(btmrvl_check_evtpkt);

@@ -76,8 +68,6 @@ int btmrvl_process_event(struct btmrvl_private *priv, str=
uct sk_buff *skb)
        struct btmrvl_event *event;
        u8 ret =3D 0;

-       BT_DBG("Enter");
-
        event =3D (struct btmrvl_event *) skb->data;
        if (event->ec !=3D 0xff) {
                BT_DBG("Not Marvell Event=3D%x", event->ec);
@@ -151,8 +141,6 @@ exit:
        if (!ret)
                kfree_skb(skb);

-       BT_DBG("Leave");
-
        return ret;
 }
 EXPORT_SYMBOL_GPL(btmrvl_process_event);
@@ -163,8 +151,6 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *p=
riv, int subcmd)
        struct btmrvl_cmd *cmd;
        u8 ret =3D 0;

-       BT_DBG("Enter");
-
        skb =3D bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
        if (skb =3D=3D NULL) {
                BT_ERR("No free skb");
@@ -202,8 +188,6 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *p=
riv, int subcmd)
        BT_DBG("module cfg Command done");

 exit:
-       BT_DBG("Leave");
-
        return ret;
 }
 EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
@@ -214,8 +198,6 @@ static int btmrvl_enable_hs(struct btmrvl_private *priv=
)
        struct btmrvl_cmd *cmd;
        u8 ret =3D 0;

-       BT_DBG("Enter");
-
        skb =3D bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
        if (skb =3D=3D NULL) {
                BT_ERR("No free skb");
@@ -247,8 +229,6 @@ static int btmrvl_enable_hs(struct btmrvl_private *priv=
)
        }

 exit:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -258,8 +238,6 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
        struct btmrvl_cmd *cmd;
        u8 ret =3D 0;

-       BT_DBG("Enter");
-
        if (priv->btmrvl_dev.hscfgcmd) {
                priv->btmrvl_dev.hscfgcmd =3D 0;

@@ -328,8 +306,6 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
        }

 exit:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -337,17 +313,12 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv,=
 struct sk_buff *skb)
 {
        u8 ret =3D 0;

-       BT_DBG("Enter");
-
-       if (!skb || !skb->data) {
-               BT_DBG("Leave");
+       if (!skb || !skb->data)
                return -EINVAL;
-       }

        if (!skb->len || ((skb->len + BTM_HEADER_LEN) > BTM_UPLD_SIZE)) {
                BT_ERR("Tx Error: Bad skb length %d : %d",
                                                skb->len, BTM_UPLD_SIZE);
-               BT_DBG("Leave");
                return -EINVAL;
        }

@@ -359,7 +330,6 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, s=
truct sk_buff *skb)
                        BT_ERR("Tx Error: realloc_headroom failed %d",
                                BTM_HEADER_LEN);
                        skb =3D tmp;
-                       BT_DBG("Leave");
                        return -EINVAL;
                }

@@ -381,52 +351,35 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv,=
 struct sk_buff *skb)
        if (priv->hw_host_to_card)
                ret =3D priv->hw_host_to_card(priv, skb->data, skb->len);

-       BT_DBG("Leave");
-
        return ret;
 }

 static void btmrvl_init_adapter(struct btmrvl_private *priv)
 {
-       BT_DBG("Enter");
-
        skb_queue_head_init(&priv->adapter->tx_queue);

        priv->adapter->ps_state =3D PS_AWAKE;

        init_waitqueue_head(&priv->adapter->cmd_wait_q);
-
-       BT_DBG("Leave");
 }

 static void btmrvl_free_adapter(struct btmrvl_private *priv)
 {
-       BT_DBG("Enter");
-
        skb_queue_purge(&priv->adapter->tx_queue);

        kfree(priv->adapter);

        priv->adapter =3D NULL;
-
-       BT_DBG("Leave");
 }

 static int btmrvl_ioctl(struct hci_dev *hdev,
                                unsigned int cmd, unsigned long arg)
 {
-       BT_DBG("Enter");
-
-       BT_DBG("Leave");
-
        return -ENOIOCTLCMD;
 }

 static void btmrvl_destruct(struct hci_dev *hdev)
 {
-       BT_DBG("Enter");
-
-       BT_DBG("Leave");
 }

 static int btmrvl_send_frame(struct sk_buff *skb)
@@ -434,11 +387,10 @@ static int btmrvl_send_frame(struct sk_buff *skb)
        struct hci_dev *hdev =3D (struct hci_dev *) skb->dev;
        struct btmrvl_private *priv =3D NULL;

-       BT_DBG("Enter: type=3D%d, len=3D%d", skb->pkt_type, skb->len);
+       BT_DBG("packet type=3D%d, len=3D%d", skb->pkt_type, skb->len);

        if (!hdev || !hdev->driver_data) {
                BT_ERR("Frame for unknown HCI device");
-               BT_DBG("Leave");
                return -ENODEV;
        }

@@ -447,7 +399,6 @@ static int btmrvl_send_frame(struct sk_buff *skb)
                BT_ERR("Failed testing HCI_RUNING, flags=3D%lx", hdev->flag=
s);
                print_hex_dump_bytes("data: ", DUMP_PREFIX_OFFSET,
                                                        skb->data, skb->len=
);
-               BT_DBG("Leave");
                return -EBUSY;
        }

@@ -469,8 +420,6 @@ static int btmrvl_send_frame(struct sk_buff *skb)

        wake_up_interruptible(&priv->main_thread.wait_q);

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -478,12 +427,8 @@ static int btmrvl_flush(struct hci_dev *hdev)
 {
        struct btmrvl_private *priv =3D hdev->driver_data;

-       BT_DBG("Enter");
-
        skb_queue_purge(&priv->adapter->tx_queue);

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -491,28 +436,18 @@ static int btmrvl_close(struct hci_dev *hdev)
 {
        struct btmrvl_private *priv =3D hdev->driver_data;

-       BT_DBG("Enter");
-
-       if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags)) {
-               BT_DBG("Leave");
+       if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags))
                return 0;
-       }

        skb_queue_purge(&priv->adapter->tx_queue);

-       BT_DBG("Leave");
-
        return 0;
 }

 static int btmrvl_open(struct hci_dev *hdev)
 {
-       BT_DBG("Enter");
-
        set_bit(HCI_RUNNING, &hdev->flags);

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -529,8 +464,6 @@ static int btmrvl_service_main_thread(void *data)
        struct sk_buff *skb;
        ulong flags;

-       BT_DBG("Enter");
-
        init_waitqueue_entry(&wait, current);

        current->flags |=3D PF_NOFREEZE;
@@ -588,8 +521,6 @@ static int btmrvl_service_main_thread(void *data)
                }
        }

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -599,8 +530,6 @@ struct btmrvl_private *btmrvl_add_card(void *card)
        struct btmrvl_private *priv;
        int ret;

-       BT_DBG("Enter");
-
        priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
        if (!priv) {
                BT_ERR("Can not allocate priv");
@@ -655,7 +584,6 @@ struct btmrvl_private *btmrvl_add_card(void *card)
        btmrvl_debugfs_init(hdev);
 #endif

-       BT_DBG("Leave");
        return priv;

 err_hci_register_dev:
@@ -671,8 +599,6 @@ err_adapter:
        kfree(priv);

 err_priv:
-       BT_DBG("Leave");
-
        return NULL;
 }
 EXPORT_SYMBOL_GPL(btmrvl_add_card);
@@ -681,8 +607,6 @@ int btmrvl_remove_card(struct btmrvl_private *priv)
 {
        struct hci_dev *hdev;

-       BT_DBG("Enter");
-
        hdev =3D priv->btmrvl_dev.hcidev;

        wake_up_interruptible(&priv->adapter->cmd_wait_q);
@@ -703,8 +627,6 @@ int btmrvl_remove_card(struct btmrvl_private *priv)

        kfree(priv);

-       BT_DBG("Leave");
-
        return 0;
 }
 EXPORT_SYMBOL_GPL(btmrvl_remove_card);
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdi=
o.c
index 0dea23e..9fc973f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -67,14 +67,10 @@ static int btmrvl_sdio_get_rx_unit(struct btmrvl_sdio_c=
ard *card)
        u8 reg;
        int ret;

-       BT_DBG("Enter");
-
        reg =3D sdio_readb(card->func, CARD_RX_UNIT_REG, &ret);
        if (!ret)
                card->rx_unit =3D reg;

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -83,8 +79,6 @@ static int btmrvl_sdio_read_fw_status(struct btmrvl_sdio_=
card *card, u16 *dat)
        int ret;
        u8 fws0, fws1;

-       BT_DBG("Enter");
-
        *dat =3D 0;

        fws0 =3D sdio_readb(card->func, CARD_FW_STATUS0_REG, &ret);
@@ -92,15 +86,11 @@ static int btmrvl_sdio_read_fw_status(struct btmrvl_sdi=
o_card *card, u16 *dat)
        if (!ret)
                fws1 =3D sdio_readb(card->func, CARD_FW_STATUS1_REG, &ret);

-       if (ret) {
-               BT_DBG("Leave");
+       if (ret)
                return -EIO;
-       }

        *dat =3D (((u16) fws1) << 8) | fws0;

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -109,14 +99,10 @@ static int btmrvl_sdio_read_rx_len(struct btmrvl_sdio_=
card *card, u16 *dat)
        int ret;
        u8 reg;

-       BT_DBG("Enter");
-
        reg =3D sdio_readb(card->func, CARD_RX_LEN_REG, &ret);
        if (!ret)
                *dat =3D (u16) reg << card->rx_unit;

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -125,16 +111,12 @@ static int btmrvl_sdio_enable_host_int_mask(struct bt=
mrvl_sdio_card *card,
 {
        int ret;

-       BT_DBG("Enter");
-
        sdio_writeb(card->func, mask, HOST_INT_MASK_REG, &ret);
        if (ret) {
                BT_ERR("Unable to enable the host interrupt!");
                ret =3D -EIO;
        }

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -144,8 +126,6 @@ static int btmrvl_sdio_disable_host_int_mask(struct btm=
rvl_sdio_card *card,
        int ret;
        u8 host_int_mask;

-       BT_DBG("Enter");
-
        host_int_mask =3D sdio_readb(card->func, HOST_INT_MASK_REG, &ret);
        if (ret) {
                ret =3D -EIO;
@@ -164,8 +144,6 @@ static int btmrvl_sdio_disable_host_int_mask(struct btm=
rvl_sdio_card *card,
        ret =3D 0;

 done:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -175,8 +153,6 @@ static int btmrvl_sdio_poll_card_status(struct btmrvl_s=
dio_card *card, u8 bits)
        int ret;
        u8 status;

-       BT_DBG("Enter");
-
        for (tries =3D 0; tries < MAX_POLL_TRIES * 1000; tries++) {
                status =3D sdio_readb(card->func, CARD_STATUS_REG, &ret);
                if (ret)
@@ -193,8 +169,6 @@ failed:
        BT_ERR("FAILED! ret=3D%d", ret);

 done:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -205,8 +179,6 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl=
_sdio_card *card,
        u16 firmwarestat;
        unsigned int tries;

-       BT_DBG("Enter");
-
         /* Wait for firmware to become ready */
        for (tries =3D 0; tries < pollnum; tries++) {
                if (btmrvl_sdio_read_fw_status(card, &firmwarestat) < 0)
@@ -220,8 +192,6 @@ static int btmrvl_sdio_verify_fw_download(struct btmrvl=
_sdio_card *card,
                }
        }

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -235,8 +205,6 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sd=
io_card *card)
        u8 *helperbuf;
        u32 tx_len;

-       BT_DBG("Enter");
-
        ret =3D request_firmware(&fw_helper, card->helper,
                                                &card->func->dev);
        if ((ret < 0) || !fw_helper) {
@@ -326,8 +294,6 @@ done:
        if (fw_helper)
                release_firmware(fw_helper);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -343,8 +309,6 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmr=
vl_sdio_card *card)
        u16 len;
        int txlen =3D 0, tx_blocks =3D 0, count =3D 0;

-       BT_DBG("Enter");
-
        ret =3D request_firmware(&fw_firmware, card->firmware,
                                                        &card->func->dev);
        if ((ret < 0) || !fw_firmware) {
@@ -479,8 +443,6 @@ done:
        if (fw_firmware)
                release_firmware(fw_firmware);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -494,8 +456,6 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_priva=
te *priv)
        struct hci_dev *hdev =3D priv->btmrvl_dev.hcidev;
        struct btmrvl_sdio_card *card =3D priv->btmrvl_dev.card;

-       BT_DBG("Enter");
-
        if (!card || !card->func) {
                BT_ERR("card or function is NULL!");
                ret =3D -EINVAL;
@@ -596,8 +556,6 @@ exit:
                        kfree_skb(skb);
        }

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -607,8 +565,6 @@ static int btmrvl_sdio_get_int_status(struct btmrvl_pri=
vate *priv, u8 * ireg)
        u8 sdio_ireg =3D 0;
        struct btmrvl_sdio_card *card =3D priv->btmrvl_dev.card;

-       BT_DBG("Enter");
-
        *ireg =3D 0;

        sdio_ireg =3D sdio_readb(card->func, HOST_INTSTATUS_REG, &ret);
@@ -653,8 +609,6 @@ static int btmrvl_sdio_get_int_status(struct btmrvl_pri=
vate *priv, u8 * ireg)
        ret =3D 0;

 done:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -665,8 +619,6 @@ static void btmrvl_sdio_interrupt(struct sdio_func *fun=
c)
        struct btmrvl_sdio_card *card;
        u8 ireg =3D 0;

-       BT_DBG("Enter");
-
        card =3D sdio_get_drvdata(func);
        if (card && card->priv) {
                priv =3D card->priv;
@@ -679,8 +631,6 @@ static void btmrvl_sdio_interrupt(struct sdio_func *fun=
c)

                btmrvl_interrupt(priv);
        }
-
-       BT_DBG("Leave");
 }

 static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
@@ -689,8 +639,6 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_=
card *card)
        u8 reg;
        int ret =3D 0;

-       BT_DBG("Enter");
-
        if (!card || !card->func) {
                BT_ERR("Error: card or function is NULL!");
                ret =3D -EINVAL;
@@ -752,7 +700,6 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_=
card *card)

        sdio_release_host(func);

-       BT_DBG("Leave");
        return 0;

 release_irq:
@@ -765,14 +712,11 @@ release_host:
        sdio_release_host(func);

 failed:
-       BT_DBG("Leave");
        return ret;
 }

 static int btmrvl_sdio_unregister_dev(struct btmrvl_sdio_card *card)
 {
-       BT_DBG("Enter");
-
        if (card && card->func) {
                sdio_claim_host(card->func);
                sdio_release_irq(card->func);
@@ -781,8 +725,6 @@ static int btmrvl_sdio_unregister_dev(struct btmrvl_sdi=
o_card *card)
                sdio_set_drvdata(card->func, NULL);
        }

-       BT_DBG("Leave");
-
        return 0;
 }

@@ -790,12 +732,8 @@ static int btmrvl_sdio_enable_host_int(struct btmrvl_s=
dio_card *card)
 {
        int ret;

-       BT_DBG("Enter");
-
-       if (!card || !card->func) {
-               BT_DBG("Leave");
+       if (!card || !card->func)
                return -EINVAL;
-       }

        sdio_claim_host(card->func);

@@ -805,8 +743,6 @@ static int btmrvl_sdio_enable_host_int(struct btmrvl_sd=
io_card *card)

        sdio_release_host(card->func);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -814,12 +750,8 @@ static int btmrvl_sdio_disable_host_int(struct btmrvl_=
sdio_card *card)
 {
        int ret;

-       BT_DBG("Enter");
-
-       if (!card || !card->func) {
-               BT_DBG("Leave");
+       if (!card || !card->func)
                return -EINVAL;
-       }

        sdio_claim_host(card->func);

@@ -827,8 +759,6 @@ static int btmrvl_sdio_disable_host_int(struct btmrvl_s=
dio_card *card)

        sdio_release_host(card->func);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -844,11 +774,8 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_priv=
ate *priv,
        void *tmpbuf =3D NULL;
        int tmpbufsz;

-       BT_DBG("Enter");
-
        if (!card || !card->func) {
                BT_ERR("card or function is NULL!");
-               BT_DBG("Leave");
                return -EINVAL;
        }

@@ -886,8 +813,6 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_priva=
te *priv,
 exit:
        sdio_release_host(card->func);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -895,11 +820,8 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_=
card *card)
 {
        int ret =3D 0;

-       BT_DBG("Enter");
-
        if (!card || !card->func) {
                BT_ERR("card or function is NULL!");
-               BT_DBG("Leave");
                return -EINVAL;
        }
        sdio_claim_host(card->func);
@@ -931,8 +853,6 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_c=
ard *card)
 done:
        sdio_release_host(card->func);

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -941,11 +861,8 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private=
 *priv)
        struct btmrvl_sdio_card *card =3D priv->btmrvl_dev.card;
        int ret =3D 0;

-       BT_DBG("Enter");
-
        if (!card || !card->func) {
                BT_ERR("card or function is NULL!");
-               BT_DBG("Leave");
                return -EINVAL;
        }

@@ -957,8 +874,6 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private =
*priv)

        BT_DBG("wake up firmware");

-       BT_DBG("Leave");
-
        return ret;
 }

@@ -969,8 +884,6 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
        struct btmrvl_private *priv =3D NULL;
        struct btmrvl_sdio_card *card =3D NULL;

-       BT_DBG("Enter");
-
        BT_INFO("vendor=3D0x%x, device=3D0x%x, class=3D%d, fn=3D%d",
                        id->vendor, id->device, id->class, func->num);

@@ -1025,8 +938,6 @@ static int btmrvl_sdio_probe(struct sdio_func *func,

        btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);

-       BT_DBG("Leave");
-
        return 0;

 disable_host_int:
@@ -1036,8 +947,6 @@ unreg_dev:
 free_card:
        kfree(card);
 done:
-       BT_DBG("Leave");
-
        return ret;
 }

@@ -1045,8 +954,6 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 {
        struct btmrvl_sdio_card *card;

-       BT_DBG("Enter");
-
        if (func) {
                card =3D sdio_get_drvdata(func);
                if (card) {
@@ -1064,8 +971,6 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
                        kfree(card);
                }
        }
-
-       BT_DBG("Leave");
 }

 static struct sdio_driver bt_mrvl_sdio =3D {
@@ -1077,32 +982,23 @@ static struct sdio_driver bt_mrvl_sdio =3D {

 static int btmrvl_sdio_init_module(void)
 {
-       BT_DBG("Enter");
-
        if (sdio_register_driver(&bt_mrvl_sdio) !=3D 0) {
                BT_ERR("SDIO Driver Registration Failed");
-               BT_DBG("Leave");
                return -ENODEV;
        }

        /* Clear the flag in case user removes the card. */
        user_rmmod =3D 0;

-       BT_DBG("Leave");
-
        return 0;
 }

 static void btmrvl_sdio_exit_module(void)
 {
-       BT_DBG("Enter");
-
        /* Set the flag as user is removing this module. */
        user_rmmod =3D 1;

        sdio_unregister_driver(&bt_mrvl_sdio);
-
-       BT_DBG("Leave");
 }

 module_init(btmrvl_sdio_init_module);
--
1.5.3.6




Thanks,

Bing
