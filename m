Return-Path: <SRS0=fFFM=YS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB4CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5091020867
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Oct 2019 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K22uijSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393219AbfJYHfA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:35:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34652 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390611AbfJYHfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Oct 2019 03:35:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id f18so894281qkm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2019 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2DTvmQSU5aAC+z4dgDIVG6CPCMe9Vfv142TTLAqDuY=;
        b=K22uijStTWQ6BWAFUpfwzk3pph1m8M9Re1qDpjdngB8w86utaw6mLNEmQoF6CTg4WZ
         qQM9v5EX29QEN/G6fxIjO/JpWY7WoJxOKap8rFH2ghXy7AW/h21fNGNuqKa3eacRHfAY
         ZF31+Ctnxf8BHRqmwcgXnWUC4VPIFUhioN4lX1z8YOK0tlzuDAi40lxDAd29HYTJoj1z
         DqVtBR5q3333Wg9qD0u6i1jY9kZpXda2EwCSXevObFgB6HRT1CO26tKSkL8GC0Cs6O73
         QSf61Hp2FVZFmktTdvV0EW4Jg8N+h6xIxHGycV634nAWUk4ReM41+qdK+1c/aFlULUBI
         fiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2DTvmQSU5aAC+z4dgDIVG6CPCMe9Vfv142TTLAqDuY=;
        b=BOwLBUArpBEAi7pyiKhYw+nOP3rV6NfQz3LVccba4KMhGbSjLfOGU5oAj4mbXdJFNK
         x2e5o5/bh1NfDm5bm4ciCymnB1NQZ74FrzdnPlp1VAMdCR0yfMbmTslJbGnMcIdogUac
         HVnzCmzqbL1b5btEx8MlD/CUCAz+0qfElEcBbkZdKsFtNN+Kgc4CtjRvHmj9uPblb+uR
         EqSSjTQcNInz2GJQ6kUoXoBiZtWS8DTZM+m0Y+gubIyJSSI2f+s11753G7MV6kOjlV/9
         tPVQJTYuQhLtoYr7ZdRRuQeroGXFrgyv+gc1fjlUiBP7M2m0aWCY8iWk89emhXmooBwP
         RMrg==
X-Gm-Message-State: APjAAAUR9Ot1Vy48PtN0m+jG4gyTvCrbHlDeVsdjaWlB+v6YtM+oBlNV
        3Zlcf1BhZSOWFHt6R+KpTCodtr602abqW8lgxeY=
X-Google-Smtp-Source: APXvYqys6XY0KEqroyTMs6+FYtxUDOD9lnJr1pUZ150Ta7RQgbMKww2AN4oSXdRvVEgQCad6vULvUWbsE8uChCxBfvw=
X-Received: by 2002:a05:620a:2191:: with SMTP id g17mr1564001qka.247.1571988899234;
 Fri, 25 Oct 2019 00:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com> <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org>
In-Reply-To: <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org>
From:   Jaganath K <jaganath.k.os@gmail.com>
Date:   Fri, 25 Oct 2019 13:04:47 +0530
Message-ID: <CAJzH+bqLK1aohAE3f5-4Xfhz1Gq05URFgZf9yFPAeBF2ekfmQw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Always set scannable for Adv instance 0
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Thu, Oct 24, 2019 at 6:31 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Jaganath,
>
> > By default for instance 0, local name will be added for scan rsp
> > data, but currently the property is set as non scannable and hence
> > Set Adv parameter fails with Invalid parameter.
>
> can you be a bit more specific why this is the correct behavior. We must have documented in mgmt-api.txt somewhere, right? Or is this something that used to be correct, but we broke it with adding extended advertising?

It seems to be functionally broken in legacy adv as well as we set scan rsp
for instance 0 always but Adv Properties is set to non connectable (if
connectable
is not set). Even we need to fix mgmt-api.txt as well as you pointed out.

But in legacy case commands do not fail as  scan rsp can be set even before
Set Adv Param where as in extended case Adv param for an Adv set has to be set
first before sending Scan rsp and other commands for that particular Adv set.

>
> > < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
> >        Handle: 0x00
> >        Properties: 0x0010
> >          Use legacy advertising PDUs: ADV_NONCONN_IND
> >        Min advertising interval: 1280.000 msec (0x0800)
> >        Max advertising interval: 1280.000 msec (0x0800)
> >        Channel map: 37, 38, 39 (0x07)
> >        Own address type: Random (0x01)
> >        Peer address type: Public (0x00)
> >        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
> >        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> >        TX power: 127 dbm (0x7f)
> >        Primary PHY: LE 1M (0x01)
> >        Secondary max skip: 0x00
> >        Secondary PHY: LE 1M (0x01)
> >        SID: 0x00
> >        Scan request notifications: Disabled (0x00)
> >> HCI Event: Command Complete (0x0e) plen 5
> >      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
> >        Status: Success (0x00)
> >        TX power (selected): 7 dbm (0x07)
> >
> > < HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
> >        Handle: 0x00
> >        Operation: Complete scan response data (0x03)
> >        Fragment preference: Minimize fragmentation (0x01)
> >        Data length: 0x0d
> >        Name (short): localhost.
> >> HCI Event: Command Complete (0x0e) plen 4
> >      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
> >        Status: Invalid HCI Command Parameters (0x12)
> >
> > This patch makes the instance 0 scannable by default.
> >
> > < HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
> >        Handle: 0x00
> >        Properties: 0x0012
> >          Scannable
> >          Use legacy advertising PDUs: ADV_SCAN_IND
> >        Min advertising interval: 1280.000 msec (0x0800)
> >        Max advertising interval: 1280.000 msec (0x0800)
> >        Channel map: 37, 38, 39 (0x07)
> >        Own address type: Random (0x01)
> >        Peer address type: Public (0x00)
> >        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
> >        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> >        TX power: 127 dbm (0x7f)
> >        Primary PHY: LE 1M (0x01)
> >        Secondary max skip: 0x00
> >        Secondary PHY: LE 1M (0x01)
> >        SID: 0x00
> >        Scan request notifications: Disabled (0x00)
> >> HCI Event: Command Complete (0x0e) plen 5
> >      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
> >        Status: Success (0x00)
> >        TX power (selected): 7 dbm (0x07)
> >
> > < HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
> >        Handle: 0x00
> >        Operation: Complete scan response data (0x03)
> >        Fragment preference: Minimize fragmentation (0x01)
> >        Data length: 0x0d
> >        Name (short): localhost.
> >> HCI Event: Command Complete (0x0e) plen 4
> >      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
> >        Status: Success (0x00)
> >
> > Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
> > ---
> > net/bluetooth/hci_request.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 7f6a581..362b1ca 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1601,7 +1601,12 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
> >                       cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
> >               else
> >                       cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
> > -     } else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
> > +     } else if (!instance || get_adv_instance_scan_rsp_len(hdev, instance)) {
> > +             /* Always set scannable for instance 0, as scan rsp data will
> > +              * be set by default with local name. For other instances set
> > +              * scannable based on whether scan rsp data is there for the
> > +              * respective instance
> > +              */
> >               if (secondary_adv)
> >                       cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
>
> So this comment is at a wrong location. And I am not convinced that we would actually depend on if scan_rsp data is present. We might want to set scannable all the time if that is what we decided for instance 0.
>

For other instances Scan rsp data will be present based on if user is sets
the same (Using Add Advertising).
So Do you want to set scannable always for all instances (even if user does
not set scan rsp data) and hence in that case we will not use non connectable
property at all?

Thanks,
Jaganath
