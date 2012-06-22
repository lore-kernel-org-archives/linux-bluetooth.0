Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Jun 2012 18:36:47 -0300 (BRT)
Message-Id: <20120622.183647.436747592564051847.pcacjr@zytor.com>
To: jprvita@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 14/19] hog: Add support for uHID events
From: Paulo Alcantara <pcacjr@zytor.com>
In-Reply-To: <1340377687-4711-15-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
	<1340377687-4711-15-git-send-email-jprvita@openbossa.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@openbossa.org>
Date: Fri, 22 Jun 2012 12:08:02 -0300

> This patch adds the GLib GIOChannel watcher to monitor uhid events.
> ---
>  input/hog_device.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/input/hog_device.c b/input/hog_device.c
> index f58b16f..cd5d1bf 100644
> --- a/input/hog_device.c
> +++ b/input/hog_device.c
> @@ -53,6 +53,7 @@
>  
>  #define HOG_REPORT_MAP_UUID	0x2A4B
>  #define HOG_REPORT_UUID		0x2A4D
> +
>  #define UHID_DEVICE_FILE	"/dev/uhid"
>  
>  #define HOG_REPORT_MAP_MAX_SIZE        512
> @@ -71,6 +72,7 @@ struct hog_device {
>  	GSList			*reports;
>  	int			uhid_fd;
>  	gboolean		prepend_id;
> +	guint			uhid_watch_id;
>  };
>  
>  struct report {
> @@ -335,6 +337,36 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
>  	}
>  }
>  
> +static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	struct hog_device *hogdev = user_data;
> +	struct uhid_event ev;
> +	ssize_t bread;
> +	int fd;
> +
> +	if (cond & (G_IO_ERR | G_IO_NVAL))
> +		goto failed;
> +
> +	fd = g_io_channel_unix_get_fd(io);
> +	memset(&ev, 0, sizeof(ev));
> +
> +	bread = read(fd, &ev, sizeof(ev));
> +	if (bread < 0) {
> +		int err = errno;
> +		DBG("uhid-dev read: %s(%d)", strerror(err), err);

Since this does not seem to be a debug message but instead an error one,
shouldn't you use error() function here ?

Other than that the patch looks good to me.


		Paulo
