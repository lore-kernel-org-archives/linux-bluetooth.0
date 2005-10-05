Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Cannot send through serial device rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Wlaschin <robertw@healthhero.com>
Cc: "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CBBBD909D2D6D211B4700090273F9E6E04C49A6C@polaris.hhn.com>
References: <CBBBD909D2D6D211B4700090273F9E6E04C49A6C@polaris.hhn.com>
Content-Type: text/plain
Message-Id: <1128534858.5447.38.camel@localhost.localdomain>
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
Date: Wed, 05 Oct 2005 19:54:18 +0200

Hi Robert,

> much for the help thus far.  Yes the rfcomm0 device is created: 
> This is the output from rfcomm; rfcomm0: 00:A0:96:0D:3B:80 channel 1
> closed, I have also seen it report [tty-attached] when I am attempting
> to read/write/connect, but it says 'config' not 'open'
> 
> So, I saw this error message:
> 
> > HCI Event: Connect Complete (0x03) plen 11 
>     status 0x05 handle 41 bdaddr 00:A0:96:0D:3B:80 type ACL encrypt
> 0x00 
>     Error: Authentication Failure

this means that you provide the wrong link key. Delete all your link
keys or set the device into pairing mode.

> So I did this: hciconfig hci0 auth, but I still got the same error, so
> I followed with this: hciconfig hci0 encrypt, but I still seem to be
> getting the error message.

This is a misconception. What activated security mode 3 and this is not
helpful at all.

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
