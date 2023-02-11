Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCCC636CC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBKLsY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 06:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBKLsX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 06:48:23 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF71D12F27
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 03:48:21 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4a263c4ddbaso103588567b3.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RplhYttQn543lg35l6s/uN2FX8iALrjEvhaFw3RQVtM=;
        b=WpGtLMe4MogDNXhsq+qShAO47lmK5vtijRivL/pCcjt/abDBtSZStDdsaEqCSBmI44
         UuwDyFt6uNHCN3e6YrnU26t+6LV/TwrrZAyYeSwLXkKPssqU+vKFkKZJrByvn/y/a+v1
         hsd3Jo580aaaGI7pGKNlbPTqJnOkXLFU1THN8fNOSzU9SNjHx1dYR8p4adJcc0iVbh4S
         Ab+2s/wVdZn93MLkaW8s+ovVY+b4feyzr/hMf5dwTi47Yh7TdV8niqw6kePGh61+ay1a
         sZtctoKBT0/W0MiRNhglBmPGlMRj/B4DUcnf3E9HmZLLirW1zwLEGVuQx/iLFnAJMC/V
         j7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RplhYttQn543lg35l6s/uN2FX8iALrjEvhaFw3RQVtM=;
        b=fE37aQyNkJAsiaA9U478Z/WsMthR29CyOv73OUsCJiK+/39ufQqr3VzBnUdYz7IO7H
         oHJ9o3/Cb9jP5KMhAT/Zq7Z2IBYVHny2UKeyTyaW9Tbt5XvTcRucJ/j65tnHrbDREwfU
         GWxeuzpHk0W/uW+gshJ98JaHDQkTt+QNvHX83vX2CQGIUMtrdc2MXBgI2NkLDd8SSPxt
         e/By26GRF9PNIa7LMIvjad/DozQ06PFrEj7ghBYzbIpz0yeDVYWRDgAGWGQryJlNtT1w
         9mcvSo0s7cNxzdzUyKurjcXKuPFwaASsBO+BVbBvVs94GeJHKb53J4Y3AKEe5WZ7giN4
         zRDA==
X-Gm-Message-State: AO0yUKXT2bdK1AhSdnXlZXZsNorBISZuSDGMeSkEClPDB6x3tV/R8XhQ
        wa7aGmfhXy817PIyuWcYBk5QpwBWnnRf/R/AdedzmtNJnw==
X-Google-Smtp-Source: AK7set+WK+2uP0mRVEUBpAIrmkOGLcSNq4vlOBPVF3ubEhz9RU9pW/YtjA696nB1C0F7jHxFnLMQtqYga6ORZ1HjoYM=
X-Received: by 2002:a0d:f603:0:b0:517:b161:1f4d with SMTP id
 g3-20020a0df603000000b00517b1611f4dmr1761371ywf.399.1676116101012; Sat, 11
 Feb 2023 03:48:21 -0800 (PST)
MIME-Version: 1.0
References: <CALDHRCt5KUezfEZCOWK+zYPM1hP32qwZqcoKw09ZjNw=oQoWKg@mail.gmail.com>
 <ecc41929af982862720209eacfa935178a8e0a1b.camel@sipsolutions.net>
 <CALDHRCuuZdqVorNzF+DFU8kAUU4eiuCHJgtV3Gtbvwr9mVow9Q@mail.gmail.com> <CABBYNZ+iz-NihAPaDCSW2TLodoH3ThDWhZdTPvQtbyx_jnMyhg@mail.gmail.com>
In-Reply-To: <CABBYNZ+iz-NihAPaDCSW2TLodoH3ThDWhZdTPvQtbyx_jnMyhg@mail.gmail.com>
From:   Arda Demir <ddmirarda@gmail.com>
Date:   Sat, 11 Feb 2023 14:48:08 +0300
Message-ID: <CALDHRCt4cpbpCLyd4g+2+Lh2H8WikJMXUBv6GfEcjz6Vi12yig@mail.gmail.com>
Subject: Re: hci0: Malformed MSFT vendor event: 0x02
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2023-02-08 at 12:21 +0300, Arda Demir wrote:
> Hello,
>
> First of all, my bluetooth adapter is;
> 04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
>
> I see the following message everytime when i boot the pc on tty.
>
> "Bluetooth: hci0: Malformed MSFT vendor event: 0x02"
>
> But bluetooth works well. If it is not critical it shouldn't print on
> tty, right?

On Wed, Feb 8, 2023 at 12:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2023-02-08 at 12:21 +0300, Arda Demir wrote:
> > Hello,
> >
> > First of all, my bluetooth adapter is;
> > 04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
>
> You've reached the Wi-Fi team here though - adding the BT list.
>
> > I see the following message everytime when i boot the pc on tty.
> >
> > "Bluetooth: hci0: Malformed MSFT vendor event: 0x02"
> >
> > But bluetooth works well. If it is not critical it shouldn't print on
> > tty, right?
>
> That's generic from net/bluetooth/hci_event.c, not related to the device
> (apart from the fact that the device might be broken if it's sending
> this?)
>
> johannes
>

On Wed, Feb 8, 2023 at 2:00 AM Arda Demir <ddmirarda@gmail.com> wrote:
>
> I don't think the device is broken since bluetooth + wi-fi is fully
> functional and i also read on arch linux forum people get the same
> message on tty with the same hardware. (AX200)
>
> https://bbs.archlinux.org/viewtopic.php?id=276815

On Wed, Feb 8, 2023 at 1:17 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> The message seems to originate from `net/bluetooth/msft.c`:
>
> ...
>
> ```
> static void *msft_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
>                             u8 ev, size_t len)
> {
>          void *data;
>
>          data = skb_pull_data(skb, len);
>          if (!data)
>                  bt_dev_err(hdev, "Malformed MSFT vendor event: 0x%02x",
> ev);
>
>          return data;
> }
> ```
>
> I recommend to create a bug report at the Linux kernel Bugzilla [1],
> where you attach the output of `dmesg`.
>
> Additionally, I suggest to not load the Bluetooth modules like btusb
> during startup, and only later load it with `btmon` running.
>
> Please reply with the bug report number/URL, if you created the bug report.
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://bugzilla.kernel.org/

On Thu, Feb 9, 2023 at 2:43 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Arda,
>
> On Wed, Feb 8, 2023 at 2:00 AM Arda Demir <ddmirarda@gmail.com> wrote:
> > I don't think the device is broken since bluetooth + wi-fi is fully
> > functional and i also read on arch linux forum people get the same
> > message on tty with the same hardware. (AX200)
> >
> > https://bbs.archlinux.org/viewtopic.php?id=276815
>
> I suspect it is some vendor event other than MSFT that we are trying
> to parse as MSFT, this normally can be ignored silently when not
> understood, but I will check internally what we can do about it.

I've created a bug report about this:
https://bugzilla.kernel.org/show_bug.cgi?id=217023
