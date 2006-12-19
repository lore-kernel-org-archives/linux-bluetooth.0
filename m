Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170612190937r140a50c1ne378f6a84b7f31de@mail.gmail.com>
Date: Tue, 19 Dec 2006 14:37:34 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4588201C.40702@glidos.net>
MIME-Version: 1.0
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
	<4587DAEC.8000603@glidos.net> <20061219153627.GJ7959@suse.de>
	<45880A1B.7030408@glidos.net> <20061219163126.GL7959@suse.de>
	<4588201C.40702@glidos.net>
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

Hi Paul,

On 12/19/06, Paul Gardiner <osronline@glidos.net> wrote:
> Does this look like a good indicator of the cause of my problems?:
>
> # apitest GetMode
> Traceback (most recent call last):
>    File "/usr/bin/apitest", line 3, in <module>
>      import dbus
> ImportError: No module named dbus

No, I don't think so. We can only know that you don't have python
bindings for dbus installed on your system. You have to install a
package that is probably named dbus-python or something alike.

Regards,

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
