Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Nov 2009 13:33:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Susanne Goldammer <susanne.goldammer@gmx.de>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
Message-ID: <20091113113335.GA18325@jh-x301>
References: <4AF9721B.3010405@gmx.de>
 <1257861916.10888.1372.camel@localhost.localdomain>
 <4AF97659.2050807@gmx.de>
 <4AFBD3B6.6020706@gmx.de>
 <20091112131357.1106213e@strolchi.home.s3e.de>
 <4AFC05BD.40508@gmx.de>
 <20091112140840.1efa7475@strolchi.home.s3e.de>
 <4AFC1803.2080703@gmx.de>
 <1258037845.2158.0.camel@localhost.localdomain>
 <4AFC26C3.50006@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AFC26C3.50006@gmx.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Susanne,

On Thu, Nov 12, 2009, Susanne Goldammer wrote:
> Fixed. New patch attached.

The patch looks good except for two more white-space issues:

> +static gboolean option_runsdp = TRUE;
> +
>  
> static guint last_adapter_timeout = 0;

No need to add another extra line here (in general there shouldn't be a
need to have two consequtive empty lines almost anywhere in the source).

> +	if (option_runsdp == TRUE) 

It looks like this has an extra space at the end before the newline
character.

Additionally, could you please create a patch using git format-patch so
that it can be applied using git am and you get proper credit for it
(through the author field). Thanks.

Johan
