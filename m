Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] HCI Errors
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0510201310w7b09bd32i30961f75a21b4bb3@mail.gmail.com>
References: <e1effdeb0510201310w7b09bd32i30961f75a21b4bb3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1129986557.11428.38.camel@blade>
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
Date: Sat, 22 Oct 2005 15:09:17 +0200

Hi Claudio,

> This patch makes possible create HCI D-Bus errors.
> 
> I removed the previous HCI errors code defined in "dbus.h", now I am 
> using the codes defined in the "hci.h" file.
> 
> In a near future it should be better move the error related functions 
> to another file or try implements internationalization.

I applied the patch. We can move the error stuff into a separate bunch
of files, but the internationalization shouldn't be part of a daemon.
This is pure application stuff.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
