Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18E0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 21:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346692AbiEaV14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 17:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbiEaV1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 17:27:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EDE49FA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 14:27:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h1so4759721plf.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABIQu6MioK9dy2CxFtDcXBj5iCOciZitvtloqX7lBno=;
        b=hZ7mO5ir6L29jTh4f/WhGKx4Pt69xFAYgLILw+i06c37tJ8xYtue+v7PP1uSJnft+3
         CRWQtlhXbWk8Pm/qvCEMbVU+cU3lrIbtJYU08pIB9qwvTFRRtm/yKebT15su+GFErPaV
         7nRGcNehNowGkQ0Gvj4Mv+ayGfOd84wI6tDrEOzoiI0siFyOUB0DMnYY9cw3SFJC6FGL
         Q4W2Xn9JZhtv5ZgXom6dLQe5dwFYoc3NqGy9KV6y5paQhriIR5bf8tC9hIC7dCI0Wh2J
         Vld3qmoxQ0ZAJrwnMkytHBqqvvzmm/qkqAxOmZgeBEEjPnOfLBujrHTc91OAZe6Fya6L
         OtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABIQu6MioK9dy2CxFtDcXBj5iCOciZitvtloqX7lBno=;
        b=Uc65rGdNrRDIsFUaXaaFdUEeF1GUZnRn6ElCyj0C/7ZzBuWYR3pNdBN6cEArK7btfR
         ZuC1WN3P2h0ZCknab7HBeyoONAo3LwVf+0ZeN1HwQbGY4xlZeRnKx3JcAXnEuxi556Na
         1J8XpNGFoGELOkPnyOAnvA0oIzNBnL0m2RA6XTx7xEdUHL2GbqcAW9FH3YfKJ12S3Rn4
         or19MgpWk0uErW7YDxwh3iSEXSZ5pEwz5KGOXkeK/TS+KIBbn9TR5xwyAs+nxHyuX7r3
         8wakOZA0xhKKKAhU8oVolX+IRRUWF4frJvROeAmNYxUMRoPuFx1S4Irsb2BAO51gzlRQ
         p5vg==
X-Gm-Message-State: AOAM533pBRbzp9CazaiWce9u71ZmJ8linJoQOVqHzO1vX4ui92cTGBKw
        1pK59RcIK0Hwa/K0KDye6HLQup7D78PGO2aALwKMKzYF
X-Google-Smtp-Source: ABdhPJxFHg9lG1EF3Nqedwok+j2zt6ZPr47KZtabcL3uaLxwAaREWigtKtQqlMnakDVD+2aelzuVoD9JnDsCDe9ugAQ=
X-Received: by 2002:a17:903:244f:b0:162:4daf:f8bb with SMTP id
 l15-20020a170903244f00b001624daff8bbmr37515523pls.20.1654032473028; Tue, 31
 May 2022 14:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220513234611.1360704-1-luiz.dentz@gmail.com>
 <83CE64EC-65DE-4DE9-994B-4729A35A6F64@holtmann.org> <CABBYNZ+Pd-5VbptVNwyd+7J2cFYr3rPUtPPc+L2s8cqzbBkKLg@mail.gmail.com>
 <56E87E28-21A2-400B-AB1B-EBEE2DBBC849@holtmann.org>
In-Reply-To: <56E87E28-21A2-400B-AB1B-EBEE2DBBC849@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 31 May 2022 14:27:41 -0700
Message-ID: <CABBYNZLurFxPz6MKzX3RmCO_usvayZoxK29eVBahWN_WFu4LtA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Add bt_status
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, May 20, 2022 at 2:16 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This adds bt_status which can be used to convert Unix errno to
> >>> Bluetooth status.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/bluetooth.h | 1 +
> >>> net/bluetooth/lib.c | 71 +++++++++++++++++++++++++++++++
> >>> 2 files changed, 72 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> >>> index 6b48d9e2aab9..cfe6159f26bc 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -521,6 +521,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
> >>> }
> >>>
> >>> int bt_to_errno(u16 code);
> >>> +__u8 bt_status(int err);
> >>>
> >>> void hci_sock_set_flag(struct sock *sk, int nr);
> >>> void hci_sock_clear_flag(struct sock *sk, int nr);
> >>> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> >>> index 5326f41a58b7..469a0c95b6e8 100644
> >>> --- a/net/bluetooth/lib.c
> >>> +++ b/net/bluetooth/lib.c
> >>> @@ -135,6 +135,77 @@ int bt_to_errno(__u16 code)
> >>> }
> >>> EXPORT_SYMBOL(bt_to_errno);
> >>>
> >>> +/* Unix errno to Bluetooth error codes mapping */
> >>> +__u8 bt_status(int err)
> >>> +{
> >>> + /* Don't convert if already positive value */
> >>> + if (err >= 0)
> >>> + return err;
> >>> +
> >>> + switch (err) {
> >>> + case -EBADRQC:
> >>> + return 0x01;
> >>> +
> >>> + case -ENOTCONN:
> >>> + return 0x02;
> >>> +
> >>> + case -EIO:
> >>> + return 0x03;
> >>> +
> >>> + case -EHOSTDOWN:
> >>> + return 0x04;
> >>> +
> >>> + case -EACCES:
> >>> + return 0x05;
> >>> +
> >>> + case -EBADE:
> >>> + return 0x06;
> >>> +
> >>> + case -ENOMEM:
> >>> + return 0x07;
> >>> +
> >>> + case -ETIMEDOUT:
> >>> + return 0x08;
> >>> +
> >>> + case -EMLINK:
> >>> + return 0x09;
> >>> +
> >>> + case EALREADY:
> >>> + return 0x0b;
> >>> +
> >>> + case -EBUSY:
> >>> + return 0x0c;
> >>> +
> >>> + case -ECONNREFUSED:
> >>> + return 0x0d;
> >>> +
> >>> + case -EOPNOTSUPP:
> >>> + return 0x11;
> >>> +
> >>> + case -EINVAL:
> >>> + return 0x12;
> >>> +
> >>> + case -ECONNRESET:
> >>> + return 0x13;
> >>> +
> >>> + case -ECONNABORTED:
> >>> + return 0x16;
> >>> +
> >>> + case ELOOP:
> >>> + return 0x17;
> >>> +
> >>> + case -EPROTONOSUPPORT:
> >>> + return 0x1a;
> >>> +
> >>> + case -EPROTO:
> >>> + return 0x19;
> >>> +
> >>> + default:
> >>> + return 0x1f;
> >>> + }
> >>> +}
> >>> +EXPORT_SYMBOL(bt_status);
> >>> +
> >>
> >> why are exporting this?
> >
> > Isn't it supposed to be exported since it is part of lib.c? All
> > functions in this file use it.
>
> is it used outside of bluetooth.ko?

Currently not, I just thought it would be convenient to have it
accessible for the drivers as well since it is complementary to
bt_to_errno.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
