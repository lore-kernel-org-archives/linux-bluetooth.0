Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY107-F22A1A1C4932DC8BBF0358D80590@phx.gbl>
References: <BAY107-F22A1A1C4932DC8BBF0358D80590@phx.gbl>
Date: Sat, 29 Jul 2006 14:56:47 +0200
Message-Id: <1154177807.25939.13.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] FW: Re:  RfCOMM connection problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Julien,

> I am asking you this question because I am using a Bluez Rfcomm server.
> One SDK from Broadcom is available for free:
> 
> http://www.broadcom.com/products/bluetooth_sdk.php
> 
> 
> My question was about rfcomm layer and services and you guys seem to be 
> expert in bluetooth so you may have play around with bluetooth of ipaqs and 
> bluez servers...
> I read that it was not possible at all to use the microsoft API cause Ipacs 
> are using broadcom stack.
> 
> My problem may come from the security handshake...but I don't know how to 
> fix it.
> I though the security parameters should be set by the server but according 
> to the Broadcom specification...both client and server should set them.
> 
> The problem is that on the client side, using broadcom SDK, setting security 
> parameters requires a service name...that 's what i don't get. How to get a 
> service from the bluez server and must i use a service??
> A program in java on a sony ericsson works fine with your Bluez 
> server...only simple socket programming. I just want to do the same with my 
> ipac in C/C++

as I said, this is about Linux and I can't give you any help when it
comes to Programming with JSR-82, the Widcomm API or the Microsoft API,
because I simply don't use any of them.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
