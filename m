Return-Path: <cyrus@holtmann.org>
Subject: Re: HCI_MAX_DEV is a bit too small.
From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Reply-To: donpedro@tdcadsl.dk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1268619078.6278.10.camel@donpedro>
References: <1268608837.6400.26.camel@donpedro>
	 <1268609659.3897.56.camel@localhost.localdomain>
	 <1268619078.6278.10.camel@donpedro>
Content-Type: text/plain
Date: Sun, 21 Mar 2010 23:26:25 +0100
Message-Id: <1269210385.19939.15.camel@donpedro>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hello again,

> > So I could be convinced to add new functions to read/write the limit
> > from within an application itself. So that it can be changed without
> > re-compiling the library. Feel free to propose a patch.
> I will see what i can do. What is needed is probably a
> hci_set_max_devices() call. Then hcitool could call that with the number
> of devices needed.

After some time looking at it more closely, i can see that the real
problem is not in hcilib, but in the stack itself. The real problem is
that there is no way of getting the actual number of devices with
reading out all of them... and thereby allocating space for MAX devices
(which could be endless). Chicken and Egg situation. What is really
needed is an ioctl to get the current count. This could be done by:

a) A new IOCTL called HCIGETDEVCOUNT that returns the device count.

or

b) Modifying HCIGETDEVLIST to return the device count (dev_num) if the
input count (dev_num) is zero (without actually returning the devices).
This would be backward compatible, as zero is not a valid input today.

Is any of this acceptable? Please advise what solutions could be
acceptable.

This would allow for hci_for_each_dev (and in turn the stack via IOCTL)
to use less resources, and to support more devices. This could deprecate
the need for MAX_HCI_DEV altogether, as it is not used anywhere else in
the lib. There is of-course allot of other software using that constant,
but maybe removing it over time would be good. It gives the user of the
lib a false idea of a non-existing limitation.

Thanks,

/Pedro
