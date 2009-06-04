Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Jun 2009 23:21:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zygo Blaxell <zygo.blaxell@xandros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add test-network to dist
Message-ID: <20090604202108.GA16595@jh-x301>
References: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com> <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zygo,

On Thu, Jun 04, 2009, Zygo Blaxell wrote:
> diff --git a/test/Makefile.am b/test/Makefile.am
> index a9247a0..12d560a 100644
> --- a/test/Makefile.am
> +++ b/test/Makefile.am
> @@ -44,7 +44,7 @@ INCLUDES = -I$(top_srcdir)/common
>  EXTRA_DIST = apitest hsplay hsmicro bdaddr.8 dbusdef.py monitor-bluetooth \
>  		list-devices test-discovery test-manager test-adapter \
>  		test-device test-service test-serial test-telephony \
> -		simple-agent simple-service  service-record.dtd \
> +		test-network simple-agent simple-service  service-record.dtd \
>  		service-did.xml service-spp.xml service-opp.xml service-ftp.xml
>  
>  MAINTAINERCLEANFILES = Makefile.in

This one has been pushed upstream. Thanks.

Johan
