Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B8C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 17:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjBFRa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBFRak (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 12:30:40 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE67C16A
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 09:29:40 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id v17so13669928qto.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 09:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/LaKIf+3pRA4MyQMhbr3PlVOqptn/pf/udFxon0+9Y=;
        b=f/zPVvxgvXxK0hkHhT/HSBYb/CW8C+VI5oZGFfqSEEGpM7NV+2TAFXUlNk95iFNbtp
         FDGEQmOruqeJIf8gnp6Nn+hnKFG8vOhC1BB6K6eK6S8QnRcVSImKwc6TenkzDgRrnUIb
         7+H/v/sOLjpmaiwamxs3pVDQXiFqxwaBeksWKCzyANRAOX+ftCwhW3Cxm79NazVHFJUN
         VFCxMJxYDBxnUcZBTToUt+/wfjSvqYsF86jrikdx4Rpe7ydR969M9qwgGGNSf+tUrTG5
         0zYepMrQ5BY2Ug20WOE5g+G1KPJk9rJBswdssHsT1bS1lAxtDPgJyQGsK1qCTxhv8rT4
         dJQQ==
X-Gm-Message-State: AO0yUKVbtLy6MHGZ7Da8TooDGySg4PqOSyvCrK8+Z5E9RQzI07vSywbE
        eXtgenVRkDPZiOmBDopu+4D+
X-Google-Smtp-Source: AK7set/ae55jb9i/baaW/xLk4b7RJtQzOV+41D/ChSc6zOFdBQ9usaCQZSB0nyipHZthrt6kgVy39g==
X-Received: by 2002:a05:622a:c7:b0:3ba:1398:c68d with SMTP id p7-20020a05622a00c700b003ba1398c68dmr150769qtw.16.1675704579799;
        Mon, 06 Feb 2023 09:29:39 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b13-20020ac844cd000000b003ba1ccba523sm3956815qto.93.2023.02.06.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 09:29:39 -0800 (PST)
Date:   Mon, 6 Feb 2023 12:29:38 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH 11/17] dm: Remove completion function scaffolding
Message-ID: <Y+E5AkiVTbjgXWjs@redhat.com>
References: <Y+DUkqe1sagWaErA@gondor.apana.org.au>
 <E1pOydu-007zio-0W@formenos.hmeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pOydu-007zio-0W@formenos.hmeau.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 06 2023 at  5:22P -0500,
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> This patch removes the temporary scaffolding now that the comletion
> function signature has been converted.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Mike Snitzer <snitzer@kernel.org>
