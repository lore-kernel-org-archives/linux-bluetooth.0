Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEAC4727E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 04:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4089B21531
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 04:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZE848Q0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJGEia (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Oct 2020 00:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGEi1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Oct 2020 00:38:27 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFBAC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 21:38:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so995168iow.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 21:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoWN3z7qMFRYwlT/swD/uz2iy+XEdvNl4brWLiTEUGc=;
        b=ZE848Q0dFaos8hqbNqRIhxn6jteIUdnTUdkXqQ7v/ZeXhPVF43NM/bL2unVN5j1ajY
         0olql6hWV9AXKf64yomqZfL/ATxFW4zsu6fv8Y0FppXA7NCP9Q8LKDdCcoa5JNBoTxhi
         zr01GpirXzSo7I1SwYDwVeqnmQT7GZGkrg9Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoWN3z7qMFRYwlT/swD/uz2iy+XEdvNl4brWLiTEUGc=;
        b=gItHFMWGDmyVsYfNmaVPP9i7415Ut2hvauxXiUm/EYEyl6rBU8dWHJ0N1TWzrfAiYk
         xaELF0dIvghQlK65RoyqLwmCwNm1zKljfUqZr7XFmqe3akm6ecXLJtcAugVGapRlwGAY
         1W7DW5eoazRyeIlbMT3u1CX/6+lZwfLT9YXt6/v5JwEUenz4G4f15dqeqxTT5BjB7usI
         j5lN9Zzi1NhDdVywavynw77MXrgaqbkrfavePeacukqgFtFbVRGFeCUmLzNsEwa6mysj
         3liI7VwVbxcRWIxVmfCSQZchY5QYZlUXIIEMY/dwzcaDWlnTHeF0YRF0I8qkINmlQUtV
         80eA==
X-Gm-Message-State: AOAM530aWrwh3OdEWKqnpbek0Qa58oBxtM8VNc4VCmpwpups6T6/pBIc
        NQS2YK82G6736FSNcEJxuwjKjNaUc1r1KA==
X-Google-Smtp-Source: ABdhPJz75/AcrpzMv1/1zmBA8EX8c3UhC+c2kQInJ3/6f1VAkSh0QSqP+8AyTFb7fjk/EV+1f3cPng==
X-Received: by 2002:a6b:d606:: with SMTP id w6mr885400ioa.89.1602045504837;
        Tue, 06 Oct 2020 21:38:24 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id o12sm485490ilh.49.2020.10.06.21.38.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 21:38:23 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id u6so974587iow.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 21:38:23 -0700 (PDT)
X-Received: by 2002:a5d:8752:: with SMTP id k18mr941313iol.27.1602045503184;
 Tue, 06 Oct 2020 21:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200929080324.632523-1-tientzu@chromium.org>
In-Reply-To: <20200929080324.632523-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 7 Oct 2020 12:38:12 +0800
X-Gmail-Original-Message-ID: <CALiNf28k5C48_ivAeRW7sSEEXp0gd-h_1n03YH6jQhYhaCXUDA@mail.gmail.com>
Message-ID: <CALiNf28k5C48_ivAeRW7sSEEXp0gd-h_1n03YH6jQhYhaCXUDA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Move force_bredr_smp debugfs into hci_debugfs_create_bredr
To:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

This patch is to fix the kernel error
[   46.271811] debugfs: File 'force_bredr_smp' in directory 'hci0'
already present!

When powering off and on the bluetooth, the smp_register will try to create the
force_bredr_smp entry again.
Move the creation to hci_debugfs_create_bredr so the force_bredr_smp entry will
only be created when HCI_SETUP and HCI_CONFIG are not set.

Thanks,
Claire

On Tue, Sep 29, 2020 at 4:03 PM Claire Chang <tientzu@chromium.org> wrote:
>
> Avoid multiple attempts to create the debugfs entry, force_bredr_smp,
> by moving it from the SMP registration to the BR/EDR controller init
> section. hci_debugfs_create_bredr is only called when HCI_SETUP and
> HCI_CONFIG is not set.
>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> v2: correct a typo in commit message
>
>  net/bluetooth/hci_debugfs.c | 50 +++++++++++++++++++++++++++++++++++++
>  net/bluetooth/smp.c         | 44 ++------------------------------
>  net/bluetooth/smp.h         |  2 ++
>  3 files changed, 54 insertions(+), 42 deletions(-)
>
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 5e8af2658e44..4626e0289a97 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -494,6 +494,45 @@ static int auto_accept_delay_get(void *data, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
>                         auto_accept_delay_set, "%llu\n");
>
> +static ssize_t force_bredr_smp_read(struct file *file,
> +                                   char __user *user_buf,
> +                                   size_t count, loff_t *ppos)
> +{
> +       struct hci_dev *hdev = file->private_data;
> +       char buf[3];
> +
> +       buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y' : 'N';
> +       buf[1] = '\n';
> +       buf[2] = '\0';
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_bredr_smp_write(struct file *file,
> +                                    const char __user *user_buf,
> +                                    size_t count, loff_t *ppos)
> +{
> +       struct hci_dev *hdev = file->private_data;
> +       bool enable;
> +       int err;
> +
> +       err = kstrtobool_from_user(user_buf, count, &enable);
> +       if (err)
> +               return err;
> +
> +       err = smp_force_bredr(hdev, enable);
> +       if (err)
> +               return err;
> +
> +       return count;
> +}
> +
> +static const struct file_operations force_bredr_smp_fops = {
> +       .open           = simple_open,
> +       .read           = force_bredr_smp_read,
> +       .write          = force_bredr_smp_write,
> +       .llseek         = default_llseek,
> +};
> +
>  static int idle_timeout_set(void *data, u64 val)
>  {
>         struct hci_dev *hdev = data;
> @@ -589,6 +628,17 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
>         debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
>                             &voice_setting_fops);
>
> +       /* If the controller does not support BR/EDR Secure Connections
> +        * feature, then the BR/EDR SMP channel shall not be present.
> +        *
> +        * To test this with Bluetooth 4.0 controllers, create a debugfs
> +        * switch that allows forcing BR/EDR SMP support and accepting
> +        * cross-transport pairing on non-AES encrypted connections.
> +        */
> +       if (!lmp_sc_capable(hdev))
> +               debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
> +                                   hdev, &force_bredr_smp_fops);
> +
>         if (lmp_ssp_capable(hdev)) {
>                 debugfs_create_file("ssp_debug_mode", 0444, hdev->debugfs,
>                                     hdev, &ssp_debug_mode_fops);
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 433227f96c73..8b817e4358fd 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -3353,31 +3353,8 @@ static void smp_del_chan(struct l2cap_chan *chan)
>         l2cap_chan_put(chan);
>  }
>
> -static ssize_t force_bredr_smp_read(struct file *file,
> -                                   char __user *user_buf,
> -                                   size_t count, loff_t *ppos)
> +int smp_force_bredr(struct hci_dev *hdev, bool enable)
>  {
> -       struct hci_dev *hdev = file->private_data;
> -       char buf[3];
> -
> -       buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y': 'N';
> -       buf[1] = '\n';
> -       buf[2] = '\0';
> -       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> -}
> -
> -static ssize_t force_bredr_smp_write(struct file *file,
> -                                    const char __user *user_buf,
> -                                    size_t count, loff_t *ppos)
> -{
> -       struct hci_dev *hdev = file->private_data;
> -       bool enable;
> -       int err;
> -
> -       err = kstrtobool_from_user(user_buf, count, &enable);
> -       if (err)
> -               return err;
> -
>         if (enable == hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
>                 return -EALREADY;
>
> @@ -3399,16 +3376,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
>
>         hci_dev_change_flag(hdev, HCI_FORCE_BREDR_SMP);
>
> -       return count;
> +       return 0;
>  }
>
> -static const struct file_operations force_bredr_smp_fops = {
> -       .open           = simple_open,
> -       .read           = force_bredr_smp_read,
> -       .write          = force_bredr_smp_write,
> -       .llseek         = default_llseek,
> -};
> -
>  int smp_register(struct hci_dev *hdev)
>  {
>         struct l2cap_chan *chan;
> @@ -3433,17 +3403,7 @@ int smp_register(struct hci_dev *hdev)
>
>         hdev->smp_data = chan;
>
> -       /* If the controller does not support BR/EDR Secure Connections
> -        * feature, then the BR/EDR SMP channel shall not be present.
> -        *
> -        * To test this with Bluetooth 4.0 controllers, create a debugfs
> -        * switch that allows forcing BR/EDR SMP support and accepting
> -        * cross-transport pairing on non-AES encrypted connections.
> -        */
>         if (!lmp_sc_capable(hdev)) {
> -               debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
> -                                   hdev, &force_bredr_smp_fops);
> -
>                 /* Flag can be already set here (due to power toggle) */
>                 if (!hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP))
>                         return 0;
> diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
> index 121edadd5f8d..fc35a8bf358e 100644
> --- a/net/bluetooth/smp.h
> +++ b/net/bluetooth/smp.h
> @@ -193,6 +193,8 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
>  int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
>  int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
>
> +int smp_force_bredr(struct hci_dev *hdev, bool enable);
> +
>  int smp_register(struct hci_dev *hdev);
>  void smp_unregister(struct hci_dev *hdev);
>
> --
> 2.28.0.618.gf4bc123cb7-goog
>
