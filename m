Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <eljkhc$d94$1@sea.gmane.org>
References: <eljkhc$d94$1@sea.gmane.org>
Date: Mon, 11 Dec 2006 21:53:06 +0100
Message-Id: <1165870386.20733.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Support for Intellimouse for bluetooth
	in	mainline kernel
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

Hi Nicolas,

> Is there any chance to see support for Microsoft Intellimouse Explorer
> for Bluetooth integrated in mainline, with better support than "Boot
> protocol" ? It has been supported for years by -mh and should be mature
> enough to be proposed for mainline, isn't it ? I'm pretty sure many
> users would enjoy that.

actually we just split the HID parser into a independent subsystem, but
the HIDP code hasn't been adjusted to use it right now. Feel free to
send in a patch to do so.

> BTW, any plan for a 2.6.19-mh ? ;)

Don't know. Maybe when I have a little bit more free time.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
