Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reading RSSI of non-connected devices
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43A03888.5010105@rumms.uni-mannheim.de>
References: <4396F911.40705@rumms.uni-mannheim.de>
	 <1133968124.3752.35.camel@blade>  <43970C1E.6020602@rumms.uni-mannheim.de>
	 <1133973783.3752.47.camel@blade>  <43A03888.5010105@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1134573996.11064.56.camel@wyatt.hadess.net>
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
Date: Wed, 14 Dec 2005 15:26:36 +0000

On Wed, 2005-12-14 at 16:21 +0100, Andreas Faerber wrote:
> Hi Marcel, Hi Arpit,
> 
> I've made some progress on our periodic scan test code. I didn't find 
> the example you referenced but I have managed to initiate a periodic 
> scan, to read some events and to stop the scan. Some things I noticed 
> however, for instance that when I ran my app twice a little time-shifted 
> the second process didn't get any events once the first process was 
> finished. Can I avoid this somehow? Currently I am catching the 
> EVT_CMD_COMPLETE event for OCF_EXIT_PERIODIC_INQUIRY and restarting the 
> search, but as I am not getting an event for the start of the periodic 
> inquiry that I could process it would seem that if I do e.g. a 3 second 
> period inquiry and during my scan afterwards someone else does e.g. a 30 
> second period inquiry then it will change this on a global level so that 
> I do not get my results as expected?
> 
> Regarding the multitude of events, how do I distinguish between the 
> inquiry_info_with_rssi and inquiry_info_with_rssi_and_pscan_mode 
> structs? They appear to be using the same event but would be 
> incompatible due to the "inserted" pscan_mode member. Currently I am 
> testing with an HCI 1.1 device and getting only the inquiry_info struct. 
> Which of the other inquiry+RSSI events map to which HCI version? Is 
> inquiry_info_with_rssi HCI 1.2 and extended_inquiry_info HCI 2.0? Or do 
> these responses depend on anything else?
> 
> Oh, and is it not possible to send HCI commands as a non-root user? We 
> were getting EPERM from hci_send_cmd and had to setup a Linux box solely 
> for this purpose so that I could be root - admins wouldn't allow that on 
> the other University machines, and I'm concerned whether our potential 
> users would all be able to run our software as root...

As Marcel mentioned earlier, the easiest is to use the D-Bus services in
hcid to do that.

---
Bastien Nocera <hadess@hadess.net> 




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
