Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 12:29:18 -0600
References: <200801242256.33910.sa@claborn.net>
	<200802041752.04450.sa@claborn.net>
	<20080205030256.E1739@3miasto.net.pl>
In-Reply-To: <20080205030256.E1739@3miasto.net.pl>
MIME-Version: 1.0
Message-Id: <200802051229.19004.sa@claborn.net>
Subject: Re: [Bluez-users] How to setup a headset as an audio device?
	Getting "Device busy" errors
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Monday 04 February 2008 20:04:31 Leszek Koltunski wrote:
> > On Sunday 27 January 2008 18:16:59 Eugene wrote:
> >> and send its output. Else, did you started bluetooth audio service?
> >> To check, use:
> >> ps ax | grep bluetoothd-service-audio
> >
> > ps ax |grep blue
> > 27467 ?        Ss     0:00 /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
> > 27472 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-input
>
> ^^^^^ Obviously you're not running the audio service.

I thought the bluetooth service /etc/init.d/bluetooth started all the services 
but I guess it's not working.

There is a file, /usr/lib/bluetooth/bluetoothd-service-audio which belongs to 
the package bluez-utils. Should I just run it from the terminal? How is it 
*supposed* to be configured?

	JW


-- 

----------------------
System Administrator - Cedar Creek Software
http://www.cedarcreeksoftware.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
