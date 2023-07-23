Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069DC001B0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 23 Jul 2023 09:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGWJp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 Jul 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWJp0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 Jul 2023 05:45:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A93E6D
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jul 2023 02:45:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so26195735e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jul 2023 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690105523; x=1690710323;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoEqP9g4RnCV+rCQcPRVucKkzyAi7lOTpMtAx4H6NwI=;
        b=dn1K/Mrj7Jbm9TygDZ1s6+g2vM/ucfyfLrOYzH+t3f8BXIqHtMsGuYs9WYxc40hybi
         EOBbrBA+iVgQpsKBEB4zU1gQV5cuPqvWMapk2OsF0+XNtJCIXLw7hPRLBYZjz/Z571/f
         7vP32bf68EEc1YWgng9+0eQiOl8z7lDzcASz/G/MTPHEfl3C4+w+myG4Fvj/kEnI0gIE
         yF0Wq9ctdoZu3c3OdiVVlXdsI/kWVmMV73rykcUDiLRuiLgHQJJCJaUpQft0SvD2Pp0h
         0Bg93w5x9srZVZ+X56ZZa26zG08a+sCrrWw3fTCnrxl0ewRcZNKkfT/UG5qbt8sPeGZE
         4BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690105523; x=1690710323;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoEqP9g4RnCV+rCQcPRVucKkzyAi7lOTpMtAx4H6NwI=;
        b=V6DuVQLc1/39Vy+LayojOsh+/CVlXGLxNkh1fgeEwd4deqp9OoQzbWLk2xYCD/Bqe8
         eeLRqsdugpMBHnlbesY2/uBtitMtlBFUocCh+PLfhSGb2pHC1C0KJKE8+CjMgqCoHj3h
         zR3+96eeFL86iD55nw5Ay85Fx7tsNduiF7tkPNIuI14RK/Mn7ylINKxgNCzLaJqHMXlJ
         s9qLV3kyeAwktJNQ7J1vDri/q2nCe+YCe33A1JnW9IEE4m22y22WCz5td/pchCm4gM+0
         fW+FD5nkKrYeWNuPXnoEXt36Tcaa/tMkPLFdRHKNCaslKUxYNrN57a17vCqt1J8YDYsR
         uucw==
X-Gm-Message-State: ABy/qLaWzd+//91g0ttMFWgDDpegBcxaJzwUaGebYSLc0jg8vGvFjcKq
        aoZDIysIrDICE3hpvNF+wGhhwuFCXCE=
X-Google-Smtp-Source: APBJJlFR1YPoHqMSvYhzEmBl9zE7ctBJ08GNZpIlsNRUnbzGcB6ZP5/+6v1MaQS2+QEbKGmSJ4GC6A==
X-Received: by 2002:a05:600c:2316:b0:3fc:5a3:367c with SMTP id 22-20020a05600c231600b003fc05a3367cmr5428315wmo.32.1690105522777;
        Sun, 23 Jul 2023 02:45:22 -0700 (PDT)
Received: from ?IPV6:2a02:8440:a20a:4a73:67b:cbff:feb2:30bc? ([2a02:8440:a20a:4a73:67b:cbff:feb2:30bc])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d53cc000000b00313f9a0c521sm9150589wrw.107.2023.07.23.02.45.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 02:45:22 -0700 (PDT)
Message-ID: <a8f64e29-c36a-3a5f-4553-ccd71afaed78@gmail.com>
Date:   Sun, 23 Jul 2023 11:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] on T14s AMD Gen3: Bluetooth: hci0: Failed to send
 headers (or body or access otp area)
Content-Language: en-CA
From:   =?UTF-8?B?RnJhbsOnb2lz?= <fanf42@gmail.com>
To:     linux-bluetooth@vger.kernel.org
References: <977f687e-533f-ebce-a50c-2dde1e1adb99@gmail.com>
In-Reply-To: <977f687e-533f-ebce-a50c-2dde1e1adb99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

And sorry for the formating, it seems that I don't know how to tell 
thunderbird to send well formatted text message anymore. The logs can be 
seen better formatted at https://bbs.archlinux.org/viewtopic.php?id=286929


On 23/07/2023 11:10, François wrote:
> Hello,
>
> (Sorry by advance if it's not the correct place to discuss that, but I 
> tried other place like my distro kernel forum 
> (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive chat, 
> etc and nobody was able to help).
>
> [1] Short summary:
>
> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card 
> (which is actually reported by lspci as QCNFA765) and bluetooth never 
> worked on it, failing to load the rampatch with "failed to send 
> header" or "failed to send body" or "|Failed to access otp area (-71)"|.
>
> Other people reports bluetooth as working 
> (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3) 
> and a work friend has a T16 AMD gen1 which seems to have exactly the 
> same chipset and work flowlessly.
> And sorry for the formating, it seems that I don't know how to tell 
> thunderbird to send well formatted text message anymore. The logs can 
> be seen better formatted at 
> https://bbs.archlinux.org/viewtopic.php?id=286929
>
> => How can this be further qualified/debuged/workarounded?
>
> |Any help, even RTFM pointing to corresponding manuals would be very 
> much appreciated. |
>
> [2] logs and more details
>
> I have that laptop since october 2022 and use archlinux with the 
> standard kernels. None made bluetooth wroked since then, starting 
> around linux 6.0.10 and current kernel: 6.4.3-arch1-2.
>
> There is nothing obvious in bios setting that could lead to that 
> (bluetooth is enabled).
>
>
> # LSPCI
> lspci -k -s 01:00.0
> 01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 
> Wireless Network Adapter (rev 01)
>     Subsystem: Lenovo QCNFA765 Wireless Network Adapter
>     Kernel driver in use: ath11k_pci
>     Kernel modules: ath11k_pci
>
>
> # kernel boot log: "|Failed to send headers (-71)"|
> kernel: thinkpad_acpi: radio switch found; radios are enabled
> kernel: thinkpad_acpi: This ThinkPad has standard ACPI backlight 
> brightness control, supported by the ACPI video driver
> kernel: thinkpad_acpi: Disabling thinkpad-acpi brightness events by 
> default...
> kernel: thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is 
> unblocked
> ...
> rfkill[6774]: unblock set for type bluetooth
> sudo[6773]: pam_unix(sudo:session): session closed for user root
> kernel: usb 1-3.1: new full-speed USB device number 3 using xhci_hcd
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, 
> idProduct=9309, bcdDevice= 0.01
> kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=0
> boltd[935]: probing: started [1000]
> kernel: Bluetooth: Core ver 2.22
> kernel: NET: Registered PF_BLUETOOTH protocol family
> kernel: Bluetooth: HCI device and connection manager initialized
> kernel: Bluetooth: HCI socket layer initialized
> kernel: Bluetooth: L2CAP socket layer initialized
> kernel: Bluetooth: SCO socket layer initialized
> kernel: usbcore: registered new interface driver btusb
> systemd[1328]: Reached target Bluetooth.
> kernel: Bluetooth: hci0: using rampatch file: 
> qca/rampatch_usb_00130201.bin
> kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, 
> firmware rome 0x130201 build 0x38e6
> kernel: Bluetooth: hci0: Failed to send headers (-71)
> systemd[1]: Starting Bluetooth service...
> bluetoothd[6866]: Bluetooth daemon 5.66
> systemd[1]: Started Bluetooth service.
> systemd[1]: Reached target Bluetooth Support.
> bluetoothd[6866]: Starting SDP server
> bluetoothd[6866]: profiles/audio/vcp.c:vcp_init() D-Bus experimental 
> not enabled
> bluetoothd[6866]: src/plugin.c:plugin_init() Failed to init vcp plugin
> bluetoothd[6866]: profiles/audio/mcp.c:mcp_init() D-Bus experimental 
> not enabled
> bluetoothd[6866]: src/plugin.c:plugin_init() Failed to init mcp plugin
> bluetoothd[6866]: profiles/audio/bap.c:bap_init() D-Bus experimental 
> not enabled
> bluetoothd[6866]: src/plugin.c:plugin_init() Failed to init bap plugin
> kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> kernel: Bluetooth: BNEP filters: protocol multicast
> kernel: Bluetooth: BNEP socket layer initialized
> bluetoothd[6866]: Bluetooth management interface 1.22 initialized
> kernel: usb 1-3.1: USB disconnect, device number 3
> systemd[1328]: Stopped target Bluetooth.
> systemd[1]: Stopped target Bluetooth Support.
>
> # rfkill status
>
> sudo rfkill
> ID TYPE      DEVICE                   SOFT      HARD
>  0 bluetooth tpacpi_bluetooth_sw   blocked unblocked
>  1 wlan      phy0                unblocked unblocked

> rfkill[105640]: unblock set for type bluetooth
> sudo[105639]: pam_unix(sudo:session): session closed for user root
> kernel: usb 1-3.1: new full-speed USB device number 4 using xhci_hcd
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, 
> idProduct=9309, bcdDevice= 0.01
> kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=0
> kernel: Bluetooth: hci0: using rampatch file: 
> qca/rampatch_usb_00130201.bin
> kernel: Bluetooth: hci0: QCA: patch rome 0x130201 build 0x5073, 
> firmware rome 0x130201 build 0x38e6
> kernel: Bluetooth: hci0: Failed to send body at 40 of 142192 (-71)
> kernel: usb 1-3.1: USB disconnect, device number 4
> boltd[935]: probing: started [1000]
> systemd[1328]: Reached target Bluetooth.
> systemd[1328]: Stopped target Bluetooth.
> systemd[1]: Reached target Bluetooth Support.
> systemd[1]: Stopped target Bluetooth Support.

> # unloading and loading back kernel related modules (|bluetooth`, 
> `btusb`, etc) and modprobe them back, and I get the same kind of logs 
> after `rfkill unblock bluetoot`:
>
> rfkill[106483]: unblock set for type bluetooth
> sudo[106482]: pam_unix(sudo:session): session closed for user root
> kernel: usb 1-3.1: new full-speed USB device number 5 using xhci_hcd
> kernel: usb 1-3.1: New USB device found, idVendor=10ab, 
> idProduct=9309, bcdDevice= 0.01
> kernel: usb 1-3.1: New USB device strings: Mfr=0, Product=0, 
> SerialNumber=0
> kernel: usb 1-3.1: Failed to access otp area (-71)
> kernel: usb 1-3.1: USB disconnect, device number 5
> boltd[935]: probing: started [1000]
> systemd[1328]: Reached target Bluetooth.
> systemd[1]: Reached target Bluetooth Support.
> systemd[1328]: Stopped target Bluetooth.
> systemd[1]: Stopped target Bluetooth Support.
> boltd[935]: probing: timeout, done: [3001068] (2000000)
>
> |Have a nice day, |
>


-- 
François ARMAND

