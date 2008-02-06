Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <356106.66582.qm@web8402.mail.in.yahoo.com>
References: <356106.66582.qm@web8402.mail.in.yahoo.com>
Date: Wed, 06 Feb 2008 11:06:18 +0100
Message-Id: <1202292378.15090.216.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] system hangs playing audio on headset
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

Hi Pramod,

> Thanks for that hint
> When I try 
> [root@localhost
> Pramod]# /usr/local/lib/bluetooth/bluetoothd-service-audio
> this is not working....
> audio[13117]: Bluetooth Audio daemon
> audio[13117]: Unix socket created: 5
> audio[13117]: audio.conf: /etc/bluetooth/audio.conf: key Enable not
> found
> audio[13117]: audio.conf: /etc/bluetooth/audio.conf: key Disable not
> found
> audio[13117]: Adding service record failed: Method "AddServiceRecord"
> with signature "ay" on interface "org.bluez.Database" doesn't exist
> audio[13117]: Unable to register HS AG service record
> audio[13117]: Unregistered manager path
> audio[13117]: Audio init failed!
> 
> I saw those AddServiceRecord scripts on bluez_Audio_HowTO..
> How to work them out?

make sure you are actually running hcid from 3.25 and not some distribution default.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
