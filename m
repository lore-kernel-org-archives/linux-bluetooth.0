Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <448A8FC7.5010401@free.fr>
References: <447B4F98.8020501@free.fr>
	<1148934839.31689.116.camel@localhost> <447C4862.5050205@free.fr>
	<1149189300.28511.61.camel@localhost> <448733E2.7090602@free.fr>
	<1149712246.22472.56.camel@localhost> <4489AA6C.7010300@free.fr>
	<1149884263.3985.10.camel@aeonflux.holtmann.net>
	<448A8FC7.5010401@free.fr>
Date: Sun, 11 Jun 2006 00:22:19 +0200
Message-Id: <1149978140.5358.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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

Hi Fabien,

> > We might leave the socket for now. The alternative is a character device
> > or directly an ALSA sound card. Haven't fully thought about it either.
> 
> For the ALSA sound card, this is basically what snd-bt-sco does. The 
> issue with this alternative, is that the headset&handsfree profile 
> mandates the use of an RFCOMM channel before to use SCO. Doing this at 
> kernel level will mean that SCO layer will be dependant on RFCOMM 
> sockets, or that user space will have to handle RFCOMM channel before to 
> open ALSA device. This is roughly the way btsco works today. The result 
> is not very pretty :-(

except that we don't would use the SCO socket interface in the kernel
like the current snd-bt-sco is doing. And yes, we would need an extra
configuration channel, because using AT commands the kernel is not an
option at all.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
