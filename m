Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Raw Sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <6951a38b0505240932769defa9@mail.gmail.com>
References: <6951a38b0505240932769defa9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1116954412.30044.154.camel@pegasus>
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
Date: Tue, 24 May 2005 19:06:52 +0200

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
> 2 - What kind of structure do I need to use to manage the packets (in
> sockets tcp/ip we use specific structures to receive/send packets)
> 3 - Can I capture all the packets or just the packets sent to my
> bluetooth device??

what makes you think that you need raw sockets. I don't see any need for
it. Write a client/server application that communicates over L2CAP or
RFCOMM.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
