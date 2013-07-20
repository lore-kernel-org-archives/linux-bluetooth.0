Return-Path: <cyrus@holtmann.org>
Date: Sat, 20 Jul 2013 09:10:59 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/8] Move device initialization and shutdown to
 tty_port_operations
Message-ID: <20130720071059.GA28216@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
 <1373661649-1385-3-git-send-email-gianluca@sottospazio.it>
 <51E5B196.7010704@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E5B196.7010704@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 16, 2013 at 04:48:22PM -0400, Peter Hurley wrote:
> >+static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
> >+{
> >+	DECLARE_WAITQUEUE(wait, current);
> >+	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
> >+	struct rfcomm_dlc *dlc = dev->dlc;
> >+	int err;
> >+
> >+	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
> >+	if (err < 0)
> >+		goto error_no_dlc;
> >+
> >+	/* Wait for DLC to connect */
> >+	add_wait_queue(&dev->wait, &wait);
> >+	while (1) {
> >+		set_current_state(TASK_INTERRUPTIBLE);
> >+
> 
> 
> >+		if (dlc->state == BT_CLOSED) {
> >+			err = -dev->err;
> >+			break;
> >+		}
> >+
> >+		if (dlc->state == BT_CONNECTED)
> >+			break;
> 
> Please consider moving these dlc->state tests into a
> .carrier_raised() port method (this is what the gsm
> driver does). Then this wait loop could go away.
> 

I have a question about this: how do I signal an error condition with
carrier_raised? In case of success I should also call some device_move,
rfcomm_tty_copy_pending and rfcomm_dlc_unthrottle. Could I do it in
carrier_raised directly?

Thanks,

Gianluca

> >+		goto error_no_connection;
> >+
> >+	device_move(dev->tty_dev, rfcomm_get_device(dev),
> >+	            DPM_ORDER_DEV_AFTER_PARENT);
> >+
> >+	rfcomm_tty_copy_pending(dev);
> >+	rfcomm_dlc_unthrottle(dlc);
> >+	return 0;
> >+
> >+error_no_connection:
> >+	rfcomm_dlc_close(dlc, err);
> >+error_no_dlc:
> >+	return err;
> >+}
