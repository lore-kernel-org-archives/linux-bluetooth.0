Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F74C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D892206E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hWjzR7gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFOIWi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOIWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 04:22:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B9C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 01:22:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n23so18045278ljh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RLXfQ1copKpZyGNfeccXQZcK9vBwWWtG4Q3CLR0OuwQ=;
        b=hWjzR7gSZ5O5fqDFGgNj+e4IUW7EYWvwUjAqcgrth49lkD/4/sM+OZoAly8bYogGIa
         8yEsLDXegVKvIVuK6c4nJOgeD8P0Dvx2z8AqrZih5urN7A8m4pLX64vnBLGYm3xmLrPD
         r7l3nCGj/itnVSE/UP67a3xZQAQQJ9P+zMzPVJ7Ji9mZq0W5nwEQvNvZlj/W/HvvKogJ
         bsLGD9AhB8NtLVdRTrOInhkfpXo3hG8BGyko4zanzXlgSufum2etFne9VGEdXo/HraAF
         j4bVFxW8SIav6yye8JHWtkQQVwZ3/H6RmEd8p5aTdoyjems2/TONMSu7yxkIpyuaAv6k
         faEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RLXfQ1copKpZyGNfeccXQZcK9vBwWWtG4Q3CLR0OuwQ=;
        b=tL3gTERjO+44d5ZmQaS8HhQ7EoqEfY5D17Auw92DhskNVwnrrMbwKUlQjDn/WkvkdN
         FIhvVavAwnuQrZwHDh8f0qglYNq8HBoxxF7wg2dsOrZ/E9vWERwcdQtOrkQu5ad9Xv3w
         1jnh3+AwgFmjz2XegIy7mqrpE6VPw9WbgUDkvgitoGcn45iZilxtwUrR8LIUYqvrWfEp
         4jo24OQN8R7lWtowkLsMlgZoYq2OfNxfsSXHoDzI8XfKSb0S73bvswid/7DKiDN7qqpf
         vyEZWkf92JtPL3YqR5Ux6SOoljVuL7ErN6E8Wi8FsxPP6KSq24F9XmKPkz2WVC/+oKu/
         O/Ag==
X-Gm-Message-State: AOAM532hAQm2uztydVDwT5Rezwo+qnSQ/Rykt/6LGPNNZJOErqo7K9IX
        SsFCJZhBaT9CgeglRIflVdKxlw==
X-Google-Smtp-Source: ABdhPJzKaiZeFbqUqXMYQkXB+50DkSQZ5n16WAHtYk8+QwDKUbUS7Hi0vHxcimNkO2SO4XAfNbC4Qg==
X-Received: by 2002:a2e:8950:: with SMTP id b16mr11659854ljk.349.1592209356185;
        Mon, 15 Jun 2020 01:22:36 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 13sm3663786ljj.83.2020.06.15.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:22:35 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Mon, 15 Jun 2020 10:22:59 +0200
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave()
 & Attach()
Message-ID: <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20200610171121.46910-1-inga.stotland@intel.com>
 <20200610171121.46910-6-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610171121.46910-6-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 06/10, Inga Stotland wrote:
> Attach() method:
> If Attach method is called for a node that is being processed as a result
> of a Create, Import or Join method calls in progress, node attachment
> is not allowed and org.bluez.mesh.Error.Busy error is returned.

I don't think I understand how this is supposed to be used by the
application.

So far, we've implemented the API by calling Import() and then, as soon as
JoinComplete() call arrives, calling Attach().

> @@ -1654,6 +1665,12 @@ void node_attach(const char *app_root, const char *sender, uint64_t token,
>  		return;
>  	}
>  
> +	/* Check if there is a pending request associated with this node */
> +	if (node->busy) {
> +		cb(user_data, MESH_ERROR_BUSY, NULL);
> +		return;
> +	}
> +
>  	/* Check if the node is already in use */
>  	if (node->owner) {
>  		l_warn("The node is already in use");

With this patch, this call sequence fails, because now we're supposed to
send a *reply* to JoinComplete first, and only then call Attach()?

I'm using a high-level API for D-Bus, so I don't really control when the
reply is sent, so at the moment the only way to implement this would be
by delaying Attach() by a fixed timeout - and I'm not comfortable with
that.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
