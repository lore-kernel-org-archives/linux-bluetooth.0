Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] getting bluetooth v1.2
From: Adam Goode <adam@evdebs.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1112030513.9016.40.camel@pegasus>
References: <1112015700.9016.30.camel@pegasus>
	 <20242.1112026706@www42.gmx.net>  <1112030513.9016.40.camel@pegasus>
Content-Type: text/plain
Message-Id: <1112031386.30560.6.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
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
Date: Mon, 28 Mar 2005 12:36:26 -0500

Yes, the "if you are lucky" part is very important. The one-line patch
may look simple, but it took a LONG time of experimenting to figure it
out!


Adam


On Mon, 2005-03-28 at 19:21 +0200, Marcel Holtmann wrote:
> Hi Marco,
> 
> > so it doesn't mather that i've a silicon dongle?
> > (i need the bt v1.2 only because the rssi inquiry)
> > or isn't it a silicon one?
> 
> you dongle is a Cambridge Silicon Radio (CSR for short) and the other
> one is Silicon Wave (SiW for short). Read it more carefully.
> 
> > what is now the procedure?
> > - getting the btdfu program
> > - fix it (Adam Goode told how)
> > - download the 18.x firmware. where can i get it?
> > - install it...
> 
> If you are lucky, then yes. The GenericCSR.dfu is inside the MacOS X
> Bluetooth update you can download from the Apple site.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
