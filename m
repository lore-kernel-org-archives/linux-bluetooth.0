Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5931C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CE60F37
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 11:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhGZKvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhGZKvx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 06:51:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684BC061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 04:32:22 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso7725731pjf.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zG5q9oV7g0IzWbkhROUtYT1WDzo8T71gJW8cIXsYNNc=;
        b=PZxMBKdttVPvuYqWgvde1JBohkQt/T5KGfDTxUnLisEu31jMXsB8j3XmWZ16G3VdN4
         9dPadYdiC9byzulCMiHv0JC1GGP8grj3nvCu0JhLHkrIzmw1+Ho5zdeydERu7JXMvaLL
         +iWR0MGvyQGcHbVFqmQeToQnYhKu0cf2Dl9B0e+El0UaRuBBuKL8QrEgo41eK32xfiHb
         H6os02Ysa9EYIx+qGmNUBF3VnGtbD4+cvP+X4qzEiATk6NSglyVsqHY0Kz9/HmcoY0vn
         MaXScATDjiJYJUnZ6dYs9Xy0Tts63A5sxC3jx0UUkN+v7hkAdM9E+cX5QC7NMsyBrbjX
         rUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zG5q9oV7g0IzWbkhROUtYT1WDzo8T71gJW8cIXsYNNc=;
        b=gdcLYaWKPxsPpER4rUSVeYGsAHy/FH1/KwhfS1empRz6gBDD4jmuXaVz40U2L6VVna
         DsKSUAgjTBRyLEsdaKkDduXkV0rc4hDP4vBxe+I3A97OihupADfuL47ZzonyySPQSsuE
         N2FogU2K/rC/491QZXf51H0s4DoM2bnnqCfgOS440zc9BTkiRYJ2g4gS8MoROAEhWTy8
         QNKlZrNuG8YbLwRvZtPZCRRELavGd9szsZg/WVxYUHBNSs8xLAFfUv8WwXApaL+wLJUx
         gNQ2WlabsrI5RSgw4GulsC6FOFxt9CpHSb1+T2W/8niHfOlXRUwJLd4Dq6ne9sL+ZT5l
         gEhA==
X-Gm-Message-State: AOAM5325DuhPtSWMnWEkFCsV++rzboOnMwIEe1ROy8mt3eMdxTPixr5D
        z68GF5zJom3BLVAG1CMlBzE=
X-Google-Smtp-Source: ABdhPJwfRdBaljBxXB40Y2dHQCKmUsYTpQxi9cpJV1SUI7T2jI73F7cjcZ7n4tpkoVpqkM3UgQHOlw==
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id c6-20020a056a000ac6b0290374a33b0a74mr17001256pfl.51.1627299142027;
        Mon, 26 Jul 2021 04:32:22 -0700 (PDT)
Received: from localhost.localdomain ([49.207.128.135])
        by smtp.gmail.com with ESMTPSA id w15sm3522569pjc.45.2021.07.26.04.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:32:21 -0700 (PDT)
From:   aathif394@gmail.com
To:     imackinnon@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        Aathif Naseer <aathif394@gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Load Broadcom firmware for Dell device 413c:8197
Date:   Mon, 26 Jul 2021 17:02:17 +0530
Message-Id: <20210726113217.6162-1-aathif394@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210423151716.39598-1-imackinnon@gmail.com>
References: <20210423151716.39598-1-imackinnon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Hi Ian,

> > I have tested the patch for bluetooth microphone support for the 
> > DELL BCM20702A0 adapter. 

> > After applying the patch, I can confirm that the patch indeed fixes
> > the problem.

Tested-By: Aathif Naseer <aathif394@gmail.com>

Regards,
Aathif
