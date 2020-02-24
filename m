Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEBDC11D2F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D076720836
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj5HF3kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgBXKKJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:10:09 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34091 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBXKKI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 05:10:08 -0500
Received: by mail-ot1-f50.google.com with SMTP id j16so8213067otl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f6j8qpPVivhtVScmxxN8CMvN486Gu4zOAh1zjlDsNrk=;
        b=aj5HF3kATsbm6bvaYj9ZclQhnHA/4me4dHNvQbdZZDv0Mwg+nn4O7VZRZyLXkY4BQj
         pGrXmskAyclPVKLMnMjn2QsW9SFCQV1axZCYLpmRUmfCoQy9+XSTAhN6RGA2L499Wt25
         A16qT6eoi6Rd41FCbL2jXB0/xxCI0g5SR8UaanFkWW8iNeW2gMXAgwl+YloP2G7vhW7q
         +iUXDv2yAFdSjsqcVsYkjtke0qqoOPfuz/t4snC6rg/nLopGoMryLN6MMbcOqcbIs3NM
         8DQIg8p4e1K5zP6uXdb572Wc+GV5FOGbErIGtsfHOdIggtXRlWX5nfa/qYaVYYfD2Plq
         GRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f6j8qpPVivhtVScmxxN8CMvN486Gu4zOAh1zjlDsNrk=;
        b=jFqKEXVZB5RWotdZKnfhga+IaYtQs+LrQG3ZOAwcJZkfTocpSq6t1hHBWa9KDvwTF6
         B93fU4CPUHIg96nAXfNdrdfMHKJ4mXnOk99UkbMxTHutAfdzvvkk6vggeWVEGh0lSXl2
         ypQNeYALhUuCSTaAREOMeZuWhgi5RtlH/jKiUvSsvpkYNuXWs+tushKtyvUfmIAlNjre
         qQJhc4ysTzbovAWLCyd3sYfDF6X2AM01km18HuAI/BhClolU776au/ZfMNeNRPcDjS9E
         AB/Ntuo6T99kqKscPNFVebaUGkzRDr98Pb/F/JI5LbnrQh1BEs3SbjPOlOe0V1km/F3B
         HHtQ==
X-Gm-Message-State: APjAAAWsVjk5hSjRHRhd1ZfNQw6TSPZd7pjbayyEdVXmhJkegPc0EdV+
        YuU09j1s+4JTYWMuXsoXeUjun08y45RCAy7HUvi7iE5mR/k=
X-Google-Smtp-Source: APXvYqztupj4AZrv/4jpVtgv8M/5bIwlHReXCIud1JQaqfprvgEvDcgNsMYxuXw7WFffcpNXVmv35N7qFzV7LTPplJ0=
X-Received: by 2002:a9d:624e:: with SMTP id i14mr40230115otk.371.1582539007630;
 Mon, 24 Feb 2020 02:10:07 -0800 (PST)
MIME-Version: 1.0
From:   chris baker <chrisbkr2020@gmail.com>
Date:   Mon, 24 Feb 2020 02:09:57 -0800
Message-ID: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
Subject: Bluez blotoothctl scan vs hcitool scan
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm running bluez 5.50 on a Raspberry Pi (both Buster and Stretch). I
have a ble sensor device that advertises data only when a button on
the sensor device is pressed. So advertisements are asynchronous and
there are no periodic advertisements in between (and all packets are
unique, no duplicates). I'm having an issue with Bluez though where
once a packet is received, Bluez seems to not report any additional
packets from the device for the next approximately 11 seconds (very
occasionally the interval is shorter). This is with the bluetoothctl
line command tool as well as my own c++ application (based off the
bluez client/main.c example). In both cases before starting a scan I
clear the scan filter, set transport to le, and set duplicate-data
reporting on. Conversely, when running "hcitool lescan" I see all the
packets from the sensor (it even seems to be reporting up to all 3
copies broadcast on the different advertisement channels).

Below is a scan covering about 20 seconds (editing out all unrelated
packets), where I'm pressing down the button on the sensor about every
2 seconds and then holding it down for another 2 seconds before
letting it up. The first chunk is from bluetoothctl, the second from
"hcitool lescan"/"hcidump --raw" (taken at the same time, on a second
raspberry pi). The first four bytes in the bluetoothctl packet data is
a little endian packet seq number incremented by the sensor for each
new packet. The next byte indicates a button up/down action. You can
see bluetoothctl reported only packets numbered 05df, 05e5, 05e9 (3
total). In the hci raw dump the seq number is at the end of the top
line. There you can see all packets are in order, reported 1 to 3
times (I assume it is reporting all advertising channels it catches).
All packets are present, 05df to 05e9, in the hcidump scan (11
packets).

So my question is, is there a way to get those missing advertisements
through the dbus api, possibly some additional setting somewhere? If
not, is the hci api okay to use from c++ and should it do the trick?
Is there another/better approach?

------ bluetoothctl
                                .
[NEW] Device E2:15:00:01:73:96 E2-15-00-01-73-96

[CHG] Device E2:15:00:01:73:96 RSSI: -46
[CHG] Device E2:15:00:01:73:96 ManufacturerData Key: 0x03da
[CHG] Device E2:15:00:01:73:96 ManufacturerData Value:
  df 05 00 00 10 a1 ac 8a b4                       .........

[CHG] Device E2:15:00:01:73:96 RSSI: -45
[CHG] Device E2:15:00:01:73:96 ManufacturerData Key: 0x03da
[CHG] Device E2:15:00:01:73:96 ManufacturerData Value:
  e5 05 00 00 10 e7 4f 67 6e                       ......Ogn
                                             .
[CHG] Device E2:15:00:01:73:96 RSSI: -65
[CHG] Device E2:15:00:01:73:96 ManufacturerData Key: 0x03da
[CHG] Device E2:15:00:01:73:96 ManufacturerData Value:
  e9 05 00 00 10 f4 f9 f8 7d                       ........}

---------- hcidump --raw

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 DF 05
  00 00 10 A1 AC 8A B4 C3
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 DF 05
  00 00 10 A1 AC 8A B4 BE

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E0 05
  00 00 11 11 0F 3E 24 B6

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E1 05
  00 00 10 F7 68 07 50 BE
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E1 05
  00 00 10 F7 68 07 50 CF
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E1 05
  00 00 10 F7 68 07 50 BA

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E2 05
  00 00 11 1D 18 A8 2A BF
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E2 05
  00 00 11 1D 18 A8 2A C0
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E2 05
  00 00 11 1D 18 A8 2A B8

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E3 05
  00 00 10 E2 29 C7 F7 BB

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E4 05
  00 00 11 57 F0 5C 76 BD
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E4 05
  00 00 11 57 F0 5C 76 C1

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E5 05
  00 00 10 E7 4F 67 6E CA

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E6 05
  00 00 11 77 63 92 CE C0
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E6 05
  00 00 11 77 63 92 CE BA
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E6 05
  00 00 11 77 63 92 CE BE

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E7 05
  00 00 10 2D 52 48 C2 BD

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E8 05
  00 00 11 EE 32 20 9D BD
> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E8 05
  00 00 11 EE 32 20 9D C1

> 04 3E 19 02 01 03 01 96 73 01 00 15 E2 0D 0C FF DA 03 E9 05
  00 00 10 F4 F9 F8 7D BC
