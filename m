Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C021C2070A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="E8hjffXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbgFRPn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbgFRPnb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 11:43:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3075C06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 08:43:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g2so3777653lfb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k1ZITpKB5ECnDS8QyF+K8mddYpJcH41BvYApV57KOf0=;
        b=E8hjffXcgl2sv5XXUdyw17BuqlGquvDlWs3pZEpj/afKLLxdxlWtQvLxeIGTAxkmE6
         OF7334mfwUP9NqRo2EXa6bMxZpQUQ+zEKmnsarJhOnVFzfYW1Kxmiuree9dJQ7bXqVG6
         w6YgtWlN+4EsK6ELGafwJ43ZrEhVrUX5fpX6zMRxQL7eqmddAj4urs2JC6LIqgfEIt5i
         bZlS7pXx5zmRkw1lGdPawiekMbrfbQbjplLGI8jJoGVxpWwqJgxBNSdeqZRcsGBtoQaK
         IRdqrbfht8xZ0beL+lZXtNvXBA58nP1vIm15pXIgcQWaq+3Vv0QH9Tqxsgof8/s2vOOC
         E7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=k1ZITpKB5ECnDS8QyF+K8mddYpJcH41BvYApV57KOf0=;
        b=Okxv5MtooEuJuMvn++uatYaxWia15M768qhgVzTTrQZNZ/iINc8nKH6T7ZN6F3V5kg
         FHmnv71QkkqssOjzgkYJgk/aWexpqU/R/cutSVm7glzVdOIoj/FVljQMxHVKq16ugPXP
         9Pr7UcQpeKTge4PIfsYM+BoNoorB0XhYEF8QGbjulR8Jht7SaOaW5YNatJDU+QkgNj0K
         jBAj85n0T2N8wvqUzzO8rDIfxPrcZKdTIeqaVA5T7ACGGg9wR7ZwX6rRufF/JVhIxxfO
         MXmg4Yg5wybz59DwxawZIuaeqvj2M65DfFqqgWid7J3Jj11MWP0mNSyoru+6yS7Hei0R
         XKGw==
X-Gm-Message-State: AOAM533F772J1p8a+rWtiDEhWxN55Z5qYmEo2eX4MRU+0ip/vOIO68NB
        ZwarxURz6MxvA2yVd2HSuTBOlQ==
X-Google-Smtp-Source: ABdhPJzNIp7mNcrzxpIIqQ0wC4TYJEnSulOcQNJ3sG3X/fmBxxx+1NbJ3OPaZ04kjFEIDhP1R1L53g==
X-Received: by 2002:a19:11:: with SMTP id 17mr2734950lfa.125.1592495007858;
        Thu, 18 Jun 2020 08:43:27 -0700 (PDT)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o2sm820637lfc.85.2020.06.18.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:43:27 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:43:25 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Message-ID: <20200618154325.eaudqfy4inbjl7oy@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200616181436.50319-1-brian.gix@intel.com>
 <f4c0a48f8d7c30b7c12bdcce84cf8ee172709daa.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4c0a48f8d7c30b7c12bdcce84cf8ee172709daa.camel@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/18, Gix, Brian wrote:
> Applied

I have a vague impression that my comments about (void*) true have been
ignored ;)

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
