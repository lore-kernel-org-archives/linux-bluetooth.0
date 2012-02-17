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
Date: Fri, 17 Feb 2012 13:23:42 -0200
Message-ID: <CAA37ikaxOQENTgatraOBWyorSyBUhOtvDoxauerYyC_42tTDEg@mail.gmail.com>
Subject: Re: [RFC 4/4] Bluetooth: Interleaved discovery support
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>, Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d044280b6a5c02a04b92a8753
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d044280b6a5c02a04b92a8753
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Fri, Feb 17, 2012 at 1:00 PM, Johan Hedberg <johan.hedberg@gmail.com>wrote:

> Hi,
>
> On Fri, Feb 17, 2012, Johan Hedberg wrote:
> > > > > The locking doesn't look right to me above. hci_do_inquiry should
> be
> > > > > called with the lock held. I think it might be simpler if you make
> > > > > mgmt_interleaved_discovery() require the caller to hold the lock.
> > > >
> > > > Yes, you're right. I just realized hci_do_inquiry now calls inquiry_
> > > > cache_flush which requires hdev->lock held. I'll fix this too.
> Thanks.
> > >
> > > please keep the lock inside mgmt_interleaved_discovery() for now. We
> > > have enough locking crazy. I don't wanna add to it by making the caller
> > > deal with it right now.
> >
> > The calling code looks like this:
> >
> > +
> > +               if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
> > +                       mgmt_interleaved_discovery(hdev);
> > +               } else {
> > +                       hci_dev_lock(hdev);
> > +                       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +                       hci_dev_unlock(hdev);
> > +               }
> >
> > I was thinking that if mgmt_interleaved_discovery required the lock to
> > be held this code would become simpler:
> >
> >       hci_dev_lock(hdev);
> >
> >       if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED)
> >               mgmt_interleaved_discovery(hdev);
> >       else
> >               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >
> >       hci_dev_unlock(hdev);
>
> Furthermore, almost all calls from hci_core.c or hci_event.c into mgmt.c
> (that pass hdev as a parameter) have hdev locked so this would just be
> maintaining consistency.


Makes sense to me. Marcel, any reason not to be this way?

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

--f46d044280b6a5c02a04b92a8753
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br><div class=3D"gmail_quote">On Fri, Feb 17, 2012 at 1:00 PM, Joha=
n Hedberg <span dir=3D"ltr">&lt;<a href=3D"mailto:johan.hedberg@gmail.com">=
johan.hedberg@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
Hi,<br>
<div><div class=3D"h5"><br>
On Fri, Feb 17, 2012, Johan Hedberg wrote:<br>
&gt; &gt; &gt; &gt; The locking doesn&#39;t look right to me above. hci_do_=
inquiry should be<br>
&gt; &gt; &gt; &gt; called with the lock held. I think it might be simpler =
if you make<br>
&gt; &gt; &gt; &gt; mgmt_interleaved_discovery() require the caller to hold=
 the lock.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Yes, you&#39;re right. I just realized hci_do_inquiry now ca=
lls inquiry_<br>
&gt; &gt; &gt; cache_flush which requires hdev-&gt;lock held. I&#39;ll fix =
this too. Thanks.<br>
&gt; &gt;<br>
&gt; &gt; please keep the lock inside mgmt_interleaved_discovery() for now.=
 We<br>
&gt; &gt; have enough locking crazy. I don&#39;t wanna add to it by making =
the caller<br>
&gt; &gt; deal with it right now.<br>
&gt;<br>
&gt; The calling code looks like this:<br>
&gt;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hdev-&gt;discovery.type =3D=3D DISCO=
V_TYPE_INTERLEAVED) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mgmt_interleaved_discove=
ry(hdev);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_lock(hdev);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_discovery_set_state(=
hdev, DISCOVERY_STOPPED);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_unlock(hdev);<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; I was thinking that if mgmt_interleaved_discovery required the lock to=
<br>
&gt; be held this code would become simpler:<br>
&gt;<br>
&gt; =A0 =A0 =A0 hci_dev_lock(hdev);<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (hdev-&gt;discovery.type =3D=3D DISCOV_TYPE_INTERLEAVED=
)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 mgmt_interleaved_discovery(hdev);<br>
&gt; =A0 =A0 =A0 else<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_discovery_set_state(hdev, DISCOVERY_ST=
OPPED);<br>
&gt;<br>
&gt; =A0 =A0 =A0 hci_dev_unlock(hdev);<br>
<br>
</div></div>Furthermore, almost all calls from hci_core.c or hci_event.c in=
to mgmt.c<br>
(that pass hdev as a parameter) have hdev locked so this would just be<br>
maintaining consistency.</blockquote><div><br></div><div>Makes sense to me.=
 Marcel, any reason not to be this way?</div></div><div><br></div><div>Rega=
rds,</div><div><br></div>-- <br>Ulisses Furquim<br>ProFUSION embedded syste=
ms<br>
<a href=3D"http://profusion.mobi">http://profusion.mobi</a><br>Mobile: +55 =
19 9250 0942<br>Skype: ulissesffs<br>
<div><br></div>

--f46d044280b6a5c02a04b92a8753--
