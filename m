Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 21:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C98E61073
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 21:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhKBVFW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKBVFV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 17:05:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D0C061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Nov 2021 14:02:46 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e144so313563iof.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Nov 2021 14:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWk6VkjEqDQMgcSH1NKNiNArGE7q0k4XXTRdXdjpK4U=;
        b=SKDGHh46XMH/v2jpDORT18PjQ+dEEHz7eYMYOrlj0PEElaOJzyty5KqQk3A/lCNfX8
         XLlG5tuu2Xpzfvq0s0pJBtP2juaCX45O91eTEG2M3eK/H3B75Au4L2x79X+Rjjg6MJCL
         M8bgMlJnLdXSz5kTOpV1J5kxGNnIBJrprp1Uu8q9Z3mAmk3uiz1EGileO1BagFOn0AU5
         NfZX0MHZIGC5ICGNKc8cclGyjgDrD6FzcSuSmlKyG4HF7logtPI1q7UTJBvfK5zCbjnx
         Xy0tMZhNt0uffsjn3bbSIOcaMTC6TpB4p76xJ9+v1xAADJRyZkDt5u2SE8HhtuIUwIiq
         o2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWk6VkjEqDQMgcSH1NKNiNArGE7q0k4XXTRdXdjpK4U=;
        b=7zWb3JjntmNB6jee4VwsAGnSzaPoq4Cf5YemgCrgpLXw4/urXyfm57nlj2BOm2+Jp6
         Ea0fMpRftfxWrISHJMnwvozRdYxbk60CnryfdFm3H68qeoQwxH4IJBhPj5iYPl7PFt6w
         becKroUhRKyfa4szS+hPGaxrAVo0JqyML6a8TVS5kaCoZOQzTAaZ3DGvdivRBXf3bvZ2
         pGqn9yZZuDh5kZsXKMQsYi7e+KXWSwtHzYm72pa0Y0VVl7i4p9SZdzmrvZMMyGWtCy0/
         uo9VTTELbxbam4AWCV2pwMn+jQv6r+HmP5I8HZWBa+fVa30Om3NRB+z6UCCsKJt3nRJ4
         /01w==
X-Gm-Message-State: AOAM530QcfJR888gedh6QAVllzo6HO6S/keBjKhLsP/ElYP09L/qzGAD
        a8KvGON46ghygY4xNuWbeHfCzhYnH0vqJritYEq3eLqCCto=
X-Google-Smtp-Source: ABdhPJwQlXTJ870q/k6ldljrbIbi0dmN+85EC1bUEy27U3wmZMVgK/1VXrnhRdqC1TH+1LxW5lKmGCL0JR18utMPFso=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr29398147ioh.106.1635886965586;
 Tue, 02 Nov 2021 14:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211102055116.2898794-1-luiz.dentz@gmail.com> <6313C3AD-AEA9-4E4E-98C4-3F1C62DE04CA@holtmann.org>
In-Reply-To: <6313C3AD-AEA9-4E4E-98C4-3F1C62DE04CA@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 2 Nov 2021 14:02:34 -0700
Message-ID: <CABBYNZLbU=qUa91Nj45B2nD=GHbAu6j=mCWP+ZkA23a733rfww@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Set Privacy Mode when updating the
 resolving list
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Nov 2, 2021 at 12:18 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds support for Set Privacy Mode when updating the resolving list
> > when HCI_LIMITED_PRIVACY so the controller shall use Device Mode for
> > devices programmed in the resolving list, Device Mode is actually
> > required when the remote device are not able to use RPA as otherwise the
> > default mode is Network Privacy Mode in which only RPA are allowed thus
> > the controller would filter out advertisement using the identity address
> > for which there is an IRK.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci.h |  7 ++++++
> > net/bluetooth/hci_sync.c    | 48 ++++++++++++++++++++++++++++++++-----
> > 2 files changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 63065bc01b76..aa856dfd5b9f 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1930,6 +1930,13 @@ struct hci_rp_le_read_transmit_power {
> >       __s8  max_le_tx_power;
> > } __packed;
> >
> > +#define HCI_OP_LE_SET_PRIVACY_MODE   0x204e
> > +struct hci_cp_le_set_privacy_mode {
> > +     __u8  bdaddr_type;
> > +     bdaddr_t  bdaddr;
> > +     __u8  mode;
> > +} __packed;
> > +
> > #define HCI_OP_LE_READ_BUFFER_SIZE_V2 0x2060
> > struct hci_rp_le_read_buffer_size_v2 {
> >       __u8    status;
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index b794605dc882..43173d645436 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1580,8 +1580,37 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > }
> >
> > +/* Set Device Privacy Mode. */
> > +static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> > +                                     struct hci_conn_params *params)
> > +{
> > +     struct hci_cp_le_set_privacy_mode cp;
> > +     struct smp_irk *irk;
> > +
> > +     /* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
> > +      * by default Network Mode is used so only really send the command if
> > +      * Device Mode is required (HCI_LIMITED_PRIVACY).
> > +      */
> > +     if (!use_ll_privacy(hdev) ||
> > +         !hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY))
> > +             return 0;
> > +
> > +     irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
> > +     if (!irk)
> > +             return 0;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +     cp.bdaddr_type = irk->addr_type;
> > +     bacpy(&cp.bdaddr, &irk->bdaddr);
> > +     cp.mode = 0x01;
> > +
>
> you need to check if this command is actually supported.

The spec suggests it is mandatory if LL Privacy is supported:

'C9: Mandatory if LE Feature (LL Privacy) is supported, otherwise excluded.'

> I think the best option is to add it to Set Device Flags and let bluetoothd set it on a per device basis like it does with the wakeup flag.

Got it, I guess

> Trying to tie it to the Limited Privacy mode seems weird. Since that is for discoverability and this is for outgoing connections.

Hmm, I'm afraid this wouldn't follow the spec to the letter then since
it doesn't actually split Incoming/advertising and Outgoing/scanning
privacy, it does seems to be global so if we go with different
settings to control each direction separately we may end up with a
custom mode e.g: limited discoverability for advertising vs network
privacy mode for scanning, for instance limited discoverability does
blast the public address while discoverable and bondable but both
privacy modes seems to require the use of RPA, anyway it would
probably be a good idea to document the interactions, also main.conf
seem to have gone with privacy from the specification so we may either
need add more modes:

Privacy:
"on"/"network": Apply Network Privacy Mode both for advertising and scanning
"limited-network": Apply Limited Discoverable Mode to advertising and
Network Privacy Mode for scanning
"device": Apply Device Privacy Mode both for advertising and scanning
"limited-device": Apply Limited Discoverable Mode to advertising and
Device Privacy Mode for scanning

-- 
Luiz Augusto von Dentz
