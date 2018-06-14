Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 14 Jun 2018 22:35:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] bluetooth: fix paring problems with 0cf3:0036 and
 certain devices
Message-ID: <20180614203500.GA7182@x1c>
References: <20180614193330.28410-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614193330.28410-1-andreas@kemnade.info>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreas,

On Thu, Jun 14, 2018, Andreas Kemnade wrote:
> This is clearly a RFC patch, things should be fixed in a cleaner way.
> With the bluetooth usb adapter 0cf3:0036 (Atheros), there are pairing
> problems in combination with certain remove devices. The cause is that
> smp_resume_cb() gets called after SMP_CMD_IDENT_INFO arrives in the end 
> of a SC pairing with numerical comparison. so that there are unexpected
> packet messages in dmesg and although an ltk is known, bluetoothd
> considers the device as unpaired and not even the ltk is not stored.
> 
> The patch makes the smp code be more tolerant with the order but that
> does not feel like a safe thing to do.
> Maybe the pairing result should be given back to userspace without the
> irk related stuff.

This sounds like the well known race between ACL data and HCI events
that's inherent with the way the USB HCI transport is designed. So
what's happening is that to the host it looks like some packets were
delivered over an unencrypted connection even though they in reality
came over an encrypted one. Not enforcing the encrypted connection
requirement is not really a solution since it creates a security
vulnerabilty. The best option (as far as I know) is to consider
switching to some other transport (e.g. H:4 over USB where both ACL data
and HCI events share a single "pipe").

Johan
