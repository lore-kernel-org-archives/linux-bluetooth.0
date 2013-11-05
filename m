Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 15:12:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v3 02/04] android/hid: Implement hid set protocol in
 daemon
Message-ID: <20131105131232.GB15228@x220.p-661hnu-f1>
References: <1383654126-19237-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383654126-19237-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383654126-19237-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
>  static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
>  								uint16_t len)
>  {
> -	DBG("Not Implemented");
> +	struct hid_device *dev;
> +	GSList *l;
> +	bdaddr_t dst;
> +	int fd;
> +	uint8_t hdr[1];

If it's just one element there's no need for an array. Just use
"uint8_t hdr;" instead.

> +	hdr[0] = HID_MSG_SET_PROTOCOL | cmd->mode;

And then here hdr = ...;

> +	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
> +
> +	if (write(fd, hdr, sizeof(hdr)) < 0) {

And here &hdr, sizeof(hdr)

Johan
