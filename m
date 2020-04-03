Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DBCC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208C2077D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Cjl+5zIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgDCRyI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:54:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36993 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCRyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 13:54:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so7855094ljd.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=skLv1HRTtKpr2smpOIuKaE2HQF8dZkc8tbEnmioJS3g=;
        b=Cjl+5zIxMaI090z+bEa1QuAUQ/TE05boar4TaWarwzjr4irQoAG6MBBeGZ7mEkAc0n
         gb+wIOXbmfIhJDJgSbLYu+hqtID8b2adiNwFJGXZ7+1/6dErnDKruievB5y5nzz0DQIA
         4g3oc3GkKEdiojpW2DLfCHuRVju0sf3pJw7gea2QJpO7oigpNIp2OXLVo6GxlYhbbJ0I
         Lt2JO1OReVBPE2yfRD3itR6TzQljidwQKm+EQtNXk2iPyTviYJOz4C3JwecBRXC17j43
         IH1AUSKPiZ/STZzfna0IVaXQA2oV3EyMvaln0uL7fOyMPW+jCvkf3AG61wcau7dJhmhU
         YZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=skLv1HRTtKpr2smpOIuKaE2HQF8dZkc8tbEnmioJS3g=;
        b=bQ45DhXGlIJLut41daaEFs1sG+KJvhmdZUVxSF0NSIXM8Yq11gJLC+9vi4aMQB2Aw5
         h9/jjWwjdLYfT20L31FDteAPayonpwpsKfuOGIhzo7xcfgkLVeg1UCm7aXsL9NpzCLef
         22yKyKPrwtxILOlfW97ZWXa/XfjfHWsJLnwiQnPRmzQGdVXAYnGkKibocGScJ4zupYOH
         ahSmeCd2YGBj27g40Lzw9SGPFQpUDLNdzcEgu2+1v3P7DOQ+Pes69Nf4PesED0+lg+8s
         oY7YnAOsf2gixIaBKXoSc5qp+8x2ANKrAuuJrwM9HSdXEMe3d0dWSfzj1dh5QpmaKZQq
         K0hg==
X-Gm-Message-State: AGi0Pub29Ah4vOXhyhSQKq+YKz8jSq97vRVJyixUk5hSyqWRxMAXAbJz
        DT23aybYyMUN9KHMBMa3uXY1BEvVFcM=
X-Google-Smtp-Source: APiQypJ+1pxxTLHuRyP6XIgD2T6NIpIWdsLKE4iMehYgvUjkPeSuy7ACDv/HxFH8+85O1Z2NBP9OYg==
X-Received: by 2002:a2e:b1c2:: with SMTP id e2mr5803983lja.288.1585936444666;
        Fri, 03 Apr 2020 10:54:04 -0700 (PDT)
Received: from kynes (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id n23sm5213183lji.59.2020.04.03.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:54:04 -0700 (PDT)
Date:   Fri, 3 Apr 2020 19:54:02 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Subject: Re: [PATCH BlueZ RESEND] mesh: Remove redundant code from mesh/crypto
Message-ID: <20200403175402.xto4ub6w6uqqyfz4@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20200326211705.18678-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326211705.18678-1-michal.lowas-rzechonek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 03/26, Michał Lowas-Rzechonek wrote:
> - Remove application_encrypt/application_decrypt
> - Make mesh_crypto_privacy_counter private, add mesh_crypto_pecb
> - Make *_nonce functions private and align their implementation to be
>   more consistent
> - Refactor network_encrypt/network_decrypt to use *_nonce functions and
>   rename them to packet_encrypt/packet_decrypt
> - Refactor packet_encode/packet_decode

Ping...

This version of the patch passes unit tests. I'd really like to get this
applied. Or at least tell me straight in the face that I should bugger
off ;)

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
