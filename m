Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050202045415.51412.qmail@web60910.mail.yahoo.com>
References: <20050202045415.51412.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107322449.9276.13.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 02 Feb 2005 06:34:09 +0100

Hi Michael,

>     Acutally, this project is just related to
> bluetooth. I've seen your reply, and then got through
> rctest.c. I found that the part of receiving mobile
> exists. Then I wish to know need I include the
> rctest.c file in my main program with which header
> files include in it? Or need I put the part in my
> program? And about the part you said that is the
> socket program, I wish to know is it ok if I just put
> it in my main program with which header files include
> in it? And as I need to accept all mobile, not the one
> that the address has been set in the program, to
> connect with PC and then access the program, how can I
> do to make sure that my wish is possible? Thank you
> very much.

you need to include the listen part, because this one gives you a socket
descriptor for the incoming connection in the end. From this descriptor
you can read() and write(). If you wanna accept only specific devices
then use getpeername() to get its address after they connected to you.
You can then decide what to do. If you don't like that device simple
close the connection.

The rctest.c is an example of how to do it. Don't include things that
you don't understand. For using RFCOMM it is enough to include the
bluetooth.h and rfcomm.h header files.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
