Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 03:04:31 +0100 (CET)
From: Leszek Koltunski <leszek@3miasto.net.pl>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802041752.04450.sa@claborn.net>
Message-ID: <20080205030256.E1739@3miasto.net.pl>
References: <200801242256.33910.sa@claborn.net> <479D1EFB.9020005@gmail.com>
	<200802041752.04450.sa@claborn.net>
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



> On Sunday 27 January 2008 18:16:59 Eugene wrote:
>> and send its output. Else, did you started bluetooth audio service?
>> To check, use:
>> ps ax | grep bluetoothd-service-audio

> ps ax |grep blue
> 27467 ?        Ss     0:00 /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
> 27472 ?        S      0:00 /usr/lib/bluetooth/bluetoothd-service-input


^^^^^ Obviously you're not running the audio service.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
