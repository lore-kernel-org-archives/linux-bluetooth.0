Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 20:47:54 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802051233.33098.sa@claborn.net>
Message-ID: <alpine.LNX.1.00.0802052042410.20192@nge2.ngu.pk>
References: <200801242256.33910.sa@claborn.net>
	<20080205030256.E1739@3miasto.net.pl>
	<200802051229.19004.sa@claborn.net>
	<200802051233.33098.sa@claborn.net>
MIME-Version: 1.0
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


On Tue, 5 Feb 2008, SA wrote:

-> > > > ps ax |grep blue
-> > > > 27467 ?        Ss     0:00 /usr/sbin/hcid -s -f
-> > > > /etc/bluetooth/hcid.conf 27472 ?        S      0:00
-> > > > /usr/lib/bluetooth/bluetoothd-service-input
-> > >
-> > > ^^^^^ Obviously you're not running the audio service.
-> >
-> > I thought the bluetooth service /etc/init.d/bluetooth started all the
-> > services but I guess it's not working.

It autostarts when hcid and friends start up.


-> > There is a file, /usr/lib/bluetooth/bluetoothd-service-audio which belongs
-> > to the package bluez-utils. Should I just run it from the terminal? How is
-> > it *supposed* to be configured?
-> >
-> > 	JW
-> 
-> I tried running it from the terminal and I got this:
->

You never need touch the stuff in /usr/lib/bluetooth (to run it).


-> /usr/lib/bluetooth/bluetoothd-service-audio
-> audio[2248]: Bluetooth Audio daemon
-> audio[2248]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No such 
-> file or directory
-> audio[2248]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No such 
-> file or directory
-> audio[2248]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No such 
-> file or directory
-> audio[2248]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No such 
-> file or directory
-> audio[2248]: Config options: DisableHFP=true, SCORouting=HCI, SourceCount=1
-> audio[2248]: Unix socket created: 5
-> audio[2248]: add_service_record: got record id 0x10001
-> audio[2248]: add_service_record: got record id 0x10002
-> audio[2248]: Registered manager path:/org/bluez/audio
->

Well, there you go. Look in the bluez-utils src and pull out the audio.conf 
and stick it in the /etc/bluetooth dir. Edit the audio.service file:

cat /etc/bluetooth/audio.service

[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true



Note most of the services are missing the Autostart line. I add it and set it 
to true, and that at least gets the service running here.




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
