Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D72204.606@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems compiling btso.
References: <dr73je$gt8$1@sea.gmane.org>
In-Reply-To: <dr73je$gt8$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 25 Jan 2006 00:00:20 -0700

Christopher

> When I download and attempt to install the CVS version of btsco (as
> recommended on the bluetooth-alsa project site, I got the following
> errors from ./bootstrap:
> 
> /usr/share/aclocal/libxosd.m4:9: warning: underquoted definition of
> AM_PATH_LIBXOSD
>   run info '(automake)Extending aclocal'
>   or see http://sources.redhat.com/automake/automake.html#Extending-aclocal
> configure.in: installing `./install-sh'
> configure.in: installing `./missing'
> alsa-plugins/Makefile.am:5: Libtool library used but `LIBTOOL' is undefined

You could try the 0.41 snapshot. It comes pre-bootstrapped. fwiw, I
think it's basically in sync with the cvs sources.

I'm not sure what is up with bootstrapping.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
