Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309448838.2276.137.camel@THOR>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<1307122514.2622.75.camel@THOR>
	<BANLkTi=aFRa7wm5EUyq9kLur1Cp0sxchhA@mail.gmail.com>
	<1309448838.2276.137.camel@THOR>
Date: Fri, 1 Jul 2011 07:46:02 +0100
Message-ID: <BANLkTin45Kchz-=1+W=XUWYSXt1o48kerg@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the information.

Hmm, I'm not sure what you mean about a "raw hci" socket. Could you
tell me how I can check this?

I'm using a custom program that can communicate directly to the chip
over hci using bluez as a go-between. Does this help?

Cheers.

On Thu, Jun 30, 2011 at 4:47 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On Wed, 2011-06-29 at 06:22 -0400, Eponymous - wrote:
>> Thanks for your reply Peter.
>>
>> Sorry if I came across a bit rude there, it is just very frustrating
>> sometimes :)
>
> I get it. BT can be <arggghhh>...
>
>> You mentioned enabling debug messages for btusb and bluetooth. Do you
>> by any chance know how to do this?
>
> I always run a debug kernel. My relevant build settings in the "Kernel
> hacking" submenu are:
>  Kernel Debugging => DEBUG_KERNEL=y
>  Debug Filesystem => DEBUG_FS=y
>  Compile the kernel with debug info => DEBUG_INFO=y
> and most importantly,
>  Enable dynamic printk() support DYNAMIC_DEBUG=y
>
> Then read the short dynamic debug howto in the kernel documentation:
> Documentation/dynamic-debug-howto.txt (there are some copies online as
> well if that's easier).
>
> Then when I want to see debug messages, I just enable those source
> files. Eg.,
> # echo -n 'file hci_core.c +p' > /sys/kernel/debug/dynamic_debug/control
> # echo -n 'file hci_conn.c +p' ...
> # echo -n 'file hci_event.c +p' ...
>
> Plus, it's easy to add your own if you suspect a particular code path.
>
> If you have more questions about this, come ask on IRC #bluez.
>
>> On Fri, Jun 3, 2011 at 6:35 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> > Although it's not at all clear from your posts, I'm assuming that you're
>> > using a raw HCI socket in a user-space utility.
>
> Are you using a raw HCI socket?
>
>> > My guess is that the btusb kernel driver is dropping your ACL packet
>> > without transmitting it. If you look at drivers/bluetooth/btusb.c. in
>> > the btusb_send_frame() function, you'll see:
>> >
>> >        switch (bt_cb(skb)->pkt_type) {
>> >                ....
>> >        case HCI_ACLDATA_PKT:
>> >                if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
>> >                        return -ENODEV;
>> >
>> > The only way that hdev->conn_hash.acl_num will be 1+ is if the
>> > establishment of an ACL connection went through hci_connect() with a
>> > connection type of ACL_LINK. This code was added when SCO support was
>> > added back in Aug 2008.
>
> My point here is this is probably a bug in btusb - raw HCI sockets
> should be able to send *any* packet.
>
> If you can confirm you're on a raw HCI socket, I can explore a fix but
> you'll be the test subject <grin>.
>
> Let me know,
> Peter Hurley
>
>
>
