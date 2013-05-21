Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 May 2013 12:36:09 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Shuah Khan <shuah.kh@samsung.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuahkhan@gmail.com
Subject: Re: [PATCH rebased] Bluetooth: Add missing reset_resume dev_pm_ops
Message-ID: <20130521153609.GC1829@joana>
References: <1369150326-4476-1-git-send-email-shuah.kh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369150326-4476-1-git-send-email-shuah.kh@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shuah,

* Shuah Khan <shuah.kh@samsung.com> [2013-05-21 09:32:06 -0600]:

> Add missing reset_resume dev_pm_ops. Missing reset_resume results in the
> following message after power management device test. This change sets
> reset_resume to btusb_resume().
> 
> [ 2506.936134] btusb 1-1.5:1.0: no reset_resume for driver btusb?
> [ 2506.936137] btusb 1-1.5:1.1: no reset_resume for driver btusb?
> 
> Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
