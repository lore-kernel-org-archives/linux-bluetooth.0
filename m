Return-Path: <SRS0=2pC7=4Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C32C10F00
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54059206D5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Mar 2020 07:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVxbIUwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgCGHvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:51:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40545 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCGHvU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Mar 2020 02:51:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id t24so2195278pgj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2020 23:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0T2PM8hYmpC+cTcDMNtIQRfi+KfzETyRuSQJNUxBWRw=;
        b=ZVxbIUwdJL+jBCTRNypo0vOUuuq4tJZC6P7LP0+H1nTnbTWDfQ87oFR1C3Qo4PM4+2
         bHCVeAi5Fs4Qr4vvr6U7hJR0E5ofJ0JHPBEdVLpdJEvRIeRHq0/fIFtOvikylxviX4aa
         CIs5BsjE4ZuXDsImW1G+OjnAt7IlsBFrCxGlTy1qbh16CcB9q1ziKz0HcaEmHs1rTJ7V
         xsu8Auz6CCftUE+uJqIKwN3WETCHN3cYphp8HrdGn7iY0jkrROFc/Wt6VqDN+IPYFYBN
         A6Mk0JqYH3UY8nDbR+yDvwAwDGfCXWKVBhiXoOrfx4O8bPpZ7TLyF/9MuWLmnoDjDrlr
         ltFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0T2PM8hYmpC+cTcDMNtIQRfi+KfzETyRuSQJNUxBWRw=;
        b=YLauO6lajSoOs+uYB4vo9IKBuEuoiQGFU04DzrrdMiii+SRb6g+ySWaVr57LmyabXI
         VOPReihTCmIaJiNhdGZPZEAJSrSQ+X1dsGIRgpPA40bd8ctKFIcruGjZdWjaWXZwoilS
         xu7LR8RzURA3XkTa1B6s8T6vyRsJhIX1QS+8vbL8owP910pZc8ERo3EJqT9UkjyYQDTp
         N8p8YKV4/a9i+Z/5s4YfaTzVRXDOBk7VxpyO4lm4qf5HwKEk2AFyvGQ9l8oFnv1+49ln
         UFXse5LSaxmMgqgvC/vCL3UiMaawZG8NGpnKn5WCYXPCzD7IdeN0UMVatDb9A7TUxKgV
         gV2A==
X-Gm-Message-State: ANhLgQ1shxQPpZUVnkJBcpYhKcQIAJgugUEcUdUhNz/51VPCaDY00/7Q
        fKflaPre72FVdJ38LSABPis916rUdemnEQ==
X-Google-Smtp-Source: ADFU+vuNyyIitGWKgJ6temBR9wJamCBlDEfQRsLRqzAYEQ+sKdDmGJtkJs9LrmX08IsVwlihHNqK6Q==
X-Received: by 2002:aa7:8089:: with SMTP id v9mr7877046pff.182.1583567479157;
        Fri, 06 Mar 2020 23:51:19 -0800 (PST)
Received: from localhost ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id f20sm11134745pfk.69.2020.03.06.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:51:18 -0800 (PST)
Date:   Sat, 7 Mar 2020 09:51:14 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix calculation of SCO handle for packet
 processing
Message-ID: <20200307075114.GA20667@kennedyj-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200305152839.92437-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305152839.92437-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 05, 2020, Marcel Holtmann wrote:
> When processing SCO packets, the handle is wrongly assumed as 16-bit
> value. The actual size is 12-bits and the other 4-bits are used for
> packet flags.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
