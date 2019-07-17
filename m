Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F5C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED1920665
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZrjvKPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfGQJi0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:38:26 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:38863 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfGQJi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 05:38:26 -0400
Received: by mail-lf1-f42.google.com with SMTP id h28so15909816lfj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5NuU1oZ+pYLE3e4fZm4g8S6uFETmTfninuSzeFp/9QQ=;
        b=JZrjvKPxZHIm7+yEWF3h1XvnzHhT8wuoP2Qy9dZOxzR6QlKsLKm7qJFqyJ7PpFsBQs
         jlvVrnbb5jlVzE8LWn2bOMUcMZVaLO3/ONYLeLVkmoTMppcbNwWyBbiJgTokmv+edjNj
         Z1VZ66TTvodZJvnxss/1crSdXJfDkDdJcCAdvDZM0iAQ2gSSztfthtsS022tCXhFx0P0
         DeO0yMvtvhmI9+crUUq0czyKMcuqo3Mrs1RB4QgbjBZWuI05CXLAJrrDXE331sUaiWsF
         QckXN3lpwPBPLHFa3Tw1PvcTsE1koPjpmpxRmkGPhXHgrqbtLI+Dlakced6vNn11t34t
         P+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NuU1oZ+pYLE3e4fZm4g8S6uFETmTfninuSzeFp/9QQ=;
        b=IlR6cwnddLDXiahk0tAFdev+UENGi20VhoE+53VbcQxHxVDAwZjKrZxjehWWpaPuL1
         BOlxv2m0tZgSEg5Muf5uzyFU0CE99s3i7DLIYhdrSwxcws6LyCRIFxb64i6/KrMT9q3u
         EYyrcDBl1X3caNfVJ5GTi1w5wJDLP68xheFEPWlct4/bFQq581TQUPLRrNDnIEhCACnQ
         24jXZpogGI+J+J5ZbuJgNJosD/z1WCdwvwvrVUVDwAYcecCFBvZMSVXcx9BR1CqNNWS1
         6flbUWFBjqGJAXA0KPwtKtgyCUysbSQRGV9doyLU2PK+canl82c4TNgmB79cOD8BdFz4
         l6tQ==
X-Gm-Message-State: APjAAAXtwCfMzyReCC5sY07buNNCrZo+5ZK6MpG1P+24y+H4E4i1qL4N
        YudLGDlUI6xN68qfWd3uqyryomQR
X-Google-Smtp-Source: APXvYqyc+oItG6m/zx0jA6XQTJAfYINk4Pjz1tW7yBtj7uWC2UUe9ssarZ5k18orMpuKk429XLdDxg==
X-Received: by 2002:ac2:465e:: with SMTP id s30mr3304584lfo.19.1563356303558;
        Wed, 17 Jul 2019 02:38:23 -0700 (PDT)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h129sm3333933lfd.74.2019.07.17.02.38.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 02:38:22 -0700 (PDT)
Subject: Re: bluetoothctl: list-attributes doesn't list services from
 example-gatt-server
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     linux-bluetooth@vger.kernel.org
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
 <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com>
Message-ID: <84f01445-74e2-5632-225a-02c369c53c07@gmail.com>
Date:   Wed, 17 Jul 2019 11:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 09.07.2019 14:14, Rafał Miłecki wrote:
> On 07.07.2019 12:14, Rafał Miłecki wrote:
>> I decided to test GATT. On elitebook I started:
>> ./test/example-gatt-server
>> and waited to let matebook refresh all info.
>>
>> After that I got:
>>
>> [elitebook]# info 20:16:B9:D8:A9:3B
>> Device 20:16:B9:D8:A9:3B (public)
>>          Name: elitebook
>>          Alias: elitebook
>>          Class: 0x001c010c
>>          Icon: computer
>>          Paired: yes
>>          Trusted: yes
>>          Blocked: no
>>          Connected: yes
>>          LegacyPairing: no
>>          UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
>>          UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
>>          UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
>>          UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
>>          UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>>          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>>          UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
>>          UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
>>          UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
>>          UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
>>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>>          UUID: Heart Rate                (0000180d-0000-1000-8000-00805f9b34fb)
>>          UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>>          UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
>>          UUID: Vendor specific           (12345678-1234-5678-1234-56789abcdef0)
>>          Modalias: usb:v1D6Bp0246d0532
>>
>> That seems all correct for now. Test example-gatt-server registers
>> Heart Rate, Battery & Test services. All of them appeared as expected.
>>
>> My problem is that I can't list GATT attributes. I don't any output.
>> Is there anything I'm doing incorrectly?
> 
> I decided to test nRF Connect Android app. It showed something
> interesting about my bluetooth devices. It nicely displays & parses
> advertising data.
> 
> Logitech M590 advertises:
> 0x01 Flags
> 0x03 Complete List of 16-bit Service Class UUIDs
> 0x09 Complete Local Name
> 0x0A Tx Power Level
> 0x19 Appearance
> 
> BlueZ on "elitebook" advertises:
> 0xFF Manufacturer Specific Data
> or to say precisely:
> 0x1BFF750042040180AE78BDBC0B7E307ABDBC0B7E2F01000000000000
> 
> Any idea/hint why BlueZ 5.30 on my "elitebook" notebook doesn't
> advertise more data?

I've discovered I also need to run test/example-advertisement. Then I
can see my notebook advertise UUIDs and characteristics. It seems that
test/example-gatt-server is insufficient on its own.
