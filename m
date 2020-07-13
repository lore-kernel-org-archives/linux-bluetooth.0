Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF44C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 00:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1A206B6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 00:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho0AkJg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGMA6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGMA6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Jul 2020 20:58:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624CC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 17:58:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g13so8802604qtv.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=8vy1eANgDjv0peNQM5v7lWEdM7p24FJdnYs8I5JxYGo=;
        b=ho0AkJg2Fz+PKv5z/BBMGm8oCmsSDsKlKaVFO94q5H8iZJK5gGTln12RM9MSBX6S6p
         t6hMPNMyXhUZ1qhOj/8oa6l+2tKCew9MF0NoFGdJTXwCV9rnOP61D82ISfJPLa9xS4Kb
         zPW+LU5ONgXWmHiwbidNEHmlNyqnqCNPSJJBkXNIZFN+6C3b7Rdkk7BKohj66ILB8Gyz
         lWSKIUCF37fup42HnIAIJ/+Eq8R6Yp4BfKCDntnthd9r1OsSreyr2NIhzS3bCgNxNqyZ
         ukwqI9OT4DhhMsalH8jO8HrNGkSf8z+6Orda4BMmhRhCTqwh+jkwuFxyvqGJCLtNcowc
         K/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=8vy1eANgDjv0peNQM5v7lWEdM7p24FJdnYs8I5JxYGo=;
        b=N29XkT7B/ybJEx58jU0i8VQDdUMCkqVxlo3cbLNFnFQ7BxLR6AXkv1exTliKXH9wYl
         XgHe/lfiIFAs7f2y0TzpfbtIyYVLYlNU2Cb+sfkcyh9wHE5Miy9nDnfUvTxu8pYyw7Lv
         zRRSFTsUN0bOuMh5Yv2xHE/5Sfbqg3/H1KgDGx0IuUN1GIdTePh3Inz5cxopfcJ8qdZE
         RdLTsMDE8XhGlDji5Yefr9M0YMMKBjzcl7A0alFU3Ip7kdvAOww7zZNAiDxDc44kpCqb
         OyONAKUXTKQSWuDn/zax+3iSmP1X/iFMalOHLKrPpbvwnp8ifgNy4ZwbmciJ+Kk7/9Cf
         5WYA==
X-Gm-Message-State: AOAM533CUAuaLu4CA09a4Y3SE989g5zIZAT+8NB/BzV1Mk6lUzrZATZQ
        0yY1yR0z7pGQ2PsMkk0ROPB44EZL
X-Google-Smtp-Source: ABdhPJzAS28sN5C71smpN3FK+vQP3402Hh2tb6cvDfd/skXwzw/6fnFgmsdao+XXgdeTvDckLnUvfQ==
X-Received: by 2002:ac8:19d3:: with SMTP id s19mr73308804qtk.356.1594601933040;
        Sun, 12 Jul 2020 17:58:53 -0700 (PDT)
Received: from meimei.greshko.com (2001-b030-112f-0000-0000-0000-0000-140e.hinet-ip6.hinet.net. [2001:b030:112f::140e])
        by smtp.gmail.com with ESMTPSA id p5sm8501428qtb.62.2020.07.12.17.58.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 17:58:52 -0700 (PDT)
From:   Ed Greshko <ed.greshko@gmail.com>
X-Google-Original-From: Ed Greshko <Ed.Greshko@gmail.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Unsupported Adapter?
Autocrypt: addr=Ed.Greshko@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c552dc0-1ef8-ae35-b51a-b6889853d535@gmail.com>
Date:   Mon, 13 Jul 2020 08:58:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I'm running the Fedora 32 disto and bluez-5.54-1.fc32 is installed.

I have 2 bluetooth dongles.  One is recognized and the other isn't.
The one not recognized is shown in lsusb.

The info is as below.  It there a process to get an adapter supported?

Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a12 Cambridge Silicon Radio, Ltd
  idProduct          0x0001 Bluetooth Dongle (HCI mode)
  bcdDevice           88.91
  iManufacturer           0
  iProduct                2 USB1.1-A￿翼
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x003f  1x 63 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)
