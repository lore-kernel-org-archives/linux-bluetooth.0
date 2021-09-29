Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0033FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE75A61503
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbhI2SJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbhI2SJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:09:21 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA32C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:07:39 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id t200so1601841vkt.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbrYz4NenFndSB79PEXKHD+uv7MN1Pa0JdPJnQTWI6o=;
        b=cDiF9y3K1VydIjYTRI5B/AwN2VrmzSDCR+MdntrqxLwnAqELdD1DXtmgr5ok7pRSPw
         yCUQmvTJlLoeU+bnMmQYCYE2yYisjT7xm86v75mhaTmYppkbJfMmTieRkkVfz7xWn+ys
         s2GwzxHoWA/6t/6KaWcTlDYK5QBWMZQPox/RJcHYSa1GlahPuLdJuw0W6oggwgqb9fJ1
         ThMImJM99VYz/B/ilR4uavZtwfhrlw7qTki+MyP8XlYIIXN790nDsOsh10PEvk5jJKNd
         g5HiwQzCg+9j26xd+teMmmGTj/cTym05GFsqxrkP7mcx6SqeM26O45D92HK+bFt8lB0s
         v+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbrYz4NenFndSB79PEXKHD+uv7MN1Pa0JdPJnQTWI6o=;
        b=JNa6O9n2+CZchMQJ3dylxLabsT7rOGHaJB4Yu0F9bsa9HYU/WPC8RVWRpmOA9k5grS
         zyAQEUlUuzcRTD4IXeRq5xlQVCgowUPFCr1AtEuu6Rt+AqMLTnFMAfjprSwFklBOoNGu
         n3lrfPbSMVSCFyLPotKjtATWq6ZV1mXGu2jFjWoplOYXNVsDCMkjj/9+9ImoD0K/wn3o
         pNot9tnsJwHBVfk0QZtYMtxpO5Jo6Tm6q9Pevn1XLhybtrgX/RprwiPs5byDWqs7ll/L
         G4Ckk5JK4ytbkHMkxifA0dJheFkQoRr6lxuQhDUz0jQDXb1FYd+0QNqolxeuO3kANRTP
         Z+Og==
X-Gm-Message-State: AOAM532jxC0cH2XOXaKGKBgFq0kNdV3ZMqE/hr94qteMKtNZfpD924cJ
        LuCoyaTgxTWhn9yQ7RCfpZv0hoD+Ofcbnawp+62dzVDf
X-Google-Smtp-Source: ABdhPJwYZ/cisFMH1hwhosHcvdfDk13PVuZTclmLPU+Kgs2bc8AmoO3OY1iRePjMNpZie3M9mx+exe/A83oZryKOXP8=
X-Received: by 2002:a1f:5c95:: with SMTP id q143mr1189214vkb.4.1632938858809;
 Wed, 29 Sep 2021 11:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
 <20210928213653.3028439-3-luiz.dentz@gmail.com> <F70A6EDE-0E0A-4D4C-8C4A-7262D0FD9CC5@holtmann.org>
In-Reply-To: <F70A6EDE-0E0A-4D4C-8C4A-7262D0FD9CC5@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 11:07:24 -0700
Message-ID: <CABBYNZLY-iF5F9rOQ9mJU_mUXAxjx+xOS2bSy+3j=61nUkcqGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_vhci: Add force_prevent_wake entry
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 29, 2021 at 6:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds force_prevent_wake which can be used to force a certain state
> > while interacting with force_suspend.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/hci_vhci.c | 48 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 48 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index 52f9106faeae..60a408a49828 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -137,6 +137,51 @@ static const struct file_operations force_suspend_fops = {
> >       .llseek         = default_llseek,
> > };
> >
> > +static bool prevent_wake;
>
> this needs to be in vhci_data since it should be per vhci.

Ack.

> > +
> > +static ssize_t force_prevent_wake_read(struct file *file, char __user *user_buf,
> > +                                    size_t count, loff_t *ppos)
> > +{
> > +     char buf[3];
> > +
> > +     buf[0] = prevent_wake ? 'Y' : 'N';
> > +     buf[1] = '\n';
> > +     buf[2] = '\0';
> > +     return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> > +}
> > +
> > +static bool hci_debugfs_prevent_wake(struct hci_dev *hdev)
> > +{
> > +     return prevent_wake;
> > +}
>
> The hci_debugfs prefix here is rather misleading. This is vhci_prevent_wake actually. And just move it to a more closer position with all the other hdev-> callbacks.

Ack.

> > +
> > +static ssize_t force_prevent_wake_write(struct file *file,
> > +                                     const char __user *user_buf,
> > +                                     size_t count, loff_t *ppos)
> > +{
> > +     struct hci_dev *hdev = file->private_data;
> > +     bool enable;
> > +     int err;
> > +
> > +     err = kstrtobool_from_user(user_buf, count, &enable);
> > +     if (err)
> > +             return err;
> > +
> > +     if (prevent_wake == enable)
> > +             return -EALREADY;
> > +
> > +     hdev->prevent_wake = hci_debugfs_prevent_wake;
>
> You need to set these with the other hdev-> callback and not in debugfs callback.

Will do and also change its naming as well.

> > +
> > +     return count;
> > +}
> > +
> > +static const struct file_operations force_prevent_wake_fops = {
> > +     .open           = simple_open,
> > +     .read           = force_prevent_wake_read,
> > +     .write          = force_prevent_wake_write,
> > +     .llseek         = default_llseek,
> > +};
> > +
> > static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> > {
> >       struct hci_dev *hdev;
> > @@ -198,6 +243,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> >       debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
> >                           &force_suspend_fops);
> >
> > +     debugfs_create_file("force_prevent_wake", 0644, hdev->debugfs, hdev,
> > +                         &force_prevent_wake_fops);
> > +
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
