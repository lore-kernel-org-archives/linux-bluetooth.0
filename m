Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327164406.1955.54.camel@aeonflux>
References: <1326975033-2668-1-git-send-email-ulisses@profusion.mobi>
	<1327164406.1955.54.camel@aeonflux>
Date: Sat, 21 Jan 2012 17:42:08 -0200
Message-ID: <CAA37ikab_chkT2vmcEH1pm9WoLAt5RSkcOYSqEfNF-HNV+u69g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Remove usage of __cancel_delayed_work()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 21, 2012 at 2:46 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Ulisses,
>
> > __cancel_delayed_work() is being used in some paths where we cannot
> > sleep waiting for the delayed work to finish. However, that function
> > might return while the timer is running and the work will be queued
> > again. Replace the calls with safer cancel_delayed_work() version
> > which spins until the timer handler finishes in other CPUs and
> > cancels the delayed work.
> >
> > Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> > ---
> >
> > v2 - rebased against newer bluetooth-next
> >
> > =A0include/net/bluetooth/l2cap.h | =A0 =A04 ++--
> > =A0net/bluetooth/l2cap_core.c =A0 =A0| =A0 10 +++++-----
> > =A02 files changed, 7 insertions(+), 7 deletions(-)
>
> looks fine to me.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Great. However, Johan please wait to apply. I'll send another version
with 2 patches including a fix for a possible crash.

Regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
