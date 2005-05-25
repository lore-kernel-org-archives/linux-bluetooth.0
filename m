Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Raw Sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <6951a38b05052510161e87e507@mail.gmail.com>
References: <6951a38b05052510161e87e507@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1117041739.12036.1.camel@pegasus>
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
Date: Wed, 25 May 2005 19:22:19 +0200

Hi Nuno,

> I'm writting from Portugal and I'm developing an application with
> bluez. This application's objective is to develop an program to
> receive data from several bluetooth devices and create a Data Base
> with that information. I need to use Raw Sockets, so I can create
> specific headers for the bluetooth packets.
>  
> Rigth now I'm having some problems using this raw sockets... So, I
> have some questions...
> 1 - How can I capture bluetooth packets using Raw Sockets?
>     I'm declaring sockets like this: socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)
>     Should it be diferent???
> 2 - What kind of structure do I need to use to manage the packets (in
> sockets tcp/ip we use specific structures to receive/send packets with
> the libpcap)
> 3 - Can I use read and write structures to send and receive the packets??

why do you resend your question? I already answered your first one.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
