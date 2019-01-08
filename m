Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A98C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC4A2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ki94+157"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfAHQMf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:12:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33188 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAHQMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 11:12:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so3357480lfc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImNGkEZuttHadR5L1VeIc0SxL4xvvItBWmqtIqbEJDs=;
        b=ki94+157Dcd+qKPWrmWR6jQCEnEJHb0LioF88oZVEX93btJRmwyOIsiMHRQ+zRO1n1
         LTB87IWejHs3V4bM9DuunfSgDzeCFex4m8nXw5r0NGxwhV9B9U9EnEv5Md3+JznNeTGJ
         CIfosZRvx0ZD51ZPbhjz8c6xpAhFfNEGIkvBzvEnhvpVzlX7YOdaEwNJfr8TFulJCTgk
         zs/MFEYlOH/gl3PA+yBR/sbOeQxeK1qjT5agdipLkbnyubXUgDCPhiuPPHv4UJpibU0N
         ElEs/IGGNWKlS79giWPJlBCUW4bV34U1dawT72m7epg87FzBMN4uCLUTuBejpBkKvB0C
         JugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImNGkEZuttHadR5L1VeIc0SxL4xvvItBWmqtIqbEJDs=;
        b=dZqBQZ0ao/+VIRvWwajo2hk3OUqGLZhbbktYWjW2/ADl7xpm6jDWHq6ZLbpy4oz68t
         3JmqKv9dD/UeqUysnUG4/rJFwysugKraApTCYnFLSD+xWyZ9wQAuD2LLy2PBZUdPPgoC
         p3enUrsIdykZDO71Ow8+ojnNuAJoEpUTVqljj13KqPr00Nm1gN/WHQT2HUCnAu3sjgd9
         V4VHZoJNVL/rham2Ky4+fF4kYnzYgcdupRMR8bVPNpDorUOmMDPShPkSUd83rmGtVaUk
         V7wmPrFzsoTvIW8wOmi/dSujF5FgDIjbpuhkgMs+OuhnEOgzaRaQ3rdpeQ+3TW5TgcGV
         x2Vg==
X-Gm-Message-State: AJcUukdzK4WK/jeNTJqpJ90GnEf5nxVEiecU7upos8j4p5Ixt7j4kRBB
        PFkofLOqD+URo3N6CHDJQ8wz0kJePg1NMYhzLeoQkHSka6U=
X-Google-Smtp-Source: ALg8bN48toHvvKexR0r6ixEk97iu+pW9d8bmgdF5dsBwY6Woy3jAXwd2nm0doXIhEkl18VzQcCi3Ith8X6ET1pp+oII=
X-Received: by 2002:a19:1019:: with SMTP id f25mr1367616lfi.54.1546963952316;
 Tue, 08 Jan 2019 08:12:32 -0800 (PST)
MIME-Version: 1.0
References: <c23a8986-5654-275c-26a8-9f9a4bf5d005@invoxia.com>
In-Reply-To: <c23a8986-5654-275c-26a8-9f9a4bf5d005@invoxia.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Tue, 8 Jan 2019 13:12:21 -0300
Message-ID: <CACumGOJrN1LFBb6uuH1T92eirzQyUMuai1qQ8SeipzJb=bvHUg@mail.gmail.com>
Subject: Re: Bug: no PropertiesChanged signal for org.bluez.Device1.AdvertisingData
To:     Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arnaud,

On Tue, Jan 8, 2019 at 1:03 PM Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
>
> Hello Luiz,
>
> I was playing with latest sources (git) and experimental features
> enabled in order to:
> - perform a BLE scan
> - find AdvertisingData (in particularly the BT_AD_INDOOR_POSITIONING (0x25))
>
> I found that:
> - once scanning is done org.bluez.Device1.AdvertisingData is correctly
> set to the expected value (the one advertised)
> - yet, there was no PropertiesChanged signal corresponding to this
> AdvertisingData property update (despite I received PropertiesChanged
> for RSSI)

Is the Data changing? If you want to get informed of each
advertisement regardless if it has changed you should set
DuplicateData filter:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107

If that doesn't work then perhaps we have a bug somewhere.

>
> Indeed src/device.c:: add_data() performs a particular filtering to only
> signal EIR_TRANSPORT_DISCOVERY data.
>
> > static void add_data(void *data, void *user_data)
> > {
> >     struct eir_ad *ad = data;
> >     struct btd_device *dev = user_data;
> >
> >     if (!bt_ad_add_data(dev->ad, ad->type, ad->data, ad->len))
> >         return;
> >
> >     if (ad->type == EIR_TRANSPORT_DISCOVERY)
> >         g_dbus_emit_property_changed(dbus_conn, dev->path,
> >                         DEVICE_INTERFACE,
> >                         "AdvertisingData");
> > }
>
> Is there a particular reason for this behavior ?

If I recall this is not to spam the bus if we are not actively discovery.

> Regards,
> Arnaud
>
