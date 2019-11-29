Return-Path: <SRS0=sIa/=ZV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A718C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0BE217AB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 12:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwSOMjwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfK2MOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:14:42 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43622 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2MOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Nov 2019 07:14:42 -0500
Received: by mail-il1-f196.google.com with SMTP id u16so782419ilg.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2019 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQklKgnIoawUmpuv74Epiptl8hhkOUY+M61a7MLzVow=;
        b=gwSOMjwWDYbtBHqTKqgQO4q+obwiwC9o6/hFamS0T9S6UknJbpLUaX/mkBTJgXH7G5
         v0kPhPK3FdgOz604GndP0wUoEvZdVW+5qwUacBdzQMn5d0qhqAJbaHg6u29vSbXRjEnM
         3AExbbyy3mNZWJ/MqaKHetD5X2tQ1Yctj1ynEqur0v1aAn0aAFRPkA8mUcg/GxeFcuAz
         ZH+hDlUZVabqf2b5W/29pvyvMaNs9+F5YapH5tM5qKGC1aurzlQHTFgKoU+Bwdc4XK4C
         Dma2hI1Fc5BLzWTJ8lLmy13d1uCitTPCLhKZ739w4ukebzBiokvEPT2GkLLGjkHg2Qhh
         bngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQklKgnIoawUmpuv74Epiptl8hhkOUY+M61a7MLzVow=;
        b=uiPojcBJfitxQ9SLjkBlaMTQtTkBvJqu398wPxR3i9w1/+2+NTqVZKikcETb4Km+vv
         +nSatmyJU5yIOfef4NP1jKT6tBYIY1X+bHTzpwVVYrGORMANvoHpdaDOvLDJZGN6xG4B
         2MTpfeFKwpUyhrKfxWW2T1w6xwd/06cuGB5dF3WU8/ISTs0P8V86u9WfuCTBlv7YxQSD
         JRKwmT6ZiXOqmbaUAVJpBCtKBohfFWRS4iribxSO0L8XYGyp6Lj16M8wFbmuZRtPSpnd
         WIoCol52DRuvsRi9TktuBWeFXxEfl9abRZ2qZIORGqn4B31mrZ8T0RVeMM4t6q1/98qX
         W4Jg==
X-Gm-Message-State: APjAAAVx0Qmhxs2+pcYuQw/mEg5xEFjkByQhU25O0/SaRTl2EuEDo5h+
        kX6UUZCENqbjjjWS8DHtnEU2WZFVpLxbxSh0bJcrAhCMmj8=
X-Google-Smtp-Source: APXvYqw89Cr32CG9NURHCGERIbWyc94eJpsRvx12rLIk6Yir168WDeLdGwRyxZVEinI81/oj6TsxYVFaBUb21050YNw=
X-Received: by 2002:a92:884e:: with SMTP id h75mr1332532ild.199.1575029679785;
 Fri, 29 Nov 2019 04:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20191128091748.24531-1-sathish.narasimman@intel.com>
In-Reply-To: <20191128091748.24531-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 29 Nov 2019 17:44:28 +0530
Message-ID: <CAOVXEJ+JKhTrtkiPthx7ju-Zdu=pHugJpaChQmpxsPxowD7rUw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] bluetooth: add support to notify SCO air mode
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Nov 28, 2019 at 2:47 PM Sathish Narsimman <nsathish41@gmail.com> wrote:
>
> notifying HCI_NOTIFY_CONN_ADD for SCO connection is generic in
> case of msbc audio. To differnetiate SCO air mode audio introducing
> HCI_NOTIFY_SCO_CVSD and HCI_NOTIFY_SCO_TRASP.
>
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
>  include/net/bluetooth/hci.h      | 2 ++
>  include/net/bluetooth/hci_core.h | 3 +++
>  net/bluetooth/hci_event.c        | 9 +++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5bc1e30dedde..26af112b1f2c 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -52,6 +52,8 @@
>  #define HCI_NOTIFY_CONN_ADD            1
>  #define HCI_NOTIFY_CONN_DEL            2
>  #define HCI_NOTIFY_VOICE_SETTING       3
> +#define HCI_NOTIFY_ENABLE_SCO_CVSD     4
> +#define HCI_NOTIFY_ENABLE_SCO_TRANSP   5
>
>  /* HCI bus types */
>  #define HCI_VIRTUAL    0
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b689aceb636b..9258e19f8cc5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  #define SCO_AIRMODE_CVSD       0x0000
>  #define SCO_AIRMODE_TRANSP     0x0003
>
> +#define SCO_CODED_CVSD         0x02
> +#define SCO_CODED_TRANSP       0x03
> +
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c1d3a303d97f..ecad696db139 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
>                 break;
>         }
>
> +       BT_DBG("sco connected with air mode: %02x", ev->air_mode);
> +       if (ev->air_mode == SCO_CODED_CVSD) {
> +               if (hdev->notify)
> +                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
> +       } else if (ev->air_mode == SCO_CODED_TRANSP) {
> +               if (hdev->notify)
> +                       hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
> +       }
> +
>         hci_connect_cfm(conn, ev->status);
>         if (ev->status)
>                 hci_conn_del(conn);
> --
> 2.17.1
>

Please ignore this as Patch V5 is updated.

Regards
Sathish N
