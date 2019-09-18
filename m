Return-Path: <SRS0=h2kO=XN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C45C4CEC4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 12:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C808D20640
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="q0MAhue/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfIRMgT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:36:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44101 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIRMgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Sep 2019 08:36:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id q11so5543394lfc.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2019 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vB5KbmrOqfeHTzapTIVJBDXUuFlWc0YWmQHR0ZpTcwE=;
        b=q0MAhue/8lSRh35xTu6+bgL3oAV0xFEbXO5cBkKkX2eqDjGPBJNsyxNKgm4mjf/fQS
         qnpUjKG6e6spsLHMzoa2IGPUxhH4+Sy6nqu2Xrw86cf4t8xXGd+zCCufbufDG4s7ZUMy
         hLM0WCKnbun5TgIke96xtIfNHd25WsLLfJSpL8opX23cZYtCMCHb5YTYzkCEvpetURcl
         OiWeUls4rhqoXd2HbquLnQT7a1OkorMpXW+btyXrt1Cj+0m6GK2EAID1ne7W7CyYz0QU
         +nJFlPQRYepNEM4axVHH2tJdUdjGA1uQU7vcWInilT/Ow6ZA9hUzhCIamtkcbEWuabFC
         s8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vB5KbmrOqfeHTzapTIVJBDXUuFlWc0YWmQHR0ZpTcwE=;
        b=NBo3WwVzApaL5yN60fHLcOwKTe8f82tQOm21cKVKg6lbUXwVhXQWCvtC2hNISnWeUh
         QQ3ZE+iSjHOULPTNz6s9bKtW+otiPhgCdI80ivRoAi7IuqYoylir7A8vb/b3J7ZK2aHm
         yRnC8syU/NVivVkymjW/LzBMbaY7Y+WO6zH5yu+iwJBm78uEhGN3/xLqwNv7FP5WTNBf
         x+GqKYXO5OmC0MK+mE6YVU3pWjL7CwxWRIacjtl8Iblrt/DWQD6bU+6LNJsa105uon5O
         cI4XfPm7DVTx6zPaHQgaUs4WT0VYumecsyzNgHfp6YF0zatYYzybz08pjYNALUITIhNr
         BJmA==
X-Gm-Message-State: APjAAAUYoz6+1tyS8ZxIyTmEdixve2nDfbHcApBT4K+cXmjklVoK0LRl
        G2YJda3auQ9qg670KWwqzdi2l6OZH2c=
X-Google-Smtp-Source: APXvYqyRBU9do10TM7MnBHvLAF558pgmj98G7btswbQdIAje42t6F/RTIjARdX4TAiZcYOMlEU82Dw==
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr2057640lfb.153.1568810175650;
        Wed, 18 Sep 2019 05:36:15 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m8sm994958lfa.67.2019.09.18.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 05:36:15 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:36:13 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org,
        Piotr Winiarczyk <piotr.winiarczyk@silvair.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190918123613.xaa37ocslhli6s6o@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org,
        Piotr Winiarczyk <piotr.winiarczyk@silvair.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 09/18, Michał Lowas-Rzechonek wrote:
> Please see a diagram at http://ujeb.se/BmTIW.

If you have trouble accesing the drawing, here are PNGs:

https://drive.google.com/file/d/1zZrmFB7NLcbyR-tPE9ljqxolZIonxXbc/view
https://drive.google.com/file/d/1ntkJGU1SYtgqrmQN9F4PDiWdjYAc0U8o/view

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
