Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030722104135.097ae0b8@unixmail.qualcomm.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Re: Re: Bluetooth headset with Bluetooth usb
	dongle status.
Cc: Jonathan Paisley <jp-www@dcs.gla.ac.uk>, bluez-devel@lists.sourceforge.net
In-Reply-To: <3F1C8EED.2050903@superbug.demon.co.uk>
References: <5.1.0.14.2.20030721172151.094589f0@unixmail.qualcomm.com>
	<E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk>
	<1058533496.25379.237.camel@pegasus>
	<3F17FD1A.9050003@superbug.demon.co.uk>
	<5.1.0.14.2.20030721172151.094589f0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 22 Jul 2003 10:46:34 -0700

At 06:10 PM 7/21/2003, James Courtier-Dutton wrote:
>Max Krasnyansky wrote:
>>At 07:33 AM 7/20/2003, Jonathan Paisley wrote:
>>
>>>I have managed to get playback and recording (with the PC acting as a
>>>headset for my phone) to work well. I've made the following changes which
>>>are included in the patch at the end:
>>>
>>>      (1) submit two rx urbs (same as your proposed patch, but done at caller)
>>>      (2) allow two pending isoc urbs instead of one
>>>      (3) only use the 9 byte (single voice channel) isoc endpoint
>>I buy #1 and #2, although I'm surprised that it's supported by HCD.
>>But 9 bytes packets ?
>Read the bluetooth headset specification. For 8000hz 8 bit mono sound.

Bluetooth headset spec has nothing to do with HCI over _USB_. USB is just one
of the defined transports for HCI.

Max



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
