Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C3C07E96
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Jul 2021 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71559610EA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Jul 2021 15:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhGKPg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Jul 2021 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbhGKPg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Jul 2021 11:36:56 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91439C0613DD
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 08:34:08 -0700 (PDT)
Received: from [192.168.1.195] (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 537791B00215
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 18:34:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1626017644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDLZvLy8I83zvIaAmKV427EtcxLvFicAYPkS9ZW9J+s=;
        b=jgl59zvIy25Cren37d72m6etKGOWf7gUvFBzaQKuPJ7J/0hhYaH0u8S04PTFwlg6TPATpY
        lrh58pouU2NMiF04sNCutA1nwtXckcC4ut5X5vopXVmT/fFoBoLN7sHvFVI2viwYCKRxZS
        70p+kyrT6elHbP5qKHHsHurblHdOyHJ8u36xCAB0WKYMw5AH9eb/eEqTxnuMaomFOg5jFn
        K2rf5TXYx4Sh2E0ejHxwPtXyGZse32bouNYWGidNTWKWCss40IGuwFHz+mJ9aCzfGqi/s7
        PxAA6yYrdKysmE76+vTVl2X7nrxQgWyGRhH01JWxiyhflvpj7yGbShc8VZbJYg==
Message-ID: <ca3adcf5fd1e7afa923f445d391aaa00f335c470.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support USB ALT 3 for WBS
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Date:   Sun, 11 Jul 2021 18:33:57 +0300
In-Reply-To: <20210514031901.2276-1-hildawu@realtek.com>
References: <20210514031901.2276-1-hildawu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1626017644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDLZvLy8I83zvIaAmKV427EtcxLvFicAYPkS9ZW9J+s=;
        b=bkT0ZL55ruf/cYbRkGz/fDxdH7Zm77v0NVeIuJLmDtjUj1e2eawlCLrmt5Ym1O01fdt9NU
        hwbMzt0G5tOJ40+arb5hSVTZq+RQdJivO9yLMCn4RA5LdKWr7MPjO7kdyG+vwi9MIxSuqQ
        TKIMOL55dQdorkXKLAyfzljhIvNLLlDZRqfEIgkyU5P6r1cCAmD/E9UvO6sqqVRnKcVNJh
        +6aRR5S03vK+yKojyjF6o2Nkp4MHMlugPkzzWMTUdNtDKESxBT2CBXZMku0PE8Nj+4hjXz
        wFQaXyoJbuv0norq+ZdwV61eFQ3QoDkXHLypO+p53oJTQNrfIMq47rpaET9Dqw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1626017644; a=rsa-sha256;
        cv=none;
        b=V5HviORjAiiKm1vly3YCxAd8SC+RfQplf09EFN5aeX8JbtIbphHOCbROH9/vtf7lXwKb+Z
        7nqKm7dc0Qvn8EU+AtJd+Bfbd+5sqdhfxy0SQR5T3ifN4P/sX4p9glbRhCFwL0nqyGfLZ1
        d6iGHLqTNvv1FeDQkF0g0oNGylpRPPmVjKMiyw/kwSexM+RxUOrQCb88GqskBQJ0H7oLZZ
        cDneI0FOeGhL3o2zBBYX2GHQhUSPRujAbE13zMrhS3tFXaWw1pia9o/lC9BssbBTf3rDhw
        dvDB3zMMMmAqQFh8mqqHbd2jgokFqHwop+mUJa/uV3BIohwm/E7NKiC4i/tLxA==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

pe, 2021-05-14 kello 11:19 +0800, hildawu@realtek.com kirjoitti:
> From: Hilda Wu <hildawu@realtek.com>
> 
> Because mSBC frames do not need to be aligned to the SCO packet
> boundary. Using USB ALT 3 let HCI payload >= 60 bytes, let mSBC
> data satisfy 60 Bytes avoid payload unaligned situation and fixed
> some headset no voise issue.
> 
> USB Alt 3 supported also need HFP support transparent MTU in 72
> Bytes.
> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Changes in v2:
> - Updated signed off name.
> - Adjusted coding style.
> ---

This change seemed to break msbc audio on some non-realtek adapters I
have. Tested Pipewire on BCM20702A1 (0b05:17cb), CSR8510A10 (0a12:0001)
-> no sound output and input appears garbled. Reverting this patch
makes it work again. Indeed these adapters report SCO mtu=64 which is
less than 72. On the other hand, with RTL8761BU (0bda:8771) msbc audio
works fine with this patch out of the box, indeed reading/writing 72
byte packets to/from the sco socket.

ALT 3 on RTL8761BU does appear to address garbled audio with some
headsets. Maybe the altsetting should be determined based on a quirk,
the mtu requirement be checked, or something similar? AFAIK, userspace
can't do anything to fix this.

Best,
Pauli Virtanen

> ---
>  drivers/bluetooth/btusb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6f253378e893..1e98f985740b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1752,6 +1752,13 @@ static void btusb_work(struct work_struct
> *work)
>                          * which work with WBS at all.
>                          */
>                         new_alts = btusb_find_altsetting(data, 6) ? 6
> :
> 1;
> +                       /* Because mSBC frames do not need to be
> aligned to the
> +                        * SCO packet boundary. If support the Alt 3,
> use the
> +                        * Alt 3 for HCI payload >= 60 Bytes let air
> packet
> +                        * data satisfy 60 bytes.
> +                        */
> +                       if (new_alts == 1 &&
> btusb_find_altsetting(data, 3))
> +                               new_alts = 3;
>                 }
>  
>                 if (btusb_switch_alt_setting(hdev, new_alts) < 0)






