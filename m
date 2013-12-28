Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Dec 2013 09:44:21 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Benson Chow <blc+bluez@mail.vanade.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
Message-ID: <20131228084421.GA27196@sottospazio.it>
References: <52AA483E.4080706@ahsoftware.de>
 <20131215112413.GA8980@sottospazio.it>
 <52ADB6B7.5010503@hurleysoftware.com>
 <20131215150847.GA10288@sottospazio.it>
 <52AF55B4.6000303@hurleysoftware.com>
 <20131216202044.GA19746@sottospazio.it>
 <20131216202720.GB19746@sottospazio.it>
 <20131216205858.GA20119@sottospazio.it>
 <20131216211542.GA20419@sottospazio.it>
 <alpine.LNX.2.00.1312271536480.28992@doujima.vanade.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <alpine.LNX.2.00.1312271536480.28992@doujima.vanade.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2013 at 04:01:27PM -0700, Benson Chow wrote:
> First off, thanks for the fix to stop rfcomm from taking down the
> machine. However, I have noted that blueman and
> networkmanager/modemmanager no longer recognize the /dev/rfcomm0
> device as a valid dialup device.  This seems to be a
> kernel-userspace interface regression as I can boot into 3.6.11 and
> it would work just fine.
> 
> When I saw this thread, I agree there appears to be some
> kernel-userspace changes that broke something, but the recent patch
> still did not seem to let modemmanger detect the bluetooth device as
> it did pre linux-3.12.
> 
> Blueman reports "connection failed: modem manager did not support
> the connection" implying there's still some userspace differences
> from the old behavior.
> 
> I do notice I can run a terminal emulator on /dev/rfcomm0 and able
> to run modem AT-commands which means that I can communicate with the
> phone through bluetooth, so that part is working.  Plus, tearing up
> that connection no longer results in a crash like before linux-3.8.
> 
> Any other information I could get from my system to help debug
> what's going on here?  Or perhaps modem-manager will need to be
> updated to work with the new behavior?
> 
> Thanks,
> -Benson

Thank you for the report.

Could you try the attached patch on top of the last rfc3.patch and see if it
works?

Regards,
Gianluca

--KsGdsel6WgEHnImy
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="modman.patch"

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 0357dcf..90c1872 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -124,9 +124,6 @@ static void rfcomm_dev_shutdown(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 
-	if (dev->tty_dev->parent)
-		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
-
 	/* close the dlc */
 	rfcomm_dlc_close(dev->dlc, 0);
 }
@@ -577,9 +574,6 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 
 	dev->err = err;
 	if (dlc->state == BT_CONNECTED) {
-		device_move(dev->tty_dev, rfcomm_get_device(dev),
-			    DPM_ORDER_DEV_AFTER_PARENT);
-
 		wake_up_interruptible(&dev->port.open_wait);
 	} else if (dlc->state == BT_CLOSED)
 		tty_port_tty_hangup(&dev->port, false);
@@ -632,6 +626,9 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = tty->driver_data;
 
+	if (dev->tty_dev->parent)
+		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+
 	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	rfcomm_dlc_lock(dev->dlc);
@@ -674,6 +671,9 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (err)
 		rfcomm_tty_cleanup(tty);
 
+	device_move(dev->tty_dev, rfcomm_get_device(dev),
+		    DPM_ORDER_DEV_AFTER_PARENT);
+
 	/* take over the tty_port reference if it was created with the
 	 * flag RFCOMM_RELEASE_ONHUP. This will force the release of the port
 	 * when the last process closes the tty. This behaviour is expected by

--KsGdsel6WgEHnImy--
