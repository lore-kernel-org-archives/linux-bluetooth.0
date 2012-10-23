Return-Path: <cyrus@holtmann.org>
Message-ID: <1351028968.1785.60.camel@aeonflux>
Subject: Re: [PATCH 1/7] Bluetooth: mgmt: Add support for switching to LE
 peripheral mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 14:49:28 -0700
In-Reply-To: <20121023202626.GA12042@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-2-git-send-email-johan.hedberg@gmail.com>
	 <1351018879.1785.44.camel@aeonflux>
	 <20121023202626.GA12042@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -786,6 +786,9 @@ static void hci_set_le_support(struct hci_dev *hdev)
> > >  	if (cp.le != !!(hdev->host_features[0] & LMP_HOST_LE))
> > >  		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
> > >  			     &cp);
> > > +	else if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
> > > +		hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(cp.le),
> > > +			     &cp.le);
> > 
> > What is this doing and why it is correct? I am failing to see this. We
> > need to enable LE host supported first anyway.
> 
> The first if-statement checks if the host feature bits are what we want
> them to be, and if not send the WRITE_LE_HOST_SUPPORTED command. The
> else if part (if the host features are already correct and don't need
> updating) enables advertising if necessary. There's a similar check for
> HCI_LE_PERIPHERAL in the command complete handler for
> HCI_OP_WRITE_LE_HOST_SUPPORTED in case the first if statement was
> triggered. FWIW, I have actually tested this both with hciconfig and
> btmgmt and it works fine.
> 
> > > +static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
> > > +{
> > > +	__u8 *sent, status = *((__u8 *) skb->data);
> > > +
> > > +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > > +
> > > +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADV_ENABLE);
> > > +	if (!sent)
> > > +		return;
> > > +
> > > +	hci_dev_lock(hdev);
> > > +
> > > +	if (!status) {
> > > +		if (*sent)
> > > +			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
> > > +		else
> > > +			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
> > > +	} else {
> > > +		if (*sent)
> > > +			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
> > > +		else
> > > +			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
> > > +	}
> > 
> > Are you sure we want to based LE peripheral enabling based on if we
> > advertise or not. I can see cases where we are a peripheral, but might
> > want to not always advertise.
> 
> These set_bit/clear_bit calls are actually all no-op in the case that
> the mgmt interface is used (since the LE_PERIPHERAL flag is already
> modified when receiving the mgmt command). The only reason I put them
> here is so that the reported mgmt settings remain correct and we reject
> connection initiation and scanning if "hciconfig hci0 leadv" or similar
> is used.
> 
> The simplistic way I thought we'd initially keep peripheral mode is
> that it always implies advertising (unless a connection exists).
> Otherwise the user would need to switch to LE-off or Central mode.

I am fine with this. However we can not merge this upstream until we
have this figured out and have a good grasp on this. So it would be nice
to have this patch last. Since some of the other patches could be
actually merged right now. They are useful fixes no matter what.

We might want to introduce a enable_peripheral module parameter as safe
guard for the time being. So that the features bit PERIPHERAL is not set
if this is disabled. Just an idea.

> 
> > > @@ -1213,48 +1242,71 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> > >  		goto unlock;
> > >  	}
> > >  
> > > -	val = !!cp->val;
> > > -	enabled = !!(hdev->host_features[0] & LMP_HOST_LE);
> > > +	if (!valid_le_mode(cp->val)) {
> > > +		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
> > > +				 MGMT_STATUS_INVALID_PARAMS);
> > > +		goto unlock;
> > > +	}
> > >  
> > > -	if (!hdev_is_powered(hdev) || val == enabled) {
> > > -		bool changed = false;
> > > +	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
> > > +		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
> > > +				 MGMT_STATUS_BUSY);
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	new_mode = cp->val;
> > > +	old_mode = get_le_mode(hdev);
> > > +
> > > +	BT_DBG("%s old_mode %u new_mode %u", hdev->name, old_mode, new_mode);
> > > +
> > > +	if (new_mode == old_mode) {
> > > +		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	if (old_mode == MGMT_LE_PERIPHERAL || new_mode == MGMT_LE_PERIPHERAL)
> > > +		change_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
> > >  
> > > -		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
> > > +	if (!hdev_is_powered(hdev)) {
> > > +		if (old_mode == MGMT_LE_OFF || new_mode == MGMT_LE_OFF)
> > >  			change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
> > > -			changed = true;
> > > -		}
> > >  
> > >  		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
> > >  		if (err < 0)
> > >  			goto unlock;
> > >  
> > > -		if (changed)
> > > -			err = new_settings(hdev, sk);
> > > +		err = new_settings(hdev, sk);
> > >  
> > >  		goto unlock;
> > >  	}
> > >  
> > > -	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
> > > -		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
> > > -				 MGMT_STATUS_BUSY);
> > > -		goto unlock;
> > > -	}
> > > -
> > >  	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE, hdev, data, len);
> > >  	if (!cmd) {
> > >  		err = -ENOMEM;
> > >  		goto unlock;
> > >  	}
> > >  
> > > +	if ((old_mode != MGMT_LE_OFF && new_mode == MGMT_LE_PERIPHERAL) ||
> > > +	    old_mode == MGMT_LE_PERIPHERAL) {
> > > +		u8 adv_enable = (new_mode == MGMT_LE_PERIPHERAL);
> > > +
> > > +		err = hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> > > +				   sizeof(adv_enable), &adv_enable);
> > > +		if (err < 0)
> > > +			mgmt_pending_remove(cmd);
> > > +
> > > +		goto unlock;
> > > +	}
> > > +
> > 
> > this gets a bit complicated. We either need more comments or split this
> > out in separate helper functions.
> 
> I actually spent over a half a day trying to figure out an easy way to
> simplify this, but the best I got was those two simple helper functions.
> So I think I'll opt for just adding good code comments.

Sounds good to me.

Regards

Marcel


