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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED9AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099AF60F48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhG2V7x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhG2V7w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 17:59:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC14C061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:59:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k4-20020a17090a5144b02901731c776526so17734226pjm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7WKi8wjMk9wI3r5Yi0tqC7Qwefzwqp1JP3u+OSI15Q4=;
        b=I61ZR43XzvZ8Fw/hALlAQvqE8KWea3hRNgNyb0EpbHiW2it6VNK/AZujnouW1jzM0k
         mUKTHKf9YeIxvCMqwqEMh9iKAIhhuRXjL1/7Kn4zCdGHY2j1GrADKh5KZ8//oo/BoT2A
         TA9ppSsQpnoSVyHQ5C6lm7YsPU0uYodu5CvF9S+FbtMhOkwWMLWOMEXBEguXjjmr8Vlr
         OLMoimsABqOlNBTnJ5FPRYSVMBHx36jMkvJJgbwv4EkV9ONju++dNzesAhuJ/uRVV8Db
         ZpwoqOGQ85Iz4YsIdjhZfs0sh9tCLeolTZN7YiTpk3/1/YqApKN2ryrfl2GpP8bEM7/D
         3c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7WKi8wjMk9wI3r5Yi0tqC7Qwefzwqp1JP3u+OSI15Q4=;
        b=HfKqLwHWL5Foi4YeKlgrnYwE1htAXlUcxEDaUsoOnYZtSuvyZjwQWbjmppL31NnaGR
         ynCjjwxyZef/9FlUWQ23GZjX249VLx4irxjVkNC5/wFgK+X/KHiEpdjRhueDDusvg3K5
         hUav9Sj5ltFTC2PniiEjMNnQwk7g0WXTNprwokZ1agbyfoCuwGJCY+STvLOzrP0JgJGJ
         eUZvGiTABhY8ay/2lpJ+QUzPZ5ma0wp0y0Lmt4a+baHQb/XoA20N4XAaOoiPa/zM88tj
         Pj+zI3lRf/137wR/vry5GPI3kkahmseRa8jNjNae/z4r1DQjDLtgkTjNpoVYylbsAy8f
         i80A==
X-Gm-Message-State: AOAM53136Goa5oSkDE1rck48DVrN44FLZ5a2QoBStns3s0PswfiBnnFG
        RWFzcOVEm597CmYo2hMOdlPsfUEIr8U=
X-Google-Smtp-Source: ABdhPJxEBUqyR+v5eC13q0CkEOC0yBbndwLEs4SgCWNLRdEkM/+OAw98kQgpW461tHpELDz4fbOUFg==
X-Received: by 2002:a65:420d:: with SMTP id c13mr5627449pgq.123.1627595988767;
        Thu, 29 Jul 2021 14:59:48 -0700 (PDT)
Received: from pkalappa-MOBL1.amr.corp.intel.com ([134.134.139.81])
        by smtp.gmail.com with ESMTPSA id b3sm4806220pfi.179.2021.07.29.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:59:47 -0700 (PDT)
Message-ID: <05fd097e82b5c50ceaba584f36b6f8855792fc69.camel@gmail.com>
Subject: Re: [PATCH v5 05/11] Bluetooth: btintel: Fix the first HCI command
 not work with ROM device
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 29 Jul 2021 14:59:46 -0700
In-Reply-To: <02BA95EC-D6F9-40DA-BAC3-6C935A8DB0C4@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
         <20210729183600.281586-6-hj.tedd.an@gmail.com>
         <02BA95EC-D6F9-40DA-BAC3-6C935A8DB0C4@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, 2021-07-29 at 21:35 +0200, Marcel Holtmann wrote:
> Hi Tedd,
> 
> > The some legacy ROM controllers have a bug with the first HCI command
> > sent to it returning number of completed commands as zero, which would
> > stall the command processing in the Bluetooth core.
> > 
> > As a workaround, send HCI Rest command first which will reset the
> > controller to fix the issue.
> > 
> > Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 21 +++++++++++++++++++++
> > drivers/bluetooth/btintel.h |  1 +
> > drivers/bluetooth/btusb.c   | 16 ++++++++++++++--
> > 3 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index bf0ad05b80fe..65ecf2ae9a10 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -1659,6 +1659,7 @@ static int btintel_legacy_rom_setup(struct hci_dev *hdev,
> > 
> > int btintel_setup_combined(struct hci_dev *hdev)
> > {
> > +	struct btintel_data *intel = hci_get_priv(hdev);
> > 	const u8 param[1] = { 0xFF };
> > 	struct intel_version ver;
> > 	struct intel_version_tlv ver_tlv;
> > @@ -1667,6 +1668,26 @@ int btintel_setup_combined(struct hci_dev *hdev)
> > 
> > 	BT_DBG("%s", hdev->name);
> > 
> > +	/* The some controllers have a bug with the first HCI command sent to it
> > +	 * returning number of completed commands as zero. This would stall the
> > +	 * command processing in the Bluetooth core.
> > +	 *
> > +	 * As a workaround, send HCI Reset command first which will reset the
> > +	 * number of completed commands and allow normal command processing
> > +	 * from now on.
> > +	 */
> > +	if (test_bit(INTEL_BROKEN_READ_VERSION, &intel->flags)) {
> > +		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
> > +				     HCI_INIT_TIMEOUT);
> > +		if (IS_ERR(skb)) {
> > +			bt_dev_err(hdev,
> > +				   "sending initial HCI reset failed (%ld)",
> > +				   PTR_ERR(skb));
> > +			return PTR_ERR(skb);
> > +		}
> > +		kfree_skb(skb);
> > +	}
> > +
> > 	/* Starting from TyP device, the command parameter and response are
> > 	 * changed even though the OCF for HCI_Intel_Read_Version command
> > 	 * remains same. The legacy devices can handle even if the
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index df7aa30142b4..29b678364a79 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -143,6 +143,7 @@ struct intel_debug_features {
> > #define INTEL_FIRMWARE_LOADED		2
> > #define INTEL_FIRMWARE_FAILED		3
> > #define INTEL_BOOTING			4
> > +#define INTEL_BROKEN_READ_VERSION	5
> > 
> > struct btintel_data {
> > 	unsigned long flags;
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 8c54ab03ee63..a64473c525eb 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
> > #define BTUSB_QCA_WCN6855	0x1000000
> > #define BTUSB_INTEL_NEWGEN	0x2000000
> > #define BTUSB_INTEL_COMBINED	0x4000000
> > +#define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
> > 
> > static const struct usb_device_id btusb_table[] = {
> > 	/* Generic Bluetooth USB device */
> > @@ -376,11 +377,14 @@ static const struct usb_device_id blacklist_table[] = {
> > 						     BTUSB_WIDEBAND_SPEECH |
> > 						     BTUSB_VALID_LE_STATES },
> > 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
> > -	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
> > -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
> > +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
> > +						     BTUSB_INTEL_BROKEN_READ_VERSION },
> > +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> > +						     BTUSB_INTEL_BROKEN_READ_VERSION },
> > 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
> > 						     BTUSB_WIDEBAND_SPEECH },
> > 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> > +						     BTUSB_INTEL_BROKEN_READ_VERSION |
> > 						     BTUSB_WIDEBAND_SPEECH },
> > 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
> > 						     BTUSB_WIDEBAND_SPEECH |
> 
> can you check that all 3 have this problem? Don’t we ever produced a ROM where this is fixed?

It looks like the early version of ROM (WP2) causes the problem. StP and SdP don't have the problem.
I will update accordingly.

WP2 - I only had mini-PCIe form factor card and it is broken.
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1                        #1 [hci0] 9.212217
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 13                                      #2 [hci0] 9.213338
      Intel Read Version (0x3f|0x0005) ncmd 0
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x07
        Hardware revision: 1.0
        Firmware variant: 0x01
        Firmware revision: 8.0
        Firmware build: 2-3.2013
        Firmware patch: 0

StP - OK. 
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1                      #3 [hci0] 108.053455
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 13                                    #4 [hci0] 108.054034
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x08
        Hardware revision: 1.0
        Firmware variant: 0x01
        Firmware revision: 1.0
        Firmware build: 3-17.2014
        Firmware patch: 0

SdP - OK.
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1                    #400 [hci0] 173.911992
        Requested Type:
          All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 13                                  #401 [hci0] 173.912576
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x08
        Hardware revision: 1.0
        Firmware variant: 0x22
        Firmware revision: 5.0
        Firmware build: 25-20.2015
        Firmware patch: 0


> 
> > @@ -4221,6 +4225,11 @@ static int btusb_probe(struct usb_interface *intf,
> > 
> > 	priv_size = 0;
> > 
> > +	if (id->driver_info & BTUSB_INTEL_COMBINED) {
> > +		/* Allocate extra space for Intel device */
> > +		priv_size += sizeof(struct btintel_data);
> > +	}
> > +
> 
> This needs to be in the previous patch.
> 
> Regards
> 
> Marcel
> 

