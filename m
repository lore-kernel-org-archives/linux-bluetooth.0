Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20031008175536.0241e658@unixmail.qualcomm.com>
To: "Christian Eiselt" <c.eiselt@gmx.de>,
   "bluez Dev" <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] hciconfig
In-Reply-To: <002401c3632a$5b9714b0$1ab91e8d@chris1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 08 Oct 2003 17:58:09 -0700

At 05:40 AM 8/15/2003, Christian Eiselt wrote:
>Hi,
> 
>I have some tests running on a usb dongle and between the tests I want to reset the dongle. I used <hciconfig hci0 reset> as reset, but I get <Cant't init device hci0. Connection time out (110).>
> 
>This error message occurs only on this special test, with others it works fine. Could this happen when <hciconfig hci0 reset> is called on a transmitting device?
> 
>Is there some other command to reset a usb dongle?

In older HCI implementation HCI_Reset used to reset USB transport even
though spec clearly states that it shouldn't. This may cases all sorts 
of problems. Looks like you got one of those dongle with buggy HCI 
implementation.

Max



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
