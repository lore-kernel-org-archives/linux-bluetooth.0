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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B2264DEE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhBJBHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 20:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhBJBFb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 20:05:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21095C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 17:04:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d13so298112plg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=+zwTYhXXQzYlEFJDGm/iULPT4qs4qMa7Gbkq/G+utGA=;
        b=sY/QR2LUGZCG/ydEUMqY5/eQd+WTzadkzYV6cEHkOzK1hI7iSc6/M+8sOeY1hKfWlR
         XvLDA+CPx5Wj+qMxHDh5FxEy3yjvvUwLe98GzPOI0uwHOjCx/SBiG3/sdz4aWMefGGVP
         KiCWivHKkeFV6CAhP9/uJN+0TLr4x36C5t97SyRSJBQD6fF///DV07ScB4Mdry/tV8Sd
         AJC7H9dXVeT9qMlWrjWcw0o44/SsbmjcKz6X7Y8sg4rEOA3lw7zjF7c89dgYTZRRZNBW
         tzo03fulDVjexpSqrVtdQpnCjmlFTpO6IKcQBOIKd1kFQRDsleUUic8RQnAoq+uTAT0V
         kc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+zwTYhXXQzYlEFJDGm/iULPT4qs4qMa7Gbkq/G+utGA=;
        b=Olih/ujrJSbuYVYZwqMfUhQCYAhcLqZYwzJG/vXKV+3vZM0z5aWgNbdm0SVlLF3O6/
         v3YXUSDLlQENOE/jWQO6iR1FjrFKOy7NjWAuyzI1pjr1FVj3FK5z/RDHUGItTCxqWHBc
         CrgVKocELBRF5HhrrhzKL+Vj6u5TJw46Z8GafNXYRRb0H3VfT8HTGAhzl/kWWIzdodWC
         bLeWGZA6w3x7ZA8knupoe9Yl4J/LV5lNVWa47PATYuDcJ5NR81tev1ohae4CYi7mvsGJ
         7zfK1eCvO3a6q78sO+yIyX+6ryfbIaZlwSCY5ON9NqD6QpF+GN4eLkOMs+u92rcReNP2
         WlGw==
X-Gm-Message-State: AOAM530MCOl5OX8hIraTCsOEl/CpSCmaws+eJoZZLgurgc3aZobfkaJl
        Oh68/qq8HmgF1/rWvOQEM5VsE+De31rSog==
X-Google-Smtp-Source: ABdhPJyjOruvBuq4AjsjZZseLD0gWZ0Wk0bC36gtuSxDuqF+AJsrQd3+3Og8RRAMIxFwCvQyLv4uXQ==
X-Received: by 2002:a17:902:cec3:b029:de:901b:d0be with SMTP id d3-20020a170902cec3b02900de901bd0bemr484593plg.26.1612919090660;
        Tue, 09 Feb 2021 17:04:50 -0800 (PST)
Received: from han1-NUC8i7BEH ([2601:1c0:6a81:13a0:5b45:6c7b:391a:8fcf])
        by smtp.gmail.com with ESMTPSA id w124sm123064pfw.176.2021.02.09.17.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 17:04:50 -0800 (PST)
Message-ID: <f689e973a5ac33516c57ebf647e78bcc1476670c.camel@gmail.com>
Subject: Re: [PATCH v3 1/6] Bluetooth: btintel: Check firmware version
 before download
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Feb 2021 17:04:49 -0800
In-Reply-To: <20210209233404.2121960-1-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 2021-02-09 at 15:33 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This checks the firmware build number, week and year matches with
> repective version loaded and then skip the download process.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> v2: Add patch that mover checks for operational mode after the version
> checking.
> v3: Fix not checking for operation mode before using btintel_read_boot_params
> since some models depend on that to contruct the fw filename. Also attempt to
> cleanup duplicated code.
> 
>  drivers/bluetooth/btintel.c   | 94 +++++++++++++++++++++++++++--------
>  drivers/bluetooth/btintel.h   |  5 +-
>  drivers/bluetooth/btusb.c     | 16 +++++-
>  drivers/bluetooth/hci_intel.c |  7 ++-
>  4 files changed, 96 insertions(+), 26 deletions(-)

Here is a quick test result after plug in the card to the USB, which is similar to "reboot" case:

dmesg:
[  380.993756] usb 1-2: new full-speed USB device number 6 using xhci_hcd
[  381.441601] usb 1-2: New USB device found, idVendor=8087, idProduct=0025, bcdDevice= 0.02
[  381.441614] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  381.456056] btusb:btusb_probe:4418: intf 00000000daf5923a id 0000000054fbca43
[  381.458813] btusb:btusb_open:1314: hci0
[  381.458824] btusb:btusb_submit_intr_urb:886: hci0
[  381.458902] btusb:btusb_submit_bulk_urb:976: hci0
[  381.458935] btusb:btusb_submit_bulk_urb:976: hci0
[  381.459006] btusb:btusb_setup_intel_new:2814: hci0
[  381.459151] btusb:btusb_send_frame_intel:2347: hci0
[  381.460077] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status 0 count 15
[  381.460167] btusb:btusb_tx_complete:1266: hci0 urb 00000000d075e504 status 0 count 3
[  381.460579] Bluetooth: hci0: Firmware revision 0.1 build 26 week 11 2020
[  381.460685] btusb:btusb_send_frame_intel:2347: hci0
[  381.461515] btusb:btusb_tx_complete:1266: hci0 urb 00000000eac374bf status 0 count 3
[  381.461986] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status 0 count 12
[  381.463058] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[  381.463283] btintel:btintel_firmware_version:991: hci0: Boot Address: 0xa100
[  381.463291] btintel:btintel_firmware_version:994: hci0: Firmware Version: 0-0.0
[  381.463401] btusb:btusb_send_frame_intel:2347: hci0
[  381.464156] btusb:btusb_tx_complete:1266: hci0 urb 0000000005038ab1 status 0 count 11
[  381.466847] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status -32 count 64
[  381.494960] usb 1-2: USB disconnect, device number 6
[  381.495216] btusb:btusb_intr_complete:841: hci0 urb 00000000fba620cd status -108 count 0
[  381.495324] btusb:btusb_bulk_complete:931: hci0 urb 00000000f4141fb0 status -108 count 0
[  381.495329] btusb:btusb_bulk_complete:931: hci0 urb 00000000a595df06 status -108 count 0
[  381.495342] btusb:btusb_disconnect:4791: intf 00000000daf5923a

[  383.519564] Bluetooth: hci0: command 0xfc01 tx timeout
[  391.555247] Bluetooth: hci0: FW download error recovery failed (-110)

[  391.555395] btusb:btusb_flush:1418: hci0
[  391.555479] btusb:btusb_close:1384: hci0
[  391.556244] btusb:btusb_disconnect:4791: intf 00000000ce1879b8


Timeout from reset command. For hard reset, I don't think it sends the CommandComplete/CommandStatus
events.


< HCI Command: Intel Read Version (0x3f|0x0005) plen
0                                                           #1 [hci0] 9.028782
> HCI Event: Command Complete (0x0e) plen
13                                                                     #2 [hci0] 9.029760
      Intel Read Version (0x3f|0x0005) ncmd 1
        Status: Success (0x00)
        Hardware platform: 0x37
        Hardware variant: 0x12
        Hardware revision: 1.0
        Firmware variant: 0x23
        Firmware revision: 0.1
        Firmware build: 26-11.2020
        Firmware patch: 0
< HCI Command: Read BD ADDR (0x04|0x0009) plen
0                                                                 #3 [hci0] 9.030334
> HCI Event: Command Complete (0x0e) plen
10                                                                     #4 [hci0] 9.031668
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 9C:DA:3E:F2:8F:A4 (Intel Corporate)
< HCI Command: Intel Reset (0x3f|0x0001) plen
8                                                                  #5 [hci0] 9.033055
        Reset type: Hard software reset (0x01)
        Patch vectors: Enable (0x01)
        DDC parameters: Reload from OTP (0x01)
        Boot option: Current image (0x00)
        Boot address: 0x00000000
= Close Index:
9C:DA:3E:F2:8F:A4                                                                                   
[hci0] 19.130135


Regards,
Tedd

