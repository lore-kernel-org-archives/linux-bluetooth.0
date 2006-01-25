Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D6CF2D.1040903@masaka.cs.ohiou.edu>
From: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] vendor/manufacture id
References: <43D69967.3060704@yall.nl> <1138143376.2616.5.camel@localhost>
In-Reply-To: <1138143376.2616.5.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 24 Jan 2006 20:06:53 -0500


> Nobody spent the time to run something like that by me. So actually
> there is no real good JSR-82 implementation for BlueZ.
> 
> Regards
> 
> Marcel

I've tested all of the JSR-82 options out there that are available for 
free on Linux: the only thing I got to work is Avetana's JSR-82 spec 
(GPL code on Linux).  You can grab it from SourceForge here:

http://sourceforge.net/projects/avetanabt/

The build instructions are unusual and the latest release is poorly put 
together (possibly by me), but if you read through the documentation, 
you should be able to get it up and running.  There's some example code 
in the project.

Lastly, if you have any other option besides JSR-82, I suggest you take 
it -- you'll save yourself many headaches.

Jim


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
