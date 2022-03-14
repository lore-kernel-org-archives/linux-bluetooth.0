Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 18:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiCNScY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiCNScX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 14:32:23 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B73DDC6
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 11:31:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jx8so12742404qvb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dW8o8MxEwRTcrsXdOuxwmkRI+eKo3H9OXkKdjk5Dnho=;
        b=vzH4iz1WcVXs7wIx4F9lJ22WspyqKGporQGqQKMWE2DI+iPCvCEzML9hatNadgzfNM
         eneUNBDk7FXPLyCzWZ9uSF81OtzkfNJM3PvdtigLm7j9VOlRYbnXOb6zHI/A4RXcAa96
         c4O3q7GZd68a2/OWfCKpJ7e1hNAV8rgi4HWTfGS2KWDRuzgrLt5cjSCvDYoaoVzPCyv0
         uceiV5Q7mQLdALpUtXP8fUN3yCtStbXZpMnEATBPVF4RYe34OvDLWNXGY+HaR4xE95aA
         cUDxPLLlMYu075O1SAp1GudcW57fixutUeLjtsa+OxeDOgwd0PwrVIEIy/RnKEs+sUSL
         nkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW8o8MxEwRTcrsXdOuxwmkRI+eKo3H9OXkKdjk5Dnho=;
        b=MeiN6QwFyiDGg26uApXwYu9tvOodPaoxMu8OGBKf1J2lJOJpFk4hj0RwD2Qdfb+hNa
         qtF0aLXl1KZFst2Nt+9IuZ9tQwFzZHwVy2GkntA207+9lKS/02VjkszKMfYdhNH2GuKj
         6g+zDoN0+fIOfZD66p0iILNKnHKPDeRA0jV5piusMCb+YyueamwtyS77SWe25Vo9N/1J
         y5/VVzfT6RNPUmDmr9uLf3yFkLLqqxOyM+3Apw5lGvXrvjfAHTsdfB2uZmDT1hcOkzBQ
         kz3ZrTIRKzOjh4BWTsPtPngfPxIZ1gYBs4bP1BWdgSZVADsh+JsTrDqaLzdLefY6XPk/
         6zsg==
X-Gm-Message-State: AOAM532qrGQnPyFTlYZMS6zowekXhETy2ej29E+pGMA6UjAu3SJU8gpT
        1Zm2CuphhkinXMmXrklBXioV8zpQFlBv7fJik8trAGu5FTxsVQ==
X-Google-Smtp-Source: ABdhPJwegnbo1NP3PunJ4hcD0+XYOy6bOqZQSjw8iuxI6cO/GGnic1P4MZ9nhCSfzuodYYyhQ9/COYovHrYXu+rp5nU=
X-Received: by 2002:ad4:5c4d:0:b0:43e:a8e3:228a with SMTP id
 a13-20020ad45c4d000000b0043ea8e3228amr10058814qva.3.1647282672487; Mon, 14
 Mar 2022 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220125185305.2419774-1-luiz.dentz@gmail.com>
 <20220314135044.2040-1-mike@fireburn.co.uk> <CABBYNZJfVnjuo9JPtapiHrfoXUoDYRQ0eMmh3n6-hx--jb=hSQ@mail.gmail.com>
In-Reply-To: <CABBYNZJfVnjuo9JPtapiHrfoXUoDYRQ0eMmh3n6-hx--jb=hSQ@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 14 Mar 2022 18:31:01 +0000
Message-ID: <CAHbf0-GUYcuj_rFdXAZ-VS-gY_mmbx2-05UdQ3W1VRxbFDkgwQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 14 Mar 2022 at 17:30, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
>
> We fixed this a while back:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/hci_event.c?id=314d8cd2787418c5ac6b02035c344644f47b292b
>
> --
> Luiz Augusto von Dentz

Yes, and it looks like that commit is queued for kernel 5.18. I was
hoping you could get it added into 5.17 where I'm seeing spurious
messages during boot, before it's released

Thanks

Mike
