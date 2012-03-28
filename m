Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 13:18:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH V4 1/7] Parse config DeviceID string on bluetoothd startup
Message-ID: <20120328101847.GA471@x220>
References: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Mar 28, 2012, Szymon Janc wrote:
> Instead of parsing config DeviceID string on sdp server startup, parse
> it in main while reading config file. This allow to store logical DID
> values in main_opts (instead of raw config string) and make use of them
> in bluetoothd code.
> ---
>  src/hcid.h         |    6 +++++-
>  src/main.c         |   20 +++++++++++++++++---
>  src/sdpd-server.c  |   19 ++++---------------
>  src/sdpd-service.c |   20 +++++++++++---------
>  src/sdpd.h         |    5 ++---
>  5 files changed, 39 insertions(+), 31 deletions(-)

All seven patches have been applied. Thanks.

Johan
