Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] GetAlias crash
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1140644211.4519.49.camel@localhost>
References: <e1effdeb0602221142qedbca67k616f1f05c435d179@mail.gmail.com>
	 <1140644211.4519.49.camel@localhost>
Content-Type: text/plain
Message-Id: <1140651932.4519.57.camel@localhost>
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
Date: Thu, 23 Feb 2006 00:45:32 +0100

Hi Claudio,

> > Now, the  daemon is returning the same error message used in the
> > RemoteAlias: "Error org.bluez.Error: No such device or address".
> > Is it ok?
> 
> The GetAlias and RemoteAlias must become GetRemoteAlias. I spent some
> time thinking about it and after writing the first code for it, I
> actually realized that GetRemoteAlias and SetRemoteAlias methods and
> RemoteAliasChanged signal would be much better and cleaner.

I did all the needed changes and finally checked in a first draft
version of the D-Bus API document.

We now really need the dbus-test script working with the new API and I
think we also should write a bunch of regression tests for testing our
new API.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
