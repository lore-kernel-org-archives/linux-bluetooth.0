Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth and C#
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43A5B0BB.1070108@rumms.uni-mannheim.de>
References: <1134931244.6881.19.camel@localhost>
	 <43A5B0BB.1070108@rumms.uni-mannheim.de>
Content-Type: text/plain
Message-Id: <1134933091.6881.29.camel@localhost>
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
Date: Sun, 18 Dec 2005 20:11:31 +0100

Hi Andreas,

> >I was playing a little bit with Mono and C# lately and I think we are
> >really in need for some good C# Bluetooth bindings.
> >
> Good idea. If you want to write a BlueZ#, then through P/Invoke you 
> would be able to call into libbluetooth.so.

I am not going to do this, because I am looking for a standard solution
and not a home brewed one.

> >I would expect that
> >Microsoft already defined some
> >
> No, not that I'm aware of - that is not in .NET Framework 1.0, 1.1 and 
> 2.0. Also Mono does not currently ship any.

Too bad.

> >, but I wasn't able to locate any good
> >documentation about Windows Bluetooth programming with C#. I found some
> >crap about the CE mobile/embedded stuff, but not for the desktop OS.
> >  
> There was something at OpenNETCF.org for the .NET CF but it has 
> dependencies on external COM interop components by InTheHand.

This is the stuff from www.32feet.net now.

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
