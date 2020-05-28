Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF9C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3475F20814
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7b1Bkhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404342AbgE1PRH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404335AbgE1PRE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 11:17:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED1C08C5C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 08:17:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c75so13610219pga.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oxRd34Wxun9nW+kBKYd8ek/TIpwGvvJGkUBghSmTo/M=;
        b=E7b1Bkhhlu107mfUeAd/DeHi/NlpmNrFcQyzK/ljKSgNsYZFSAIIGxiM/pZUnGnWPV
         37n89LF/8CdNzNEPy06WjDQuEZHXPfLUIcfgOq2cPgiUd2QhuRyZnfnLM84XCU7TAqbn
         a3y3CZBzDxfqeUUt5zIVIPhhjECLPjEu7A5iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oxRd34Wxun9nW+kBKYd8ek/TIpwGvvJGkUBghSmTo/M=;
        b=AAvLPD5O8USmjdswKXeUfwll+6hi4xV78eyjM/6FpUrWYGzTg2h8WcYqix1XPH7SWc
         jGAch6VaXUEvPRtRkNb7CdmO0slqRYCJtGyF/NiP8QyCgk00ULrzVVOBwcmDDYPyDXkG
         Egk4Nb2oUprbE6041yYowVR6A3JJ7WViZpgZ5FkJ4VCsoyGzgUljFaTVjFXWMHZTrkm7
         XP4zTqj3I6vSi3/CM5/reTwReFdxw3QfY9W4cp/oKvJyhDjOBicDZBsz/7NjhgYPAVO4
         UvT/Ky4ZHV+jlihDedm3HRpuk0d1u+YAO86YTOf1o9VkIjLVYkCG7EDCNRZeMncnHfRZ
         d/Gg==
X-Gm-Message-State: AOAM533ec5QlVzC7ZU2S3y+0WRyDbVYhXKHTeAOIqypkvdEG/G+Zvfy6
        JKCvnyYXwAUb53my4Sl8BRNisSOhVJ4=
X-Google-Smtp-Source: ABdhPJyxzHAYaJd5Z6GbAf+TezrPlzuSkqSImxvxt7Ed9e478gZdxwkkDr6qOku13suW+nr9oaU/lA==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr3695218pfa.209.1590679023291;
        Thu, 28 May 2020 08:17:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h7sm4642562pgn.60.2020.05.28.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:17:02 -0700 (PDT)
Date:   Thu, 28 May 2020 08:17:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Improve controller ID info log
 level
Message-ID: <20200528151700.GI4525@google.com>
References: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, May 28, 2020 at 07:03:17PM +0800, Zijun Hu wrote:
> Controller ID info got by VSC EDL_PATCH_GETVER is very
> important, so improve its log level from DEBUG to INFO.
> 
> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>

Please add the tags from earlier version unless the new patch has
substantial changes.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
