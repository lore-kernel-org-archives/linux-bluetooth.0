Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY18-F204E0C80858C7BCEF24318D6880@phx.gbl>
References: <BAY18-F204E0C80858C7BCEF24318D6880@phx.gbl>
Date: Fri, 09 Jun 2006 09:06:11 +0200
Message-Id: <1149836771.6618.1.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SSL and L2CAP
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

Hi Ali,

> my question is similar to: 
> http://sourceforge.net/mailarchive/message.php?msg_id=7257931
> 
> I have an L2CAP application, and I was wandering if I could apply SSL to 
> L2CAP sockets?
> 
> I am new at SSL, my understand is that it should be working with most of the 
> socket types. However, my search for information led me to the link above 
> and there is no answer to it.

I never had to deal with SSL progamming in detail. So in general you can
do everything over L2CAP. However the L2CAP is a SOCK_SEQPACKET and not
a SOCK_STREAM like TCP. If you need a SOCK_STREAM you must use a RFCOMM
socket.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
