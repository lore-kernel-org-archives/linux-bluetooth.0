Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090BC3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385592186A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 05:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wSKgc7E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfH3Fr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:47:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42175 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfH3Fr4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 01:47:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so5280486ljj.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WhsZ4YABETaZp2LDJIY/+veXTWzZPHgmOSUCIQZtrvc=;
        b=wSKgc7E11MoImp1ctQxQZ3BzWEzrcbWI8fTD/s+7Dke9GNCAAZ1hBLgg6TFSa7GmyB
         d81SHe9oFaaK+l2XM+yNtV76rmaHINBxF/5mLRW82W12cxYZqZjBvJAXd1ofpv7hyCky
         3X9Oi8HHDpslXGHl+2BydF/xnTlyf6aYbBwK1Bi1Q7A/z2lPHnoAvMXlbpGfQVF+gXqC
         UZNKLxV6zyGU4hhdTHvcb31nAwziPn//KxahfuVA0wt5BPlKAOG8tBRyr951lYgqLEsS
         rhcg4xFXFTA+FPJfqWG86EzxTpa9wb9ANsd5TCHVSO2fnvEdbhL5vzAR8OqQEaOZIls9
         qJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WhsZ4YABETaZp2LDJIY/+veXTWzZPHgmOSUCIQZtrvc=;
        b=c5E20mC/yrP8P2BQJfEyna8ij6xx9Md7zrfwwODBZi87BsG7RKyo+9TCvtkmoXhwWR
         ymH3/cbCV4b8WtKe2FJm8sDFqFOrERhEMtnNamTn6QF3R6qPCp0BZV+b3m3ojIWfDqeu
         o3x1tj7k6QgvoMY/KUsuC00ZM8ph7FZPWyCl3nXsJxL0G9ePNYSelf/tGCNd0FyZuqun
         tKmpvhEEdUZKWdJVzIAa9N/8fdhStCvHz6nyQDvLTTTyWz9aLUFonQF5hLfptCNjG8ld
         tf3ePN6hmxwrvKoJ2SBS4mxSNFf95sMieDIPVxHVPWca/O1yjh33gkURrCWG90YG0pPP
         UHUg==
X-Gm-Message-State: APjAAAWmD3rqeK/laix/lPc9ueZbNwOTeGSMuFLYNm8QWg5atI70drMz
        2ZcSSeqTFDqZibS+uU0QNidsGw==
X-Google-Smtp-Source: APXvYqyvVriHUQwIOUeiSlK1mLKjXNKFUwVQ2ebCzSB5jv7rjyoAiDnqUkKd+X95pFcXT7hYaWFlVA==
X-Received: by 2002:a2e:8856:: with SMTP id z22mr7306948ljj.71.1567144074569;
        Thu, 29 Aug 2019 22:47:54 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id i5sm660607lji.74.2019.08.29.22.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 22:47:53 -0700 (PDT)
Date:   Fri, 30 Aug 2019 07:47:52 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Log D-Bus method call errors
Message-ID: <20190830054752.o3wrahabdsqmmvrt@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
 <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
 <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
 <145b9b726c45fd37592b5a7a3504c911cd848409.camel@intel.com>
 <20190829195610.a6dwgxabq3d2g3bp@kynes>
 <38E88E55-4291-47AF-B502-47922E9FBA56@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38E88E55-4291-47AF-B502-47922E9FBA56@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 08/29, Gix, Brian wrote:
> > Anyway, I think a better approach would be to submit patches to ELL
> > implementing these two features, and then use these additions in meshd.
> > Does that sound acceptable from your POV?
> 
> I still feel though, that you are trying to solve a pre-deployment
> “debugging” issue by requiring DBus responses for messages that don’t
> require them.

I think you're right.

Let's drop this patch, and I'll try to come up with something that would
cover only "important" methods you mentioned earlier.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
