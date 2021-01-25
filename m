Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB754C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 07:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69045229C5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 07:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAYHAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbhAYGmp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 01:42:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9EC061756
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 22:42:05 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id e17so8989898qto.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 22:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWxPCOWE4nVOCUe330fdsIiyZ6zF5Mqd+3aCb9h18Nc=;
        b=U9wpChPTB/SsSbl62DJ29zy3chleD7of65QEW0O78luygxiONwyqw3coe8W7Y26l+e
         RiMRXtTjusu3lhc/E+7FoeL+a+SnUoI49vFPvcE3fRpmy3NNwCALGGCjiILFUmng9hqC
         HyT1G7w+hFOcYH8Jf0VAI2T6SjFzY2m6h3ijnolFoicGFI9q2+WvWppl0XDITv/tvXDb
         ayVy7yICwjqQnYlqAEyAy8uO7vrA5nfwwWJHkZPsLiUeMPhFVFdE9X3aX1YoCgXgjV/I
         gikwsxK8IkF0hZ+JXI4YM5Ix2MdGW3L7AKOOpDJAsRL2zNpW1PcyY97GHzgoKqX7uU24
         T2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWxPCOWE4nVOCUe330fdsIiyZ6zF5Mqd+3aCb9h18Nc=;
        b=A3yYsyUZj7ody/Gyin5p5VujXaT8EiOEoTewyQRa9wwevMVnu+wUrWouOaHlYldlBS
         Is7aoN+B4Oc+o7M5YmBdYUIYKb/K7WKzOc5cHF8a9g9DsoanuFurjnl5UWS577eECqy+
         AUJXZ5O4EAgaso+yo1DS1hJVPr8hp5CxO9khmek3l4EgQqueILbHebrwOboHBnW9JfFL
         WtOweOcOPRrJB4d/YxQ+mGV/HekQGqEbTBt5AKCtGt6cbBph43ItfIgNtF05RasVi/jx
         4dRa/+tITlLcUK9QK4xh+rIIqfRiR/McMWqPs0uCe8A33qCUN7IPJ3V9S1jxEUYSBqtg
         XRBA==
X-Gm-Message-State: AOAM533Rg6OJNDpSEvtd+Y22v5trIifMuYYwY22mDJQwIU41DNBp4z6q
        CRnc+VgLmaYmfyFNGqKmtTh9fllvsj4GoEnTRw==
X-Google-Smtp-Source: ABdhPJztSBP8RPc3gKtGADnMGPCBpogcCZJfLPNex1Xtm1OuJLo20SVfxagGP+xAqhAP8boQUAB/I9XvIXRIMbRvKFw=
X-Received: by 2002:ac8:3508:: with SMTP id y8mr90047qtb.58.1611556924225;
 Sun, 24 Jan 2021 22:42:04 -0800 (PST)
MIME-Version: 1.0
References: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
 <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
In-Reply-To: <CABBYNZJrb=jpuaUAC9DxRSnRrReZRQgPTKwgqQYBN-3KWoUxQA@mail.gmail.com>
From:   Kenny Bian <kennybian@gmail.com>
Date:   Sun, 24 Jan 2021 22:41:48 -0800
Message-ID: <CAC9s0NYvmRHQ1qrbpQtKrACi2Mp7YCTPA4oYF-TwgpnCN-vhPg@mail.gmail.com>
Subject: Re: How to add "Service Changed Indication"
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you so much for your reply. I appreciate it.

By "registering the services", do you mean "RegisterApplication()" in
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n656?
If that is the case, I believe I already registered the services.
I checked the files in /var/lib/bluetooth. According to
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storage.txt#n321,
there should be a "[ServiceChanged]" section in the "info" file. But I
don't see it in the "info" file. Is there a way to tell the "Service
Changed Indication" is actually working?
Let's suppose the "Service Changed Indication" is already enabled, is
there a way for the mobile app to check on their side to tell which
service(s) got changed?

Thanks again for your help.

On Sun, Jan 24, 2021 at 7:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kenny,
>
> On Sun, Jan 24, 2021 at 12:45 AM Kenny Bian <kennybian@gmail.com> wrote:
> >
> > Hello,
> >
> > We implemented a GATT server on Linux in Python. The code is based on
> > the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
> > The BlueZ version is 5.48. But we found a problem. The cached data in
> > /var/lib/bluetooth caused the mobile app to crash if some
> > characteristics are changed. After some research, we found "Under BLE
> > standard 'Generic Attribute'(0x1801), there is a Characteristic
> > 'Service Changed' (0x2A05) with 'indicate' property", see
> > https://github.com/espressif/esp-idf/issues/1777.
> >
> > The questions we have:
> > How to enable the "Service Changed Indication"(0x2A05) in the
> > bluetooth? Is there any code example in Python?
>
> If you are registering the services with Bluetoothd then it should
> generate the service change automatically:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1185
>
> When a new service is registered it is indicated here:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n1452
>
>
> --
> Luiz Augusto von Dentz
