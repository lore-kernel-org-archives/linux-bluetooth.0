Return-Path: <cyrus@holtmann.org>
From: Smriti GUPTA <smriti.gupta@stericsson.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Naresh-kumar GUPTA <naresh.gupta@stericsson.com>,
	"smritigupta2008@gmail.com" <smritigupta2008@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 23 Jan 2012 06:25:00 +0100
Subject: RE: [RFC BlueZ 1/1] Add provision for terminating an ATT connection
Message-ID: <7E02D43720E46647A0E6521055937EC915DAF597A0@EXDCVYMBSTM005.EQ1STM.local>
References: <1324894570-15226-1-git-send-email-smriti.gupta@stericsson.com>
 <1324894570-15226-2-git-send-email-smriti.gupta@stericsson.com>
 <7E02D43720E46647A0E6521055937EC915DAF58D0F@EXDCVYMBSTM005.EQ1STM.local>
 <20120119075718.GA17465@x220.P-661HNU-F1>
In-Reply-To: <20120119075718.GA17465@x220.P-661HNU-F1>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: Thursday, January 19, 2012 1:27 PM
To: Smriti GUPTA
Cc: Naresh-kumar GUPTA; smritigupta2008@gmail.com; linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 1/1] Add provision for terminating an ATT connection

Hi,

On Thu, Jan 19, 2012, Smriti GUPTA wrote:
> Do you have any comments on the below patch.

Sure,

> --- a/src/device.c
> +++ b/src/device.c
> @@ -2880,3 +2880,17 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>  
>  	return TRUE;
>  }
> +
> +void att_disconnect(struct btd_device *device)
> +{
> +	GIOChannel *io;
> +
> +	if (!device)
> +		return;
> +
> +	io = g_attrib_get_channel(device->attrib);
> +	if (io) {
> +		g_io_channel_shutdown(io, FALSE, NULL);
> +		g_io_channel_unref(io);
> +	}
> +}
> diff --git a/src/device.h b/src/device.h
> index 13005ae..bd14315 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -119,3 +119,4 @@ int device_block(DBusConnection *conn, struct btd_device *device,
>  						gboolean update_only);
>  int device_unblock(DBusConnection *conn, struct btd_device *device,
>  					gboolean silent, gboolean update_only);
> +void att_disconnect(struct btd_device *device);

I don't think any separate function like this should be needed. Instead,
the existing device_request_disconnect() function should be extended
take care of bringing down any ATT connections.
Thanks for your suggestions.
I have uploaded a new patch, please have a look.

Johan

Regards,
Smriti
