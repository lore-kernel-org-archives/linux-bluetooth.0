Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <473C74C1.2000105@aircable.net>
Date: Thu, 15 Nov 2007 13:33:05 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <473BB4BA.4030102@aircable.net>
	<1195139936.3140.98.camel@cookie.hadess.net>
In-Reply-To: <1195139936.3140.98.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="------------000600080401090706070707"
Subject: Re: [Bluez-devel] [PATCH] Fix 64 configuration
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
--------------000600080401090706070707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Oops!! Sorry.
> Please use "diff -up" to generate your patches. There's not even a
> filename in the diff you posted.
>
>   
Here it's again.

--------------000600080401090706070707
Content-Type: text/x-patch;
 name="bluez-utils_64bits.cvs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-utils_64bits.cvs.patch"

--- acinclude.m4.orig	2007-11-14 23:40:12.000000000 -0300
+++ acinclude.m4	2007-11-15 12:22:48.000000000 -0300
@@ -44,11 +44,17 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 
 		prefix="${ac_default_prefix}"
 	fi
-
-	if (test "${libdir}" = '${exec_prefix}/lib'); then
-		libdir="${prefix}/lib"
+	
+	dnl if lib64 is present then we use it
+	if (test -d "${prefix}/lib64" ); then
+	    libdir="${prefix}/lib64"
 	fi
-
+	
+	dnl and then only if ${libdir} keeps beeing empty we use lib
+	if ( test -z "${libdir}" ) ; then
+	    libdir="${prefix}/lib"
+	fi
+	
 	if (test "$sysconfdir" = '${prefix}/etc'); then
 		configdir="${prefix}/etc/bluetooth"
 	else

--------------000600080401090706070707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------000600080401090706070707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000600080401090706070707--
