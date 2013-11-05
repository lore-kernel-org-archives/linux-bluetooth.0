Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 15:10:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 01/04] android/hid: Implement hid get protocol in
 daemon
Message-ID: <20131105131050.GA15228@x220.p-661hnu-f1>
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
> +static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
> +{
> +	struct hid_device *dev = data;
> +	int fd, bread;
> +	uint8_t buf[UHID_DATA_MAX];
> +
> +	DBG("");
> +
> +	fd = g_io_channel_unix_get_fd(chan);
> +	bread = read(fd, buf, sizeof(buf));
> +	if (bread < 0) {
> +		error("read: %s(%d)", strerror(errno), -errno);
> +		return TRUE;
> +	}
> +
> +	switch (dev->last_hid_msg) {
> +	case HID_MSG_GET_PROTOCOL:
> +		bt_hid_notify_proto_mode(dev, buf, bread);
> +		break;
> +	default:
> +		DBG("unhandled hid msg type 0x%02x", dev->last_hid_msg);
> +	}

This doesn't really make sense to me. If you only set last_hid_msg when
you send a code that you do support, then why would the value of
last_hid_msg ever contain a type that you do not support? (assuming you
always add an entry to this switch statement in the same patch that you
add a corresponding write for the type).

Also, since you don't seem to be using last_hid_msg for anything else
than printing this debug message, I'm wondering is there really any
value for it? Previously (based on our IRC) discussion I understood that
it had some actual functional value that helped determine what to send
to the HAL, but now I'm not seeing it anywhere in the patch. I might
have missed it though (in which case please enlighten me :)

Johan
