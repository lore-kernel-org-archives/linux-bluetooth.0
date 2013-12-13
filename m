Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Dec 2013 14:51:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sebastian <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] Adding missing test scripts to Makefile.tools
Message-ID: <20131213125118.GA25866@x220.p-661hnu-f1>
References: <1386880421-19461-1-git-send-email-sebastianx.chlad@intel.com>
 <1386880421-19461-2-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386880421-19461-2-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thu, Dec 12, 2013, Sebastian wrote:
> ---
>  Makefile.tools | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 78034f5..b306c34 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -289,6 +289,7 @@ test_scripts += test/sap_client.py test/bluezutils.py \
>  		test/test-thermometer test/test-profile test/test-health \
>  		test/test-health-sink test/service-record.dtd \
>  		test/service-did.xml test/service-spp.xml test/service-opp.xml \
> -		test/service-ftp.xml test/simple-player test/test-nap \
> +		test/opp-client test/service-ftp.xml test/ftp-client \
> +		test/simple-player test/test-nap \
>  		test/test-heartrate test/test-alert test/test-hfp \
> -		test/test-cyclingspeed
> +		test/test-cyclingspeed test/pbap-client test/map-client

Looks otherwise fine, but you'll need to fix your git author information
and resend. We're not going to have an entry in the git history simply
from someone called "Sebastian". It should also contain a last name.

Johan
