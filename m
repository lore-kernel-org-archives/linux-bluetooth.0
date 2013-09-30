Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC] Bluetooth: Add command for setting static address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130929191102.GA32665@x220.p-661hnu-f1>
Date: Mon, 30 Sep 2013 05:42:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <83DE7E8F-F647-4349-85AB-5EDB14F292B9@holtmann.org>
References: <1380441937-55298-1-git-send-email-marcel@holtmann.org> <20130929191102.GA32665@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Add command for setting static address for use as LE random address.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/hci.h      |  2 ++
>> include/net/bluetooth/hci_core.h |  1 +
>> include/net/bluetooth/mgmt.h     |  6 ++++++
>> net/bluetooth/hci_core.c         |  5 +++++
>> net/bluetooth/mgmt.c             | 43 +++++++++++++++++++++++++++++++++++++++-
>> 5 files changed, 56 insertions(+), 1 deletion(-)
> 
> This looks all pretty good to me. Did you have any particular thoughts
> on resolvable private address generation (which we have to support as
> soon as we support the privacy feature as a central) or is that
> completely orthogonal to this feature? I suppose we'll be implementing
> that through a "privacy" mgmt settings bit and leave the rest up to the
> kernel?

originally I called this random address and had the idea to let userspace program the addresses all by itself. Then I got into reading on how they are defined and realized that it might be better to separate static addresses from private addresses.

The kernel can easily generate a static address by itself during the initial setup of the controller and that would satisfy the requirement from the specification to only ever change and power cycle. Which would be essentially when you remove the controller or reboot the kernel.

However as we discussed in New Orleans, we might want to provide a way for userspace to generate a static address and keep it. So that this becomes more deterministic. It would also make it a bit simpler for testing since you can have a "fixed" address.

I limited this command to by only available when the controller is powered off so that we do not have to deal with changing the address at runtime. Since that is clearly against the specification that it should only change at power cycle.

For private addresses, the resolvable ones involve our own IRK and that is something that we should provide to the kernel somehow. And then the kernel should create the key for us. Providing the IRK one way and then having userspace to generate the random address for it seemed like a bad idea.

The non-resolvable private addresses are kinda funky on how they work. And I am not even sure they will be useful at all. They really only make sense for LE only controllers that do not have a public address. I am not sure anybody actually uses them at all. So we have to think about on how we use these addresses. If we want to use them at all.

One thing that still bugs me is the case that when we encounter an LE only controller with no public address, then we return 00:00:00:00:00:00 to the management interface and also the legacy ioctl. The management interface can happily handle it, the ioctl and its command line tools break badly. bluetoothd also has some issues on how to actually use such a controller and store persistent data with it. That is where a "fixed" static address might be useful. We can just generate one, keep it and program it in the next LE only controller with no public address. At that point it does not really matter which hardware it is since they are all the same. But we need an address for it and here the static addresses come in handy.

The current command already has the magic 00:00:00:00:00:00 that will disable static address again. By itself BDADDR_ANY is not a valid random address. I am thinking of adding 11:11:11:11:11:11 as another special case (since that is not valid either) and let the kernel generate a static random address for us. It can easily generate one that is not conflicting with any other controller in the system. Not sure if this is really worth it. This can be as easily achieved in userspace.

Regards

Marcel

