Return-Path: <cyrus@holtmann.org>
Date: Mon, 04 Aug 2008 18:22:33 +0200
From: "Wachendorf, Paul, 7P Consulting" <paul.wachendorf@7p-group.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <C4BCF969.1654%paul.wachendorf@7p-group.com>
In-Reply-To: <FC0BAE0E-DD24-4407-A94A-4EC9F380D89F@holtmann.org>
Mime-version: 1.0
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
Thanks for your quick answer.
Is there an other config file like hcid.conf? (I'm using version 3.30-1 of
libbluetooth2 from the debian reposetory at
http://bluez.sourceforge.net/download/debian).
Or should setting the device class work at hcid.conf?
I'm working on an test scenario and would be great if I'd be able to fully
simulate mobile Phones.

Regards,

Paul


Am 04.08.08 18:07 schrieb "Marcel Holtmann" unter <marcel@holtmann.org>:

> Hi Paul,
> =

>> I=B9m searching for an Dbus function to set the major device class of
>> an local bluetooth device, but I can=B9t find anything in the Dbus API.
>> Does someone know, if something like this exists? And if not, does
>> anybody know how can I change the lokal device class? Setting it in
>> the hcid.conf seems to do nothing
> =

> we decided to not do that and in the new D-Bus API, we don't allow
> class of device changes at all. The major and minor class of a device
> is a static value and thus should be set via a config file like
> hcid.conf.
> =

> Regards
> =

> Marcel
> =

> =

> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challe=
nge
> Build the coolest Linux based applications with Moblin SDK & win great pr=
izes
> Grand prize is a trip for two to an Open Source event anywhere in the wor=
ld
> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> =


-- =

Paul Wachendorf
Consultant
7P Consulting GmbH
Am Coloneum 6
50829 K=F6ln
Phone: +4922199379520
Mobil: +491622616456



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
