Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E99C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EAB2065C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YED3WxuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFEAMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAMI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:12:08 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395AC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:12:06 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so6249580oti.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DNLU9SVwrEq2VnP0O58aXHrPI/KPyFMB2pG4V1owunM=;
        b=YED3WxuGqq3HMFCJ9ovUwbpLTC/f/AsAt6P0DKlSelIOOTLwjiRtSA4/QPXO4L9/Ji
         /1p8QMRibpcyuX2PRrVXbvZlTvZSMchWwZM/kmUpgBI8Hf3fkr8IQpnS/3jdDK5iU3Uo
         Bk+p2V7MBdT5dgeFr8nVt5HZmcs0VbTtVuPBHO3+x+Wo89z38k2O4hWlrsdrQ9v5AdYY
         T54/rVbCYy1wTrbJpDFtHd7A1TiEcnoU1gHoq0oPZHniMb+zqqJtyZqPNOxdhgInEVaq
         bmrlRmZSQ7X7kXBmR8hL0vAMKOPf7b+fNun/NYPU9YsKsoTtJ1tx5h0AdHZ+9asoO3Sr
         n7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DNLU9SVwrEq2VnP0O58aXHrPI/KPyFMB2pG4V1owunM=;
        b=Ctrfu8kHFe1J5cNBuv5bbsA7xmIZIz7NO/DyogD0xNFxZGTe1NmYzeP9Fxp6vFJ+SS
         fgR+YDw416MVDaPAaZCfsGWrWfe7ip3ASpEtBXiqkKAIhauuICFsJvPjQVs9vBDa8LeW
         RJD4wlVd3qGCgvdeWGh2eVGIIQcJPLo7ZbksnAztP8j1dz67Y9aY4s9ZOVT0JzO//tzv
         AWswDEIRHysvkZfXZUM2e3OXV3dvkT42x+4QTlbUHz28IhSpc8GFTe7AvR6rPg22g7M1
         sO7ok0E361Gy6g3OJTRW1dY7vL4OdGB7Uz7v9Q9vYsFo+Ft5jsWu2SCB62onJLBbExgd
         RAiw==
X-Gm-Message-State: AOAM532hw6f0MGvAsVFJDg8C+xHKU3cYOT50Yr9E4R+WRG2CfbMwCJ0N
        3fp41x5gghvh1fmBHCtcoRdNFugbeCx11A1rdiw=
X-Google-Smtp-Source: ABdhPJwo5AmOA+tWvteECjWVCTSD6gyi953YW0c1/xnhGWm+zw7muOw9uSjfRAbvxEqbvxtQ/fDeZl+xYD9G1hK5mzQ=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr5859148otq.79.1591315925978;
 Thu, 04 Jun 2020 17:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200604231541.4170-1-pali@kernel.org>
In-Reply-To: <20200604231541.4170-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Jun 2020 00:11:54 -0700
Message-ID: <CABBYNZ+3QO8C_h15=6AgVYSY=Ki-eq=Mg2_mv_cp7QjkTHVpuw@mail.gmail.com>
Subject: Re: [PATCH] btio: Fix registering Object Push, File Transfer and
 other L2CAP profiles
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Jun 4, 2020 at 4:18 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> When bluetoothd daemon is starting, it prints following error messages:
>
> bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed =
for Message Notification: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed =
for Message Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed =
for Phone Book Access: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed =
for File Transfer: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed =
for Object Push: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
>
> Result is that Object Push and File Transfer profiles do not work at all.
>
> Debugging set_l2opts() function showed me that src/profile.c calls it wit=
h
> L2CAP mode 0x01 (L2CAP_MODE_RETRANS). But kernel bluetooth code in functi=
on
> l2cap_sock_setsockopt_old() for L2CAP_OPTIONS option disallows to set L2C=
AP
> method to 0x01 (L2CAP_MODE_RETRANS) and just returns -EINVAL (22).
>
> These bluetooth profiles have in src/profile.c file defined L2CAP mode to
> BT_IO_MODE_ERTM and not to RETRANS. So it means that BT_IO_MODE_ERTM valu=
e
> defined in 'enum BtIOMode' must be incorrect.
>
> Digging into git history, it appears that 'enum BtIOMode' was broken in
> commit f2418bf97d ("btio: Add mode to for Enhanced Credit Mode") which
> basically broke all those Object Push, File Transfer, Phone Book Access,
> Message Access and Message Notification L2CAP profiles. That commit remov=
ed
> some values from 'enum BtIOMode' and therefore broke all bluetooth code
> which uses 'enum BtIOMode' for communication with kernel.
>
> This patch fixes 'enum BtIOMode' by reverting back BT_IO_MODE_RETRANS and
> BT_IO_MODE_FLOWCTL modes, so BT_IO_MODE_ERTM has again correct value 0x03=
.
>
> After applying this patch, Object Push and File Transfer profiles work
> again.
>
> Fixes: f2418bf97d ("btio: Add mode to for Enhanced Credit Mode")
> ---
>
> Hello Luiz, could you please review this patch? As that problematic commi=
t
> f2418bf97d was introduced by you.
>
> I'm curious why nobody else reported this issue about broken Object Push
> and File Transfer profile as it should print those error messages... Or
> maybe error message is visible only in debug build and nobody is using
> Bluetooth File Transfer anymore?

Looks like you are right but, see bellow.

> ---
>  btio/btio.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/btio/btio.h b/btio/btio.h
> index 23e0ef72b..0d183e3ce 100644
> --- a/btio/btio.h
> +++ b/btio/btio.h
> @@ -68,6 +68,8 @@ typedef enum {
>
>  typedef enum {
>         BT_IO_MODE_BASIC =3D 0,
> +       BT_IO_MODE_RETRANS,
> +       BT_IO_MODE_FLOWCTL,
>         BT_IO_MODE_ERTM,
>         BT_IO_MODE_STREAMING,
>         BT_IO_MODE_LE_FLOWCTL,
> --
> 2.20.1

These modes were never supported by the kernel thus why Ive dropped
them, so might want to translate them to the old L2CAP modes when
set_l2opts is called.


--=20
Luiz Augusto von Dentz
