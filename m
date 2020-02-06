Return-Path: <SRS0=lv0E=32=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220EC33CAC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D54214AF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 17:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nrfwpyKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBFRxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:53:42 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41044 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBFRxm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Feb 2020 12:53:42 -0500
Received: by mail-lj1-f170.google.com with SMTP id h23so7042553ljc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2020 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ybf6+9BEmNE/ItpgnSqjyqh2Kwgfzx8idRXKbH7XGuM=;
        b=nrfwpyKxnLfJq5/RqZ4Ixx7vOFt70jZWn7jhzfEhIPvNgVNsP2dJ5pE4Lnia/tgGWF
         xNHkiwqPxtZxM8dHUfKSml/p/9e46ONMEBGt0P+qKZmPK+M8cNwA/lA+zDtIkGmZfDRx
         bifEINzxm3gMu+4EzV44Rf224gWH4DaFX2BmGxds/4/36hT0WCV2dAGwzRNLZn1cuwXJ
         mwXclcKXtXXO/YwK13eft82w2r58IrgmrpKFDUKpAezBEdjHmFHBZoUzTTD5LcMKZLIf
         W2cLHPISQPmqDKAtkgnEGToFmdSRnr4qsuyvxWrAPnhC0lX171PPlquTJtLdji6O0D38
         3llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ybf6+9BEmNE/ItpgnSqjyqh2Kwgfzx8idRXKbH7XGuM=;
        b=E8RqNokdw43eTCDoZbX2nJ9sp3PS2/E/5SfSj08XP0eWJLhYzwT1hE09x63Yftrb+b
         yGFl+niAVaVmMxkWKZKPlX/qYGAk0uMDVcS+/7MOLJpEFvAubS5vpnMq2ZYk0PyNAJFg
         sRZOYOXgwK467l12FtYy2lKOjmlEv7t2gPqyzc/7avd18hGAvmZIJn6i+MyWJcqoS6FY
         6kKohyn3ZG1Y402Yj5yr2AdPoVWz6WuWz2/zQqFi9cGe1bChsVAn2QE2ZqjJ44xrP84i
         eQ7gCkerj+tgMMqmGKVw/kpHKZaGzj1mOXUftPlepuukDGPcYeOI21ufQXMtVNsBMAM3
         yIbA==
X-Gm-Message-State: APjAAAXjlpLWZPS9pl0QUYn95s0iAGhn/vOSvA9uMDzEJPMw8dGdJvMp
        DvHKrXF0i6BGvXnRyL/VffArzA==
X-Google-Smtp-Source: APXvYqx4jePiTmi2clvYXi269vY/sGjlN1BwDBkFehQ6fHMX6LwZRxeAk1lbOLAfySrD3ha4e1pZ9w==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr2755935lji.197.1581011620328;
        Thu, 06 Feb 2020 09:53:40 -0800 (PST)
Received: from kynes (apn-31-1-137-240.dynamic.gprs.plus.pl. [31.1.137.240])
        by smtp.gmail.com with ESMTPSA id j19sm57326lfb.90.2020.02.06.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 09:53:39 -0800 (PST)
Date:   Thu, 6 Feb 2020 18:53:37 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: mesh: Missing API for delivering provisioning public key via OOB?
Message-ID: <20200206175337.i647u3tydrf6z7s5@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200206171600.227uzfonhepltydy@kynes>
 <cd23abb8286bfa1bd8ac2ea5eabeeaa98dd39888.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd23abb8286bfa1bd8ac2ea5eabeeaa98dd39888.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 02/06, Gix, Brian wrote:
> > Is my understanding correct, or is there something I've missed?
> Yes... It looks like tools/mesh-cfgclient.c needs to implement the:
> 
> 	array{byte} PublicKey()
> 
> method.
> 
> This is a good catch, and needs to be added.  

Ok, thanks. I'll give it a shot, if time permits.

What puzzled me is that the provisioning gets stuck instead of failing,
so it seems it's not only that cfgclient doesn't implement the method,
but also the daemon doesn't seem to check for errors?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
