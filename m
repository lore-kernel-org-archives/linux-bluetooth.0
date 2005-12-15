Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reading RSSI of non-connected devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43A083E1.1050804@rumms.uni-mannheim.de>
References: <4396F911.40705@rumms.uni-mannheim.de>
	 <1133968124.3752.35.camel@blade>  <43970C1E.6020602@rumms.uni-mannheim.de>
	 <1133973783.3752.47.camel@blade>  <43A03888.5010105@rumms.uni-mannheim.de>
	 <1134577422.10473.1.camel@localhost>
	 <43A04F30.7080600@rumms.uni-mannheim.de>
	 <1134580410.10473.5.camel@localhost>
	 <43A083E1.1050804@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1134623747.5198.8.camel@localhost>
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
Date: Thu, 15 Dec 2005 06:15:47 +0100

Hi Andreas,

> >>>>Regarding the multitude of events, how do I distinguish between the 
> >>>>inquiry_info_with_rssi and inquiry_info_with_rssi_and_pscan_mode 
> >>>>structs? They appear to be using the same event but would be 
> >>>>incompatible due to the "inserted" pscan_mode member. Currently I am 
> >>>>testing with an HCI 1.1 device and getting only the inquiry_info struct. 
> >>>>Which of the other inquiry+RSSI events map to which HCI version? Is 
> >>>>inquiry_info_with_rssi HCI 1.2 and extended_inquiry_info HCI 2.0? Or do 
> >>>>these responses depend on anything else?
> >>>>
> >>>The event code is different.
> >>>
> >>For the two I mentioned it is not, there is none defined for the latter. 
> >>Only its size is - in bluez-libs-2.22.tar.gz.
> >>But what about practical availability of those? When do we get which 
> >>response? Do you have any link on that or a short answer?
> >
> >look again, because they are different and bluez-libs-2.22 even contains
> >the definitions for extended inquiry already.
> >  
> No, all I was saying is that there was definately no 
> EVT_INQUIRY_RESULT_WITH_RSSI_AND_PSCAN_MODE defined in the 
> bluez-libs-2.22.tar.gz hci.h file, at least not anywhere near the 
> inquiry_info_with_rssi_and_pscan_mode struct. The extended_inquiry_info 
> struct on the other hand I even mentioned in the above quote, so I did 
> see it.
> 
> So you are saying that (theoretically) I should be able to distinguish 
> all responses by event code. In that case my question on when do I get 
> the respective event codes for an inquiry_info_with_rssi vs. 
> inquiry_info_with_rssi_and_pscan_mode vs. extended_inquiry_info still 
> stands...

my bad and I totally forgot about it. This is an ugly hack for these
stupid devices around that support inquiry with RSSI, but followed the
0.7 version of the Bluetooth 1.2 specification instead of the final one.
They removed page scan mode before they made the specification final and
thus you have to hack around it. So far I've seen Silicon Wave based
chips with this behavior (this includes AVM actually).

So in general if you get an EVT_INQUIRY_RESULT_WITH_RSSI you should only
expect to deal with inquiry_info_with_rssi. If you wanna really deal
with a broken device then you need to compare the length of the event
(don't forget the number of results) and then decide if you need to work
around a broken device or not. Actually the kernel is doing this now,
but I never implemented that in any userspace routine. However I think
that I also made hcidump aware of it.

I personally won't bother with inquiry_info_with_rssi_and_pscan_mode ;)

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
