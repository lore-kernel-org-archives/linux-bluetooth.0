Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1287441278-11284-1-git-send-email-pavan_savoy@ti.com>
References: <1287441278-11284-1-git-send-email-pavan_savoy@ti.com>
Date: Tue, 19 Oct 2010 10:56:00 -0400
Message-ID: <AANLkTi=BYbrVh=oCxZ0xektSxFkg58WJmADS=Ld5f53c@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btwilink driver
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: pavan_savoy@ti.com
Cc: padovan@profusion.mobi, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 18, 2010 at 6:34 PM,  <pavan_savoy@ti.com> wrote:
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 02deef4..e0d67dd 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -219,4 +219,14 @@ config BT_ATH3K
> =A0 =A0 =A0 =A0 =A0Say Y here to compile support for "Atheros firmware do=
wnload driver"
> =A0 =A0 =A0 =A0 =A0into the kernel or say M to compile it as module (ath3=
k).
>
> +config BT_WILINK
> + =A0 =A0 =A0 tristate "BlueZ bluetooth driver for TI ST"

I think this has been mentioned before: "BlueZ" is not used in this
context on the kernel. It is also not consistent with the config name
"BT_WILINK". You can follow the pattern from the other entries and
use:

tristate "Texas Instruments WinLink7 driver"

> + =A0 =A0 =A0 depends on TI_ST
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This enables the Bluetooth driver for Texas Instrument'=
s BT/FM/GPS
> + =A0 =A0 =A0 =A0 combo devices. This makes use of shared transport line =
discipline
> + =A0 =A0 =A0 =A0 core driver to communicate with the BT core of the comb=
o chip.
> +
> + =A0 =A0 =A0 =A0 Say Y here to compile support for Texas Instrument's Wi=
Link7 driver
> + =A0 =A0 =A0 =A0 into the kernel or say M to compile it as module.
> =A0endmenu
> [...]
> diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
> new file mode 100644
> index 0000000..e6e2e64
> --- /dev/null
> +++ b/drivers/bluetooth/btwilink.c
> [...]
> +/* Defines number of seconds to wait for reg completion
> + * callback getting called from ST (in case,registration
> + * with ST returns PENDING status)
> + */

I suggest rewriting this comment into:

"Number of seconds to wait for registration completion when ST returns
PENDING status"

> +#define BT_REGISTER_TIMEOUT =A0 6000 =A0 =A0 /* 6 sec */
> +
> +/**
> + * struct ti_st - BT driver operation structure
> + * @hdev: hci device pointer which binds to bt driver

Just drop "BT" and "bt" here. I think it is clear you are referring to
the Bluetooth driver.

> + * @flags: used locally,to maintain various BT driver status

Suggestion: @flags: driver status flags

(if you can be more specific to which kind of status, it would be even bett=
er)

> + * @streg_cbdata: to hold ST registration callback status

You can drop "to hold" here.

> + * @st_write: write function pointer of ST driver

IMHO this description does not add anything to what st_write is for.

> + * @wait_reg_completion - completion sync between ti_st_open
> + * =A0 =A0 and ti_st_registration_completion_cb.
> + */
> +struct ti_st {
> + =A0 =A0 =A0 struct hci_dev *hdev;
> + =A0 =A0 =A0 char streg_cbdata;
> + =A0 =A0 =A0 long (*st_write) (struct sk_buff *);
> + =A0 =A0 =A0 struct completion wait_reg_completion;
> +};
> +
> +static int reset;
> +
> +/* Increments HCI counters based on pocket ID (cmd,acl,sco) */
> +static inline void ti_st_tx_complete(struct ti_st *hst, int pkt_type)
> +{
> + =A0 =A0 =A0 struct hci_dev *hdev;
> + =A0 =A0 =A0 hdev =3D hst->hdev;
> +
> + =A0 =A0 =A0 /* Update HCI stat counters */
> + =A0 =A0 =A0 switch (pkt_type) {
> + =A0 =A0 =A0 case HCI_COMMAND_PKT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->stat.cmd_tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case HCI_ACLDATA_PKT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->stat.acl_tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case HCI_SCODATA_PKT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->stat.sco_tx++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
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
> + =A0 =A0 =A0 struct ti_st *lhst =3D (struct ti_st *)priv_data;

Is this explicit cast necessary?

> +
> + =A0 =A0 =A0 /* ti_st_open() function needs value of 'data' to know
> + =A0 =A0 =A0 =A0* the registration status(success/fail),So have a back
> + =A0 =A0 =A0 =A0* up of it.
> + =A0 =A0 =A0 =A0*/

Suggestion:  /* Save registration status for use in ti_st_open() */

> + =A0 =A0 =A0 lhst->streg_cbdata =3D data;
> +
> + =A0 =A0 =A0 /* Got a feedback from ST for BT driver registration
> + =A0 =A0 =A0 =A0* request.Wackup ti_st_open() function to continue
> + =A0 =A0 =A0 =A0* it's open operation.
> + =A0 =A0 =A0 =A0*/

Too much BT here. If it means "Bluetooth", you don't need to use it
every time. Additionally, I don't get what the above comment means.

> + =A0 =A0 =A0 complete(&lhst->wait_reg_completion);
> +}
> +
> +/* Called by Shared Transport layer when receive data is
> + * available */
> +static long st_receive(void *priv_data, struct sk_buff *skb)

Can this function return "int" instead? It is more common for
functions which return just a error value.

> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 struct ti_st *lhst =3D (struct ti_st *)priv_data;

Again, is this cast necessary?

> +
> + =A0 =A0 =A0 if (!skb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 if (!lhst) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 skb->dev =3D (struct net_device *)lhst->hdev;
> +
> + =A0 =A0 =A0 /* Forward skb to HCI core layer */
> + =A0 =A0 =A0 err =3D hci_recv_frame(skb);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Unable to push skb to HCI core(%d)"=
, err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 lhst->hdev->stat.byte_rx +=3D skb->len;

Add a blank like here.

> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* ------- Interfaces to HCI layer ------ */
> +/* protocol structure registered with shared transport */
> +static struct st_proto_s ti_st_proto =3D {
> + =A0 =A0 =A0 .type =3D ST_BT,
> + =A0 =A0 =A0 .recv =3D st_receive,
> + =A0 =A0 =A0 .reg_complete_cb =3D st_registration_completion_cb,
> + =A0 =A0 =A0 .priv_data =3D NULL,
> +};
> +
> +/* Called from HCI core to initialize the device */
> +static int ti_st_open(struct hci_dev *hdev)
> +{
> + =A0 =A0 =A0 unsigned long timeleft;
> + =A0 =A0 =A0 struct ti_st *hst;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 BT_DBG("%s %p", hdev->name, hdev);
> +
> + =A0 =A0 =A0 /* provide contexts for callbacks from ST */
> + =A0 =A0 =A0 hst =3D hdev->driver_data;
> + =A0 =A0 =A0 ti_st_proto.priv_data =3D hst;
> +
> + =A0 =A0 =A0 err =3D st_register(&ti_st_proto);
> + =A0 =A0 =A0 if (err =3D=3D -EINPROGRESS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Prepare wait-for-completion handler data=
 structures.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Needed to syncronize this and st_regis=
tration_completion_cb()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* functions.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/

syncronize -> synchronize

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_completion(&hst->wait_reg_completion);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset ST registration callback status fl=
ag , this value
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will be updated in ti_st_registration_=
completion_cb()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* function whenever it called from ST dr=
iver.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hst->streg_cbdata =3D -EINPROGRESS;

If this field is used solely for holding status values, why not call
it "reg_status" or something like that? "cbdata" is more for opaque
parameters IMHO.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ST is busy with other protocol registrat=
ion(may be busy with
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* firmware download).So,Wait till the re=
gistration callback
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (passed as a argument to st_register()=
 function) getting
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* called from ST.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/

"ST is busy with either protocol registration or firmware download.
Wait until the registration callback is called."

Is it clearer?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG(" waiting for reg completion signal =
from ST");

BT_DBG("Waiting for registration completion signal from ST");

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeleft =3D wait_for_completion_timeout
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (&hst->wait_reg_completion,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msecs_to_jiffies(BT_REGI=
STER_TIMEOUT));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!timeleft) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Timeout(%d sec),did=
n't get reg "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "completion signal from ST",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 BT_REGISTER_TIMEOUT / 1000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Is ST registration callback called with =
ERROR value? */

ERROR value -> "error status"

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hst->streg_cbdata !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("ST reg completion C=
B called with invalid"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "status %d", hst->streg_cbdata);

Too much abbreviations here:

reg -> registration
CB -> callback

Also you are truncating the C string wrong here (and maybe in other
places). It will be print as "invalidstatus". Use either
"...invalid<space>" (1st line) or "<space>status..." (2nd line).

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 } else if (err =3D=3D -EPERM) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("st_register failed %d", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +

You could assign hst->st_write right here:

hst->st_write =3D ti_st_proto.write;

And simplify the if/else below to:

if (!hst->st_write) {
    BT_ERR(....);
...
}

(i.e. invert the check logic and drop the "!=3D NULL" case)

> + =A0 =A0 =A0 /* Do we have proper ST write function? */
> + =A0 =A0 =A0 if (ti_st_proto.write !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We need this pointer for sending any Blu=
etooth pkts */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hst->st_write =3D ti_st_proto.write;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("failed to get ST write func pointer=
");

This error message could be:

BT_ERR("undefined ST write function");

*Although* I think the whole check is in the wrong place. I think this
check should be inside the function which sets ti_st_proto.write.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Undo registration with ST */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D st_unregister(ST_BT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("st_unregister faile=
d %d", err);

Suggestion:

BT_ERR("st_unregister() failed with error %d", err);

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hst->st_write =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Registration with ST layer is completed successfully,
> + =A0 =A0 =A0 =A0* now chip is ready to accept commands from HCI core.
> + =A0 =A0 =A0 =A0* Mark HCI Device flag as RUNNING
> + =A0 =A0 =A0 =A0*/

The comment above could be summed as:

/* Registration with ST layer was successful and hardware is ready to
accept commands from HCI core. */

> + =A0 =A0 =A0 set_bit(HCI_RUNNING, &hdev->flags);

Add a blank line here.

> + =A0 =A0 =A0 return err;
> +}
> +
> +/* Close device */
> +static int ti_st_close(struct hci_dev *hdev)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 struct ti_st *hst =3D hdev->driver_data;
> +
> + =A0 =A0 =A0 /* continue to unregister from transport */
> + =A0 =A0 =A0 err =3D st_unregister(ST_BT);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("st_unregister failed %d", err);

BT_ERR("st_unregister() failed with error %d", err);

> +
> + =A0 =A0 =A0 hst->st_write =3D NULL;

Add a blank line here.

> + =A0 =A0 =A0 return err;
> +}
> +
> +/* Called from HCI core, Sends frames to Shared Transport */

IMHO the comment above can be dropped (it is too obvious).

> +static int ti_st_send_frame(struct sk_buff *skb)
> +{
> + =A0 =A0 =A0 struct hci_dev *hdev;
> + =A0 =A0 =A0 struct ti_st *hst;
> + =A0 =A0 =A0 long len;
> +
> + =A0 =A0 =A0 if (!skb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 hdev =3D (struct hci_dev *)skb->dev;
> + =A0 =A0 =A0 if (!hdev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 if (!test_bit(HCI_RUNNING, &hdev->flags))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 hst =3D (struct ti_st *)hdev->driver_data;
> +
> + =A0 =A0 =A0 /* Prepend skb with frame type */
> + =A0 =A0 =A0 memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
> +
> + =A0 =A0 =A0 BT_DBG(" %s: type %d len %d", hdev->name, bt_cb(skb)->pkt_t=
ype,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb->len);
> +
> + =A0 =A0 =A0 /* Insert skb to shared transport layer's transmit queue.
> + =A0 =A0 =A0 =A0* Freeing skb memory is taken care in shared transport l=
ayer,
> + =A0 =A0 =A0 =A0* so don't free skb memory here.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!hst->st_write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR(" Can't write to ST, st_write null?"=
);

Suggestion: BT_ERR("Could not write to ST (st_write is NULL)");

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 len =3D hst->st_write(skb);
> + =A0 =A0 =A0 if (len < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR(" ST write failed (%ld)", len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EAGAIN;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* ST accepted our skb. So, Go ahead and do rest */
> + =A0 =A0 =A0 hdev->stat.byte_tx +=3D len;
> + =A0 =A0 =A0 ti_st_tx_complete(hst, bt_cb(skb)->pkt_type);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void ti_st_destruct(struct hci_dev *hdev)
> +{
> + =A0 =A0 =A0 if (!hdev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Destruct called with invalid HCI De=
vice"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(hdev=3DNU=
LL)");

There is a "return" missing here. Also I don't think this error
message is necessary at all. You could have just:

if (!hdev)
    return;

> +
> + =A0 =A0 =A0 BT_DBG("%s", hdev->name);
> +
> + =A0 =A0 =A0 /* free ti_st memory */
> + =A0 =A0 =A0 kfree(hdev->driver_data);

add a blank line here.

> + =A0 =A0 =A0 return;
> +}
> +
> +/* Creates new HCI device */
> +static int ti_st_register_dev(struct ti_st *hst)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 struct hci_dev *hdev;
> +
> + =A0 =A0 =A0 /* Initialize and register HCI device */
> + =A0 =A0 =A0 hdev =3D hci_alloc_dev();
> + =A0 =A0 =A0 if (!hdev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 BT_DBG("hdev=3D %p", hdev);

BT_DBG("hdev %p", hdev);

> +
> + =A0 =A0 =A0 hst->hdev =3D hdev;
> + =A0 =A0 =A0 hdev->bus =3D HCI_UART;
> + =A0 =A0 =A0 hdev->driver_data =3D hst;
> + =A0 =A0 =A0 hdev->open =3D ti_st_open;
> + =A0 =A0 =A0 hdev->close =3D ti_st_close;
> + =A0 =A0 =A0 hdev->flush =3D NULL;
> + =A0 =A0 =A0 hdev->send =3D ti_st_send_frame;
> + =A0 =A0 =A0 hdev->destruct =3D ti_st_destruct;
> + =A0 =A0 =A0 hdev->owner =3D THIS_MODULE;
> +
> + =A0 =A0 =A0 if (reset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
> +
> + =A0 =A0 =A0 err =3D hci_register_dev(hdev);
> + =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Can't register HCI device");

Print the err value on the message above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_free_dev(hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 BT_DBG(" HCI device registered. hdev=3D %p", hdev);

Suggestion:  BT_DBG("HCI device registered (hdev %p)", hdev);

> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +static int bt_ti_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 static struct ti_st *hst;
> +
> + =A0 =A0 =A0 BT_DBG(" Bluetooth Driver Version %s", VERSION);
> +
> + =A0 =A0 =A0 hst =3D kzalloc(sizeof(struct ti_st), GFP_KERNEL);
> + =A0 =A0 =A0 if (!hst)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 /* Expose "hciX" device to user space */
> + =A0 =A0 =A0 err =3D ti_st_register_dev(hst);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hst);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, hst);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int bt_ti_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct ti_st *hst;
> +
> + =A0 =A0 =A0 hst =3D dev_get_drvdata(&pdev->dev);
> + =A0 =A0 =A0 /* Deallocate local resource's memory =A0*/

You can invert the hst check:

if (!hst)
    return <some_error_code>;

And reduce put the code below outside the if(). Also note that the
current code always returns 0. It should return error for hst =3D=3D NULL
and hdev =3D=3D NULL.

> + =A0 =A0 =A0 if (hst) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hci_dev *hdev =3D hst->hdev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("Invalid hdev memory=
");

The error message above is not informative.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hst);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ti_st_close(hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_unregister_dev(hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free HCI device memory *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_free_dev(hdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver btwilink_driver =3D {
> + =A0 =A0 =A0 .probe =3D bt_ti_probe,
> + =A0 =A0 =A0 .remove =3D bt_ti_remove,
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "btwilink",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +/* ------- Module Init/Exit interfaces ------ */
> +static int __init bt_drv_init(void)
> +{
> + =A0 =A0 =A0 long ret;
> +
> + =A0 =A0 =A0 ret =3D platform_driver_register(&btwilink_driver);
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("btwilink platform driver registrati=
on failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EPERM;

-EPERM for a registration failure? Looks strange to me.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void __exit bt_drv_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&btwilink_driver);
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


Regards,
--=20
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
