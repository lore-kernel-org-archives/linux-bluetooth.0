Return-Path: <cyrus@holtmann.org>
Message-Id: <FC0BAE0E-DD24-4407-A94A-4EC9F380D89F@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <C4BCF1CC.164D%paul.wachendorf@7p-group.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Date: Mon, 4 Aug 2008 18:07:14 +0200
References: <C4BCF1CC.164D%paul.wachendorf@7p-group.com>
Subject: Re: [Bluez-users] Dbus Function to Set the Major Device Class
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Paul,

> I=92m searching for an Dbus function to set the major device class of  =

> an local bluetooth device, but I can=92t find anything in the Dbus API.
> Does someone know, if something like this exists? And if not, does  =

> anybody know how can I change the lokal device class? Setting it in  =

> the hcid.conf seems to do nothing

we decided to not do that and in the new D-Bus API, we don't allow  =

class of device changes at all. The major and minor class of a device  =

is a static value and thus should be set via a config file like  =

hcid.conf.

Regards

Marcel


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
