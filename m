Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Cancel the hci_request timeout if it received expected event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D0BEFBBC.573B%tedd.an@intel.com>
Date: Tue, 23 Dec 2014 12:37:33 -0800
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5116F06D-DD91-46A3-A64E-7E42A97EADF5@holtmann.org>
References: <20141222190142.59176a26@tedd-test> <20141223185511.GA5686@t440s.P-661HNU-F1> <D0BEFBBC.573B%tedd.an@intel.com>
To: "An, Tedd" <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

>>> This patch cancels the hci_request timeout work if the expected event
>>> is recevied.
>> 
>> The timer you're canceling isn't hci_request specific, so I'm not sure
>> why you're making that reference here? You might want to provide some
>> more detailed explanation in the commit message.
> 
> When the command is sent with __hci_cmd_sync_ev() and expected event is
> other than Command_Complete or
> Command_Status, especially, vendor specific event (0xFF), the function
> returns the skb filled with
> event parameters properly, but there is tx timeout error because the
> cmd_timer is not canceled.

the cmd_timer is protecting the cmd_q and with that is doing exactly the right thing here. It is here for handling cmd_status and cmd_complete events and with that updating ncmd and HCI command flow control. So we can not just cancel the timer here.

It seems that __hci_cmd_sync_ev is actually not used at all at the moment. However it works just fine when you get the interim cmd_status as done by all HCI commands. The problem is that you are not seeing the cmd_status and thus you have problems here. But we can not just ignore the missing cmd_status. If we do, then ncmd is out of date and HCI flow control is broken at that point.

With that said, we can neither use __hci_cmd_sync nor __hci_cmd_sync_ev for Bluetooth controllers that do not obey the HCI command flow control. So sending commands via cmd_q is not an option here.

The only way I am thinking of being able to work around such behavior is by introducing separate functionality to handle it. So we might need __hci_cmd_raw_sync and __hci_cmd_raw_sync_ev that allows scheduling on raw_q and skipping cmd_complete and cmd_status processing. This however would mean that __hci_cmd_raw_sync can never return data from cmd_complete events (meaning it is actually not _sync in the sense of returning data, even while the name would suggest it).

Regards

Marcel

