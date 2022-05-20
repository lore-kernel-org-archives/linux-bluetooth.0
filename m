Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A1CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348088AbiETSje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiETSjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 14:39:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A216195BCA
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 11:39:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so8419020pgj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDOSI6C3zaaG1qskO5rCoAdt7tYfK685tL5TGqpkW1o=;
        b=Iqcf+lkRKRSwvNhjzqxSWaddtL9m7Wy8yTfchFXd2tGLGkvcaF4HOCAe5pIb71AVGN
         RybgoUiXBsRI+YXtlSE2m3LnayKD+NyDJicFo1HOkgBpjjR75AIq/RR4q0kWNfAWFkLi
         msH8fcwrKIyngz4dSQP3fq2JsSKIW9MvJ235F3NlFQJb9atfghoaGkgB+4resDFeimsb
         T/F+TVJTDKMduJc8gNS/UFp3o5wuTWUWbooe8yXytALykwyolmX+yCRvBG7LXA2nBjhc
         mfxTOtJrJsKz9dmKCpK/3Glc5Gw3lpbCJCkfSSC08+kV72GqH44fJrEehZyAkCXCU4fs
         PWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDOSI6C3zaaG1qskO5rCoAdt7tYfK685tL5TGqpkW1o=;
        b=F9+084mcGXAhmw2ZUfVGFZ4jk5qmYVU/L2A4R35Y2ATEje4a5k8fioR4Kadp1S9bsE
         tUKHBTq3UQpitVxmC3/AaPxgS4GZQxoOBNtZ7Z2o3QrD9qjh8mjl/IFVQBnyULXj5+9a
         AU1FpeavPg5xut1YX9yTpIsF0yKTSv1KWQtB5fZHuYfebv9TTVu6XcZlO9/uFwKHE+jb
         foR22v11TuupJtmQtnN7Nm3w6ExmNICcXZzEOs2j+Bhwtr3afs2vcFrqDYKaMHcKbd7T
         XQgp8MHiIHj/a8PdDdQH5294Z8fSVEoJ2creM2cnY0/qanL7bB4pxWhhZjpcxz+JTXLU
         p4qQ==
X-Gm-Message-State: AOAM533b9Se2kLMZgu58aORsg4r2/mgjQoRq1KW37ORcJVArKPQsaHCB
        +WDRUixwq3/GumijCZ0t+txNykmYP71uG7xFINlHTBRw
X-Google-Smtp-Source: ABdhPJwP0AaL1bmkYv3ZOygN0lwmjU0LwM/ksqwWM4uVhxZ4qq1lhAWCyaGP/AUQ8HVleYM+7HI5YMIccZKRdEfH+7U=
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id
 bf8-20020a656d08000000b003c68a083b9fmr9633876pgb.147.1653071970765; Fri, 20
 May 2022 11:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220519202258.2459530-1-luiz.dentz@gmail.com> <4A64967D-9487-4E8E-80F1-64B0389B2D95@holtmann.org>
In-Reply-To: <4A64967D-9487-4E8E-80F1-64B0389B2D95@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 May 2022 11:39:19 -0700
Message-ID: <CABBYNZJ0s=rOddU53hNfqucwDW=-NaSn=_e3cmi-QYRq0QidHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, May 20, 2022 at 2:18 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > The handling of connection failures shall be handled by the request
> > completion callback as already done by hci_cs_le_create_conn, also make
> > sure to use hci_conn_failed instead of hci_le_conn_failed as the later
> > don't actually call hci_conn_del to cleanup.
> >
> > Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_conn.c  | 5 +++--
> > net/bluetooth/hci_event.c | 8 +++++---
> > 2 files changed, 8 insertions(+), 5 deletions(-)
>
> you are making a bit mess with yet another v2 of this. I rather have you mark this as [PATCH -stable] or something so that we get this one into that tree and then later the rest into -next.
>
> Regards
>
> Marcel

Just sent one with -stable, is that something we should adapt going
forward? Perhaps we should document this somewhere.

-- 
Luiz Augusto von Dentz
