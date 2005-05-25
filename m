Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcitool cc timeout - change able ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.58.0505251521120.25684@myrtle.ukc.ac.uk>
References: <Pine.GSO.4.58.0505251442560.25684@myrtle.ukc.ac.uk>
	 <1117029743.30044.212.camel@pegasus>
	 <Pine.GSO.4.58.0505251521120.25684@myrtle.ukc.ac.uk>
Content-Type: text/plain
Message-Id: <1117031469.30044.215.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 25 May 2005 16:31:09 +0200

Hi Phil,

> > > could some one please tell me if there is a way to reduce the timeout time
> > > ? e.g. to 2 ?
> > >
> > > I would like to do this, because I like to find out what the link
> > > quality and rssi of a device is. As
> > > my bluetooth hardware only supports 1.1 and not 1.2 I have to connect to
> > > the device first in order to find out the above information. As my list of
> > > BT devices I would like to find the above info out about is constantly
> > > growing I have a problem with the hcitool cc timeout, as I do:
> > >
> > > hcitool cc BT-address
> > > hcitool lq BT-address
> > > hcitool dc BT-address
> > >
> > > If the device is in range the three commands are very quick, but if the
> > > device is not in range the connect command takes a long time till it times
> > > out.
> > > So my question is, is there a way to reduce the timeout time ? e.g. to 2
> > > sec. ?
> >
> > you are looking for the page timeout. Look at the manual page of
> > hciconfig.
> 
> 
> I did look at the manual page, but all I found was:
> 
> lst <bdaddr> [value]
>               With no value, displays link supervision timeout for the
> 	      connection to the device with Bluetooth address bdaddr.  If  value
>               is given,  sets the link supervision timeout for that
>               connection to value slots, or to infinite if value is 0.
> 
> But this only sets the timeout for conncetions which are already
> established. I would like to change the timeout for trying to establish a
> conncetion, e.g. if the device can't be found within 2 sec. stop trying.

you may wanna read my response again. When I say page timeout then I
mean page timeout and not link supervision timeout. I also said that you
should look at the manual page of hciconfig and not hcitool. This means
that the command will be "hciconfig hci0 pageto <slots>".

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
