Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
From: Marcel Holtmann <marcel@holtmann.org>
To: Tetsuo Shiraishi <tetsu@s-direct.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
References: <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
	 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
	 <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
Content-Type: text/plain
Message-Id: <1089481271.13519.71.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 10 Jul 2004 19:41:11 +0200

Hi Tetsuo,

> >what kind of peer is this? Why don't you try to fix the problem in the
> >peer device? The BlueZ RFCOMM part is working correct.
> 
> The peer is a device for data gathering using DUN + PPP.
> 
> I think so, but that device is not our product.
> I cannot fix it.
> (It takes long time to fix the problem...)

then buy another one, because the behavior of that device is wrong.

> The followings is more detailed testing operations.
> 
> 1 - I start the application.
>     - DUN listen

you should have mentioned that, because dund creates a /dev/rfcommX
device node for starting PPP. Maybe there is a leftover, which leaves
the DLC open and so the session can't be terminated. Maybe a running
pppd holds the socket descriptor open.

But I won't have time to look into that in detail. If you provide me a
patch for dund or for the kernel RFCOMM part, I will review it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
