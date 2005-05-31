Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] about rfcomm tty channel listening
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <429BCBD3.90205@avantwave.com>
References: <429B04EE.5070205@avantwave.com>
	 <1117471183.7072.192.camel@pegasus>  <429BCBD3.90205@avantwave.com>
Content-Type: text/plain
Message-Id: <1117524733.7072.239.camel@pegasus>
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
Date: Tue, 31 May 2005 09:32:13 +0200

Hi,

> >>    When i bind a rfcomm tty socket, Could i serve mulitple connections
> >>at the same time? And how about rfcomm raw socket? if the answer is no,
> >>that mean i need to open a new channel to listen.
> >>    Also , could i connect the rfcomm channel in the same computer?
> >
> >be more specific in what you are trying to do. I can't follow you.
> >
>     Sorry for my bad english, may be i describe more.
>     I am now writing a server program to accept 2 rfcomm connections. I
> found that it is not possible to accept 2 connections with same channel.
> Why i ask this because, in tcp socket, a server create a socket with
> e.g. 80 port. It can then accept multiple connections with the same port
> number. The behavior is different between channel and socket.
>     So, if i want to make multiple connections with rfcomm, i need to
> bind, listen and accept in another rfcomm socket. Does this thinking
> correct?

this works if the two client connections are from different devices. If
they are coming from the same device then this won't work and you need a
second server on a different channel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
