Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/6] Bluetooth: LE scan infra-structure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 19 Nov 2011 07:11:29 +0100
In-Reply-To: <944367C4-28CD-4EF2-8D4C-FF2FA1A734D5@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
	 <1321051824-5216-4-git-send-email-andre.guedes@openbossa.org>
	 <1321053220.15441.411.camel@aeonflux>
	 <944367C4-28CD-4EF2-8D4C-FF2FA1A734D5@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321683091.15441.626.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >> This patch adds to hci_core the infra-structure to carry out the
> >> LE scan. Functions were created to init the LE scan and cancel
> >> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
> >> 
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >> include/net/bluetooth/hci_core.h |    5 +++
> >> net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
> >> 2 files changed, 74 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index f6d5d90..69dda9b 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -232,6 +232,8 @@ struct hci_dev {
> >> 	struct list_head	adv_entries;
> >> 	struct timer_list	adv_timer;
> >> 
> >> +	struct timer_list	le_scan_timer;
> >> +
> >> 	struct hci_dev_stats	stat;
> >> 
> >> 	struct sk_buff_head	driver_init;
> >> @@ -987,5 +989,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
> >> 
> >> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> >> int hci_cancel_inquiry(struct hci_dev *hdev);
> >> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> >> +								int timeout);
> >> +int hci_cancel_le_scan(struct hci_dev *hdev);
> >> 
> >> #endif /* __HCI_CORE_H */
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 64cdafe..c07dc15 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -1423,6 +1423,23 @@ int hci_add_adv_entry(struct hci_dev *hdev,
> >> 	return 0;
> >> }
> >> 
> >> +static int le_scan(struct hci_dev *hdev, u8 enable)
> >> +{
> >> +	struct hci_cp_le_set_scan_enable cp;
> >> +
> >> +	memset(&cp, 0, sizeof(cp));
> >> +	cp.enable = enable;
> >> +
> >> +	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> >> +}
> >> +
> >> +static void le_scan_timeout(unsigned long arg)
> >> +{
> >> +	struct hci_dev *hdev = (void *) arg;
> >> +
> >> +	le_scan(hdev, 0);
> >> +}
> >> +
> >> /* Register HCI device */
> >> int hci_register_dev(struct hci_dev *hdev)
> >> {
> >> @@ -1501,6 +1518,9 @@ int hci_register_dev(struct hci_dev *hdev)
> >> 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
> >> 						(unsigned long) hdev);
> >> 
> >> +	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
> >> +						(unsigned long) hdev);
> >> +
> >> 	INIT_WORK(&hdev->power_on, hci_power_on);
> >> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
> >> 
> >> @@ -1587,6 +1607,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >> 	hci_del_sysfs(hdev);
> >> 
> >> 	del_timer(&hdev->adv_timer);
> >> +	del_timer(&hdev->le_scan_timer);
> >> 
> >> 	destroy_workqueue(hdev->workqueue);
> >> 
> >> @@ -2615,3 +2636,51 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
> >> 
> >> 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> >> }
> >> +
> >> +static int set_le_scan_param(struct hci_dev *hdev, u8 type, u16 interval,
> >> +								u16 window)
> >> +{
> >> +	struct hci_cp_le_set_scan_param cp;
> >> +
> >> +	memset(&cp, 0, sizeof(cp));
> >> +	cp.type = type;
> >> +	cp.interval = cpu_to_le16(interval);
> >> +	cp.window = cpu_to_le16(window);
> >> +
> >> +	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
> >> +}
> >> +
> >> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
> >> +								int timeout)
> >> +{
> >> +	int err;
> >> +
> >> +	if (test_bit(HCI_LE_SCAN, &hdev->hci_flags))
> >> +		return -EINPROGRESS;
> >> +
> >> +	BT_DBG("%s", hdev->name);
> >> +
> >> +	err = set_le_scan_param(hdev, type, interval, window);
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	err = le_scan(hdev, 1);
> >> +	if (err < 0)
> >> +		return err;
> > 
> > since you are using hci_send_cmd, you never check the error from the
> > controller for set_le_scan_param. We should be doing exactly that before
> > just going ahead with a scan.
> 
> Yes, you're right, there is no error checking at this point.
> 
> I took some time thinking about this problem and I concluded we
> should not bother so much about it (at least for now). The reasons
> are:
> 
> 1. The spec says the Set LE Scan Parameters command fails if it
> is issued when LE scan is enabled. We guarantee this doesn't happen
> since we check the HCI_LE_SCAN flag before sending any command to
> the controller.
> 
> 2. Even if the Set LE Scan Parameters command fails for some other
> unknown reason, we would do the LE scanning with the last parameters
> set. This doesn't seem to be a big deal.
> 
> 3. We've done lots of tests (with different dongles), but I've not
> seen this error happening so far. It seems to be difficult to
> reproduce it.
> 
> I also took some time thinking about a fix for that, but I didn't find
> any easy/clean way to do it. 
> 
> So I think we should just log if the Set LE Scan Parameters command
> fails and, if somehow, this becomes often we come up with a fix for it.

so the proposed fix is to ignore the problem?

> > It is also not guaranteed that the controller queues up these commands,
> > it might just return busy from le_scan() if it can have more than one
> > outstanding commands (which many controller can do).
> 
> I didn't follow you here. We have a mechanism to keep track of how
> many commands the host is allowed to send to the controller. The
> tasklet hdev->cmd_task only issue a command if the controller is
> able to handle it.

Yes, we do handle that, but we do not handle the controllers radio
resources. There is no requirement for a controller to queue the command
internally. If it does not have radio resources or is still busy with
the previous command, it can just return busy.

> Besides, other parts of the code send more than one command in sequence
> and it doesn't seem to be a problem (see set_fast_connectable() in
> mgmt.c, hci_init_req() in hci_core.c and hci_setup() in hci_event.c).

The fast connectable thing is a problem then as well. The init code
works different here. That is done via hci_request in a context that can
sleep.

> But anyway, if the controller returns error from le_scan(), we do the
> proper handling in hci_cc_le_set_scan_enable().

That is not the point here. That is obviously required.

Regards

Marcel


