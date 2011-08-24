Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: David Herrmann <dh.herrmann@googlemail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 17:51:12 -0400
Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
Message-ID: <1314222672.2219.66.camel@THOR>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
	 <1313617329.3373.188.camel@aeonflux>
	 <13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
	 <CANq1E4TKSJZF+HoV+XuopnupRmSvDiEOu72b+7YX4O2wR6Hd9g@mail.gmail.com>
	 <1314114448.4095.40.camel@THOR>
	 <CANq1E4SnHHRUV6PQpgxyiXvFyebjmfF9UVahG3VUOk2w+m4=FQ@mail.gmail.com>
In-Reply-To: <CANq1E4SnHHRUV6PQpgxyiXvFyebjmfF9UVahG3VUOk2w+m4=FQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, 2011-08-24 at 15:27 -0400, David Herrmann wrote:
> Hi Peter
>=20
> On Tue, Aug 23, 2011 at 5:47 PM, Peter Hurley <peter@hurleysoftware.com> =
wrote:
> > David,
> > I know you already posted a patch for this (which looks ok for fixing
> > the oops specifically), but it'd still be helpful to see a debug kernel
> > log that led up to that. There's only a couple of reasons -- all bad --
> > why the hci connection could not be found in the connection list while
> > the ctrl & intr sockets are connected (which are tested just prior to
> > hidp_add_connection).
>=20
> Sorry for the delay. I currently have no other machine to run a debug
> kernel and I really don't like provoking oopses on my working machine.
> However, the next days I will setup a machine and try to send a full
> trace.
> Are there any useful config symbols for bluetooth debug? Despite the
> standard kernel-wide debug symbols.

I understand about trying to invoke oops. A one-line
	BT_DBG("");
in the NULL parent error pathway of hidp_setup_hid with your patch would
be just as good (because it's the condition I'm trying to catch).

Don't need (or want) kernel-wide output. If your kernel is configured
for dynamic debug output, this is as easy as:
	$ sudo su
	$ echo -n 'module bluetooth +p'
			> /sys/kernel/debug/dynamic_debug/control
	$ echo -n 'module hidp +p'
			> /sys/kernel/debug/dynamic_debug/control

Run test, then:
	$ echo -n 'module bluetooth -p'
			> /sys/kernel/debug/dynamic_debug/control
	$ echo -n 'module hidp -p'
			> /sys/kernel/debug/dynamic_debug/control
	$ exit

Dynamic debug output is enabled in the Kconfig here:
	Kernel hacking / Enable dynamic printk() support =3D> Y

> What are possible reasons why an l2cap connection can be available
> without an underlying ACL connection?

Well, if the ACL connection is gone, the l2cap channels should be gone
as well, but the matching l2cap sockets stay around because of the
references on them. But the sockets should be in state BT_CLOSED, which
is tested just prior to calling hidp_add_connection.

Possible reasons why the apparent contradiction:
1. Neither socket is locked by the hidp driver AFAICT. If true, then the
sock state (and by extension, the l2cap channels and hci connection list
could change at any time). l2cap_conn_del acquires the socket lock prior
to l2cap_chan_del.
2. HCI connection list (conn_hash) is corrupted. hidp_get_device looks
smp-unsafe to me. I think it needs to be acquiring device lock via
hci_dev_lock_bh.
3. Some other unknown race.

That's why a debug log would help. It would help establish when
l2cap_conn_del and hci_conn_del are called relative to
hidp_add_connection, and what the other pre-conditions are.

>                                       My fix eliminates the oops but I
> still think that it is not fixing the real problem (anyway, I'd really
> like to see it upstream).

Not my place to say re: the patch. Gustavo Padovan and Marcel Holtmann
are the gatekeepers here. (Looks ok to me though, at least as far as
preventing NULL dereferences and handling the error exit properly).

Regards,
Peter Hurley
