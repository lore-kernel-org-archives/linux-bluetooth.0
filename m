Return-Path: <SRS0=Lh13=V5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F1C19759
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 14:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CB720644
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Aug 2019 14:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGReOF5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfHAOXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:23:39 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:42012 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfHAOXi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Aug 2019 10:23:38 -0400
Received: by mail-lf1-f46.google.com with SMTP id s19so50401548lfb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2019 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IFJn3FYSn7Lnj8XPD+mc3J+GQ7bjwPDieNyI4G7uMbo=;
        b=SGReOF5OXUGCSLsskykw8CLydIbFqIaa8KYa6QzcrImMS1IuZiDO7ml81+8hLQKUl8
         PoHBjawVV/68VBZYMpqGvdjLhqv3bJDuIdmvJ3qDAr/IljPx0AliUqkfsPe8y+wYlCxk
         WT2G3kKAT8Fy3LyKmlDbQV1vG7LiKPbMa8RROt+GGAEZbLD45wOq6OX7BSBQnGpl/xNP
         Rwz8R9/BygJXASXvV+Nm+7j5fvmhM0LK5orDPOcVLJnfwd2eB08FKUY4dk3lEFX8tbS9
         MfoturzRABa83x/Q66hjN/u0P/UF9lUbxJcJr0zpCn3xOFCYfx4ek/ONeeH8+ccjezJ2
         KpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IFJn3FYSn7Lnj8XPD+mc3J+GQ7bjwPDieNyI4G7uMbo=;
        b=jpSjxA5R8rKW8zw0Pqzsza55XgNQRYXLMTflFjop98P7d9OxxWL6jOJo14GWKKJZ8R
         2l7Oe1Bex5QvY73gPl3UPy8Wine8BUt5jR5Jgi0Xt3jk1nnAwZ9a8k4k/ent7pYrVspm
         371CXFD3ikLlrrmvyIctQE/iDbwOhhoG6iAFxJkVUCkBJcZ6HnPh5PmGufKaKasCPgpR
         6MMYHMOxtJnPstID2lBh0/NWzqfYTdloOR3KYptK10TgGGNjrQu4rhE3Gi+1CEREYnqp
         ceiJzPXy7+N76DMDUbMpuqx5KTfxgZGx+R7Ujv+bXLyVVxQJWo1ZjT9c3TxvRE54DOUo
         PbIQ==
X-Gm-Message-State: APjAAAVlweLJDqnWj+Vv0SjBSg9lz+ioLANdIR+fO0OBO6kse+PJ3EK7
        SbIxje5Tn/cM6Mo+hdXvJ586Gc6g7aJ7FXYJwCRFPDBE
X-Google-Smtp-Source: APXvYqyJFIlpnNzlri63lBPo7j/5NqFbPRQM4F31vxmpVnfU8T7624oYXQOW0d64/8kwnSt9uj30umz5uEhE3y7jRcU=
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr60213564lfg.163.1564669416800;
 Thu, 01 Aug 2019 07:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzhej0YJ6b+=nFXHiiZPJnSdOm=F_OaXR5kWFjvbw2107X94Q@mail.gmail.com>
 <CAAu3APb3LtRkbsGp7kFiBLYMmgKGXiqxnc96ZuBNf93E7ygXSA@mail.gmail.com>
In-Reply-To: <CAAu3APb3LtRkbsGp7kFiBLYMmgKGXiqxnc96ZuBNf93E7ygXSA@mail.gmail.com>
From:   Mathias Baert <mathiasrobaert@gmail.com>
Date:   Thu, 1 Aug 2019 16:23:27 +0200
Message-ID: <CAEzhej3SM77dYEQRLStixeo15tLHqia1ZL3__gn-mQmFYOasZw@mail.gmail.com>
Subject: Re: BlueZ Central to Peripheral latency issue
To:     Barry Byford <31baz66@gmail.com>, Jeroen.Hoebeke@ugent.be,
        subhoshankar.basu@ugent.be, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

I'm using the IPv6 over BLE implementation, which does not use the
GATT layer for actual data communication. It directly interacts with
the L2CAP channel, via LE Credit Based Flow Control Mode. So I'm using
neither of these methods.

Kind regards,

Mathias

On Tue, Jul 2, 2019 at 3:34 PM Barry Byford <31baz66@gmail.com> wrote:
>
> Hi Mathias,
>
> Are you using WriteValue:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt?h=5.48#n79
> or AcquireWrite
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt?h=5.48#n94
> method?
>
> Regards,
> Barry
>
> On Tue, 2 Jul 2019 at 13:32, Mathias Baert <mathiasrobaert@gmail.com> wrote:
> >
> > Hi,
> >
> > We are using the BlueZ 5.48 version on a Raspberry PI with Raspbian Stretch 9.1.
> >
> > The setup is this PI connected with a Nordic Semiconductor nRF52840
> > device, via an IPv6 over BLE connection. The connection is using a
> > connection interval of 7.5 ms. Via throughput measurements with iperf,
> > both ways (central to peripheral and peripheral to central), we are
> > able to achieve maximally ~ 100 kbps (using the 1 Mbps PHY).
> >
> > However, when looking into individual packet exchanges, we notice a
> > significant delay (up to 1 sec) in the RTT when pinging from the
> > peripheral to the BlueZ central and back. We also see a huge
> > fluctuation in this value and it also depends on the intervals at
> > which the pings are fired (lower throughput gives a much higher
> > average individual latency). When firing ping packets at a 1 sec
> > interval, it is definitely visible.
> >
> > When looking into this, we found that the latency between the
> > peripheral and the central is quite stable and low enough. But the
> > latency between the central and peripheral is fluctuating a lot and is
> > generally quite high. Is this something you have noticed before? We
> > think that it could be a scheduling issue on the kernel, where higher
> > throughput gives more priority to Bluetooth communication?
> >
> > Thanks in advance.
> >
> > Kind regards,
> >
> > Mathias Baert
