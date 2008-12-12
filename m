Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <OFDB593D66.4F9C0904-ON65257514.0044834D-65257515.004C4F06@lntemsys.com>
References: <OFDB593D66.4F9C0904-ON65257514.0044834D-65257515.004C4F06@lntemsys.com>
Date: Fri, 12 Dec 2008 02:51:37 +0100
Message-Id: <1229046697.22285.27.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Setting up Bluetooth Audio (A2DP)
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>         I intend to use the A2DP profile of BlueZ, by playing some
> music over my desktop(Having Broadcom USB bluetooth adaptor) and
> listering it on BT-headset. 
> 
> System Details: 
> Linux Flavour:        Fedora Core 4 
> Linux Kernel:           2.6.26 
> BlueZ version:        4.18 
> DBUS version:        1.2.4 
> GLIB version:        2.14 
> ALSA version:        1.013 
> 
> HCID: 
>         When I start bluetooth service, hcid throws error: Unable to
> get on DBUS and continues to run. I proceed further to pair with
> headset, wherein in gives, Can't connect: Input/Output error. But
> surprisingly it can connect with other bluetooth devices like mobile
> phones. Behaviour is alike irrespective of pin-helpers,bluepin or
> bluez-pin. 
> Bluetoothd: 
>          Yes, I know that version 4.xx replaces hcid wiht bluetoothd.
> I edited the /etc/ini.d/bluetooth script to spawn bluetoothd daemon,
> instead of hcid daemon. Even Bleutoothd daemon throws error:  Unable
> to get on DBUS and exits. 
> 
> Im attaching the debug log herewith. Any help in this regard is deeply
> appreciated. 

your system is seriously screwed up and old. Why don't you just upgrade
to a more recent Fedora 10. The A2DP support should work out of the box
there using ALSA, GStreamer or PulseAudio.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
