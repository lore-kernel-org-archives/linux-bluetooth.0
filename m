Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY1-F3A6B25F16373653CE3514C1BF0@phx.gbl>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Bluez-users] OBEX: obex_test
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 01 Dec 2004 16:20:47 +0000

Hello!

I have some problems with obex_test.

I add the OPUSH with "sdptool add opush"  in server and client.

the channel of the Obex object push is 4.

In server side I write:
obex_test -b 00:11:22:33:44:55 4
s

In the client side I write:
obex_test -b 99:88:77:66:55:44 4
c

And then, in client side appears this message:
"Transport connect error! (Bluetooth)"

The Hcidump in the client show this:

>HCI Event: Command Status (0x0f) plen 4
>HCI Event: Connect Complete (0x03) plen 11
>HCI Event: Command Complete (0x0e) plen 6
>HCI Event: Command Status (0x0f) plen 4
>HCI Event: Disconn Complete (0x05) plen 4

The Hcidump in the server show:

>HCI Event: Connect Request (0x04) plen 10
>HCI Event: Command Status (0x0f) plen 4
>HCI Event: Connect Complete (0x03) plen 11
>HCI Event: Command Complete (0x0e) plen 6
>HCI Event: Command Status (0x0f) plen 4
>HCI Event: Disconn Complete (0x05) plen 4


why occurs this?

thanks.
Regards.

_________________________________________________________________
Descarga gratis la Barra de Herramientas de MSN 
http://www.msn.es/usuario/busqueda/barra?XAPID=2031&DI=1055&SU=http%3A//www.hotmail.com&HL=LINKTAG1OPENINGTEXT_MSNBH



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
