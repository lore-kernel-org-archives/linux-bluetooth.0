Return-Path: <SRS0=Wjv6=RP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1438C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 10:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D828206DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Mar 2019 10:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5RKM3LV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfCLKjn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:39:43 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46705 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLKjn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Mar 2019 06:39:43 -0400
Received: by mail-wr1-f51.google.com with SMTP id i16so2052473wrs.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2019 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sVQefnVEp4L+nh4LjO45AvIgIb2bj3mXXfGEpDBvulo=;
        b=c5RKM3LVsIeJ8pj1ZsNGJrzQFtxNa0WCkX51fTk7XXU1oQ6d6lI8UZawchm5AE4X7Q
         mx/w4gGQQ+oAkzS5wAjM1arHbuhubA5oFKD9jg4vhIiMLsJv8ohYoTa9m2Gw/XPqyR/s
         07bGnTZ3vHdTxVercrC477OM4e4x+tgXIOx/0YLAtEeuQYgI73caqbOPMHQUShjwpquz
         B11zS1uHsmyaAdIqWPL6RghUKIa2PHa2WXOu8EO7pIPBeqnt7YreBVpZba/n+iT7xk1l
         imJAgF9CygdinOZroccbS09o42e5MT9gDQD9D6UFnqx3mJumd2gg/eKxM8LoTeXrX/be
         ZWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sVQefnVEp4L+nh4LjO45AvIgIb2bj3mXXfGEpDBvulo=;
        b=rP12KaXgStvZjYJDjPqIIBoqDhzLBjowPV9k32Sry0isq2C3vSvRuzuwy4b/Ra5XJC
         notc/mbPSx0frZkQgT/xs18kYLjlPfK9zVeNbnrkCuHvSSR7n756o+jJ9C+8dGtlewNx
         9T2qlRTq2vG7ImO/zLPckyyZPtTFW6pP6R1Xhin/j2J3uLoHtc/1xfWcAOtuEo6SxIxK
         ef12n3tFIkbo8/qhwQya6/qGZhqyYivxeblTG/jrMqOiREkCFcxUH+F+5tfuBKAvM6NI
         e1NbmbLG3CIS0nEqnlhvoJ6t+1FZhrXaIzK5OgkCxx0M29abgrb6zZpnHiJKRh7sxl1a
         qyuQ==
X-Gm-Message-State: APjAAAXlCNiWA53rl7AdRZmVEbdUd9gZMJARlwIlhZpkEnHpsMTEziJX
        Ll9lIrZX8+WNzA8X9zua41E1IEbcOrQ=
X-Google-Smtp-Source: APXvYqxjPFK8w6H5sB7QphoLXr0328aT5QUYX0M3HPLJFyNFAT9OHtNLzidOjH9vb3qIMwnDRlbvbQ==
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr7980251wru.141.1552387181338;
        Tue, 12 Mar 2019 03:39:41 -0700 (PDT)
Received: from localhost.localdomain (cpc119140-heme13-2-0-cust57.9-1.cable.virginm.net. [82.44.198.58])
        by smtp.gmail.com with ESMTPSA id p6sm28716174wre.63.2019.03.12.03.39.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:39:40 -0700 (PDT)
X-Mozilla-News-Host: news://news.gmane.org:119
From:   Andrea <mariofutire@gmail.com>
Subject: Help on BLE MIDI Peripheral
To:     linux-bluetooth@vger.kernel.org
Message-ID: <4439bd7c-3f40-df57-d1f4-914154581fb4@gmail.com>
Date:   Tue, 12 Mar 2019 10:39:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I have adapted the python test files in example-gatt-server and example-advertisement to MIDI.

The code is here https://github.com/audetto/ble-midi

I can advertise it properly and in Android I can see the device.
But after it is selected and the android app create a MIDI Device, it drops after 3-4 seconds.

In Android I have used https://github.com/philburk/android-midisuite which is the reference 
implementation.

I have added a lot of logging to the code and it does not print anything after the initial 
advertisement phase.

Application.GetManagedObjects
GATT application registered
Advertisement.GetAll
returning props
Advertisement registered
			<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
/org/bluez/example/advertisement0: Released!
Advertisement unregistered

I would expect the Central to Read some values as in the MIDI BLE spec

"The Central will attempt to read the MIDI I/O characteristic of the Peripheral after establishing a
connection with the accessory. The accessory shall respond to the initial MIDI I/O characteristic
read with a packet that has no payload."

And I get the exact same behaviour if I use the wrong UUID for the characteristic, or if I don't add 
it at all.

I have the feeling the Characteristic is not registered properly.

Here is the key code:

class MIDICharacteristic(egs.Characteristic):
     def __init__(self, bus, index, service):
         flags = ['notify', 'read', 'write', 'write-without-response']
         super().__init__(bus, index, MIDI_CHARACTERISTIC_UUID, flags, service)

and

class MIDIService(egs.Service):
     def __init__(self, bus, index):
         super().__init__(bus, index, MIDI_SERVICE_UUID, True)
         self.add_characteristic(MIDICharacteristic(bus, 0, self))

Is there anything that comes to your mind with these symptoms?

Thank you

