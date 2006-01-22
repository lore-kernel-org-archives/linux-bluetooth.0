Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez is uncompilable
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200601220328.00979.mlipocky@atlas.sk>
References: <200601220328.00979.mlipocky@atlas.sk>
Content-Type: text/plain
Message-Id: <1137898197.20856.154.camel@localhost>
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
Date: Sun, 22 Jan 2006 03:49:57 +0100

Hi Martin,

> I now downloaded the latest bluez and I cannot compile the stuff, no matter 
> what version of gcc I try. There must be a complete mess in the code.
> 
> gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/include  -I/usr/include 
> -Wall -O2 -D_FORTIFY_SOURCE=2 -c `test -f 'sdptool.c' || echo './'`sdptool.c
> sdptool.c: In function `print_raw_data':
> sdptool.c:590: warning: unknown conversion type character `j' in format
> sdptool.c:590: warning: too many arguments for format
> sdptool.c:605: warning: unknown conversion type character `j' in format
> sdptool.c:605: warning: too many arguments for format
> sdptool.c: In function `add_isync':
> sdptool.c:2621: `APPLE_AGENT_SVCLASS_ID' undeclared (first use in this 
> function)
> sdptool.c:2621: (Each undeclared identifier is reported only once
> sdptool.c:2621: for each function it appears in.)
> sdptool.c: At top level:
> sdptool.c:2681: `APPLE_AGENT_SVCLASS_ID' undeclared here (not in a function)
> sdptool.c:2681: initializer element is not constant
> sdptool.c:2681: (near initialization for `service[30].class')
> make[2]: *** [sdptool.o] Error 1
> make[2]: Leaving directory 
> `/home/mlipocky/install/synce/bluez-utils-2.25/tools'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/mlipocky/install/synce/bluez-utils-2.25'
> make: *** [all] Error 2

read the README and you will see that you need bluez-libs-2.25 in order
to compile bluez-utils-2.25.

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
