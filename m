Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 00/18] Rework HIDP Module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANq1E4QJ3F_tseko9+4tRLFaF7MiMZVPgjQQ7eiWQn_Y3vYTQg@mail.gmail.com>
Date: Tue, 2 Apr 2013 11:05:24 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>
Message-Id: <64D25323-864F-4477-87A7-9EF453322E75@holtmann.org>
References: <1364918918-2336-1-git-send-email-dh.herrmann@gmail.com> <14D61081-B665-4A03-840C-52CB64ECB1C4@holtmann.org> <CANq1E4QJ3F_tseko9+4tRLFaF7MiMZVPgjQQ7eiWQn_Y3vYTQg@mail.gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>>> This is my second attempt to get these patches merged. I added 4 more fixes at
>>> the end and removed the patches that were already merged by Gustavo.
>>> 
>>> This fixes a lot of issues with the HIDP layer. It is currently nearly
>>> impossible to use HIDP devices. Every attempt (except the first) to connect a
>>> device results in an oops or panic for me.
>>> 
>>> I haven't found a way to fix this easily, so I decided to rewrite the session
>>> handling of HIDP.
>> 
>> I am generally fine with these patches after a quick read-through. However I am not 100% sure that hci_conn_user is the right approach.
>> 
>> So my question is if we really want to base this of the ACL link itself and not base this around L2CAP directly. Every L2CAP connection implies a hci_conn in the end. Would it be hard to have something like l2cap_user instead of hci_conn_user?
> 
> The thing is that HID uses two L2CAP channels. We would probably use
> the CTRL channel as parent device, but this makes the synchronization
> with the INTR channel quite hard to implement.
> Also note that l2cap channels do not have "struct device" embedded,
> which would disallow showing the HID device in the right location in
> sysfs.
> If you have some other idea, I can try to implement this. But I
> couldn't come up with anything better than hid_conn_user.

there is a difference between l2cap_conn and l2cap_chan. The L2CAP layer has a generic representation of underlying ACL link. I was talking about that one. From that we can get to the hci_conn device object.

Maybe this is more cosmetic, but only going through l2cap_conn and have that bridge into hci_conn seems a bit cleaner to me. Especially since you need a bunch of exports from L2CAP layer anyway.

Regards

Marcel

