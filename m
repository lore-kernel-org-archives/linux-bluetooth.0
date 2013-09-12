Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Sep 2013 09:55:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Add missing include
Message-ID: <20130912065559.GA32432@x220.p-661hnu-f1>
References: <1378908208-17063-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378908208-17063-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Sep 11, 2013, Szymon Janc wrote:
> Bionic library requires explicit include for data types used in ioctl
> call. This fix following build error with bionic:
> 
> target  C: btmon <= external/bluetooth/bluez/monitor/display.c
> external/bluetooth/bluez/monitor/display.c: In function 'num_columns':
> external/bluetooth/bluez/monitor/display.c:59:18: error: storage size
>     of 'ws' isn't known
> ---
>  monitor/display.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
