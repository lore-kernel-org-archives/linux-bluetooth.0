Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 17:36:14 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061219163614.GM7959@suse.de>
References: <20061219155102.GK7959@suse.de> <1166544053.7309.7.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1166544053.7309.7.camel@violet>
Subject: Re: [Bluez-devel] hcid.conf options not honored after DBus API
	had	been used?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

On Tue, Dec 19, 2006 at 05:00:53PM +0100, Marcel Holtmann wrote:
 =

> > Any opinions? How is this handled on other distributions?
> =

> once you have values set through the D-Bus API they have priority and
> that is the only possible choice. The provided configuration options in
> hcid.conf are only default values for the distributions. No user should
> ever modify these values. This also means that YaST should no longer
> modify hcid.conf. Simply call the appropriate method via dbus-send.

Ok. How about shipping an empty hcid.conf with bluez-utils (or maybe
list the options, but comment them out) so everybody knows that "if you
touch anything here, you better know what you are doing"?

> In general you can have as many configuration tools as you want. The
> only small thing you need to take care of is to listen to signals for
> your settings, because another tool might change a value while you are
> running.

Yes, or just make all those dbus-send calls at once before exiting :-)
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
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
