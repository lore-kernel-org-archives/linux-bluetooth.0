Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDBC5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8784217F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 09:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="qTiY+fz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKFJDA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:03:00 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:35755 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfKFJDA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 04:03:00 -0500
Received: by mail-io1-f52.google.com with SMTP id x21so10494146iol.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2019 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fGCJj6Pz3I6UKKEeOYN+WVQ9B06lngzg2P5VaTZWabw=;
        b=qTiY+fz91TPAkQ114kqsI3MtJ6e18IFur01/+8MErLlRy/6fp8RtAGMPbRBN9CgCfV
         32Jd2nGODg4WH0tLqrR5WQkBvsONRMSWVLK8Kq71XflHSp1STTFk3J4XEF+ezHAHiSQg
         9tScHrebRC//inxEo+lTN4I4QAS4FGX4GY013igJiK3FyBSE5LRNxI4BtWXm/H63xpw8
         PdL602X7datPHsmxgSBfyP/lAMHqarPJTvajWurNYrnqnt8irdAtkrt9K/uqmviylE3/
         KPxP/T09vwv5YessRv8ypjk+GsRXj2GyldY9V5v7TQRvpqNLir6oX+zqWsB1ezJSZSP8
         7tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fGCJj6Pz3I6UKKEeOYN+WVQ9B06lngzg2P5VaTZWabw=;
        b=HHZ63d1SZtamFB8NWiHm89y6NsiU9yWRIQQkn1mKpOSNZ6UUSYZXxSruxe9VCS9XUX
         eZIflmfeZQhMphOsHpLZDbNHERFoadtXuAUyGkdGlXCvmjJNA6dMb/e6+hdzAmehWHtb
         WCyR+Ds8aa1G6olxRVbut/mZKrp+SQHQW+Ha0MxrUW0NPw6W4k/QKBpmzrhZdS7IN+z1
         2kS64XmlXLZYC/MkTTplrpTAihjjARSVJXT52mSP0y6cE0faDQt2RUTUChU3jPTnf2ZQ
         7mnjMOLffNBtZ+P6wHKYMSiwyiHTh8nw1Be9uQKaa8BLlCgZb0q6pbBZxo8NHLC3W2D3
         Vmjw==
X-Gm-Message-State: APjAAAX0NuXRx5gbIoA56/+kf8fX4zAWhKa1vODpz4dR2IB+1WRlRlkw
        Qhj0mtLNbSeY1yOVuUy5KAydoXXycKHPH9RcLYQkOQi+LQh5Tco8
X-Google-Smtp-Source: APXvYqwEuiPuyj9UzPONH8O06GSLy0t/lRhcRSRXlp6yzx5G0xokXEK1froo/1enqt1H/4Tga/g3O0bpoVhfLcJ5CRI=
X-Received: by 2002:a5e:9617:: with SMTP id a23mr5422028ioq.191.1573030979283;
 Wed, 06 Nov 2019 01:02:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOVXEJJ=dMe=f8R23JmC_idSV=gy1mmH4NSQTZUpmQPedjgBxw@mail.gmail.com>
In-Reply-To: <CAOVXEJJ=dMe=f8R23JmC_idSV=gy1mmH4NSQTZUpmQPedjgBxw@mail.gmail.com>
From:   =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Date:   Wed, 6 Nov 2019 10:02:48 +0100
Message-ID: <CALevQMaR8C6-cGkkFrNO2B6MfSEo+rxq=6DHnJTBv39wwOW4VA@mail.gmail.com>
Subject: Re: Bluez Compilation error for l_dbus_object_manager_enable arguments
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Please update ell library.

Regards,
Grzegorz

=C5=9Br., 6 lis 2019 o 07:35 Sathish Narasimman <nsathish41@gmail.com> napi=
sa=C5=82(a):
>
> Hi,
>
> I am getting the below error for compiling the latest bluez
>
> tools/mesh-cfgclient.c:1690:7: error: too many arguments to function
> =E2=80=98l_dbus_object_manager_enable=E2=80=99
>  1690 |  if (!l_dbus_object_manager_enable(dbus, "/"))
>
>
> Regards,
> Sathish N
