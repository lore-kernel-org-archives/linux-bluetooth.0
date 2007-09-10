Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <46DF18F7.8000807@gmail.com>
References: <46DF18F7.8000807@gmail.com>
Date: Mon, 10 Sep 2007 21:13:48 +0200
Message-Id: <1189451628.687.67.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [Bluez-users] [BLUETOOTH-ALSA] Skype with
	SCO/headsetd deamon
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Advhertz,

> anyone knows how to let to works an headset bluetooth via SCO protocol 
> with skype?
> 
> Once compiled and installed the bluetooth-alsa stack I've configured the 
> ~/.asoundrc as the attached one and I did works the headset with vlc 
> (vlc --alsadev=headset-sco-resample file.mp3) and aplay (aplay -D 
> headset-sco-resample file.wav) well.
> 
> But as tried with skype, I had some problem.
> 
> When I launch skype the system do the pairing with the headset device 
> but when I'm trying to make some tests (sound test and test call) I 
> don't hear nothing.

the bluetooth-alsa project is dead. Use the new audio service that is
included in bluez-utils. However the mono headset support with SCO over
HCI has been not tested enough. Feel free to report any issues and you
can always send in patches.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
