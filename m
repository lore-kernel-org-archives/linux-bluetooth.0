Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD9C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B565220728
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="CSd7maIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgDWOmO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728478AbgDWOmN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:42:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7F5C08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:42:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so6479505ljg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjG8D4xc3qMlBNiEZsEZDVipk8eVcUA/4a7peYcMpng=;
        b=CSd7maImmdY/Dof1IBpRDkhCub9hRbUSfeCgsBCwR2KC/1z37TUqcwJUU8Oqbqtv9W
         vlOqle0H/VajnFqR0NqoGZppJaEXN7HJxTvgP9NzuWgT62DL9xcDzfRrSznPK8B+8g5Z
         cirDYHdoFRVdYwRBIIVFSZiiGTwLemU1W6pMqy28tZfov6alSYzULmsN1Jt+VJjKmgzV
         JTiQKfpbj+TqYicxnd6OiZnvdeNvrvUuZ7y0eizj/MUZwRBozgu7+t6b292U8yGJ87l9
         HMal49XGm8O0KHdiXgGEYiBw+244l8V/Y9XGXrOCGalI4fHEE5zrrqPpoe9NLtz0Bl4u
         pr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KjG8D4xc3qMlBNiEZsEZDVipk8eVcUA/4a7peYcMpng=;
        b=ldGql8f3WtUHzv9HnOMEz412LPhnytLLomqGQ4biYAIxCWekeqDj117lyNAbUVGrpe
         uFSDqB5NNEnikRbHWmuzlvj7vUO4H7cufY+jwhtLMWV12BQKfJrCxhL6eXnCIffudEvO
         so/qGrPM4sAWoKABeyOAu6xrNNGwalkvBsP8cUBgCtOaoQmXA377GO55FEL4SCztccW2
         pum9C2BUFr7zq6WnqpYUVzy4Nw4/iEB+5z9maVa+Uu67gLLNKnKY39xMJn8JMDmQ/sf4
         27hqxYS63yqHLlojmkvRaMMRIyAWEhFDF4PsaHmiHwrm+VHyfqvIW1RMj4/S9ik4rKKJ
         F6gw==
X-Gm-Message-State: AGi0PubtdcF/qPGiEaNiHghK7bqhdkl5sT0fr+IZr/A4xMRG1mtIXLo/
        ZC+fYFmAcV48mb/yBg+JwtIcCvidicQ=
X-Google-Smtp-Source: APiQypIaZCuWHKukpNOQGwx6MOZ3i5zk1fC9kKdEhYqe4d80kE1L6165Oqy9NhctAlIRIxY4qzRxXg==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr2713226ljj.214.1587652931027;
        Thu, 23 Apr 2020 07:42:11 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id r206sm1909533lff.65.2020.04.23.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:42:10 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org,
        Alain Michaud <alainm@chromium.org>
Cc:     Alain Michaud <alainm@chromium.org>
Subject: Re: [BlueZ PATCH v3] doc:Adding Roles property
Date:   Thu, 23 Apr 2020 16:42:09 +0200
Message-ID: <5347568.DvuYhMxLoT@ix>
Organization: CODECOUP
In-Reply-To: <20200423142305.66778-1-alainm@chromium.org>
References: <20200423142305.66778-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thursday, 23 April 2020 16:23:05 CEST Alain Michaud wrote:
> This change adds a new property to indicate the support for concurrent
> roles which means that the controller has reported the appropriate
> LE_Supported_States (hdev->le_states) and that the controller's driver
> has reported correctly handling the various reported states.
> ---
> 
>  doc/adapter-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index acae032d9..1a7255750 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -326,3 +326,11 @@ Properties	string Address [readonly]
> 
>  			Local Device ID information in modalias format
>  			used by the kernel and udev.
> +
> +		array{string} Roles [readonly]
> +
> +			List of supported roles. Possible values:
> +				"central": Supports the central role.
> +				"peripheral": Supports the peripheral 
role.
> +				"central-peripheral": Supports both 
roles
> +						      
concurrently.

If this is an array os strings why central-peripheral is needed?

-- 
pozdrawiam
Szymon Janc


