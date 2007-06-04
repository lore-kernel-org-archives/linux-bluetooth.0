Return-Path: <hakauvoni@gmail.com>
Message-ID: <e96e9eeb0706040830p1d0ab00es249070ffece6b941@mail.gmail.com>
Date: Mon, 4 Jun 2007 18:30:54 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: marcel@holtmann.org
Subject: Re: [Bluez-users] hcid <-> dbus problem
Cc: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1180970355.13429.45.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e96e9eeb0706040653t2a6f8da5lbc7399932ff6fcbb@mail.gmail.com>
	 <1180970355.13429.45.camel@violet>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On 6/4/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > I can't run bluez in my platform. i tried this series of commands:
> > that last command doesn't work, i get:
> > Dec 31 18:48:16 8 daemon.info hcid[945]: Bluetooth HCI daemon
> > Dec 31 18:48:17 8 daemon.err hcid[945]: Could not become the primary
> > owner of org.bluez
> > Dec 31 18:48:17 8 daemon.err hcid[945]: Unable to get on D-Bus
> >
> > I even tried:
> > dbus-daemon --config-file /etc/dbus-1/system.d/bluetooth.conf
> >
> > but it fails with the message:
> > Failed to start message bus: Configuration file needs one or more
> > <listen> elements giving addresses
>
> this looks wrong. The bluetooth.conf is only one of the security rules
> used by dbus-daemon. You must make sure the compiled in paths are all
> correct. Ask the D-Bus guys for more help.

THANKS

indeed something with the paths went wrong. i don't know what, but i played
with the system.conf file a little and now it works. THANKS !!

i don't need to run a dbus daemon with the bluetooth.conf, right ?

(this line is not relevant: dbus-daemon --config-file
/etc/dbus-1/system.d/bluetooth.conf ?)

thank you
voni


>
> > (running sdpd alone does not fail btw)
>
> Of course, but sdpd is obsoleted.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
