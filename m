Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] O2 XDA mini and DUND
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <87fyt15a5b.fsf@secunet.de>
References: <20050823050058.8940.qmail@web35314.mail.mud.yahoo.com>
	 <87fyt15a5b.fsf@secunet.de>
Content-Type: text/plain
Message-Id: <1124786244.23599.146.camel@pegasus>
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
Date: Tue, 23 Aug 2005 10:37:24 +0200

Hi Sascha,

> I have some problems to configure DUN access for the XDA mini.  I use
> the description for the XDA II:
> 
> http://wiki.xda-developers.com/wiki/bluetoothnetworking
> 
> but it does not work at all.  If I understand it right the DUND should
> start the PPPD to enable the PPP handshake, but DUND reports only a
> timeout error (110) and a protocol error (71).  I could not find any
> DUND option to enable any debuging output.
> 
> The basic communication works.  I can search on each side each other
> and I can l2ping from my Debian system the XDA mini.
> 
> After this I tried HCIDUMP, but I dont understand the output.  How can
> I analyse this problem further?  Is anybody here able to read the
> HCIDUMP output?

looks like there is no service running on RFCOMM channel 1. Don't use
the sdptool call in the example, because dund can register the service
record by itself and then the channel number will match.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
