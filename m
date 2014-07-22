Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jul 2014 11:34:46 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: Update Android tests coverage
Message-ID: <20140722083446.GA26403@t440s.lan>
References: <1405949020-27462-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405949020-27462-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Jul 21, 2014, Jakub Tyszkowski wrote:
> One test case was not ported to new tester framework as it was
> considered invalid.
> ---
>  doc/test-coverage.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
> index 0da8321..e19e6c7 100644
> --- a/doc/test-coverage.txt
> +++ b/doc/test-coverage.txt
> @@ -53,7 +53,7 @@ Android end-to-end testing
>  
>  Application		Count	Description
>  -------------------------------------------
> -android-tester		  86	Android HAL interface testing
> +android-tester		  85	Android HAL interface testing
>  ipc-tester		  94	Android IPC resistance testing
>  			-----
>  			 180

It seems like you've forgotten to update the total count?

Johan
