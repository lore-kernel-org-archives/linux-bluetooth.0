Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] GetAlias crash
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602221142qedbca67k616f1f05c435d179@mail.gmail.com>
References: <e1effdeb0602221142qedbca67k616f1f05c435d179@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140644211.4519.49.camel@localhost>
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
Date: Wed, 22 Feb 2006 22:36:51 +0100

Hi Claudio,

> The GetAlias is crashing when the requested device alias doesn't
> belongs to "aliases" file.

good catch.

> Now, the  daemon is returning the same error message used in the
> RemoteAlias: "Error org.bluez.Error: No such device or address".
> Is it ok?

The GetAlias and RemoteAlias must become GetRemoteAlias. I spent some
time thinking about it and after writing the first code for it, I
actually realized that GetRemoteAlias and SetRemoteAlias methods and
RemoteAliasChanged signal would be much better and cleaner.

> The "err" casting to a positive value is a little bit uggly. If you
> prefer another approach, fell free to change or let me know that I can
> change. :)

I think we might gonna change the error code reply once again. For some
higher level programming languages they translate to exceptions and in
this case we have to define our own error codes/exceptions. However I
haven't had the time to fully think about it.

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
