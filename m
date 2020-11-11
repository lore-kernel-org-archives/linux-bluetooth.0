Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC68C4742C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47FE2072C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 17:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="u42HclEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgKKRtp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKRto (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 12:49:44 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0223C0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 09:49:44 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CWXLB1qlZzQlLY
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 18:49:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1605116976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kJDLXWltpms+dqRzEecHjuGf9Up0lyL4pwgly4dY718=;
        b=u42HclEqJNlIi/urY/NQzyQn5q4fG/oZK3tCpr+/+M15pVJZgZqGRIqhQekzVW3z6btMxU
        CnMqiFkNHy/0nYMIdYJidHMghCD5aLuKL92MJP9pJe1Pwt5XBsIneWSUr44rIoA0kho7me
        Fl1914UGUKynVx3mnwAzxijXN+hYxpcTbcD2oFmVhB0di7as9LQLvatzow4m4C0BHme7an
        NJRXmPi0jaeXsZr6kxubBLa29+x+VzrUcyIZJsIKcGMRwFqE9umUDYOCSqMAJGVPzhW57U
        vpAiwIYCeeZPl4auGT3E85YFLDAnWHxrCQC4UC3h0MI2CPN9bjsaivf1KhYOfA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id YctHdFxXM4Ie for <linux-bluetooth@vger.kernel.org>;
        Wed, 11 Nov 2020 18:49:35 +0100 (CET)
To:     linux-bluetooth@vger.kernel.org
From:   Devin Bayer <dev@doubly.so>
Subject: LE Advertising: Command Disallowed
Message-ID: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
Date:   Wed, 11 Nov 2020 18:49:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.87 / 15.00 / 15.00
X-Rspamd-Queue-Id: 35792181E
X-Rspamd-UID: a9b966
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am trying to figure out why I'm getting "Command Disallowed" for the HCI
commands "LE Set Advertise Enable" and "LE Set Advertising Parameters". I've
been trying for a few days to get a GATT service running; first with the D-BUS
API, which occasionally worked but was very unstable. Now I'm trying with HCI
directly with the pybleno / bleno libraries.

I have bluetoothd disabled and I have tried an `hciconfig reset` and reboot.
Unsure what else I can do, I'm asking here.

The errors are these:

> HCI Event: Command Complete (0x0e) plen 4      #14 [hci0] 3.406377
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)

> HCI Event: Command Complete (0x0e) plen 4      #16 [hci0] 3.407380
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Command Disallowed (0x0c)

The complete log follows:

Bluetooth monitor ver 5.53
= Note: Linux version 5.8.0-26-generic (x86_64)             0.408833
= Note: Bluetooth subsystem version 2.22                    0.408835
= New Index: DC:FB:48:24:13:5E (Primary,USB,hci0)    [hci0] 0.408836
= Open Index: DC:FB:48:24:13:5E                      [hci0] 0.408836
= Index Info: DC:FB:48:24:13:5E (Intel Corp.)        [hci0] 0.408837
@ MGMT Open: btmon (privileged) version 1.17       {0x0001} 0.408979
@ RAW Open: py.. (privileged) version 2.22  {0x0002} [hci0] 1.487478
< HCI Command: Set Event... (0x03|0x0001) plen 8  #1 [hci0] 1.487682
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
> HCI Event: Command Complete (0x0e) plen 4       #2 [hci0] 1.605102
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Eve.. (0x08|0x0001) plen 8  #3 [hci0] 1.605163
        Mask: 0x000000000000001f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
> HCI Event: Command Complete (0x0e) plen 4       #4 [hci0] 1.605858
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local.. (0x04|0x0001) plen 0  #5 [hci0] 1.605905
> HCI Event: Command Complete (0x0e) plen 12      #6 [hci0] 1.606854
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.1 (0x0a) - Revision 256 (0x0100)
        LMP version: Bluetooth 5.1 (0x0a) - Subversion 256 (0x0100)
        Manufacturer: Intel Corp. (2)
< HCI Command: Write LE H.. (0x03|0x006d) plen 2  #7 [hci0] 1.606900
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4       #8 [hci0] 1.607854
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read LE Ho.. (0x03|0x006c) plen 0  #9 [hci0] 1.607863
> HCI Event: Command Complete (0x0e) plen 6      #10 [hci0] 1.608862
      Read LE Host Supported (0x03|0x006c) ncmd 1
        Status: Success (0x00)
        Supported: 0x01
        Simultaneous: 0x00
< HCI Command: Read BD A.. (0x04|0x0009) plen 0  #11 [hci0] 1.608916
> HCI Event: Command Complete (0x0e) plen 10     #12 [hci0] 1.610004
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: DC:FB:48:24:13:5E (Intel Corporate)
< HCI Command: LE Set Ad.. (0x08|0x000a) plen 1  #13 [hci0] 1.610132
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4      #14 [hci0] 1.610811
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set A.. (0x08|0x0006) plen 15  #15 [hci0] 1.610893
        Min advertising interval: 100.000 msec (0x00a0)
        Max advertising interval: 100.000 msec (0x00a0)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from
Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4      #16 [hci0] 1.611979
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set S.. (0x08|0x0009) plen 32  #17 [hci0] 1.612322
        Length: 6
        Name (short): echo
> HCI Event: Command Complete (0x0e) plen 4      #18 [hci0] 1.612880
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set A.. (0x08|0x0008) plen 32  #19 [hci0] 1.613007
        Length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xec00)
> HCI Event: Command Complete (0x0e) plen 4      #20 [hci0] 1.613980
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Ad.. (0x08|0x000a) plen 1  #21 [hci0] 1.614025
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4      #22 [hci0] 1.614830
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set S.. (0x08|0x0009) plen 32  #23 [hci0] 1.614913
        Length: 6
        Name (short): echo
> HCI Event: Command Complete (0x0e) plen 4      #24 [hci0] 1.615974
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set A.. (0x08|0x0008) plen 32  #25 [hci0] 1.616018
        Length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xec00)
> HCI Event: Command Complete (0x0e) plen 4      #26 [hci0] 1.616985
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Command Disallowed (0x0c)

Any help / pointers is much appreciated.

~ Dev
