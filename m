Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A94C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831CB60E8E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhGWLCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhGWLCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 07:02:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C5C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:43:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so1191871wrx.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7joHR173kmsc59rBBr/ksencMbsFUjxYr35XX72uJ4=;
        b=XmDE1aZ04m4QoePKjKFJawONG0A6JuZs/DgUv0j28eTcPurXk++wwQGYzEZtls3jVu
         Xod3TmM4Fyls9kKhlk6XdWUSypFAzgBgg53DWjxhbDuzlNzNbLaL/qWoEz2a3xN9zQtC
         LYDGKY3310RxmO1CvWKcsrhQg6MpdlcKQnTfaQ74r90KDBW9EmVe/8F4Gm0Am/mxZtyp
         k8mlnAlOj4P05/yVIgxsTB24IaKfoVnyuXPxBchHaocjjsw8DI/hVXEPjDWuhCHrPGK/
         ondyvi4a2R55a3uFACQydfM/HxZY2oZDHeidtbZXDdkjqocloYZhxR/kwplwb27WTRMw
         ReeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7joHR173kmsc59rBBr/ksencMbsFUjxYr35XX72uJ4=;
        b=VDb17RK9aGdRZDRE1q5NHsilNNXwHnOOG0z7AHWfJk0uktjPjF8r63vugz3FmCi8hv
         MuLNhUrPdwtQ2TXCCFvfvFf8MI4Vd8RYDakJtLVZQmEvvI4KF9DCuMtYWsl3BjDFvH3w
         aWvIikrpuDU0qBiYdzuogTHaBKRFEqWNuKqOslqmp6hE1NEcBZeSIzztS3F/97tV3P8i
         bRKQwTdMCUBQmUqHIN64/zaJP2Kczd3Jgvup8HvPreLaoNFobkVSgqJxYxEUPsBhtUDI
         AFuwxVCXU/9+QWepxla/Q7BEF6CoizeYOX2v3qc3PUM2icXTUK+y3zNHmIVb8ZHI9nrA
         K+5w==
X-Gm-Message-State: AOAM531GiDbqjgFBqH8ZxTIYsG3bu5Yf5YliorynWqOx6awgqBlJqY2w
        ksHLi3z8jq8h6gCQuxSpp7xIQYBSbGQVQabLrIbgXg==
X-Google-Smtp-Source: ABdhPJyBe356P7hF37a77qJ0nScNcGn6bF9gReBYqYI52GxtnMyzsolZO5kOIE/TqQBeFjA+1b5QpZD5xQmnGB2VXSA=
X-Received: by 2002:adf:ec07:: with SMTP id x7mr4977285wrn.262.1627040587489;
 Fri, 23 Jul 2021 04:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org>
In-Reply-To: <57AE120A-78AE-4990-8D7F-BA8D8077B610@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 23 Jul 2021 19:42:56 +0800
Message-ID: <CAJQfnxFzj9m43wntnb2gvXkJS6B5+aQGsu7v6hc4H4ktAopk7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 22 Jul 2021 at 22:32, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > Some RTL chips resets the FW on suspend, so wakeup is disabled on
> > those chips. This patch introduces this WAKEUP_DISABLE flag so that
> > chips that doesn't reset FW on suspend can leave the flag unset and
> > is allowed to wake the host.
> >
> > This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
> > allowing it to wake the host, and preventing reprobing on resume.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Hilda Wu <hildawu@realtek.com>
> >
> > ---
> >
> > Changes in v2:
> > * Remove unnecessary variable
> >
> > drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
> > 1 file changed, 59 insertions(+), 24 deletions(-)
>
> so the set does not apply cleanly to bluetooth-next
>
> Applying: Bluetooth: hci_h5: Add runtime suspend
> error: patch failed: drivers/bluetooth/hci_h5.c:11
> error: drivers/bluetooth/hci_h5.c: patch does not apply

Hmm, it applies cleanly for me. Not sure what's going on.
Anyway I rebased and made a little change as v3, please take a look!

>
>
> And I am really close to not accepting any patches for hci_h5.c anymore. This thing turns into crazy hacking and nobody is taking my hint to redo this as clean H:5 3-Wire serdev standalone driver.

Pardon my unfamiliarity, but could you share more about your vision of
a clean h5 driver? Should the RTL component be moved out to btrtl?
Do we have something as a reference?

>
> Regards
>
> Marcel
>

Thanks,
Archie
