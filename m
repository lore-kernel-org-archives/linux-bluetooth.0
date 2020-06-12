Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F761C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5974120691
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hndUUFzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLPBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPBW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 11:01:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5EC03E96F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 08:01:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so11406930ljh.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHf5KKUoTUO0JgWWRs9KZUpWuw3+9kuvXEde3HxBiRw=;
        b=hndUUFzgq9UIgA+wiNmGWt3udwn7wuKqNUJmVWqVDMSbbqYi7eFyXELadnJJGa38TI
         QSAXurMgaw6opID8X8av2AJce02nGUVGGdtBxMkF3K8DwqxOuET4In35uAll6Ibo07mz
         l+PqgEPH+7OmGpdOWtVvvLtKqLSSAk0xQboW67IJKlg9rCNp6WRe7eK8qmiPAkPbw9BR
         YwkNTJAgDHf3Y9WI8oJCZLxS7/0sDTlgOpwW9gcWEXqz693SEW+1ZWTPgpbKN5h5MVWU
         adRU/m6Ok2qUw3kGkTdo1UoZtCH+CfXfw1qzKoVq0FzOELKxOQ12TY7d0ZjcJY4ZsWBL
         Q0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHf5KKUoTUO0JgWWRs9KZUpWuw3+9kuvXEde3HxBiRw=;
        b=CEzuZpk5c9EgL4UoFmPJ1sSNa/DXtWZ3PeAuplULCSzsta9NVQ9hb5N4+wclAsActd
         U0qr4IzBF0xdOyt2stIpOE66ECQPAytWqS+/euqYgmzaRgsxlrsPgjCF8IMb2PKZjvAQ
         DM8Eq0ZtZMLoXIlZIZB8vQ4pcIRqv0T16dk5ovqqqM/fFG7Lsp1lAuPrwunkuqL4qwUt
         HBMr/A/56VsgT+oaoLVg3vqAMiGbCxZ/ZY7taXA3lROR8itvmenhgl4kC+4BCK4BD+1P
         9AtHNcq3ZwvKcHtZZ/v4HpyVeE3QsuJ2qAWBPJUPgft/QS+AefnxxFuJmKJia4U7Locc
         Rpsw==
X-Gm-Message-State: AOAM531iP+zy2Nr624vWneGAge9apu/57GtfK/e6eqBscHJpbJJX7Drg
        MwWZo5H2B2//1Ym/jwhcJqCuYes3P4I2gE6kDZPmWA==
X-Google-Smtp-Source: ABdhPJy/YP0F7t/uPtSjz8vuoIC2BHGOwctOdN75diiP4S3byEeZ2nCkn9p8j8M64sskASC2VabJYk/B66vsww0mhQc=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr7170416ljj.3.1591974080169;
 Fri, 12 Jun 2020 08:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200611195041.46839-1-alainm@chromium.org> <CE137166-3D51-40C1-819C-D6CC91639439@holtmann.org>
In-Reply-To: <CE137166-3D51-40C1-819C-D6CC91639439@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 12 Jun 2020 11:01:08 -0400
Message-ID: <CALWDO_XGb7e7GExZd386kUPMAPtfYfz_Us7UNyTh7cUSrC-KMw@mail.gmail.com>
Subject: Re: [PATCH v6] sco:Add support for BT_PKT_STATUS CMSG data
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel!


On Fri, Jun 12, 2020 at 9:12 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > This change adds support for reporting the BT_PKT_STATUS to the socket
> > CMSG data to allow the implementation of a packet loss correction on
> > erronous data received on the SCO socket.
> >
> > The patch was partially developed by Marcel Holtmann and validated by
> > Hsin-yu Chao.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> >
> > ---
> >
> > Changes in v6:
> > - Fixing sparse errors.
> >
> > Changes in v5:
> > - reducing cmsg_mask to 8 bit
> > - clarifying the public symbol usage versus internal CMSG flags.
> >
> > Changes in v4:
> > - Addressing feedback from Marcel
> >
> > include/net/bluetooth/bluetooth.h | 10 ++++++++++
> > include/net/bluetooth/sco.h       |  2 ++
> > net/bluetooth/af_bluetooth.c      |  3 +++
> > net/bluetooth/hci_core.c          |  1 +
> > net/bluetooth/sco.c               | 32 +++++++++++++++++++++++++++++++
> > 5 files changed, 48 insertions(+)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
