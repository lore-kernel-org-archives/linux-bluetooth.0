Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E825BC001DE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jul 2023 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGWJK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWJK0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 05:10:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5091BD0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jul 2023 02:10:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so31708555e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jul 2023 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690103419; x=1690708219;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIgz/WejE2Tkcx7RgvRRkdtJp2X4BwZQlyo2QAGTz/o=;
        b=B/gUUf1uSjI/PB7NcXmXY4RHdDcEsWKIiQSqoviSMEAkf3Bx6f5+r2xAJB+CYnLXN1
         EpUSDe1QfjexIc6xktpWL7E1zSF1pdGLnM9RYAwzd1L66tZMIRQTrzsqLYGCLRk8gEMQ
         DZO6rzs42FmXxcCshUyycRwoAUdL5/GdRrC/nS+UNBLuRGVzt57rOmfqMgZT1giUELsA
         73Yzyr7ZjINO2vmvU4jmmXacZHhp+MpPdLe48gJQl02bH2A8EpJUYrFGqFhDVnv6urkM
         OR6x+FtYR94vPYNkNgyFSCqg0wqenqgvVdsUBr0h83MK634br5RcgenID8y8RJdB97dg
         /n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690103419; x=1690708219;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIgz/WejE2Tkcx7RgvRRkdtJp2X4BwZQlyo2QAGTz/o=;
        b=JOBzPnfZHwCGM1+VAq5X8i1rsdNzNzDekKaFqVywvwoNED/h0P2gSs12NUc4axbQdt
         UV3cbBqOSl4/j6fUa7e4rx7Eja/9Wq/g2qJ7U4ZG2kyF45U2XO3lAAlLM2jcOMUUCPQE
         5flKiNBPYA3FxaFEduJN8KCcxQzlyqnFDSps8+eGk6oGtmYLx5f7vgwUO6F+Lc3I/OZq
         OKJtxALw/sTqpCLBBtJucE6/7AehD1oOPuQDIqTZ5fnUU+HtMz8k4pT9oYW1oeddlBUs
         AALs9wTZRRc8Y+aFyHSX4XxH8ltGq16DTFZ9GVby43gAEvhy/UkA1yX5q5kggbm7Dlck
         MhwA==
X-Gm-Message-State: ABy/qLarXMfWVuUrpMlpQmzMjPqv1Xq2KO1bowPWW5VdXFTIkf+SGPVQ
        r8/iog8cx3js4Vx5UQOVkZIh/Wvl2UA=
X-Google-Smtp-Source: APBJJlFrF7KPO5DCrj1DSHsjr7SngCuGNWE0Bvy4VS9iZkH/O+h+mIEX5phK1iF+pSM4KvRnwdKIyg==
X-Received: by 2002:a7b:c84c:0:b0:3fb:ff8f:2db0 with SMTP id c12-20020a7bc84c000000b003fbff8f2db0mr5033142wml.39.1690103418695;
        Sun, 23 Jul 2023 02:10:18 -0700 (PDT)
Received: from ?IPV6:2a02:8440:a208:4532:67b:cbff:feb2:30bc? ([2a02:8440:a208:4532:67b:cbff:feb2:30bc])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003fa98908014sm9843843wmr.8.2023.07.23.02.10.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 02:10:18 -0700 (PDT)
Message-ID: <977f687e-533f-ebce-a50c-2dde1e1adb99@gmail.com>
Date:   Sun, 23 Jul 2023 11:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-bluetooth@vger.kernel.org
Content-Language: en-CA
From:   =?UTF-8?B?RnJhbsOnb2lz?= <fanf42@gmail.com>
Subject: [PROBLEM] on T14s AMD Gen3: Bluetooth: hci0: Failed to send headers
 (or body or access otp area)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

(Sorry by advance if it's not the correct place to discuss that, but I 
tried other place like my distro kernel forum 
(https://bbs.archlinux.org/viewtopic.php?id=286929), interactive chat, 
etc and nobody was able to help).

[1] Short summary:

I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card 
(which is actually reported by lspci as QCNFA765) and bluetooth never 
worked on it, failing to load the rampatch with "failed to send header" 
or "failed to send body" or "|Failed to access otp area (-71)"|.

Other people reports bluetooth as working 
(https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3) and 
a work friend has a T16 AMD gen1 which seems to have exactly the same 
chipset and work flowlessly.

=> How can this be further qualified/debuged/workarounded?

|Any help, even RTFM pointing to corresponding manuals would be very 
much appreciated. |

[2] logs and more details

I have that laptop since october 2022 and use archlinux with the 
standard kernels. None made bluetooth wroked since then, starting around 
linux 6.0.10 and current kernel: 6.4.3-arch1-2.

There is nothing obvious in bios setting that could lead to that 
(bluetooth is enabled).


# LSPCI

|spci -k -s 01:00.0 01:00.0 Network controller: Qualcomm Technologies, 
Inc QCNFA765 Wireless Network Adapter (rev 01) Subsystem: Lenovo 
QCNFA765 Wireless Network Adapter Kernel driver in use: ath11k_pci 
Kernel modules: ath11k_pci|


# kernel boot log: "|Failed to send headers (-71)"|

|kernel: thinkpad_acpi: radio switch found; radios are enabled kernel: 
thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness 
control, supported by the ACPI video driver kernel: thinkpad_acpi: 
Disabling thinkpad-acpi brightness events by default... kernel: 
thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked ... 
rfkill[6774]: unblock set for type bluetooth sudo[6773]: 
pam_unix(sudo:session): session closed for user root kernel: usb 1-3.1: 
new full-speed USB device number 3 using xhci_hcd kernel: usb 1-3.1: New 
USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 kernel: 
usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 
boltd[935]: probing: started [1000] kernel: Bluetooth: Core ver 2.22 
kernel: NET: Registered PF_BLUETOOTH protocol family kernel: Bluetooth: 
HCI device and connection manager initialized kernel: Bluetooth: HCI 
socket layer initialized kernel: Bluetooth: L2CAP socket layer 
initialized kernel: Bluetooth: SCO socket layer initialized kernel: 
usbcore: registered new interface driver btusb systemd[1328]: Reached 
target Bluetooth. kernel: Bluetooth: hci0: using rampatch file: 
qca/rampatch_usb_00130201.bin kernel: Bluetooth: hci0: QCA: patch rome 
0x130201 build 0x5073, firmware rome 0x130201 build 0x38e6 kernel: 
Bluetooth: hci0: Failed to send headers (-71) systemd[1]: Starting 
Bluetooth service... bluetoothd[6866]: Bluetooth daemon 5.66 systemd[1]: 
Started Bluetooth service. systemd[1]: Reached target Bluetooth Support. 
bluetoothd[6866]: Starting SDP server bluetoothd[6866]: 
profiles/audio/vcp.c:vcp_init() D-Bus experimental not enabled|

# rfkill status

|sudo rfkill ID TYPE DEVICE SOFT HARD 0 bluetooth tpacpi_bluetooth_sw 
blocked unblocked 1 wlan phy0 unblocked unblocked # when trying to 
unlock: "failed to se||nd body at 40 of ||142192 (-71)"|||

|rfkill[105640]: unblock set for type bluetooth sudo[105639]: 
pam_unix(sudo:session): session closed for user root kernel: usb 1-3.1: 
new full-speed USB device number 4 using xhci_hcd kernel: usb 1-3.1: New 
USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 kernel: 
usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 
kernel: Bluetooth: hci0: using rampatch file: 
qca/rampatch_usb_00130201.bin kernel: Bluetooth: hci0: QCA: patch rome 
0x130201 build 0x5073, firmware rome 0x130201 build 0x38e6 kernel: 
Bluetooth: hci0: Failed to send body at 40 of 142192 (-71) kernel: usb 
1-3.1: USB disconnect, device number 4 boltd[935]: probing: started 
[1000] systemd[1328]: Reached target Bluetooth. systemd[1328]: Stopped 
target Bluetooth. systemd[1]: Reached target Bluetooth Support. 
systemd[1]: Stopped target Bluetooth Support. # unloading and loading 
back kernel related modules (|bluetooth`, `btusb`, etc) and modprobe them back, and I get the same kind of logs after `rfkill unblock bluetoot`:

|rfkill[106483]: unblock set for type bluetooth sudo[106482]: 
pam_unix(sudo:session): session closed for user root kernel: usb 1-3.1: 
new full-speed USB device number 5 using xhci_hcd kernel: usb 1-3.1: New 
USB device found, idVendor=10ab, idProduct=9309, bcdDevice= 0.01 kernel: 
usb 1-3.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0 
kernel: usb 1-3.1: Failed to access otp area (-71) kernel: usb 1-3.1: 
USB disconnect, device number 5 boltd[935]: probing: started [1000] 
systemd[1328]: Reached target Bluetooth. systemd[1]: Reached target 
Bluetooth Support. systemd[1328]: Stopped target Bluetooth. systemd[1]: 
Stopped target Bluetooth Support. boltd[935]: probing: timeout, done: 
[3001068] (2000000)|

|Have a nice day, |

-- 
François ARMAND

