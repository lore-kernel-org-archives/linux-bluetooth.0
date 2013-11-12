Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:28:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hidhost: Fix uhid create failure case
Message-ID: <20131112132805.GE22931@x220.p-661hnu-f1>
References: <1384249639-10915-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384249639-10915-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 12, 2013, Ravi kumar Veeramally wrote:
> If uhid open or create fails then notify state and free the device.
> Otherwise it replies bogus success return value on connect request.
> ---
>  android/hidhost.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)

Applied. Thanks.

Johan
