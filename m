Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] getting bluetooth v1.2, success report
References: <1112015700.9016.30.camel@pegasus> <42490CD5.2000505@gmx.ch> <1112091360.9016.70.camel@pegasus>
In-Reply-To: <1112091360.9016.70.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200503291220.21937.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 29 Mar 2005 12:20:21 +0200

Dne =FAt 29. b=F8ezna 2005 12:16 Marcel Holtmann napsal(a):
> Hi Marco,
>
> > My last questions (hopefully) regarding this topic now are:
> > - What is dangerous about updating the dongle?
> > the procedure itself? only the linux btdfu tool (secure with mac)?
>
> this depends on. Not all firmwares will fit into every dongle. However
> we discussed this quite often and there is also a statement from a CSR
> in the mailing list archive about it.
>
> > - Widcomm delivers update-software too, will/should this work too with
> > the GenericCSR.dfu?
>
> Never tested, but in general it should do the same job.
>
> > - I now have to run hid2hci every time after I plug the dongle in (than=
ks
> > for the info marcel). What is this exactly doing, why is it necessary?
>
> You get a USB dongle with HID proxy support. Look at the mailing list
> archive for more details on what this is.
>
> > - doing hid2hci I get:
> > Switching device 0a12:1000 to HCI mode failed (Invalid or incomplete
> > multibyte or wide character)
> > but everything's fine after that. is this a problem? why the error?
>
> I thought this was fixed, but in general you can ignore the error.

It wasn't fixed. I see this error too.

>
> Regards
>
> Marcel

Michal

>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
