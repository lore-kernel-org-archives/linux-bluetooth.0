Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307122514.2622.75.camel@THOR>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<1307122514.2622.75.camel@THOR>
Date: Wed, 29 Jun 2011 11:22:04 +0100
Message-ID: <BANLkTi=aFRa7wm5EUyq9kLur1Cp0sxchhA@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for your reply Peter.

Sorry if I came across a bit rude there, it is just very frustrating
sometimes :)

Ok, I managed to get l2test working from the 4.91 source using BlueZ 4.94:

./l2test -s -i 00:02:5B:00:31:27 -b 10 00:02:5B:00:31:25
l2test[30513]: Connected [imtu 672, omtu 672, flush_to 65535, mode 0,
handle 44, class 0x000000]
l2test[30513]: Sending ...

./l2test -r -i 00:02:5B:00:31:25
l2test[30498]: Waiting for connection on psm 4113 ...
l2test[30590]: Connect from 00:02:5B:00:31:27 [imtu 672, omtu 672,
flush_to 65535, mode 0, handle 44, class 0x480100]
l2test[30590]: Receiving ...
l2test[30590]: 680 bytes in 0.09 sec, 7.36 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: 680 bytes in 0.10 sec, 6.92 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: 680 bytes in 0.08 sec, 7.82 kB/s
l2test[30590]: Disconnect: Success

Does this help us?

You mentioned enabling debug messages for btusb and bluetooth. Do you
by any chance know how to do this?

Thanks.


On Fri, Jun 3, 2011 at 6:35 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Wed, 2011-05-11 at 04:52 -0400, Eponymous - wrote:
>> Hi,
>>
>> I've ran into an issue where data doesn't seem to be received by a slave device.
>>
>> I do the following:
>>
>> Using Gentoo Linux (2.6.34-gentoo-r1)
>> Using BlueZ 4.81
>>
>> 1. Use BlueZ to connect to two Bluetooth devices using HCI only. This
>> is over USB.
>>
>> 2. I set one device as a slave and then create a connection between
>> the two. This completes sucessfully and can be seen on both sides.
>>
>> 3. I then try to send an acl packet with the word "hi" in it and it is
>> not received on the other side.
>>
>> --------
>>
>> Doing the same thing above but:
>>
>> Using Fedora Core 5 (2.6.20-1.2320.fc5)
>> And:
>> bluez-libs-2.25-1
>> bluez-pin-0.30-2
>> bluez-utils-2.25-4
>> bluez-libs-devel-2.25-1
>> bluez-hcidump-1.30-1
>>
>> and using the same hardware - the problem doesn't happen.
>>
>> I have attached two HCI dumps, one of the Master device and one of the Slave.
>>
>> Thanks for any help you can give.
>
> Although it's not at all clear from your posts, I'm assuming that you're
> using a raw HCI socket in a user-space utility.
>
> My guess is that the btusb kernel driver is dropping your ACL packet
> without transmitting it. If you look at drivers/bluetooth/btusb.c. in
> the btusb_send_frame() function, you'll see:
>
>        switch (bt_cb(skb)->pkt_type) {
>                ....
>        case HCI_ACLDATA_PKT:
>                if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
>                        return -ENODEV;
>
> The only way that hdev->conn_hash.acl_num will be 1+ is if the
> establishment of an ACL connection went through hci_connect() with a
> connection type of ACL_LINK. This code was added when SCO support was
> added back in Aug 2008.
>
> The acl_num test (and the sco_test below it) probably should be skipped
> if the HCI device is in raw mode (assuming you sent the HCISETRAW ioctl
> to both devices).
>
> You can confirm this is happening by enabling debug messages for btusb
> and bluetooth. You shouldn't need bluez, as this is the user-space
> daemon responsible for the protocols built on L2CAP and SCO (SDP,
> RFCOMM, A2DP, etc.)
>
> On Mon, 2011-05-30 at 09:57 -0400, Eponymous - wrote:
>> Ok well this has been a complete waste of time. I guess we should just
>> ignore a potential bug then,...
>>
>> Is this project dead or something? I can't believe an entire mailing
>> list can't be bothered to even e-mail back or try and help with this.
>
> This isn't appropriate.
>
> I can understand your frustration that what you want to work doesn't,
> but since you're using a kernel interface directly, you should be
> prepared to debug that yourself.
>
> On Fri, 2011-05-13 at 08:42 -0400, Eponymous - wrote:
>> The following were executed in a root shell.
>>
>> Receive Side (Device B):
>>
>> $ ./l2test -r 00:02:5B:00:31:21
>> l2test[29219]: Waiting for connection on psm 4113 ...
>>
>> Transmit Side (Device A):
>>
>> $ ./l2test -s -b 10 00:02:5B:01:FE:DF
> ...
>>
>> Doesn't appear to work...
>
> BTW, you're using l2test wrong. With the each CSR dongle on *different
> machines*, this is supposed to look like:
>
> Receive side (device 00:02:5B:00:31:21)
> $ ./l2test -r
>
> Transmit side (device 00:02:5B:01:FE:DF)
> $ ./l2test -s -b 10 00:02:5B:00:31:21
>
> NB: the bdaddr parameter is used to indicate *to where*, not *from
> where*.
>
> Since you have both devices on the same machine, do this (in root
> shells):
>
> Receive side (device 00:02:5B:00:31:21)
> $ ./l2test -r -i 00:02:5B:00:31:21
>
> Transmit side (device 00:02:5B:01:FE:DF)
> $ ./l2test -s -i 00:02:5B:01:FE:DF -b 10 00:02:5B:00:31:21
>
> Lastly, you may want to reconsider the way you're using Bluetooth.  If
> you can get L2CAP working on your setup (ie, if l2test works), then
> consider using RFCOMM instead. Most BT stacks are not going to let you
> program the host controller directly.
>
> Good luck,
> Peter Hurley
>
>
