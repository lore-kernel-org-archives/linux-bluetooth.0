Return-Path: <SRS0=7bNH=57=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37EC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 13:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558602076D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 13:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob1owOHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636274AbgDONwT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636272AbgDONwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Apr 2020 09:52:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993BC061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 06:52:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so1522520pfc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGz/L2miEmTu+tQA1MFnDL60D9N2vYuQAn3/0FzKdBc=;
        b=ob1owOHVD6nyWAaYDyzeV8uQVmeXpkgIjwelObkmNxkoSFhjwlLu+NE5P2KvcSzrMz
         Xm87DgXGPjUwdz54F6Jc5aEDPcF4lCtkU76iFqtN7yFudIY+1+kTbx5QhF6bTZUp+3TI
         zRMUXfgkDiv8x+6jlNo6SRgFwJ7OEdYsocYYFi/t6+19wLtb4fPqPniGx8g7yyJvFtHY
         dN4InXpYnSoJufEwct9BqOZe8KN0WnkmiTvJUeNFs896HI2qySSu8efhWHpBsZ23vK9p
         gKI6C+6+QGZ+jzpnPPS2OOWtjx3j9gkQ1EQWm35l79LOfRy9CAWUVXCtevmJlk+NZF/P
         N7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HGz/L2miEmTu+tQA1MFnDL60D9N2vYuQAn3/0FzKdBc=;
        b=rHbYeYu/ye1ui6x84VgKT6au6NEorQwH7zOo3OJvSwxHkl8EQU5JwAk1OiBBVG/Gzv
         /pL1tixURwF88c7a4bkv/bhhRNxspPWZkXJl2kry58Lh3Oc3r/pjHR7RSIzXAHB7Qwhf
         W5trKE5zpmNLOPqo9z/msM9VL206611GCKSGTRfAnn2tNIc3eATuqwlIGvXS/53oZ4Lo
         vUnsmqGW+n2AFGErR+6Z9fUprsBV1CUzeE/sN8xvuPrXf4YmDrSi/bYGNOeUJKiCE2dP
         Jn2jCMn8o7vIBeU0jwuu2AZAa5rE1bg5snd/V0pcUK5Sg6Nch5Q7Nm2UKdF2z46gspYc
         HHgw==
X-Gm-Message-State: AGi0PuasoBKAy3XJM7ybAt105rD4Inqf23ItJXroYQFhw1np1yS3V0xB
        gwq+tAjgVA+LQ3XuVeC/7gZEcZfxWjPwvA==
X-Google-Smtp-Source: APiQypKJ8kw+o9EoA4U3TI2GAvH2TrzfBB1UeTSjh7762nO54o1Yo1yMikBLFxXZ1UBo0g1ywtytGg==
X-Received: by 2002:a63:b542:: with SMTP id u2mr26710578pgo.352.1586958735526;
        Wed, 15 Apr 2020 06:52:15 -0700 (PDT)
Received: from localhost ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id b4sm3797071pff.6.2020.04.15.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:52:14 -0700 (PDT)
Date:   Wed, 15 Apr 2020 16:52:11 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Cleanup patches for LL Privacy work
Message-ID: <20200415135211.GA7222@mshaanan-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <cover.1586412226.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586412226.git.marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Apr 09, 2020, Marcel Holtmann wrote:
> These are are few cleanup patches before the LL Privacy work can
> continue.
> 
> Marcel Holtmann (4):
>   Bluetooth: Sort list of LE features constants
>   Bluetooth: Use extra variable to make code more readable
>   Bluetooth: Enable LE Enhanced Connection Complete event.
>   Bluetooth: Clear HCI_LL_RPA_RESOLUTION flag on reset
> 
>  include/net/bluetooth/hci.h      | 5 ++---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_core.c         | 8 ++++++++
>  net/bluetooth/hci_request.c      | 4 +++-
>  4 files changed, 14 insertions(+), 4 deletions(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
