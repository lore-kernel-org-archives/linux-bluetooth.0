Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C810BC73C42
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75020861
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd6wiijh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGIMOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:14:12 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35890 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfGIMOL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 08:14:11 -0400
Received: by mail-lj1-f178.google.com with SMTP id i21so19347543ljj.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 05:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vogCuJAB6KE5xKRg3WODS+hWFr72Sp+76GmzsjR59X4=;
        b=Nd6wiijhZDj3EreZVnB0jFGjfjlgv9aRByBPU2Bi62GmblXWrX7reM7R2TiMKrX74t
         uc6Gb5rInOVrqvA6qoX0wjg+qVMRPI8HJbF6s7S2GK45A3GAbz5iyL0pLkhjR8xaBQDL
         f7g4zf577eMGufsoqZjvyTqOh7+FOTq6oYjTnmj6omeML1U0s4p39XSHK3oMa1+s8VtF
         WubYnpqcGwgQ9TTP35bW/ztDBik+n6VY9Yd7oiO1ny8R29tQFOfOq2EQe77qX+Ul6EiM
         gNBtAGQrTx9bktO7cRnk1DXtjHeeRNYwb5abHsHTQuj+sS1gn4BmWWhIpKgRZRqrSNfZ
         Sr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vogCuJAB6KE5xKRg3WODS+hWFr72Sp+76GmzsjR59X4=;
        b=isKLn1tPFvaLwQYqI9WzCrVy9Tp8oHBmPCSosRVeKHqovDJU5R+IWeJVIOZf5kwJHC
         SxiWhtHHou1phTm2ubp5t9WSTEH44/IENXo6nBsLbgAkONTCX0APBKl2ucfqRlfb71tO
         G4bcQ+UyXVKCRuth7a0p/gidhB1uMA7YWBlD+NRi89xg5QKmcoBXRspmXVR3Z7DbK1bv
         +i8mUZFqLBIpFw2doXFo9dJjKWmUW8P2Ixn+qr2SvRmUmXX0k2v3U4y5cRTQjjv3rZsn
         ku+FOZhdi5ggK6MeLyITF2xHDC8M3Lslq9DyyWurffBKpCLTskkzx9sjc65Ba+gOZLPf
         9giw==
X-Gm-Message-State: APjAAAUl8DLUvbYtSkaU9eTh28RjXRUK2bpK4BfZHvQBPiqW2NOBjlqF
        i16hCusPotJXigzDzA2kh/A=
X-Google-Smtp-Source: APXvYqwCVfy7OZ/2gtuh1I4ztaRYOrYLmTN7lhLApM/vSH96Lqr31FxhX6Sypt9K6D3wnT3QHAilTA==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr14088869ljg.167.1562674449689;
        Tue, 09 Jul 2019 05:14:09 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h1sm2889017lfj.21.2019.07.09.05.14.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 05:14:08 -0700 (PDT)
Subject: Re: bluetoothctl: list-attributes doesn't list services from
 example-gatt-server
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     linux-bluetooth@vger.kernel.org
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
Message-ID: <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com>
Date:   Tue, 9 Jul 2019 14:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07.07.2019 12:14, Rafał Miłecki wrote:
> I decided to test GATT. On elitebook I started:
> ./test/example-gatt-server
> and waited to let matebook refresh all info.
> 
> After that I got:
> 
> [elitebook]# info 20:16:B9:D8:A9:3B
> Device 20:16:B9:D8:A9:3B (public)
>          Name: elitebook
>          Alias: elitebook
>          Class: 0x001c010c
>          Icon: computer
>          Paired: yes
>          Trusted: yes
>          Blocked: no
>          Connected: yes
>          LegacyPairing: no
>          UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
>          UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
>          UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
>          UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
>          UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>          UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
>          UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
>          UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
>          UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>          UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
>          UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>          UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
>          UUID: Vendor specific           (12345678-1234-5678-1234-56789abcdef0)
>          Modalias: usb:v1D6Bp0246d0532
> 
> That seems all correct for now. Test example-gatt-server registers
> Heart Rate, Battery & Test services. All of them appeared as expected.
> 
> My problem is that I can't list GATT attributes. I don't any output.
> Is there anything I'm doing incorrectly?

I decided to test nRF Connect Android app. It showed something
interesting about my bluetooth devices. It nicely displays & parses
advertising data.

Logitech M590 advertises:
0x01 Flags
0x03 Complete List of 16-bit Service Class UUIDs
0x09 Complete Local Name
0x0A Tx Power Level
0x19 Appearance

BlueZ on "elitebook" advertises:
0xFF Manufacturer Specific Data
or to say precisely:
0x1BFF750042040180AE78BDBC0B7E307ABDBC0B7E2F01000000000000

Any idea/hint why BlueZ 5.30 on my "elitebook" notebook doesn't
advertise more data?
