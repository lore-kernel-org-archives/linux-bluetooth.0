Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D3C2BB85
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 09:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F28C21D7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjwlk9kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503968AbgDPJoG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503681AbgDPJoF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Apr 2020 05:44:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF3C061A0C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 02:44:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n10so1430623pff.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2020 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73qIqG9XIJzLC+J+cf2hUS0T48eUKRhxcJJ7kJxxd6g=;
        b=Xjwlk9kKcA5ZFmeeI+GlwammwL+xhHY7Pwc2rpPyC5dQylUzXyxgJdtxRzWh/X5t31
         7SsWWBd/lA563MnD4LktCv0KbsLHJAUR9+eWr0g0z6H1Rm727hKI3hPm+qCzaBrqSRc+
         dyQmoVyI/Agl//Wy2xhIdJZcaWybLskgeheO64e2BYwcwzvt1ege5FbiHTahDkllxEy2
         u97zrRr8E5TtHuOkuKuZaXWOnEZ/GJ2kPn12ZuaIlPZIykHC/Ai/g5Yew1rb7FvvKdwt
         8Z0AWP8CHUSEdsvsSxGPD8YGgV0pYTZapGxnPvbvXjiegJnE7vASwqEDanSGEz6CBdp/
         31vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=73qIqG9XIJzLC+J+cf2hUS0T48eUKRhxcJJ7kJxxd6g=;
        b=Vwnu4V+E7xRVNlQ1KR1WED2k+Zr2fpcVGly34yr2hESAM6JvusiCqkrHEyfzlfuwYr
         O5mdNsfObJYgXxAsQZUO6/5v7kN669yk04JdILMrsyfRkRF/rDMUyDz+6o6bLctwvSJv
         K9ZdXNxteRUoJ4/j/J/3829NxaKrlvHTo06xYEWiG2D89xRlfbVwsGqMqZdwL29s60E5
         Tx41xLohmK/EGfMJ/xcaRFVj33xXiay9wiFg6VHfB+XH/aTQfJo/Nd+9VnGsfJK5sCHs
         FszmrHRUEuMw/cFt9AdpPy0T0Cs/vdGH3brfbaCxFDz5vJ1q0j4o7iugesYjVDA2ukOB
         gRDQ==
X-Gm-Message-State: AGi0PuZogISKNm+io+7Tw2KgnhXRP7l3zxUr3BJKzLklfDhbojnd6s6N
        vg1l3GWB6BexBGeYo49bDu9/6s6AfJ70xw==
X-Google-Smtp-Source: APiQypJpcgzwi9DNTauKHDuZ+1AVrsZ1CqLw8sEWwoaxPE2UmY9ypSWxlSt44am2m8u+PUr/y7oSYA==
X-Received: by 2002:a63:fa15:: with SMTP id y21mr29144437pgh.296.1587030244348;
        Thu, 16 Apr 2020 02:44:04 -0700 (PDT)
Received: from localhost (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id f3sm2034761pjo.24.2020.04.16.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 02:44:03 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:43:59 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enhanced Connection Complete event belongs to
 LL Privacy
Message-ID: <20200416094359.GA16609@spluber-mobl.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200415153516.38267-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415153516.38267-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Apr 15, 2020, Marcel Holtmann wrote:
> The Enhanced Connection Complete event is use in conjunction with LL
> Privacy and not Extended Advertising.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
