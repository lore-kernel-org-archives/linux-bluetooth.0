Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798122076E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPE/daSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHUSBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHUSBl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 14:01:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859AC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:01:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so3290421eje.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/uS7c1SrPQDGlp7+Q5FcnPtIsy/vqTZPU3IA+XfqTQ=;
        b=FPE/daSR//SiJRbTbi/1QePf3Z/YcKWIj4S6yCuox9RMjxBEmeAaNJUh8xaDs9gX8Q
         sTumnPmgkqVkB1lHEmwIlCSLCSafjnXMV4C/neVbq6IMSQdjVrui7hHsaeXCpF5u2R4b
         W8CBKUFrDkHQBrUD5ubptomBxQuauwAj8npxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/uS7c1SrPQDGlp7+Q5FcnPtIsy/vqTZPU3IA+XfqTQ=;
        b=ldrRhiQQrHeNOEt5fwbnoAkh0/vOQKRgLk6zSNvcbtDxNjOBuTlYuPuj/QKImoibbT
         V+4d7CiwK0VOdTK24u4ADml4DY8jdzh0abmz97sw3zrMqsD5UlXvdTdgGOX8ANt+fH5C
         JXVgu9KjaDcIaYTzN+IIc7R/9EauBnXm2O7ETeTPUR1oauw8GZQKb8VW3wbViuWmGTi+
         yzoEf5nUAOMo8RS95WdbmlHniS5JKzjh0ClFFJ2owaQS2FXj2ME21RHv1s251JvcvFFi
         o6csg+m5dOZy2X1bO269VIyPQb8Wu2XeTyKn9ks5bw69toLKDPab/nNGkkRU6oGKNFDl
         M5yg==
X-Gm-Message-State: AOAM5337jLAyurMKnb/9wamcnImd64WwnlitlzPCbXml4uJKNKsHsHo+
        W7u7OsCcDrjKCls9ZwpBfXjmWmU4ngr0tA==
X-Google-Smtp-Source: ABdhPJzQ96rFm5l/JqOACd2Ei5iLfBEfaG+0vgU7aK706Y9wGVqDc3kQnIGWO2WHSyY4bCcovO15GQ==
X-Received: by 2002:a17:906:2356:: with SMTP id m22mr4046322eja.124.1598032899246;
        Fri, 21 Aug 2020 11:01:39 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id m13sm1502181eds.10.2020.08.21.11.01.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 11:01:38 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id a5so2740426wrm.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 11:01:38 -0700 (PDT)
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr3789680wrr.370.1598032898165;
 Fri, 21 Aug 2020 11:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200821074512.19985-1-sonnysasaka@chromium.org> <CABBYNZJp2cCqRFa2zrdLnva0UgxvG2eBhYyKr52Rx54sU=znSA@mail.gmail.com>
In-Reply-To: <CABBYNZJp2cCqRFa2zrdLnva0UgxvG2eBhYyKr52Rx54sU=znSA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 21 Aug 2020 11:01:25 -0700
X-Gmail-Original-Message-ID: <CAO271m=ZwWs4oKH1xBRD9BwxOdiA05bLgzsA-++gTzQwEv05jA@mail.gmail.com>
Message-ID: <CAO271m=ZwWs4oKH1xBRD9BwxOdiA05bLgzsA-++gTzQwEv05jA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix race condition between device
 connection and disconnection
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the feedback. I have sent a v2 fixing the comment style.

On Fri, Aug 21, 2020 at 10:36 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Aug 21, 2020 at 12:47 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > When Connect() is called and waiting for return, dev_disconnected may be
> > called due to MGMT_EV_DEVICE_DISCONNECTED event from kernel. In that
> > case reply to client that the connection failed otherwise the dbus
> > method will timeout because bluetoothd never replies.
> >
> > Tested with simulation of a lot of Connect() to bluetooth devices and
> > check that error is returned from bluetoothd rather than dbus timeout
> > when this race condition happens.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >
> > ---
> >  src/device.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 7b7808405..55e7b4042 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -3006,6 +3006,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
> >  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> >  {
> >         struct bearer_state *state = get_state(device, bdaddr_type);
> > +       DBusMessage *reply;
> >
> >         if (!state->connected)
> >                 return;
> > @@ -3020,6 +3021,17 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
> >                 device->disconn_timer = 0;
> >         }
> >
> > +       // This could be executed while the client is waiting for Connect() but
> > +       // att_connect_cb has not been invoked.
> > +       // In that case reply the client that the connection failed.
>
> Please use C style comment /* */
>
> > +       if (device->connect) {
> > +               DBG("connection removed while Connect() is waiting reply");
> > +               reply = btd_error_failed(device->connect, "Disconnected early");
> > +               g_dbus_send_message(dbus_conn, reply);
> > +               dbus_message_unref(device->connect);
> > +               device->connect = NULL;
> > +       }
> > +
> >         while (device->disconnects) {
> >                 DBusMessage *msg = device->disconnects->data;
> >
> > --
> > 2.26.2
> >
>
> Otherwise it looks good.
>
> --
> Luiz Augusto von Dentz
