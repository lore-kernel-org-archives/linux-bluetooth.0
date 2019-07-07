Return-Path: <SRS0=ATBr=VE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E5C0650E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 10:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1FE2070D
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHh6+Pk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGGKPB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jul 2019 06:15:01 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33109 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGGKPA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jul 2019 06:15:00 -0400
Received: by mail-lf1-f44.google.com with SMTP id x3so3017907lfc.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2019 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Oh1fXZhfyWzYcrolrM6zx/Cbtp1OXwYWyNc6+cIPkqo=;
        b=OHh6+Pk3IoyCuAjYzQ5zUo1dJAUWi35AlcG9gYkJRsXagg4pzjKP9ZXoTj811u0B8T
         hzQnPb5U49zvdhUgLVhziF+/WpOGwKb8afbsyn7LMpr0cc4l+JO6kKXYmHEBuOHhGxE9
         ztJuhFtDLkVrzLIbzCePArGVO/kYdvdYVPGeWex6lekRC0cL6T1nLiN5cdau8+4sgIFx
         2KT+vSIGYJJZ0L3nvHqPezaxcc5GlmYm1hY23iEp1eMCms2X6ZtoJggK4QwPX9b2kh31
         e608wX9DJEmVKaJFpg9UmuNCTSPJ/CHIyENv8zDcGV/evPOAkVWy5wEZjdC+wwubwrPK
         mm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Oh1fXZhfyWzYcrolrM6zx/Cbtp1OXwYWyNc6+cIPkqo=;
        b=mOEwV3K0yGwoVMbgps1NPktR5P2nA6wvB4flScTRYUxAST12akBI/WcH00fp9ja4a8
         99yREX0zugcJmSGdqotK1Df2rxHyi/upqrsAkx/R2u6QHpMOkQcaMsqGljzs2RQoKvs/
         Ul1dGP1DZgQ39h1HgQs6G7Ku82e5wwzra/9ncxCGtvbwWcCqkhMeuQ5/NHEO/+CiJLRP
         sUEcWdEpWcVzDFN4uDY/ajJBjUY+x4UF97beiCUY9O/t81n75tf47N7niMQM6ZrJk/H/
         I9czJ3K4A+kEtuKACg8UX7dC4OYSRlGy+/jTSKWHzgTicuhEC5hVZPtFyhqTsjp4LLE1
         0s5w==
X-Gm-Message-State: APjAAAUKbtyxUCdNPYc9h9EZhYAgKHC7N40STwWb9LoX8HR45h4L31Ji
        f42ZwJvJcbM37/nMPqdTWoc=
X-Google-Smtp-Source: APXvYqzop7vM1QrHMjTqdF3S11FfHN825wEO95JTHUHj7tisSYix4yj2/47GW3LbVr2nXj9ehf9r+g==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr6434231lfo.114.1562494497241;
        Sun, 07 Jul 2019 03:14:57 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id x18sm2240495lfe.42.2019.07.07.03.14.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 03:14:56 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: bluetoothctl: list-attributes doesn't list services from
 example-gatt-server
Message-ID: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
Date:   Sun, 7 Jul 2019 12:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have 2 notebooks with Bluetooth running bluez 5.30. I called them:
1) "elitebook" with controller 20:16:B9:D8:A9:3B
2) "matebook" with controller 38:BA:F8:3F:7C:A7

Normally, when I check elitebook from matebook I get this:

[elitebook]# info 20:16:B9:D8:A9:3B
Device 20:16:B9:D8:A9:3B (public)
         Name: elitebook
         Alias: elitebook
         Class: 0x001c010c
         Icon: computer
         Paired: yes
         Trusted: yes
         Blocked: no
         Connected: yes
         LegacyPairing: no
         UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
         UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
         UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
         UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
         UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
         UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
         UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
         UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
         UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
         UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
         UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
         UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
         UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
         UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
         Modalias: usb:v1D6Bp0246d0532

I decided to test GATT. On elitebook I started:
./test/example-gatt-server
and waited to let matebook refresh all info.

After that I got:

[elitebook]# info 20:16:B9:D8:A9:3B
Device 20:16:B9:D8:A9:3B (public)
         Name: elitebook
         Alias: elitebook
         Class: 0x001c010c
         Icon: computer
         Paired: yes
         Trusted: yes
         Blocked: no
         Connected: yes
         LegacyPairing: no
         UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
         UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
         UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
         UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
         UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
         UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
         UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
         UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
         UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
         UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
         UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
         UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
         UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
         UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
         UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
         UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
         UUID: Vendor specific           (12345678-1234-5678-1234-56789abcdef0)
         Modalias: usb:v1D6Bp0246d0532

That seems all correct for now. Test example-gatt-server registers
Heart Rate, Battery & Test services. All of them appeared as expected.

My problem is that I can't list GATT attributes. I don't any output.
Is there anything I'm doing incorrectly?

[elitebook]# menu gatt
Menu gatt:
Available commands:
-------------------
list-attributes [dev]                             List attributes
select-attribute <attribute/UUID>                 Select attribute
attribute-info [attribute/UUID]                   Select attribute
read [offset]                                     Read attribute value
write <data=xx xx ...> [offset]                   Write attribute value
acquire-write                                     Acquire Write file descriptor
release-write                                     Release Write file descriptor
acquire-notify                                    Acquire Notify file descriptor
release-notify                                    Release Notify file descriptor
notify <on/off>                                   Notify attribute value
register-application [UUID ...]                   Register profile to connect
unregister-application                            Unregister profile
register-service <UUID>                           Register application service.
unregister-service <UUID/object>                  Unregister application service
register-includes <UUID>                          Register as Included service in.
unregister-includes <Service-UUID><Inc-UUID>      Unregister Included service.
register-characteristic <UUID> <Flags=read,write,notify...>  Register application characteristic
unregister-characteristic <UUID/object>           Unregister application characteristic
register-descriptor <UUID> <Flags=read,write...>  Register application descriptor
unregister-descriptor <UUID/object>               Unregister application descriptor
back                                              Return to main menu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help                                              Display help about this program
export                                            Print evironment variables
[elitebook]# list-attributes
[elitebook]# list-attributes 20:16:B9:D8:A9:3B
