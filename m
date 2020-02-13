Return-Path: <SRS0=+UdQ=4B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C5C352A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4F217F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPjzLU6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBMTPi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:15:38 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38138 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBMTPi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 14:15:38 -0500
Received: by mail-wm1-f50.google.com with SMTP id a9so8003760wmj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E8sixWlesleV2a2KW8ANR2lWK/GhtYEYAhQb0IOsAGE=;
        b=YPjzLU6V7yNJxdmaiCvitn+jOeJl40skoPG6n0SGDysRLN+XGCjD0Rp1qRYHr79qNz
         S2B05jRFbGURWJ76jmmsmld0+uerNi5aLQy7kIsowlSN2v0dtB98wBbZk0q7muUC3Loq
         FYWcaERvdj0mSi3VOXQk9YqxsJBn1dbhQOhtLpIlDezlBVBKtvlUjgURy5LG38ZVkbNa
         KzslrVemby1FRg9mNQN0NecoQZTxTv0MbeOAGf9y77DKnUQ07b4+Oz/gUIPh6NzrTUCU
         1Sf9ZHhP+8wJ4Ze0baALIahCTK/4yNabtjFi+t2eyq2IyCF5jGq9MLm0yUotCyEt+xAH
         aYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E8sixWlesleV2a2KW8ANR2lWK/GhtYEYAhQb0IOsAGE=;
        b=CmdwmLxJA6VjWOoLHN+MG5EiHA2FFyzVY6sr2sov61mZqQAq15tb138pXxCJSHdd/q
         VLnx1m2QEfc+c3fgUfh6+pWnnE3ItozJ2DKRXqgEzaHg0tivi0RH5FtKpdyg/6Zvn4P3
         OfcoL86UmzDIa9mZsFLNNvCkyNoqp3l1J0d6PKrP/OupbSC4CAPTA2v3sLy2XNzY0TmZ
         oDHUw3vS7bDwROXQNIJqmeZewfQUTe3sWSt8ReU8ppuB+j0mWn5/7uzyvw1SL7aV/Q/l
         JGZ/E7Un1I/Bkf4/nNoHAnN5pnBscg6AiSouugxNmowrQ84NRrbjkitdfbYbbJS8jkIQ
         ar0Q==
X-Gm-Message-State: APjAAAUV5KlogcOP+aXO3mr+VXespH8GBCyi8fhA/FHJ8Vs0RGlqd+pu
        f/6HodJ5sx0ch+pxLfXvhiY=
X-Google-Smtp-Source: APXvYqzcwRmldZ+BcFhZcjzyvNdIN91XZxUzZvcyWFIK6dVj9mkgGD8aspVk+Sca3GBdfGNThssAbA==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr6810395wmf.184.1581621335794;
        Thu, 13 Feb 2020 11:15:35 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t12sm3839525wrq.97.2020.02.13.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 11:15:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:15:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200213191534.vz2mzxhkhr6i73r4@pali>
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
 <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
 <20200213174621.e2q4ryu36p5ericx@pali>
 <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
 <20200213183253.44vkm6bpddre4dvp@pali>
 <77397684-1c15-854e-b88b-4adff6f73ada@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77397684-1c15-854e-b88b-4adff6f73ada@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 13 February 2020 13:08:56 Denis Kenzior wrote:
> > So, why should I even consider to use ofono at all? It does not support
> > none of above desktop feature, it does not support extended codecs, it
> > does not support HSP profile and also it does not support HFP profile
> > without physical modem (majority of desktops and laptops).
> 
> Your initial proposal wanted to use oFono as some sort of helper for your
> daemon, and that is just not going to be accepted by oFono upstream.  I gave
> you a few alternatives, including how to extend oFono to do what you want.
> If you want to roll your own, go for it.

You have said that ofono is not going to accept usage of hsphfpd for
telephony and also you said that ofono does not have plans to implement
needed HSP and HFP features for desktop users.

So conclusion from all these facts is that ofono is fully unusable for
desktop / latop usage of bluetooth HSP and HFP profiles.

-- 
Pali Rohár
pali.rohar@gmail.com
