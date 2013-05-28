Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [BUG] Set Powered=true doesn't power up the adapter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130528071306.GA31172@x220>
Date: Tue, 28 May 2013 16:36:51 +0900
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <16EC52EF-CEB3-40B5-BDD3-6D6BE35FF177@holtmann.org>
References: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com> <CAE6HaMnFF7ym+FCWpVHCi=7=OJZeaS+uiF_qQDKHgpbzLUUu_w@mail.gmail.com> <CAE6HaMmUL2Dn6H0iBzh6Wrk+DzOzDUHa8fUNGDt6psAc6=JAUw@mail.gmail.com> <61DC8CEB-C49A-466F-B5E3-F5B60D398157@holtmann.org> <20130522172213.GA12160@samus.indt.org> <1E509939-3804-43E0-A047-09CCD38A4713@holtmann.org> <20130528071306.GA31172@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> If I send any Set Powered command after the controller is unblocked, while
>>> there's still one pending command in the queue, this command will fail, and I
>>> won't be able to bring the controller up, unless I force a HCI_RESET command.
>>> 
>>> So it seems that we need a way to mark an hdev as rfkill blocked.
>>> 
>>> Does anyone else have any other ideas?
>> 
>> my wild guess right now is that this is the problem:
>> 
>> 	static void hci_power_on(struct work_struct *work)
>> 	{
>> 	        struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
>> 
>> 	        BT_DBG("%s", hdev->name);
>> 
>> 	        if (hci_dev_open(hdev->id) < 0)
>> 	                return;
>> 
>> 	        if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
>> 	                queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
>> 	                                   HCI_AUTO_OFF_TIMEOUT);
>> 
>> 	        if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
>> 	                mgmt_index_added(hdev);
>> 	}
>> 
>> In case hci_dev_open() fails and rfkill would be one example for that,
>> we do not return an error back to the mgmt command that originates
>> this power on.
>> 
>> Of course there is the initial adapter power on and there is the mgmt
>> triggered power on. And my guess is that these two are racing against
>> each other.
> 
> It seems you're right about the cause. I just sent a patch to fix it.
> With the patch I get this behavior:
> 
> jh@qemu~/src/bluez{master}$ sudo rfkill list
> 0: hci0: Bluetooth
> 	Soft blocked: no
> 	Hard blocked: no
> jh@qemu~/src/bluez{master}$ sudo rfkill block 0
> jh@qemu~/src/bluez{master}$ sudo tools/btmgmt power on
> Set Powered for hci0 failed with status 0x03 (Failed)

we could be a bit smarter about the error code here. At least when ERFKILL we should return a more descriptive error via mgmt.

Regards

Marcel

