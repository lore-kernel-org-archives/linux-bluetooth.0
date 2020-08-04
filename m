Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB66C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8470207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SoyMHVPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgHDRMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgHDRL6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 13:11:58 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04449C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 10:11:57 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id r63so13081112uar.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDe2U+JQQtlm6PkmOwl5fjQfHoZ0o3DW3eDHCm6kTvQ=;
        b=SoyMHVPkgxHGIyVFghEqt+dz76dWygdZK5qv96mgYHIB8BQDfnDSdlwicrCousdePt
         6kFYSc0n7RSJRhh/WbIBfAW1Mu0Sap9jaMdg6UlhNdK0k672HQpR0CmBGVutHlwlHgV+
         jMC83l8tqgA+ALlv4CakhMvyvvf1kF8Uhx/7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDe2U+JQQtlm6PkmOwl5fjQfHoZ0o3DW3eDHCm6kTvQ=;
        b=cN6FKgv2Zzr5pePYQySg9EuMRwaWQcOnbplR+7uvaoyJ67fs0gL+VMjU/Cn1+cEnRF
         e91nZr7JhxNLsd7ip9VYxMBje7FlCMZgrm/Q6SB+jEisScvzzIpsIGuRof3zB/+ZGTZu
         CnfkGB/Wt/rkddeAdnL1k4yN71SuE2mMcwYS/B+OQZk9ol3woXEQlrKTmio2Bc67AIIh
         Si54WKSxoOBVyGCAHWKhzQ3pfgpyhAw9fdb5erz+Gal1MOEt7makjBgvjQsOKhHloQxC
         qXpeJ6+gMj0klAs1qnmzRzUG9ZEaqFes42cWuEVzZkQEx11EaKMm7TnKt4cdw447Jx/a
         KJ4A==
X-Gm-Message-State: AOAM532xQNGqqMphWayT6hqpRsnqoSW0IZvNS7qE66hE8Ls8zhJo0SrN
        5fo3Z+5GyFBsCBOBQnABJFV4vlzniTfYdgUOinPLIQ==
X-Google-Smtp-Source: ABdhPJzdxejwD5qJ3tvpESkSc0h2CyPb4WDolKHYh5SfDmcf4Fg5xK3WK/bLFsJz2MfIniAOjYF53pvHQqw0ach4VHA=
X-Received: by 2002:a9f:2197:: with SMTP id 23mr15629203uac.60.1596561115676;
 Tue, 04 Aug 2020 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200729014225.1842177-1-abhishekpandit@chromium.org>
In-Reply-To: <20200729014225.1842177-1-abhishekpandit@chromium.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 4 Aug 2020 10:11:44 -0700
Message-ID: <CANFp7mV0TP-WbBWGSpduERaf9-KBXevhG7xKvjkMrqrtWWkZ5w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: Emit events for suspend/resume
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Gentle reminder that this is waiting for feedback. Related userspace
changes are here to see how we plan on using it:
https://patchwork.kernel.org/project/bluetooth/list/?series=325777

Thanks
Abhishek

On Tue, Jul 28, 2020 at 6:42 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> Hi Marcel,
>
> This series adds the suspend/resume events suggested in
> https://patchwork.kernel.org/patch/11663455/.
>
> I have tested it with some userspace changes that monitors the
> controller resumed event to trigger audio device reconnection and
> verified that the events are correctly emitted.
>
> Please take a look.
> Abhishek
>
>
> Abhishek Pandit-Subedi (3):
>   Bluetooth: Add mgmt suspend and resume events
>   Bluetooth: Add suspend reason for device disconnect
>   Bluetooth: Emit controller suspend and resume events
>
>  include/net/bluetooth/hci_core.h |  6 +++
>  include/net/bluetooth/mgmt.h     | 16 +++++++
>  net/bluetooth/hci_core.c         | 26 +++++++++++-
>  net/bluetooth/hci_event.c        | 73 ++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c             | 28 ++++++++++++
>  5 files changed, 148 insertions(+), 1 deletion(-)
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
