Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080822073628.GA5989@piper.oerlikon.madduck.net>
References: <20080822073628.GA5989@piper.oerlikon.madduck.net>
Date: Fri, 22 Aug 2008 10:33:35 +0200
Message-Id: <1219394015.7591.441.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO flowcontrol patch v4.4 on 2.6.25/6
	causes	hardlocks when	connecting to BT device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Martin,

> > I have just compiled a Debian 2.6.24 with the v4.4 patch: it applied
> > and compiled cleanly.
> > 
> > And it works most of the time with my BT500v headset (sco)! Thank
> > you for that.
> 
> So I used to have a working Bluetooth setup with 2.6.24, and it also
> still works. However, the kernel developers have moved on, and even
> though the sco-flowcontrol v4.4 patch applies to 2.6.25/6 as well
> [0], the resulting 2.6.25 and 2.6.26 kernels both freeze hard when
> I try to connect to the headset.
> 
> 0. http://bugs.debian.org/493098
> 
> Does anyone have an idea what could be going on? How can I help
> debug this? Is there a newer patch floating around somewhere?

what about not using that patch at all? I am using the new audio
interface without that patch. And you wanna use the btusb driver and
since 2.6.27-rc4 that one actually has SCO support.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
