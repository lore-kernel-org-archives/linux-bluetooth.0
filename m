Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 09:42:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: coekbe <coekbe@gmail.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Bug report: bluetoothd broken for a USB dongle since bluez 4.85
Message-ID: <20120426064220.GA14645@x220.P-661HNU-F1>
References: <CAK678xgXnf-bgBRGU+tyNdnUv4VoGM+XyH15W0jw8h3Wypi+_A@mail.gmail.com>
 <20120425194852.GB2781@joana>
 <CAK678xiBPbdnx=U4tV4Zj0=0vraU1RwyEpxe3W7fy7TA6gTqVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK678xiBPbdnx=U4tV4Zj0=0vraU1RwyEpxe3W7fy7TA6gTqVQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Thu, Apr 26, 2012, coekbe wrote:
> Perhaps the following is the correct patch (works with my device):
> 
> -----------------------------------------------------------------
> --- bluez-4.99/plugins/hciops.c.orig	2012-03-05 11:03:57.000000000 +0200
> +++ bluez-4.99/plugins/hciops.c	2012-04-26 06:38:53.105166053 +0300
> @@ -565,7 +565,7 @@ static void set_event_mask(int index)
>  	}
> 
>  	if (dev->features[3] & LMP_RSSI_INQ)
> -		events[4] |= 0x04; /* Inquiry Result with RSSI */
> +		events[4] |= 0x02; /* Inquiry Result with RSSI */
> 
>  	if (dev->features[5] & LMP_SNIFF_SUBR)
>  		events[5] |= 0x20; /* Sniff Subrating */
> -------------------------------------------------------------------
> 
> Above the code that I quoted there's another "event[4] |= 0x02" with the comment
> "Inquiry Result with RSSI". Surely it cannot be both 0x02 and 0x04?
> The bluetooth spec 1.2 suggests 0x02 is correct.

Yes, you're right. The correct value is 0x02 and 0x04 (which means "Read
Remote Extended Features Complete" that your dongle doesn't support).
I've pushed a patch to bluez.git to fix this and I'll also send a patch
in a minute for the kernel which will be needed when using mgmtops
instead of hciops.

Johan
