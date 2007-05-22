Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46536A7D.7010500@access-company.com>
References: <464B36D4.80702@access-company.com>
	<1179666685.10069.250.camel@violet>
	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>
	<4653218D.3090504@access-company.com>
	<1179854658.9152.37.camel@aeonflux.holtmann.net>
	<46533F31.9090406@access-company.com>
	<1179868135.9152.39.camel@aeonflux.holtmann.net>
	<46536A7D.7010500@access-company.com>
Date: Wed, 23 May 2007 00:21:13 +0200
Message-Id: <1179872473.9152.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Fix for disconnection in new serial service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Frederic,

> >>>> What I want to do in my program is : ConnectService, open rfcomm, DisconnectService, than use file descriptor on rfcomm. Close rfcomm after, that should 
> >>>> disconnect the bluetooth connection.
> >>> that is not the the use case for ConnectService and DisconnectService.
> >>> It is as simple as that. What you want is more like the CreatePort
> >>> methods that create persistent RFCOMM bindings.
> >> Even if I change to : ConnectService, open rfcommX, use file descriptor on rfcommX, close rfcommX, DisconnectService 
> >> (that is a more classical use), the rfcommX connection is not released (and acl connection, until remote close it), as 
> >> serial service keep a file descriptor opened on the rfcommX device (no close on node->io).
> > 
> > that is the use case this is designed for. If this doesn't seem to work
> > than it actually looks like a bug. Can you provide further information
> > for Claudio so he can debug it.
> 
> To simply check this, I do :
> 
> - on remote, I create a SPP server :
>      frederic.danis@remote:~$ sdptool add --channel=5 sp
>      Serial Port service registered
>      frederic.danis@remote:~$ rfcomm listen 0 5
>      Waiting for connection on channel 5
> 
> - on local, I connect to remote using serial service :
>      ~ # dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez org.bluez.Manager.ActivateService string:serial
>      method return sender=:1.0 -> dest=:1.22
>         string ":1.19"

if the process goes away that called ConnectService() which is the care
here since dbus-send will exit from the system bus, the connection
should be automatically terminated. This is a meant to be cleanup of the
serial service.

>      ~ # dbus-send --system --type=method_call --print-reply --dest=:1.19 /org/bluez/serial org.bluez.serial.Manager.ConnectService string:00:01:02:03:04:05 
> string:spp
>      serial[1040]: /org/bluez/serial: org.bluez.serial.Manager.ConnectService()
>      serial[1040]: Connect in progress
>      serial[1040]: rfcomm_connect_cb: connected
>      serial[1040]: name_listener_add(:1.23)

Claudio, this is way to late to call name_listener_add(). You need to
call it during the method call actually.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
