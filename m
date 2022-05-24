Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiEXVVe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEXVVc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:21:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF0D37A0B
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:21:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y199so17510745pfb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LVh5+uHWDfw3tFgRQN+VQcoc4Kz7ETRMta9HJRagE4=;
        b=ji3FdMFqIbZFfZBEfv3Y+ltTybqA7UMCmJ1ViBwfZTMDm4eAwHw2xTuIxZb0vJ5aCg
         +FqK/QM3+ZZ+IrtKHSygIXoroTcTzq9iW34GoBWD+ebRqj6u9K8qa4SQUCAOXQoOAZJn
         qIxGA64BzapaLFUKnZQWn/qWSYPn+5Ka7BGVEvBfrrJJAFa7OL4y5ug5K61RNtF2DzV0
         YBjAIz0TlB4Jv150ylgNNo/2cDSG6x7kwelEsP8FONIVnqcMunyU7o2cAwyW/Kdk89hr
         R/fyIevGJZ928M9rDN3+rfJwrpNYJbsS0HhtbZzXKq4/2uiJDoAl15I0+vIzh9r4j9RL
         KCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LVh5+uHWDfw3tFgRQN+VQcoc4Kz7ETRMta9HJRagE4=;
        b=x60sR5WCCf91g511aaKQ+vYMkJli3c47nXEGmKjPDz30f+Zbgbozq2rX0VL8WKkpSy
         YzrrwfC1MZ9e5X445gFH2JBFxGiktLIVCUwaLXebRo9MFxN0DhYOZUqkrBcTv329n8PN
         +BwXnJpKoWqSGUVAFAEKfmh+B8L2KeExDxvbdQ69qqDxgFxpKF8IiKv1jVFMEeT/oxUj
         Ikxv7mYlVBYgwNPxJ+Ka9ou5CGi/ziEeRK+yND3yEDWlNw2cL1K2y/IBVLxdWTOtI9RP
         fex0O9gA8QWzcwqbL0aWvBHedYS78suNc1F9a70lLZmNHaUktCAnAjthNsIllSCqxAkJ
         5cCg==
X-Gm-Message-State: AOAM530LkcbUHKdvgo0RskYE2dlSOTgkfcQAW+0WUMJkadufjtx5vsVC
        1PX2AHbu9LMfArwL02sKwgI/gQ==
X-Google-Smtp-Source: ABdhPJyWaSA+5br2d2z/7q3xuvUYQFFdmCTh3SJeuCbrgyqGCp7VmnVaoOaxueoo6EM5HlDEuxV9YQ==
X-Received: by 2002:aa7:82d9:0:b0:4fa:2c7f:41e with SMTP id f25-20020aa782d9000000b004fa2c7f041emr30730013pfn.1.1653427291489;
        Tue, 24 May 2022 14:21:31 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b0050dc762814asm9986464pfg.36.2022.05.24.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:21:31 -0700 (PDT)
Date:   Tue, 24 May 2022 14:21:28 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Message-ID: <20220524142128.01acb75a@hermes.local>
In-Reply-To: <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
        <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 24 May 2022 13:55:57 -0700
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Here is a tentative fix, I do wonder though why you were trying to set
> the name directly and not using the likes of bluetoothctl/btmgmt?
> bluetoothd don't seem to bother setting a shortname so it is probably
> not reproducible with it but btmgmt does:

Not me. I just forward reports from bugzilla.
Any networking related bug reports end up going to me, and I filter/forward them.
