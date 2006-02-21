Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Possible Patch: list paired devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200602211837.00121.denis.kenzior@trolltech.com>
References: <200602211837.00121.denis.kenzior@trolltech.com>
Content-Type: text/plain
Message-Id: <1140521857.10008.12.camel@localhost>
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
Date: Tue, 21 Feb 2006 12:37:37 +0100

Hi Denis,

> I noticed that there is no way to list paired devices from hcitool/hciconfig, 
> at least I couldn't find a way to do so.   Here is a proposed patch to 
> hcitool which will show a list of paired devices.  
> 
> I'm not sure if this is the right solution, since it requires hcitool to be 
> run with effective permissions to access the linkkeys file (e.g. root on my 
> system).  If there is a better way let me know.

you can use standard tools like grep and awk to get this information and
since we have the limitation with the root access, I am not going to add
this. Use the new D-Bus interface to retrieve this information.

> Also, will the patch for 128 bit UUID searching in sdptool get merged into 
> CVS, or did I mess something up again?

The patch is in my todo stack, but I haven't looked at it.

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
