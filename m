Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <458904A1.5090508@glidos.net>
Date: Wed, 20 Dec 2006 09:38:41 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4587BB0E.2070909@glidos.net>
	<1166523629.29972.18.camel@violet>	<4587DAEC.8000603@glidos.net>
	<20061219153627.GJ7959@suse.de>	<45884A49.5040702@glidos.net>
	<20061220085414.GA18455@suse.de>
In-Reply-To: <20061220085414.GA18455@suse.de>
Subject: Re: [Bluez-users] hcid.conf seemingly ignored
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

Stefan Seyfried wrote:
> On Tue, Dec 19, 2006 at 08:23:37PM +0000, Paul Gardiner wrote:
>  
>> Ok, that works. It gives me a way, other than hciconfig, to make the 
>> device discoverable. Still a pity that hcid.conf isn't obeyed as in
>> opensuse 10.1. That was simpler for my set up.
> 
> Well, that's the price we are paying for progress.
> (and it escapes me how editing hcid.conf is easier than using
> bluetooth-applet once to set up the system :-))

The machine in question is a headless server. Also I keep all my
config changes under CVS, and use CVS to do most of the work
of configing a new machine (or upgrading a machine to a new
version of opensuse).  I often use the GUI interfaces when first
setting up something I've never used before, but once I
have a reasonable set up, I like to break it down to config
file changes so that I can reuse the settings easily. Admittedly
this may not be common usage.

>> The real problem now though, is whatever I do I can't get dund to
>> respond.  Its a shame this was all working reliable back with 10.1.
>> Now it looks like I'm not going to be able to get it going.
> 
> If the procedure explained in /usr/share/doc/packages/bluez-utils/README.dund
> does not work, please file a bugreport at bugzilla.novell.com so i can update
> the documentation.

Ok thanks. I'm not sure I have read that before. That may help a lot.

Cheers,
	Paul.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
