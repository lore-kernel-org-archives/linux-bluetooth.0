Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] authentication problem - link_key prevents from
	pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200505021327.04496.RJenster@web.de>
References: <Pine.LNX.4.30.0505011025590.18702-100000@stealth.kirenet.com>
	 <200505012210.59716.RJenster@web.de> <1114989560.21785.82.camel@pegasus>
	 <200505021327.04496.RJenster@web.de>
Content-Type: text/plain
Message-Id: <1115035517.21785.112.camel@pegasus>
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
Date: Mon, 02 May 2005 14:05:17 +0200

Hi Ruben,

> > > I've a really enerving problem.
> > >
> > > On my desktop I'm not able to pair my headset without
> > > deleting /etc/bluetooth/link_key. After deleting the link_key
> > > the pinhelper pops up and asks for the pin. I insert them and
> > > I'm able to connect.
> >
> > use the latest BlueZ utilities and run "hcidump -X -V" as root, so we
> > can see what is going on.
> 
> Ok, I've attached the hcidump output 
> 
> test sequence:
> deleting link_key (if existent)
> pair with  headset (btsco2 00:0D:B5:80:21:04 )
> 	success -> successfull attempt (after having link_key deleted)
> switching headset off
> pair with  headset (btsco2 00:0D:B5:80:21:04 )
> 	failure -> authentication problem (when not having link_key deleted)

make sure that only _one_ hcid is running at a time and I don't know
what else programs are you running, but all this RSSI etc. stuff that
uses the handle 0 is wrong.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
