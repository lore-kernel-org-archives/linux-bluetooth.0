Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0807170117q184cab4dk317fa92d04771b42@mail.gmail.com>
Date: Thu, 17 Jul 2008 11:17:19 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2A1E7937-4DA2-4B00-8EBD-10DC50269D54@gmail.com>
MIME-Version: 1.0
References: <e96e9eeb0807160834n6eb74e3dn133d7abfb333d07b@mail.gmail.com>
	<e378cfb20807170101iec7c9e5jfeb3aa1afe9e01e@mail.gmail.com>
	<2A1E7937-4DA2-4B00-8EBD-10DC50269D54@gmail.com>
Subject: Re: [Bluez-users] bluez-utils 3.36: Unable to get on D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

On Thu, Jul 17, 2008 at 11:06 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Another common cause of this error is that the user hasn't installed
> the D-Bus policy configuration for BlueZ into /etc/dbus-1/system.d
> (the hcid/bluetooth.conf file).

YES ! that was it. more or less. Actually I did have those files in
/etc/dbus-1/system.d, but I found out that my dbus used
/usr/etc/dbus-1/system.d for some reason (I cross compiled it with
--prefix=/usr). So I copied the files over there and voila it works. I
have no clue why it chose to work with /usr/etc instead of /etc
though.

Thank you all for the help!
Voni

>
> Johan
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
