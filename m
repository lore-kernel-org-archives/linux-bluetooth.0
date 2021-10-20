Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19526C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA55061371
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 15:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhJTPcV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhJTPcU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 11:32:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F7C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 08:30:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso793939pjd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZePVF3V7BcESfRNnGF6GTdR3Cvza54d1sEiKXmmr/wc=;
        b=ZflZqKw9g7+n7A5iR9n0w1lyAGwi2aijd2gYV/6Lt2NOjJV500Ztz3+XqHHIgLqN3d
         tnh7meajXtVFv9TvVPvTG6uSdejxnABMIFiHaRerwlnPXxXjWyUTbev6k0N3jfGfJsy7
         eUybpGEXb2ejp7Nmvak+9e63VAS21mUCBX+Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZePVF3V7BcESfRNnGF6GTdR3Cvza54d1sEiKXmmr/wc=;
        b=qzS2Au796RTNAlXcT3w29MTbQwdAzmJi3JrwvkyW11/JEkZ9EQyUZ0mgCiNR0qEgHG
         Xr/KUXSp6EuERf7XyI9JC5PwCySTV3trv3cvJp318DUtcBYGzWNBqK/76N1GpWLfUSrp
         SEI5vdssGOO7yu/p70as0xTivgFZuv8pQzKu/X3ipxYhd91ZUW3zXTvWRGdSBijpb4Nq
         x+OL2pjcrHN+R2ktUdTqzC63+UJSgqnzVuMc69vN8tMm8VaZ4Ls5GNbAOQOvdprBPyEs
         CL2qbr8+NvmasnGPlEQ78f3tLtWWf0r2i0quB2lA2uBrV6cHl+BQO8FyswjqzFgHttcB
         u+BA==
X-Gm-Message-State: AOAM533TlQzwOE1HPj7ZaypmRec/8edS3suDK8RPjGUngqyslRB0EP7T
        7/Z8vIeYM0AgeberDq2DV9/Uig==
X-Google-Smtp-Source: ABdhPJywAZ0vjVwOr64P3L5GvlqlYhw8Xzr5r0oGdvyzC00QTHlqQzksEQM/GUrbly31pMOCIvvD3g==
X-Received: by 2002:a17:90b:2404:: with SMTP id nr4mr682253pjb.40.1634743804142;
        Wed, 20 Oct 2021 08:30:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d5fe:85e9:caf2:ec4e])
        by smtp.gmail.com with UTF8SMTPSA id d137sm3162168pfd.72.2021.10.20.08.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 08:30:03 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:30:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     tjiang@codeaurora.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for variant WCN6855 by
 using different nvm
Message-ID: <YXA1+tEiCoY8yPRR@google.com>
References: <81add00a4a038008e9f734c5f5e5b712@codeaurora.org>
 <YW8csSr/I1IRgAaT@google.com>
 <39ca0c9102265d6e14f3e0da94fec40d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39ca0c9102265d6e14f3e0da94fec40d@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Oct 20, 2021 at 12:00:52PM +0800, tjiang@codeaurora.org wrote:
> Thanks Matthias for the comments. please see my comments inline .
> 
> BTW: marcel , do you agree with Matthias comments ? if fine , I will align
> Matthias comments and make the final version.
> 
> regards.
> tim
> On 2021-10-20 03:29, Matthias Kaehlcke wrote:
> > On Tue, Oct 12, 2021 at 03:55:56PM +0800, tjiang@codeaurora.org wrote:
> > > the RF performance of wcn6855 soc chip from different foundries will
> > > be
> > > difference, so we should use different nvm to configure them.
> > > 
> > > Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> > > ---
> > >  drivers/bluetooth/btusb.c | 56
> > > +++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 42 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 75c83768c257..f352ff351b61 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -3190,6 +3190,9 @@ static int btusb_set_bdaddr_wcn6855(struct
> > > hci_dev
> > > *hdev,
> > >  #define QCA_DFU_TIMEOUT		3000
> > >  #define QCA_FLAG_MULTI_NVM      0x80
> > > 
> > > +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> > > +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> > > +
> > >  struct qca_version {
> > >  	__le32	rom_version;
> > >  	__le32	patch_version;
> > > @@ -3221,6 +3224,7 @@ static const struct qca_device_info
> > > qca_devices_table[] = {
> > >  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
> > >  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
> > >  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> > > +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
> > >  };
> > > 
> > >  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8
> > > request,
> > > @@ -3375,6 +3379,43 @@ static int btusb_setup_qca_load_rampatch(struct
> > > hci_dev *hdev,
> > >  	return err;
> > >  }
> > > 
> > > +static void btusb_generate_qca_nvm_name(char *fwname,
> > > +					size_t max_size,
> > > +					struct qca_version *ver)
> > 
> > => const struct qca_version *ver
> > 
> > > +{
> > > +	u32 rom_version = le32_to_cpu(ver->rom_version);
> > > +	u16 flag = le16_to_cpu(ver->flag);
> > > +
> > > +	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> > > +		u16 board_id = le16_to_cpu(ver->board_id);
> > > +		u32 ram_version = le32_to_cpu(ver->ram_version);
> > > +		const char *variant;
> > > +
> > > +		switch (ram_version) {
> > > +		case WCN6855_2_0_RAM_VERSION_GF:
> > > +		case WCN6855_2_1_RAM_VERSION_GF:
> > > +			variant = "_gf";
> > > +			break;
> > > +		default:
> > > +			variant = "";
> > 
> > instead of the default branch you could assign a default to 'variant' at
> > declaration time, but it's fine either way.
> 
> [Tim] this code style is recommend by marcel.

Both are ok, if Marcel prefers the default branch let's keep it that way.

> > 
> > > +			break;
> > > +		}
> > > +
> > > +		/* if boardid equal 0, use default nvm without suffix */
> > 
> > delete the comment, it just states the obvious
> > 
> > > +		if (board_id == 0x0) {
> > 
> > nit: is there really any value in using a hex number here instead of a
> > plain decimal 0?
> 
> [Tim] this line is inherit from last change , if you think I should change
> 0x0 to 0 , I am fine.

Since this patch touches/moves this code it seems a good opportunity to clean
things up a bit. It's also true that there are quite a few instances of this
and comparisons with '0x00' in other parts of the kernel, so I guess it's
also fine to leave it as is.
