Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E578DC06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 12:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB81C21721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 12:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxHZsNiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGBMay (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:30:54 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:42457 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGBMay (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 08:30:54 -0400
Received: by mail-lj1-f175.google.com with SMTP id t28so16684703lje.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cLNP/sosMDd8EoWilGG4yKpNq20kQJtoc5CsHx4SqSU=;
        b=uxHZsNizCEDjuprQU2iQehvqQSd53AiMSkSRVvG1YlJ+NHs2J9VGBuuKZfhJoilrZ0
         xYr7Kr73hUxrXTeC/LEoja3DpNkhEUU6oveq9A62Q7x9Y3mqc4kPft7lxVfktt3Zci4G
         YZMenea6du89cpxZVnqYoBEL/cBQTlhrC/ofB86sM4Zt+IrPBOeIXwFaF7whVfp8JS8v
         lq4a2CuccxZv3y/31Ta4kYe3Xm7AUJi6gbl6tyHSg8zWvpt2nCZAUGiuvnadISnNkLAO
         goAeNP0de3Pdi2a5/wHcwVfDvFhq1TEqliy6Jj2sj+/73hSeTb4rEM+gRGN21CwYSw8S
         Qe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cLNP/sosMDd8EoWilGG4yKpNq20kQJtoc5CsHx4SqSU=;
        b=KRPFmCRwvwzP9KYkaN+ZV0BM9x0iyn9W41fj7U8/WjPGo5MEkTOEBOpWo96eO2+rPJ
         ddKCI8pEk1s4oMm333qA0mzv2AD2h/yFfj9/jmUIkxzfz4Qb1xAROEoLLaJOANoypdCP
         Zw7QeSk7bVC1dM35oIqIvW8OsuYUe5/P8YdNQ/6tSC846aqdZFbwbQ0L1n87s3ROAAJF
         14H0xpkmwCaSYfkBZiQuNHkkpG8GMYtcKzK53l/9wt5Kj7vR59V0FePyYwHsPh5NwOny
         LtXIn2mgQISR/d1bN1ULX47lKBWkUR7QOqnvHB+yL+axv/fsjtJQQeDpMKjh6k8P9GXZ
         eaSg==
X-Gm-Message-State: APjAAAVAeMOjXJ+eBNnyoaMkkFqjpjI10R9WP872RJ2f72pkRo9ID2GZ
        IG29c/hIrxdI/5dSwgU5JM0WDiDU+7XjYdv97j9yvUU3
X-Google-Smtp-Source: APXvYqwjmumvoTiEBYmKXfwionqGDlevL1Vcbdn+BU2QrAH9S/nuUSyKgi415ktPdpY3vdS1yGzGC/7U6qykZaLvvXs=
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr17085850ljl.161.1562070651895;
 Tue, 02 Jul 2019 05:30:51 -0700 (PDT)
MIME-Version: 1.0
From:   Mathias Baert <mathiasrobaert@gmail.com>
Date:   Tue, 2 Jul 2019 14:30:41 +0200
Message-ID: <CAEzhej0YJ6b+=nFXHiiZPJnSdOm=F_OaXR5kWFjvbw2107X94Q@mail.gmail.com>
Subject: BlueZ Central to Peripheral latency issue
To:     linux-bluetooth@vger.kernel.org
Cc:     subhoshankar.basu@ugent.be, Jeroen.Hoebeke@ugent.be
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

We are using the BlueZ 5.48 version on a Raspberry PI with Raspbian Stretch 9.1.

The setup is this PI connected with a Nordic Semiconductor nRF52840
device, via an IPv6 over BLE connection. The connection is using a
connection interval of 7.5 ms. Via throughput measurements with iperf,
both ways (central to peripheral and peripheral to central), we are
able to achieve maximally ~ 100 kbps (using the 1 Mbps PHY).

However, when looking into individual packet exchanges, we notice a
significant delay (up to 1 sec) in the RTT when pinging from the
peripheral to the BlueZ central and back. We also see a huge
fluctuation in this value and it also depends on the intervals at
which the pings are fired (lower throughput gives a much higher
average individual latency). When firing ping packets at a 1 sec
interval, it is definitely visible.

When looking into this, we found that the latency between the
peripheral and the central is quite stable and low enough. But the
latency between the central and peripheral is fluctuating a lot and is
generally quite high. Is this something you have noticed before? We
think that it could be a scheduling issue on the kernel, where higher
throughput gives more priority to Bluetooth communication?

Thanks in advance.

Kind regards,

Mathias Baert
