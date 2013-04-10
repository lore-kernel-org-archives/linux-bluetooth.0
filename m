Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 08:57:56 +0900
From: Johan Hedberg <johan.hedberg@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	don.fry@intel.com
Subject: Re: [RFC] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130410235756.GA20270@x220>
References: <1640417.GJq4DRhhap@tedd-ubuntu>
 <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6C02E13F-AA1A-43B9-891F-8B42F9111DD8@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 10, 2013, Marcel Holtmann wrote:
> > +		/* Send command based on the evt */
> > +		if (evt->evt == HCI_EV_CMD_COMPLETE) {
> > +			/* Command Complete Event */
> > +			skb = __hci_cmd_sync(hdev, cmd->opcode, cmd->plen,
> > +					(void *)param,
> > +					HCI_INIT_TIMEOUT);
> > +			if (IS_ERR(skb)) {
> > +				BT_ERR("__hci_cmd_sync(patch): %ld",
> > +						PTR_ERR(skb));
> > +				m_off_code = m_off_1;
> > +				goto exit_mfg;
> > +			}
> > +
> > +			/* Check the event status */
> > +			if (skb->data[0]) {
> > +				BT_ERR("%s patch failed(%02x)", hdev->name,
> > +						skb->data[0]);
> > +				m_off_code = m_off_1;
> > +				kfree_skb(skb);
> > +				goto exit_mfg;
> > +			}
> > +		} else {
> > +			/* Non Command Complete Event */
> > +			skb = __hci_cmd_sync_ev(hdev, cmd->opcode, cmd->plen,
> > +					(void *)param, evt->evt,
> > +					HCI_INIT_TIMEOUT);
> > +			if (IS_ERR(skb)) {
> > +				BT_ERR("__hci_cmd_sync_ev(patch): %ld",
> > +						PTR_ERR(skb));
> > +				m_off_code = m_off_1;
> > +				goto exit_mfg;
> > +			}
> > +
> > +			/* Checking the returned event */
> > +			if (memcmp(skb->data, evt_param, evt->plen)) {
> > +				BT_ERR("%s patch event doesn't match!!",
> > +						hdev->name);
> > +				m_off_code = m_off_1;
> > +				kfree_skb(skb);
> > +				goto exit_mfg;
> > +			}
> > +		}
> 
> Check if the __hci_cmd_sync_ev can just take HCI_EV_CMD_COMPLETE as
> event and it would work the same.

It should work but it does change the semantics of the function a bit.
When a non-zero "special" event is given __hci_cmd_sync_ev() assumes no
special knowledge of the contents of the event. This means that it
does not strip off the cmd_complete header, where as a value 0 (or using
__hci_cmd_sync) will strip off the cmd_complete header in the returned
skb so that it can be directly cast to the structs we have in hci.h.

Johan
