Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC75C31E5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527752147A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fBv6ni2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfFSRpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:45:54 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34434 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSRpx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 13:45:53 -0400
Received: by mail-lj1-f173.google.com with SMTP id p17so75762ljg.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HSFi2tztquZU7FOcFToXGAxv4ImJGlvwfLgiw6MVkVQ=;
        b=fBv6ni2UqjMqcB6IksyhmW0psUWOYCv2eLzj00wx2t17HFReTeeNF1QIGnqkVHUoDH
         gy2Ibk2hioH1OKhc2PhXnsW0w/cGM6yTKBF2taTMDGb4RvfhOtZdU7F7GexPgpFI6QvY
         Yj6pzUl6Tnxp2AiTB8zAtfdp2rpM/A9PGyBsXj0XyH9jTsQIujgbt48XlP2r/UymhACP
         zQP5hyKriUc19jIWdH7ecM1hbEbuIw9a9r4Dj/gda0eBSVamdo+hTNLAXhcJbz2qitV2
         pob6zGARfMNgNrq2C9Lsrs5tWMlInpyekRfavBcMERA+fL2sX/taXhWk01bW7N3nuxm1
         Hi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HSFi2tztquZU7FOcFToXGAxv4ImJGlvwfLgiw6MVkVQ=;
        b=DrG/6RvMNL+gayAUw28BBbhsLDcP0uT56++v6YkNUILE7zs51HJVXJNEBklLPF1CVj
         rsjdqpwya2v4jw0PpKUaJucZXHA2lnQQKTFL8HTVvtaY/8HkWQbC6fjk30lO25xWuNUt
         s8ZNXDWQPvPurApJEUmN7MKrD8XoNNTUcqRciObjqma4IefVMShB1u0IoqYl8C+a8GvW
         vdLdk5OT5LTiZSLDFrFN9DGKRdFWVN+qbkJ7MMJSQFPMgql8MTFD9my/lBqLSRGap/pY
         BCmR2CIPWYwKi2uLa0SvRZSn1C5Im9oT52XaXuGWkpz7kz+4aiJFJcEhGoCib2Q3dnBq
         EhNQ==
X-Gm-Message-State: APjAAAUiXLz/F4+FQ1avPGlztJIVpEmfzBseZAg0AosUl8ygP3oz/g0f
        PMfPt2QAMVBd0OiUdbe4hMW4OQ==
X-Google-Smtp-Source: APXvYqxzR55FL/xUi79jJkeRRzgZjr4He//M9JMc+Ti2XpV08I4nbmHXbtiitW6EJTWue5D3Y05+Ww==
X-Received: by 2002:a2e:94ca:: with SMTP id r10mr8205132ljh.196.1560966351725;
        Wed, 19 Jun 2019 10:45:51 -0700 (PDT)
Received: from kynes (apn-46-76-45-65.dynamic.gprs.plus.pl. [46.76.45.65])
        by smtp.gmail.com with ESMTPSA id r17sm1990698ljb.77.2019.06.19.10.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:45:51 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 19 Jun 2019 19:45:49 +0200
To:     Grzegorz =?utf-8?Q?Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc:     Jakub Witowski <jakub.witowski@silvair.com>,
        linux-bluetooth@vger.kernel.org,
        Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH v2] mesh: Return dbus error code on Leave() with invalit
 token given
Message-ID: <20190619174549.tqfqkgwu6yfq3tmr@kynes>
Mail-Followup-To: Grzegorz =?utf-8?Q?Ko=C5=82odziejczyk?= <grzegorz.kolodziejczyk@codecoup.pl>,
        Jakub Witowski <jakub.witowski@silvair.com>,
        linux-bluetooth@vger.kernel.org,
        Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
References: <20190619074851.24039-1-jakub.witowski@silvair.com>
 <CALevQMaSheh9nY88L53bV==vS=7V0DBY6wFtf+A=UyHDnjYS=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALevQMaSheh9nY88L53bV==vS=7V0DBY6wFtf+A=UyHDnjYS=g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Grzegorz,

On 06/19, Grzegorz Kołodziejczyk wrote:
> You have commit message typo "invalit".

And you top-post ;)

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
