Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703310111m6c21fda1g45495830909c91d9@mail.gmail.com>
References: <ddea76ce0703310111m6c21fda1g45495830909c91d9@mail.gmail.com>
Date: Sat, 31 Mar 2007 15:34:15 +0200
Message-Id: <1175348055.5815.239.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BlueZ API, HID profile, socket programming
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Meenakshi,

> I am developing for the Nokia 770 - the idea is to use the PDA as a
> mouse to
> control another bluetooth-enabled PC.
> At this point I have opened a socket via L2CAP (Logical Link Control
> and
> Adaptation Protocol). How do I test if the socket is working? 
> I am sorry if this is a stupid question but I am new to linux,C and
> socket
> programming :(

you have to implement the HID device part (not provided by BlueZ at the
moment). So you have to have two listen sockets on PSM 17 and 19 and you
need the appropriate SDP service record that contains the HID descriptor
and other HID related settings. Check the HID specification for more
details.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
