Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B9C636C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D6061221
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhGUO77 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:59:59 -0400
Received: from meesny.iki.fi ([195.140.195.201]:34222 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239922AbhGUO76 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 10:59:58 -0400
Received: from [192.168.1.195] (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by meesny.iki.fi (Postfix) with ESMTPSA id F3D10200C0;
        Wed, 21 Jul 2021 18:40:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1626882030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDs0jgCsvkGgpLEtAiAdZHaBtwOuxFbMU8eWvONBzbI=;
        b=amRFucxKAkPyzJ5T62eymWGG4wURVFjDT6v4A9/a8PVM3upjYf4IdOy0Dbdttj0DD+b+pJ
        cRw29c7X0iq1LvdscclveHtzwfuV2DMdgmSPdj/8FUsZmRoE0I7BA0n8kzx5qZj2ekIE6T
        NC7L40HTBuaiuc6mxIGC+dDKGYt4Ga4=
Message-ID: <f0a3fae602bb54313d078563d971827c88315b43.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT
 3 for WBS
From:   Pauli Virtanen <pav@iki.fi>
To:     Joseph Hwang <josephsih@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>
Date:   Wed, 21 Jul 2021 18:40:29 +0300
In-Reply-To: <CAHFy41_-EYBNnKyLPof40r6jhtBW=mSHjOX6O=+hzLCbf7_ELQ@mail.gmail.com>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
         <CAHFy41_-EYBNnKyLPof40r6jhtBW=mSHjOX6O=+hzLCbf7_ELQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1626882030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDs0jgCsvkGgpLEtAiAdZHaBtwOuxFbMU8eWvONBzbI=;
        b=TUy+ec8f0U9cCx1OS0njytayPjaGNlT/VzTi80KZkMtOUaIugBMQ2V8AsPXipU8VPqMREJ
        AtEsVc5oc+2JOFt3glg7fM3uNppFwPS+O1XrWQzVxM/4cquxqorE9OaEbaKfj+LN8LR2AO
        mgL27u4Drf5xGHkfk7ZMHhqTmlYQoVI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1626882030; a=rsa-sha256; cv=none;
        b=k09AeowBoJHDyQKU+BsEBenqHUV+VdCD/qfAgcwdr81DQRcXL6NuDqnH+fOdZOuE3B8wjQ
        Ns7iLXudLB1WS9MF7d/eNztwrNm8Cvm/CyYrc33SP0HihhTCEoTddjMTdBBNSgBUk1c0Wz
        pdO6ZksaJ+gjaoRMq7B6hy625fv+vB8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

la, 2021-07-17 kello 21:34 +0800, Joseph Hwang kirjoitti:
> It looks reasonable to check sco_mtu. My suggestion is to use
> hci_packet_size_usb_alt[3] instead of the magic number 72.

Thanks for looking at it. IIUC, hci_packet_size_usb_alt only appears in
previous discussions on this list, which did not seem to reach a
conclusion if this should be computed from wMaxPacketSize. I can do
less magical v2 and add the table.

Different solution would be to make the altsetting choice
manufacturer/device specific flag, as I'm not sure on what hardware
e848dbd364ac was tested on, so maybe it is intended Realtek specific.

Best,
Pauli


> On Sat, Jul 17, 2021 at 1:58 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Some USB BT adapters don't satisfy the MTU requirement mentioned in
> > commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> > and have ALT 3 setting that produces no/garbled audio. Check that the MTU
> > condition is satisfied, and fall back to ALT 1 if not.
> > 
> > Tested with USB adapters (mtu<72, produce sound only with ALT1)
> > BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3)
> > RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling ALT6).
> > 
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  drivers/bluetooth/btusb.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index a9855a2dd561..3ee66e415c4d 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1763,9 +1763,11 @@ static void btusb_work(struct work_struct *work)
> >                         /* Because mSBC frames do not need to be aligned to the
> >                          * SCO packet boundary. If support the Alt 3, use the
> >                          * Alt 3 for HCI payload >= 60 Bytes let air packet
> > -                        * data satisfy 60 bytes.
> > +                        * data satisfy 60 bytes. USB Alt 3 support also needs
> > +                        * HFP transparent MTU >= 72 Bytes.
> >                          */
> > -                       if (new_alts == 1 && btusb_find_altsetting(data, 3))
> > +                       if (new_alts == 1 && hdev->sco_mtu >= 72 &&
> > +                           btusb_find_altsetting(data, 3))
> >                                 new_alts = 3;
> >                 }
> > 
> > --
> > 2.31.1
> > 
> > 
> 
> 


