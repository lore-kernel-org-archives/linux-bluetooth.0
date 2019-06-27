Return-Path: <SRS0=8pQu=U2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C342C48BE7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E1208CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jun 2019 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="k2JzJbNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0T44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jun 2019 15:56:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF0T44 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jun 2019 15:56:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so3578295lje.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2019 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aEey46qs5ZtoQZkQRW2ywNMMwsNQlvnxMDLg9ZnZjiw=;
        b=k2JzJbNVnIKN/cTzlgT9VFoSgElGBCvodbLKsU2hnOmWYMrz6s20xpvfDis58YxkEn
         XUe6nkKcumjyVy32NaC2aSs5DnrZOjA24ikp/JnGpUTlbeFbiN7Io3R8CyP16JMwJgm1
         /Ka6t4nXeuEYW0sj/+kO+1Jmmi/FMq/VBhwREXlNah+hyBu+OtAIAJwMCCcf7o7zTFJm
         rajESCuh3AyKF5pvhxDUvaZbXJsobVnIy3XXojtJ4kmA2btHCUSWj1LMiYah1yjU3xBq
         rIWO2kWlqIdInVaQtgvzQ+B8RKV4Wx97sbMgQ4pu0ewgmsRcTfOCuUZiI2/xI9Dh/zVT
         7rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aEey46qs5ZtoQZkQRW2ywNMMwsNQlvnxMDLg9ZnZjiw=;
        b=cXWI5eL3Xbhvsf91KSk1CGxsxhSWC1UOkfb1yLAdSNSMu0ifQmh8+Pl2OdtRRxcrsg
         fxVMXEHHkFVrOp2y2d9RZ6fIJ/hyczFP4eWRQC6b78+qkeT6UgGkidmTSlnUFHd+2xwx
         n9to/J+kUx+5Ky25I/+/0hojZuWe8td+z+Pbjt70I5Ch9k9wldNUeysHCoMjJbU30jtt
         WvBFcr+3c5JxNfs0v+gAjnzce25dVgtlPtun1uoVB0YZKvrjoYlS1em+HFtVz4DbV0Lk
         krCMzGup4+KUH72yYm1ZjuCbJOqmfkyOQmNlyvGCPOSQDZpkBcJI0x0lSfiisV+HcPym
         5qhA==
X-Gm-Message-State: APjAAAXYq/i2e1qGufO2jjVUdIi5KOMq+QEbW8iTPL9X/0Upvm0WH/EY
        5N7hqCFOlC4aT9wMZinxsKcn+w==
X-Google-Smtp-Source: APXvYqwzK4jEhjFkUzDJ599JxFCONXA1uTyoNLvj8kNbVnHl0D6u6N26QMSyN6mCp+3h2PLh/U2lbw==
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr3859327ljc.38.1561665414378;
        Thu, 27 Jun 2019 12:56:54 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id d65sm16525lfd.72.2019.06.27.12.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 12:56:53 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Thu, 27 Jun 2019 21:56:51 +0200
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: Re: [PATCH BlueZ 2/4] mesh: Fix virtual address processing
Message-ID: <20190627195651.7cilfv7aswyobdk4@kynes>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
References: <20190627033320.8898-1-inga.stotland@intel.com>
 <20190627033320.8898-3-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627033320.8898-3-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/26, Inga Stotland wrote:
> diff --git a/mesh/model.c b/mesh/model.c
> index 9fd3aac6c..219371090 100644
> --- a/mesh/model.c
> +++ b/mesh/model.c
> @@ -55,10 +55,10 @@ struct mesh_model {
>  };
>  
>  struct mesh_virtual {
> -	uint32_t id; /*Identifier of internally stored addr, min val 0x10000 */
> -	uint16_t ota;
> +	uint32_t id; /* Internal ID of a stored virtual addr, min val 0x10000 */
>  	uint16_t ref_cnt;
> -	uint8_t addr[16];
> +	uint16_t v_addr; /* 16-bit virtual address, used in messages */

Maybe nitpicking, but I would call this field just 'addr'.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
