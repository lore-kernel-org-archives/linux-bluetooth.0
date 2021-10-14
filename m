Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B361151
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 17:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhJNRZx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhJNRZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Oct 2021 13:25:53 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B6C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 10:23:47 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f4so12780297uad.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2jlHZQuOx6FYPZVMK2g4W7PZeEWtmyYGp7ZPuz9XIQ=;
        b=Q+LbiCN39paHRzXOp2g1r7k9HeWetAnJGxavwvvb/kK/5iCail8xurhxUL7/xy/Bv5
         kWsaxp9WK6EISqjWZjdDwGzKtfKIn9YJMfm2l3A2yPJY/5PzqYFqnOwqouUSGoULhgF5
         M4/mVNJyXZq4YrirsIO/DEbHpLPj3ff4R/pt5YtXUmxGUoBpCUpPxHhQ0j98/Xy04KuQ
         xfmypT2yroMWm26rZEyqH9cPV8C8m2opUG3aXxbC3dvcNKjVf6hviFGZKU3NErgdd84m
         OlhbJU3v6O3GNmsOwt/7Xuup7GHPOa5kegzJMXjfCgbCptVK3+Z03I/KOIXwMy1pn3ww
         UDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2jlHZQuOx6FYPZVMK2g4W7PZeEWtmyYGp7ZPuz9XIQ=;
        b=TCDiEYR4dlJr/pGtje+R7MI3U1jUfUgwZEyLkb6xWBtamc41OHWXN5l2NSmAEYAb7Y
         esqva4rSZBzLqyeSBBnkcT47xwp0mL9ZUm6zGMo4wVzSv1fCvNf1rtAphfodN8XxCGbO
         EpBFS4t2nfafpPD3cYPEF6Iej/JuvgLBG0XVlbg+Zp15nZJap+vj954T3ZSlFek3wEg4
         uDa7UJNTkKE31n1PHBklFclwyHKsA7p2AzsPU/AAJeQcN1+KjvLYxVw2E9NK9CAEHChE
         h/bs+dpGzhZTqKX6w9nQFWgB0K4DGDOe+uojfEen6Pe0FjtR4F0ETlECJn7ixsNowFqe
         cvwA==
X-Gm-Message-State: AOAM530d+00uXEXu1SssDR9JndDNJxKq5mYMZ72fMuPevRGy/a1fNxq6
        xueoE0Y5zXB9LbXcGQSzpQ8uq0RJmSjUjfjM7CvqfzBd7uE=
X-Google-Smtp-Source: ABdhPJyjeEEFKjrvm4e7T3RKtttxM6qRy2HKSIcMdhhDQFm/M88XY6sVQvfd+8DsZ67k7S8szq53FOTGVFJelqjDRxU=
X-Received: by 2002:ab0:29da:: with SMTP id i26mr7739501uaq.129.1634232226784;
 Thu, 14 Oct 2021 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211013221701.2826793-1-luiz.dentz@gmail.com> <ABE43C65-BA9A-43C0-8A59-CF26A0A106D0@holtmann.org>
In-Reply-To: <ABE43C65-BA9A-43C0-8A59-CF26A0A106D0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 14 Oct 2021 10:23:36 -0700
Message-ID: <CABBYNZLn=pV5GZ4wpUrEoNOHrsWkjnxKqTbKj5n-Ys=-yctvWA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: vhci: Add support for setting msft_opcode
 and aosp_capable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Oct 14, 2021 at 5:39 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds a debugfs entries to set msft_opcode and aosp_capable enabling
> > vhci to emulate controllers with MSFT/AOSP extension support.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Fix typos: s/extention/extension/g
> > v3: Remove checks for HCI_SETUP, merge changes to introduce MSFT/AOSP support
> > at the same time.
> >
> > drivers/bluetooth/hci_vhci.c | 92 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 92 insertions(+)
>
> patch has been applied to bluetooth-next tree (with slight modifications).

++<<<<<<< HEAD
 +      hci_set_msft_opcode(hdev, vhci->msft_opcode);
 +      hci_set_aosp_capable(hdev);
++=======
+       if (vhci->msft_opcode)
+               hci_set_msft_opcode(hdev, vhci->msft_opcode);
+
+       if (vhci->aosp_capable)
+               hci_set_aosp_capable(hdev);
++>>>>>>> 9bbbb6a7ad09 (Bluetooth: vhci: Add support for setting
msft_opcode and aosp_capable)

I suspect the above changes won't work if we don't init the fields in
the vhci_data, msft_opcode would be set to 0x0000 so it won't be
enabled anyway but aosp_capable would be enabled which would be out of
sync with vhci->aosp_capable, so perhaps we want to change
hci_set_aosp_capable to take a parameter:

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 74c0eb28c422..9e67517b6cef 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -264,7 +264,7 @@ static int vhci_setup(struct hci_dev *hdev)
        struct vhci_data *vhci = hci_get_drvdata(hdev);

        hci_set_msft_opcode(hdev, vhci->msft_opcode);
-       hci_set_aosp_capable(hdev);
+       hci_set_aosp_capable(hdev, vhci->aosp_capable);

        return 0;
 }

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..d007b487d4c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1279,10 +1279,10 @@ static inline void hci_set_msft_opcode(struct
hci_dev *hdev, __u16 opcode)
 #endif
 }

-static inline void hci_set_aosp_capable(struct hci_dev *hdev)
+static inline void hci_set_aosp_capable(struct hci_dev *hdev, bool enable)
 {
 #if IS_ENABLED(CONFIG_BT_AOSPEXT)
-       hdev->aosp_capable = true;
+       hdev->aosp_capable = enable;
 #endif
 }


> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
