Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A772C433E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F99207BB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1kwjjjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGPFMX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA0C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 22:12:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i18so3978122ilk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 22:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46kz+Eza/6bwvKMNUgCo81wTzXHTZri/532QaxEYzzA=;
        b=n1kwjjjKlTqe9naWgY89IqF2JGWKl4Nxf8cbc4BuJjqhz0/aIdjEJWgEO7BeTuWQ0m
         jN+a2Dh8fI27J5hYiAXV+0MmUEPjsa4VWQT2fz61SvVmVnf2zu6M/Cpq3i9/kMRLFEd7
         /eSM+Na+8VrUW02XpLq3/KMTJZGHldNb+2fXyZF04Tvkmh2GYaquNHDKJKw4kD64NQSS
         TluKXQbQX7xJvEGnwCdk8UwEBw/4MsqG0ZWXrmbf4pvrr6GQ+HpFGa6q7DeE2CqlgcpM
         OhQbu4uPoG4vapr09WgrdRaECrdibxZbNxpzKg04RWISCnbwMNzL1WnLp0eQ04Imhfbv
         EBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46kz+Eza/6bwvKMNUgCo81wTzXHTZri/532QaxEYzzA=;
        b=oWDYUlKkUs7QDWpl/DTzEsQl8fJ1/LjBYYd0bU/o80rlu2UCpAEe5Lcnodmd0Vt83K
         x+wZkOY9v1SFPcdFy4y6hfYs2jaDf3ixlLrNjwAbDlTZE+QOcc1iVabbSXCr4MizTom6
         kZFTCqHsw7f9yvFwlZmqMIB/olvloHMQdO4ctsQEGqb1eYF9wHjF0HdgkWWj3AitLNJq
         TeRKqNfAGdfh5f784fdVrdcebOLBVArHB3AmQUpkLrsbNp66lcEvcyEne/Qk88KBRp47
         a1X0N79hnz1Y/XEyvK75odCzSPMpAe7/5MnBBHxFR2AtcUxjAdSo23V7Vm6hZkN8dQu2
         QNEw==
X-Gm-Message-State: AOAM530UwyuDxABycP2TBO5aXalMSOeZJSpbg6BgDwQNT3ttuLUOnEOt
        eN74f2yPwWrbf+BRgixDuVnX/7a+tyqk0R7jprPCVRaA
X-Google-Smtp-Source: ABdhPJyOeufne2bXodDR0ovoG8C2++5zaguX4Qziwm81ERMKZvVKEApI7CbttFtsrGauB345ogsB0A90T6RJswKAIvY=
X-Received: by 2002:a92:4913:: with SMTP id w19mr2751990ila.185.1594876338875;
 Wed, 15 Jul 2020 22:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 16 Jul 2020 10:42:07 +0530
Message-ID: <CAOVXEJL=gZnZYi42zzGauLMVr94eAwALXm1qppW3TRy61+H2CQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] LL Privacy Support
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        Sathish N <nsathish41@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

Gentle reminder

On Mon, Jul 13, 2020 at 11:48 AM Sathish Narasimman
<nsathish41@gmail.com> wrote:
>
> V4: patches are rebased
> Added support to use set Experimental feature to enable controller
> address resolution
>
> Marcel Holtmann (3):
>   Bluetooth: Translate additional address type correctly
>   Bluetooth: Configure controller address resolution if available
>   Bluetooth: Update resolving list when updating whitelist
>
> Sathish Narasimman (5):
>   Bluetooth: Translate additional address type during le_conn
>   Bluetooth: Let controller creates RPA during le create conn
>   Bluetooth: Enable/Disable address resolution during le create conn
>   Bluetooth: Enable RPA Timeout
>   Bluetooth: Enable controller RPA resolution using Experimental feature
>
>  include/net/bluetooth/hci.h      |   9 ++-
>  include/net/bluetooth/hci_core.h |   3 +
>  net/bluetooth/hci_conn.c         |   7 +-
>  net/bluetooth/hci_core.c         |  17 +++++
>  net/bluetooth/hci_event.c        |  21 ++++++
>  net/bluetooth/hci_request.c      | 120 ++++++++++++++++++++++++++-----
>  net/bluetooth/hci_request.h      |   3 +-
>  net/bluetooth/mgmt.c             |  54 +++++++++++++-
>  8 files changed, 213 insertions(+), 21 deletions(-)
>
> --
> 2.17.1
>
Regards
Sathish N
