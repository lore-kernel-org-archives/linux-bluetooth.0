Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
From: Fredrik Tolf <fredrik@dolda2000.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1110808286.5056.87.camel@pc7.dolda2000.com>
References: <1110683934.5056.43.camel@pc7.dolda2000.com>
	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
	 <42357B08.7020009@dark-reality.de>
	 <1110808286.5056.87.camel@pc7.dolda2000.com>
Content-Type: text/plain
Message-Id: <1110812452.5056.108.camel@pc7.dolda2000.com>
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
Date: Mon, 14 Mar 2005 16:00:52 +0100

On Mon, 2005-03-14 at 14:51 +0100, Fredrik Tolf wrote:
> On Mon, 2005-03-14 at 12:52 +0100, Lars Grunewaldt wrote:
> > Is it possible to have the headset buttons work as they did without the
> > patch, like, switching between both behaviours? there are scenarios for
> > both methods, and even the BT specs cover both of them.
> I'm not sure if the signal interface or config file extension is the
> best, really, so I'd appreciate comments on that.

In fact, I took the time and extended the config file format. Now, the
daemon has a "SCO force" variable, that forces connection or
disconnection. If this variable is set to 0, the SCO channel will not be
connected, if it is 1, it will be connected, and if it is -1 (the
default), the connection status will depend on the driver usage.

Some sample config files:

AT\+CKPD=200
system play ~/sounds/click05.wav
AT\+CHLD=2
system play ~/sounds/click06.wav

AT\+CKPD=200
sco-force on
AT\+CHLD=2
sco-force off

AT\+CKPD=200
sco-toggle on off
AT\+CHLD=2
system play ~/sounds/click06.wav

The arguments to sco-force and sco-toggle can be `on', `off' or `none',
which corresponds to the values 1, 0 and -1 of the force variable,
respectively. The default for sco-toggle is to toggle between on and
none.

The new patch is once again available at
<http://www.dolda2000.com/~fredrik/patches/btsco.diff>

Fredrik Tolf




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
