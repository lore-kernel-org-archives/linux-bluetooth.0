Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 08:57:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] gattrib: Add support for listening for events
 for specific handles
Message-ID: <20121011065733.GB2223@x220.example.org>
References: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Oct 10, 2012, Vinicius Costa Gomes wrote:
> We want only the profile that implements a service to be notified of
> changes on that service. Before this patch, all the registered event
> notifiers are being called.
> ---
> Hi,
> 
> I am re-sending this series because, if it makes sense, it would be awesome
> if it gets the "UPF treatment".
> 
> Cheers,
> 
> 
>  attrib/client.c                    |  4 ++--
>  attrib/gattrib.c                   | 33 ++++++++++++++++++++++++++++-----
>  attrib/gattrib.h                   |  7 ++++---
>  attrib/gatttool.c                  |  8 ++++----
>  attrib/interactive.c               |  8 ++++----
>  profiles/gatt/gas.c                |  1 +
>  profiles/heartrate/heartrate.c     |  2 +-
>  profiles/input/hog_device.c        |  5 +++--
>  profiles/scanparam/scan.c          |  4 ++--
>  profiles/thermometer/thermometer.c |  2 ++
>  src/attrib-server.c                |  2 +-
>  11 files changed, 52 insertions(+), 24 deletions(-)

I went and applied this set too as it looks good. Thanks.

Johan
