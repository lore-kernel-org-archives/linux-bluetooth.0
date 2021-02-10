Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E7C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 01:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8A764DD6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 01:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhBJB3e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 20:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhBJB13 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 20:27:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393CC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 17:26:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so320432plp.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=gs+gHQrNg6+DVzR0klBFT7OMX6Mwvn/RSJJ/ZJdGm4c=;
        b=FBsl+Mo1ci4ev840dVQg5MPFuxDspr3pFESPHzbdSaAjtwN8T4lrMgnhwOyCHNvjEM
         6W55x0NSapLd6777AIOTJLINWPZwldMoSm21vPYOCh26arwYjzEqSPeQUzrzraBfLlYm
         Iu4e4MqeTO3OKoD9w1d4yaJyCG5khUMbAatlurNZHg3nyKHscfykFzvCMzpqhL47IrYV
         ziEGZLJLWOILQfGdYNp5sSwUG9O/amDSqwsEgUGyYm8BD9/Z9f8O37gShACDLdQtE3AR
         nRIG8T673fiIEp/TFLZKsccD8Sk/T7fWiTCyfT6t3JBLTyHI+sTq/Yef2F/WIOmFxKeb
         XuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gs+gHQrNg6+DVzR0klBFT7OMX6Mwvn/RSJJ/ZJdGm4c=;
        b=htcvmTWKOgGZURCZwSlAxHw01K0iJgp9+6Ywaf7Wmvlfs9/XOdH3KKEmtd175JWbCa
         Hfg/AU187KcOXcsOcE2i2bD7s4iI4re+RtIxm0INb8RYtqZe73AJJRH+NYqHhhWrsCGW
         lT2Wr+887j+1t+bEnsYi6o1KsyeUifUsZfTK14/UpGXKB87WWxhhnLY3cgGMvPJ4m7xi
         82Q189AqlS8UohTppIN5tdixco+rmx1kWVSbStNoSzqujkbRL3FfDfAq1CT5Bi7BMd9B
         2cy8/RxK1CwlK1uCNJ8xjc5z+Ltm4gfoHyK+bMV+qQlWl4wTC8tY/NhKx09czw70uQSF
         YLXQ==
X-Gm-Message-State: AOAM531jYg3ghrFOVm3iAMUpO7nnAUCCHNMkrOwEsO5hPxnWXZXORous
        xTFYrFypdXJMNKF8DJ796Bs=
X-Google-Smtp-Source: ABdhPJzMQeCqDtC6xY5I7IXVivLopA7NN0lU7XDfbeVeOM+lxPr21J+m41TtJR2JzVtx+mdBHDDPHQ==
X-Received: by 2002:a17:902:9348:b029:e1:506a:7f67 with SMTP id g8-20020a1709029348b02900e1506a7f67mr619844plp.71.1612920408516;
        Tue, 09 Feb 2021 17:26:48 -0800 (PST)
Received: from han1-NUC8i7BEH ([2601:1c0:6a81:13a0:5b45:6c7b:391a:8fcf])
        by smtp.gmail.com with ESMTPSA id v31sm163201pgl.76.2021.02.09.17.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 17:26:47 -0800 (PST)
Message-ID: <2f3bf6dde215f4094404b377d8ad51b8b767cf3d.camel@gmail.com>
Subject: Re: [PATCH v3 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Feb 2021 17:26:47 -0800
In-Reply-To: <f689e973a5ac33516c57ebf647e78bcc1476670c.camel@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
         <f689e973a5ac33516c57ebf647e78bcc1476670c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz,

On Tue, 2021-02-09 at 17:04 -0800, Tedd Ho-Jeong An wrote:
> Hi Luiz,
> 
> On Tue, 2021-02-09 at 15:33 -0800, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > 
> > This checks the firmware build number, week and year matches with
> > repective version loaded and then skip the download process.
> > 
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > v2: Add patch that mover checks for operational mode after the version
> > checking.
> > v3: Fix not checking for operation mode before using btintel_read_boot_params
> > since some models depend on that to contruct the fw filename. Also attempt to
> > cleanup duplicated code.
> > 
> >  drivers/bluetooth/btintel.c   | 94 +++++++++++++++++++++++++++--------
> >  drivers/bluetooth/btintel.h   |  5 +-
> >  drivers/bluetooth/btusb.c     | 16 +++++-
> >  drivers/bluetooth/hci_intel.c |  7 ++-
> >  4 files changed, 96 insertions(+), 26 deletions(-)
> 
> Here is a quick test result after plug in the card to the USB, which is similar to "reboot" case:

This is not actually correct. I was using VM to test so the device was alrady running in
operational firmware.
Let me run on real hw and send the new result.

> 
> dmesg:
> [  380.993756] usb 1-2: new full-speed USB device number 6 using xhci_hcd
> [  381.441601] usb 1-2: New USB device found, idVendor=8087, idProduct=0025, bcdDevice= 0.02
> [  381.441614] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [  381.456056] btusb:btusb_probe:4418: intf 00000000daf5923a id 0000000054fbca43
> [  381.458813] btusb:btusb_open:1314: hci0
> [  381.458824] btusb:btusb_submit_intr_urb:886: hci0
> [  381.458902] btusb:btusb_submit_bulk_urb:976: hci0
> [  381.458935] btusb:btusb_submit_bulk_urb:976: hci0
> [  381.459006] btusb:btusb_setup_intel_new:2814: hci0
> [  381.459151] btusb:btusb_send_frame_intel:2347: hci0
> [  381.460077] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status 0 count 15
> [  381.460167] btusb:btusb_tx_complete:1266: hci0 urb 00000000d075e504 status 0 count 3
> [  381.460579] Bluetooth: hci0: Firmware revision 0.1 build 26 week 11 2020
> [  381.460685] btusb:btusb_send_frame_intel:2347: hci0
> [  381.461515] btusb:btusb_tx_complete:1266: hci0 urb 00000000eac374bf status 0 count 3
> [  381.461986] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status 0 count 12
> [  381.463058] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
> [  381.463283] btintel:btintel_firmware_version:991: hci0: Boot Address: 0xa100
> [  381.463291] btintel:btintel_firmware_version:994: hci0: Firmware Version: 0-0.0

I have noticed this line, which isn't correct. it is actually
Boot Parameters
Boot Address:	0x00040800
Firmware build:	26-11.2020

[  381.463401] btusb:btusb_send_frame_intel:2347: hci0
> [  381.464156] btusb:btusb_tx_complete:1266: hci0 urb 0000000005038ab1 status 0 count 11
> [  381.466847] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status -32 count 64
> [  381.494960] usb 1-2: USB disconnect, device number 6
> [  381.495216] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status -108 count 0
> [  381.495324] btusb:btusb_bulk_complete:931: hci0 urb 00000000f4141fb0 status -108 count 0
> [  381.495329] btusb:btusb_bulk_complete:931: hci0 urb 00000000a595df06 status -108 count 0
> [  381.495342] btusb:btusb_disconnect:4791: intf 00000000daf5923a
> 
> [  383.519564] Bluetooth: hci0: command 0xfc01 tx timeout
> [  391.555247] Bluetooth: hci0: FW download error recovery failed (-110)
> 
> [  391.555395] btusb:btusb_flush:1418: hci0
> [  391.555479] btusb:btusb_close:1384: hci0
> [  391.556244] btusb:btusb_disconnect:4791: intf 00000000ce1879b8
> 
> 
> Timeout from reset command. For hard reset, I don't think it sends the
> CommandComplete/CommandStatus
> events.
> 
> 
> < HCI Command: Intel Read Version (0x3f|0x0005) plen
> 0                                                           #1 [hci0] 9.028782
> > HCI Event: Command Complete (0x0e) plen
> 13                                                                     #2 [hci0] 9.029760
>       Intel Read Version (0x3f|0x0005) ncmd 1
>         Status: Success (0x00)
>         Hardware platform: 0x37
>         Hardware variant: 0x12
>         Hardware revision: 1.0
>         Firmware variant: 0x23
>         Firmware revision: 0.1
>         Firmware build: 26-11.2020
>         Firmware patch: 0
> < HCI Command: Read BD ADDR (0x04|0x0009) plen
> 0                                                                 #3 [hci0] 9.030334
> > HCI Event: Command Complete (0x0e) plen
> 10                                                                     #4 [hci0] 9.031668
>       Read BD ADDR (0x04|0x0009) ncmd 1
>         Status: Success (0x00)
>         Address: 9C:DA:3E:F2:8F:A4 (Intel Corporate)
> < HCI Command: Intel Reset (0x3f|0x0001) plen
> 8                                                                  #5 [hci0] 9.033055
>         Reset type: Hard software reset (0x01)
>         Patch vectors: Enable (0x01)
>         DDC parameters: Reload from OTP (0x01)
>         Boot option: Current image (0x00)
>         Boot address: 0x00000000
> = Close Index:
> 9C:DA:3E:F2:8F:A4                                                                                 
>   
> [hci0] 19.130135
> 
> 
> Regards,
> Tedd
> 

