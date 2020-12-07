Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A10C4361B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D99F23444
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLGNsg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGNsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 08:48:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A85C061A4F
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 05:47:21 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c12so2924316pfo.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BR0ORvff+Pe3m9IN4Cn2Vhv50vxwYPhrpDVwqXeTJr4=;
        b=YQtQ8A/qJOS64Xa/5bMcGExrkmFZg/ZXgreyg+6nZdYnVdPLMwy48HebjN6a/8uwta
         0B7ReI4g2SjGXpsg96lye884DC6YDo5cm8WjsTO8CmlvAIA3MpQsIYI88fz06gBsJxSp
         neJ8A9KBs2hCv7rs9CpjjzF04uCvefRp8Rzi4PxfDmOMr9j6ESmdIEsJyzsUArRZoTqf
         e8aybJNy/mgOB6dpJ28zqJiDp6ZUBeNwfOK/wtl9IePiHCgxqnC7cpCM1LWnnfFVCvog
         MMS+STeVQMsqJeJ2kkJdeZ8Rxewb6s+pbpXVDMqOoOY3I6zgZn5htrB0Mg9OhWkLycP2
         e2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BR0ORvff+Pe3m9IN4Cn2Vhv50vxwYPhrpDVwqXeTJr4=;
        b=UWF1wzaMZ09F18ppHznd05sIwfqR9cnfm0TeH1Rj9izBubMQ/2myp+L69U186Zvqe3
         Eh/R0Nfen12FgkZpqjfaIbKh40qe8dr1BLsFNO8Sy0wt8pA/YQZ/LPVQcKvu1EGiwXyx
         Xmxw9cLwxdV/z6C0EJVHk0T3pVTxp3yyQN/FFqOlGSJ0gmXc1CPuS1obg48sRYCkeE8l
         D9l5Atp5J1CEuwDLYLjoOJ+hpY82Be5L1yfyDKr3l+Xo177n9bXR8EPmQVw8tN+R7bSi
         tSqiqGdO9vd7ZsG+cau+Z0iDYsm0E9UWrTuZNs7C+K+QkYUOhLVjNJvPWwo6atXLK/Je
         EPzA==
X-Gm-Message-State: AOAM531JXEGc8Cosu69rnBH6nKonMXKzRCV+vNvzD6+ccgOOmu7MKeY8
        Rq/YaVhOFyHC1VRQogG1Ru3Byc84HxF1SyP/
X-Google-Smtp-Source: ABdhPJzqC2UGYFsl1y1i7DsWiYVXnvuPQXf8G8og4bUWlWz2s8ChZpX+L1EtDZh7szsKkVqGrRSx1w==
X-Received: by 2002:a62:4dc2:0:b029:19d:b6f2:e7bb with SMTP id a185-20020a624dc20000b029019db6f2e7bbmr15959690pfb.74.1607348841075;
        Mon, 07 Dec 2020 05:47:21 -0800 (PST)
Received: from localhost ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id l15sm12339809pgr.87.2020.12.07.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:47:20 -0800 (PST)
Date:   Mon, 7 Dec 2020 15:47:16 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increment management interface revision
Message-ID: <20201207134716.GA10089@johnypau-MOBL2.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20201207100209.128306-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207100209.128306-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Dec 07, 2020, Marcel Holtmann wrote:
> Increment the mgmt revision due to the recently added new commands.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
