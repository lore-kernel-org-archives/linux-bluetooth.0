Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D8BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB31660720
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 15:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhJ0QBl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbhJ0QBg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 12:01:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CBC061767
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 08:59:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so2410449pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DN0M028IcPxor16NY4zNQ6KdrEsEqQ5iFPl6MyAoGPA=;
        b=Hkhe7iGI0K8SRI1G3HZ34zmXt2hr2U6Wv23X5uzs9hqgrmoqBYpKYqOkWURliScyfl
         IvDZ+wE+pmZvg1s6bdM1DVjTdwZ6KV9UyabipNaL9+HIH7G+orE6YRkq1gaSF1jeagkO
         J34i0OloyLcSwHnEnauUleIQOi5a/xeGJYriA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DN0M028IcPxor16NY4zNQ6KdrEsEqQ5iFPl6MyAoGPA=;
        b=qWCDd4/nTWIMDEpvFfQ3GAaBu31jOK8+0E/vAtwn1F3VeEC5Oisi7GmKYqPU4UsxAT
         JPMQE8tfJNrPp7pI4vk6Qx2rNiAsNtAiD6NrGItQDnp1euy0pfRiSrN88AkpDDL2NY7/
         KC2tPdZbkDuub9fw3BPGlOTODp/1Vuq41aHGYQSCwEuNwoC8Og/3ILaarxpNfcpXeh44
         nz0PUlwRS3LpX1PdXGN4hHX6DuSq/01rU956k04YXBzKbQcT+2m+FutBVXmNNxJsP9fI
         rNUqvpO11aHPP57/8ZCPRBviOn2CA2279oCwpohOooELgwI017G76uYLU9BcnOsapzw7
         YBEg==
X-Gm-Message-State: AOAM533ZvDdTNPhpgV8I1p2Reu0RKLQ/J+PAtUmoUsvfG+MPaUnSD6xk
        WJWg+HXQGofv7BTUNlhQXk8bZQ==
X-Google-Smtp-Source: ABdhPJzG8mDMEBfswvzruxZuiMix01R6gOyZzzx38cUqlAm2dSx9WAjyiVtH8UA12FRXcQgLpTLiLw==
X-Received: by 2002:a17:902:aa08:b0:13f:eb2e:8ce8 with SMTP id be8-20020a170902aa0800b0013feb2e8ce8mr29833672plb.0.1635350349227;
        Wed, 27 Oct 2021 08:59:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5ca8:d6ca:59bb:2694])
        by smtp.gmail.com with UTF8SMTPSA id f203sm386161pfa.112.2021.10.27.08.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 08:59:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 08:59:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     tjiang@codeaurora.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: btusb: Add support for variant WCN6855 by
 using different nvm
Message-ID: <YXl3S7TT30PFfyB8@google.com>
References: <1d19afff955cdc8d47582297a26246d9@codeaurora.org>
 <YXgrwKUZwUWuWfG4@google.com>
 <fe118b60df5881b0e9938f57aae6f87e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe118b60df5881b0e9938f57aae6f87e@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 27, 2021 at 02:12:07PM +0800, tjiang@codeaurora.org wrote:
> Hi Matthias:
>   the previous patch is submitted by zijun , as he is not working on this
> project, I take over his job, so can we assume abandon the previous patch,
> using my new patch ? thank you.
> regards.

Your patch is clearly based on zijun's one, it even has the same subject. A
change of authorship shouldn't result in resetting the version number, it's
still the same patch/series. You can always add a 'Co-developed-by:' tag to
indicate that someone else contributed to a patch, or use a 'From:' tag if
you only made minor changes on top of someone else's work.

Not sure how to proceed best with the version number, especially since there
are already 3 versions of the 'new' patch. Either option can create confusion,
I guess you can continue with the new scheme, it seems the patch is almost
ready to land anyway.
