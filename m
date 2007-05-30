Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f3i8fk$tfv$1@sea.gmane.org>
References: <f3ev58$iku$1@sea.gmane.org>
	<1180411455.21432.114.camel@aeonflux.holtmann.net>
	<f3i8fk$tfv$1@sea.gmane.org>
Date: Wed, 30 May 2007 09:31:59 +0200
Message-Id: <1180510319.21432.158.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Increasing HIDP_DEFAULT_MTU ?
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

Hi Pascal,

> > Actually we are not really supporting segmentation by ourself. If I had
> > one of the devices for testing, I might be able to fix that easily. Hint
> > hint :)
> 
> It's that wireless joystick from Sony.  Be sure to ask for the
> console that goes with it, it makes debugging much easier :-)

do you mean the controller that comes with the PS3?

> Note: when polled with HIDP_TRANS_GET_REPORT on the control channel,
> it does use DATC (unlike what happens on the interrupt channel).
> So maybe it would be a good platform for testing reassembly code.

Yes. We need to fix that.

> > I fixed the input service now. We will see how this works out. In
> > addition the 2.6.22-rc3 kernel contains a patch to fix a bug in the
> > L2CAP config handling.
> 
> Thanks; the device now works out-of-the box with ps3-linux 2.6.22-rc3
> and bluetoothd-service-input from bluez-utils-cvs (except I couldn't
> figure how the new authorization framework works, so I renamed
> /var/lib/bluetooth/*/hidd to /var/lib/bluetooth/*/input instead).

That can produce some strange settings. The input file format is a
little bit different than the hidd file format.

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
