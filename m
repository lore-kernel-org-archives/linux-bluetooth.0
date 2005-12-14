Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reading RSSI of non-connected devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43A04F30.7080600@rumms.uni-mannheim.de>
References: <4396F911.40705@rumms.uni-mannheim.de>
	 <1133968124.3752.35.camel@blade>  <43970C1E.6020602@rumms.uni-mannheim.de>
	 <1133973783.3752.47.camel@blade>  <43A03888.5010105@rumms.uni-mannheim.de>
	 <1134577422.10473.1.camel@localhost>
	 <43A04F30.7080600@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1134580410.10473.5.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 14 Dec 2005 18:13:30 +0100

Hi Andreas,

> >>Regarding the multitude of events, how do I distinguish between the 
> >>inquiry_info_with_rssi and inquiry_info_with_rssi_and_pscan_mode 
> >>structs? They appear to be using the same event but would be 
> >>incompatible due to the "inserted" pscan_mode member. Currently I am 
> >>testing with an HCI 1.1 device and getting only the inquiry_info struct. 
> >>Which of the other inquiry+RSSI events map to which HCI version? Is 
> >>inquiry_info_with_rssi HCI 1.2 and extended_inquiry_info HCI 2.0? Or do 
> >>these responses depend on anything else?
> >
> >The event code is different.
> >  
> For the two I mentioned it is not, there is none defined for the latter. 
> Only its size is - in bluez-libs-2.22.tar.gz.
> But what about practical availability of those? When do we get which 
> response? Do you have any link on that or a short answer?

look again, because they are different and bluez-libs-2.22 even contains
the definitions for extended inquiry already.

> >>[...] is it not possible to send HCI commands as a non-root user? We 
> >>were getting EPERM from hci_send_cmd [...]
> >>
> >The inquiry related commands and events are accessable by all users.
> >Some other are protected by the HCI security inside the kernel.
> >
> As I said, hci_send_cmd for a HCI socket with OGF_LINK_CTL and 
> OCF_PERIODIC_INQUIRY returned errno==EPERM for user and runs fine as 
> root. Same for plugging in Bluetooth dongles - doesn't work for user 
> (driver loaded in dmesg but not listed in hcitool dev), works fine for root.

Oh yes, the periodic inquiry must be started as root. If you recompile
your kernel, you can of course change the HCI security filter and allows
all commands by normal users.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
