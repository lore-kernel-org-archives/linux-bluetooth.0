Return-Path: <cyrus@holtmann.org>
From: "Savoy, Pavan" <pavan_savoy@ti.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 20 Oct 2010 02:24:59 +0530
Subject: RE: [PATCH v3] Bluetooth: btwilink driver
Message-ID: <19F8576C6E063C45BE387C64729E739404AA4E7911@dbde02.ent.ti.com>
References: <1287521858-15190-1-git-send-email-pavan_savoy@ti.com>
 <20101019203913.GA2322@vigoh>
 <19F8576C6E063C45BE387C64729E739404AA4E790D@dbde02.ent.ti.com>
 <20101019205403.GA2331@vigoh>
In-Reply-To: <20101019205403.GA2331@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>



> -----Original Message-----
> From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gustavo=
 F.
> Padovan
> Sent: Tuesday, October 19, 2010 3:54 PM
> To: Savoy, Pavan
> Cc: marcel@holtmann.org; linux-bluetooth@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] Bluetooth: btwilink driver
>=20
> * Savoy, Pavan <pavan_savoy@ti.com> [2010-10-20 02:15:29 +0530]:
>=20
> >
> >
> >
> > > -----Original Message-----
> > > From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of Gus=
tavo
> F.
> > > Padovan
> > > Sent: Tuesday, October 19, 2010 3:39 PM
> > > To: Savoy, Pavan
> > > Cc: marcel@holtmann.org; linux-bluetooth@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3] Bluetooth: btwilink driver
> > >
> > > * pavan_savoy@ti.com <pavan_savoy@ti.com> [2010-10-19 16:57:38 -0400]=
:
> > >
> > > > From: Pavan Savoy <pavan_savoy@ti.com>
> > > >
> > > > v3 comments
> > > >
> > > > Marcel, Gustavo, & list,
> > > > Please review this version of patch.
> > > >
> > > > Anderson,
> > > > I have taken care of most of the comments you had.
> > > > Have re-wrote some of the code commenting you've mentioned.
> > > > Thanks for the comments,
> > > >
> > > > The other few like -EPERM for platform driver registration is to ke=
ep
> > > > it similar to other drivers
> > >
> > > Which drivers returns -EPERM to any kind of error? The are many reaso=
ns
> > > why the funcion can fail, and you want to give the best error report =
to
> the
> > > user. Use EPERM to all of them is just wrong.
> >
> > Yes, it can fail for plenty of reasons.
> > So I'll just return whatever I get from platform_driver_register.
> > Is this OK?
>=20
> Yes.
>=20
> >
> > > >type casting is maintained just to feel safe
> > > > and have style similar to other drivers.
> > >
> > > We don't need to feel safe here. Type cast actually can hide errors,
> > > only use them when you really need to cast, in many case here you don=
't.
> >
> > Ok, I can remove type casting.
> > I am not really for or against it...
>=20
> Yes, do that please. ;)

Done :)

> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
