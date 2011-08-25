Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314222672.2219.66.camel@THOR>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
	<1313617329.3373.188.camel@aeonflux>
	<13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
	<CANq1E4TKSJZF+HoV+XuopnupRmSvDiEOu72b+7YX4O2wR6Hd9g@mail.gmail.com>
	<1314114448.4095.40.camel@THOR>
	<CANq1E4SnHHRUV6PQpgxyiXvFyebjmfF9UVahG3VUOk2w+m4=FQ@mail.gmail.com>
	<1314222672.2219.66.camel@THOR>
Date: Thu, 25 Aug 2011 19:11:33 +0200
Message-ID: <CANq1E4RuGAyjegMpfeCKNEQ-UP9xRyuCP7qMurbsMEEEfVRvKw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
From: David Herrmann <dh.herrmann@googlemail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 24, 2011 at 11:51 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Hi David,
>
>> What are possible reasons why an l2cap connection can be available
>> without an underlying ACL connection?
>
> Well, if the ACL connection is gone, the l2cap channels should be gone
> as well, but the matching l2cap sockets stay around because of the
> references on them. But the sockets should be in state BT_CLOSED, which
> is tested just prior to calling hidp_add_connection.

If I disconnect my HID device, the l2cap sockets stay alive for 20
seconds! Even though the baseband connection is closed. I think this
bug is not related to the hid/sysfs bug here, but may be also
interesting.

> Possible reasons why the apparent contradiction:
> 1. Neither socket is locked by the hidp driver AFAICT. If true, then the
> sock state (and by extension, the l2cap channels and hci connection list
> could change at any time). l2cap_conn_del acquires the socket lock prior
> to l2cap_chan_del.

I guess the problem is that the l2cap channels are BT_CONNECTED when
HIDP checks them but while hidp_add_conenction is called the l2cap
channels close and the ACL connection is removed. hidp_add_connection
then fails because it can't find the ACL connection. This is fixed by
my patch but there is still a race condition. The ACL lookup does not
increase reference count of the connection and hence it may disappear
while we hold a pointer to it.

> 2. HCI connection list (conn_hash) is corrupted. hidp_get_device looks
> smp-unsafe to me. I think it needs to be acquiring device lock via
> hci_dev_lock_bh.
> 3. Some other unknown race.
>
> That's why a debug log would help. It would help establish when
> l2cap_conn_del and hci_conn_del are called relative to
> hidp_add_connection, and what the other pre-conditions are.

It is quite hard to reproduce this bug, but I tried again a couple of
times and got a full debug log now. However, after looking at it I
noticed that I did not apply the patch from Doron Keren so this log is
triggered by the sysfs-duplicate bug and not by the one I discovered.

Last few lines with OOPS message from the kernel log:
https://gist.github.com/1171138
Full kernel.log for the session (including the log above):
http://dl.dropbox.com/u/1475019/kernel.txt

>
> Regards,
> Peter Hurley
>

I will try again with this patch applied, but I think both bugs are
related to each other.

Regards
David
