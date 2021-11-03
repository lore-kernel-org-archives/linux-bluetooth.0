Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70194C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F94D61139
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 20:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhKCUfJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCUfI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 16:35:08 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D66C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 13:32:32 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id q13so6800926uaq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8RMvdb5deiVGFFl0RPIDMoMjGl1PucTlHn9Kt/MF9E=;
        b=Uf+C+EVAigk9dp4bCXrm2XHqGjX3FTo2AOQTIL5u3vI7cmvP7mD7eR3MUQPNqfuUrE
         V+d3jaar/oPu033wrk/nGxws7kIaOyIWV2EGdU2l3/BUk1/jF8iLEK6oUWj8YZsI/dtN
         B5YMmK8ppS6ueLMeDyZI9LTBEw96XvNGKVwpKr0dsqw7Y3WF2pbKWxLJP+wZfNSJhU45
         PX8aWHUK1Thz1R6bh76J+1DYjyZ5nCOzgUdJDaudsPrb6889xxUr1cVEIejX9s8Y/Ej5
         aV1UWFe1ecVDtBO54SFEFFkG6TlRrfD34FIjsBdQJUJHx+EYAgWi3QlWv1nPj0gLHkjw
         HSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8RMvdb5deiVGFFl0RPIDMoMjGl1PucTlHn9Kt/MF9E=;
        b=nFnBzRgIHlxSK88WOkrd7WxOsdZJzquFjNojnf0KzhNJP5aqhXZPZ8mP18FItAYYWX
         KRvTlDZwZwiiBmkvoLnh2IV5dW9gQ75AbSrcPYuV050tzk5NCm7vMGiU/YPtVe5TY8hj
         7Ok1Xltpn7QTXZ3gIWqLdlOxmPkRAF3sQlmFeB0g3bbjg3x3gM2K56A8AoBZYC8w5XL4
         ut2cfqohuyw/7a4K+hgmbIbfn6anE8POLZXkXxq6oxb6cFjkeY8GHK3BdFnGTtLnHrrr
         s/luEQvbnRJT/oJFCuNoXGHHIvov/p6v80584hwxQoxTh7CmbwIgnZqa93odn7osf2pI
         zmNA==
X-Gm-Message-State: AOAM532t3cVibZAuRKtfOD5Raesu9vYfiiUHR9UJbTHBHDFaK+KDMHx7
        gNrQaH2WXUPy1IO13NdnFS47A9Ph2IZhHdX54WCCFOcO
X-Google-Smtp-Source: ABdhPJzb3zamLeXyShJseVm4viZQ03vteTcDaYSf22MDE6b5hQsTl1l9lbm5/ZHwU7C/1rnJC2b5IflCEms1zQJpx2U=
X-Received: by 2002:a05:6102:3589:: with SMTP id h9mr39755365vsu.39.1635971550978;
 Wed, 03 Nov 2021 13:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211102055116.2898794-1-luiz.dentz@gmail.com>
 <6313C3AD-AEA9-4E4E-98C4-3F1C62DE04CA@holtmann.org> <CABBYNZLbU=qUa91Nj45B2nD=GHbAu6j=mCWP+ZkA23a733rfww@mail.gmail.com>
 <AF9E9ADC-B77F-4C07-B030-84BC40472739@holtmann.org>
In-Reply-To: <AF9E9ADC-B77F-4C07-B030-84BC40472739@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Nov 2021 13:32:20 -0700
Message-ID: <CABBYNZ+=6WCHz3j6HMSt5LPgegCk5xMVc9782=XJsSWqhWZmxA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Set Privacy Mode when updating the
 resolving list
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Nov 3, 2021 at 1:28 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This adds support for Set Privacy Mode when updating the resolving list
> >>> when HCI_LIMITED_PRIVACY so the controller shall use Device Mode for
> >>> devices programmed in the resolving list, Device Mode is actually
> >>> required when the remote device are not able to use RPA as otherwise the
> >>> default mode is Network Privacy Mode in which only RPA are allowed thus
> >>> the controller would filter out advertisement using the identity address
> >>> for which there is an IRK.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/hci.h |  7 ++++++
> >>> net/bluetooth/hci_sync.c    | 48 ++++++++++++++++++++++++++++++++-----
> >>> 2 files changed, 49 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >>> index 63065bc01b76..aa856dfd5b9f 100644
> >>> --- a/include/net/bluetooth/hci.h
> >>> +++ b/include/net/bluetooth/hci.h
> >>> @@ -1930,6 +1930,13 @@ struct hci_rp_le_read_transmit_power {
> >>>      __s8  max_le_tx_power;
> >>> } __packed;
> >>>
> >>> +#define HCI_OP_LE_SET_PRIVACY_MODE   0x204e
> >>> +struct hci_cp_le_set_privacy_mode {
> >>> +     __u8  bdaddr_type;
> >>> +     bdaddr_t  bdaddr;
> >>> +     __u8  mode;
> >>> +} __packed;
> >>> +
> >>> #define HCI_OP_LE_READ_BUFFER_SIZE_V2 0x2060
> >>> struct hci_rp_le_read_buffer_size_v2 {
> >>>      __u8    status;
> >>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >>> index b794605dc882..43173d645436 100644
> >>> --- a/net/bluetooth/hci_sync.c
> >>> +++ b/net/bluetooth/hci_sync.c
> >>> @@ -1580,8 +1580,37 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> >>>                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> >>> }
> >>>
> >>> +/* Set Device Privacy Mode. */
> >>> +static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> >>> +                                     struct hci_conn_params *params)
> >>> +{
> >>> +     struct hci_cp_le_set_privacy_mode cp;
> >>> +     struct smp_irk *irk;
> >>> +
> >>> +     /* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
> >>> +      * by default Network Mode is used so only really send the command if
> >>> +      * Device Mode is required (HCI_LIMITED_PRIVACY).
> >>> +      */
> >>> +     if (!use_ll_privacy(hdev) ||
> >>> +         !hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> >>> +             return 0;
> >>> +
> >>> +     irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
> >>> +     if (!irk)
> >>> +             return 0;
> >>> +
> >>> +     memset(&cp, 0, sizeof(cp));
> >>> +     cp.bdaddr_type = irk->addr_type;
> >>> +     bacpy(&cp.bdaddr, &irk->bdaddr);
> >>> +     cp.mode = 0x01;
> >>> +
> >>
> >> you need to check if this command is actually supported.
> >
> > The spec suggests it is mandatory if LL Privacy is supported:
> >
> > 'C9: Mandatory if LE Feature (LL Privacy) is supported, otherwise excluded.'
>
> and what about Bluetooth 4.2 spec. devices? Not all earlier specs have both features.

Right looks like Privacy Mode was introduced in 5.0 but LL Privacy was
already part of 4.2, so I guess we will need to check if the command
is really supported after all.

> >> I think the best option is to add it to Set Device Flags and let bluetoothd set it on a per device basis like it does with the wakeup flag.
> >
> > Got it, I guess
>
> I prefer Set Device Flags since with Get Device Flags you can indicate if this is supported or not.
>
> >> Trying to tie it to the Limited Privacy mode seems weird. Since that is for discoverability and this is for outgoing connections.
> >
> > Hmm, I'm afraid this wouldn't follow the spec to the letter then since
> > it doesn't actually split Incoming/advertising and Outgoing/scanning
> > privacy, it does seems to be global so if we go with different
> > settings to control each direction separately we may end up with a
> > custom mode e.g: limited discoverability for advertising vs network
> > privacy mode for scanning, for instance limited discoverability does
> > blast the public address while discoverable and bondable but both
> > privacy modes seems to require the use of RPA, anyway it would
> > probably be a good idea to document the interactions, also main.conf
> > seem to have gone with privacy from the specification so we may either
> > need add more modes:
> >
> > Privacy:
> > "on"/"network": Apply Network Privacy Mode both for advertising and scanning
> > "limited-network": Apply Limited Discoverable Mode to advertising and
> > Network Privacy Mode for scanning
> > "device": Apply Device Privacy Mode both for advertising and scanning
> > "limited-device": Apply Limited Discoverable Mode to advertising and
> > Device Privacy Mode for scanning
>
> Then we can do that and use Limited Privacy mode for exactly that. However in addition I would use the Set Device Flags to allow punching holes for specific devices.

Yep, I actually realized that the reason we have limited privacy as a
mode for LE is that on dual-mode while discoverable it would already
blast the address over BR/EDR, so we might as well only allow the use
of limited-* modes on dual mode.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
