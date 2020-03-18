Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05BEC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984E20767
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNuWxpd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRI4n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:56:43 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43992 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRI4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 04:56:43 -0400
Received: by mail-il1-f195.google.com with SMTP id d14so22335606ilq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oqy8BnAmTxO+/nqkJ/9EFY2l9umzBMpHxRCbKuO6Wc=;
        b=JNuWxpd84sK521JlMr3wKnCEIVB+SdauPQfsyKNpnDChHpiv4QLoPcKIsbE1ZYmQPW
         Fyi0VR/WfMEFfUqZqkqnY+z9xeozGp17Jz8ltF4mwhjILGF1DkpwVpWv8/y2nawA1WjK
         7KOT+PREW/VewQIYh3cKNrhGEVpoXvXp3xNM9ul5og80rGGHKnie5mwYxM6EirtjtQxw
         KK1Dw3u7iHUQLoYFNtMblsZSD6IhMJFQGUARaW9yKDn5Gn3+ySAmyNbGV+KR5nMIJdpD
         S9x+f9Voo5ZhkwBS6g0mi9L9bo0qIQDFnaN6wEE/piONc4bn9dDiahbS369qSr6tVW+c
         nleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oqy8BnAmTxO+/nqkJ/9EFY2l9umzBMpHxRCbKuO6Wc=;
        b=CH/g4McCGQtzbUj8zCi+Nyi3W0bMzd4P88f7YBdUZLncf120DIVNr+5XEcXZiqg6EV
         usAzsN5GUUiS8PP9WxS6DtAtS+sIQPuOZuiauiGclURatjix2klXU27YOA4hJVRBE737
         D12sni6NF4mlHQdZmWJ0AMRWkr+AWjPR+QHHsjlruiS3qb3ABJGJTebSDm8SCDwHr1bl
         VC4AV3WLwgdGx+BDdQcYxGtFh+io/KVRiuLLGWa+ECUWpevSaf5EdHHYO/rAb47hq/Ih
         BtXJq0gH5lAFLgnzXloXgXeetbm5Ug4vaXChuq+OLksLxzekcemlcUr9teN8Bk/VtimU
         Ix1w==
X-Gm-Message-State: ANhLgQ1rx1Ep3JMff91mCAj235FjcBK9OCWVscCPWcRHMaykMPYSiHU4
        Cse/KTkLVJGa50rPYyK6xnqdp6b363HOksSZcpZUi35P
X-Google-Smtp-Source: ADFU+vvI2QiK0w5pTWO79UYOVUdIR1X/LX+3ZLigSQgy1upG8wYrdQ3ICP6Gacv58ZjtZslIjBedfJOHAsw2ESj9J2o=
X-Received: by 2002:a92:a192:: with SMTP id b18mr755457ill.199.1584521801969;
 Wed, 18 Mar 2020 01:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 18 Mar 2020 14:26:30 +0530
Message-ID: <CAOVXEJJK0WgeXvwPM=_7kUxrb7O13E5XcaNDpURC6acwrGgXWg@mail.gmail.com>
Subject: Re: [PATCH 0/7] LE LL Priavcy support enabled
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sathish N <nsathish41@gmail.com>
Cc:     Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

A gentle reminder to review the patches

On Thu, Mar 12, 2020 at 3:36 PM Sathish Narsimman <nsathish41@gmail.com> wrote:
>
> With this LE LL Priavcy feature available if BT controller supports
> LL Privacy when privacy is enabled.
>
> The patches are verified in below case.
> Pairing - where the IRK is added to device Resolving List after
> identity info & IRK is shared in SMP.
> Unpair - Delete the resolving entry from the Device resolving list
> Local IRK change - Whenever there is change in local IRK (privacy) the
> resolving list entries in the device is updated.
> Whitelist - filter policies for whitelist is updated based on LL_adress
> resolution support.
> Reload Resolving list - device reset/sysmte reboot the Resolving list
> reloaded in to the device.
>
> Sathish Narsimman (7):
>   Bluetooth: LL Privacy Delete Store Resolving list
>   Bluetooth: Add device to Resolving List
>   Bluetooth: Update the Resolving list when Local IRK changed
>   Bluetooth: LL_PRIVACY re-load resolving list
>   Bluetooth: LL Privacy Check and Update the Resolving List
>   Bluetooth: Enable LL Privacy
>   Bluetooth LL Privacy update White list
>
>  include/net/bluetooth/hci.h      |   3 +
>  include/net/bluetooth/hci_core.h |   7 +
>  net/bluetooth/hci_conn.c         |  32 ++++
>  net/bluetooth/hci_core.c         |  20 ++-
>  net/bluetooth/hci_event.c        |  32 +++-
>  net/bluetooth/hci_request.c      | 251 ++++++++++++++++++++++++++++++-
>  net/bluetooth/hci_request.h      |   2 +
>  net/bluetooth/mgmt.c             |  10 +-
>  net/bluetooth/smp.c              |  11 ++
>  9 files changed, 354 insertions(+), 14 deletions(-)
>
> --
> 2.17.1
>
