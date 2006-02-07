Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dund needs pppd
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <52492.192.168.0.2.1138486931.squirrel@jcr.homelinux.com>
References: <52492.192.168.0.2.1138486931.squirrel@jcr.homelinux.com>
Content-Type: text/plain
Message-Id: <1139311118.15160.19.camel@localhost>
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
Date: Tue, 07 Feb 2006 12:18:38 +0100

Hi Jean-Claude,

> May be it is an evidence for a bluetooth developper, but, as a beginner in
> the bluetooth area,  I spend a lot of time trying to establish a
> connection with a bluetooth device before I looked at the source code of
> dund and realized it needed pppd installed on the computer.
> 
> dund reports no error message !
> 
> I think it should be nice for future users to add an error message like
> that :
> 
> diff -ru bluez-utils-2.19.orig/dund/dun.c bluez-utils-2.19/dund/dun.c
> --- bluez-utils-2.19.orig/dund/dun.c    2006-01-28 22:33:47.000000000 +0100
> +++ bluez-utils-2.19/dund/dun.c 2006-01-28 22:31:10.000000000 +0100
> @@ -175,6 +175,7 @@
>                 close(fd);
> 
>         execvp(prog, args);
> +        syslog(LOG_INFO, "Error while executing %s\n", prog);
>         exit(1);
>  }

good catch, but your patch has some problems. It should be LOG_ERR
instead of LOG_INFO and you don't need a "\n" at the end when calling
syslog(). However this is fixed in the CVS now.

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
