Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE0C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjFGTV5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFGTV4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 15:21:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F21FD5
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 12:21:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso9366994e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686165713; x=1688757713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0EsGNXtSydSBRo4wZwHRok3oO7Te/zA7Id9vPP2hxQ=;
        b=a3R99Efjdebcqlk/C2WA4NXBKS2NVtjx0lcSPXe7rk30UbXkOyijIwAUL3prfrkdIB
         0qNFt+kJG25Qa+MsT557F3Gune8jUzgHe4UXAz74VEh/z2HGCmANHH1nbF96jr6PmIMr
         ex2tHfb2+IRyMESmuwH5MWTFsmWGXOg+0aJtuD43Mj2UEW+JEgmMjHT85B8b9ga/3aej
         NPIaJewz2h0cYKTN0B+IyUR3AUF6Cv9BBQC0w85BJKW7IdbYYFn2ImmD2/ttLKhrBmd2
         zRqZhV2VxikEd10KnyhXW/fEdBFFoXXb1N0GOk6+pebrEskNF4ilWXDxtnWkYOx5/n/c
         8TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165713; x=1688757713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0EsGNXtSydSBRo4wZwHRok3oO7Te/zA7Id9vPP2hxQ=;
        b=groI9EBMp1gwA97xKjjWRLX0hr8w3aZxnpLunQ2OWfsPQz5eJAdgc4FnJXYpVU7RNv
         dXmKKBULWjW5nDYGOmQZmRzqn3C1XY0GMp77J/mVmKwq6VrCW9UGEWsx9tu0i8ng7Qlt
         j0y8I2a2VBknE2huCN/L8F7e0PSApQLjHnthnOWmEwnD51gES3j+T3gXTso2qy15EfXI
         KjH5aUEG1KKGHq9hCGF12Z5B8/26k7mtk5YJ4uRZOqvz9ChWjA+kkQBjjckGSbG4Tvm6
         CRkO1c2zPNvPtG/1UqZJLdrSDvmGpZ0f6KH95likwFe4DDdcqy9hVacFtZdgyCAeLZ5P
         +REg==
X-Gm-Message-State: AC+VfDzrnO5Ffis/U+IJ/xA32aEWLQ1nz1bQ9UHC6I6ft8+Jcqj9UBI9
        tFq/NoWbp7h0zxjmkyCqVtLeCwaVyaCsWajX/Oc9qKZg/QA=
X-Google-Smtp-Source: ACHHUZ5IooadXAQyIJswTRDVn+DxAzVgE7AdYqAd3xnzwYSjVik2zF/eix7u/yB6PhBKgQtEerzxaD2iU0JZIJA8ww4=
X-Received: by 2002:a2e:968e:0:b0:2ac:bd28:d457 with SMTP id
 q14-20020a2e968e000000b002acbd28d457mr2841626lji.14.1686165712457; Wed, 07
 Jun 2023 12:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
In-Reply-To: <76E1E367-BAF0-41A8-A292-7E002B213D8A@athom.nl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Jun 2023 12:21:40 -0700
Message-ID: <CABBYNZ+CYMsDSPTxBn09Js3BcdC-x7vZFfyLJ3ppZGGwJKmUTw@mail.gmail.com>
Subject: Re: Intermittent Not connectable devices reported
To:     Herman Meerlo <herman.meerlo@athom.nl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Herman,

On Fri, Jun 2, 2023 at 2:51=E2=80=AFAM Herman Meerlo <herman.meerlo@athom.n=
l> wrote:
>
> I'm working on a Raspberry Pi device that performs periodic BLE discovery=
 and tries to connect to multiple devices. Most of the times this goes fine=
 but especially in BLE heavy environments every now and then it fails becau=
se it says that the device is not found. I have been debugging this issue f=
or a few weeks now and it comes down to this:
>
>    =E2=80=A2 Connect to DBus to start the discovery
>    =E2=80=A2 Devices are found, interfacesAdded callbacks are made, every=
thing looks fine
>    =E2=80=A2 Stop discovery
>    =E2=80=A2 Directly some devices are removed by the interfacesRemoved c=
allback
>    =E2=80=A2 My code does not get the device it searches for -> unhappy u=
ser
>
> What happens under the hood is that DBus removes all devices from it's ca=
che that have been indicated by Bluez as being Not connectable. I.e. there =
is no use in keeping them around, you can't connect to them anyway. But... =
this is not true for the device I'm looking for. It is marked as Not connec=
table incorrectly.
> So to chase down the problem I create a btmon dump which shows indeed tha=
t the device is reported to be Not connectable after having received a SCAN=
_RSP:
>
> > HCI Event: LE Meta Event (0x3e) plen 38 #73 [hci0] 34.359921
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Scan response - SCAN_RSP (0x04)
> Address type: Public (0x00)
> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> Data length: 26
> Name (complete): BeeWi SmartLite
> Peripheral Conn. Interval: 0x0028 - 0x0050
> TX power: 0 dBm
> RSSI: -42 dBm (0xd6)
> @ MGMT Event: Device Found (0x0012) plen 40 {0x0001} [hci0] 34.360057
> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> RSSI: -42 dBm (0xd6)
> Flags: 0x00000004
> Not Connectable
> Data length: 26
> Name (complete): BeeWi SmartLite
> Peripheral Conn. Interval: 0x0028 - 0x0050
> TX power: 0 dBm
>
> But all ADV_IND PDU's before that clearly indicate that the device is con=
nectable, it is only after this SCAN_RSP that it is reported as Not connect=
able:
>
> > HCI Event: LE Meta Event (0x3e) plen 27 #46 [hci0] 34.152817
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Connectable undirected - ADV_IND (0x00)
> Address type: Public (0x00)
> Address: F4:B8:5E:64:02:55 (Texas Instruments)
> Data length: 15
> Flags: 0x06
> LE General Discoverable Mode
> BR/EDR Not Supported
> Company: Texas Instruments Inc. (13)
> Data: 06030108b0e408f7
> RSSI: -43 dBm (0xd5)
> @ MGMT Event: Device Found (0x0012) plen 31 {0x0001} [hci0] 34.152905
> LE Address: 44:6E:FF:00:0D:65 (Resolvable)
> RSSI: -74 dBm (0xb6)
> Flags: 0x00000000
> Data length: 17
> Flags: 0x1a
> LE General Discoverable Mode
> Simultaneous LE and BR/EDR (Controller)
> Simultaneous LE and BR/EDR (Host)
> TX power: 9 dBm
> Company: Apple, Inc. (76)
> Type: Unknown (16)
> Data: 01188898dc
> > HCI Event: LE Meta Event (0x3e) plen 41 #47 [hci0] 34.156958
> LE Advertising Report (0x02)
> Num reports: 1
> Event type: Connectable undirected - ADV_IND (0x00)
> Address type: Random (0x01)
> Address: FA:BD:8D:12:26:BF (Static)
> Data length: 29
> Name (short): P mesh
> Flags: 0x04
> BR/EDR Not Supported
> 128-bit Service UUIDs (partial): 1 entry
> Vendor specific
> RSSI: -47 dBm (0xd1)
> @ MGMT Event: Device Found (0x0012) plen 29 {0x0001} [hci0] 34.157030
> LE Address: F4:B8:5E:64:02:55 (Texas Instruments)
> RSSI: -43 dBm (0xd5)
> Flags: 0x00000000
> Data length: 15
> Flags: 0x06
> LE General Discoverable Mode
> BR/EDR Not Supported
> Company: Texas Instruments Inc. (13)
> Data: 06030108b0e408f7
>
> So I am heavily doubting whether the Linux kernel code has a bug in handl=
ing the SCAN_RSP. Please look at this part of the kernel:
>
> https://github.com/torvalds/linux/blob/48b1320a674e1ff5de2fad8606bee38f72=
4594dc/net/bluetooth/hci_event.c#L6326
>
> It sets the NOT CONNECTABLE flag by default for a SCAN_RSP and will overw=
rite it with any flags it has received with a previous ADV_IND. But it does=
 not seem to take into account that in BLE heavy environments the previous =
ADV_IND might be of a totally different device. So every now and then it wi=
ll enter the first path where it will just report the device with a NOT_CON=
NECTABLE flag. Or am I missing something here?

You are saying that the controller would interleave ADV_IND of
different peers before SCAN_RSP, in that case yes that would be
possible that the device would be marked as NOT_CONNECTABLE, usually
that is not really the case which is why we end up adding the code
above:

     * In the really unlikely case that a controller get confused
     * and just sends a scan response event, then it is marked as
     * not connectable as well.

I guess it is not really unlikely after all, so perhaps we need a flag
indicating this is a standalone SCAN_RSP e.g. MGMT_DEV_FOUND_SCAN_RSP,
then we can treat it accordingly in userspace.

--=20
Luiz Augusto von Dentz
