Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Feb 2012 15:32:56 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RESEND 1/3] Bluetooth: Use cancel_work instead of
 cancel_work_sync
Message-ID: <20120201133254.GA3388@aemeltch-MOBL1>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
 <20120131130242.GB7660@aemeltch-MOBL1>
 <1328022697.1955.217.camel@aeonflux>
 <CAA37ikaOnZEZNFatN4ncHkVB=H7y3DZy1E_7LWBtcmJdJTF6Zg@mail.gmail.com>
 <1328025524.1955.219.camel@aeonflux>
 <CAA37ikbbTy95vY7otkYKHNcMcUboYj4XQc5+MjiwSZLedtE33Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikbbTy95vY7otkYKHNcMcUboYj4XQc5+MjiwSZLedtE33Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Jan 31, 2012 at 03:49:19PM -0200, Ulisses Furquim wrote:
> Hi Marcel,
> 
> On Tue, Jan 31, 2012 at 1:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Ulisses,
> >
> >> >> > > -       cancel_delayed_work_sync(&conn->disc_work);
> >> >> > > +       cancel_delayed_work(&conn->disc_work);
> >> >> >
> >> >> > I'm afraid we must use _sync variant here. disc_work is not supposed to
> >> >> > be running after hci_conn is deleted.
> >> >> >
> >> >> > BTW, I believe we already addressed this issue in patches [PATCH 1/2]
> >> >> > Bluetooth: Fix potential deadlock and [PATCH 2/2] Bluetooth: Remove
> >> >> > unneeded locking. These patches are now pushed upstream. Could you
> >> >>
> >> >> I will check those patches from upstream and let you know.
> >> >
> >> > crap, I just acked these.
> >> >
> >> > Johan, forget about my acks and just ignore them. Lets wait until we get
> >> > a clean new series.
> >> >
> >> This change is really wrong because we're on the delete path and Andre
> >> sent other patches which I'm almost sure will address this problem.
> >
> > lets do it this way, I only look at final patches that you and Andrei
> > signed off / acked.
> 
> Sure, we can do that this way.

I've checked recent upstream code and it works fine so far, please forget
about this particular patch.

The other 2 patches are still valid.

Best regards 
Andrei Emeltchenko 
