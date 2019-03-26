Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96050C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 10:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589B72084B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 10:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="LObTVkPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCZKxa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:53:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44738 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCZKx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 06:53:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id u9so8248797lfe.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2019 03:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGP3KsidIgf9uRydsPN4wsEtEwYAsKY08VxJXJKe9AY=;
        b=LObTVkPhMAgfvcmSFfU0W+1hXcCnNGa8iWVQkLHJUx7Fa3XsexXUKr2WJzX1pFM6db
         GfsmyiZaROJCyhTmiObvBeqkuRM2xWPRvCxg10jgt+e81UgIDfll5a+Wy/yA9uQQWck8
         n/7aaFITjIp/K9yRwfPewKYtksGVMwr4cxQcq4moJDslEzR41JlCy5LJLZ3lzmI5FSTk
         m8Sfdiy19lstuhb+zYTGmxQJYDMnTMDv9ENCG+rSINTntsBafD374qgh5kA3VjVBxPqC
         khOV0NZSqo9KVBAMUxlTkzQVsULhalMQgHBMe4BsS5uw07gyViNSgtd3jIDoSHG7SY11
         Eh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lGP3KsidIgf9uRydsPN4wsEtEwYAsKY08VxJXJKe9AY=;
        b=je3VMNq++/a4UPlhLfxgEFvSqMHCDsL8fnJIYDS2H0zq+W1Yel90PGdnZ1Mp6O1oUu
         +kTmxnVuW+mALmQQyI/aglbwOCCLfdGTvhGuUrbXofXd38SN64gDX4hkM1Eu2zQIx9HS
         r2MRKZW1oSscGChWdkzfA5pDQEZit091vTuBJC24GKQQsvXhyLfrNrMggqeWsCk7rELd
         W1rjb+Tlb5TbQqP3i3t6M14TkGC0HsY4Zp/UdRpBiuyPNyQbe2DsfyePd49irk5jxwMK
         5FnpC5R0NWOC2NuS8jyq+cHVnlpNI2W1gaSmb/qt6ccD3E4bf8cyeNCjZXaNzIcYhPlv
         1ufA==
X-Gm-Message-State: APjAAAWiel3zOCDjqlW7dgSBBP2xCfnV81Rlcgg18p4O/UsIokN/s99I
        1ASD8sUa8aTBHcKljSqJzqEv5rwXyvQ=
X-Google-Smtp-Source: APXvYqxWJz+uOL5bDaPfAkjm5OiqXKOZxFedcyrbtqcBa8tkFtOFs6h589fiNm9iIxe7YkD5lLRwKQ==
X-Received: by 2002:a19:f50f:: with SMTP id j15mr15873708lfb.126.1553597607628;
        Tue, 26 Mar 2019 03:53:27 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t81sm3896129lff.21.2019.03.26.03.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:53:26 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] autopair: Add more common PIN codes for audio devices
Date:   Tue, 26 Mar 2019 11:53:25 +0100
Message-ID: <1577665.qXM628sudz@ix>
Organization: CODECOUP
In-Reply-To: <66544e21401986edd519e4f6939e405eea5c7397.camel@hadess.net>
References: <20171127152651.18997-1-hadess@hadess.net> <1511796502.11411.33.camel@hadess.net> <66544e21401986edd519e4f6939e405eea5c7397.camel@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Monday, 25 March 2019 12:10:52 CET Bastien Nocera wrote:
> On Mon, 2017-11-27 at 16:28 +0100, Bastien Nocera wrote:
> > On Mon, 2017-11-27 at 16:26 +0100, Bastien Nocera wrote:
> > > PIN codes "1111", and "1234" are fairly common PIN codes used for
> > > audio
> > > devices such as speakers and headsets. This replaces similar quirks
> > > already present in gnome-bluetooth's PIN database.
> > 
> > V2 of this patch, I've tested it again, and it seems to work in my
> > tests. I've also added another special case for gaming input devices
> > and remote controls in a second patch.
> 
> The 2 patches in this patchset still apply, and are still relevant.
> Could those be reviewed and merged, please?
> 
> Cheers

I've must have miss those, sorry for that.
Both patches are now applied.


-- 
pozdrawiam
Szymon Janc


