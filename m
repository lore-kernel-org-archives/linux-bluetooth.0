Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC14C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E2B61440
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbhI2SIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbhI2SID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:08:03 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47447C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:06:22 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id h132so1571013vke.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/92QQ/0rKe5SJKEIOVpYAWzJ7zlJ8fg89PWndU9bCE=;
        b=OV+xhALTDgKzVq9JNc9MAM1Xqs3qxt8DjOXLxzyUGlKq9SK5SBxmv7imq2SsLcZLKG
         G/jNWqGjIjTqcDnowZCn9bPsMNQ07Rz510OMSmuCRkMyaBbr/56aCyj3CSYr7q3Ikkbi
         /wv1mwdcJ1d51keafVqUeH44I1UGk1AgbC9zQxfGXsED4ixHv+wIDjqjLvB/tblsQRuJ
         qNPsLbFpAxdP6jhegLdaZ8RIgLuX1ESH3T6xh76CQoIxVu/YnuZq4joQCBqp44YKJzc/
         cP2+Q46gV5sWFoU8KtA5sYC0on91xB9WSx74Qku91iJrFteyCLIOa/uxQ2NYzQ2zfTrV
         EGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/92QQ/0rKe5SJKEIOVpYAWzJ7zlJ8fg89PWndU9bCE=;
        b=cDqNorz8NlIMwL+3kp1kqqS+e8axxOdlDQrl8dW545gmLw+jecmgnOYUP7jHm7I4rn
         YD8Pv6QgincMjFGSlP9fREsF0wa1+95MALTcn4RWTrH4LcG6wPiO53novP5rgrmIm3nJ
         oXQ1BHxm7oJ06vvxHfNROcwgcHB1uO3PegDHKMGlFUIQEvenz5JG0+q4dXiIUqa6Hzn3
         S5j1a5WPzsXZnLflHeWjQQnr0Y7iEey+poPaF+If10yPnjLUk82UxsnhBo1gCBeEEQHv
         rkiCw0NxLbz3pQw0r2NpeOGzN+V4WGjMjScaUwenzxwrZAXw+PGQwF4RwZ3gy8tOGU+2
         g3VA==
X-Gm-Message-State: AOAM532r2Wyui1bfH6YKN6Mxt0BnFLDguNF/g6a7wcqyCfQ2yfO0kbAO
        KRa4xqPjIqd5DjlHsADIXb02S2EYc4dg2eKwRiBb8Pz9
X-Google-Smtp-Source: ABdhPJwzV57zx7V4J+tuIPXYXNUXK0gghmLMOikwVrCZOFgngR1hAxW559d3smxAfeaKB7PCd7yRA2jw6Yy9XYH0y7s=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr1103732vky.3.1632938781340;
 Wed, 29 Sep 2021 11:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210928213653.3028439-1-luiz.dentz@gmail.com>
 <20210928213653.3028439-2-luiz.dentz@gmail.com> <2F5C465D-1D47-4A16-B7E0-6FE32D6E9DC1@holtmann.org>
In-Reply-To: <2F5C465D-1D47-4A16-B7E0-6FE32D6E9DC1@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 29 Sep 2021 11:06:07 -0700
Message-ID: <CABBYNZLmA0iaGS+L+-aCYszpdZ42JCJB0EXu5A_HkEXsK-Q4fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: hci_vhci: Add force_suspend entry
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 29, 2021 at 6:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds force_suspend which can be used to force the controller into
> > suspend/resume state.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/hci_vhci.c | 49 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index cc3679f3491d..52f9106faeae 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -21,6 +21,7 @@
> >
> > #include <linux/skbuff.h>
> > #include <linux/miscdevice.h>
> > +#include <linux/debugfs.h>
> >
> > #include <net/bluetooth/bluetooth.h>
> > #include <net/bluetooth/hci_core.h>
> > @@ -91,6 +92,51 @@ static int vhci_get_codec_config_data(struct hci_dev *hdev, __u8 type,
> >       return 0;
> > }
> >
> > +static ssize_t force_suspend_read(struct file *file, char __user *user_buf,
> > +                               size_t count, loff_t *ppos)
> > +{
> > +     struct hci_dev *hdev = file->private_data;
> > +     char buf[3];
> > +
> > +     buf[0] = hdev->suspended ? 'Y' : 'N';
> > +     buf[1] = '\n';
> > +     buf[2] = '\0';
> > +     return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> > +}
> > +
> > +static ssize_t force_suspend_write(struct file *file,
> > +                                const char __user *user_buf,
> > +                                size_t count, loff_t *ppos)
> > +{
> > +     struct hci_dev *hdev = file->private_data;
> > +     bool enable;
> > +     int err;
> > +
> > +     err = kstrtobool_from_user(user_buf, count, &enable);
> > +     if (err)
> > +             return err;
> > +
> > +     if (hdev->suspended == enable)
> > +             return -EALREADY;
>
> I think that we have to have bool suspended in vhci_data struct here. It needs to be local to the driver.

Ok, but I guess hdev->suspended should be kept as is, right?

>
> > +
> > +     if (enable)
> > +             err = hci_suspend_dev(hdev);
> > +     else
> > +             err = hci_resume_dev(hdev);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     return count;
> > +}
> > +
> > +static const struct file_operations force_suspend_fops = {
> > +     .open           = simple_open,
> > +     .read           = force_suspend_read,
> > +     .write          = force_suspend_write,
> > +     .llseek         = default_llseek,
> > +};
> > +
> > static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> > {
> >       struct hci_dev *hdev;
> > @@ -149,6 +195,9 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> >               return -EBUSY;
> >       }
> >
> > +     debugfs_create_file("force_suspend", 0644, hdev->debugfs, hdev,
> > +                         &force_suspend_fops);
> > +
> >       hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
