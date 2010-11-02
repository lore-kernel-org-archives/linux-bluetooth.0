Return-Path: <cyrus@holtmann.org>
Subject: Re: Downstream patches
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20101027221627.GA24756@jh-x301>
References: <1288202527.30124.107.camel@novo.hadess.net>
	 <20101027221627.GA24756@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Nov 2010 16:39:43 +0100
Message-ID: <1288712383.3322.182.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > 0001-systemd-install-systemd-unit-files.patch installs a systemd unit,
> > which, when systemd is used, replaces the udev rule to launch
> > bluetoothd. This was pretty heavily tested as part of the alpha for
> > Fedora 14, though systemd was not included in the end.
> > 
> > This patch is used in Fedora 15 now.
> 
> I'll let Marcel comment on this since IIRC he had previously some issues
> with systemd related patches.

I still have the systemd patches in my queue. I wanna do some proper
cleanup to move over to systemd full scale. And just remove everything
else from the source repository and the packages.

Regards

Marcel


