Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B7BC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1AD222C4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfZda5B5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLKV0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:26:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40438 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKV0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 16:26:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so25730427ljs.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/uI6Ae+FdlrGQjCM4aBha1wXdbVJjtHkfpjf0SnUsE=;
        b=NfZda5B5idlP4SMgrTW+2uBQFLWW5xFf7HzHSAUG4WOu+ToqQ15MJONW4JuQqxq/B9
         7q/YsthBbCgi6PCCpbxihJxXEgxsTgWfE+4hlbIeDSzky2nowSgdZIlZiSnenmSCWvko
         sZs6373hiHF2kTY9I9JYDTZe4+RSIwaXB1DDow3svnW4S+p03L26c/v1utaDt/MIYpUy
         PyilbOdG3NqNVGprUgfNQTo7a9sPoH7fjaBWgaD0dimiIbUBNBtXLBNH53pc3D1B0Oqt
         b85wyGrwzVIIqK25pjZJj15aBN3TA6J9lcV+BeWviWpLCAft2C7Ds43HjblyaKufYdeE
         elqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=a/uI6Ae+FdlrGQjCM4aBha1wXdbVJjtHkfpjf0SnUsE=;
        b=KP82MQ8NwMbauQlG0l+6fD9tCK6OcMEn11abu+5vjVhv+fw9lh/LeLVlvRJX0afWro
         hLwl2XUiiy424sQ9bkheY6p4oglYDNwQxeIYsUZuFYfOQ6qwrPymLhmftlneJMSjPC18
         sIWNzMhKT60Q/Ac3L3/gRGIsFcRP6a/SmPKLfMvFQJjkcXsTIDGEbr1gkxnJO+Aa0VIx
         tVG/kExzYnnE91qFO9o4L1DdrUtKxofz5xlcmPB34XT3CSRkJWRRjRMlWLVAU7uQ7QG4
         w5SaW8qRL6fsxW3AvSRqlEsO6V1eUy1YraziyVYboD22ckd6e3oiLMDNz6381xpmlgM0
         5E/A==
X-Gm-Message-State: APjAAAXuhXyRNSftXyLX2thUAVkssbDiRCvWhwAcuZEY0CoxXmnjJa4t
        keTn1f/1zZCvOsXHe9aoTvw=
X-Google-Smtp-Source: APXvYqzVPiN5zIzzSOtbMfc4SMlADwPTw0jXEHKcnez1SMBPhBt6eGUQ2ijYVbgKP40NgqTqsaNHFw==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr3641393ljj.147.1576099567321;
        Wed, 11 Dec 2019 13:26:07 -0800 (PST)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id w29sm1551556lfa.34.2019.12.11.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 13:26:06 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:26:05 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove usage of BT_ERR_RATELIMITED macro
Message-ID: <20191211212605.GA34367@jhedberg-mac01.home>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20191211103436.15369-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211103436.15369-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Dec 11, 2019, Marcel Holtmann wrote:
> The macro is really not needed and can be replaced with either usage of
> bt_err_ratelimited or bt_dev_err_ratelimited.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/bluetooth.h |  4 +---
>  net/bluetooth/hci_event.c         | 14 ++++++--------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 

Applied to bluetooth-next. Thanks.

Johan
