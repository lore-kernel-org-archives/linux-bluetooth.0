Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146ABC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Nov 2021 19:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbhK3TYy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Nov 2021 14:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbhK3TYt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Nov 2021 14:24:49 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D794C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Nov 2021 11:21:30 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id m16so13353409vkl.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Nov 2021 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiYbwBmtbSsXpHUUEQNeg4dK5IGAcozBcNLr8SXE45o=;
        b=jq/tnpzaOHDMYbBO6sDFVKk1nwjGzk4dHMAfQaIMEU/8ztzJil2uPxUy8Bp/dyQTNw
         W5Qz2eugbUdZmj1ZMpjnyBkw9Z4rL3Xn0jRZeXiGgdelz/gexSbxgDvOAnB7FFUlOtmp
         GMQgMRexl2LXKnOmEyXwst1ArUdZwtRPOK6PEFgx3ZfEJt1yns8mK2NHAKtOEdLjbtl0
         2Ibdf2ZxUQpSNbwBoiCgYRnx2Xduq8adOVlUgdPBX4Doc5MZJhnQyGAm8YRhG5fMOF8Q
         6tBaHzKPCqYNl5QVhxKiJ8NJAsxT8yxmdXcDw7N3dITQ0fjuWbXEMfa8MEXRau4rM3Nj
         XFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiYbwBmtbSsXpHUUEQNeg4dK5IGAcozBcNLr8SXE45o=;
        b=qfhs8iJ6BgtiIJtEh4af0NIa7D2iqFhvQII970Nm4H3zoKJzOS6rUXY5lTWpJiar3k
         FwCFEP9Rtg00EykeK8Jey2JejHe30Xso2hIlG5ImJHs1+lfKSXWm+RMRrBeeZHC5ME1L
         KiUCvgdBV/c5jmJsMrYNGj1n6LHoIy7BYr577w0SXiyZj7Mv2fhM8ketRNhEs5bHDsuX
         XY/kseTYyTLaCFVhqpCbX9icDhl72HYUNAKYSGAGiiHb++Zyh6dzYtSFJ/IPS4S6bN/h
         G9gRnQ3T51mleHrXz/GRvlzHP+774uqMcUZYhhdSzXSktwLrvBSR6zRcVhvyVeq4UUne
         Qs6Q==
X-Gm-Message-State: AOAM531pE/Gl+GTgTH0EIfBSbqAbzQPaNk0nSXNEwTGTbi0Y/tQkXlcq
        IvDRosGMuTSbV2gJvOKL3idNMElk4WCq+DFoq24bBdu6
X-Google-Smtp-Source: ABdhPJxGdC/Hxd0QIMxQcgObx1zPEaU/3AIHefwjoY8ltTSFaxBExr4R/v2W73P8yGhRwfr2QvOL3O7vwGQ9eNtsGVg=
X-Received: by 2002:a05:6122:d8d:: with SMTP id bc13mr1747847vkb.22.1638300088452;
 Tue, 30 Nov 2021 11:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20211130095643.3140-1-sathish.narasimman@intel.com>
In-Reply-To: <20211130095643.3140-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Nov 2021 11:21:17 -0800
Message-ID: <CABBYNZJhV3yq6ZExkzFj2-QC-YbJL-6Ywu4j_vNjeHFDHiW6YA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Fix authentication failure error during pairing
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, Nov 30, 2021 at 7:23 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> When Experimental LL_Privacy enabled & Privacy is set to device mode the
> pairing of 2 linux devices fails with authentication failure error. This
> happens only on the 2nd attempt when we swap the advertiser/initiator
> role. This is because the init_addr is updated with dev->rpa which still
> holds the previous connection RPA. This patch fixes the issue when
> ll_privacy is enabled.

What does the previous RPA has to do with the 2nd connection? This
doesn't explain exactly what is the problem, does this means that
local_rpa is not used on the 2nd connection? And why would the
controller not set a local_rpa?

> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9d8d2d9e5d1f..bd40d8cedc27 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5314,8 +5314,10 @@ static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
>                         conn->init_addr_type = ADDR_LE_DEV_RANDOM;
>                         bacpy(&conn->init_addr, local_rpa);
>                 } else if (hci_dev_test_flag(conn->hdev, HCI_PRIVACY)) {
> -                       conn->init_addr_type = ADDR_LE_DEV_RANDOM;
> -                       bacpy(&conn->init_addr, &conn->hdev->rpa);
> +                       if (!use_ll_privacy(conn->hdev)) {
> +                               conn->init_addr_type = ADDR_LE_DEV_RANDOM;
> +                               bacpy(&conn->init_addr, &conn->hdev->rpa);
> +                       }

This can't be right, first it doesn't set any init address and second
I would expect the controller to always set a local_rpa when LL
Privacy is enabled. I suspect the controller is either getting
confused with the first pairing and then the swapping of the roles
with the removal of the devices or there is some else at play because
neither local_rpa or hdev->rpa seems to be set in the init_addr.

>                 } else {
>                         hci_copy_identity_address(conn->hdev, &conn->init_addr,
>                                                   &conn->init_addr_type);
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
