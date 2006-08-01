Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: thermal@o2.pl
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 1 Aug 2006 18:23:37 +0200
References: <200607312232.58278.thermal@o2.pl>
	<1154385676.4982.39.camel@aeonflux.holtmann.net>
In-Reply-To: <1154385676.4982.39.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Message-Id: <200608011823.37945.thermal@o2.pl>
Subject: Re: [Bluez-devel] [PATCH] inline keyword & ansi-C compilers
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

On wtorek, 1 sierpnia 2006 00:41, Marcel Holtmann wrote:
> Hi,
>
> > Recently when I`ve tried to compile KDE (ktnef to be exact) I came
> > upon an error in your include files:
>
> no idea what ktnef has to do with BlueZ. This seems to be the main
> problem here.
>

Yes, this may look a bit weird but ktnef is a part of the kdepim source 
bundle which contains addressbook, organizer, etc. and thus can make 
use of Bluetooth.

>
> #ifdef __STRICT_ANSI__
> #define inline
> #endif
>

You`re right, that will be much better.

-- 
|   ******* Maciek Grela RV409b *********
|        JID: thermal@jabber.wroc.pl
| Linux user #319794 ++ There is no spoon ...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
