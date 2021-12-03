Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D83C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383214AbhLCVpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbhLCVpX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:45:23 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56BC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 13:41:58 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id az37so7954881uab.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 13:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lb0V5Ql4JVotHnIB4saXtIFV6mhw9E9UWo2gomIQIvs=;
        b=gTDqf5Za+LKuMBMWtIlTa6h9r5UHyFsDlMazLLyytfM0PnyCPu1OIkWC98PSlCXZ1a
         u5hZzI2HDVoe/a/5zK53Wy+uDCEtAHWyx+l+YjBEbdux5sqPGa9J9DC/ktyuxhNGmy09
         AkwNVNZwXt2cDpkz70s1u37KiYASeUmXAn7tuhza8b6+u0oI0bNl1Ekg0fiuF/pVEDIg
         TbzOzTOBlmJ4nWbiznl8ncTtjxpcCKQ9ZzuuUHh+G89R77mZlLPCh70B+2jl97WlQsOv
         k5fBB4g92fZm/8IfBq5amCjWjBbUKcv8B7Gr9oybbjz3KnL2XPPs+QY/UADGhV/EPl6J
         13gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lb0V5Ql4JVotHnIB4saXtIFV6mhw9E9UWo2gomIQIvs=;
        b=rJ8B5ciSCX5bdLaXnFZPmm+Vb6Z04Vq20iUbOkOThdTnBrQlgK4ACmH/T/yg1Hq6BG
         +Ywv8VpEvCku/x5Tz0NMO+yr6SowJTywjiPTyhCfVN59IEpwwhmc5OmCk5gCuyUJGUMs
         QaXQUFmFO7BwMg1h0J2o6v5embDEkcMOd4x8h/cZRjupdhv2AzMzy48dylIopz5BxvTE
         mkNHdbYi25MvRij1K0aNWWVUJWzY3KbNo+C7VJxDb611+TSmYinaV1CzMypXBFoJP/7+
         ezfKzSuvojNZL1so9t+UpVdq7sKqQlbSRBp/TFAjPu5Z8SSUbLjvM9+uUoNylsISWZPa
         TEPA==
X-Gm-Message-State: AOAM532MaWIdmqam89onsjh1x0GEbr80ekgJPNCYbq5nYUy3s/aNhxe4
        pT2vbxLroDA9cvYcNjN3slPLIO3C0R2pvmDSsh1tWLIc
X-Google-Smtp-Source: ABdhPJx3ywOR3bT9X+wKS+S+jJERZlLnf4K3jfKHOPVcYCflOB2XLDzE04K0OqMhCL88egZ/cTPxHjiE+hQApIOx8TI=
X-Received: by 2002:a67:5f45:: with SMTP id t66mr23754551vsb.64.1638567717719;
 Fri, 03 Dec 2021 13:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
 <20211120012448.1476960-3-luiz.dentz@gmail.com> <0B2956DC-56B1-43A2-BB4A-CF42ABFC9C30@holtmann.org>
 <CABBYNZKZ-VNtMDDAJrEokVUHqh8MSrZ8eR9mJaoX7ASrOt3tRQ@mail.gmail.com> <B7D70E25-E96B-4309-8EA3-00D8B9BF5F41@holtmann.org>
In-Reply-To: <B7D70E25-E96B-4309-8EA3-00D8B9BF5F41@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 13:41:46 -0800
Message-ID: <CABBYNZLsEYAWriqGnEOis0TMkNpPk3-xPzcCrBneNBcGyhC97Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Dec 3, 2021 at 1:12 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> >>> userspace to indicate to the controller to use Device Privacy Mode to=
 a
> >>> specific device.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/hci_core.h |  1 +
> >>> net/bluetooth/mgmt.c             | 12 ++++++++++++
> >>> 2 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> >>> index fc93a1907c90..9c94d1c49b25 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -153,6 +153,7 @@ struct bdaddr_list_with_irk {
> >>>
> >>> enum hci_conn_flags {
> >>>      HCI_CONN_FLAG_REMOTE_WAKEUP,
> >>> +     HCI_CONN_FLAG_DEVICE_PRIVACY,
> >>
> >> coming this now, I wonder if we better call them FLAG_REMOTE_WAKEUP_SU=
PPORT and FLAG_DEVICE_PRIVACY_SUPPORT. If I am not mistaken, then these are=
 for indicating support for it.
> >
> > These flags are used in multiple places:
> >
> > hci_dev->conn_flags
> > hci_conn_params->conn_flags
> > bdaddr_list_with_flags->flags
> >
> > Which is one of the reason I made them all use  DECLARE_BITMAP(flags,
> > __HCI_CONN_NUM_FLAGS) so they are in sync, the use of them in
> > hci_dev->conn_flags means they are supported but in the other 2 it
> > means they are in use, so I prefer leave as they are.
>
> is my comment wrong? Don=E2=80=99t they always indicate the support for i=
t?

Support vs Use, anyway I always think about the shortest form for
defines and having some term like SUPPORT sounds a little superfluous
for me, but I'm fine adding it if you really think that is necessary
in this case.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
