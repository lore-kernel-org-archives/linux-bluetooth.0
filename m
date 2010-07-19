Return-Path: <cyrus@holtmann.org>
Message-ID: <828454.70868.qm@web56507.mail.re3.yahoo.com>
Date: Mon, 19 Jul 2010 11:30:41 -0700 (PDT)
From: Shreesh Holla <hshreesh@yahoo.com>
Subject: Re: [HCI Events] Connection Event  Processing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1279563007.4572.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,=0A=0AFirstly, my intention has not been to be rude etc - I really d=
ont know what top posting is. But, if I have posted something that has offe=
nded anyone - please excuse that and as it was not intentional - only tryin=
g to figure out the best approach to our issue.=0A=0ABut, from your comment=
s below I do see that this connection hookup needs to happen in the kernel.=
 And I shall explore the RAW mode - if it can work for us.=0A=0ABut thanks,=
=0AShreesh=0A=0A--- On Mon, 7/19/10, Marcel Holtmann <marcel@holtmann.org> =
wrote:=0A=0A> From: Marcel Holtmann <marcel@holtmann.org>=0A> Subject: Re: =
[HCI Events] Connection Event  Processing=0A> To: "Shreesh Holla" <hshreesh=
@yahoo.com>=0A> Cc: "Johan Hedberg" <johan.hedberg@gmail.com>, linux-blueto=
oth@vger.kernel.org=0A> Date: Monday, July 19, 2010, 11:10 AM=0A> Hi Shress=
h,=0A> =0A> first of all, stop top posting. This is rude and we will=0A> ig=
nore further=0A> emails from you if you keep doing this.=0A> =0A> > ugh! I =
see the issues now. As you said - neither of=0A> those approaches would wor=
k for me since we need to=0A> conditionally handle the incoming connection =
really.=0A> > =0A> > Wonder if there is some design reason this was done=0A=
> i.e. hardcoding it in hci_event.c? Or is it for performance=0A> reasons?=
=A0=A0=A0Any plans on supporting this in=0A> the future? =0A> > =0A> > What=
 I'm considering is plugging in our own handler=0A> inside hci_event.c.=0A>=
 > =0A> > We can do this inside some custom hardware - but we=0A> are tryin=
g to avoid this since we already have other custom=0A> hardware we need to =
do in our device which is a wireless=0A> access control system.=0A> =0A> I =
really don't know what you are trying to achieve here,=0A> but you might=0A=
> better not use BlueZ if you wanna do something like this.=0A> The connect=
ion=0A> handling needs to be done in the kernel and it does this=0A> the ri=
ght way.=0A> =0A> Use your own Bluetooth stack or switch the device into RA=
W=0A> mode and=0A> program it as you like. As Johan mentioned RAW devices a=
re=0A> left alone by=0A> the kernel.=0A> =0A> Regards=0A> =0A> Marcel=0A> =
=0A> =0A> 
