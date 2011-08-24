Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314114448.4095.40.camel@THOR>
References: <1313596884-8733-1-git-send-email-doronkeren@ti.com>
	<1313617329.3373.188.camel@aeonflux>
	<13872098A06B02418CF379A158C0F1460162C51B1A@dnce02.ent.ti.com>
	<CANq1E4TKSJZF+HoV+XuopnupRmSvDiEOu72b+7YX4O2wR6Hd9g@mail.gmail.com>
	<1314114448.4095.40.camel@THOR>
Date: Wed, 24 Aug 2011 21:27:43 +0200
Message-ID: <CANq1E4SnHHRUV6PQpgxyiXvFyebjmfF9UVahG3VUOk2w+m4=FQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth-next: Add incremental indexing in sysfs HCI
 connection name.
From: David Herrmann <dh.herrmann@googlemail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "Keren, Doron" <doronkeren@ti.com>, Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Ilia, Kolominsky" <iliak@ti.com>,
	"Hadar, Amir" <a-hadar@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter

On Tue, Aug 23, 2011 at 5:47 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> David,
> I know you already posted a patch for this (which looks ok for fixing
> the oops specifically), but it'd still be helpful to see a debug kernel
> log that led up to that. There's only a couple of reasons -- all bad --
> why the hci connection could not be found in the connection list while
> the ctrl & intr sockets are connected (which are tested just prior to
> hidp_add_connection).

Sorry for the delay. I currently have no other machine to run a debug
kernel and I really don't like provoking oopses on my working machine.
However, the next days I will setup a machine and try to send a full
trace.
Are there any useful config symbols for bluetooth debug? Despite the
standard kernel-wide debug symbols.

What are possible reasons why an l2cap connection can be available
without an underlying ACL connection? My fix eliminates the oops but I
still think that it is not fixing the real problem (anyway, I'd really
like to see it upstream).

I will try to send a debug log if I can reproduce it.

> Regards,
> Peter Hurley

Cheers
David
