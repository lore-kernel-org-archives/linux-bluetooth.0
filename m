Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1183462763.4335.17.camel@localhost>
References: <1183412947.20815.7.camel@localhost>
	<1183433596.6351.25.camel@aeonflux.holtmann.net>
	<1183462763.4335.17.camel@localhost>
Date: Wed, 04 Jul 2007 03:48:26 +0200
Message-Id: <1183513706.6351.47.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Only one pand-daemon?
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

Hi Mats,

> > > I am facing the problem that I cannot start more than
> > > one listening pand-daemon, in spite of using two usb-dongles.
> > > The second call with 'pand --listen -e bdaddr ...' immediately
> > > ends with return value zero and no traces in any log file.
> > > I am running Bluez-utils 3.7 on Debiif test "$PAND_ENABLED" != "0"; then
>   
> > an Etch. Slowly I am 
> > > beginning to think that it could be DBUS that haunts me, but I
> > > have just begun studying the source code of pand to make sure.
> > 
> > I have no idea why you actually need two pand, but you can call pand
> > with -i hciX to bind it to a specific adapter.
> 
> 
> I need more than one Bluetooth radio, i.e. usb-dongle, each providing
> a NAP service, since I am not content with only seven clients in one
> piconet. Hence my belief was that I could simply start one pand-daemon
> for each dongle and have my system up and running.

by default pand listens on all attached dongles. So that should work out
of the box.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
