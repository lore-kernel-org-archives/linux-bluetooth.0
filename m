Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] vendor/manufacture id
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <43D69967.3060704@yall.nl>
References: <43D69967.3060704@yall.nl>
Content-Type: text/plain
Message-Id: <1138143376.2616.5.camel@localhost>
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
Date: Tue, 24 Jan 2006 23:56:16 +0100

Hi Michiel,

> I posted almost the same email to the bluez-user mailing list, but its more developer related I think;
> 
> I use the outdated jBluez native Java API and got a question about the manufacture 
> id's.
> 
> When getting version info for a remote device using the Java API wich is native corresponding with Bluez a manufacture 
> id is retreived and stored. This is great but I don't have or can't find any list corresponding with 
> these manufacture id's. I browsed some Bluez c code and did see some manufacture id such as 10 (Nokia) being stored and used in functions.

the company id 10 stands for CSR. Take a look at the Bluetooth assigned
numbers documents from their website.

> Another question which is proberbly asked many times before, but I just can't 
> settle with it, yet:
> 
> - Is there a good, can be simple but good and maintened opensource Java API for Bluez?

Nobody spent the time to run something like that by me. So actually
there is no real good JSR-82 implementation for BlueZ.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
