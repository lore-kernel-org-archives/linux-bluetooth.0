Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F1C8EED.2050903@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Jonathan Paisley <jp-www@dcs.gla.ac.uk>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Re: Bluetooth headset with Bluetooth usb
	dongle status.
References: <E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk>
	<1058533496.25379.237.camel@pegasus>
	<3F17FD1A.9050003@superbug.demon.co.uk>
	<5.1.0.14.2.20030721172151.094589f0@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030721172151.094589f0@unixmail.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 22 Jul 2003 02:10:05 +0100

Max Krasnyansky wrote:
> At 07:33 AM 7/20/2003, Jonathan Paisley wrote:
> 
>>I have managed to get playback and recording (with the PC acting as a
>>headset for my phone) to work well. I've made the following changes which
>>are included in the patch at the end:
>>
>>       (1) submit two rx urbs (same as your proposed patch, but done at caller)
>>       (2) allow two pending isoc urbs instead of one
>>       (3) only use the 9 byte (single voice channel) isoc endpoint
> 
> I buy #1 and #2, although I'm surprised that it's supported by HCD.
> But 9 bytes packets ?
Read the bluetooth headset specification. For 8000hz 8 bit mono sound.

> 
> Max
> 




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
