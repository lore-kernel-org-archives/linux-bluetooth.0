Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 18:42:57 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061219174257.GN7959@suse.de>
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
	<4587DAEC.8000603@glidos.net> <20061219153627.GJ7959@suse.de>
	<45880A1B.7030408@glidos.net> <20061219163126.GL7959@suse.de>
	<4588201C.40702@glidos.net>
MIME-Version: 1.0
In-Reply-To: <4588201C.40702@glidos.net>
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

On Tue, Dec 19, 2006 at 05:23:40PM +0000, Paul Gardiner wrote:

> Does this look like a good indicator of the cause of my problems?:
> =

> # apitest GetMode
> Traceback (most recent call last):
>    File "/usr/bin/apitest", line 3, in <module>
>      import dbus
> ImportError: No module named dbus

No. Just install the dbus-1-python package.
(yes, i deliberately made bluez-test not depend on dbus-1-python, but
i will think again about that :-)
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
