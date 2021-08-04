Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599F760F35
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhHDOx6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDOx5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:53:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D876C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 07:53:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e5so2889113ljp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4/SR+tNoaY+zWisNJvOD5v/HEgyWuAof+ThEqgK440=;
        b=gV6FGkcNlPejaRm2HMj1chpNFeVRapDYUCTj2l6IGgERnAxBIw3my3gWwbh9ZdoOzR
         W+DKcCEH3cWiI9nJDeWd2o9xWDUiP2RFwOMg29THW5qdTogVTuO3AsojXEkLo9pcasEM
         9yoi5PItuhyIOxHojDxYNqV9pKJUlKy2XlxsHA4D3P5KEoKqu59sNwkSFXYrfWOoRDl2
         tymwl+D15CGnjUdQ/jKAiGMPnxpzuREDXhUPd76E00ZN9W4mbEfgHgONYyQU2nKOOXEo
         q2TYC/n0synpsTbbpuGZGJkgOuFV3nXjolJv2PM2jmjn3Qxzgoe1QrtSzJmmQjkub8fZ
         Vhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=x4/SR+tNoaY+zWisNJvOD5v/HEgyWuAof+ThEqgK440=;
        b=lSaAcvt1txwqcHwD2kOAuVQRdA0jO7KeI+gVO7a47/5RqSObxq778zwBS3LMHtWck/
         3RdRT4pZFCnK08wg/eLPNuA3/kveMCrjcZFHe/gGWk0QSEP8gxTebxaBwoyfklwUdIxA
         C15Pw912OVdCYqlHnerryR+lW76P+1arKiyIRorvcNP9LEACR6TmLvVN/Bvoacjnbnzk
         RWKvWjgKiBMvYGeIcNJh6fAGwAdKn4PkOc+8llgTuUbyBqox5iKof/IzI7k30mwcR6mB
         k+RXPBa9ty/7BCPGfpqdMt1gDq0xxzxr1mZZVTITD710wfrf5b62voaKOLOBKQKSpyU0
         VLiQ==
X-Gm-Message-State: AOAM531/wTckOj5PB3s1wHM9NVgj9iGxWRr75g6pHbNN2OWek/wLMvL4
        SYtQ+Dr55/r0ulaHiLYpWK2BHfmSwY3HGA==
X-Google-Smtp-Source: ABdhPJzxn+vfX+Uav71+VMdYVHhXbHbOsEm9hztyQVzmlhmfh0finiwwTNrpisKI/XxHMaR4NDCXWw==
X-Received: by 2002:a2e:a80f:: with SMTP id l15mr18867470ljq.354.1628088823450;
        Wed, 04 Aug 2021 07:53:43 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id e6sm218454lfs.268.2021.08.04.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:53:42 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        Mariusz Skamra <mariusz.skamra@codecoup.pl>
Cc:     Mariusz Skamra <mariusz.skamra@codecoup.pl>
Subject: Re: [PATCH v2] monitor: Fix truncated server socket path parameter
Date:   Wed, 04 Aug 2021 16:53:41 +0200
Message-ID: <2592179.mvXUDI8C0e@ix>
Organization: CODECOUP
In-Reply-To: <20210804105446.556937-1-mariusz.skamra@codecoup.pl>
References: <20210804085937.541076-1-mariusz.skamra@codecoup.pl> <20210804105446.556937-1-mariusz.skamra@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Mariusz,

On Wednesday, 4 August 2021 12:54:46 CEST Mariusz Skamra wrote:
> This fixes the issue of --server <socket> parameter
> last character was dropped. There is no need to use
> strncpy, as the length is already checked, and it is
> known that the destination buffer is big enough
> ---
>  monitor/control.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/control.c b/monitor/control.c
> index d1ba97d37..266602a34 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -1165,14 +1165,12 @@ static int server_fd = -1;
>  void control_server(const char *path)
>  {
>  	struct sockaddr_un addr;
> -	size_t len;
>  	int fd;
> 
>  	if (server_fd >= 0)
>  		return;
> 
> -	len = strlen(path);
> -	if (len > sizeof(addr.sun_path) - 1) {
> +	if (strlen(path) > sizeof(addr.sun_path) - 1) {
>  		fprintf(stderr, "Socket name too long\n");
>  		return;
>  	}
> @@ -1187,7 +1185,7 @@ void control_server(const char *path)
> 
>  	memset(&addr, 0, sizeof(addr));
>  	addr.sun_family = AF_UNIX;
> -	strncpy(addr.sun_path, path, len - 1);
> +	strcpy(addr.sun_path, path);
> 
>  	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>  		perror("Failed to bind server socket");

Patch applied, thanks.

-- 
pozdrawiam
Szymon Janc


