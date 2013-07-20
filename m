Return-Path: <cyrus@holtmann.org>
Message-ID: <51EA9AA6.3000000@hurleysoftware.com>
Date: Sat, 20 Jul 2013 10:11:50 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 3/8] Move device initialization and shutdown to tty_port_operations
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-3-git-send-email-gianluca@sottospazio.it> <51E5B196.7010704@hurleysoftware.com> <20130720071059.GA28216@sottospazio.it>
In-Reply-To: <20130720071059.GA28216@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/20/2013 03:10 AM, Gianluca Anzolin wrote:
> On Tue, Jul 16, 2013 at 04:48:22PM -0400, Peter Hurley wrote:
>>> +static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
>>> +{
>>> +	DECLARE_WAITQUEUE(wait, current);
>>> +	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
>>> +	struct rfcomm_dlc *dlc = dev->dlc;
>>> +	int err;
>>> +
>>> +	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
>>> +	if (err < 0)
>>> +		goto error_no_dlc;
>>> +
>>> +	/* Wait for DLC to connect */
>>> +	add_wait_queue(&dev->wait, &wait);
>>> +	while (1) {
>>> +		set_current_state(TASK_INTERRUPTIBLE);
>>> +
>>
>>
>>> +		if (dlc->state == BT_CLOSED) {
>>> +			err = -dev->err;
>>> +			break;
>>> +		}
>>> +
>>> +		if (dlc->state == BT_CONNECTED)
>>> +			break;
>>
>> Please consider moving these dlc->state tests into a
>> .carrier_raised() port method (this is what the gsm
>> driver does). Then this wait loop could go away.
>>
>
> I have a question about this: how do I signal an error condition with
> carrier_raised?

Sorry Gianluca, I should have been more specific here.

There's no need to test for dlc->state == BT_CLOSED in carrier_raised().
At the point where port->carrier_raised is called, the tty will have been
linked with the file descriptor, so if the dlc->state goes to BT_CLOSED,
then rfcomm_dev_state_change() will call
   tty_hangup() -> driver hangup() -> tty_port_hangup() -> tty_port_shutdown()
This call chain will
   1. set the file_ops to hung_up_tty_fops which will cause tty_hung_up_p() to
      return true
   2. clear ASYNCB_INITIALIZED in port->flags
   3. wakeup port->open_wait

So an open() parked in the schedule loop of tty_port_block_til_ready()
will wake and exit the loop with either -EAGAIN or -ERESTARTSYS.

rfcomm_dev_state_change() should only do a wakeup on port->open_wait when
dlc->state == BT_CONNECTED.

> In case of success I should also call some device_move,
> rfcomm_tty_copy_pending and rfcomm_dlc_unthrottle. Could I do it in
> carrier_raised directly?

I wouldn't. That would be a nasty hack and a potential problem if a
signal occurred.

The device_move() isn't dependent on success, and can stay in .activate().

The rfcomm_tty_copy_pending() looks to me like a hack for a lack
of flow control when receiving data for the rfcomm_dev.
[Note how rfcomm_dev_data_ready() doesn't bother to test the return
value from tty_insert_flip_string().]

For simplicity, you could leave
	rfcomm_tty_copy_pending(dev);
	rfcomm_dlc_unthrottle(dlc);
in rfcomm_tty_open(), eg.:

	err = tty_port_open(&dev->port, tty, filp);
	if (err)
		return err;
	/*
	 * FIXME: rfcomm should use proper flow control for
	 * received data. This hack will be unnecessary and can
	 * be removed when that's implemented.
	 */
	rfcomm_tty_copy_pending(dev);
	rfcomm_dlc_unthrottle(dlc);
	return 0;

Regards,
Peter Hurley

>>> +		goto error_no_connection;
>>> +
>>> +	device_move(dev->tty_dev, rfcomm_get_device(dev),
>>> +	            DPM_ORDER_DEV_AFTER_PARENT);
>>> +
>>> +	rfcomm_tty_copy_pending(dev);
>>> +	rfcomm_dlc_unthrottle(dlc);
>>> +	return 0;
>>> +
>>> +error_no_connection:
>>> +	rfcomm_dlc_close(dlc, err);
>>> +error_no_dlc:
>>> +	return err;
>>> +}
