Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <14D61081-B665-4A03-840C-52CB64ECB1C4@holtmann.org>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com>
	<14D61081-B665-4A03-840C-52CB64ECB1C4@holtmann.org>
Date: Tue, 2 Apr 2013 18:48:53 +0200
Message-ID: <CANq1E4QJ3F_tseko9+4tRLFaF7MiMZVPgjQQ7eiWQn_Y3vYTQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Rework HIDP Module
From: David Herrmann <dh.herrmann@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Gustavo Padovan <gustavo@padovan.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On Tue, Apr 2, 2013 at 6:38 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
>
>> This is my second attempt to get these patches merged. I added 4 more fixes at
>> the end and removed the patches that were already merged by Gustavo.
>>
>> This fixes a lot of issues with the HIDP layer. It is currently nearly
>> impossible to use HIDP devices. Every attempt (except the first) to connect a
>> device results in an oops or panic for me.
>>
>> I haven't found a way to fix this easily, so I decided to rewrite the session
>> handling of HIDP.
>
> I am generally fine with these patches after a quick read-through. However I am not 100% sure that hci_conn_user is the right approach.
>
> So my question is if we really want to base this of the ACL link itself and not base this around L2CAP directly. Every L2CAP connection implies a hci_conn in the end. Would it be hard to have something like l2cap_user instead of hci_conn_user?

The thing is that HID uses two L2CAP channels. We would probably use
the CTRL channel as parent device, but this makes the synchronization
with the INTR channel quite hard to implement.
Also note that l2cap channels do not have "struct device" embedded,
which would disallow showing the HID device in the right location in
sysfs.
If you have some other idea, I can try to implement this. But I
couldn't come up with anything better than hid_conn_user.

All in all I think using the HCI-conn object is the best approach as
it is the "logical" parent device of an HIDP device. Also note that
this is only used as sysfs connection. We still detect L2CAP channel
events in the HIDP core.

Thanks for the review! I have a ton more HID fixes which generalize
HID-boot devices and output reports across HID ll-drivers. But I
really want this to get in first. Everything else can be taken through
Jiri's HID tree.

Regards
David
