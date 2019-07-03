Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BEC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58E92184C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5TGogCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCPf0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:35:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39237 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCPf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 11:35:26 -0400
Received: by mail-ot1-f45.google.com with SMTP id r21so2343006otq.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjmfVm9YrrGJWWGilOjwJ7URKQk1IH1WZT7no1fYdQg=;
        b=b5TGogCAwvM0BFJMH6XQIY2DwcxzVOENTgcC7EQgxjLooqKEHncE6tc79HRr2JkSUO
         JC5aF0JR8dsD3SJihjr0+OIySxgLRBZgLMAqL10NqBcYwWCGYS+c5xgzmBAuNhXJJNIr
         6SrhRuLpRx/tezvRycRGZWhznV6L2PGzO4cp165iF/aaWZI9lJJnst63SGHGOezRLxwc
         QAzFmjYvtX3owRr4WqpH8Mruj9UyElDV7Th152scAt5TBhpWUVY5JCSBNvPmQWMJ4ZYi
         zcmpDmpEVh18F+cTDmOFWlUT9IDvIrY0dw00QoAJpdNtNaz0xFkTVVCzuNnLOO/epEYG
         s/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjmfVm9YrrGJWWGilOjwJ7URKQk1IH1WZT7no1fYdQg=;
        b=MzfvakeOvYhpH9eZzyQJVEIvFcZI20ymmKxMWJ7rpy/nPiITL39TXZ6uB0FMrtAibC
         S+6YRmifRMhaXUAmcA4kuSf7mdAwwPMnLGsRr0qbVeGuv2BEFgLaFfIBWv47W7y6eczs
         Vl7DUUSyHuJk4NPM81vD8O4hPVdqclAmJaEC1qaLuRcI0WrZHB/6o4hrfK8+DOEskBjb
         lX4kSV+s+cStQhaYxF/UmFsil9448kjGycdZ63ooBSvLqjpq7iizENT5a25J7LUteL5Q
         MDXpCZZ2UVfrH/fC+DNML7tqWbVHQJb6wNn8rjHI+tvqjxTideFwT9mu9wfuvPx2Uib1
         AUug==
X-Gm-Message-State: APjAAAUQ1IqwQM/KWZLluYvow9pErxReC1+vEYrKAsnab22Rz7l0Pswv
        z2+vsVnsJRt7ddIZ1iOjxTm39DTJbQmEvd8OpkY=
X-Google-Smtp-Source: APXvYqxmZiml/sILCKBxcALUvPXqMHTurCZ3i3lJ47N3JFdBYAHZHKhi6ULkQjVpSPpUGojBGVYcsrs/4/9qHKVth0E=
X-Received: by 2002:a9d:2c26:: with SMTP id f35mr29155717otb.362.1562168123845;
 Wed, 03 Jul 2019 08:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK_dC=N+YvA1mH5XJDO-P3CV38NbK6UiLrBQe9na-AT8yraVAA@mail.gmail.com>
 <CABBYNZKf5=Kvi21Q=HH8f2KLo0qCTe1U=DeY2QfEGi46m-5x3w@mail.gmail.com>
In-Reply-To: <CABBYNZKf5=Kvi21Q=HH8f2KLo0qCTe1U=DeY2QfEGi46m-5x3w@mail.gmail.com>
From:   Edward Fung <jjsheepman@gmail.com>
Date:   Wed, 3 Jul 2019 08:35:12 -0700
Message-ID: <CAK_dC=OsbyNdFtC6tqhPy1nh6KB6A6BF5u0nEi9obUhLJ5FW8A@mail.gmail.com>
Subject: Re: PTS test case (GATT/SR/UNS/BI-01-C) fails with Bluez 5.50
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

Yes, this is the same test with 3 different errors reported by the
PTS. The HCI commands for each error code are included as below.
Thanks!

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 0116-0102-01
- Invalid request handle received. Expected=0x0000 Received =0x201.
- Connection terminated successfully.
     -Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished

HCI sniffer - Bluetooth packet analyzer ver 5.50
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 class 0x040110 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:1B:DC:F2:1C:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 2
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0038
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 name 'PTS-GATT-E01C'
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x03 oob 0x00 auth 0x00
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 passkey 421373
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:1B:DC:F2:1C:E0 key 9817E8842AA1BDD8469E76A4E83ACEB6 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
        Unicast Connectless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 31 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 517
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0001, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 31]
      ATT: Prepare Write req (0x16)
        attr handle 0x0201, value offset 0x0403
        part attr value  0x05 0x06 0x07 0x08 0x09 0x0a 0x0b 0x0c 0x0d
0x0e 0x0f 0x10 0x11 0x12 0x13
< ACL data: handle 12 flags 0x00 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 31]
      ATT: Error (0x01)
        Error: Invalid handle (1)
        Prepare Write req (0x16) on handle 0x0201
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 31]
      ATT: Read By Group resp (0x11)
        attr handle 0x0001, end group handle 0x0007
        value 0x00 0x18
        attr handle 0x0010, end group handle 0x0015
        value 0x01 0x18
< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0016, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Clock Offset (0x01|0x001f) status 0x00 ncmd 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 010E-0000-01
- Invalid Error Code received. Expected=0x06 Received =0x1.
- Connection terminated successfully.
     -Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished

root@cci:~# hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 5.50
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 class 0x040110 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:1B:DC:F2:1C:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 2
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 mode 2 clkoffset 0x0000
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0038
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 name 'PTS-GATT-E01C'
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x03 oob 0x00 auth 0x00
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 passkey 605930
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:1B:DC:F2:1C:E0 key 487D2063247B68F6031E9D08DB53F9C5 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
        Unicast Connectless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 31 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 517
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0001, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 31]
      ATT: Read Multi req (0x0e)
        Handles
        handle 0x0201
        handle 0x0403
        handle 0x0605
        handle 0x0807
        handle 0x0a09
        handle 0x0c0b
        handle 0x0e0d
< ACL data: handle 12 flags 0x00 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 31]
      ATT: Error (0x01)
        Error: Invalid handle (1)
        Read Multi req (0x0e) on handle 0x0000
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 31]
      ATT: Read By Group resp (0x11)
        attr handle 0x0001, end group handle 0x0007
        value 0x00 0x18
        attr handle 0x0010, end group handle 0x0015
        value 0x01 0x18
< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0016, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Clock Offset (0x01|0x001f) status 0x00 ncmd 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 010C-0000-04
- Invalid Error Code received. Expected=0x06 Received =0x4.
- Connection terminated successfully.
     -Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished

HCI sniffer - Bluetooth packet analyzer ver 5.50
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 class 0x040110 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:1B:DC:F2:1C:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 11 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 11 page 1 max 2
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 mode 2 clkoffset 0x0000
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0038
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0 name 'PTS-GATT-E01C'
> HCI Event: IO Capability Response (0x32) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x01 oob 0x00 auth 0x00
    Capability: DisplayYesNo (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: IO Capability Request (0x31) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
    bdaddr 00:1B:DC:F2:1C:E0 capability 0x03 oob 0x00 auth 0x00
    Capability: NoInputNoOutput (OOB data not present)
    Authentication: No Bonding (No MITM Protection)
> HCI Event: Command Complete (0x0e) plen 10
    IO Capability Request Reply (0x01|0x002b) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:1B:DC:F2:1C:E0 passkey 285477
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:1B:DC:F2:1C:E0
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:1B:DC:F2:1C:E0 key D4B8F555619DFB62C87970AA22E15515 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x01
> ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
        Unicast Connectless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 31 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 517
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 517
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
< ACL data: handle 11 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0001, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 31]
      ATT: Read Blob req (0x0c)
        handle 0x0201 offset 0x0403
< ACL data: handle 11 flags 0x00 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 31]
      ATT: Error (0x01)
        Error: Invalid PDU (4)
        Read Blob req (0x0c) on handle 0x0000
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 31]
      ATT: Read By Group resp (0x11)
        attr handle 0x0001, end group handle 0x0007
        value 0x00 0x18
        attr handle 0x0010, end group handle 0x0015
        value 0x01 0x18
< ACL data: handle 11 flags 0x00 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 31]
      ATT: Read By Group req (0x10)
        start 0x0016, end 0xffff
        type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
< HCI Command: Read Clock Offset (0x01|0x001f) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Clock Offset (0x01|0x001f) status 0x00 ncmd 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 11 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host


On Wed, Jul 3, 2019 at 8:07 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jul 3, 2019 at 5:42 PM Edward Fung <jjsheepman@gmail.com> wrote:
> >
> > Hello team,
> >
> > I'm performing PTS testing (PTS 7.4.1 Build 2 and Bluez 5.50 stack)
> > for SIG certification and the test case GATT/SR/UNS/BI-01-C always
> > fails with the following response error codes. Can anyone shed some
> > light on this? Thank you!
> >
> > Test case : GATT/SR/UNS/BI-01-C started
> > - Running test case with ATT bearer setup over BR/EDR.
> > - BR/EDR Connection setup successfully.
> > - BR Security not initiated due to TSPX_security_enabled value.
> > - Sending an ATT request with an unsupported opcode.
> > - Received data 010C-0000-04
> > - Invalid Error Code received. Expected=0x06 Received =0x4.
> > - Connection terminated successfully.
> > -Final Verdict: FAIL
> > GATT/SR/UNS/BI-01-C finished
> >
> > Test case : GATT/SR/UNS/BI-01-C started
> > - Running test case with ATT bearer setup over BR/EDR.
> > - BR/EDR Connection setup successfully.
> > - BR Security not initiated due to TSPX_security_enabled value.
> > - Sending an ATT request with an unsupported opcode.
> > - Received data 010E-0000-01
> > - Invalid Error Code received. Expected=0x06 Received =0x1.
> > - Connection terminated successfully.
> > -Final Verdict: FAIL
> > GATT/SR/UNS/BI-01-C finished
> >
> > Test case : GATT/SR/UNS/BI-01-C started
> > - Running test case with ATT bearer setup over BR/EDR.
> > - BR/EDR Connection setup successfully.
> > - BR Security not initiated due to TSPX_security_enabled value.
> > - Sending an ATT request with an unsupported opcode.
> > - Received data 0116-0102-01
> > - Invalid request handle received. Expected=0x0000 Received =0x201.
> > - Connection terminated successfully.
> > -Final Verdict: FAIL
> > GATT/SR/UNS/BI-01-C finished
>
> Is this all the same test which cause different errors to be reported?
> It seems to expect request not supported over invalid PDU, but the
> second one is returning invalid handle which is weird, do you have the
> HCI for these runs?
>
> --
> Luiz Augusto von Dentz
