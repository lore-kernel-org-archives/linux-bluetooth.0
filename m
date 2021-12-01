Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDD1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 19:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbhLATXZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhLATXY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 14:23:24 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835CC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:20:01 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id e27so16901973vkd.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 11:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGC6Sc3o0jtK9JkuWtujBnJlJkJ2ssmEhakh/XLCLx8=;
        b=FvTbKOuasvAGNI0VgeHqJhbI4fPGU5J59QEUoFcXHvC7qzj9on0iOdw31YFg1us97Q
         fxRFEhpvn01sCnsmLVWrAPgZIObb0hyMTHhwSGVJbdX8Fd6U2BKCMTPReiBQETT5rCjy
         2A8NRI8I+PTM2v9UUB21pPGkwU2ZwXI/KkuHTqPJ7BpLTUU7paBW+eBl0jj9LXrs65Jd
         OtKq7O69m5Qk8Ey8Qd5ieknGAo30OtFQdXwcr3X+ighgOy8EBpYQqCe5Cb/H4cDNf6TS
         NPnbwZzM28myQeKiSXwyClztRa+kxARvFSw+50jW01ghoAm7DBHBbA+RC71TdG0LqjXG
         XqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGC6Sc3o0jtK9JkuWtujBnJlJkJ2ssmEhakh/XLCLx8=;
        b=RRJScJyyVpnIrdF7EkZJqAArRawW59xlt/XfHCNxnaovGp8GblZIzwfEc3QYM40kzu
         oV9csw0j3vHBkwfeJowThAhFK78QqcCAr4J8xx82WKGG2NY13GYCOpy5F73g6gwcYFLS
         6qhuD0+AJdVdz9AxI/IfkC88FY++pxpEyFzLG/S+Ty/2RPBuogS7qgBeVQ2M5GXsawfI
         3i75HEzhutgs7ekNO9ITl3hjCRj8NK1UFTi9EjjutePLAVwJKKddcdjhzNcWCxNrlu9A
         izumBFvXAHK6SWo4U5JjqzokAcJCBd8vAwtG3GlWCuH0cHR/QZoCmL0TJgLqMi7ClhxF
         bVJg==
X-Gm-Message-State: AOAM5324QD7AueyaeY3TXthqQmXsomb2UUZxgSxeOwysTceCurqQupRi
        knOn1zkVspgCUnMTFnW1vkDVyYyyTiL60GYajTV3uqtEYEg=
X-Google-Smtp-Source: ABdhPJzYu9iNEtScXzPK0AZWy0x/P81vidGkpsKiHFTSDlluue1ncTystHWPOs/fr8LlpvOIdtdNE7kP2wXbOXbFHVM=
X-Received: by 2002:a05:6122:b64:: with SMTP id h4mr11231286vkf.21.1638386400888;
 Wed, 01 Dec 2021 11:20:00 -0800 (PST)
MIME-Version: 1.0
References: <20211120012448.1476960-1-luiz.dentz@gmail.com>
 <20211120012448.1476960-3-luiz.dentz@gmail.com> <0B2956DC-56B1-43A2-BB4A-CF42ABFC9C30@holtmann.org>
In-Reply-To: <0B2956DC-56B1-43A2-BB4A-CF42ABFC9C30@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Dec 2021 11:19:50 -0800
Message-ID: <CABBYNZKZ-VNtMDDAJrEokVUHqh8MSrZ8eR9mJaoX7ASrOt3tRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Nov 24, 2021 at 7:27 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> > userspace to indicate to the controller to use Device Privacy Mode to a
> > specific device.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci_core.h |  1 +
> > net/bluetooth/mgmt.c             | 12 ++++++++++++
> > 2 files changed, 13 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index fc93a1907c90..9c94d1c49b25 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -153,6 +153,7 @@ struct bdaddr_list_with_irk {
> >
> > enum hci_conn_flags {
> >       HCI_CONN_FLAG_REMOTE_WAKEUP,
> > +     HCI_CONN_FLAG_DEVICE_PRIVACY,
>
> coming this now, I wonder if we better call them FLAG_REMOTE_WAKEUP_SUPPORT and FLAG_DEVICE_PRIVACY_SUPPORT. If I am not mistaken, then these are for indicating support for it.

These flags are used in multiple places:

hci_dev->conn_flags
hci_conn_params->conn_flags
bdaddr_list_with_flags->flags

Which is one of the reason I made them all use  DECLARE_BITMAP(flags,
__HCI_CONN_NUM_FLAGS) so they are in sync, the use of them in
hci_dev->conn_flags means they are supported but in the other 2 it
means they are in use, so I prefer leave as they are.

-- 
Luiz Augusto von Dentz
