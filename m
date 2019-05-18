Return-Path: <SRS0=UGHn=TS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE4C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 17:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942B820873
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 May 2019 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSR6KQ31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfERRGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 May 2019 13:06:03 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:42626 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfERRGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 May 2019 13:06:03 -0400
Received: by mail-pf1-f182.google.com with SMTP id 13so5170219pfw.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2019 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1K9vw6RUV0f1WDbV1U2uTXR4wPNCaUs43gDZPPCYPc=;
        b=ZSR6KQ31Nqly2QKDQlOyandrLtJKU8X7xn2+m5omJsDqH5W9f67iqc5/RFQqt5oZS2
         q7Ift0Z0A/OtSYhZ15AeePxN5CTeKgAz91GzHyvJJG5vKcp0CXOftfm8TO00DbpWKwtg
         ciIofzlj1IXmZLHLAy2w5Ibjg0AA6JAKCcY6GqMlT13oew5z5Gywtdl2E4g5zRkAhgwb
         oobMtCud6Kdj1wwaXKKiBnEtl1LFwzQWQk6bPslDJcWBzTLaS9u4WbjgJnPiSQNpmcMP
         5c1n8h3mEbim+6QQLBR3yRW5mxU7+ixfVboqNz/DiQZK1/U7xQIW9CJU5KIKnFz5jzNT
         s1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=d1K9vw6RUV0f1WDbV1U2uTXR4wPNCaUs43gDZPPCYPc=;
        b=BZixAUenZLhiRSDtK2BOD9lZaR77yUZCo7BlZU975JE6PLN8K9pDNd3/VaoABxtgA/
         5vGs1U8Q5PVhHRDsAPEscnAF9FCmaJLi/TRipeYMAjo9d4d6lrwTe1adbfCYaEP0xybp
         71ZooVSclH9d5yDUV5/IKd7NoOAcFL3VRqqdWsssTA8/IUVQg1+t7zBwRujNej5mzYTV
         eAewMshPgIRdRAXGB6qpcTU6ciJWw6v7+TtSV0sA88KXCRUznGNl6hiv82hpw74Dtstx
         rQE7Ix7zwsQ/wGwHEYJKeRD2QRkAEa3JovmA2iYy7b1QlA4GE/KhIt9hTvDQbYx2BYx8
         unRw==
X-Gm-Message-State: APjAAAUHbBIGUAal9CbcQRH7Wkk1yeYd53c9345lGb9SteQcYgbj974X
        tDMpoglbOGUMd6HGYEKoXHQ=
X-Google-Smtp-Source: APXvYqxn6g7hLqsjAkJ4pGOxiePV0F7BVWvUwUDKhcUjuq0880K8skcdeSA9FVAengq5qbROQqlLEA==
X-Received: by 2002:a65:5785:: with SMTP id b5mr28378744pgr.252.1558199162099;
        Sat, 18 May 2019 10:06:02 -0700 (PDT)
Received: from localhost ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id 135sm22352961pfb.97.2019.05.18.10.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 10:06:01 -0700 (PDT)
Date:   Sat, 18 May 2019 20:05:57 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: After kernel update: connect/disconnect forever while attempting
 to auto-reconnect
Message-ID: <20190518170557.GA79055@canella-mobl.ger.corp.intel.com>
Mail-Followup-To: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CAELgYhdqAxTGA98RsUEOSEA5WfhxGaVn7C_DegAfU13sHx817A@mail.gmail.com>
 <CANxMttCx4uFeVpM9EsYmfg9VoXG45ihpzw=phJcx0Uy53cGD_A@mail.gmail.com>
 <CABBYNZLGgUL6W=-v+stoaukpN5kvt1AHFBQ_vEdh=sqU9JO0LQ@mail.gmail.com>
 <CAELgYhcCBAUr6oQxTnmjBjQfkc8JeTbkXHea64PN+7cWQSqQ=Q@mail.gmail.com>
 <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANxMttCqEYDZOwTriLqC-q39+JhEJ9KCOsPhRqkjZwE1h-64Gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

The HCI log below seems to indicate an issue with the mouse:

On Sat, May 18, 2019, Alexandre Pereira Nunes wrote:
> > HCI Event: Connect Complete (0x03) plen 11                 #6 [hci0] 5.703492
>         Status: Success (0x00)
>         Handle: 512
>         Address: 20:14:12:09:18:BD (OUI 20-14-12)
>         Link type: ACL (0x01)
>         Encryption: Disabled (0x00)
> < HCI Command: Read Remote Supported.. (0x01|0x001b) plen 2  #7 [hci0] 5.703737
>         Handle: 512
> > HCI Event: Command Status (0x0f) plen 4                    #8 [hci0] 5.704439
>       Read Remote Supported Features (0x01|0x001b) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Link Supervision Timeout Changed (0x38) plen 4  #9 [hci0] 5.707467
>         Handle: 512
>         Timeout: 2000.000 msec (0x0c80)
> > HCI Event: Read Remote Supported Features (0x0b) plen 11  #10 [hci0] 5.714448
>         Status: Success (0x00)
>         Handle: 512
>         Features: 0xfc 0x02 0x04 0x38 0x18 0x18 0x19 0x83
>           Encryption
>           Slot offset
>           Timing accuracy
>           Role switch
>           Hold mode
>           Sniff mode
>           Power control requests
>           Power control
>           Enhanced inquiry scan
>           Interlaced inquiry scan
>           Interlaced page scan
>           AFH capable slave
>           AFH classification slave
>           AFH capable master
>           AFH classification master
>           Extended Inquiry Response
>           Secure Simple Pairing
>           Encapsulated PDU
>           Link Supervision Timeout Changed Event
>           Inquiry TX Power Level
>           Extended features
> < HCI Command: Read Remote Extended.. (0x01|0x001c) plen 3  #11 [hci0] 5.714535
>         Handle: 512
>         Page: 1
> > HCI Event: Command Status (0x0f) plen 4                   #12 [hci0] 5.715445
>       Read Remote Extended Features (0x01|0x001c) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Read Remote Extended Features (0x23) plen 13   #13 [hci0] 5.728475
>         Status: Success (0x00)
>         Handle: 512
>         Page: 1/0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10    #14 [hci0] 5.728565
>         Address: 20:14:12:09:18:BD (OUI 20-14-12)
>         Page scan repetition mode: R2 (0x02)
>         Page scan mode: Mandatory (0x00)
>         Clock offset: 0x0000
> < ACL Data TX: Handle 512 flags 0x00 dlen 10                #15 [hci0] 5.728582
>       L2CAP: Information Request (0x0a) ident 1 len 2
>         Type: Extended features supported (0x0002)
> > HCI Event: Command Status (0x0f) plen 4                   #16 [hci0] 5.729447
>       Remote Name Request (0x01|0x0019) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Number of Completed Packets (0x13) plen 5      #17 [hci0] 5.740495
>         Num handles: 1
>         Handle: 512
>         Count: 1
> > ACL Data RX: Handle 512 flags 0x02 dlen 16                #18 [hci0] 5.746576
>       L2CAP: Information Response (0x0b) ident 1 len 8
>         Type: Extended features supported (0x0002)
>         Result: Success (0x0000)
>         Features: 0x00000000
> > HCI Event: Remote Name Req Complete (0x07) plen 255       #19 [hci0] 5.781389
>         Status: Success (0x00)
>         Address: 20:14:12:09:18:BD (OUI 20-14-12)
>         Name: Bluetooth Mouse
> @ MGMT Event: Device Connected (0x000b) plen 35        {0x0001} [hci0] 5.781439
>         BR/EDR Address: 20:14:12:09:18:BD (OUI 20-14-12)
>         Flags: 0x00000000
>         Data length: 22
>         Name (complete): Bluetooth Mouse
>         Class: 0x002580
>           Major class: Peripheral (mouse, joystick, keyboards)
>           Minor class: 0x20
>           Limited Discoverable Mode
> > HCI Event: Role Change (0x12) plen 8                      #20 [hci0] 6.058251
>         Status: Success (0x00)
>         Address: 20:14:12:09:18:BD (OUI 20-14-12)
>         Role: Master (0x00)
> > ACL Data RX: Handle 512 flags 0x02 dlen 12                #21 [hci0] 6.088229
>       L2CAP: Connection Request (0x02) ident 1 len 4
>         PSM: 17 (0x0011)
>         Source CID: 65
> < ACL Data TX: Handle 512 flags 0x00 dlen 16                #22 [hci0] 6.088298
>       L2CAP: Connection Response (0x03) ident 1 len 8
>         Destination CID: 0
>         Source CID: 65
>         Result: Connection refused - security block (0x0003)
>         Status: No further information available (0x0000)

From the above it looks like the mouse is initiating an L2CAP Connection
Request to a non-SDP PSM (17 in this case), which is prohibited by the
spec whenever both sides support Secure Simple Pairing (SSP), and the
kernel is correctly responding with a security block error. So to me the
above looks like misbehavior by the mouse. Could you also post the same
log using a kernel that's working for you?

Johan
