Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 16:24:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix test-attrib not being listed in EXTRA_DIST
Message-ID: <20101111142437.GA17777@jh-x301>
References: <1289484528-23630-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289484528-23630-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 11, 2010, Luiz Augusto von Dentz wrote:
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -191,7 +191,8 @@ EXTRA_DIST += test/apitest test/hsplay test/hsmicro test/dbusdef.py \
>  		test/test-network test/simple-agent test/simple-service \
>  		test/simple-endpoint test/test-audio test/test-input \
>  		test/service-record.dtd test/service-did.xml \
> -		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
> +		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
> +		test/test-attrib
>  
>  
>  if HIDD

Pushed upstream after fixing to group this together with the rest of the
test scripts.

Johan
