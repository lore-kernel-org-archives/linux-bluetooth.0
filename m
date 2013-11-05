Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 10:24:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/11] android/hid: Implement hid get protocol in daemon
Message-ID: <20131105082459.GA20907@x220.p-661hnu-f1>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383603615-9953-4-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383603615-9953-4-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013, Ravi kumar Veeramally wrote:
> This patch requests hid device protocol mode and reads reply
> message and sends notification to hal.
> ---
>  android/hal-msg.h |   9 +++++
>  android/hid.c     | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 113 insertions(+), 4 deletions(-)

I've applied patches 1 and 2, but from this one onwards there were
sevaral issues.

> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index f381862..214daa9 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -442,6 +442,8 @@ struct hal_ev_hid_conn_state {
>  	uint8_t state;
>  } __attribute__((packed));
>  
> +#define HAL_HID_STATUS_OK		0x00
> +
>  #define HAL_EV_HID_INFO			0x82
>  struct hal_ev_hid_info {
>  	uint8_t bdaddr[6];
> @@ -456,6 +458,13 @@ struct hal_ev_hid_info {
>  	uint8_t descr[884];
>  } __attribute__((packed));
>  
> +#define HAL_EV_HID_PROTO_MODE		0x83
> +struct hal_ev_hid_protocol {
> +	uint8_t bdaddr[6];
> +	uint8_t status;
> +	uint8_t mode;
> +} __attribute__((packed));

To be consistent, shouldn't the struct be called hal_ev_hid_proto_mode?

Also, I'd split this hal-msg.h update into a separate patch. Am I right
to assume hal-ipc-api.txt doesn't need updating for this one?

> @@ -76,6 +84,7 @@ struct hid_device {
>  	guint		intr_watch;
>  	int		uhid_fd;
>  	guint		uhid_watch_id;
> +	int		hid_msg;
>  };
>  
>  static int device_cmp(gconstpointer s, gconstpointer user_data)
> @@ -243,12 +252,74 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
>  	return FALSE;
>  }
>  
> +static void bt_hid_notify_protocol_mode(struct hid_device *dev, uint8_t *buf,
> +									int len)

To be consistent with the struct names you might use "proto" instead of
"protocol" here.

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
> +	switch (dev->hid_msg) {
> +	case HID_MSG_GET_PROTOCOL:
> +		bt_hid_notify_protocol_mode(dev, buf, bread);
> +		break;
> +	default:
> +		DBG("unhandled hid msg type 0x%02x", dev->hid_msg);
> +	}
> +
> +	/* reset msg type request */
> +	dev->hid_msg = -1;

Do we really need to do this tracking of what we wrote to the socket.
Isn't it possible to infer the type of procedure from the content of the
data that we read from the socket?

Johan
