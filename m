Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120217150030.GA9941@x220>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	<1329429041-30715-5-git-send-email-andre.guedes@openbossa.org>
	<20120216221213.GA3889@x220.ger.corp.intel.com>
	<CACJA=fV3-GvzLd3WKGDRwO7q06rQ8j+3ts9Vo8GTiE_0T42XwA@mail.gmail.com>
	<1329468528.28848.139.camel@aeonflux>
	<20120217145249.GA9776@x220>
	<20120217150030.GA9941@x220>
Date: Fri, 17 Feb 2012 13:25:23 -0200
Message-ID: <CAA37ikbYxEbKhHbOmjEjRENoHraFLF7WvFhRBHvRRMw2U+=f_g@mail.gmail.com>
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>, Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 17, 2012 at 1:00 PM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
>
> Hi,
>
> On Fri, Feb 17, 2012, Johan Hedberg wrote:
> > > > > The locking doesn't look right to me above. hci_do_inquiry should=
 be
> > > > > called with the lock held. I think it might be simpler if you mak=
e
> > > > > mgmt_interleaved_discovery() require the caller to hold the lock.
> > > >
> > > > Yes, you're right. I just realized hci_do_inquiry now calls inquiry=
_
> > > > cache_flush which requires hdev->lock held. I'll fix this too. Than=
ks.
> > >
> > > please keep the lock inside mgmt_interleaved_discovery() for now. We
> > > have enough locking crazy. I don't wanna add to it by making the call=
er
> > > deal with it right now.
> >
> > The calling code looks like this:
> >
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hdev->discovery.type =3D=3D DISCOV_TY=
PE_INTERLEAVED) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mgmt_interleaved_discover=
y(hdev);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_lock(hdev);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_discovery_set_state(h=
dev, DISCOVERY_STOPPED);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_unlock(hdev);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > I was thinking that if mgmt_interleaved_discovery required the lock to
> > be held this code would become simpler:
> >
> > =A0 =A0 =A0 hci_dev_lock(hdev);
> >
> > =A0 =A0 =A0 if (hdev->discovery.type =3D=3D DISCOV_TYPE_INTERLEAVED)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 mgmt_interleaved_discovery(hdev);
> > =A0 =A0 =A0 else
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_discovery_set_state(hdev, DISCOVERY_STO=
PPED);
> >
> > =A0 =A0 =A0 hci_dev_unlock(hdev);
>
> Furthermore, almost all calls from hci_core.c or hci_event.c into mgmt.c
> (that pass hdev as a parameter) have hdev locked so this would just be
> maintaining consistency.

Makes sense to me. Any reason not be this way, Marcel?

Regards,

--
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
