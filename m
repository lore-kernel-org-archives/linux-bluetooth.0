Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EFC43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 18:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiLASq4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiLASqy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 13:46:54 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9BB71DA
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 10:46:54 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id n10-20020a056e02140a00b00302aa23f73fso2815473ilo.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9EceL29h4lz+VTrDyVsXoBv1dpybnemt6+9wisRpJ4=;
        b=e+y6e2RPo4OXFAaxWvK8b6/RiIAnQkHu9YjGg/MChg28/Wu11mfVcAKprUDJMSWQLr
         CGYc0ECXUWoJSb79yLhiUkt4scpelyH9AvbnXb74k6FKNhMH1gWRfEokqlcmXouzsMNa
         ZgeydWY7CifU0uD9pDByVO/0He/mNdUV9+bEavU2TyH2V9kqhNC0GAJu3jczfpQidYhh
         gWOkvXxUjsUjB9wdIeqRFSzuGimT+EQFD2J5WDS3PnN6BghRG7Wa55/NMr4gDE+WUYUz
         yMza1TkpN3xYlMFZJk5D6ArV8Dp5hpBr99PdAJEGwqwOFDolTVlOBASruOMfRW8f9Biz
         rqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9EceL29h4lz+VTrDyVsXoBv1dpybnemt6+9wisRpJ4=;
        b=1mx+Xx+nKi/pigkGP+e8fKr3dbDQy92bF1NsIkSeuFj8NRbnvGMwMRt6WDSwjBtVGC
         MoyBcYze5y+y+md/bYQQrTz0Cv4m6JErpfcfrMMLnbiRDDuWdOjRAd4ZYC++vz7m2mB7
         p9qk3NFfhUl4iqXWgexM881sDM5lSq+Gr+Ud24eixYsMvPBv7O9Ku8zrtR/FEyx5psfI
         b1LfWpptBvu/81RTAe1AQYuZittUED70f/jxH/29YeSwCZmYle83dfbZRGLwxg2wFgHA
         ug8+5qaRSwWMKYhBevfQetmkS5MhNPEcLgGEeb5ph2y/uWRqvAovm1EMg4OpSnR/AL+4
         qJ5w==
X-Gm-Message-State: ANoB5pl+XCTe2Pw+feSPVsdOo7b1IZmPcn+bTV4laaAMgjHWRmwDrBIw
        NP9rD79ARoArvWh81mEBgBCkOS0JxVUqMjyjeiRQuSUFYLBtF0UXUkBfhW6vTcm39Nb6SRuhYfE
        +ANVPa4nDg9LXvPu6HfBYEy7Qm844WJu4kgxQ0RTmmDzj/TWy5shqXOfG7sf/e8aqjzTODicUKU
        /+O4C9kA==
X-Google-Smtp-Source: AA0mqf6brP/5hVvSNHUMYxmIywZkysB8pEWWQegtkf41F0jKd6/TOgUAhBDBVwON7R2xY5J7Zn/ra1QnKJBAujU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a92:de07:0:b0:303:1d4b:aeec with SMTP id
 x7-20020a92de07000000b003031d4baeecmr7937214ilm.125.1669920413437; Thu, 01
 Dec 2022 10:46:53 -0800 (PST)
Date:   Thu,  1 Dec 2022 12:46:46 -0600
In-Reply-To: <ed43586d-5db7-862e-f012-1f54b5b6583d@molgen.mpg.de>
Mime-Version: 1.0
References: <ed43586d-5db7-862e-f012-1f54b5b6583d@molgen.mpg.de>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201184647.4060523-1-allenwebb@google.com>
Subject: [PATCH BlueZ v4 0/1] Fix spelling error in the commit message
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of the patch fixes a spelling error in the commit message.

Allen Webb (1):
  bluetooth.ver: Export sanitizer symbols

 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

