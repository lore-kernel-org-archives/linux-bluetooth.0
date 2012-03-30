Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 13:14:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH] Makefile: Add simple-player and test-nap
Message-ID: <20120330101410.GA9564@x220>
References: <1333030461-28221-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333030461-28221-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Mar 29, 2012, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> ---
> Hi,
> 
> it seems that these two scripts are missing in the list
> of test scripts. 
> 
> cheers,
> daniel
> 
>  Makefile.tools |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index f997a3f..7a8be0e 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -222,7 +222,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
>  		test/test-sap-server test/test-oob test/test-serial-proxy \
>  		test/test-thermometer test/test-health test/test-health-sink \
>  		test/service-record.dtd test/service-did.xml \
> -		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
> +		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
> +		test/simple-player test/test-nap
>  
>  
>  if HIDD

This doesn't apply to current git:

Applying: Makefile: Add simple-player and test-nap
error: patch failed: Makefile.tools:222
error: Makefile.tools: patch does not apply
Patch failed at 0001 Makefile: Add simple-player and test-nap

Could you also add "to EXTRA_DIST" to the commit message to make it
clear what's being done. Thanks.

Johan
