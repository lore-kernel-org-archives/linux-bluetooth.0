Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD7C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9DD2342E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="qcTI4stl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH3SXV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:23:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39381 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3SXV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 14:23:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id l11so6051346lfk.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2019 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eQill36fue7Go81D6Kz8KAY5ejHyfulPWGvj504O4d0=;
        b=qcTI4stlmZ8zhtFmKBz+Yl0gCHA8AyuwCMbiGRx2XGmZd4thrc0Fv5Dswtf78e/QaB
         zk4THJM4njCeVhss+CApWcBzoB4jjjhOb2b8Qqf99NtgJgwL/GSr3iJGjfOuQJFO62NL
         Luiol+sFwho/oftrSf+fwCQM806u1A6h8TRg7VokTmKqRPB3qUAk2XF5cN/i3HQgWSzq
         bF9VL41T9pdLohQ1vxXSYnMKw9H5l3NNv9C6G6xmXRayFnLbEcJl2wcDdETnKbKLK3sp
         B6Gby6KYhdZr+TBv1pJapcc5VOCgMJ890UeqihLQXvQtc06xdgwCihFsmdsKvgr6rpGu
         kXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eQill36fue7Go81D6Kz8KAY5ejHyfulPWGvj504O4d0=;
        b=rmChJku5xotrRBhtmtgxfjSc6G/GejFccoaaGJfM9FWZzJseCH1Y1BblnMuWMHVcA7
         aNiIwwNA0Hw393RkiJ8wKkc2r2YggpksLcRT36Gtm4Hv0YCjFjZNFDlD8y1kiiTg4UzJ
         TA5BqHpQN7neHoC7gu77E5IC2iOPR8LaefEiOb/mq5hKDpIpAjYFYCEnz0z9lZS6HE/i
         wXk1A9bgj6HnzR9mMrukL0lBWgY8e8O0u6moTdY8L7yO0oct0uhkfBOqKvg9j7w8IVZS
         suNEbEQ+SrsCUaK2UsxIR6yf9ruv1bn1VxK130f/2z+5ZeBnut0Ei275CSjCIsPmK4jx
         Whmw==
X-Gm-Message-State: APjAAAV11G0YH7JHS4nlUW1qpwQc7Lw9uRehynKD7BLXFJW/wBB4tqji
        ueZYsKY2C/EWe+xv4FszWl6Jrw==
X-Google-Smtp-Source: APXvYqyBLfGSWZwbXIDC+mh+Y28rpyKYzNVB7WQZNQWE+6A1iaQJ2ay7SN1PpRXsPq+luHGPj5WXcg==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr10054890lfm.104.1567189398977;
        Fri, 30 Aug 2019 11:23:18 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id d16sm1021705lfl.29.2019.08.30.11.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Aug 2019 11:23:18 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Fri, 30 Aug 2019 20:23:16 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: Re: [PATCH BlueZ] mesh: test AEAD at startup to check kernel support
Message-ID: <20190830182316.fo3nmzfvzk55rhnj@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org
References: <20190830173902.19953-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830173902.19953-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 08/30, Brian Gix wrote:
> One time test at startup to ensure either kernel version v4.9 or later,
> *or* that required AES-CCM support has been back-ported. If support not
> there, daemon will run without providing D-Bus service or attaching to
> controllers (prevents systemd thrashing).

By the way - I have a patch that implements all required cryptographic
operations using libcrypto, enabled by ./configure --with-openssl
(disabled by default).

I know that last time we've talked about this, the consensus was that the
vendor should patch meshd to work on older kernels, so we did exactly
that - but maybe having this available in the mainline would be
interesting?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
