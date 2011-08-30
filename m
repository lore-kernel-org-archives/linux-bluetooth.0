Return-Path: <cyrus@holtmann.org>
Subject: Re: second scan timing out, bisected to 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <201108301552.19010.oliver@neukum.org>
Date: Tue, 30 Aug 2011 11:53:04 -0300
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <407EE2E8-9841-4A67-B63D-F2084E341C92@openbossa.org>
References: <201108301005.20103.oliver@neukum.org> <20110830084322.GA15992@dell.ger.corp.intel.com> <201108301552.19010.oliver@neukum.org>
To: Oliver Neukum <oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver/Johan

On Aug 30, 2011, at 10:52 AM, Oliver Neukum wrote:

> Am Dienstag, 30. August 2011, 10:45:05 schrieb Johan Hedberg:
>> Hi Oliver,
>> 
>> On Tue, Aug 30, 2011, Oliver Neukum wrote:
> 
>> I think this is a real issue, but it only happens with the HCIINQUIRY
>> ioctl which bluetoothd doesn't use (but hcitool does). I think the
>> problems is with the following type of additions in the patch:
>> 
>> +       if (test_bit(HCI_MGMT, &hdev->flags) &&
>> +                               test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
>> +               mgmt_discovering(hdev->id, 0);
>> 
>> Because of the ordering of the if-statement the HCI_INQUIRY flags
>> doesn't get cleared if HCI_MGMT is not set and so the HCIINQUIRY ioctl
>> doesn't trigger inquiry even though it should (see hci_inq_req in
>> net/bluetooth/hci_core.c). Can you try to flip the ordering of the
>> test_bit and test_and_clear_bit calls in all relevant if-statements in
>> the patch and see if it resolves your issue?
> 
> Hi,
> 
> this patch makes it work again.

I'm working on a new version of discovery procedure support and I have
the fix for this issue in that patch series (see [PATCH v2 01/16]
Bluetooth: Periodic Inquiry and mgmt discovering event).

Soon, I'll send the new version of discovery patches to ML.

Andre