Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Nov 2011 14:28:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add missing health test scripts to Makefile.tools
Message-ID: <20111125122823.GA23467@x220>
References: <1321974170-21111-1-git-send-email-jorge.fernandez.gonzalez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321974170-21111-1-git-send-email-jorge.fernandez.gonzalez@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jorge,

On Tue, Nov 22, 2011, Jorge Fernandez Gonzalez wrote:
> ---
>  Makefile.tools |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index c0a54d0..7fa4269 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -214,7 +214,7 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
>  		test/simple-service test/simple-endpoint test/test-audio \
>  		test/test-input test/test-attrib test/test-proximity \
>  		test/test-sap-server test/test-oob test/test-serial-proxy \
> -		test/test-thermometer \
> +		test/test-thermometer test/test-health test/test-health-sink \
>  		test/service-record.dtd test/service-did.xml \
>  		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
>  

Applied. Thanks.

Johan
