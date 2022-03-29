Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiC2U2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2U2v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:28:51 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B41CCAE4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:27:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id u103so33529551ybi.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buTLOJJBqXJet4HgVD1VAuATt87H0PT22KsQ/eV49a0=;
        b=OqoMcNQvgABuY+EXNYz7ROr9jtiMEv1N93QtrB0zHOColtbPaDQITeFRPChS2itqqd
         uD9Psq5A0JahJ1hWNf2F7KZIqOOd7c9NJkmMcrHvzXQRecKcgWYRYksTy3O/prRjAu+J
         LW6hTGYy5nQnowVEB5Z/V6DvJFXlHlpsP2JVo7BWjwiYM2/qkiJJookiqNI4Kz08NH2Z
         QaGjmYfmq5EozsvFYpy6WgWseL9x6gRHRpP8/+8xqMuUe02MSGXVmQ2PD2crsY0n1dsN
         Cy0Tdjxvobd2v449uWw9JyYTq3jCxAkEYTp0NtsD98xDxewEmotfFHIrpiRUiRIchyqi
         3gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buTLOJJBqXJet4HgVD1VAuATt87H0PT22KsQ/eV49a0=;
        b=nxHhP5E1Viio2UrWuhLOfcqKPjSmS7V2fxWhsjX31TiYiyWSl8F5J7i+DPxXblmyij
         ynyiRsjj96yYGFSAHBhmz+0rCLJXgUFKA5HKLrg3imPlrpnP//2bCfee/9UE0s+lGDyP
         ZbqvuvyGfPGLfCcw1dY42m1GfrzwZje2JL71ddJLP3XIK+8q7YiWJIjbbUu2RhoCG2O1
         rf9z9/grJVuq9gyNK3o/cUEtmRDy4sKwvACAwAowCL8nvlhSarabUMmkr2LuNIo8Ymqc
         AwKzwZ8rOOKj+8ocvb9lCe9wy8M96/iCvybkQA/Hfso2n2v4Hz9uiUbOnfWalOBuW5IS
         IdVw==
X-Gm-Message-State: AOAM533ArZDWUrlu+gFF1K9HGFizISu7BfLl0LMVz5K4mMPjrmvu7htC
        79PeK9+UHmNd2oVlD+xLQe/em4nSH5HnFEoz1l2pvIqQ
X-Google-Smtp-Source: ABdhPJyzOFuG0e8qzw0dXMnb74/52GF+vphspAghmXqIFDY9E43mLZ61C0hBmqEl4vGF1JicLD+eZxdDj6x95OVVWv4=
X-Received: by 2002:a05:6902:1009:b0:634:674f:ef16 with SMTP id
 w9-20020a056902100900b00634674fef16mr31616166ybt.459.1648585627145; Tue, 29
 Mar 2022 13:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329201646.2296314-1-luiz.dentz@gmail.com> <20220329201646.2296314-3-luiz.dentz@gmail.com>
In-Reply-To: <20220329201646.2296314-3-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Mar 2022 13:26:56 -0700
Message-ID: <CABBYNZ+T6bS-Gk7du8n1gARQ7Vr24AgqgFAczn5kyyi-k5YbBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN
 for QCA
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Tim Jiang <tjiang@codeaurora.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Zijun Hu <zijuhu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Mar 29, 2022 at 1:16 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA controllers
> since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 50df417207af..2470c3d4ef0f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3335,6 +3335,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>                         msleep(QCA_BT_RESET_WAIT_MS);
>         }
>
> +       /* https://bugzilla.kernel.org/show_bug.cgi?id=215576 */
> +       set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
> +
>         return 0;
>  }
>
> --
> 2.35.1

Im CCs you guys since you have been involved with Bluetooth QCA
drivers, the patch above marks all QCA controller as broken with
respect to use of HCI Enhanced Setup Sync Connection, if you guys have
know that it only affect specific models it would probably be a good
idea to introduce a table with the affected models or better yet have
their firmware fixed.

-- 
Luiz Augusto von Dentz
