Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051216031937.GE12373@elmicha.333200002251-0001.dialin.t-online.de>
References: <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost> <op.s1t0xmg8xabado@portatilegio> <op.s1t2ws0rxabado@portatilegio> <op.s1t63hh3xabado@portatilegio> <20051215211716.GB12373@elmicha.333200002251-0001.dialin.t-online.de> <op.s1uu2mo1xabado@portatilegio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.s1uu2mo1xabado@portatilegio>
Subject: [Bluez-users] Re: A blue chamaleon to be
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 16 Dec 2005 04:19:37 +0100

zio tom wrote:

> In data Thu, 15 Dec 2005 22:17:16 +0100, Michael Mauch  
> <michael.mauch@gmx.de> ha scritto:
> 
> >"rfcomm" should show rfcomm0 with the device address and the channel.
> >If not, run "rfcomm bind 0".

What's the output of "rfcomm" now?

> >If that works, you could change the "bind no" to "bind yes" in
> >rfcomm.conf and restart the bluez/bluetooth init script (hopefully it
> >contains a "rfcomm bind all").
> 
> Thanks a lot for aswerin on such a newbie issue!
> So, here my GPRS/Bluetooth situation. I start kde, I open the shell, I  
> type su and the password, then wvdial, my mobile show a pin request, I  
> insert it, the pc pops up with a small window asking the pin, I insert it,  
> the phone says "the pin has been verified and saved"

That's all ok if "rfcomm" shows:

  rfcomm0: 00:0A:28:0C:D4:EF channel 1 clean

before you use wvdial.

Are you sure that the channel number 1 is correct? It's different on
each device. Did you lookup this channel on your device with "sdptool
browse 00:0A:28:0C:D4:EF" or (if that doesn't work) with "sdptool
records 00:0A:28:0C:D4:EF"?

Look for the "Service Name" and the "Channel" lines. I don't know for which
service name you should look, on my phone it's called "SSA" (I don't
know if these names come from the phone or from bluez). If you can't
figure out the suitable channel, post the output of "sdptool records
00:0A:28:0C:D4:EF".


Sorry, I can't help with your other issue.

Regards...
		Michael


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
