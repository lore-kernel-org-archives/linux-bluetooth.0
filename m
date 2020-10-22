Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34058C388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F0C223C7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 21:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUNNTreR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372127AbgJVVAP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372101AbgJVVAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 17:00:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74F9C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:00:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j30so3982089lfp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tdrev71KGOf2Y571CUND6kiORBHl4dOq08sNHY+E9iM=;
        b=IUNNTreRVlzDPUrD53EeWYqhZ8MZnQfbL7lQH5X1Cis2/drJ9xMY+9eoS6UgEpNJTW
         OkBUemqDpHzUO2weAXu7AXIW7Z2mxmaFZcPz5uxwYbQEd1vqjnmDGONGq+sDpjskHkBC
         S9HuDghqccTEj+M0UIm2JiEOhA/Tc5HRR8qkRqsgQlqjmJ7r4Jojn6VFnjgmWvBNmVyq
         aDFfY3xmqdSEAtorN0nRUjS3OQC+S3I0qXGNIEJ3qXLUPHG3wtPWqKwU3MyCIloimFdG
         gF6tYuRBSs09OufWDPIsP/J9R5t31WAZM3SKqMXlDV/icShUCnilJ8EbYL+ppt+DbVar
         KO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Tdrev71KGOf2Y571CUND6kiORBHl4dOq08sNHY+E9iM=;
        b=OZxrloTwbJvtuHnnKxuLvsD9q64WkFROfu1tY3B4MIIcjBRSNmQN4eKxx2sWHo8meI
         RZdHXW/rWYtT6IO0FN/RlIYI5ZEbeYdGhbQto0/qutzHslfETiCHErGOWavyaR+qcRm4
         pgjlg5F5V0fBJ6DQHXPma64Q292+lE62bBcx9Rj3jg63eOPkYb5bE1RIbaKgF6IG333b
         7YsxI3PyeD2PBbD2KttNJ29c1njPuH3t9xCKNFxPVyWIQsAhIEIqr4PRe6FRivcelFra
         398f0ym1ToGEulODGFY5OltIOJ0OzlM3u3bkSbL3ZhcTxsS1WfNbAL2MDIkdo3CB6Old
         Remg==
X-Gm-Message-State: AOAM531y8e295pxJz/Llqhb8vKP8UPIW71qR2jMEg4tVBq/mir9LYgHZ
        b5c5AEZVCsEM0+0/Ql7Kr8gtu+KlV6xraEph
X-Google-Smtp-Source: ABdhPJyoZQm9BsLaSaRsxoarHF5OaGnx9qsJ8ju9+SUZCqoD8+tG7lfROW5LjbEYKZArDcDeoyEQgA==
X-Received: by 2002:ac2:592d:: with SMTP id v13mr1336231lfi.355.1603400411269;
        Thu, 22 Oct 2020 14:00:11 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id f6sm434213ljg.83.2020.10.22.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 14:00:10 -0700 (PDT)
Date:   Fri, 23 Oct 2020 00:00:09 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: A2MP: Fix not setting request ID
Message-ID: <20201022210009.GA64331@jhedberg-mac01.home>
Mail-Followup-To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
 <20201019172529.1179996-2-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019172529.1179996-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Oct 19, 2020, Luiz Augusto von Dentz wrote:
> This fixes not resetting of the request ID when sending
> A2MP_GETAMPASSOC_RSP.
> 
> Fixes: Bluetooth: A2MP: Fix not initializing all members
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/a2mp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The fix itself looks fine, but I think the "Fixes: ..." line should
contain the commit id followed by the commit summary within parentheses,
at least based on how I can see this style of annotation used in other
commits in the tree.

Johan
