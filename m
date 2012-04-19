Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Apr 2012 23:16:06 -0300
From: Paulo Alcantara <pcacjr@zytor.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Subject: Re: [RFC v2 09/16] HoG: HID I/O driver
Message-ID: <20120419021606.GC1327@pcacjr.at.laptop>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
 <1334786904-26282-10-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1334786904-26282-10-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Wed, Apr 18, 2012 at 07:08:17PM -0300, João Paulo Rechi Vita wrote:
> @@ -188,6 +211,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>  		else
>  			DBG("\t %02x %02x", value[i], value[i + 1]);
>  	}
> +
> +	/* create UHID device */
> +	memset(&ev, 0, sizeof(ev));
> +	ev.type = UHID_CREATE;
> +	/* TODO: get info from DIS */
> +	strcpy((char*)ev.u.create.name, "bluez-hog-device");

Wouldn't the correct coding style for the cast be "char *" ?

-- 
-Paulo
