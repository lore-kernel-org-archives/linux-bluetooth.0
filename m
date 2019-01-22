Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2253C282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 22:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE20217D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 22:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s09DgXtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfAVWaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:30:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45101 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAVWaT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 17:30:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so99161lfa.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfJaF5rZw1WpHVeU/lKvjOAxKYjfNoAOiPQJd080AZ4=;
        b=s09DgXtqesxzUaza8JYBpsdlUDWrSwx53RNeaveBTAs4fzYVQLbg6Gcp0hzLpdtCTK
         DA7gqLbUWqunLgFl1Zhk6DnwBQ6sjDMyvZI8hYrEXzbghUmt+NfR+GInFq8RbHux1iqi
         6nMez5BHpcdnLkC5/TqfVEba47uLTriutWpDsQs3t9aMFpqZl1cTqnYvnTVuhM46E3d3
         f8qSvMoODQLxS770Zq+o3FjKXuORKLmcnw5YJ8NR8JtGnqeC156uuGbs72wpGYIDPPIn
         wH6uuugwfZGf9txAMsAlOtrO6ErUKHtL35UkyduyPBuUgHka35zt4QkxZ2FiKJmvIQjr
         dhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfJaF5rZw1WpHVeU/lKvjOAxKYjfNoAOiPQJd080AZ4=;
        b=VcjQ1gOSvOGABTVmF0QO0+nBT65s/+nP5lpmvJLfj9j60P5bMZPa5CyScwOhUpeBsY
         RTnE5nQNGAW31Ar9bRSbt0JiGnUv9+E5IQl0F+Vz1Yxrfj9l+LhOsCrNouzR8LEgSZAO
         Ix4lmNCpT3OnQ544vXI3dAPKAehJ+Qcm6CZwTZYCoJNnblFPCZ7xprhJgdJaAxD1ApMT
         qqGPhvFwI+nK+QHx7qNTZYGmxnCdsTpQDI5bmtA1eeyq2rhobKq7HrglgnyUGXPPBuAC
         FZbtbOT6y8sDNzLyD3E5ZHXKjoqB7j/gu5sHEB0L9YYUbDW0fuHz06yl6YkODZwRRte6
         +YIA==
X-Gm-Message-State: AJcUukeWe7ZWOYKb1u15g5oPbHXU5QAhQanN2xJ7rglkotM0b5LsG7UB
        2VnMI0adis2duHTeV6C2xoP0vmB6DXGzW6ediKxp1Q==
X-Google-Smtp-Source: ALg8bN4iihXjDJm45ITxsxDpwVhfjNTp9M3tswDNpSs2pcF6JUE3G77ZjsicEl//gVyfeuExwsRHKUyg3bcpzMrVeZQ=
X-Received: by 2002:a19:db82:: with SMTP id t2mr23272607lfi.130.1548196216989;
 Tue, 22 Jan 2019 14:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-2-rajatja@google.com> <77FFC08C-D038-4BBE-9153-FBA1701D3168@holtmann.org>
In-Reply-To: <77FFC08C-D038-4BBE-9153-FBA1701D3168@holtmann.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 22 Jan 2019 14:29:40 -0800
Message-ID: <CACK8Z6Ez63Bn43WJL5X96GUr+U3T69UyymRtNg++1By_KUP=DA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] usb: assign ACPI companions for embedded USB devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Jan 19, 2019 at 11:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Rajat,
>
> > USB devices permanently connected to USB ports may be described in ACPI
> > tables and share ACPI devices with ports they are connected to. See [1]
> > for details.
> >
> > This will allow us to describe sideband resources for devices, such as,
> > for example, hard reset line for BT USB controllers.
> >
> > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/other-acpi-namespace-objects#acpi-namespace-hierarchy-and-adr-for-embedded-usb-devices
> >
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > Signed-off-by: Rajat Jain <rajatja@google.com> (changed how we get the usb_port)
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> > ---
> > v4: Add Acked-by and Tested-by in signatures.
> > v3: same as v1
> > v2: same as v1
> >
> > drivers/usb/core/usb-acpi.c | 44 +++++++++++++++++++++++++++++--------
> > 1 file changed, 35 insertions(+), 9 deletions(-)
>
> same question here. Which tree is suppose to take this?

Just responded to the 1st patch. Since the subsequent patches use this
feature, may be best to push this via your tree. Greg or Dmitry can
suggest if they have any other suggestions.

>
> Regards
>
> Marcel
>
