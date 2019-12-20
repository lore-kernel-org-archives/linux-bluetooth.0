Return-Path: <SRS0=msWm=2K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4687DC43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1622082E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KsXtjHpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTUuQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:50:16 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33494 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTUuQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Dec 2019 15:50:16 -0500
Received: by mail-lj1-f176.google.com with SMTP id y6so3288873lji.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2019 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G/iJwAV3G5Mizs3c21wyBgc3jvEdl+VOKiGzT0GyuZo=;
        b=KsXtjHpzZC3UAB9WakJQ7UI9guYueUFmYe+2veXUperbLJ8HfwquvEbk5umFU3fO9x
         SAoJYITxJ1YtnYsHMIMp8ALQmkgWLFXwr6a0FSFaQJ0ivJ16/fM8+hOVW5QprW4zAk/x
         pfLwcIu4hw0A51n3e2ag438ljNFPFk6QKqXvYwrdV8y6heIcjdaFVTn39wLoHEXO3Q5C
         HregsCxN9e8YETts81RJp0+DE+hsvSPLdUFpaGYplMHpAnHm508q1JEu2kJ3pctre6G7
         D4RnVIKnj1m0eyEgh9SmbyxZbrll4Wmr1YJ/k0Dwt7L9oA7BwlL85hU20ewUDS+8l+vk
         h8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G/iJwAV3G5Mizs3c21wyBgc3jvEdl+VOKiGzT0GyuZo=;
        b=k1J53tEiOVd685/CAljz3o+LBIl0OCCbKVy/z/oYpiUnH7gEqjYt5VLH/gCljvz2bz
         aXMwdTkSAJrJUIVoWLvNPH2I4HW9kLJ8itzpm1lDFONcKBlSAltLGUjUl31AwvXwNaR2
         0YFiQwVS/ZX3QohTJikVTcASOzx4UbgK0VKNCCg4ZHwGG1fMWJB8Q+ebGtVUaMgLec3/
         ETFZ2HqMq0ub33xf7R7EkXQp7I/9HxJghsruqCq7Cum3HHsgvNefFn8nbCEGMrFEsVkv
         LdZkUDpC5qIQXbDxO3jG62i4FSHWl3V+RmXPi1+ov4JJ9zf0hJov1TedSCmfiTojDL1H
         lx1w==
X-Gm-Message-State: APjAAAXbfm7ULJr/HARhOsq8Iji8rBta80ysBYBaPehNjv0o0MAN6Lbf
        dPmsZNT982JkHqU5a9uAmw3yUg==
X-Google-Smtp-Source: APXvYqxpgAQ+bC55QfOASY/S9iwHq71QV/PZclrT8A0MdPprwTRmP3U3scoYeJa267FxazEUrwNhiQ==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr1903657ljo.180.1576875013818;
        Fri, 20 Dec 2019 12:50:13 -0800 (PST)
Received: from kynes (apn-46-215-206-57.dynamic.gprs.plus.pl. [46.215.206.57])
        by smtp.gmail.com with ESMTPSA id s26sm5662972lji.9.2019.12.20.12.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 12:50:13 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Fri, 20 Dec 2019 21:50:11 +0100
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ] mesh: Base config json code on newer version of
 json-c
Message-ID: <20191220205011.nte4wz3n5ujxwj4j@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20191220191329.5190-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191220191329.5190-1-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/20, Inga Stotland wrote:
> This removes a roundabout logic that was required to delete
> a json entry from a json array using libjsonc utilities.
> A new API function, json_object_array_del_idx(), implemented in
> json-c version 0.13 simplifies array entry removal to one call.
> 
> Also, add requirement to configure.ac for json-c version >= 0.13

Nice!

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
