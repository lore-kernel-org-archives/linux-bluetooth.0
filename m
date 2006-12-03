Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb0611280555m1aef46f5i33cd495290366daf@mail.gmail.com>
References: <e1effdeb0611280555m1aef46f5i33cd495290366daf@mail.gmail.com>
Date: Sun, 03 Dec 2006 15:00:45 +0100
Message-Id: <1165154445.19590.45.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [DBUS] Service - ListUsers and RemoveUser
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

Hi Claudio,

> I have another question about the service interface methods. We
> discussed a lot of stuff in the last meeting, but I don't remember
> exactly how some methods should work.
> 
> ListUsers is a method to retrieve the connected devices related to a
> specific service. How it is possible track the current connected
> remote devices? I guess it should be tracked inside the hcid without
> any interaction with the service agent, right?

it should be done in hcid without interaction of the service agents if
possible. Currently I have no idea on how we do this.

> RemoveUser removes a user of the service. If it is removed should it
> be automatically disconnected too?

This depends on. If it has no permission to use any other service then
it should be definitely disconnected.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
