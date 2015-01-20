Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] mgmt-tester: Fix clang warning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421757693-17233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 20 Jan 2015 08:12:19 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6BCE6C2A-2063-40BE-A6EB-8B325992B3CD@holtmann.org>
References: <1421757693-17233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes clang warning below:
> ...
> tools/mgmt-tester.c:3805:2: warning: Value stored to 'id' is never read
>        id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING,
> data->mgmt_index,
>        ^
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> ...
> ---
> tools/mgmt-tester.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 92351e4..295fef5 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -3802,7 +3802,7 @@ static void setup_start_discovery(const void *test_data)
> 	uint16_t send_len = test->setup_send_len;
> 	unsigned int id = 0;
> 
> -	id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
> +	mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
> 			   discovering_event, UINT_TO_PTR(id), NULL);

this this is actually totally broken code. And not in the sense that clang reports it. You are not fixing the problem here. It is just masking the symptom.

Look into discovering_event callback and see what we do with the UINT_TO_PTR(0) that we are handing in. That code never did what the author was thinking it might do ;)

Regards

Marcel

