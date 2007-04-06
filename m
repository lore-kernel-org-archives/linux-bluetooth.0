Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 06 Apr 2007 06:18:17 +0200
From: "Harald Kubota" <hkubota@gmx.net>
In-Reply-To: <1175765581.5815.601.camel@violet>
Message-ID: <20070406041817.177760@gmx.net>
MIME-Version: 1.0
References: <20070404123836.132910@gmx.net> <1175765581.5815.601.camel@violet>
To: BlueZ users <bluez-users@lists.sourceforge.net>,
        bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] dfutool  - does not work for me
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

Marcel,

> However you might wanna check
> first with "hciconfig hci0 revision" that you dongle doesn't use a ROM
> chip. In that case DFU is not available.

hciconfig says:

Chip version: BlueCore4-ROM

I think that means it's not working. And it would explain why dfutool did not work at all.
Gotta find another one :-)

Harald (going to Akihabara today)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
