Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E5C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FE72051A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="VlfPf1mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392214AbgAPSW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:22:26 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42242 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391385AbgAPSWP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 13:22:15 -0500
Received: by mail-lj1-f178.google.com with SMTP id y4so23748725ljj.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9KBfRM7eXnfM9NUuk/am9M5VHWFYz5dwmwZDCNcMWEo=;
        b=VlfPf1mHzunZjCjZ7NVXXg/Z4N799y90f2h2QfCVnQGMIJukD7BnAtJhR9BEI+WfEP
         1lrCZ/e82IcnHL6GxS3MJpO5TfLXIvLVonci4ynBEhjvY9BRB+JZEwIh6vp3fZ3rf6z7
         e4p3gr4Lde4Swuth/BGgAgRDEq6NVgHYyPsfrHPw0EI2cL+a5/5PRG6X8FYIVD8reJIa
         PHUxvkXI+5KfCHVmDwrZHoalO+0+RVyWg+eq7bAj34XZIAi5BSBKarP/gX2d3wUzVmHj
         aH/zKJhmfqqMpOQwdGpEpjGEVmcGpu3BugM/wJrPqG0nJXJ04N/sYgjTxXW+DZV75P21
         ncNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9KBfRM7eXnfM9NUuk/am9M5VHWFYz5dwmwZDCNcMWEo=;
        b=QgsU+CL7KmqpHCecI65FVtFnAWsH0X6Xq8dzK+acG6K9ZaRG8pBmTbOt3XsicaKIqE
         GAxMkpHRYOvXG10r3ZDJsfEduXQCwTNMZKNvZwbxb+PlT6/heEvsB1hptTqrd4+/NVGx
         rX4/g7FAcyWGZ1HDMlPflKEe6bGJYtlqGqkt3rPBhIqrEQJlQDhtnfT/noAcULE0rWQV
         DuSEchkY3eQ5D6vsr15RZV3N4tstDpj1HHJRSOeucVYdvnYz6/Wn1jH9s2DwiPYFWRH3
         /MZcSJsgpiNSmljVzpKuwUb2DcVHz1ObbENmeJwWUsvFcd80bp7ceVJfMKRagcdUObJl
         bnjw==
X-Gm-Message-State: APjAAAXUjCiqazXjyHLAtx+vSQZnd3U9lLgT6ZSx6yCQlDfHvvyc/Pvu
        lla6JKYPFbqHmwHYRVbDJqiiezDXMEo=
X-Google-Smtp-Source: APXvYqzthMZRpfH0Kk0P/l/B7rFS8ZcesO46ZxDcrlo4QOmjcteHxrGwCa/XXg4ReOm+BX0/iu98ow==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr3159425lja.16.1579198933257;
        Thu, 16 Jan 2020 10:22:13 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id i16sm10842137lfo.87.2020.01.16.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:22:12 -0800 (PST)
Date:   Thu, 16 Jan 2020 19:22:06 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: Re: [PATCH RESEND BlueZ v3 0/1] mesh: Streamline crypto functions
Message-ID: <20200116182206.eo6un6kegdsckwai@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
References: <20200113123110.2209-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113123110.2209-1-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 01/13, Michał Lowas-Rzechonek wrote:
> This is a followup to commits 79fd24af1 45beec16b and 37bbe30c9,
> continuing a cleanup of mesh/crypto.
> 
> This version works with unit tests added in 06cf0fd1c.

Any chances to apply this, or is there something I should improve?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
