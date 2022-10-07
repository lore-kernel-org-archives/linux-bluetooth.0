Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD356C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 13:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJGNCJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJGNBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 09:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE5114DC2
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665147659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+zw5KqJ9vGznW+9ck2aKuAd2+Qsa5aSnhqW3TfQr/Uo=;
        b=i1Y2RpD2P8SQSIpZ7W+mxVbcXxnwC6VDoiyHMQik0A4DQwPSnSfaZWgIHAJlTbZ3lyJ4vZ
        dBnqhtFftzIUV32vRVwpixU0Y3JEdYpRpuje5xjkmDUiG6sDcNKyE/28pee142h+1uSuEt
        RGquXoe7edDgQr6rOYF8xF0XHZQNdfM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-hAglAfdcMTadgalcyVw6Ow-1; Fri, 07 Oct 2022 09:00:58 -0400
X-MC-Unique: hAglAfdcMTadgalcyVw6Ow-1
Received: by mail-wr1-f69.google.com with SMTP id j8-20020adfa548000000b0022e2bf8f48fso1416235wrb.23
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 06:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zw5KqJ9vGznW+9ck2aKuAd2+Qsa5aSnhqW3TfQr/Uo=;
        b=HVNmQSRKmJW2cBeYnEheDHIIDAsx+0UD7jaTZMz/2oIlymehv2dJo+e+jmbfeILMmx
         jgqDd3zfLqwPEkk7BoOBXVozU6cyRN5PxJcTgpB2dOSdLA9yufiz+T8Wm8XVCvNhGSt8
         ZLaIEFUi5sLCfhu5+q/iEgK5DAuS2+ed/YqAm5+NlSUoOzVW9dtsZ65ztmPr8niEq2qQ
         ezPEDftkvSrCmi08uwpNikZEnF0ex6iKiXQPe5Z7te0Wmj0l+f1+HXRWRuX7Tjx3ouLE
         l4dbK+EX6m9DCPgUyvgdAFFQpktOarBCN3zDGBsxGaxBgmHzoN6lAQEVl+Dt3aw/ucDR
         xzRA==
X-Gm-Message-State: ACrzQf1EpHXrrRACr5tRPNrXMrm5mMoW10Q6pQQ8X/oFUVoz4ePXL6Wl
        ViQ9f6NUqi7AjyX2gpGXUXOyOV34fnY10Ms+xpYMIwu+qGVxaGC5Y+PzwHmIA9p7rQPRNacRLQP
        d6a5oZr8+iVISKIm9gOnaN1Z+ACkf
X-Received: by 2002:a5d:5750:0:b0:22d:58d5:338 with SMTP id q16-20020a5d5750000000b0022d58d50338mr3264745wrw.693.1665147657035;
        Fri, 07 Oct 2022 06:00:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tpFSG1Ueq05PO7eb8POH7gDXfFAlVZ5gCbKaWMW4dB/lQuQhfh8Xkzbb30c6kW9q+5hrxIg==
X-Received: by 2002:a5d:5750:0:b0:22d:58d5:338 with SMTP id q16-20020a5d5750000000b0022d58d50338mr3264680wrw.693.1665147656275;
        Fri, 07 Oct 2022 06:00:56 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm2023912wru.83.2022.10.07.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:00:55 -0700 (PDT)
Date:   Fri, 7 Oct 2022 09:00:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: virtio_bt: fix device removal
Message-ID: <20221007090043-mutt-send-email-mst@kernel.org>
References: <20220811094542.268519-1-mst@redhat.com>
 <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Aug 15, 2022 at 11:07:05AM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> >
> > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> > not really what a driver is supposed to be doing. These are transport
> > enable/disable callbacks from the BT core towards the driver. It maps to
> > a device being enabled/disabled by something like bluetoothd for
> > example. So if disabled, users expect that no resources/queues are in
> > use.  It does work with all other transports like USB, SDIO, UART etc.
> > There should be no buffer used if the device is powered off. We also
> > don’t have any USB URBs in-flight if the transport is not active.
> >
> > The way to implement a proper fix would be using vq reset if supported,
> > or even using a full device reset.
> >
> > The cost of the hack is a single skb wasted on an unused bt device.
> >
> > NB2: with this fix in place driver still suffers from a race condition
> > if an interrupt triggers while device is being reset.  To fix, in the
> > virtbt_close() callback we should deactivate all interrupts.  To be
> > fixed.
> >
> > squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
> 
> Shouldn't the line above be a Fixes tag with the commit hash you are
> attempting to fix, other than that I'd be fine to apply these changes.


ping? what's going on?

> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20220811080943.198245-1-mst@redhat.com>
> > ---
> >
> > changes from v2:
> >         tkeaked commit log to make lines shorter
> > changes from v1:
> >         fixed error handling
> >
> >  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> > index 67c21263f9e0..f6d699fed139 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
> >
> >  static int virtbt_open(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> >
> > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         if (virtbt_add_inbuf(vbt) < 0)
> >                 return -EIO;
> >
> > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> >
> >  static int virtbt_close(struct hci_dev *hdev)
> >  {
> > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > +       return 0;
> > +}
> > +
> > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > +{
> >         int i;
> >
> >         cancel_work_sync(&vbt->rx);
> > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
> >                 goto failed;
> >         }
> >
> > +       virtio_device_ready(vdev);
> > +       err = virtbt_open_vdev(vbt);
> > +       if (err)
> > +               goto open_failed;
> > +
> >         return 0;
> >
> > +open_failed:
> > +       hci_free_dev(hdev);
> >  failed:
> >         vdev->config->del_vqs(vdev);
> >         return err;
> > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
> >
> >         hci_unregister_dev(hdev);
> >         virtio_reset_device(vdev);
> > +       virtbt_close_vdev(vbt);
> >
> >         hci_free_dev(hdev);
> >         vbt->hdev = NULL;
> > --
> > MST
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

