Return-Path: <cyrus@holtmann.org>
Message-ID: <48D2417C.60301@suse.de>
Date: Thu, 18 Sep 2008 13:54:36 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200809152316.25937.dirk_vornheder@yahoo.de>
In-Reply-To: <200809152316.25937.dirk_vornheder@yahoo.de>
Subject: Re: [Bluez-users] bluez 4.6 and undefined symbols
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dirk Vornheder wrote:
> Hi !
> =

> After installing bluez 4.6 i get the following messages during boot
> =

> Sep 15 22:16:43 pcneu hcid[5034]: Bluetooth HCI daemon
> Sep 15 22:16:43 pcneu hcid[5034]: Starting SDP server
> Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: =

> /usr/lib/bluetooth/plugins/network.so: undefined symbol: device_get_path
> Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: =

> /usr/lib/bluetooth/plugins/service.so: undefined symbol: adapter_get_path
> Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: =

> /usr/lib/bluetooth/plugins/input.so: undefined symbol: device_get_path
> Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: =

> /usr/lib/bluetooth/plugins/serial.so: undefined symbol: device_get_path
> Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin: =

> /usr/lib/bluetooth/plugins/audio.so: undefined symbol: device_get_path
> Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 registered
> Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 up
> Sep 15 22:16:43 pcneu hcid[5034]: Device hci0 has been added
> Sep 15 22:16:43 pcneu hcid[5034]: Starting security manager 0

you are definitely not running 4.6, hcid is no longer present in 4.6.

Where did you get 4.6 from? You could try the builds from here:
http://download.opensuse.org/repositories/home:/seife:/bluez-4/openSUSE_11.=
0/
but I guess that you run into dependency hell on 11.0.
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

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
