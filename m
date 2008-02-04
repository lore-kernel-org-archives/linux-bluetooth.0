Return-Path: <cyrus@holtmann.org>
From: SA <sa@claborn.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 4 Feb 2008 17:52:04 -0600
References: <200801242256.33910.sa@claborn.net> <479D1EFB.9020005@gmail.com>
In-Reply-To: <479D1EFB.9020005@gmail.com>
MIME-Version: 1.0
Message-Id: <200802041752.04450.sa@claborn.net>
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

On Sunday 27 January 2008 18:16:59 Eugene wrote:
> Hello,
> try to
> aplay -v -D bluetooth './your-sound.wav'
> and send its output. Else, did you started bluetooth audio service?
> To check, use:
> ps ax | grep bluetoothd-service-audio


BTW I started off using KDE and the bluetooth applet to pair the device. It is 
now listed in the "Paired/Trusted Devices" screen. It it also listed in 
the "Configured Input Devices" section of "Input Devices".

I'm a little suspicious of the KDE applets, does anyone know what tools to use 
on the commandline to make sure that the connection/pairing is good? It shows 
up with hcitool scan:


citrine:~ # hcitool scan
Scanning ...
        00:0D:3C:6F:0E:89       Jawbone
#

Output of trying to play:

:~> aplay -v -D bluetooth /work/tmp/Audio-tmp/11\ -\ How\ Can\ I\ Keep\ From\ 
Singing-.wav
ALSA lib pcm_bluetooth.c:1189:(bluetooth_init) Connection fail
aplay: main:546: audio open error: Connection refused

I don't see anything useful in /var/log/messages

I tried deleting the pairing, re-pairing and immediately doing the "aplay" 
test and still I get the same error.

As far as the bluetooth audio service, I'm not sure. As I mentioend, I'm on 
SuSE 10.3. It only has /etc/init.d/bluetooth which I think is supposed to 
handle all types of bluetooth connections - like a wrapper or something.

ps ax |grep blue
27467 ?        Ss     0:00 /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
27472 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-input


# cat /etc/bluetooth/audio.service
[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service

My bluetooth adapter is the good old USB D-Link DBT 120 that works on 
everything (Mac, Linux etc).

hcitool con shows:

# hcitool con
Connections:


hcitool rssi 00:0D:3C:6F:0E:89
Not connected.


I'm not sure what that means. I wonder if it means it's not really connected?

	JW

-- 

----------------------
System Administrator - Cedar Creek Software http://www.cedarcreeksoftware.com
http://jwadmin.blogspot.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
