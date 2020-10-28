Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ADC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0422473C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH4V0onQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgJ1WAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgJ1WAd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC2C0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:00:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i26so633065pgl.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Af2E6VaP4qbVM30IdJ+8yzV/rlXswBtvlDIzGMk5vCE=;
        b=HH4V0onQuS6sm4ZSE2k3Ufx0Lgv0r1o5TtCRP66PFJFsgzwbkB37aNKyTApO5E3u82
         RFkpF+C+8Hy3AItw0OGNBfZAQb7D4BPfYKE0If0RfAz2uiqSkzTckA6xc3c/Z7UbqIHx
         hKjW0arhGF1BkXErmV9Lf2cB6QRoYuncqkQJfJ5sxkYuRGTBSdLF4nHkfiykYF8hIoVW
         FTY4hJpl15UFgZCm3bbX7Cqeh+s/cpx6fe1ToEglBg8MRkIjJF3rxdfWSUIjigdkRGSp
         uTeorFJl/7WESTllF66K28hj5ym7BawW6D6ULXFYyPuY0AV4tAdn7I5SGm+2x7kdfGW6
         nVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Af2E6VaP4qbVM30IdJ+8yzV/rlXswBtvlDIzGMk5vCE=;
        b=erRgJCELGLKG8jc6S8wdq9BryxmYQTtxRZqn3OhVhmybhkmGW6weRcSzT8qPANb2d1
         RylQ/LmnRt+gbxEdJRWAJQdX5FhNtd3e0BB+H6Ubq3vCHdUiQaWacQ51lhxB/wX/mXrK
         gX/u8n9YZ35hJWCLea3QCm0ggF5OzVhOxCoBkVivxvEnr+MROXYPn2s6QiYfP22IjCtB
         nV3ESuYGVmzofBVKVw9c7v82sQn+/OohViqXi6l1Wj5DuoDCqhRps++RxcmNABpirce5
         jizyLpggZs+tFDajYW66Bb45cUYrvYCYAA+TRg3QGGyL4mqSM3QXaZyj7dWwZTaDS47t
         gD/A==
X-Gm-Message-State: AOAM530uG/A7fbJkbON8mBgZQyjCbJVcGFQdedQGsl6/eFJh4Pqn/lkq
        7O9TfI63qVozwdFhBPSFiH1qcGB8t3m/kxMQxHuQOHwL
X-Google-Smtp-Source: ABdhPJxZO+OlC0iB8KeqHOV2V5ZbSLY/k4LUBP/houdX7ugmisnb4pFDxYQKH4Wn0vCYVc9VvaWA8YtmKnftg+FTFsI=
X-Received: by 2002:a92:99ce:: with SMTP id t75mr4664029ilk.257.1603862791354;
 Tue, 27 Oct 2020 22:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
In-Reply-To: <20201022082435.31831-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 28 Oct 2020 10:56:20 +0530
Message-ID: <CAOVXEJ+NZ-=y4xcGBOsdmjumw53ZpSjfXnPMSSyjaPzDV0ExAg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth:btintel parse TLV structure
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        ravishankar.srivatsa@intel.com, kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi
gentle reminder

On Thu, Oct 22, 2020 at 1:49 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Latest intel firmware supports TLV structure in operational mode for intel
> read version. so made changes accordingly to support both bootloader
> and operational mode . These changes are only to specific intel bluetooth
> controller for example ThP, CcP.
>
> Sathish Narasimman (3):
>   Bluetooth: btintel: seperated TLV parsing as new function
>   Bluetooth: btintel: Introducing new btintel read version
>   Bluetooth: btusb: Use the new btintel read version
>
>  drivers/bluetooth/btintel.c | 105 +++++++++++++++++++++++++++---------
>  drivers/bluetooth/btintel.h |  16 ++++++
>  drivers/bluetooth/btusb.c   |  41 ++++++++++----
>  3 files changed, 129 insertions(+), 33 deletions(-)
>
> --
> 2.17.1
>
