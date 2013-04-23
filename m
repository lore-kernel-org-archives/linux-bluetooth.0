Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:51:04 -0300
From: Gutavo Padovan <gustavo@padovan.org>
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, andrei.emeltchenko@intel.com,
	akarwar@marvell.com, bzhao@marvell.com, zonque@gmail.com
Subject: Re: [PATCH v3 2/2] Bluetooth: btmrvl: report error if
 verify_fw_download times out.
Message-ID: <20130423235104.GF1697@joana>
References: <1366621823-10411-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1366621823-10411-3-git-send-email-andreas.fenkart@streamunlimited.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366621823-10411-3-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andreas,

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [2013-04-22 11:10:23 +0200]:

> FW does the synchronization of the different modules during init.
> It will report different modules, that it is ready at different times.
> The fw download 'winner' will be reported fw ready first. Without this
> patch, btmrvl was already continuing before the FW told it too. Probably
> on behalf of the 'winner' which then never sees FW ready and times out.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
