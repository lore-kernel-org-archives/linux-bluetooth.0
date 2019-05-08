Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30C0C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C856216C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="T53P9Ez3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEHTD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 15:03:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35166 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEHTD5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 15:03:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id m20so9217045lji.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2019 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oukS0tWnjhUcgrOB+VdnNDEvlpBoD2u3Ucf9S3+HJLQ=;
        b=T53P9Ez33w5PHBxX0aFn5qpWGk5cDVGxj2L7dJzxyaB6GXPaCU4i0m1ezr7moDnDuM
         NNcVBFd4BPK/S+zVJ9ap/TXCRzWo7MnNiyuyv7V5T1J8mn1UEuhrNM5eJ9KaZGZgYCHw
         5nZWH+OaRr7q/hwmZWRpu1RIXxTHlX85jDMr71CHeWuyWpdI+/jny1Xo1w2Oza1Ubhws
         CiXBKxPJZNTPylczmop6wjaZLhIdAbQewUPx1Vf9VgWnWp6ozZWq4Hl055wSw9zpXPQh
         0FC91mdxex2UUHs/awQ5EOYQDy+DfknrMaIrxSC9t98TAJOFjmbUgFBCXsgy9DWH61yW
         RTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oukS0tWnjhUcgrOB+VdnNDEvlpBoD2u3Ucf9S3+HJLQ=;
        b=LiQNwDSiwlHl6u/KL2dnk3pLJGk6eX4u+tlDSPc+xLPXU1tJ8XSHAjKr28UjixaEYx
         GdfuChjAcK/qYDq+SvIQcJeA4Z2vaW1qHAc909K3Fu5edNbref07yr6TFjtvG0siXJs9
         ImdLnt1pX7d6IrS62X5lnhnCKe3M0DPGsBMfM9y19dD5uEjxh7aI88M6Z+8pw2gCYHvS
         ogAW+IQR1RiCrLrZBg+giqWv3uqfaLZ9SD04Gt7SXNyUgSJP0GUSlZoS59/pTnyKf5P8
         00b2jqwViaFlgdmzrVHsPB8pt6DL0ztPcYH3Gbfjnq17ObZKnjK587Vsf3l+zGazuKdP
         wy9A==
X-Gm-Message-State: APjAAAUDpXOFBbVJ4/5g3Oi7Dn3LfXlpbSkTONmUg6nuDodzTclvcyIh
        XO0DipWlPGAvmoP9Xd8p66qKMw==
X-Google-Smtp-Source: APXvYqyypA4po792Y3d01RpCM/kq5X/WUNUwPtsRGuO6eJUVsT3slKY4K7A1cgC6HGOyukcltGc74g==
X-Received: by 2002:a2e:9d4c:: with SMTP id y12mr2843621ljj.132.1557342235706;
        Wed, 08 May 2019 12:03:55 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id x68sm4260362lff.3.2019.05.08.12.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 12:03:54 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 8 May 2019 21:03:52 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v4] mesh: Add key storage
Message-ID: <20190508190352.lsekrwrs3jk7ooc7@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190507172701.20726-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507172701.20726-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 05/07, Brian Gix wrote:
> +	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
> +	if (fd) {
I think these should check for fd >= 0

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
