Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 20 Dec 2006 12:04:57 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061220110457.GC20278@suse.de>
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
	<4587DAEC.8000603@glidos.net> <20061219153627.GJ7959@suse.de>
	<45884A49.5040702@glidos.net> <20061220085414.GA18455@suse.de>
	<458904A1.5090508@glidos.net>
MIME-Version: 1.0
In-Reply-To: <458904A1.5090508@glidos.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Dec 20, 2006 at 09:38:41AM +0000, Paul Gardiner wrote:
 =

> The machine in question is a headless server. Also I keep all my
> config changes under CVS, and use CVS to do most of the work
> of configing a new machine (or upgrading a machine to a new
> version of opensuse).  I often use the GUI interfaces when first
> setting up something I've never used before, but once I
> have a reasonable set up, I like to break it down to config
> file changes so that I can reuse the settings easily. Admittedly
> this may not be common usage.

In this case, it is easy to script all this with dbus-send or apitest.
Just a script that sets up the machine and verifies the configuration
afterwards. Keep this script under version control and everything will
be fine :-)

> > If the procedure explained in /usr/share/doc/packages/bluez-utils/READM=
E.dund
> > does not work, please file a bugreport at bugzilla.novell.com so i can =
update
> > the documentation.
> =

> Ok thanks. I'm not sure I have read that before. That may help a lot.

If it does not work, let me know so that i can fix the documentation.

Have fun,

    Stefan

-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
