Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jean-Claude Repetto <jrepetto@free.fr>
Subject: Re: [Bluez-devel] dund needs pppd
In-reply-to: <1139311118.15160.19.camel@localhost>
To: bluez-devel@lists.sourceforge.net
Message-id: <33574.84.98.162.18.1139312824.squirrel@jcr.homelinux.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <52492.192.168.0.2.1138486931.squirrel@jcr.homelinux.com>
 <1139311118.15160.19.camel@localhost>
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
Date: Tue, 07 Feb 2006 12:47:04 +0100 (CET)

Hello Marcel,

Marcel Holtmann wrote :
>
> good catch, but your patch has some problems. It should be LOG_ERR
> instead of LOG_INFO and you don't need a "\n" at the end when calling
> syslog().

OK. I didn't know about the "\n".

> However this is fixed in the CVS now.

Thanks.

Regards,
Jean-Claude




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
