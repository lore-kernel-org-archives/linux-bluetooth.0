Return-Path: <wolfgang.heidrich@esk.fhg.de>
Message-ID: <3E6EFB60.1B36829@esk.fhg.de>
Date: Wed, 12 Mar 2003 10:18:24 +0100
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for Clock offset event
References: <5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030307165419.01bb5668@mail1.qualcomm.com>
	<3E6E22B3.8E6E87FA@esk.fhg.de> <1047428151.28416.8.camel@pegasus.local>
Content-Type: text/plain; charset=iso-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Hello,

the patch alone doesn't help to accelerate connection establishment.
And of course you are right, that the clock offset event is only
generated
if someone requests it for an existing acl-conenction. But maybe
some people want to do this.
But maybe if you terminate the connection and want to establish it again
without inquiry (just using the inquiry cache), the clock offset event
is 
helpful (why do we have the inquiry cache?). Especially if you want to
do this automatically. For the normal user this has no benefit until
now.

In this context INQUIRY_ENTRY_AGE_MAX should be set to e.g. one hour
(see the mails from 30th. of January, Subject "Connecting with clock
offset").

But the main reason for integrating this event in bluez is: 
The clock offset event exists in the spec
and can be generated if someone wants to do this
and there is no reason to omit these few lines of code.

Regards

Marcel Holtmann schrieb:
> 
> Hi Wolfgang,
> 
> > I added support for the clock offset event to bluez-kernel. The
> > attached patch is very simple and applies cleanly to bluez-kernel-2.3.
> > If you like, you can commit it. Then bluez gets one more step more
> > complete.
> > The clock information in the corresponding
> > entry of the inquiry cache is updated in case of a clock offset event.
> >
> > Clock offset is important for very fast connection establishment.
> 
> thanks for the patch. Can you please explain how it should help to get a
> fast connection establishment. I have been through the spec. and the
> clock offset event will only be generated if you request it with the
> read clock offset command. This command requires a connection handle of
> an ACL link and if you got the connection handle you will already have a
> established connection. So I can't see how this patch will give us any
> advantages.
> 
> Regards
> 
> Marcel

-- 
Fraunhofer Einrichtung für Systeme der Kommunikationstechnik (ESK)

Wolfgang Heidrich        	  	Hansastraße 32
Dipl.-Ing.                      	80686 München / Germany
                                  	Phone :  +49(0)89-547088-376
E-Mail: wolfgang.heidrich@esk.fhg.de   	Fax   :  +49(0)89-547088-221
