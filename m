Return-Path: <xavier@xgarreau.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Garreau <xavier@xgarreau.org>
To: Marcel Holtmann <marcel@holtmann.org>,
   Dan ABITBOL <d.abitbol@bloophone.com>
Subject: Re: [Bluez-users] CLASS OF DEVICE AND L2CAP INCOMING CONNECTION REQUESTS
Date: Wed, 29 Oct 2003 16:07:45 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <006c01c39e27$f3d324c0$0900a8c0@Silicium> <1067438006.24041.272.camel@pegasus>
In-Reply-To: <1067438006.24041.272.camel@pegasus>
MIME-Version: 1.0
Message-Id: <200310291607.45916.xavier@xgarreau.org>
List-ID: <bluez-users.lists.sourceforge.net>

Le Mercredi 29 Octobre 2003 15:33, Marcel Holtmann a =E9crit :
> > 2/  and/or  make a filter to allow l2cap incoming connections request=
s
> > only from devices that have a specific class of device .
>
> I don't have any real thought about this. Any comments from other
> people?

This can be achieved at hci level by sending a Set_Event_Filter command (=
OGF =3D=20
3, OCF =3D5) with filter type set to 2, Filter_condition_type to 1 and th=
e=20
condition, composed of the CoD that interrests you followed by a mask=20
indicating the bits of interrest in the preceding CoD.

The problem is i'm sure you need to be root to do that and it forbids hci=
=20
connections ...

Regards,
--=20
Xavier Garreau
http://www.xgarreau.org
