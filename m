Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Favrholdt <pfavr@mip.sdu.dk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40E346A8.2050209@mip.sdu.dk>
References: <40E33BF2.7010705@mip.sdu.dk>  <40E346A8.2050209@mip.sdu.dk>
Content-Type: text/plain
Message-Id: <1088691001.4540.230.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 01 Jul 2004 16:10:01 +0200

Hi Peter,

> Well, I figured out I didn't have the /dev/snd/* device files
> 
> So now it almost works. The headset seems connected. I can use alsamixer (and 
> the volume buttons on the headset changes the volume in the mixer window). 
> hciconfig shows data is flowing at a steady rate from the microphone:
> 
> hci0:   Type: USB
>          BD Address: 00:0B:0D:20:79:21 ACL MTU: 339:4  SCO MTU: 64:0
>          UP RUNNING PSCAN ISCAN
>          RX bytes:8895374 acl:72 sco:329395 events:232 errors:0
>          TX bytes:3768 acl:151 sco:0 commands:47 errors:0
> 
> But no sound

and I am not sure that your USB dongle supports SCO over HCI. Show us
the output of "hciconfig -a" and "cat /proc/bus/usb/devices".

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
