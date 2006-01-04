Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Some fun with Apple devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060104141041.e4c44035.henryk@ploetzli.ch>
References: <1136374748.13931.17.camel@localhost>
	 <20060104141041.e4c44035.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1136382444.24203.2.camel@localhost>
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
Date: Wed, 04 Jan 2006 14:47:24 +0100

Hi Henryk,

> > If you don't wanna install the CVS you might replace the string
> > "apple" with "0x1234" and you get the same information about this
> > record. I am really interested how other MacOS X machines look like.
> 
> henryk@gleam ~ $ sdptool search --bdaddr 00:0A:94:XX:XX:XX --raw 0x1234
> Class 0x1234
> Sequence
>         Attribute 0x0000 - ServiceRecordHandle
>                 UINT32 0x00020000
>         Attribute 0x0100
>                 String Apple Macintosh Attributes
>         Attribute 0x0780
>                 UUID128 f0722e20-0f8b-4e90-8cc2-1b46f5f2efe2
>         Attribute 0x0781
>                 String PowerMacG4
>         Attribute 0x0782
>                 String PowerMac3,4
>         Attribute 0x0783
>                 UINT32 0x00000000
>         Attribute 0x0784
>                 String 1.6.6f22
>         Attribute 0x0785
>                 UINT32 0x00000002
>         Attribute 0x0786
>                 UUID16 0x1234
> 
> This is a Mac in my university's Macintosh pool. I don't know anything
> about Macs, but on the "About this Mac" window it says "Processor: 466
> MHz PowerPC G4, Memory: 512 MB SDRAM" (well, actually it's speaking
> German) and the 'System Profiler' identifies the computer name as
> "Power Mac G4" and the computer model as "PowerMac3,4". The operating
> system seems to be "Mac OS X 10.4.3 (8F46)".

the attribute 0x0784 is the version of the Bluetooth stack. If you look
at the extensions for Bluetooth, they will show the same version number.
I am actually curious about the attributes 0x0783 and 0x0785.

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
