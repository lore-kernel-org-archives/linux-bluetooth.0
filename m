Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 9 Aug 2013 08:53:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <09231CA6-E5F3-453E-9479-68F08072893A@holtmann.org>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Kernel interface has evolved in between.
> ---
> tools/sco-tester.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 70b8a5d..1e8351f 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -237,7 +237,7 @@ static const struct sco_client_data connect_success = {
> };
> 
> static const struct sco_client_data connect_failure = {
> -	.expect_err = ECONNABORTED
> +	.expect_err = EOPNOTSUPP
> };

can we please have a proper thread on what error is appropriate to send from a socket interface when this situation happens. I see that we are flipping errors, but my request to discuss this gets ignored.

Please look for a good reference of the error code usage in other socket protocols or manpages

Regards

Marcel

