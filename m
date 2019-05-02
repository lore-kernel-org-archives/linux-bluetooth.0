Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8DC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3D2085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="WL4/LIaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBUfc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 16:35:32 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40686 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUfb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 16:35:31 -0400
Received: by mail-lj1-f179.google.com with SMTP id d15so3433043ljc.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jwVw1861Z47A8TkSt0+ycEuZCRNVTcaAYcM9GpsG/X8=;
        b=WL4/LIaAiuu7/VVx+OX8SvQgBcT3WOPC6PTI6m9Ctlf/jQAg6k37kvxq0QU2w71Xl2
         z/OycikZUn8Yagnba8z605petVXI5Dm7nfUumDRC8p2/dJ4YVBCT/iyBEi+UJRngqb8d
         4K7lmV8t9lqxSizFSNqNUsPnX7Zy7UGM9vd0n8vMeQhrKoUQ/GzJuO7QB9SSirPqrN3X
         Os+xmJnjwhSzC13phMZ+FOnhmsSiVN0nW+v3Uvy0kUWl2r6mlxHo32J9JiRc3ynndSDA
         /HkBUDrYk5WxkRQLbrLGflsEcy9kyKBZbUl0CnFBTpjww31QVCnWy8Py15Zl2ahAMJ/F
         VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jwVw1861Z47A8TkSt0+ycEuZCRNVTcaAYcM9GpsG/X8=;
        b=U2suEFJizgT6KOMWFRorThxP46U4Z5yOEcCj2Cr6JsDLSnGoW+VT21aoerHlIGM9bg
         85SiC7dY8ASACs0rDllaovOaU/gsN8pzxaKzpGzMtEvCdgyNWtTWToUyKMJmEfMkOVQo
         pmfNXEzsbjLPZ0OVR8sA+6XoQP+N+D4Q+XrEZrO+2zim7YlMXi3iBocyX3vUlDGENKdS
         zpzzJMmQ33KLIMn+cOuKcRTwhoHyFQLFsaMlhSO+EvesoYM/px1r2lI5tqUkJD+1lk8U
         6xSXyd5XfyduswiB7e7DgXvQtYf/FhYMuZP4amnudNeiH9LIAw0H5lNBpfMR1pRVF92h
         qeoA==
X-Gm-Message-State: APjAAAUbsDcQM+kWkr9SaEjaLXM3LEEHht+qa+pJIPmgNM9qeipFrJgl
        9SYZm4Od72uFPSQiaAI00AYT4Q==
X-Google-Smtp-Source: APXvYqxTELyE6wBBpv0RVF/CiWCuiS/DzoiJfljsRzjGJ0ZeAkvVR8/1OnVwgtZL+cHJZ8Akr49q2A==
X-Received: by 2002:a2e:4457:: with SMTP id r84mr3087008lja.112.1556829328953;
        Thu, 02 May 2019 13:35:28 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id v22sm7711lje.44.2019.05.02.13.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:35:28 -0700 (PDT)
Date:   Thu, 2 May 2019 22:35:26 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH] mesh: Use node uuids as storage directory names
Message-ID: <20190502203526.mfglyyzsoudp6mtw@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190502130630.13890-1-michal.lowas-rzechonek@silvair.com>
 <a716514ec5be59e7e177c9a256238e314b4599d9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a716514ec5be59e7e177c9a256238e314b4599d9.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 05/02, Stotland, Inga wrote:
> Device UUID is associated with a mesh-based application and, as such,
> is immutable.

> However, the same application (or we can call it device) can be
> simultaneously provisioned on different mesh networks (e.g., home and
> office networks), which means that it needs to be represented as a
> unique mesh node and its configuration has to be stored in unique
> distinct location.  Hence the need for a unique node ID that is not
> based on device UUID.
3.10.3 says that:

"(...) each node shall be assigned a 128-bit UUID known as the Device
UUID. Device manufacturers shall follow the standard UUID format as
defined in [RFC4122] and generation procedure to ensure the uniqueness
of each Device UUID"

So I think the UUID is assigned to *nodes*, not *applications*
controlling them? I don't think it's legal to create two different
nodes with the same UUID.

To cover the use case you mentioned, I think the application would need
to keep track of two UUIDs, and Attach() itself to both - which is
certainly possible.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
