Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Apr 2015 11:31:03 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Eyal Reizer <eyalreizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, Eyal Reizer <eyalr@ti.com>,
	Pavan Savoy <pavan_savoy@ti.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add tty HCI driver
Message-ID: <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk>
In-Reply-To: <1430380089-2395-1-git-send-email-eyalr@ti.com>
References: <1430380089-2395-1-git-send-email-eyalr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 30 Apr 2015 10:48:09 +0300
Eyal Reizer <eyalreizer@gmail.com> wrote:

> tty_hci driver exposes a /dev/hci_tty character device node, that intends
> to emulate a generic /dev/ttyX device that would be used by the user-space
> Bluetooth stacks to send/receive data to/from the WL combo-connectivity
> chipsets.

We have an in kernel bluetooth stack, why do we care about this - how
will people test and debug driver interactions with binary only bluetooth
stacks in userspace ?

That aside

Either

- Use the tty layer to provide your interface with a correct "emulation",

or

- Don't pretend to be a tty device in the first place

Your code behaviour is nothing like a tty or indeed much like anything
else sane.

> +int hci_tty_open(struct inode *inod, struct file *file)
> +{
> +	int i = 0, err = 0;
> +	unsigned long timeleft;
> +	struct ti_st *hst;
> +
> +	pr_info("inside %s (%p, %p)\n", __func__, inod, file);
> +
> +	hst = kzalloc(sizeof(*hst), GFP_KERNEL);
> +	file->private_data = hst;
> +	hst = file->private_data;

Just crashed if you ran out of memory


> +		pr_debug("waiting for registration completion signal from ST");
> +		timeleft = wait_for_completion_timeout
> +			(&hst->wait_reg_completion,
> +			 msecs_to_jiffies(BT_REGISTER_TIMEOUT));
> +		if (!timeleft) {
> +			pr_err("Timeout(%d sec),didn't get reg completion signal from ST",
> +			       BT_REGISTER_TIMEOUT / 1000);
> +			err = -ETIMEDOUT;
> +			goto error;

Without de-registering stuff ?

 +
> +/** hci_tty_read Function
> + *
> + *  Parameters :
> + *  @file  : File pointer for BT char driver
> + *  @data  : Data which needs to be passed to APP
> + *  @size  : Length of the data passesd
> + *  offset :
> + *  Returns  Size of packet received -  on success
> + *           else suitable error code
> + */
> +ssize_t hci_tty_read(struct file *file, char __user *data, size_t size,
> +		     loff_t *offset)
> +{
> +	int len = 0, tout;
> +	struct sk_buff *skb = NULL, *rskb = NULL;
> +	struct ti_st	*hst;
> +
> +	pr_debug("inside %s (%p, %p, %u, %p)\n",
> +		 __func__, file, data, size, offset);
> +
> +	/* Validate input parameters */
> +	if ((NULL == file) || (((NULL == data) || (0 == size)))) {
> +		pr_err("Invalid input params passed to %s", __func__);
> +		return -EINVAL;
> +	}

Why ... if they are broken here then the kernel is already crashed.

> +
> +	hst = file->private_data;
> +
> +	/* cannot come here if poll-ed before reading
> +	 * if not poll-ed wait on the same wait_q
> +	 */
> +	tout = wait_event_interruptible_timeout(hst->data_q,
> +						!skb_queue_empty(&hst->rx_list),
> +						msecs_to_jiffies(1000));
> +	/* Check for timed out condition */
> +	if (0 == tout) {
> +		pr_err("Device Read timed out\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* hst->rx_list not empty skb already present */
> +	skb = skb_dequeue(&hst->rx_list);
> +	if (!skb) {
> +		pr_err("dequed skb is null?\n");
> +		return -EIO;
> +	}
> +
> +#ifdef VERBOSE
> +	print_hex_dump(KERN_INFO, ">in>", DUMP_PREFIX_NONE,
> +		       16, 1, skb->data, skb->len, 0);
> +#endif
> +
> +	/* Forward the data to the user */
> +	if (skb->len >= size) {
> +		pr_err("FIONREAD not done before read\n");
> +		return -ENOMEM;

Even if the user did an FIONREAD this wouldn't work with two threads.
ENOMEM is a nonsense return for it
The semantics of read/write on a tty are not those you have implemented
You don't want to allow users to fill the log with error messages


> +	}
> +	/* returning skb */
> +	rskb = alloc_skb(size, GFP_KERNEL);
> +	if (!rskb)
> +		return -ENOMEM;
> +
> +	/* cb[0] has the pkt_type 0x04 or 0x02 or 0x03 */
> +	memcpy(skb_put(rskb, 1), &skb->cb[0], 1);
> +	memcpy(skb_put(rskb, skb->len), skb->data, skb->len);
> +
> +	if (copy_to_user(data, rskb->data, rskb->len)) {
> +		pr_err("unable to copy to user space\n");

Same problem with error messages

> +		/* Queue the skb back to head */
> +		skb_queue_head(&hst->rx_list, skb);

You've just re-ordered your list if threaded


> +/** hci_tty_ioctl Function
> + *  This will peform the functions as directed by the command and command
> + *  argument.
> + *
> + *  Parameters :
> + *  @file  : File pointer for BT char driver
> + *  @cmd   : IOCTL Command
> + *  @arg   : Command argument for IOCTL command
> + *  Returns  0 on success
> + *           else suitable error code
> + */
> +static long hci_tty_ioctl(struct file *file,
> +			  unsigned int cmd, unsigned long arg)
> +{
> +	struct sk_buff *skb = NULL;
> +	int		retcode = 0;
> +	struct ti_st	*hst;
> +
> +	pr_debug("inside %s (%p, %u, %lx)", __func__, file, cmd, arg);
> +
> +	/* Validate input parameters */
> +	if ((NULL == file) || (0 == cmd)) {
> +		pr_err("invalid input parameters passed to %s", __func__);
> +		return -EINVAL;
> +	}

More nonsense validation
> +
> +	hst = file->private_data;
> +
> +	switch (cmd) {
> +	case FIONREAD:
> +		/* Deque the SKB from the head if rx_list is not empty
> +		 * update the argument with skb->len to provide amount of data
> +		 * available in the available SKB +1 for the PKT_TYPE
> +		 * field not provided in data by TI-ST.
> +		 */
> +		skb = skb_dequeue(&hst->rx_list);
> +		if (skb) {
> +			*(unsigned int *)arg = skb->len + 1;

arg is in userspace is it not - if so you've just added some interesting
holes because you should be using the proper user access functions.

> +			/* Re-Store the SKB for furtur Read operations */
> +			skb_queue_head(&hst->rx_list, skb);

Re-ordering problems again here.

> +		} else {
> +			*(unsigned int *)arg = 0;
> +		}
> +		pr_debug("returning %d\n", *(unsigned int *)arg);
> +		break;
> +	default:
> +		pr_debug("Un-Identified IOCTL %d", cmd);
> +		retcode = 0;
> +		break;
> +	}
> +
> +	return retcode;
> +}
> +
> +/** hci_tty_poll Function
> + *  This function will wait till some data is received to the hci_tty driver from ST
> + *
> + *  Parameters :
> + *  @file  : File pointer for BT char driver
> + *  @wait  : POLL wait information
> + *  Returns  status of POLL on success
> + *           else suitable error code
> + */
> +static unsigned int hci_tty_poll(struct file *file, poll_table *wait)
> +{
> +	struct ti_st	*hst = file->private_data;
> +	unsigned long mask = 0;
> +
> +	pr_debug("@ %s\n", __func__);
> +
> +	/* wait to be completed by st_receive */
> +	poll_wait(file, &hst->data_q, wait);
> +	pr_debug("poll broke\n");

Why "broke" ?

> +
> +	if (!skb_queue_empty(&hst->rx_list)) {
> +		pr_debug("rx list que !empty\n");
> +		mask |= POLLIN;	/* TODO: check app for mask */
> +	}
> +

Alan
