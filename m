Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0549AC742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 20:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B4A208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 20:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXMoj8rJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfGKUm6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:42:58 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43077 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGKUm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 16:42:57 -0400
Received: by mail-lf1-f51.google.com with SMTP id c19so4965407lfm.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2019 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3XyFvVTIMKsMMb0WZzNR2UfI9oUeWJRtVCWrDMoW6sI=;
        b=nXMoj8rJaPekouXRDrmhZ+c6MQ7dcO5qGikt+ObgcHpQ6TVKPk0AYxLuKvoOUCVYOU
         IPlgP0LXTe2QNAH8Ycxa9Ebf0VBEDZUn88p0In6Bnmi9zFjq+74VSV/gWdmdz6UJQlan
         iJvUw+hQKT2ff7s7TkcSNs7g2qqnkPgdabAlqIjzxv/jWZrjlOXYlAI6axNrC03KSC3l
         j2Y3Rqak05IC4SXmOCCqJm9W8bRjMiREyav5ZAc58YeJMW9KJlRWmgKs2wJ7tnUbieYv
         E204C/Hv5toPV15VACSIYqW61bOw+QHBCtYILwl6FHymk3r78eY8VgV6g/GH7qQHJUfu
         6eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3XyFvVTIMKsMMb0WZzNR2UfI9oUeWJRtVCWrDMoW6sI=;
        b=fq2Gn/Bi+YW8eZUmxA7K4rgIeC6hDDBfKbX3GBJArWUoob+G5mog7PX5lxc1274hGQ
         vb7ICnKCrUSj0pxtH89WZ3M56Pgob2o7oHq5CdCAZRm7F25tjvU5LPxSKlW7qkY497+U
         yFllID2DytQBCKpYaUYvebSrClbxZC9BRKNdctzs0Cm8CTc2QIyAGdXT00gcaOThNl4D
         LI1skwA0rJxFCgJEBqfXVtQVBFWIH6CpRt/BD50mCVEeTx61pMu6BEZqIOa24noEzdYE
         NOhVPIVvD+ctdaWNryVkAbcA/3b4t2DYEP9jP68i+Ig+EROGIDHcKpha8/Abde6xbPRV
         7qIw==
X-Gm-Message-State: APjAAAUmaZ/ZhdQ512BJMHWeGijZ+yDX22F/5b9s2REA9ObkL4z52g/K
        DR9ovEO2cG9aSmqm7vcsMZAdvseEntc=
X-Google-Smtp-Source: APXvYqwfwqvcMtZvG1zLXRL6SkniMLIAGl9JgQF9caB8Y+WbOdNPdajhAbGe8LUVq+YRlrLvlWu8XA==
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr2809801lfg.160.1562877775294;
        Thu, 11 Jul 2019 13:42:55 -0700 (PDT)
Received: from ubuntu-18-04-beta2 ([2001:999:40:af14:8844:7726:2fc8:2])
        by smtp.gmail.com with ESMTPSA id r24sm1270585ljb.72.2019.07.11.13.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 13:42:54 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:42:52 +0000
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     Axelle <aafortinet@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: SMP: Pairing failed with unspecified reason (0x08)
Message-ID: <20190711204252.GA2759@ubuntu-18-04-beta2>
References: <CANKzOHBCQ_ApbXXXNxjeRkrTwefxivgsVusqPxLaHkio3QitLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANKzOHBCQ_ApbXXXNxjeRkrTwefxivgsVusqPxLaHkio3QitLA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Axelle,

On Thu, Jul 11, 2019 at 02:47:31PM +0200, Axelle wrote:
> I am trying to pair with a BLE device from a RPI device. The first few
> packets seem fine (Pairing Request, Pairing Response, LE Start
> Encryption, Signing Information...) but in the end I get a "Pairing
> Failed" SMP packet, with reason "Unspecified reason"  :(
> 
> Any explanation what could be the ... reason ;) and how to solve this please?
> 
> Thanks!

What kernel version you are running on RPI? How do you initiate pairing? 
There seems to be something weird going on in this btmon trace.

> 
> PS. This is the btmon log:
> 
> < HCI Command: Reset (0x03|0x0003) plen 0
>                          [hci0] 298.154979
> > HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.157882
>       Reset (0x03|0x0003) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Set Event Filter (0x03|0x0005) plen 1
>                          [hci0] 298.171262
>         Type: Clear All Filters (0x00)
> > HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.171657
>       Set Event Filter (0x03|0x0005) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
>                          [hci0] 298.185592
>         Timeout: 20000.000 msec (0x7d00)
> > HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.186005
>       Write Connection Accept Timeout (0x03|0x0016) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Set Event Mask (0x03|0x0001) plen 8
>                          [hci0] 298.198904
>         Mask: 0x3dbff807fffbffff
>           Inquiry Complete
>           Inquiry Result
>           Connection Complete
>           Connection Request
>           Disconnection Complete
>           Authentication Complete
>           Remote Name Request Complete
>           Encryption Change
>           Change Connection Link Key Complete
>           Master Link Key Complete
>           Read Remote Supported Features Complete
>           Read Remote Version Information Complete
>           QoS Setup Complete
>           Command Complete
>           Command Status
>           Hardware Error
>           Flush Occurred
>           Role Change
>           Mode Change
>           Return Link Keys
>           PIN Code Request
>           Link Key Request
>           Link Key Notification
>           Loopback Command
>           Data Buffer Overflow
>           Max Slots Change
>           Read Clock Offset Complete
>           Connection Packet Type Changed
>           QoS Violation
>           Page Scan Mode Change
>           Page Scan Repetition Mode Change
>           Flow Specification Complete
>           Inquiry Result with RSSI
>           Read Remote Extended Features Complete
>           Synchronous Connection Complete
>           Synchronous Connection Changed
>           Sniff Subrating
>           Extended Inquiry Result
>           Encryption Key Refresh Complete
>           IO Capability Request
>           IO Capability Request Reply
>           User Confirmation Request
>           User Passkey Request
>           Remote OOB Data Request
>           Simple Pairing Complete
>           Link Supervision Timeout Changed
>           Enhanced Flush Complete
>           User Passkey Notification
>           Keypress Notification
>           Remote Host Supported Features Notification
>           LE Meta
> > HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.199255
>       Set Event Mask (0x03|0x0001) ncmd 1
>         Status: Success (0x00)
> < HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
>                          [hci0] 298.214150
>         Supported: 0x01
>         Simultaneous: 0x01
> > HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.214499
>       Write LE Host Supported (0x03|0x006d) ncmd 1
>         Status: Success (0x00)
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>                          [hci0] 302.516667
>         Scan interval: 60.000 msec (0x0060)
>         Scan window: 30.000 msec (0x0030)
>         Filter policy: White list is not used (0x00)
>         Peer address type: Random (0x01)
>         Peer address: D2:A7:4C:76:F3:E0 (Static)
>         Own address type: Public (0x00)
>         Min connection interval: 50.00 msec (0x0028)
>         Max connection interval: 70.00 msec (0x0038)
>         Connection latency: 0x0000
>         Supervision timeout: 420 msec (0x002a)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 302.517237
>       LE Create Connection (0x08|0x000d) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 19                                                       [hci0] 302.658079
>       LE Connection Complete (0x01)
>         Status: Success (0x00)
>         Handle: 64
>         Role: Master (0x00)
>         Peer address type: Random (0x01)
>         Peer address: D2:A7:4C:76:F3:E0 (Static)
>         Connection interval: 67.50 msec (0x0036)
>         Connection latency: 0.00 msec (0x0000)
>         Supervision timeout: 420 msec (0x002a)
>         Master clock accuracy: 0x00
> > ACL Data RX: Handle 64 flags 0x02 dlen 16                                                     [hci0] 307.789579
>       LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
>         Min interval: 6
>         Max interval: 12
>         Slave latency: 0
>         Timeout multiplier: 400
> < HCI Command: LE Connection Update (0x08|0x0013) plen 14
>                          [hci0] 307.813788
>         Handle: 64
>         Min connection interval: 7.50 msec (0x0006)
>         Max connection interval: 15.00 msec (0x000c)
>         Connection latency: 0x0000
>         Supervision timeout: 4000 msec (0x0190)
>         Min connection length: 0.000 msec (0x0000)
>         Max connection length: 0.000 msec (0x0000)
> > HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 307.814226
>       LE Connection Update (0x08|0x0013) ncmd 1
>         Status: Success (0x00)
> < ACL Data TX: Handle 64 flags 0x00 dlen 10
>                          [hci0] 307.837601
>       LE L2CAP: Connection Parameter Update Response (0x13) ident 0 len 2
>         Result: Connection Parameters accepted (0x0000)
> > HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 308.157176
>         Num handles: 1
>         Handle: 64
>         Count: 1
> > HCI Event: LE Meta Event (0x3e) plen 10                                                       [hci0] 308.272198
>       LE Connection Update Complete (0x03)
>         Status: Success (0x00)
>         Handle: 64
>         Connection interval: 15.00 msec (0x000c)
>         Connection latency: 0.00 msec (0x0000)
>         Supervision timeout: 4000 msec (0x0190)
> < ACL Data TX: Handle 64 flags 0x00 dlen 11
>                          [hci0] 315.133782
>       SMP: Pairing Request (0x01) len 6
>         IO capability: KeyboardOnly (0x02)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, MITM, Legacy, No Keypresses (0x05)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey Sign (0x05)
>         Responder key distribution: EncKey Sign (0x05)
> > ACL Data RX: Handle 64 flags 0x02 dlen 11                                                     [hci0] 315.157207
>       SMP: Pairing Response (0x02) len 6
>         IO capability: NoInputNoOutput (0x03)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, Legacy, No
> Keypresses (0x01)
>         Max encryption key size: 16
>         Initiator key distribution: Sign (0x04)
>         Responder key distribution: EncKey (0x01)
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
>                          [hci0] 315.165422
> > HCI Event: Command Complete (0x0e) plen 10                                                    [hci0] 315.165792
>       Read BD ADDR (0x04|0x0009) ncmd 1
>         Status: Success (0x00)
>         Address: B8:27:EB:15:50:70 (Raspberry Pi Foundation)
> < ACL Data TX: Handle 64 flags 0x00 dlen 21
>                          [hci0] 315.183781
>       SMP: Pairing Confirm (0x03) len 16
>         Confim value: 12e170d20c0bb8beb6d7c59bb006acd0
> > HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.187419
>         Num handles: 1
>         Handle: 64
>         Count: 2
> > ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.202330
>       SMP: Pairing Confirm (0x03) len 16
>         Confim value: 6e0be0cc5a8f08ffc98a88c25167aa2f
> < ACL Data TX: Handle 64 flags 0x00 dlen 21
>                          [hci0] 315.219695
>       SMP: Pairing Random (0x04) len 16
>         Random value: 25498f1cc873d7450460df3b5ce2ab7e
> > ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.247316
>       SMP: Pairing Random (0x04) len 16
>         Random value: 9e7769acf6f4c19706f9abde25d4749f
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>                          [hci0] 315.256836
>         Handle: 64
>         Random number: 0x0000000000000000
>         Encrypted diversifier: 0x0000
>         Long term key: 7689a6b5371537b24f2c7c7805688df6
> > HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 315.257310
>       LE Start Encryption (0x08|0x0019) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Encryption Change (0x08) plen 4                                                    [hci0] 315.337302
>         Status: Success (0x00)
>         Handle: 64
>         Encryption: Enabled with AES-CCM (0x01)
> > ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.367776
>       SMP: Encryption Information (0x06) len 16
>         Long term key: b22ef80c481a8b4929e7159e0c2b0ba3
> > ACL Data RX: Handle 64 flags 0x02 dlen 15                                                     [hci0] 315.397264
>       SMP: Master Identification (0x07) len 10
>         EDIV: 0x02ee
>         Rand: 0x0720e828075f93eb
> > HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.407288
>         Num handles: 1
>         Handle: 64
>         Count: 1
> < ACL Data TX: Handle 64 flags 0x00 dlen 21
>                          [hci0] 315.416056
>       SMP: Encryption Information (0x06) len 16
>         Long term key: ffeeddccbbaa99887766554433221100
> < ACL Data TX: Handle 64 flags 0x00 dlen 15
>                          [hci0] 315.425880
>       SMP: Master Identification (0x07) len 10
>         EDIV: 0x000c
>         Rand: 0x8877665544332211

This looks weird here: to my understanding your RPI should not send
Encryption Information and Master Identification at all because only 
Sign bit is set in Pairing Response's Initiator key distribution flags.

It is possible that the other device does not like that and sends then
Pairing Failed.

Also Long Term Key and Rand values are somewhat suspicious and not
random as they should.

> < ACL Data TX: Handle 64 flags 0x00 dlen 21
>                          [hci0] 315.433926
>       SMP: Signing Information (0x0a) len 16
>         Signature key: ffeeddccbbaa99887766554433221100
> > ACL Data RX: Handle 64 flags 0x02 dlen 6                                                      [hci0] 315.442266
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Unspecified reason (0x08)
> > HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.442543
>         Num handles: 1
>         Handle: 64
>         Count: 2
> > HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.532771
>         Num handles: 1
>         Handle: 64
>         Count: 1
> > HCI Event: Disconnect Complete (0x05) plen 4                                                  [hci0] 315.532868
>         Status: Success (0x00)
>         Handle: 64
>         Reason: Remote User Terminated Connection (0x13)

Best regards,
Matias
