Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0365C10F0B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897B2063F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOYwZyup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfBZTby (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:31:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41468 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZTby (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 14:31:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id y5so6705922plk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOkMcF/KCR9TmeYJTCZ/0RpTzFWfB6fAq5K2h5yMqbs=;
        b=cOYwZyupTirhDFFAkCvu6/uxuElh8519IGROS3I1jD+i5X6xBjNGtyraM+B0upsOpU
         HGukdh5a3LmUX+ihl+41kVtrvPcgNe+jtEQad+bZn4PALymI8hzkknyz+J6i/qJ/bWxE
         cnBgPunvziIK23sVKUSbECig+0OvUpMk+ol+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOkMcF/KCR9TmeYJTCZ/0RpTzFWfB6fAq5K2h5yMqbs=;
        b=rcbrZR3YM3mhneRVKpy0SMPjm0LELzuTEGTxN/tX5md2za+gP14I246ISZCymEHYYJ
         GUQSrGWK6knwjWzSNEADfROQO4QFzG3VilykzOGLlaLWsQxziH4FU7f/llS4sbMGRdHB
         hapxyWab/CnuxKt07EP2PJjqcwAOvMP2k9AlzPGTJdK5dtFYT/ErAN8DOIM4D7ofyFaH
         jFuFqzNA6ycJ1q8z5E9syAFUXaYfIbJrqGoBZNhV8Sy2zTC5Jol4LvWq/zAV12L42XCM
         0rYLYsgNrO02MeXzgIutiQXj/syVcb4DLq7o7Bu0RMH8mTFsVDCvCLxz/y1rDUsin+ed
         cZkQ==
X-Gm-Message-State: AHQUAubRrCsGDSpxk7OPHT12l73mF9TNbW7fOHjwq8psNf5BmksR/S6Y
        gzv7TMI6XCSHdLunpZzw8zazDA==
X-Google-Smtp-Source: AHgI3IbSFVw3hRqY8yEc265o7kjLWArzcDmCZS4TJg8n+WBFjbXiYSX1VwzY90p1lGQBcdN1smyIHQ==
X-Received: by 2002:a17:902:e60e:: with SMTP id cm14mr27695513plb.192.1551209513481;
        Tue, 26 Feb 2019 11:31:53 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d129sm15319595pgc.59.2019.02.26.11.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:31:52 -0800 (PST)
Date:   Tue, 26 Feb 2019 11:31:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantg@codeaurora.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Move boot delay to
 qca_send_power_pulse()
Message-ID: <20190226193152.GA135932@google.com>
References: <20190225234954.82942-1-mka@chromium.org>
 <20190225234954.82942-3-mka@chromium.org>
 <c4f0563baa3b61a3bd1725d71517495e@codeaurora.org>
 <0c928a085f4c237c3efe0ad9fda803d9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c928a085f4c237c3efe0ad9fda803d9@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Balakrishna,

Thanks for the reviews!

On Tue, Feb 26, 2019 at 05:54:24PM +0530, Balakrishna Godavarthi wrote:
> hi Matthias,
> 
> On 2019-02-26 17:48, Balakrishna Godavarthi wrote:
> > On 2019-02-26 05:19, Matthias Kaehlcke wrote:
> > > After sending a power on pulse the driver has a delay of 100ms
> > > to allow the host controller to boot. Move the delay into
> > > qca_send_power_pulse(), since it is directly related with the
> > > power-on pulse.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index e4128774e9686..eacc108c422d0 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -1036,6 +1036,9 @@ static int qca_send_power_pulse(struct hci_uart
> > > *hu, bool on)
> > >  	usleep_range(100, 200);
> 
> [Bala] : i still doubt do we require this delay.

I don't know if it was necessary (or at least helped in the power-off
case) without this series, but my testing suggests it is not needed
with the delay after the power off pulse ("[3/3] Bluetooth: hci_qca:
Add delay after power-off pulse").

I'll send a new version without the delay.

Thanks

Matthias
