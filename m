Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Oct 2010 18:16:27 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	marcel@holtmann.org
Subject: Re: Downstream patches
Message-ID: <20101027221627.GA24756@jh-x301>
References: <1288202527.30124.107.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288202527.30124.107.camel@novo.hadess.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Oct 27, 2010, Bastien Nocera wrote:
> 0001-systemd-install-systemd-unit-files.patch installs a systemd unit,
> which, when systemd is used, replaces the udev rule to launch
> bluetoothd. This was pretty heavily tested as part of the alpha for
> Fedora 14, though systemd was not included in the end.
> 
> This patch is used in Fedora 15 now.

I'll let Marcel comment on this since IIRC he had previously some issues
with systemd related patches.

> 0002-build-Fix-parallel-build.patch fixes a parallel build problem I
> encountered on my machine, running "make -j8".

This one has been pushed upstream. Thanks.

Johan
