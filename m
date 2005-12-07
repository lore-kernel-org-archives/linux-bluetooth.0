Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43970C1E.6020602@rumms.uni-mannheim.de>
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@rumms.uni-mannheim.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Reading RSSI of non-connected devices
References: <4396F911.40705@rumms.uni-mannheim.de> <1133968124.3752.35.camel@blade>
In-Reply-To: <1133968124.3752.35.camel@blade>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Wed, 07 Dec 2005 17:21:50 +0100

Hi Marcel,

>the ioctl() is very old and number updated it to support Inquiry with
>RSSI or Extended Inquiry. The main reason for this is, because you can't
>update it without breaking backward-compatibility with older versions of
>the library and the tools.
>
>However you can program the HCI socket interface directly and read the
>inquiry result directly. Example code for this is already available in
>the mailing list archives.
>  
>
Some posts say ioctl was bad because it's old, some posts say raw HCI 
sockets were bad because the messed with BlueZ. Your hcitool apparently 
is using ioctl for "hcitool scan" in its most recent version 
downloadable from your site...
Our software is a Java framework that shall continuously check the RSSI 
of devices around in a background thread (test code for this is in C). 
Another thread might be continuously using GPS data via BT and apart 
from that we don't want to keep the user from using the BlueZ stack in a 
"normal" way while our software is running. In this context is it safe 
to use HCI sockets in the way you have suggested?

I'm having a hard time finding the example you're mentioning over and 
over... Do you have any search words for me?
Not having found it I would assume you mean hci_open_dev and 
hci_send_cmd? Examples for the latter would be in the kernel driver 
which I already have.

Regards,

Andreas



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
