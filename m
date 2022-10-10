Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJJRPo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJJRPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 13:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A3D1E3E3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665422139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJ03u28FFkf43i2pkeNoXvgymZucfB/TyQdQUE62glg=;
        b=G5zxyWddLz/Y/ZIMEZNfVEbwwLTNBrwxKBoUIP9C0tEkQ16wph6sqIKKwr23icFzqPDUzA
        Rc1BAcJHR7qAHvS0oCF9u3l3wMavInCDytjuOE7oI9bu/agYcPax0VOm8otEG/hnR7zcEg
        WGU4EiG2iy203QQK3IPgU3D2DM2fvT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-8yRDvfhFPSuMNekDxlpqvQ-1; Mon, 10 Oct 2022 13:15:38 -0400
X-MC-Unique: 8yRDvfhFPSuMNekDxlpqvQ-1
Received: by mail-wm1-f69.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso3247926wmj.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 10:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ03u28FFkf43i2pkeNoXvgymZucfB/TyQdQUE62glg=;
        b=2odUG3229a7BTKSU4T04BhYj2+oTLdza1OJaLBhlYnEGCtVHQEp/Yq1qHrxSKOKjNo
         oyxpi15ufc//XSuHbeUgHxZGJHF8v+MXgRDVSt7AlK7kW4bhWBESEgIBulhCaslnYpUr
         AfBL2ixf3O8jHNWdZso3mx653im7Qk2zFbUcYWMpvZtL+3SHXkNQwEA8/UQht7ZIW/ae
         HW+LACl/xl0D1SpM8MYw2Oc2u4KfIf8rs7kJsCvY1RV/Y8ZTFLeYonRVyicI5mPpJU37
         H0liLfuRp3eFJ/Q4IUYr+bHgNy9JF0S43mWQ9Hs3YjFUaLnvDyW2YqjW78zx3bitPSS+
         hPHQ==
X-Gm-Message-State: ACrzQf1opKZ2OtPmqyoAr2bRW9Tvvq9QDoZub5WyI5QY1pQQMK2OYVNu
        sIeFoG1h9XM2ymdKMkD/l+6vTb3x4Lw9oJUL8lwmyL9I2iAnSa9DpBfRbemYfDN54zTB4uWLawb
        Z0aubhKGE9eD9HlxjbVpkQh/9uI/A
X-Received: by 2002:adf:ec01:0:b0:22e:35ce:7a65 with SMTP id x1-20020adfec01000000b0022e35ce7a65mr12488158wrn.498.1665422137284;
        Mon, 10 Oct 2022 10:15:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7DyaXPz4NaZupn34mXpfTS7G27JtmTzTrnOmPHBX1neswis1VCsfiVsH2hXhORD2K4sedNng==
X-Received: by 2002:adf:ec01:0:b0:22e:35ce:7a65 with SMTP id x1-20020adfec01000000b0022e35ce7a65mr12488149wrn.498.1665422137044;
        Mon, 10 Oct 2022 10:15:37 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c34c500b003c409244bb0sm8851785wmq.6.2022.10.10.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:15:36 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:15:29 -0400
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
Message-ID: <20221007201232-mutt-send-email-mst@kernel.org>
References: <20220811094542.268519-1-mst@redhat.com>
 <CABBYNZLeszHHi2TVcQsOtPWs1u=s8gjOVAhL+Q=O-ThgpxvpOw@mail.gmail.com>
 <20221007090043-mutt-send-email-mst@kernel.org>
 <CABBYNZKHuaoy0OrA+t46V6=PZtN9BPeNQR4RutdKZhdJJ+4ixA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKHuaoy0OrA+t46V6=PZtN9BPeNQR4RutdKZhdJJ+4ixA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Oct 07, 2022 at 12:33:03PM -0700, Luiz Augusto von Dentz wrote:
> Hi Michael,
> 
> On Fri, Oct 7, 2022 at 6:01 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 11:07:05AM -0700, Luiz Augusto von Dentz wrote:
> > > Hi Michael,
> > >
> > > On Thu, Aug 11, 2022 at 2:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > Device removal is clearly out of virtio spec: it attempts to remove
> > > > unused buffers from a VQ before invoking device reset. To fix, make
> > > > open/close NOPs and do all cleanup/setup in probe/remove.
> > > >
> > > > NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> > > > not really what a driver is supposed to be doing. These are transport
> > > > enable/disable callbacks from the BT core towards the driver. It maps to
> > > > a device being enabled/disabled by something like bluetoothd for
> > > > example. So if disabled, users expect that no resources/queues are in
> > > > use.  It does work with all other transports like USB, SDIO, UART etc.
> > > > There should be no buffer used if the device is powered off. We also
> > > > don’t have any USB URBs in-flight if the transport is not active.
> > > >
> > > > The way to implement a proper fix would be using vq reset if supported,
> > > > or even using a full device reset.
> > > >
> > > > The cost of the hack is a single skb wasted on an unused bt device.
> > > >
> > > > NB2: with this fix in place driver still suffers from a race condition
> > > > if an interrupt triggers while device is being reset.  To fix, in the
> > > > virtbt_close() callback we should deactivate all interrupts.  To be
> > > > fixed.
> > > >
> > > > squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
> > >
> > > Shouldn't the line above be a Fixes tag with the commit hash you are
> > > attempting to fix, other than that I'd be fine to apply these changes.
> >
> >
> > ping? what's going on?
> 
> Please resend, our patchwork only retain the patches for 30 days.

I did but what is going on here? Why was the patch dropped?


> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Message-Id: <20220811080943.198245-1-mst@redhat.com>
> > > > ---
> > > >
> > > > changes from v2:
> > > >         tkeaked commit log to make lines shorter
> > > > changes from v1:
> > > >         fixed error handling
> > > >
> > > >  drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
> > > >  1 file changed, 17 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> > > > index 67c21263f9e0..f6d699fed139 100644
> > > > --- a/drivers/bluetooth/virtio_bt.c
> > > > +++ b/drivers/bluetooth/virtio_bt.c
> > > > @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
> > > >
> > > >  static int virtbt_open(struct hci_dev *hdev)
> > > >  {
> > > > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > > > +       return 0;
> > > > +}
> > > >
> > > > +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> > > > +{
> > > >         if (virtbt_add_inbuf(vbt) < 0)
> > > >                 return -EIO;
> > > >
> > > > @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
> > > >
> > > >  static int virtbt_close(struct hci_dev *hdev)
> > > >  {
> > > > -       struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> > > > +{
> > > >         int i;
> > > >
> > > >         cancel_work_sync(&vbt->rx);
> > > > @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
> > > >                 goto failed;
> > > >         }
> > > >
> > > > +       virtio_device_ready(vdev);
> > > > +       err = virtbt_open_vdev(vbt);
> > > > +       if (err)
> > > > +               goto open_failed;
> > > > +
> > > >         return 0;
> > > >
> > > > +open_failed:
> > > > +       hci_free_dev(hdev);
> > > >  failed:
> > > >         vdev->config->del_vqs(vdev);
> > > >         return err;
> > > > @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
> > > >
> > > >         hci_unregister_dev(hdev);
> > > >         virtio_reset_device(vdev);
> > > > +       virtbt_close_vdev(vbt);
> > > >
> > > >         hci_free_dev(hdev);
> > > >         vbt->hdev = NULL;
> > > > --
> > > > MST
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

