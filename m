Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43A5B0BB.1070108@rumms.uni-mannheim.de>
From: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@rumms.uni-mannheim.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth and C#
References: <1134931244.6881.19.camel@localhost>
In-Reply-To: <1134931244.6881.19.camel@localhost>
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
Date: Sun, 18 Dec 2005 19:55:55 +0100

Hi Marcel,

>I was playing a little bit with Mono and C# lately and I think we are
>really in need for some good C# Bluetooth bindings.
>
Good idea. If you want to write a BlueZ#, then through P/Invoke you 
would be able to call into libbluetooth.so.

>I would expect that
>Microsoft already defined some
>
No, not that I'm aware of - that is not in .NET Framework 1.0, 1.1 and 
2.0. Also Mono does not currently ship any.

>, but I wasn't able to locate any good
>documentation about Windows Bluetooth programming with C#. I found some
>crap about the CE mobile/embedded stuff, but not for the desktop OS.
>  
>
There was something at OpenNETCF.org for the .NET CF but it has 
dependencies on external COM interop components by InTheHand.

>So does anybody used C# under Windows XP for Bluetooth programming so
>far or is the only option still C++?
>  
>
I am not aware of a free, widely used Bluetooth framework for .NET. If 
you come upon any others, please let me know!

Best regards,

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
