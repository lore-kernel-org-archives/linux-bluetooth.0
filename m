Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:28:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hidhost: Fix error handling issue incase of
 G_IO_HUP
Message-ID: <20131112132817.GF22931@x220.p-661hnu-f1>
References: <1384261515-28725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384261515-28725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 12, 2013, Ravi kumar Veeramally wrote:
> Incase of G_IO_HUP on GIOCondtion when hid device disconnected,
> GIOCondition is combination of G_IO_IN and G_IO_HUP. Current code
> tries to read as soon as it finds G_IO_IN in condition.
> Apparently there is no data to read and loop continues.
> ---
>  android/hidhost.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan
