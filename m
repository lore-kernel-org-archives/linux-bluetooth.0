Return-Path: <cyrus@holtmann.org>
Message-ID: <5224B48D.7090200@linux.intel.com>
Date: Mon, 02 Sep 2013 17:53:49 +0200
From: =?UTF-8?B?RnLDqWTDqXJpYyBEQUxMRUFV?=
	<frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?=
	<frederic.dalleau@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le 09/08/2013 17:42, Frédéric Dalleau a écrit :
> Kernel interface has evolved in between.
> ---
>   tools/sco-tester.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 70b8a5d..1e8351f 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -237,7 +237,7 @@ static const struct sco_client_data connect_success = {
>   };
>
>   static const struct sco_client_data connect_failure = {
> -	.expect_err = ECONNABORTED
> +	.expect_err = EOPNOTSUPP
>   };
>
>   static void client_connectable_complete(uint16_t opcode, uint8_t status,
>

Hello,

SCO sockets are now using EOPNOTSUPP.
What about these patches?

Thanks,
Frédéric

