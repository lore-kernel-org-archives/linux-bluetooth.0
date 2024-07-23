Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BB13B2B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731214; cv=none; b=bqRb6I8DG/4iqQvIpP8pQ0O0sSufep5nagIktoS6ani2kBjEnW99o8+HwWhIV3XTCMcTvZ2PqbhxVXaH+WvtME3BkdnsXYlY4AGtweviTiNR1Ol30dTBnwLB/i/GFW7pAN3oqxx2y/jii/vZkvC0FdbKr6UqgdW0mEwpMMBYfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731214; c=relaxed/simple;
	bh=FhAKlwl7ytdL+2ZuktS/lWlN1t+0MIpregn5n+U+2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEiwhaJ3oj675Tpl2pmgtTt2mb3v4++R5pCU0LYWcpSxl05eKD5jNBxCCtjszDd4lU56hz7RGlGvL47flbJqJFWcRP/xbu4buDj0fz/SgAp4rGmII3FrT3fROWYMH6/TeOPa0v5Z+vJupHMNe/oxaszZkwbA7iUw+pUUoGujPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 910B061E5FE01;
	Tue, 23 Jul 2024 12:40:02 +0200 (CEST)
Message-ID: <7c427210-24ad-4769-9c11-aaebe9656cec@molgen.mpg.de>
Date: Tue, 23 Jul 2024 12:40:02 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: obexd: Add system bus support for obexd
To: quic_dgangire@quicinc.com
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com, linux-bluetooth@vger.kernel.org
References: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Damodar,


Thank you for your patch.

Am 23.07.24 um 09:54 schrieb quic_dgangire@quicinc.com:
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>

Is your last named spelled in camel case?

> Currently obexd uses session bus.
> Distros  where session bus is not supported and still obex profiles
> are required in that case use system bus instead of session bus
> which can be configured with new optional feature
> 
> Additional optional feature has been added to achieve this
> with name --enable-use-systembus-for-obexd
> 
> steps to configure system bus
> ./configure --enable-use-systembus-for-obexd
> 
> If this optional option is approved  will add other patches
> on how to use system bus based on this option

This paragraph does not belong into the commit message.

> ---
>   Makefile.obexd | 14 ++++++++++++++
>   configure.ac   |  9 +++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/Makefile.obexd b/Makefile.obexd
> index b7e9f2d33..87432cc37 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -2,6 +2,19 @@
>   if OBEX
>   
>   if SYSTEMD
> +
> +if USE_SYSTEMBUS_FOR_OBEXD
> +
> +systemdsystemunit_DATA += obexd/src/obex.service
> +dbussystembus_DATA += obexd/src/org.bluez.obex.service
> +
> +obexd-add-service-symlink:
> +	$(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
> +
> +obexd-remove-service-symlink:
> +	rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
> +else
> +
>   systemduserunitdir = $(SYSTEMD_USERUNITDIR)
>   systemduserunit_DATA = obexd/src/obex.service
>   
> @@ -13,6 +26,7 @@ obexd-add-service-symlink:
>   
>   obexd-remove-service-symlink:
>   	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
> +endif
>   else
>   obexd-add-service-symlink:
>   obexd-remove-service-symlink:
> diff --git a/configure.ac b/configure.ac
> index d31eb1656..cc9a55f4c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -283,6 +283,15 @@ if (test "${enable_obex}" != "no"); then
>   fi
>   AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
>   
> +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
> +		[enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
> +if (test "${enable_use_systembus_for_obexd}" = "yes"); then
> +	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
> +else
> +	AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
> +fi
> +
>   AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
>   		[enable BTP client]), [enable_btpclient=${enableval}])
>   AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")

It would be nice to see the whole picture. Is it just for creating and 
placing the systemd units in the right place?


Kind regards,

Paul
