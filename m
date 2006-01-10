Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Error with USB
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43C3A9B4.9070102@yahoo.com>
References: <43C3A9B4.9070102@yahoo.com>
Content-Type: text/plain
Message-Id: <1136909030.7200.0.camel@localhost.localdomain>
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
Date: Tue, 10 Jan 2006 17:03:49 +0100

Hi Pedro,

> I am experiencing a problem with the USB subsystem. For some unknown 
> reason, at a random moment, the ohci_hcd driver starts to fill syslog 
> with messages of the type:
> 
> Dec 22 21:30:21 Host kernel: ohci_hcd 0000:00:13.0: urb c130f7f4 path 
> 1.3 ep1in 5f160000 cc 5 --> status -110
> 
> This happens until the hard disk is filled, that is, once the error 
> happens, it does not stop. I have been looking the kernel archives, 
> Google... with no luck at all, except for a post done by Marcel back in 
> June 2004 at the kernel mailing list, but there was a kernel oops in 
> this case.
> 
> I have attached CSR-based Bluetooth dongles to the USB hub and I am 
> using kernel 2.6.12-mh3. I believe that it is a hardware error, but I 
> want to make sure that there is no known issue with this.
> 
> What was the error in the post done in June 2004? What does this error 
> mean? How is this triggered? Any further information would be greately 
> appreciated.

this is a USB specific error. Try at least a 2.6.15 kernel or newer or
ask the USB gurus.

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
