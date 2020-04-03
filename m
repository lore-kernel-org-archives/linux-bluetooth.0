Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A48C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1789206F6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joy7rjvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbgDCRLj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:11:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34377 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404106AbgDCRLj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 13:11:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so7755204ljn.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSpR6K/pYIpGbbixuFSHlTpRwTA7M8j5OghtVLTP4XM=;
        b=joy7rjvcFTZShWHAL/8yG3IO7NZau0A61M3bp5ixE6qQ77xa2q353rcXiJmsD9imCH
         BT6fsKDfVulQBt0HmkiKbgkK9Q2ilYejs2H+MbnmESrwFHsyP4xPC+dRxunaWaBUXWvw
         GFy74PNvXTg6l0zu5BlK1lK8nVFq2rSdC3T25CF+FTrlX9yiHnt5EYbAHZ4XpEpt4qx0
         BA3OhkYkUvNbVvstgWdSDaI4BEdhck0f8oe0uTiPnMbs/jKuaEg0hg3Qq1CFoQifUxry
         gH5J2rIRP8jSS/PSfpS3JWptLlGUQlXRHWenZQS0vW1z3M/nz+RqomrqjEFRM1NIgYfZ
         Kiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSpR6K/pYIpGbbixuFSHlTpRwTA7M8j5OghtVLTP4XM=;
        b=hJYrjv0rbyDc+YWV7W4/qyf1ZU8ju1dynJcBpEefjKbXNr2LyN2+HgAmdteqIaadqP
         1gjjN+hgC2lY3TPjDN6v3CBcH6CJ5z2UgBGXhhcHCKtDwPcJBw4AAyA2dOILmkUFMl6w
         eAWokgvtDBFiZ4m5KHSeuzKMWOfOiNnQ0+xq4f2vYOBk4EkO8CrsmJsHuvCNIfIJKjVr
         NyaRRN3j0Ade2uLkeYKfmggzSBUc81CURBQJBWz/MlIRRRaFbTYgTlfn3TQ9cBnqMYz+
         +W2Svr1OUe7LFgMmqI1TDyHbDFmcX1GhAXn1lzWGJM2h08sAGnU3JL26tJ0AkfHs11oG
         xrcg==
X-Gm-Message-State: AGi0PuZQc2jyOnDkk/lv/Uj+d6JWYaMTT0NOGYvCOBmK8xGwdYKJYfOR
        ynjuiZGBm85B+9ZJ4Ld1c2BqSJG5iDozrlcSrvl46an/
X-Google-Smtp-Source: APiQypI9o2bwD3Rl25k/iF/AJY2XVhlgdDcUL5VmxP3Zku/8sQ6TYEaMH/D9nCezgxUXVk03PhI0E3QpUUHBAXhYlxU=
X-Received: by 2002:a2e:9652:: with SMTP id z18mr1009476ljh.79.1585933895212;
 Fri, 03 Apr 2020 10:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200403133806.246918-1-alainm@chromium.org> <D3C05492-13B9-447C-982B-26B681C9EF8C@holtmann.org>
 <CALWDO_Xy0m4PyAACDAHmf9wmPGwKoW6keYWHy8UKjNcsLF5SDQ@mail.gmail.com> <BF96E348-7D97-4FF8-A888-4B8338ACF6CA@holtmann.org>
In-Reply-To: <BF96E348-7D97-4FF8-A888-4B8338ACF6CA@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 13:11:23 -0400
Message-ID: <CALWDO_XOkASZd=YXbLt+otyjtmVcSQtwDai0HjkuA_X-RCor4g@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth:Adding driver and quirk defs for multi-role LE
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 3, 2020 at 1:05 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >>> This change adds the relevant driver and quirk to allow drivers to
> >>> report that concurrent roles are well supported by the controller.
> >>>
> >>> This has historically been disabled as controllers did not reliably
> >>> support this. In particular, this will be used to relax this conditio=
n
> >>> for controllers that have been well tested and reliable.
> >>>
> >>>      /* Most controller will fail if we try to create new connections
> >>>       * while we have an existing one in slave role.
> >>>       */
> >>>      if (hdev->conn_hash.le_num_slave > 0)
> >>>              return NULL;
> >>>
> >>> Signed-off-by: Alain Michaud <alainm@chromium.org>
> >>> ---
> >>>
> >>> drivers/bluetooth/btusb.c   | 2 ++
> >>> include/net/bluetooth/hci.h | 8 ++++++++
> >>> 2 files changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index 3bdec42c9612..22e61a502d40 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -58,6 +58,8 @@ static struct usb_driver btusb_driver;
> >>> #define BTUSB_CW6622          0x100000
> >>> #define BTUSB_MEDIATEK                0x200000
> >>> #define BTUSB_WIDEBAND_SPEECH 0x400000
> >>> +#define BTUSB_LE_CONCURRENT_ROLES_SUPPORTED \
> >>> +                             0x800000
> >>>
> >>> static const struct usb_device_id btusb_table[] =3D {
> >>>      /* Generic Bluetooth USB device */
> >>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> >>> index 5f60e135aeb6..b2c76cde7cd4 100644
> >>> --- a/include/net/bluetooth/hci.h
> >>> +++ b/include/net/bluetooth/hci.h
> >>> @@ -214,6 +214,14 @@ enum {
> >>>       * This quirk must be set before hci_register_dev is called.
> >>>       */
> >>>      HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> >>> +
> >>> +     /* When this quirk is set, the controller has validated that
> >>> +      * concurrent LE roles are supported.  This mechanism is necess=
ary
> >>> +      * as many controllers have been seen has having trouble initia=
ting
> >>> +      * a connectable advertisement after at least one connection in
> >>> +      * central had already been established.
> >>> +      */
> >>> +     HCI_QUIRK_LE_CONCURRENT_ROLES_SUPPORTED,
> >>> };
> >>
> >> lets do this the other way around. Lets remove the limitation we have =
in our HCI core code. And then we see which controllers report errors. Tryi=
ng to enable each controller individually is cumbersome. I rather later on =
blacklist the one or two historic controllers that don=E2=80=99t support it=
.
> >>
> >
> > I agree it's cumbersome but given we don't have much data or existing
> > tests around this, we don't have too many options.  I strongly
> > disagree with the approach of simply enabling it and seeing what
> > breaks as scenarios using this functionality are expected to scale out
> > quickly, likely before we have time to fine all controller issues.
> >
> > My team is building test infrastructure to help collect data with
> > this, we already know it's already problematic on a range of
> > controllers and we have a good idea on which controllers which will be
> > set.  We will contribute to the cumbersome part of this.
>
> can we at least do something a bit smarter based on the LE Read Supported=
 States command?
>
> If that command in general indicates that central and peripheral mode is =
supported concurrently, we provide the support for advertising. If it is no=
t supported, we just don=E2=80=99t indicate support for advertising.
In an ideal case I'd say yes, but that's also proven not to be a
reliable metric.  Unfortunately it doesn't seem to be covered by
qualification program and as a result, it is largely not trustworthy.

>
> So I have a really bad experience with the move from Bluetooth 1.0b to 1.=
1 and the HCI Reset on init. We got that wrong by whitelisting
hardware and it came to bite us badly when the number of controllers
increased that just got the spec right.
I'm afraid I don't have a good exit plan for this at the moment.  It
may be something we either need to have some sort of extention for the
hardware to report the appropriate support or better, fix the
compliance gap so after a particular HCI version the bit field becomes
trustworthy.
>
> Regards
>
> Marcel
>
