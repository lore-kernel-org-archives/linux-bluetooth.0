Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 8 Jan 2007 20:47:01 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070108184701.GA12689@jh-mbp>
References: <200701081837.04388.dgollub@suse.de>
MIME-Version: 1.0
In-Reply-To: <200701081837.04388.dgollub@suse.de>
Subject: Re: [Bluez-devel] Should hcid wait for dbus daemon?
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

Hi Daniel,

On Mon, Jan 08, 2007, Daniel Gollub wrote:
> If the hcid would wait for the dbus daemon this wouldn't be a problem. At 
> least hcid can handle a dbus daemon restart, maybe we can enhance this.

Sounds like a useful feature. It should be quite simple to implement too 
since most of the required code already exists due to the dbus restart 
detection support. Feel free to provide a patch for it :)

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
