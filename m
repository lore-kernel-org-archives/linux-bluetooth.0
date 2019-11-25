Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED259C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 02:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C616020674
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 02:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mLmnZ3Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKYC6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:58:48 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38625 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKYC6r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Nov 2019 21:58:47 -0500
Received: by mail-pg1-f180.google.com with SMTP id t3so5997507pgl.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2019 18:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pqb+GA+AV2mbJaXpnj74CQaLRYZl6peQCIBZfhCemGo=;
        b=mLmnZ3WiWCtynypAoIPkluXf7tpYAXDipRfi9QMgzPS5loYdLlgR80ogXxRBI4sdZp
         QdFug1yOS5C3WCORNvCY1PSD/oZf4Vacx+LVa+mPzAHgpGJCpfO0gshsH45I8C527/0Q
         VGNsErGzEetYAVbAjmZK2/cg4OHB19CSyMuE2MlCjStqIkzV2zV0OhCScIukwXiRuBA8
         PaEVfWinovQcGgHHXKrX6a61sCmDu841PfDGXeMKkzEfJD4Ou5aNJYeoGgH0S8ebdjYe
         cIIp9TID4w5m+il6G8dh1S5lTh+qIHEZpujjofDxaKBfXaYD8hEvdn0ysnLxwUbjagF/
         wwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pqb+GA+AV2mbJaXpnj74CQaLRYZl6peQCIBZfhCemGo=;
        b=OCFDjBzUzIYD1F/W+UJAeqohGB1y20m0xmFia42vjGa29e8Z97mJReS8iAD5WK4pL8
         9A26/AeTGy/6VO2xw+A2LHrFOrWuid0Nb5RM4dpJQ0PFz/Ilh5zJFW/PqwthR2l2Bljt
         ysYL071Oh5O/jNyLQQCfGozBzZs/w3vn95pXmeCiZAlin2x5RxVGdc5dOAxr/61h6zCf
         cSBsEOXJOrdVxZ9mDQ/r78TtfganI7l3MR1l14tMgp2hXMPOWpfVTA/+42MUHCz95swG
         Cq9BeYtmrCjYwztyWbOVd1NHWETRNdqwRF+pcdUbgLMrX8BhxiJacdcZ0vasij2v2/yW
         4kaQ==
X-Gm-Message-State: APjAAAX14TGYseFeP0VEqRJkz5cnVaa0ptrgm3sah2Ym3NYYZQ2kM289
        quPgUqQZMzl3egLktpLYNUSlqg==
X-Google-Smtp-Source: APXvYqx7pyfcYNt7vKGiYVY/GTidY/pCIxrh1LflI+Aicjzc6KavANnCBrhTuogtg6qKR2TqcqPgsg==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr29580973pgk.437.1574650727145;
        Sun, 24 Nov 2019 18:58:47 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id m13sm5835849pga.70.2019.11.24.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 18:58:47 -0800 (PST)
Date:   Sun, 24 Nov 2019 18:58:40 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2019-11-24
Message-ID: <20191124185840.4edc495e@cakuba.netronome.com>
In-Reply-To: <20191124132645.GA43125@pehoward-mobl1.ger.corp.intel.com>
References: <20191124132645.GA43125@pehoward-mobl1.ger.corp.intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, 24 Nov 2019 15:26:45 +0200, Johan Hedberg wrote:
> Hi Dave,
> 
> Here's one last bluetooth-next pull request for the 5.5 kernel:
> 
>  - Fix BDADDR_PROPERTY & INVALID_BDADDR quirk handling
>  - Added support for BCM4334B0 and BCM4335A0 controllers
>  - A few other smaller fixes related to locking and memory leaks
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thank you!
