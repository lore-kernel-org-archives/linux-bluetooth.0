Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com>
References: <1090054739.4558.2.camel@pegasus>
	 <1090759952.4791.91.camel@pegasus>
	 <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com>
	 <1090864026.29589.1.camel@pegasus>
	 <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com>
	 <1090865790.29589.5.camel@pegasus>
	 <76F28965-DF34-11D8-B83A-00039390D626@pepper.com>
	 <1090875679.10807.1.camel@pegasus>
	 <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com>
	 <1090916301.4650.9.camel@pegasus>
	 <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1090940516.4845.19.camel@pegasus>
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
Date: Tue, 27 Jul 2004 17:01:56 +0200

Hi Michael,

> > at the end of hidp_input_report() and see if this helps out for your
> > keyboard and mouse problems. What do "hidd -l" say after you have
> > connected the devices? What devices do you use?
> 
> root@(none):~# hidd -l
> 00:02:72:40:8A:97 HID Boot Device [0000:0000] connected
> 
> I am using a Keyboard with integrated mouse.  So I guess it is 
> technically one device.  The mouse is a track ball embedded in the 
> keyboard.  The keyboard is made by BlueLogic.

you should have said this earlier. Do you have a website for me? I need
more information about this device. Please use sdptest from libs2 CVS
repository to get the SDP record.

	./sdptest records 00:xx:xx:xx:xx:xx > sdp_record.txt

Send me that file. I also need the information from "hcitool inq" and
from "hcitool info" for that device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
