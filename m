Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F381C41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105252083B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8ntnkFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgJFVwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 17:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgJFVwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 17:52:45 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E964C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 14:52:45 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id h2so52410vso.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fBB2dN7PdVdzeo2GaMVbE6RJ04Kn9xtAgetaWZ+zY8=;
        b=j8ntnkFTswigoDlM2kyeqSJnc2fj4esZFkzvc+ruGDYe/EKQ32ogWQakV7iq525v7z
         bR0JIdfXxMtuGKKbkC97ikiGOh7EOcbTBoXZXD1aIuwSEEFV/PdWgWZmSjmtXw6A172S
         AShlaJNKVdo9XefO6oV2tFPa9wc1RaopZv+K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fBB2dN7PdVdzeo2GaMVbE6RJ04Kn9xtAgetaWZ+zY8=;
        b=BKBiriEbtAZnUqt3wxyeQ6LPhUBiip6ETzcX7GzUrfWLKex/uOizsYPA5SID3QBaOK
         ROzrqL9w/x/05Z+a7oz0Si3BhQEChxhYf8lZ8kt0c6Mb5GkkhKWTDjN9BuotfFeL8Wm/
         gBIP1xxUqYeojFbPEgvYWHD+fGZTuTzuw0Jws96gEBL9KhlhEJZcmAlpcShui6K+gUOO
         13UPnb42mgZe2zdP+IGY0AJGloq8rm+4hqkLFYyxU0qm9zXRYd+D4L4jiMbSHm57EqPG
         5f2Ly5FJ7Z6Yh3Yrxo4wB3jvZbE3KmIMqT7YcESO0zdNToNG627hZKh5XxuegkLbmTRe
         HrYA==
X-Gm-Message-State: AOAM530lz6j9JxNB09FUePYm98x2pZW7fmJ3yNadp8kjGeGYeWFH2B9d
        sqPBvyXtK/WYDbgAm6ey1jSEO7ymeccJatNosHbp2Q==
X-Google-Smtp-Source: ABdhPJzneCJCHYv0M1DrM76Ar6uigcbc3WG3NIajdN24GCsJGLRUKR6frfTDFPPkxH5b41lK85jBVXzoSJwinIYY7OI=
X-Received: by 2002:a67:f857:: with SMTP id b23mr57260vsp.10.1602021164282;
 Tue, 06 Oct 2020 14:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <1601997621-12056-1-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1601997621-12056-1-git-send-email-bgodavar@codeaurora.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 6 Oct 2020 14:52:33 -0700
Message-ID: <CANFp7mWU6DEuHxQqq+hnWfCnqrJLo=kY41J+uM7AfjEpTnzH4A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Wait for timeout during suspend
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

On Tue, Oct 6, 2020 at 8:20 AM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
> From: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
>
> Currently qca_suspend() is relied on IBS mechanism. During
> FW download and memory dump collections, IBS will be disabled.
> In those cases, driver will allow suspend and still uses the
> serdev port, which results to errors. Now added a wait timeout
> if suspend is triggered during FW download and memory collections.
>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
