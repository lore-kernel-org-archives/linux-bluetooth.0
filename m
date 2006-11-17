Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0611171019o2c346e60o266251e5ea2a99ad@mail.gmail.com>
Date: Fri, 17 Nov 2006 13:19:00 -0500
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163758205.26965.1.camel@localhost>
MIME-Version: 1.0
References: <200611171357.25160.denis.kenzior@trolltech.com>
	<1163758205.26965.1.camel@localhost>
Subject: Re: [Bluez-devel] PATCH: handle unicode local device name
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

> the local device name is in UTF-8 and not unicode and we need to change
> to character 127 to not corrupt the storage format.

do you mean "not UCS-2" instead of "not unicode"?

-albert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
