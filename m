Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E901260F22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhG2UCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhG2UC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 16:02:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEDEC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 13:02:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so484608pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gwBN9s/RGZC8CNklpl7u88ayha2EeFnJt+Xr9suaay0=;
        b=Y/E7YNR++97qhmuSWEvrztm8NbBDo9A3cHSqAdsIUWySBMEtrXiPilA8BePaUi1k9E
         HT1hX9mWOabEPxgE5mF9DC/4Z0AnM7WippLEF6gVKfTXBOF0Bon923eLPUiaGzQRc2R5
         TQH3mKue/9vyqS3fZpwkfO/68c65G3ChdM6wzjYWweDbErywjTCBg7qY5W9+cqooCVzH
         nHZCSZLe+IjeioJhSBI0kTMHdf12CkubMs6gRSFpEHIRdGgnYWkQyqdHwRpuRKcK0ME4
         VLVbBrMUvvnJXMTQAO9o9lTX7uKDN/XCs3Nhrvlnn1tPRb4hdi87dYyNpQ/CE0RK5Pps
         ZDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gwBN9s/RGZC8CNklpl7u88ayha2EeFnJt+Xr9suaay0=;
        b=uacUM4qsdd3A4pNDe76l4+th8xUTTaoX98eDEsFwy5oLQyb3/IShu3SBz6PmumjEaL
         BuBIMSK0nO7sBIrLSrbY+V+ysGFdO1s9QAkAt+a7K7Azn5FvgvRJgYV1CgbTIfjsGCHO
         yg97IJbcHnnTD5RyLf9m6guW5/6N/LJS9QRzmJj26CtdVsTScG91DKjMP4Fjroj0zrq7
         4zCyBIhVajNAFj0sFUdq2O0rwx30bmCQgHDXGMLDMlNQY/QkVWFTgnl/smaNhROQS1NB
         f0Y6eM5eOlyRdeXanI47H07WwpvX8oDCfk7HG3aJ/ZxE+X4dWguu4H6shKKOSyi02il4
         fWig==
X-Gm-Message-State: AOAM530RmVGgcmZQ26oWQHooNgci8cIfB3BjjI8Ks2LzjzDpB1UPVa8Q
        Ggl9cEIRJNhA8DSbu2dDBEuGGl9UQg4=
X-Google-Smtp-Source: ABdhPJxV2aqht1ehqnwykTruKsWduGCQTSK9DMcMEvzeyCpUCeOkOHfcv7kN1h2EbYZmyqL8mx1mXg==
X-Received: by 2002:a17:902:d389:b029:12b:b3cc:457c with SMTP id e9-20020a170902d389b029012bb3cc457cmr6169998pld.31.1627588945340;
        Thu, 29 Jul 2021 13:02:25 -0700 (PDT)
Received: from pkalappa-MOBL1.amr.corp.intel.com ([134.134.139.81])
        by smtp.gmail.com with ESMTPSA id u3sm10817996pjn.18.2021.07.29.13.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:02:24 -0700 (PDT)
Message-ID: <b89dcd756cff44718b1bbb8388eb6b4d2175bdb7.camel@gmail.com>
Subject: Re: [PATCH v5 11/11] Bluetooth: btintel: Fix the legacy bootloader
 returns tlv based version
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Thu, 29 Jul 2021 13:02:23 -0700
In-Reply-To: <F95FB44C-1E3B-485A-A373-878768518C6F@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
         <20210729183600.281586-12-hj.tedd.an@gmail.com>
         <F95FB44C-1E3B-485A-A373-878768518C6F@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 2021-07-29 at 21:40 +0200, Marcel Holtmann wrote:
> Hi Tedd,
> 
> > From the ThP, it supports both old and TLV based HCI_Intel_Read_Version
> > command after downloading the operational firmware.
> > Starting from th JfP, it supports both old and TLV based
> > HCI_Intel_Read_Version command in the operational firmware and it causes
> > the setup() uses the TLV based setup instead of legacy setup.
> > 
> > So, as a workaround, this patch checks the fw variant from the TLV based
> > version and it uses the legacy HCI_Intel_Read_Version command to get the
> > legacy version information and run the legacy bootloader setup with it.
> > 
> > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 25 ++++++++++++++++++++++++-
> > 1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 57b64d744f0a..f11882d10da7 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2254,10 +2254,33 @@ int btintel_setup_combined(struct hci_dev *hdev)
> > 	/* For TLV type device, parse the tlv data */
> > 	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
> > 
> > +	/* Some legacy bootloader devices from JfP supports both old and TLV
> > +	 * based HCI_Intel_Read_Version command. But we don't want to use the
> > +	 * TLV based setup routines for those old bootloader device.
> > +	 * Also, it is not easy to convert TLV based version to the legacy
> > +	 * version format.
> > +	 *
> > +	 * So, as a workaround for those devices, use the legacy
> > +	 * HCI_Intel_Read_Version to get the version information and run the
> > +	 * legacy bootloader setup.
> > +	 */
> 
> why is that again? If possible we should convert them. What information is missing from the TLV
> format that we need?
> 
It needs hw_variant, hw_revision, and fw_revision in order to get the firmware file for legacy
bootloader setup. But new TLV format doesn't provide those values.

Let me check with FW team if those values are wrapped in TLV somehow.


> Regards
> 
> Marcel
> 

Regards,
Tedd

