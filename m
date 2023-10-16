Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE4C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 13:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjJPNkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjJPNjy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 09:39:54 -0400
X-Greylist: delayed 2525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 06:39:48 PDT
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2ED63
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 06:39:47 -0700 (PDT)
Received: from localhorst ([127.0.0.1])
         by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
         (Exim 4.94.2)
        (envelope-from <michael.hunold@eu.panasonic.com>)
         id 1qsN84-0004FR-JZ ; Mon, 16 Oct 2023 14:55:28 +0200
From:   Michael Hunold <michael.hunold@eu.panasonic.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Hunold <michael.hunold@eu.panasonic.com>
Subject: [PATCH 0/1] Make initialization work for newer versions of TI CC2564
Date:   Mon, 16 Oct 2023 14:55:25 +0200
Message-Id: <20231016125526.749848-1-michael.hunold@eu.panasonic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

My company recently released a new evaluation kit for the Panasonic PAN1326C2 Bluetooth module which is based on the revision B of the CC2564C chipset ("C2") from Texas Instruments.

This evaluation kit has a built-in USB-to-serial adapter, which makes it easy to attach it to any Linux-bases system and add Bluetooth functionality to it.

The CC2564 family is very well supported by BlueZ for years now, however this variant of the chipset does not work out-of-the-box.

You are probably well aware that these devices require a so-called initscript to be uploaded using vendor-specific HCI commands. For this "hciattach" has the special "texas" parameter and the necessary code for this special handling is in bluez/tools/hciattach_ti.c

CC2464C revision B requires the TIInit_6.12.26.bts initscript which can be obtained from https://git.ti.com/cgit/ti-bt/service-packs/tree/initscripts and has to be stored at /lib/firmware/ti-connectivity/ Usually you use something like hciattach -n /dev/ttyUSB0 texas 115200 in order to initialize a CC2564-based to be used in conjunction with BlueZ.

This works fine for earlier variants of CC2564, but not with CC2564C revision B. The initialization procedure seems to start, but stops at a certain point and the following error message is shown:

> Cannot send hci command to socket: Connection timed out

It seems that this problem is already known in the community for a long time, because it is described in the following thread in the Texas Instruments Bluetooth forum: https://e2e.ti.com/support/wireless-connectivity/bluetooth-group/bluetooth/f/bluetooth-forum/375766/can-t-init-device-cc2564b

It boils down to call to hci_send_req() in the function brf_send_command_socket() in bluez/tools/hciattach_ti.c.

> if (hci_send_req(fd, &rq, 15) < 0) {
>	perror("Cannot send hci command to socket");
>	return -1;
> }

The number 15 is a timeout value in milliseconds that in the end is passed down to a call to poll() on the file descriptor for the serial device.

I traced all the calls to brf_send_command_socket() and matched them with the commands that are included in the initscript.

The initial upload of some big vendor-specific data using the vendor-specific Send_HCI_VS_Write_Memory_Block command is working fine. Later in the script two calls to Send_HCI_VS_Read_Modify_Write_Hardware_Register() are done and it is always the second call that times out.

As described in the forum thread it seems that the CC2564C revision B (and already some earlier variants) take more than 15 milliseconds to complete these vendor-specific commands.

I verified that the solution to increase the timeout time from 15ms to something bigger actually works. By trial-and-error I could find out that starting with 20ms everything starts working fine again.

The original code was added approx. 15 years ago with the following commit: https://github.com/bluez/bluez/commit/14f84d602a7584f0805c93ae9ad1bd26e2387f6d

I think there is no way to find out today why 15 milliseconds were chosen as a timeout value at that time. From the way I understand the code it should not matter if a (way) higher timeout value is used here. If the low-level HCI command is successful it will return as quickly as possible and if there is an error, it will timeout no matter what.

So my suggestion is to increase the timeout value to something reasonable like 100ms instead.

I am aware that this patch is for the hciattach tool which is already deprecated and is not built by default any more. However, hciattach is the only tool to start and initialize the CC2564 series correctly under Linux and I guess it is still used by the people that use the CC2564 device under Linux.

Michael Hunold (1):
  tools/hciattach: Increase timeout for TI-specific initialization

 tools/hciattach_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

