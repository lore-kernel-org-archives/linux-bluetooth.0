Return-Path: <cyrus@holtmann.org>
Message-ID: <53A3DF4E.8030806@linux.intel.com>
Date: Fri, 20 Jun 2014 10:14:22 +0300
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] Initial implementation for MCAP data channel
References: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403107087-10539-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Ignore this patch set. I will send another one which supports
channel type_streaming also.

Thanks,
Ravi.

On 06/18/2014 06:58 PM, Ravi kumar Veeramally wrote:
> Patchset implements initial MCAP MDL creation and connection. On
> successful MDL connection fd will be passed to HAL.
>
> Ravi kumar Veeramally (3):
>    android/health: Check if device and channel already exists or not
>    android/health: Cache remote mdep id on channel connect request
>    android/health: Create and connect MDL
>
>   android/health.c | 317 +++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 282 insertions(+), 35 deletions(-)
>

