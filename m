Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F85C10F28
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6220838
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 08:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMvqmPTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCHIus (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 04:50:48 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50354 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCHIus (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 04:50:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id u10so1407192pjy.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2020 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMwxD6lix3M7vEz9qguvc/d+y0zfupNFxfC686zxTNs=;
        b=lMvqmPTRCsApXjbpMCRCxFjXb6Dalvq3lk2YdW+coGJLgnzhNAXjIBXJnaTPYHPWWG
         55j8Msqh0HdoOKBTSIFqUwqyFHre6/TFxMyOAtUZX1Jpi/2xb7/w9/zpGlMhdY6SDpoQ
         LvMn+jcbCCFCLYKNiJn7SvaxFrRxjByipuwbDWqzoifvmZbHVrQ7z/AQ3u/CTIKAh1oZ
         T9eKOoewFp8XbKx9RnlVQ/9EVV7wjzz+Nqn6vGP/UstOKVi9rDqidH5u3s3jt97/C82/
         /GjXG+6294jyRz7pguElBAWOrQjPE66H9vnXC35ZTQgsvVpriJMQLjMynyjb75rOe+Go
         nGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pMwxD6lix3M7vEz9qguvc/d+y0zfupNFxfC686zxTNs=;
        b=s7dQ0eSKR9wUNiRm3bSTmPtBTlawtgRAvr7nYHlGJHqhDssYtH/hslLAvZmMSyXS1I
         FRZrJuAkuGcbF4ujVipGgv+NHu1LgiCcKmia5kvKNzNgPvm56A7Wu36XIXcttP2gbXtX
         Bl7X3CpOV9dxthKyY4f3B1SEpmcup+VvkVpcW2sKvomg6LIvEQC7Sgc9ocaviQrQh95a
         ZsFIHZRU5CU4CouBEeSo9DKOLWEKF6lLo0PzHwdio0ODnbPxGEWzXEDAuRLkj9LjNB7Z
         f3HUhIXUHTodyvD591KoQ0cl6UEYaQPMGs1RTNcvluZ67ToQBxRwDIFSSH3Hc5XXHLPv
         UiyQ==
X-Gm-Message-State: ANhLgQ3BSGGjJ66zYVNYvElYhCNVOv8RSLvBE6SYbq4waQRBm0ERv4w/
        bK6ulxc2EW/j944ZaKYzRlo5owsdkSO6DQ==
X-Google-Smtp-Source: ADFU+vs1yXW3jL+vC8Y68KxR+Upp7y8bq2bgqMCefHqEFQd2My2+IeV2IMqNldQ7gZSH9hQVNczgUg==
X-Received: by 2002:a17:90b:8d0:: with SMTP id ds16mr13168889pjb.75.1583657447154;
        Sun, 08 Mar 2020 00:50:47 -0800 (PST)
Received: from localhost ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id m11sm14675850pjl.18.2020.03.08.00.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 00:50:46 -0800 (PST)
Date:   Sun, 8 Mar 2020 10:50:42 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increment management interface revision
Message-ID: <20200308085042.GA96478@kennedyj-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200308081250.126797-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308081250.126797-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sun, Mar 08, 2020, Marcel Holtmann wrote:
> Increment the mgmt revision due to the recently added setting and
> command.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
