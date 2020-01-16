Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1130C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0CB217F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 18:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ar5gWxLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393145AbgAPSOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:14:19 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42981 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393147AbgAPSOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 13:14:11 -0500
Received: by mail-lf1-f52.google.com with SMTP id y19so16189562lfl.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jxva/k0uXAhVRCG1plu/nHb1uzU+qPvciJICwtwwZOU=;
        b=Ar5gWxLU1E2ZmQJqF7ZazhYn1gZnYeCB9Mi92gvnPKTI7fpV06HzjEH58zRzjoFYFr
         EL1rzAR7FjNjtxiqbdMZFw81FFCq88QcGVmIjDOzl5sU8WVmxnQ4EaD6uEtdCIMlvRzq
         WW1juiwlXpytaLTe5Nt81O8lVsRZVAv6/hYbsfT4B68YOelAt9sRSTLcDm1Jy28hsrT7
         uLb+1c104Q34oxfsZfwpXJit4LESVsv4JWXli89oEfPCnM3XhAGADBGnxgro12TNdt24
         v1z2l0vEyirqKFvjbZrqXkJe/7VA7wi4n15INpqYiqMNOJS9t2f+Vi8FVUe5y+x5NA3y
         5Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jxva/k0uXAhVRCG1plu/nHb1uzU+qPvciJICwtwwZOU=;
        b=qXNFZLeTD4Gry7iiIneffmKwBSmtogmWda5/q13+OnHU6sz7f6bd/Zce0V1/G5CBBZ
         ULr0p/nc83cIScAKciQurZwaKdKhWg1PtiLJfTUP6g4dx631Aiq6bbXAsj9fMIFaUpUc
         lP+r9e0rWXhs790Xyx33uWJgcWENY69GGHX/MIAfIG9W660SX926JoAh2Vr6fY8254u+
         Ytvp5de1WqZNnNgMw+G3vipMApWNEgDkF18qCVXiN+tK/0Qwg0IcLYbpPxwW0pFv2lnh
         OASIhv8ngtjIDdyVJ8auoY08rO+eCQjwWHfgsRvUNr++Pccxvey1l2qvkHvlHScx5Syt
         ANgQ==
X-Gm-Message-State: APjAAAXoMf6M4jo3N3W9S7+r4y3lr159EuyYnFXkCyE6zURIutIqAmFe
        2ZWx05rIXtgb5bKLMcahHzHueQ==
X-Google-Smtp-Source: APXvYqzc/+OZ/MQJF7ZbKXPTj5tsKRG3EvlvR6S3YIRxiFxBhKJ13x+EMpAG6K2DyeA3rUxW+yqpgw==
X-Received: by 2002:a19:5057:: with SMTP id z23mr2973335lfj.132.1579198449570;
        Thu, 16 Jan 2020 10:14:09 -0800 (PST)
Received: from kynes (apn-5-60-0-97.dynamic.gprs.plus.pl. [5.60.0.97])
        by smtp.gmail.com with ESMTPSA id t81sm10920253lff.25.2020.01.16.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:14:08 -0800 (PST)
Date:   Thu, 16 Jan 2020 19:14:07 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v4] mesh: Rename --index to --io, support
 additional io types.
Message-ID: <20200116181407.xuwee2c2tv4fguka@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200116120910.10575-1-michal.lowas-rzechonek@silvair.com>
 <155b9994772e7aeb1b883daafb2dac5637eabca8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155b9994772e7aeb1b883daafb2dac5637eabca8.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/16, Gix, Brian wrote:
> Applied

Thanks!

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
