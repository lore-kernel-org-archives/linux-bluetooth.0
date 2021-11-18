Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3263C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 16:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F560FED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhKRQMx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhKRQMw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 11:12:52 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD4C06173E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 08:09:52 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id t13so14744392uad.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 08:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++11JarpoD3GeXwfpa5uAn6sitkJX4EkFYOUroczE7I=;
        b=HATPAw6eOQNfX8uUFdFbQxNUWscxiV1WuiKi+izirecPxBI4P9UfFqyCZPcrl7DA/T
         vjS49k+KMsMU2VBwm8M2KMvoCZhVgvSVxYrgEj1BF6eArupiswoOqPouVqcBvZx1qb//
         yFOz+nsQ+Iw6tlFOJfPWNlZr7ScbxRKTYpsbNwkkp4ljiw6RFY3K+oKPbiuNsnsc3VdR
         Neat+SrEEEQfCA/3eLOmkf+NL0SiNd9tyn+2FFLVAof2Cnnlzoaz1t8zm7/0xZEmlxVi
         CUlqd+S4rWjf+qHT7TOt0ya+SNnLROWF9dLkgPWBeF1slAzRiYP9rAZ38O2LnxJ78dje
         PRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++11JarpoD3GeXwfpa5uAn6sitkJX4EkFYOUroczE7I=;
        b=gfSel93+hVYxp+55NbLlhSjZjHndwi+lmkyZ7d1n8Do34KecJ5jh7XLj92E7W2LwPG
         4jlNdylm5VfNE5wecP1Kajstup+WtresPpA5wb+zj7r7vSPhnrNTtCVU1iB46kwPtwAn
         9JbT7kKG611j/Q0U3YZjUDC6ZKRzyPNM9vZv+OlMJuGVRBDbKOIKV/QON61yRWD8ywc9
         AHHrBBNfFKJ2nGpUvSJzE/lfIDm6sZ1gD4XiNyR/X58+FOQcshnwOHCeGxz+3Jnj7JQQ
         +TjOjTlWislouDoVzlHlT7gioRbDcalrWLu+0/VMQUJzpFN6vPrGMbrcHKY3WJrZIqUX
         tTzQ==
X-Gm-Message-State: AOAM532vdUxdzoS5pTQnX+dqVT2o3qbWhISrQWmw2DJ+X6n/XAnJYTU+
        d2op/Akf7Uzz2eNiFk9ERU8E3+YsxajHy1ihFZY=
X-Google-Smtp-Source: ABdhPJxqsANewnSe4w3tBezgCV0iojQut/2KeojWKowYpxjPztSjk6cIkHhtw9fH5hRecsNRunYNB8+RGp0CkSAM7Zg=
X-Received: by 2002:a67:b844:: with SMTP id o4mr85764095vsh.61.1637251786756;
 Thu, 18 Nov 2021 08:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20211105222739.461398-1-luiz.dentz@gmail.com> <411F0489-163E-4809-B20F-282311A5BC36@holtmann.org>
In-Reply-To: <411F0489-163E-4809-B20F-282311A5BC36@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Nov 2021 08:09:35 -0800
Message-ID: <CABBYNZKZBrTnOoo9yGyYP7i8N9EzcmPpy_-FPngouZOzu+gUJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Nov 17, 2021 at 8:45 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> > userspace to indicate to the controller to use Device Privacy Mode to a
> > specific device.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Fix marking Device Privacy Flag even when adapter is not capable of
> > handling Set Privacy Mode.
> >
> > include/net/bluetooth/hci_core.h |  4 ++++
> > net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++----
> > 2 files changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index b5f061882c10..07d2d099dc2a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
> >
> > enum hci_conn_flags {
> >       HCI_CONN_FLAG_REMOTE_WAKEUP,
> > +     HCI_CONN_FLAG_DEVICE_PRIVACY,
> >       HCI_CONN_FLAG_MAX
> > };
> >
> > @@ -1468,6 +1469,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> > #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
> >                            hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
> >
> > +#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> > +                                (hdev->commands[39] & 0x04))
> > +
> > /* Use enhanced synchronous connection if command is supported */
> > #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 06384d761928..8a8376d32be3 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -4350,7 +4350,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> >                              MGMT_STATUS_NOT_SUPPORTED);
> > }
> >
> > -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> > +static u32 supported_device_flags(struct hci_dev *hdev)
> > +{
> > +     u32 flags = BIT(HCI_CONN_FLAG_MAX) - 1;
> > +
> > +     /* Check if Privacy Mode can be set */
> > +     if (!privacy_mode_capable(hdev))
> > +             flags &= ~BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
> > +
> > +     return flags;
> > +}
>
> I am lost on what we are doing, I know that SUPPORTED_DEVICE_FLAGS was introduced by 4c54bf2b093bb from Abhishek, but I fail to reason now why it is correct.

But we don't set the HCI_CONN_FLAG_DEVICE_PRIVACY is hdev is not
capable of setting it, anyway the general idea of the supported_flags
is to indicate to userspace what flags the kernel is capable of
settings, so yeah I would expected it to be capable of setting every
flag except for those the controller don't have proper support for.
Maybe you got confused by the logic of first enabling everything and
then toggle back the bits that are not supported by the hdev.

> If we really set all bits on the supported device flags, then that is a bug. Or is it too early for me to grok this code?
>
> >
> > static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> >                           u16 data_len)
> > @@ -4359,7 +4368,7 @@ static int get_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> >       struct mgmt_rp_get_device_flags rp;
> >       struct bdaddr_list_with_flags *br_params;
> >       struct hci_conn_params *params;
> > -     u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> > +     u32 supported_flags = supported_device_flags(hdev);
> >       u32 current_flags = 0;
> >       u8 status = MGMT_STATUS_INVALID_PARAMS;
> >
> > @@ -4423,7 +4432,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> >       struct bdaddr_list_with_flags *br_params;
> >       struct hci_conn_params *params;
> >       u8 status = MGMT_STATUS_INVALID_PARAMS;
> > -     u32 supported_flags = SUPPORTED_DEVICE_FLAGS();
> > +     u32 supported_flags = supported_device_flags(hdev);
> >       u32 current_flags = __le32_to_cpu(cp->current_flags);
> >
> >       bt_dev_dbg(hdev, "Set device flags %pMR (type 0x%x) = 0x%x",
> > @@ -4456,6 +4465,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
> >               if (params) {
> >                       params->current_flags = current_flags;
> >                       status = MGMT_STATUS_SUCCESS;
> > +
> > +                     /* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
> > +                      * has been set.
> > +                      */
> > +                     if (hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
> > +                                            params->current_flags))
> > +                             hci_update_passive_scan(hdev);
> >               } else {
> >                       bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
> >                                   &cp->addr.bdaddr,
> > @@ -7061,7 +7077,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> > added:
> >       device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
> >       device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
> > -                          SUPPORTED_DEVICE_FLAGS(), current_flags);
> > +                          supported_device_flags(hdev), current_flags);
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
