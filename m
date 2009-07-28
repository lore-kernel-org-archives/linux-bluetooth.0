Return-Path: <cyrus@holtmann.org>
Subject: Re: Gnome applet failing with current BlueZ?
From: Bastien Nocera <hadess@hadess.net>
To: David Sainty <david.sainty@dtsp.co.nz>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A6E523E.6000802@dtsp.co.nz>
References: <4A6E3161.7010105@dtsp.co.nz>
	 <1248742400.23466.11069.camel@localhost.localdomain>
	 <4A6E523E.6000802@dtsp.co.nz>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 02:23:58 +0100
Message-Id: <1248744238.23466.11103.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-07-28 at 13:19 +1200, David Sainty wrote:
> Bastien Nocera wrote:
> > On Tue, 2009-07-28 at 10:59 +1200, David Sainty wrote:
> >   
> >> Hi all,
> >>
> >> Using BlueZ 4.46 and Gnome Bluetooth 2.27.8, the applet icon fails to 
> >> appear.  If I pull the USB adapter out and in the icon appears, but with 
> >> a little red cross, and it isn't very functional.
> >>     
> >
> > Is bluetoothd running?
> > <snip>
> >   
> 
> Yes, and otherwise functional.  For example, I'm sending this reply over 
> a bluetooth GPRS connection, and at the same time can see the 
> non-functional bluetooth-applet icon with the little red/white cross.
> 
> Running bluetoothd in debug mode didn't seem to display any useful 
> information relating to the applet.

> Agent registration failed: Rejected send message, 2 matched rules; 
> type="method_call", sender=":1.12" (uid=1000 pid=1473 
> comm="bluetooth-applet -d ") interface="org.bluez.Adapter" 
> member="RegisterAgent" error name="(unset)" requested_reply=0 
> destination="org.bluez" (uid=0 pid=1100 comm="bluetoothd "))

Do you have blueman, or the applet from bluez-gnome running?

Looks like D-Bus is refusing the connection, which version of bluez are
you using?

> >> I'm not sure when this stopped working, having got suitably confused 
> >> over whether to use bluez-gnome or gnome-bluetooth I've ended up using 
> >> neither for some time :)  bluez-gnome doesn't work either though.
> >>     
> >
> > I'm not sure what confusion there should be. Use gnome-bluetooth.
> >   
> 
> Well that clears that up :)  But it isn't that obvious from the state of 
> the various web pages.

Which web pages?

Cheers

