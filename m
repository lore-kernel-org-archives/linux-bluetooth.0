Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713BDC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8B6101E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 14:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhGVNph (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhGVNpf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 09:45:35 -0400
X-Greylist: delayed 81937 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jul 2021 07:26:10 PDT
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2444C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 07:26:10 -0700 (PDT)
Received: from [192.168.1.195] (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by meesny.iki.fi (Postfix) with ESMTPSA id 0BF17200CE;
        Thu, 22 Jul 2021 17:26:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1626963968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rr8zfG4i2dbxym/RPUInutiR5WBcnmchD8Xt/2Da4M=;
        b=ZEc2yzMcsQAS9DesvoQfBQsuDo3FGLNors5hD+82mi5xY/P5T3GhGEopLeh9+2gYSsFqcx
        cYpPs+2BoCeEYcwD56xg54YUzMfBU0cBV8gU2GIhtbPnjDlc8ejD16ToS3Pw3M+wca6U3o
        zldsRicDZymkYq/f9teHxgFhmTD+g8Y=
Message-ID: <f32df70b9aaccfbb471a6305c5b4884ae14dede3.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT
 3 for WBS
From:   Pauli Virtanen <pav@iki.fi>
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Thu, 22 Jul 2021 17:26:07 +0300
In-Reply-To: <YPly1RR8V33T3odj@larwa.hq.kempniu.pl>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
         <YPly1RR8V33T3odj@larwa.hq.kempniu.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1626963968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rr8zfG4i2dbxym/RPUInutiR5WBcnmchD8Xt/2Da4M=;
        b=O6EI4t5YrdWejbiv5XTm82F4jP0pBZxnWlBKfl6gjJ1+EmXcYl0j2whd/Oymhd6KLtiet7
        ru64WtoHyzFrhpZaFltSQDcf/IGhmyxxGUezREfbQ4afNmbI+/Bh6FAnwwpcws0LpbC3IC
        7LVN8tgbeBOQ3MaB9ttsZUBxnDZ278o=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1626963968; a=rsa-sha256; cv=none;
        b=OWX8GVAi6m0F03+vlgJdRjbbCGVKgxH2sCRy5N7gxmBt1O2HHrE6IRmyVpWTYEtufWw0nl
        h9jRoQgEEuZxgB9wzdC7y/MUzUUi/OYrrIvG7dFtk4R+yZXNDr3fMw4nC7deLzr9XKSmUb
        +rXFO439hNi3t3a6gNVsP3tQtqgdRCI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michał,

to, 2021-07-22 kello 15:29 +0200, Michał Kępień kirjoitti:
> Thank you for your work on this patch!
> 
> > Some USB BT adapters don't satisfy the MTU requirement mentioned in
> > commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> > and have ALT 3 setting that produces no/garbled audio. Check that the MTU
> > condition is satisfied, and fall back to ALT 1 if not.
> > 
> > Tested with USB adapters (mtu<72, produce sound only with ALT1)
> > BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3)
> > RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling ALT6).
> 
> Commit e848dbd364aca44c9d23c04bef964fab79e2b34f causes garbled mSBC
> audio on my Bluetooth adapter (8087:0a2b), so I gave your patch a try.
> 
> Unfortunately, the patch in its current shape does not seem to be enough
> to fix things for this adapter, which reports an SCO MTU of 96 bytes and
> produces garbled mSBC audio with ALT 3.
> 
> For the record, reverting e848dbd364aca44c9d23c04bef964fab79e2b34f on
> top of v5.14-rc2 makes mSBC work again with my adapter.
> 
> I am no Bluetooth expert, but I will be happy to perform any additional
> debugging and/or testing.

Thanks for testing! What userspace software did you use? Pulseaudio at
least I think had assumption that mtu <= 60, which breaks here
(Pipewire works, don't know about bluez-alsa). If otherwise, maybe it
then needs also the manufacturer flag.

Best,
Pauli

