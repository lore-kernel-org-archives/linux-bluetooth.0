Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473BB4BA.4030102@aircable.net>
Date: Wed, 14 Nov 2007 23:53:46 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------040109050201060205080501"
Subject: [Bluez-devel] [PATCH] Fix 64 configuration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040109050201060205080501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello everyone,

It's been about 1 month since I got my 64 bits laptop, and after a hole
month I started to figure out why the he## I couldn't get the audio
service working on it. Or the pan service, or the serial service, or
what ever service you might think off.

I was always getting: dbus.exceptions.DBusException:
org.bluez.Error.Failed: Exec format error

When ever I asked dbus to register a new server.

After a long trial and error, I discovered that by default bluez was
installing all the services to ${prefix}/lib instead of ${prefix}/lib64.

Here's a little patch that fixes that problem. I'm not sure if I fixed
the problem in the best way, I haven't ever used auto tools for over 10
seconds, so I might have broken something. I tested, it builds, and then
when I make the install it puts the files into lib64.

The patch was made against the latest cvs version.

Thanks,
Manuel Naranjo
Wireless Cables Inc.
www.aircable.net



--------------040109050201060205080501
Content-Type: text/x-patch;
 name="bluez-utils_64bits.cvs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-utils_64bits.cvs.patch"

47,49c47,50
< 
< 	if (test "${libdir}" = '${exec_prefix}/lib'); then
< 		libdir="${prefix}/lib"
---
> 	
> 	dnl if lib64 is present then we use it
> 	if (test -d "${prefix}/lib64" ); then
> 	    libdir="${prefix}/lib64"
51c52,57
< 
---
> 	
> 	dnl and then only if ${libdir} keeps beeing empty we use lib
> 	if ( test -z "${libdir}" ) ; then
> 	    libdir="${prefix}/lib"
> 	fi
> 	
68a75
> 

--------------040109050201060205080501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------040109050201060205080501
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040109050201060205080501--
