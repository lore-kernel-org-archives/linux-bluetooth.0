Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 10:29:55 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 11/11] android/hid: Handle uhid events
Message-ID: <20131105082843.GC18874@aemeltch-MOBL1>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1383603615-9953-12-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383603615-9953-12-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 05, 2013 at 12:20:15AM +0200, Ravi kumar Veeramally wrote:
> Handling few uhid events and described scenarios. OUTPUT and
> FEATURE events are not yet handled.
> ---
>  android/hid.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hid.c b/android/hid.c
> index 74de02f..fccaa87 100644
> --- a/android/hid.c
> +++ b/android/hid.c
> @@ -149,6 +149,11 @@ static void hid_device_free(struct hid_device *dev)
>  	g_free(dev);
>  }
>  
> +static void handle_uhid_event(struct hid_device *dev, struct uhid_event *ev)
> +{
> +	DBG("unsupported event");
> +}
> +
>  static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
>  							gpointer user_data)
>  {
> @@ -172,7 +177,40 @@ static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
>  	}
>  
>  	DBG("uHID event type %d received", ev.type);
> -	/* TODO Handle events */
> +
> +	switch (ev.type) {
> +	case UHID_START:
> +	case UHID_STOP:
> +		/* These are called to start and stop the underlying hardware.
> +		 * We open the channels before creating the device so the
> +		 * hardware is always ready. No need to handle these.
> +		 * The kernel never destroys a device itself! Only an explicit
> +		 * UHID_DESTROY request can remove a device. */
> +
> +		break;
> +	case UHID_OPEN:
> +	case UHID_CLOSE:
> +		/* OPEN/CLOSE are sent whenever user-space opens any interface
> +		 * provided by the kernel HID device. Whenever the open-count
> +		 * is non-zero we must be ready for I/O. As long as it is zero,
> +		 * we can decide to drop all I/O and put the device
> +		 * asleep This is optional, though. */
> +		break;
> +	case UHID_OUTPUT:
> +	case UHID_FEATURE:
> +		handle_uhid_event(dev, &ev);
> +		break;
> +	case UHID_OUTPUT_EV:
> +		/* This is only sent by kernels prior to linux-3.11. It
> +		 * requires us to parse HID-descriptors in user-space to
> +		 * properly handle it. This is redundant as the kernel
> +		 * does it already. That's why newer kernels assemble
> +		 * the output-reports and send it to us via UHID_OUTPUT. */
> +		DBG("Unsupported uHID event: type %d", ev.u.output_ev.type);

Use handle_uhid_event helper? You could add printing event type there.

Best regards 
Andrei Emeltchenko 

> +		break;
> +	default:
> +		warn("unexpected uHID event");
> +	}
>  
>  	return TRUE;
>  
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
