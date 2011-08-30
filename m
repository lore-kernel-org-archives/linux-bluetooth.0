Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Aug 2011 11:45:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: second scan timing out, bisected to
 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Message-ID: <20110830084322.GA15992@dell.ger.corp.intel.com>
References: <201108301005.20103.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201108301005.20103.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On Tue, Aug 30, 2011, Oliver Neukum wrote:
> I am seeing with newer kernels a regression in "hcitool scan" failing if it
> is issued a second or further times by timing out. I can bisect this in the
> kernel to
> 
> commit 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Wed Apr 27 10:29:57 2011 -0400
> 
>     Bluetooth: Add discovering event to the Management interface
>     
>     This patch adds a new event to the Management interface to track when
>     local adapters are discovering remote devices. For now this only tracks
>     BR/EDR discovery procedures.
> 
> Is this a known issue. Might this be an issue with too old bluez utils?
> I am using bluez-4.64

I think this is a real issue, but it only happens with the HCIINQUIRY
ioctl which bluetoothd doesn't use (but hcitool does). I think the
problems is with the following type of additions in the patch:

+       if (test_bit(HCI_MGMT, &hdev->flags) &&
+                               test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
+               mgmt_discovering(hdev->id, 0);

Because of the ordering of the if-statement the HCI_INQUIRY flags
doesn't get cleared if HCI_MGMT is not set and so the HCIINQUIRY ioctl
doesn't trigger inquiry even though it should (see hci_inq_req in
net/bluetooth/hci_core.c). Can you try to flip the ordering of the
test_bit and test_and_clear_bit calls in all relevant if-statements in
the patch and see if it resolves your issue?

Johan
