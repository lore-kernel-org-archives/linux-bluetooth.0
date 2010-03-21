Return-Path: <cyrus@holtmann.org>
Subject: RE: [bluetooth-next V3] Bluetooth: handle device reset event
From: Marcel Holtmann <marcel@holtmann.org>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Cohen, Guy" <guy.cohen@intel.com>,
	"Rindjunsky, Ron" <ron.rindjunsky@intel.com>,
	"Paskar, Gregory" <gregory.paskar@intel.com>
In-Reply-To: <6F5C1D715B2DA5498A628E6B9C124F04016C304710@hasmsx504.ger.corp.intel.com>
References: <1268898246-22693-1-git-send-email-tomas.winkler@intel.com>
	 <1268976778.3003.14.camel@violet>
	 <6F5C1D715B2DA5498A628E6B9C124F04016C304710@hasmsx504.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 21 Mar 2010 06:48:41 +0100
Message-ID: <1269150521.4851.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> > > A Bluetooth device experiencing hardware failure may issue
> > > a HARDWARE_ERROR hci event. The reaction to this event is device
> > > reset flow implemented in following sequence.
> > >
> > > 1. Notify: HCI_DEV_DOWN
> > > 2. Reinitialize internal structures.
> > > 3. Call driver flush function
> > > 4. Send HCI reset request to the device.
> > > 5. Send HCI init sequence reset to the device.
> > > 6. Notify HCI_DEV_UP.
> > >
> > > Signed-off-by: Gregory Paskar <gregory.paskar@intel.com>
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Reviewed-by: Ron Rindjunsky <ron.rindjunsky@intel.com>
> > > ---
> > > V2:
> > > 1. Fix email typo
> > > 2. Fix style issues
> > > V3:
> > > 1. align with naming convention hw_err_work -> work_hw_err
> > > 2. use per controller workqueue
> > >
> > >  include/net/bluetooth/hci.h      |    5 ++++
> > >  include/net/bluetooth/hci_core.h |    2 +
> > >  net/bluetooth/hci_core.c         |   47
> > +++++++++++++++++++++++++++++++++++++-
> > >  net/bluetooth/hci_event.c        |    3 ++
> > >  4 files changed, 56 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > index fc0c502..3f986e7 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -695,6 +695,11 @@ struct hci_ev_cmd_status {
> > >  	__le16   opcode;
> > >  } __attribute__ ((packed));
> > >
> > > +#define HCI_EV_HARDWARE_ERROR 0x10
> > > +struct hci_ev_hw_error {
> > > +	__u8     hw_code;
> > > +} __attribute__ ((packed));
> > > +
> > 
> > So the rule is that the HCI_EV and hci_ev struct names are matching up.
> > It should be matching what we have in the library (not a hard
> > requirement though):
> > 
> > #define EVT_HARDWARE_ERROR              0x10
> > typedef struct {
> >         uint8_t         code;
> > } __attribute__ ((packed)) evt_hardware_error;
> > 
> > So just spell it out hardware_error. This means it is also code and not
> > hw_code inside the struct.
> > 
> > >  #define HCI_EV_ROLE_CHANGE		0x12
> > >  struct hci_ev_role_change {
> > >  	__u8     status;
> > > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > > index e17849e..1c9601d 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -113,6 +113,8 @@ struct hci_dev {
> > >  	struct tasklet_struct	rx_task;
> > >  	struct tasklet_struct	tx_task;
> > >
> > > +	struct work_struct	work_hw_err;
> > > +
> > 
> > I would prefer if you just call it reset_work actually. I know that we
> > are acting on a hardware error, but the action that we are performing is
> > actually a full reset. It might be useful for other parts of the stack
> > as well.
> > 
> > >  	struct sk_buff_head	rx_q;
> > >  	struct sk_buff_head	raw_q;
> > >  	struct sk_buff_head	cmd_q;
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 8b4baac..c5a43e3 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -839,6 +839,51 @@ static int hci_rfkill_set_block(void *data, bool
> > blocked)
> > >  	return 0;
> > >  }
> > >
> > > +static void hci_device_hw_error(struct hci_dev *hdev)
> > > +{
> > > +	hci_req_lock(hdev);
> > > +
> > > +	/* notify: going down */
> > > +	clear_bit(HCI_UP, &hdev->flags);
> > > +	hci_notify(hdev, HCI_DEV_DOWN);
> > > +
> > > +	tasklet_disable(&hdev->tx_task);
> > > +	skb_queue_purge(&hdev->rx_q);
> > > +	skb_queue_purge(&hdev->cmd_q);
> > > +
> > > +	hci_dev_lock_bh(hdev);
> > > +	inquiry_cache_flush(hdev);
> > > +	hci_conn_hash_flush(hdev);
> > > +	hci_dev_unlock_bh(hdev);
> > > +
> > > +	if (hdev->flush)
> > > +		hdev->flush(hdev);
> > > +
> > > +	/* reset device */
> > > +	atomic_set(&hdev->cmd_cnt, 1);
> > > +	hdev->acl_cnt = 0;
> > > +	hdev->sco_cnt = 0;
> > > +	hci_reset_req(hdev, 0);
> > > +
> > > +	/* init device */
> > > +	atomic_set(&hdev->cmd_cnt, 1);
> > > +	hci_init_req(hdev, 0);
> > > +
> > > +	tasklet_enable(&hdev->tx_task);
> > > +
> > > +	/* notify: going back up */
> > > +	set_bit(HCI_UP, &hdev->flags);
> > > +	hci_notify(hdev, HCI_DEV_UP);
> > > +
> > > +	hci_req_unlock(hdev);
> > > +}
> > > +
> > > +static void hci_work_hw_err(struct work_struct *ws)
> > > +{
> > > +	struct hci_dev *hdev = container_of(ws, struct hci_dev, work_hw_err);
> > > +	hci_device_hw_error(hdev);
> > > +}
> > > +
> > 
> > Please name it hci_reset_work to match it properly. And then put
> > everything in the same function. No need to really split it here.
> > 
> > What I would prefer if we can split out the open/close code and re-use
> > it it here.
> > 
> > >  static const struct rfkill_ops hci_rfkill_ops = {
> > >  	.set_block = hci_rfkill_set_block,
> > >  };
> > > @@ -908,7 +953,7 @@ int hci_register_dev(struct hci_dev *hdev)
> > >  	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
> > >  	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
> > >  	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
> > > -
> > > +	INIT_WORK(&hdev->work_hw_err, hci_work_hw_err);
> > >  	skb_queue_head_init(&hdev->rx_q);
> > >  	skb_queue_head_init(&hdev->cmd_q);
> > >  	skb_queue_head_init(&hdev->raw_q);
> > 
> > I am missing the cancel_work_sync() call in hci_unregister_dev().
> > 
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 6c57fc7..6bcf3e9 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -1955,6 +1955,9 @@ void hci_event_packet(struct hci_dev *hdev, struct
> > sk_buff *skb)
> > >  	case HCI_EV_REMOTE_HOST_FEATURES:
> > >  		hci_remote_host_features_evt(hdev, skb);
> > >  		break;
> > > +	case HCI_EV_HARDWARE_ERROR:
> > > +		queue_work(hdev->workqueue, &hdev->work_hw_err);
> > > +		break;
> > >
> > >  	default:
> > >  		BT_DBG("%s event 0x%x", hdev->name, event);
> > 
> > Since it seems you have the only hardware where this can be re-produced,
> > it would be great if you include some hcidump -X -V extracts inside the
> > commit message.
> > 
> 
> What exactly are you looking for? I'm testing it by artificially triggering the error. Does hci dump has any value in that case?

you mentioned that you see hardware error events on real hardware. I
like to see the hcidump from that actually.

And btw. the bluetooth-testing tree now contains the patches to push
event processing into a workqueue. They have limit testing so far, but
seems to work fine. Someone still needs to do some performance testing
before we can clear that patch for upstream. However it should make your
reset logic patch a lot simpler.

Regards

Marcel


