Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <448930F9.2080306@personnelware.com>
References: <44891608.2030906@personnelware.com>
	<1149836904.6618.4.camel@localhost>	<44892B25.6000309@personnelware.com>
	<1149840442.6618.16.camel@localhost>
	<448930F9.2080306@personnelware.com>
Date: Fri, 09 Jun 2006 10:40:17 +0200
Message-Id: <1149842417.6618.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PM325 by LG cell phone - pairing failed
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

Hi Carl,

> > So since you are not emulating a headset or handsfree unit, this is not
> > the way to go.
>
> arg - I was going to ask if it mattered which direction the pairing was 
> done for a given profile.  I guess it does.  Now to try the other direction.

for the pairing the direction doesn't matter all. You have a valid link
key and that is enough.

For using a service of your phone it does matter. If you wanna connect
to DUN for dialup into the Internet then you don't wanna play with the
headset support of your phone.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
