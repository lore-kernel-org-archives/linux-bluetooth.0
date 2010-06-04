Return-Path: <cyrus@holtmann.org>
Message-ID: <4C08BBFB.8060303@linux.intel.com>
Date: Fri, 04 Jun 2010 16:40:27 +0800
From: Zhu Yanhai <yanhai.zhu@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gateway_server_remove should unref audio_adapter
References: <1275639598-22048-1-git-send-email-yanhai.zhu@linux.intel.com> <20100604083043.GB2714@jh-x301>
In-Reply-To: <20100604083043.GB2714@jh-x301>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/04/2010 04:30 PM, Johan Hedberg wrote:
> Hi,
>
> On Fri, Jun 04, 2010, Zhu Yanhai wrote:
>> gateway_server_remove should unrefer the adapter, not refer it.
>>
>> Signed-off-by: Zhu Yanhai<yanhai.zhu@linux.intel.com>
>
> We don't use Signed-off-by in userspace BlueZ. I fixed it manually for
> you this time. Also try to start the summary line with "Fix ..." for any
> bugfixes (take a look at the upstream git how I changed it). With those
> commit message changes the patch has now been pushed upstream.
>
> Johan
>

Thank you Johan! I promise I will follow these next time :)

Regards,
Zhu Yanhai
