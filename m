Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: pghatwork@gmail.com
Subject: Re: [PATCH 2/9] mfd: Add char devices for the ST-Ericsson CG2900.
Date: Fri, 22 Oct 2010 17:49:37 +0200
Cc: linus.walleij@stericsson.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <AANLkTimzWPqHBSDyeoObAcxewg_adubgkt1KQYUmpBRA@mail.gmail.com>
In-Reply-To: <AANLkTimzWPqHBSDyeoObAcxewg_adubgkt1KQYUmpBRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010221749.37928.arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 22 October 2010 12:36:09 Par-Gunnar Hjalmdahl wrote:
> This patch adds char devices to the ST-Ericsson CG2900 driver.
> The reason for this is to allow users of CG2900, such as GPS, to
> be placed in user space.

Can you be more specific how you expect this to be used?

I guess you have hardware units that then each correspond to
one character device and can be talked to over a pseudo socket
interface, right?

For most devices (radio, audio, bluetooth, gps, ...), we already
have existing user interfaces, so how do they interact with this
one?

> +#define NAME					"CharDev "

?

> +/* Ioctls */
> +#define CG2900_CHAR_DEV_IOCTL_RESET		_IOW('U', 210, int)
> +#define CG2900_CHAR_DEV_IOCTL_CHECK4RESET	_IOR('U', 212, int)
> +#define CG2900_CHAR_DEV_IOCTL_GET_REVISION	_IOR('U', 213, int)
> +#define CG2900_CHAR_DEV_IOCTL_GET_SUB_VER	_IOR('U', 214, int)

These definitions look wrong -- you never use the ioctl argument...

> + *
> + * Returns:
> + *   Bytes successfully read (could be 0).
> + *   -EBADF if NULL pointer was supplied in private data.
> + *   -EFAULT if copy_to_user fails.
> + *   Error codes from wait_event_interruptible.
> + */
> +static ssize_t char_dev_read(struct file *filp, char __user *buf, size_t count,
> +			     loff_t *f_pos)

The same comment applies here that I made for the test interface:
Why is this not an AF_BLUETOOTH socket instead of a chardev?

Unless I'm mistaken, you actually send bluetooth frames after all.

> +	case CG2900_CHAR_DEV_IOCTL_RESET:
> +		if (!dev) {
> +			err = -EBADF;
> +			goto error_handling;
> +		}
> +		CG2900_INFO("ioctl reset command for device %s", dev->name);
> +		err = cg2900_reset(dev->dev);
> +		break;
> +
> +	case CG2900_CHAR_DEV_IOCTL_CHECK4RESET:
> +		if (!dev) {
> +			CG2900_INFO("ioctl check for reset command for device");
> +			/* Return positive value if closed */
> +			err = CG2900_CHAR_DEV_IOCTL_EVENT_CLOSED;
> +		} else if (dev->reset_state == CG2900_CHAR_RESET) {
> +			CG2900_INFO("ioctl check for reset command for device "
> +				    "%s", dev->name);
> +			/* Return positive value if reset */
> +			err = CG2900_CHAR_DEV_IOCTL_EVENT_RESET;
> +		}
> +		break;

Strange interface. Why do you need to check for the reset?

> +	case CG2900_CHAR_DEV_IOCTL_GET_REVISION:
> +		CG2900_INFO("ioctl check for local revision info");
> +		if (cg2900_get_local_revision(&rev_data)) {
> +			CG2900_DBG("Read revision data revision %d "
> +				   "sub_version %d",
> +				   rev_data.revision, rev_data.sub_version);
> +			err = rev_data.revision;
> +		} else {
> +			CG2900_DBG("No revision data available");
> +			err = -EIO;
> +		}
> +		break;
> +
> +	case CG2900_CHAR_DEV_IOCTL_GET_SUB_VER:
> +		CG2900_INFO("ioctl check for local sub-version info");
> +		if (cg2900_get_local_revision(&rev_data)) {
> +			CG2900_DBG("Read revision data revision %d "
> +				   "sub_version %d",
> +				   rev_data.revision, rev_data.sub_version);
> +			err = rev_data.sub_version;
> +		} else {
> +			CG2900_DBG("No revision data available");
> +			err = -EIO;
> +		}
> +		break;

These look like could better live in a sysfs attribute of the platform device.

	Arnd
