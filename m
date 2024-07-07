Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA937141
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jul 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371042; cv=none; b=epm78WSAo8D/vxF7pBffjmfcvrJE3Gj8aTMpHS9AQW+VN94Tp4e9S7lCqqcUzlKwRXma7CjguLOtWXx4CSSCnY47bGcecpe1wUbRoWqthYTZdzUH1NYuGv5vr9/Fw5eHeGMxeXQzPe4aShUuHBxNNVHbHW5HVikpidWFSaYdhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371042; c=relaxed/simple;
	bh=oNPqD/Y4tBYDQEM1KgmJpS4rtH5kQbCYwBubv0qtR2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ii2Nrn9WtHYgSOtDiW9LuFeld/WHz2PXjFaxEwia2ps25/XJv80jMNgtu/9qAUUHxPUJB7CLm8C4sLJ5bBc4lKBMhpumLepgEjhnLXdxCdO2K986fyIGYCN8PQ/j82l5o+KIUSmggOBsSSMR+9zPgO/+xkDg9IKENDvPNxPiH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEPPqL12; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEPPqL12"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77e5929033so116901566b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2024 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720371039; x=1720975839; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0dKYs+74Zq7cK3RyE8IxiF4wk3/5Y16clgqYV2WSSM4=;
        b=dEPPqL12S0HP/+MvlYUiyV3kKYN7s+98N9QKK8CHZiWvPvo1w/8JO98jtLrc9dHv/Q
         Zki3PPWUXsZ8grwFPm1NwqHawoIN/nr1p3lHEOMBslCoQw+fOL4ifTE/RK5Ywg5AbDcc
         5D7V68m1LRTPWO5sXV7gGq/8zXBfU4a7cj7MM3WEYGUxs5k3kaAZSCZpvlMRFb/dnRDC
         F6PaKtse8jHqdgor3Lw21umyPdggMlbh6kjYVCWgg3kwc7Mu6l+PFCxRpQCdkHSMFgy+
         8UHN1GAtR/B/M/t3RQXX/xWYYLnW5ipTFhlumF7cmgVjQyNYQkQUGFQ7cEvg6bRNKSgC
         FBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720371039; x=1720975839;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dKYs+74Zq7cK3RyE8IxiF4wk3/5Y16clgqYV2WSSM4=;
        b=JQ+gsgVh3tPrZHqekxUIN0i9dXK3cot71ZJRbEqPJAvsgRy6Ptogl+Ii/CG4A9C0UD
         zRFfvDRS7Fnp64rGm9MotLpL9eZzh6F2BKnvufyiIEJAT7EdPI7L8evookNwhP+BnyUB
         Lr4AT0qed63gpPP7TidpSMrSQM56VQxWNjUOuPflVlDa05ZdNYmZMNSVRWKv5gHQQh0i
         Cr5kwRh9b9OkGQLxdPx7GxiApMc01KAS6OaiYfrzJ6xgH1jt7u9YkcGhXwOLPnXloUxi
         iMIx8mepV12YsmMSju9Qv3ShRO2+CPnf+eR1/p2/lPQHP8D7yOv4XyKGm/gLqPxghzpN
         qF+Q==
X-Gm-Message-State: AOJu0YymBXFE91pB8giVluel4VkLfBUYWK4GVHBYFuExvyFteuxsNgda
	bYXNf+/ji0EOQy98/AG31v5TeqlYxoVVUB2/mQ+CSZpA64/GTK4ALbZmSOIaWQ/c38fhvzFjitb
	DzDX0jp3p0XwBKE6lywN6jIR7oNVXdFzY
X-Google-Smtp-Source: AGHT+IHzWTCjRh2V+m2azUVGTIVB9OouHFd5E/yaA409xbBK1MjnJhGksmOu5LRwdJVaWfXGIwUEHaXUpd9u9DuD+Ro=
X-Received: by 2002:a17:906:6c8a:b0:a77:e391:c10e with SMTP id
 a640c23a62f3a-a77e391c1b1mr222545366b.59.1720371038901; Sun, 07 Jul 2024
 09:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patrice Duroux <patrice.duroux@gmail.com>
Date: Sun, 7 Jul 2024 18:50:27 +0200
Message-ID: <CAGKjw9+40dSve_4u5RgUQUVXykESDsQ5kktOFN-EV-6o5NnUKQ@mail.gmail.com>
Subject: no longer able to connect to a Plantronics headset
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

In the past (same laptop and headset) it has worked but it is no more
working after upgrading my current system (more details to follow).
The device scanning is able to list a lot of devices in my environment
but not the desired one and finally I used btmon to get more output.

Any help would be appreciated.

Regards,
Patrice

--
$ uname -a
Linux kos-moceratops 6.9.7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.7-1
(2024-06-27) x86_64 GNU/Linux

$ sudo dmesg | grep -i blue
[   11.381833] Bluetooth: Core ver 2.22
[   11.381853] NET: Registered PF_BLUETOOTH protocol family
[   11.381854] Bluetooth: HCI device and connection manager initialized
[   11.381857] Bluetooth: HCI socket layer initialized
[   11.381859] Bluetooth: L2CAP socket layer initialized
[   11.381863] Bluetooth: SCO socket layer initialized
[   12.124487] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[   12.125484] Bluetooth: hci0: Device revision is 1
[   12.125486] Bluetooth: hci0: Secure boot is enabled
[   12.125487] Bluetooth: hci0: OTP lock is enabled
[   12.125488] Bluetooth: hci0: API lock is enabled
[   12.125489] Bluetooth: hci0: Debug lock is disabled
[   12.125489] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   12.128514] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[   12.128580] Bluetooth: hci0: Boot Address: 0x24800
[   12.128581] Bluetooth: hci0: Firmware Version: 132-3.24
[   12.194702] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.194705] Bluetooth: BNEP filters: protocol multicast
[   12.194707] Bluetooth: BNEP socket layer initialized
[   12.311050] Bluetooth: hci0: Failed to send firmware data (-19)
[   12.311087] Bluetooth: hci0: sending frame failed (-19)
[   12.311093] Bluetooth: hci0: FW download error recovery failed (-108)
[   12.311139] Bluetooth: hci0: sending frame failed (-19)
[   12.311154] Bluetooth: hci0: Reading supported features failed (-19)
[   12.311157] Bluetooth: hci0: Error reading debug features
[   12.311158] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
but its usage is not supported.
[12819.555606] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
[12819.556628] Bluetooth: hci0: Device revision is 1
[12819.556638] Bluetooth: hci0: Secure boot is enabled
[12819.556641] Bluetooth: hci0: OTP lock is enabled
[12819.556644] Bluetooth: hci0: API lock is enabled
[12819.556646] Bluetooth: hci0: Debug lock is disabled
[12819.556649] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[12819.564727] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
[12819.564776] Bluetooth: hci0: Boot Address: 0x24800
[12819.564777] Bluetooth: hci0: Firmware Version: 132-3.24
[12821.811205] Bluetooth: hci0: Waiting for firmware download to complete
[12821.811547] Bluetooth: hci0: Firmware loaded in 2194161 usecs
[12821.811732] Bluetooth: hci0: Waiting for device to boot
[12821.826744] Bluetooth: hci0: Device booted in 14765 usecs
[12821.827778] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
[12821.829646] Bluetooth: hci0: Applying Intel DDC parameters completed
[12821.830657] Bluetooth: hci0: Firmware revision 0.3 build 132 week 3 2024
[12821.832658] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
but its usage is not supported.
[12821.897877] Bluetooth: MGMT ver 1.22
[12821.927208] Bluetooth: RFCOMM TTY layer initialized
[12821.927213] Bluetooth: RFCOMM socket layer initialized
[12821.927215] Bluetooth: RFCOMM ver 1.11

$ sudo btmon
Bluetooth monitor ver 5.73
btmon[166569]: = Note: Linux version 6.9.7-amd64 (x86_64)

         0.917019
btmon[166569]: = Note: Bluetooth subsystem version 2.22

         0.917020
= New Index: 5C:80:B6:E9:D7:DD (Primary,USB,hci0)

  [hci0] 0.917021
= Open Index: 5C:80:B6:E9:D7:DD

  [hci0] 0.917021
= Index Info: 5C:80:B6:E9:D7:DD (Intel Corp.)

  [hci0] 0.917021
bluetoothd[166074]: @ MGMT Open: bluetoothd (privileged) version 1.22

{0x0001} 0.917022
> HCI Event: Connect Request (0x04) plen 10                                                                                                 #1 [hci0] 17.029619
        Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
        Class: 0x240404
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Wearable Headset Device
          Rendering (Printing, Speaker)
          Audio (Speaker, Microphone, Headset)
        Link type: ACL (0x01)
< HCI Command: Reject Connection Request (0x01|0x000a) plen 7
                                                                    #2
[hci0] 17.029727
        Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
        Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
> HCI Event: Command Status (0x0f) plen 4                                                                                                   #3 [hci0] 17.030438
      Reject Connection Request (0x01|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                                                                                #4 [hci0] 17.112704
        Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
        Handle: 65535
        Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)

<... cut repeating the same ...>
