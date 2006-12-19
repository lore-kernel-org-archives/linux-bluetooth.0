Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 17:31:26 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061219163126.GL7959@suse.de>
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
	<4587DAEC.8000603@glidos.net> <20061219153627.GJ7959@suse.de>
	<45880A1B.7030408@glidos.net>
MIME-Version: 1.0
In-Reply-To: <45880A1B.7030408@glidos.net>
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

On Tue, Dec 19, 2006 at 03:49:47PM +0000, Paul Gardiner wrote:
> Stefan Seyfried wrote:

> > Hm. It works for me. I have not configured anything via YaST, but just =
with
> > bluetooth-applet and apitest (in the bluez-test package).
> =

> I can try that: I still have the original config files I can put back in =

> place. Did you not use yast2 even to enable bluetooth?

I had the dongle plugged in during the installation, so bluetooth was
enabled by default. It should, however, just get enabled via udev when
the adapter is plugged in, even if nothing is configured.

But i did not configure anything besides "enable bluetooth" in YaST.

In 10.2, no matter how you configure it in YaST, the settings made via
DBus will override this, so no need to restore your config files IMO.
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
