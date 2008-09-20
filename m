Return-Path: <cyrus@holtmann.org>
From: Dirk Vornheder <dirk_vornheder@yahoo.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 20 Sep 2008 20:23:40 +0200
References: <200809152316.25937.dirk_vornheder@yahoo.de>
	<48D2417C.60301@suse.de> (sfid-20080919_183851_469491_21C6D798)
In-Reply-To: <48D2417C.60301@suse.de>
MIME-Version: 1.0
Message-Id: <200809202023.40270.dirk_vornheder@yahoo.de>
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
Errors-To: bluez-users-bounces@lists.sourceforge.net


> > After installing bluez 4.6 i get the following messages during boot
> >
> > Sep 15 22:16:43 pcneu hcid[5034]: Bluetooth HCI daemon
> > Sep 15 22:16:43 pcneu hcid[5034]: Starting SDP server
> > Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin:
> > /usr/lib/bluetooth/plugins/network.so: undefined symbol: device_get_path
> > Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin:
> > /usr/lib/bluetooth/plugins/service.so: undefined symbol: adapter_get_pa=
th
> > Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin:
> > /usr/lib/bluetooth/plugins/input.so: undefined symbol: device_get_path
> > Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin:
> > /usr/lib/bluetooth/plugins/serial.so: undefined symbol: device_get_path
> > Sep 15 22:16:43 pcneu hcid[5034]: Can't load plugin:
> > /usr/lib/bluetooth/plugins/audio.so: undefined symbol: device_get_path
> > Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 registered
> > Sep 15 22:16:43 pcneu hcid[5034]: HCI dev 0 up
> > Sep 15 22:16:43 pcneu hcid[5034]: Device hci0 has been added
> > Sep 15 22:16:43 pcneu hcid[5034]: Starting security manager 0
>
> you are definitely not running 4.6, hcid is no longer present in 4.6.
>
> Where did you get 4.6 from? You could try the builds from here:
> http://download.opensuse.org/repositories/home:/seife:/bluez-4/openSUSE_1=
1.
>0/ but I guess that you run into dependency hell on 11.0.

Compile bluez 4.6 from source and using new init-script solved my problem.

Dirk


	=

		=

___________________________________________________________ =

Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail=
: http://mail.yahoo.de


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
