Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A8AC74A35
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6E2084B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 12:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYj84h0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfGKMrA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:47:00 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:41504 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKMrA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 08:47:00 -0400
Received: by mail-yb1-f180.google.com with SMTP id 13so2395212ybx.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2019 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v6tJCYIS2vF/xsXVCSGA5pIEZ6g7gqED5kAgfyPBKAE=;
        b=EYj84h0EIlUloTSFagwAD2naBs/QNUNMUVbqduIRcYjf2ZmKFNGx6jF8aM2lGLedEI
         Q0O6PKvGkTA5MrjRi/g/VQPJmIlRFKmH6th090CctYtcoiH2o6l0RZ1p/aRj0WPNtU7c
         ZDu2Bsr8qbXRoNeBio5oLRljfnZVbTHtRbnKr/d8exFpXWAHCR6bCb5FNZAqtoTJXwi1
         M0Lgqeuvio2lOX2vPt7BjBCt/eD//zESI/AjUI0kK+qZgvq2yv8S2UebwKN9EPZY0NBi
         1y50cD7KmV3/YyeyDVl9XFIaRVo15pg4KhV5OAMstVbDwHm7fF2al08Q+dbw6o5YbOv/
         jdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v6tJCYIS2vF/xsXVCSGA5pIEZ6g7gqED5kAgfyPBKAE=;
        b=shdrwnvn23yfUU+jE3t6h1Gmpr8jXt062onJblb+jvJw/Xhufj9IeIY6cAcJEwb37/
         nhzwbKJlkyHVdJpj6IQTQMEYVDJcXvXk+PLCR28SHB05bUt7El5QetHaq5EHbc+tpHG4
         Ac6QKvryf2wcMA2iQ/Y7DY6lAy1kOcAIzqeXsxC/1E2OdsektJ9zO22czerB5ayBiBCR
         d5tOcviPH++cUZZE/aRtg+E9dQvlW2JIxkGmBC4hdXLJb7ONxQTL/lgZVqeZvNVEyUrW
         Hdr/IXF+fNNpF4f51MbGdBJdn6IYB8QU0T5Lh7xPOanA0EvuAQFrafTe9N+QdA1Tg5JM
         juQw==
X-Gm-Message-State: APjAAAU6t6SCAamrI4caoNYnOs/X/vPhqDYNVyb1W4uaVaTxCWBNUJwS
        TefumVEGxSkG9TlyWiyfP0+dGXLB2IpdSX3nhUY0p9ypLak=
X-Google-Smtp-Source: APXvYqxyoWmY59psGEEvGUS0rWoeUBWB+o72Wd/IhGIHrT1Qa/dCgMMTQPxdane1mdq59IwTU2tEauyzl7WFVmmfVt8=
X-Received: by 2002:a0c:9233:: with SMTP id a48mr1934046qva.66.1562849219006;
 Thu, 11 Jul 2019 05:46:59 -0700 (PDT)
MIME-Version: 1.0
From:   Axelle <aafortinet@gmail.com>
Date:   Thu, 11 Jul 2019 14:47:31 +0200
Message-ID: <CANKzOHBCQ_ApbXXXNxjeRkrTwefxivgsVusqPxLaHkio3QitLA@mail.gmail.com>
Subject: SMP: Pairing failed with unspecified reason (0x08)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am trying to pair with a BLE device from a RPI device. The first few
packets seem fine (Pairing Request, Pairing Response, LE Start
Encryption, Signing Information...) but in the end I get a "Pairing
Failed" SMP packet, with reason "Unspecified reason"  :(

Any explanation what could be the ... reason ;) and how to solve this please?

Thanks!

PS. This is the btmon log:

< HCI Command: Reset (0x03|0x0003) plen 0
                         [hci0] 298.154979
> HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.157882
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
                         [hci0] 298.171262
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.171657
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
                         [hci0] 298.185592
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.186005
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: Set Event Mask (0x03|0x0001) plen 8
                         [hci0] 298.198904
        Mask: 0x3dbff807fffbffff
          Inquiry Complete
          Inquiry Result
          Connection Complete
          Connection Request
          Disconnection Complete
          Authentication Complete
          Remote Name Request Complete
          Encryption Change
          Change Connection Link Key Complete
          Master Link Key Complete
          Read Remote Supported Features Complete
          Read Remote Version Information Complete
          QoS Setup Complete
          Command Complete
          Command Status
          Hardware Error
          Flush Occurred
          Role Change
          Mode Change
          Return Link Keys
          PIN Code Request
          Link Key Request
          Link Key Notification
          Loopback Command
          Data Buffer Overflow
          Max Slots Change
          Read Clock Offset Complete
          Connection Packet Type Changed
          QoS Violation
          Page Scan Mode Change
          Page Scan Repetition Mode Change
          Flow Specification Complete
          Inquiry Result with RSSI
          Read Remote Extended Features Complete
          Synchronous Connection Complete
          Synchronous Connection Changed
          Sniff Subrating
          Extended Inquiry Result
          Encryption Key Refresh Complete
          IO Capability Request
          IO Capability Request Reply
          User Confirmation Request
          User Passkey Request
          Remote OOB Data Request
          Simple Pairing Complete
          Link Supervision Timeout Changed
          Enhanced Flush Complete
          User Passkey Notification
          Keypress Notification
          Remote Host Supported Features Notification
          LE Meta
> HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.199255
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
                         [hci0] 298.214150
        Supported: 0x01
        Simultaneous: 0x01
> HCI Event: Command Complete (0x0e) plen 4                                                     [hci0] 298.214499
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
                         [hci0] 302.516667
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: D2:A7:4C:76:F3:E0 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 302.517237
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                       [hci0] 302.658079
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: D2:A7:4C:76:F3:E0 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
> ACL Data RX: Handle 64 flags 0x02 dlen 16                                                     [hci0] 307.789579
      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
        Min interval: 6
        Max interval: 12
        Slave latency: 0
        Timeout multiplier: 400
< HCI Command: LE Connection Update (0x08|0x0013) plen 14
                         [hci0] 307.813788
        Handle: 64
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 15.00 msec (0x000c)
        Connection latency: 0x0000
        Supervision timeout: 4000 msec (0x0190)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 307.814226
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
< ACL Data TX: Handle 64 flags 0x00 dlen 10
                         [hci0] 307.837601
      LE L2CAP: Connection Parameter Update Response (0x13) ident 0 len 2
        Result: Connection Parameters accepted (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 308.157176
        Num handles: 1
        Handle: 64
        Count: 1
> HCI Event: LE Meta Event (0x3e) plen 10                                                       [hci0] 308.272198
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 64
        Connection interval: 15.00 msec (0x000c)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 4000 msec (0x0190)
< ACL Data TX: Handle 64 flags 0x00 dlen 11
                         [hci0] 315.133782
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardOnly (0x02)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, Legacy, No Keypresses (0x05)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey Sign (0x05)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                     [hci0] 315.157207
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: Sign (0x04)
        Responder key distribution: EncKey (0x01)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
                         [hci0] 315.165422
> HCI Event: Command Complete (0x0e) plen 10                                                    [hci0] 315.165792
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: B8:27:EB:15:50:70 (Raspberry Pi Foundation)
< ACL Data TX: Handle 64 flags 0x00 dlen 21
                         [hci0] 315.183781
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 12e170d20c0bb8beb6d7c59bb006acd0
> HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.187419
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.202330
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 6e0be0cc5a8f08ffc98a88c25167aa2f
< ACL Data TX: Handle 64 flags 0x00 dlen 21
                         [hci0] 315.219695
      SMP: Pairing Random (0x04) len 16
        Random value: 25498f1cc873d7450460df3b5ce2ab7e
> ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.247316
      SMP: Pairing Random (0x04) len 16
        Random value: 9e7769acf6f4c19706f9abde25d4749f
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
                         [hci0] 315.256836
        Handle: 64
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 7689a6b5371537b24f2c7c7805688df6
> HCI Event: Command Status (0x0f) plen 4                                                       [hci0] 315.257310
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Change (0x08) plen 4                                                    [hci0] 315.337302
        Status: Success (0x00)
        Handle: 64
        Encryption: Enabled with AES-CCM (0x01)
> ACL Data RX: Handle 64 flags 0x02 dlen 21                                                     [hci0] 315.367776
      SMP: Encryption Information (0x06) len 16
        Long term key: b22ef80c481a8b4929e7159e0c2b0ba3
> ACL Data RX: Handle 64 flags 0x02 dlen 15                                                     [hci0] 315.397264
      SMP: Master Identification (0x07) len 10
        EDIV: 0x02ee
        Rand: 0x0720e828075f93eb
> HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.407288
        Num handles: 1
        Handle: 64
        Count: 1
< ACL Data TX: Handle 64 flags 0x00 dlen 21
                         [hci0] 315.416056
      SMP: Encryption Information (0x06) len 16
        Long term key: ffeeddccbbaa99887766554433221100
< ACL Data TX: Handle 64 flags 0x00 dlen 15
                         [hci0] 315.425880
      SMP: Master Identification (0x07) len 10
        EDIV: 0x000c
        Rand: 0x8877665544332211
< ACL Data TX: Handle 64 flags 0x00 dlen 21
                         [hci0] 315.433926
      SMP: Signing Information (0x0a) len 16
        Signature key: ffeeddccbbaa99887766554433221100
> ACL Data RX: Handle 64 flags 0x02 dlen 6                                                      [hci0] 315.442266
      SMP: Pairing Failed (0x05) len 1
        Reason: Unspecified reason (0x08)
> HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.442543
        Num handles: 1
        Handle: 64
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                          [hci0] 315.532771
        Num handles: 1
        Handle: 64
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4                                                  [hci0] 315.532868
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)
