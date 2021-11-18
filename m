Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5910BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 22:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DED061361
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 22:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhKRWFY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRWFX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 17:05:23 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76DC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 14:02:22 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id y5so17020985ual.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nb3AzqBFnULovAiif0TV5vL+krJcbcoTqU42LwEwQ44=;
        b=JJ9NrKS8wdjSEjYpQ+j3c9gGB18uBWfR1bXYlMUuqxzqicth2xz9caLLE9ByDPYq1c
         6BLsk9Klf0Y+m2WexwMawk0nahCUXUBcvwiutC/1n3IbkIdnp/v8I+IABzf9jnXTmXsH
         lDKu9Yk+cPEbr5v6I/BAn9cYjIJ7+aFNqRkMkDFArIpoChq04C0aZGybLKOKHLHwh0Gk
         bJYiZTtNCWxkqC841FoG8KOxA3gAfpBTDpa+kOehdnI8zcxf+0sAGBMwYYQj+ulSx8YF
         wUBN+eOH9pZxXvOX07xMv32Chw9G+Vtnk1HYhjhgB6VuQ332BlGIFlZ1dsF4NSUoQICH
         vNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nb3AzqBFnULovAiif0TV5vL+krJcbcoTqU42LwEwQ44=;
        b=6b6kPiq37bia2pwEJLPI6+Hnyy25BQgj1C9V8Y0wwmyJFuyIONVNokDXgMDvACjaxt
         UQa6bv5xdHaTfDN3yOEXkVT5Qnt1tzVmOQ2O3eJhowddWH28Th6FpaovjPZAcqK0/Laq
         8RoKItfnn6HzGzolK/68kuh9Fzpr46HHe0jsNUbWN/hIBehuXLjQvgDKWPLHA61P6j3e
         0/vgbJiyHlBjBAyg9EpiYBFXdWgr2fraRgFZe2yG0IUBjKj2VsPzuONbM48o31XwEhoq
         eHTUjW1xkYMYqIfGq/+1LrJDaQsrSDVus8zFqvwWKJSxZmR7BlpaG8b2a3OOEbB4uXul
         Q2hQ==
X-Gm-Message-State: AOAM532ijD+UKxxqGlIG5czGB4psydvbh9z+8DR/h5ILzRh0WoaxqRLp
        4sRFv7D0681fel61nBoSTSEirV1dC6VGMbO6mgTu6pq/LrY=
X-Google-Smtp-Source: ABdhPJw1BRxvVC+cvcydkGfrNGXhZ5gII+Q8vgo2D9/ZK8ZbMDJN9a+MkcIVB3QYjL5NbyNFnGSqztKdKj+kPYoZO0w=
X-Received: by 2002:ab0:5a23:: with SMTP id l32mr41523115uad.129.1637272941787;
 Thu, 18 Nov 2021 14:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20211105222739.461398-1-luiz.dentz@gmail.com> <411F0489-163E-4809-B20F-282311A5BC36@holtmann.org>
 <CABBYNZKZBrTnOoo9yGyYP7i8N9EzcmPpy_-FPngouZOzu+gUJA@mail.gmail.com> <B47FBB15-3593-43AB-BA21-E08B34DE3C1F@holtmann.org>
In-Reply-To: <B47FBB15-3593-43AB-BA21-E08B34DE3C1F@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Nov 2021 14:02:11 -0800
Message-ID: <CABBYNZ+VaBM+FM9GAAAd5Kb4LJnfPs6LrZaU-KpVOwK7kPawpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY
 device flag
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Nov 18, 2021 at 9:19 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
> >>> userspace to indicate to the controller to use Device Privacy Mode to a
> >>> specific device.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> v2: Fix marking Device Privacy Flag even when adapter is not capable of
> >>> handling Set Privacy Mode.
> >>>
> >>> include/net/bluetooth/hci_core.h |  4 ++++
> >>> net/bluetooth/mgmt.c             | 24 ++++++++++++++++++++----
> >>> 2 files changed, 24 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >>> index b5f061882c10..07d2d099dc2a 100644
> >>> --- a/include/net/bluetooth/hci_core.h
> >>> +++ b/include/net/bluetooth/hci_core.h
> >>> @@ -160,6 +160,7 @@ struct bdaddr_list_with_flags {
> >>>
> >>> enum hci_conn_flags {
> >>>      HCI_CONN_FLAG_REMOTE_WAKEUP,
> >>> +     HCI_CONN_FLAG_DEVICE_PRIVACY,
> >>>      HCI_CONN_FLAG_MAX
> >>> };
> >>>
> >>> @@ -1468,6 +1469,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >>> #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
> >>>                           hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
> >>>
> >>> +#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
> >>> +                                (hdev->commands[39] & 0x04))
> >>> +
> >>> /* Use enhanced synchronous connection if command is supported */
> >>> #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
> >>>
> >>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >>> index 06384d761928..8a8376d32be3 100644
> >>> --- a/net/bluetooth/mgmt.c
> >>> +++ b/net/bluetooth/mgmt.c
> >>> @@ -4350,7 +4350,16 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> >>>                             MGMT_STATUS_NOT_SUPPORTED);
> >>> }
> >>>
> >>> -#define SUPPORTED_DEVICE_FLAGS() ((1U << HCI_CONN_FLAG_MAX) - 1)
> >>> +static u32 supported_device_flags(struct hci_dev *hdev)
> >>> +{
> >>> +     u32 flags = BIT(HCI_CONN_FLAG_MAX) - 1;
> >>> +
> >>> +     /* Check if Privacy Mode can be set */
> >>> +     if (!privacy_mode_capable(hdev))
> >>> +             flags &= ~BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
> >>> +
> >>> +     return flags;
> >>> +}
> >>
> >> I am lost on what we are doing, I know that SUPPORTED_DEVICE_FLAGS was introduced by 4c54bf2b093bb from Abhishek, but I fail to reason now why it is correct.
> >
> > But we don't set the HCI_CONN_FLAG_DEVICE_PRIVACY is hdev is not
> > capable of setting it, anyway the general idea of the supported_flags
> > is to indicate to userspace what flags the kernel is capable of
> > settings, so yeah I would expected it to be capable of setting every
> > flag except for those the controller don't have proper support for.
> > Maybe you got confused by the logic of first enabling everything and
> > then toggle back the bits that are not supported by the hdev.
>
> and I think that is wrong. We should only set the bits that the hardware and/or kernel supports. I have no idea on how I missed this in the review back then. I am trying to figure it out, but I am failing to follow this logic.

There is only 1 flag currently though, HCI_CONN_FLAG_REMOTE_WAKEUP, so
I wonder if that really requires a check? Or perhaps you want to
change the way we supported_device_flags works to:

index fe52b7eefb56..3ad09ce6eaeb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4351,11 +4351,15 @@ static int set_exp_feature(struct sock *sk,
struct hci_dev *hdev,

 static u32 supported_device_flags(struct hci_dev *hdev)
 {
-       u32 flags = BIT(HCI_CONN_FLAG_MAX) - 1;
+       u32 flags = 0;
+
+       /* Check if adapter can wakeup the system */
+       if (hdev->wakeup && hdev->wakeup(hdev))
+               flags |= HCI_CONN_FLAG_REMOTE_WAKEUP;

        /* Check if Privacy Mode can be set */
-       if (!privacy_mode_capable(hdev))
-               flags &= ~BIT(HCI_CONN_FLAG_DEVICE_PRIVACY);
+       if (privacy_mode_capable(hdev))
+               flags |= HCI_CONN_FLAG_DEVICE_PRIVACY;

        return flags;
 }

We will need to adjust some of the tests though to reflect this change
in behavior:

et Device Flags - Success                           Failed       0.016 seconds
Set Device Flags - Success                           Not Run
