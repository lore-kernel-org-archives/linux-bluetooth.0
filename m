Return-Path: <SRS0=2Aeq=X3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A329AC352AA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A9020842
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Oct 2019 13:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="U51mhLQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfJBNb1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:31:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33573 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfJBNb1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Oct 2019 09:31:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so12771315lfc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2019 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0FtEYUu/cXLCU2Wx/FRgEyJ+h1UqlVRpNKuJsg7dsZM=;
        b=U51mhLQZDXDq/uBscDo7ainXu45o15EqkJxFOo1pcR+XnS2EuGGCJ1O5wgbjFpkqeS
         8Cr/hflQZtV5OmTy1ncn3OiqZZBQL4dq52M4cPDICltN0ojM3xXrrQmEqgl7nXVHlK5a
         ognGSf046RrTibUFGyu00l3s2wR6NMx+h2E6Ca4E83PrzKTNl7lGCaVLeSZcNcWqZ5GU
         Pirmpq9eG2pICMO+gv9wmSGpG20qIgclfiUAFJbvID3Yvub7yJ1rNhV9tU0s1Y/dmiT9
         JQj7XSFqEMsfihnrSi+u/Jw426qZF0sF6ktwYUtfFnudE9otAm3cL+neHoUVxGGm8wHa
         J6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0FtEYUu/cXLCU2Wx/FRgEyJ+h1UqlVRpNKuJsg7dsZM=;
        b=S5neAEyLyPEZoeQUDdibhLftDscfA7bc5XYnEy2uQ3ysrfTgcxHTm1kTQ5tJZgkSdv
         pmm783+JtO10wPYIxOcLNwyzMsKYq8dtP4It01QRlOqK8fJEQAGroKhHV5KV2c6ferkI
         ud51ryG7XLJv9kfNw9dRPDeQog8Xi5JhwwFc8HDl76Gx+89nuKTSKhTQyRPxV/49Fj0U
         LHte6xMTwlFnlFcbYMmJkRYOBxaBEl3rx4JUq3hq4EKvSqGZCcoX9lhu8bgBzo1+bxv/
         gNgo2H3Co0tgf1cW6HA1Vzl/k+ZL2k1lrs4H2GmeDdKIKcJGc3OKBi1/4kqNX+WNb8AS
         A31w==
X-Gm-Message-State: APjAAAX2cKm7s+D3vWUUhCPQGB+52ke1/vEOLSJxpoGLpsEdFUeModwl
        sexIwApZ1eP5Ixm9U9YzfUo30Q==
X-Google-Smtp-Source: APXvYqwaodZsRA7Shfo3PGyJurQsjLbti6KGkPmbXJ/3+O0wm8qr137trZlNcKYsjGf5YjyiRCFXBA==
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr2338967lfq.71.1570023085295;
        Wed, 02 Oct 2019 06:31:25 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m17sm6183743lje.0.2019.10.02.06.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:31:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 15:31:22 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2] mesh: Fix IV Recovery procedure when IV Update
 is in progress
Message-ID: <20191002133122.xha64n3el4klliul@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190909192509.15007-1-michal.lowas-rzechonek@silvair.com>
 <547a20d9ff42c6b404bfc646812a243cc2469708.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547a20d9ff42c6b404bfc646812a243cc2469708.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 10/01, Gix, Brian wrote:
> The problem, I think, is using the iv_upd_state (which we need to do 
> IV Index recovery) as a proxy for the actual state of the IVU bit.

Agreed. The IV Recovery flag should be tracked separately from IV
Update state.

FYI:

We ended up implementing two separate state machines to process IV
Update procedure: one for 'not synced' and one for 'synced' operation.

Node starts in 'not synced' machine and moves to 'synced' when it
receives its first SNB. The move is one-way, so it's not possible to
move from 'synced' back to 'not synced' without resetting the node.

Both machines are fairly simple and nearly identical... but moving from
'not synced' to 'synced' is far from trivial.

In the end, the whole machinery is rather complex. Reflecting this
approach in BlueZ would require quite an invasive patchset, essentially
reworking the whole IV Update logic.

I'm going to try to document the whole solution and get back to you.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
