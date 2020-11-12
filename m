Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDAC388F7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7155120872
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 12:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="mxEoZgQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgKLMQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKLMQm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 07:16:42 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DFC0613D1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 04:16:42 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CX0vW3xjrzQlWw;
        Thu, 12 Nov 2020 13:16:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1605183397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=buFdH3lWqqFMc3OdTfZ6r8bOn7nnIrade7iLlkKkGH0=;
        b=mxEoZgQjZdezuFdskeoDAxqQX41/R+u/iSNoADf9bxQZ5wlG4YhBT8BMO9NU9kpevYrb64
        /Zm3kGO96P6fvX4jYnLCJI6URTTWR/yPpCwos/2ELOxNWMxhQ/ot4WNmTBlGe5V5G9OY01
        Oa+tPV+FQA9j+kL3bZRDEY/fyFvJxiQHpzcuxbVK4P6EdIDgV2TnWjxRo8V2L1AxYHj/VV
        1XZD/pENelHI2m0VLy97MUjc5p8N6Ceq447hqOifIfW7n2xIyTaiRWqxSoOp4WqXCIcN44
        9nSqQydcsMLTP0DqQcxq2NvBpvf1Fj6yXtRflADa/0+lM85pIZFOXd2NMsaEfw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id gKAU-xg1g6MF; Thu, 12 Nov 2020 13:16:16 +0100 (CET)
Date:   Thu, 12 Nov 2020 13:16:14 +0100
From:   Devin Bayer <dev@doubly.so>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Michael N. Moran" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE Advertising: Command Disallowed
Message-ID: <20201112121614.c5kko4iofg32ckxs@orac>
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org>
 <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
 <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
 <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so>
 <CAO1O6sefGxgwcesfu8qEFSX_HDRFFf8NW7ugyvXT=rSBVUMGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1O6sefGxgwcesfu8qEFSX_HDRFFf8NW7ugyvXT=rSBVUMGYw@mail.gmail.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -1.88 / 15.00 / 15.00
X-Rspamd-Queue-Id: 52D691726
X-Rspamd-UID: c5621b
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 11, 2020 at 11:00:32PM +0000, Emil Lenngren wrote:
> 
> It would be good to see the complete log from when the "Reset" command
> is issued, otherwise we don't know in which "state" the controller is
> in at the various commands. Also widen the command window when running
> btmon so we see the complete names. :)
> Seeing the result from "LE Read Supported States" would also be nice.
> 

Hi Emil,

below is the complete log, starting with the the reset command. It
includes the "Supported States" call too. Let me know if there is
anything else I can do.

~ Devin

Bluetooth monitor ver 5.53
= Note: Linux version 5.8.0-26-generic (x86_64)                                            0.384781
= Note: Bluetooth subsystem version 2.22                                                   0.384783
= New Index: DC:FB:48:24:13:5E (Primary,USB,hci0)                                   [hci0] 0.384784
= Open Index: DC:FB:48:24:13:5E                                                     [hci0] 0.384784
= Index Info: DC:FB:48:24:13:5E (Intel Corp.)                                       [hci0] 0.384785
@ MGMT Open: btmon (privileged) version 1.17                                      {0x0001} 0.384851
@ RAW Open: hciconfig (privileged) version 2.22                                   {0x0002} 1.207461
< HCI Command: Reset (0x03|0x0003) plen 0                                        #1 [hci0] 1.207523
> HCI Event: Command Complete (0x0e) plen 4                                      #2 [hci0] 1.337162
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
@ MGMT Event: New Settings (0x0006) plen 4                                 {0x0001} [hci0] 1.337400
        Current settings: 0x00000686
          Connectable
          Fast Connectable
          BR/EDR
          Low Energy
          Advertising
= Close Index: DC:FB:48:24:13:5E                                                    [hci0] 1.337406
= Open Index: DC:FB:48:24:13:5E                                                     [hci0] 1.337800
< HCI Command: Reset (0x03|0x0003) plen 0                                        #3 [hci0] 1.337808
> HCI Event: Command Complete (0x0e) plen 4                                      #4 [hci0] 1.347045
      Reset (0x03|0x0003) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0                #5 [hci0] 1.347107
> HCI Event: Command Complete (0x0e) plen 12                                     #6 [hci0] 1.348034
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
          Power control
          Transparent synchronous data
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0               #7 [hci0] 1.348046
> HCI Event: Command Complete (0x0e) plen 12                                     #8 [hci0] 1.349037
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.1 (0x0a) - Revision 256 (0x0100)
        LMP version: Bluetooth 5.1 (0x0a) - Subversion 256 (0x0100)
        Manufacturer: Intel Corp. (2)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0                                 #9 [hci0] 1.349074
> HCI Event: Command Complete (0x0e) plen 10                                    #10 [hci0] 1.350009
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: DC:FB:48:24:13:5E (Intel Corporate)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0                            #11 [hci0] 1.350259
> HCI Event: Command Complete (0x0e) plen 11                                    #12 [hci0] 1.351164
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 4
        SCO MTU: 96   SCO max packet: 6
< HCI Command: Read Class of Device (0x03|0x0023) plen 0                        #13 [hci0] 1.351215
> HCI Event: Command Complete (0x0e) plen 7                                     #14 [hci0] 1.352162
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0                             #15 [hci0] 1.352212
> HCI Event: Command Complete (0x0e) plen 252                                   #16 [hci0] 1.356200
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name:
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0                          #17 [hci0] 1.356222
> HCI Event: Command Complete (0x0e) plen 6                                     #18 [hci0] 1.357165
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0060
          Input Coding: Linear
          Input Data Format: 2's complement
          Input Sample Size: 16-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0                #19 [hci0] 1.357224
> HCI Event: Command Complete (0x0e) plen 5                                     #20 [hci0] 1.357998
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0                        #21 [hci0] 1.358040
> HCI Event: Command Complete (0x0e) plen 8                                     #22 [hci0] 1.359210
      Read Current IAC LAP (0x03|0x0039) ncmd 2
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1                            #23 [hci0] 1.359237
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                     #24 [hci0] 1.360166
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2             #25 [hci0] 1.360175
        Timeout: 20000.000 msec (0x7d00)
> HCI Event: Command Complete (0x0e) plen 4                                     #26 [hci0] 1.361162
      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Buffer Size (0x08|0x0002) plen 0                         #27 [hci0] 1.361203
> HCI Event: Command Complete (0x0e) plen 7                                     #28 [hci0] 1.362010
      LE Read Buffer Size (0x08|0x0002) ncmd 1
        Status: Success (0x00)
        Data packet length: 251
        Num data packets: 3
< HCI Command: LE Read Local Supported Features (0x08|0x0003) plen 0            #29 [hci0] 1.362091
> HCI Event: Command Complete (0x0e) plen 12                                    #30 [hci0] 1.363134
      LE Read Local Supported Features (0x08|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xff 0x59 0x00 0x08 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
          LE 2M PHY
          LE Coded PHY
          LE Extended Advertising
          Channel Selection Algorithm #2
          Remote Public Key Validation
< HCI Command: LE Read Supported States (0x08|0x001c) plen 0                    #31 [hci0] 1.363181
> HCI Event: Command Complete (0x0e) plen 12                                    #32 [hci0] 1.363998
      LE Read Supported States (0x08|0x001c) ncmd 1
        Status: Success (0x00)
        States: 0x000003ffffffffff
          Non-connectable Advertising State
          Scannable Advertising State
          Connectable Advertising State
          High Duty Cycle Directed Advertising State
          Passive Scanning State
          Active Scanning State
          Initiating State
            and Connection State (Master Role)
          Connection State (Slave Role)
          Non-connectable Advertising State
            and Passive Scanning State
          Scannable Advertising State
            and Passive Scanning State
          Connectable Advertising State
            and Passive Scanning State
          High Duty Cycle Directed Advertising State
            and Passive Scanning State
          Non-connectable Advertising State
            and Active Scanning State
          Scannable Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Active Scanning State
          High Duty Cycle Directed Advertising State
            and Active Scanning State
          Non-connectable Advertising State
            and Initiating State
          Scannable Advertising State
            and Initiating State
          Non-connectable Advertising State
            and Connection State (Master Role)
          Scannable Advertising State
            and Connection State (Master Role)
          Non-connectable Advertising State
            and Connection State (Slave Role)
          Scannable Advertising State
            and Connection State (Slave Role)
          Passive Scanning State
            and Initiating State
          Active Scanning State
            and Initiating State
          Passive Scanning State
            and Connection State (Master Role)
          Active Scanning State
            and Connection State (Master Role)
          Passive Scanning State
            and Connection State (Slave Role)
          Active Scanning State
            and Connection State (Slave Role)
          Initiating State
            and Connection State (Master Role)
            and Master Role & Master Role
          Low Duty Cycle Directed Advertising State
          Low Duty Cycle Directed Advertising State
            and Passive Scanning State
          Low Duty Cycle Directed Advertising State
            and Active Scanning State
          Connectable Advertising State
            and Initiating State
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Initiating State
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Master Role)
            and Master Role & Slave Role
          Connectable Advertising State
            and Connection State (Slave Role)
            and Master Role & Slave Role
          High Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Low Duty Cycle Directed Advertising State
            and Connection State (Slave Role)
            and Slave Role & Slave Role
          Initiating State
            and Connection State (Slave Role)
            and Master Role & Slave Role
< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0               #33 [hci0] 1.364042
> HCI Event: Command Complete (0x0e) plen 68                                    #34 [hci0] 1.366015
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 215 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Add SCO Connection (Octet 0 - Bit 6)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Authentication Enable (Octet 8 - Bit 4)
          Write Authentication Enable (Octet 8 - Bit 5)
          Read Encryption Mode (Octet 8 - Bit 6)
          Write Encryption Mode (Octet 8 - Bit 7)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Read Page Scan Mode (Octet 11 - Bit 7)
          Write Page Scan Mode (Octet 12 - Bit 0)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Read LE Host Supported (Octet 24 - Bit 5)
          Write LE Host Supported (Octet 24 - Bit 6)
          LE Set Event Mask (Octet 25 - Bit 0)
          LE Read Buffer Size (Octet 25 - Bit 1)
          LE Read Local Supported Features (Octet 25 - Bit 2)
          LE Set Random Address (Octet 25 - Bit 4)
          LE Set Advertising Parameters (Octet 25 - Bit 5)
          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
          LE Set Advertising Data (Octet 25 - Bit 7)
          LE Set Scan Response Data (Octet 26 - Bit 0)
          LE Set Advertise Enable (Octet 26 - Bit 1)
          LE Set Scan Parameters (Octet 26 - Bit 2)
          LE Set Scan Enable (Octet 26 - Bit 3)
          LE Create Connection (Octet 26 - Bit 4)
          LE Create Connection Cancel (Octet 26 - Bit 5)
          LE Read White List Size (Octet 26 - Bit 6)
          LE Clear White List (Octet 26 - Bit 7)
          LE Add Device To White List (Octet 27 - Bit 0)
          LE Remove Device From White List (Octet 27 - Bit 1)
          LE Connection Update (Octet 27 - Bit 2)
          LE Set Host Channel Classification (Octet 27 - Bit 3)
          LE Read Channel Map (Octet 27 - Bit 4)
          LE Read Remote Used Features (Octet 27 - Bit 5)
          LE Encrypt (Octet 27 - Bit 6)
          LE Rand (Octet 27 - Bit 7)
          LE Start Encryption (Octet 28 - Bit 0)
          LE Long Term Key Request Reply (Octet 28 - Bit 1)
          LE Long Term Key Request Neg Reply (Octet 28 - Bit 2)
          LE Read Supported States (Octet 28 - Bit 3)
          LE Receiver Test (Octet 28 - Bit 4)
          LE Transmitter Test (Octet 28 - Bit 5)
          LE Test End (Octet 28 - Bit 6)
          Enhanced Setup Synchronous Connection (Octet 29 - Bit 3)
          Enhanced Accept Synchronous Connection Request (Octet 29 - Bit 4)
          Read Local Supported Codecs (Octet 29 - Bit 5)
          Set External Frame Configuration (Octet 29 - Bit 7)
          Remote OOB Extended Data Request Reply (Octet 32 - Bit 1)
          Read Secure Connections Host Support (Octet 32 - Bit 2)
          Write Secure Connections Host Support (Octet 32 - Bit 3)
          Read Authenticated Payload Timeout (Octet 32 - Bit 4)
          Write Authenticated Payload Timeout (Octet 32 - Bit 5)
          Read Local OOB Extended Data (Octet 32 - Bit 6)
          Write Secure Connections Test Mode (Octet 32 - Bit 7)
          Read Extended Page Timeout (Octet 33 - Bit 0)
          Write Extended Page Timeout (Octet 33 - Bit 1)
          Read Extended Inquiry Length (Octet 33 - Bit 2)
          Write Extended Inquiry Length (Octet 33 - Bit 3)
          LE Remote Connection Parameter Request Reply (Octet 33 - Bit 4)
          LE Remote Connection Parameter Request Negative Reply (Octet 33 - Bit 5)
          LE Set Data Length (Octet 33 - Bit 6)
          LE Read Suggested Default Data Length (Octet 33 - Bit 7)
          LE Write Suggested Default Data Length (Octet 34 - Bit 0)
          LE Read Local P-256 Public Key (Octet 34 - Bit 1)
          LE Generate DHKey (Octet 34 - Bit 2)
          LE Add Device To Resolving List (Octet 34 - Bit 3)
          LE Remove Device From Resolving List (Octet 34 - Bit 4)
          LE Clear Resolving List (Octet 34 - Bit 5)
          LE Read Resolving List Size (Octet 34 - Bit 6)
          LE Read Peer Resolvable Address (Octet 34 - Bit 7)
          LE Read Local Resolvable Address (Octet 35 - Bit 0)
          LE Set Address Resolution Enable (Octet 35 - Bit 1)
          LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
          LE Read Maximum Data Length (Octet 35 - Bit 3)
          LE Read PHY (Octet 35 - Bit 4)
          LE Set Default PHY (Octet 35 - Bit 5)
          LE Set PHY (Octet 35 - Bit 6)
          LE Enhanced Receiver Test (Octet 35 - Bit 7)
          LE Enhanced Transmitter Test (Octet 36 - Bit 0)
          LE Set Advertising Set Random Address (Octet 36 - Bit 1)
          LE Set Extended Advertising Parameters (Octet 36 - Bit 2)
          LE Set Extended Advertising Data (Octet 36 - Bit 3)
          LE Set Extended Scan Response Data (Octet 36 - Bit 4)
          LE Set Extended Advertising Enable (Octet 36 - Bit 5)
          LE Read Maximum Advertising Data Length (Octet 36 - Bit 6)
          LE Read Number of Supported Advertising Sets (Octet 36 - Bit 7)
          LE Remove Advertising Set (Octet 37 - Bit 0)
          LE Clear Advertising Sets (Octet 37 - Bit 1)
          LE Set Extended Scan Parameters (Octet 37 - Bit 5)
          LE Set Extended Scan Enable (Octet 37 - Bit 6)
          LE Extended Create Connection (Octet 37 - Bit 7)
          LE Read Transmit Power (Octet 38 - Bit 7)
          LE Read RF Path Compensation (Octet 39 - Bit 0)
          LE Write RF Path Compensation (Octet 39 - Bit 1)
          LE Set Privacy Mode (Octet 39 - Bit 2)
          Octet 41 - Bit 3
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241           #35 [hci0] 1.366024
        FEC: Not required (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                     #36 [hci0] 1.367022
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1                          #37 [hci0] 1.367067
        Mode: Inquiry Result with RSSI or Extended Inquiry Result (0x02)
> HCI Event: Command Complete (0x0e) plen 4                                     #38 [hci0] 1.368161
      Write Inquiry Mode (0x03|0x0045) ncmd 2
        Status: Success (0x00)
< HCI Command: Read Inquiry Response TX Power Level (0x03|0x0058) plen 0        #39 [hci0] 1.368203
> HCI Event: Command Complete (0x0e) plen 5                                     #40 [hci0] 1.369160
      Read Inquiry Response TX Power Level (0x03|0x0058) ncmd 1
        Status: Success (0x00)
        TX power: 12 dbm (0x0c)
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1                #41 [hci0] 1.369204
        Page: 1
> HCI Event: Command Complete (0x0e) plen 14                                    #42 [hci0] 1.370018
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 1/2
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Set Event Mask (0x03|0x0001) plen 8                              #43 [hci0] 1.370270
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
> HCI Event: Command Complete (0x0e) plen 4                                     #44 [hci0] 1.370998
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7                        #45 [hci0] 1.371040
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Read all: 0x01
> HCI Event: Command Complete (0x0e) plen 8                                     #46 [hci0] 1.372045
      Read Stored Link Key (0x03|0x000d) ncmd 1
        Status: Success (0x00)
        Max num keys: 5
        Num keys: 0
< HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2          #47 [hci0] 1.372055
        Link policy: 0x0005
          Enable Role Switch
          Enable Sniff Mode
> HCI Event: Command Complete (0x0e) plen 4                                     #48 [hci0] 1.373175
      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Page Scan Activity (0x03|0x001b) plen 0                     #49 [hci0] 1.373219
> HCI Event: Command Complete (0x0e) plen 8                                     #50 [hci0] 1.374046
      Read Page Scan Activity (0x03|0x001b) ncmd 2
        Status: Success (0x00)
        Interval: 1280.000 msec (0x0800)
        Window: 11.250 msec (0x0012)
< HCI Command: Read Default Erroneous Data Reporting (0x03|0x005a) plen 0       #51 [hci0] 1.374093
> HCI Event: Command Complete (0x0e) plen 5                                     #52 [hci0] 1.375010
      Read Default Erroneous Data Reporting (0x03|0x005a) ncmd 1
        Status: Success (0x00)
        Mode: Disabled (0x00)
< HCI Command: Read Page Scan Type (0x03|0x0046) plen 0                         #53 [hci0] 1.375194
> HCI Event: Command Complete (0x0e) plen 5                                     #54 [hci0] 1.376167
      Read Page Scan Type (0x03|0x0046) ncmd 2
        Status: Success (0x00)
        Type: Standard Scan (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8                           #55 [hci0] 1.376186
        Mask: 0x00000000000a1fff
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
          LE Remote Connection Parameter Request
          LE Data Length Change
          LE Read Local P-256 Public Key Complete
          LE Generate DHKey Complete
          LE Enhanced Connection Complete
          LE Direct Advertising Report
          LE PHY Update Complete
          LE Extended Advertising Report
          LE Extended Advertising Set Terminated
          LE Channel Selection Algorithm
> HCI Event: Command Complete (0x0e) plen 4                                     #56 [hci0] 1.377031
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read White List Size (0x08|0x000f) plen 0                     #57 [hci0] 1.377080
> HCI Event: Command Complete (0x0e) plen 5                                     #58 [hci0] 1.378169
      LE Read White List Size (0x08|0x000f) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear White List (0x08|0x0010) plen 0                         #59 [hci0] 1.378217
> HCI Event: Command Complete (0x0e) plen 4                                     #60 [hci0] 1.379071
      LE Clear White List (0x08|0x0010) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Resolving List Size (0x08|0x002a) plen 0                 #61 [hci0] 1.379146
> HCI Event: Command Complete (0x0e) plen 5                                     #62 [hci0] 1.380175
      LE Read Resolving List Size (0x08|0x002a) ncmd 1
        Status: Success (0x00)
        Size: 25
< HCI Command: LE Clear Resolving List (0x08|0x0029) plen 0                     #63 [hci0] 1.380224
> HCI Event: Command Complete (0x0e) plen 4                                     #64 [hci0] 1.381126
      LE Clear Resolving List (0x08|0x0029) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Read Maximum Data Length (0x08|0x002f) plen 0                 #65 [hci0] 1.381155
> HCI Event: Command Complete (0x0e) plen 12                                    #66 [hci0] 1.382060
      LE Read Maximum Data Length (0x08|0x002f) ncmd 1
        Status: Success (0x00)
        Max TX octets: 251
        Max TX time: 17040
        Max RX octets: 251
        Max RX time: 17040
< HCI Command: LE Read Suggested Default Data Length (0x08|0x0023) plen 0       #67 [hci0] 1.382086
> HCI Event: Command Complete (0x0e) plen 8                                     #68 [hci0] 1.383033
      LE Read Suggested Default Data Length (0x08|0x0023) ncmd 1
        Status: Success (0x00)
        TX octets: 27
        TX time: 328
< HCI Command: LE Read Number of Supported Advertising... (0x08|0x003b) plen 0  #69 [hci0] 1.383225
> HCI Event: Command Complete (0x0e) plen 5                                     #70 [hci0] 1.384070
      LE Read Number of Supported Advertising Sets (0x08|0x003b) ncmd 1
        Status: Success (0x00)
        Num supported adv sets: 6
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2                     #71 [hci0] 1.384241
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4                                     #72 [hci0] 1.385079
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Extended Features (0x04|0x0004) plen 1                #73 [hci0] 1.385089
        Page: 2
> HCI Event: Command Complete (0x0e) plen 14                                    #74 [hci0] 1.386017
      Read Local Extended Features (0x04|0x0004) ncmd 1
        Status: Success (0x00)
        Page: 2/2
        Features: 0x20 0x0b 0x00 0x00 0x00 0x00 0x00 0x00
          Generalized interlaced scan
          Secure Connections (Controller Support)
          Ping
          Train nudging
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7                      #75 [hci0] 1.386279
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 6                                     #76 [hci0] 1.387183
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Success (0x00)
        Num keys: 0
< HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8                       #77 [hci0] 1.387233
        Mask: 0x0000000000800000
          Authenticated Payload Timeout Expired
> HCI Event: Command Complete (0x0e) plen 4                                     #78 [hci0] 1.388184
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Codecs (0x04|0x000b) plen 0                 #79 [hci0] 1.388204
> HCI Event: Command Complete (0x0e) plen 12                                    #80 [hci0] 1.389190
      Read Local Supported Codecs (0x04|0x000b) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 6
          Codec: u-law log (0x00)
          Codec: A-law log (0x01)
          Codec: CVSD (0x02)
          Codec: Transparent (0x03)
          Codec: Linear PCM (0x04)
          Codec: mSBC (0x05)
        Number of vendor codecs: 0
< HCI Command: Unknown (0x04|0x000c) plen 0                                     #81 [hci0] 1.389226
> HCI Event: Command Complete (0x0e) plen 6                                     #82 [hci0] 1.390183
      Unknown (0x04|0x000c) ncmd 1
        Status: Success (0x00)
        01 10                                            ..
< HCI Command: LE Write Suggested Default Data Length (0x08|0x0024) plen 4      #83 [hci0] 1.390203
        TX octets: 251
        TX time: 17040
> HCI Event: Command Complete (0x0e) plen 4                                     #84 [hci0] 1.391183
      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Default PHY (0x08|0x0031) plen 3                          #85 [hci0] 1.391234
        All PHYs preference: 0x00
        TX PHYs preference: 0x01
          LE 1M
        RX PHYs preference: 0x01
          LE 1M
> HCI Event: Command Complete (0x0e) plen 4                                     #86 [hci0] 1.392181
      LE Set Default PHY (0x08|0x0031) ncmd 1
        Status: Success (0x00)
= Index Info: DC:FB:48:24:13:5E (Intel Corp.)                                       [hci0] 1.392279
< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25     #87 [hci0] 1.392397
        Handle: 0x00
        Properties: 0x0013
          Connectable
          Scannable
          Use legacy advertising PDUs: ADV_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5                                     #88 [hci0] 1.393181
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 7 dbm (0x07)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6          #89 [hci0] 1.393225
        Extended advertising: Enabled (0x01)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x00
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4                                     #90 [hci0] 1.394182
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Page Scan Activity (0x03|0x001c) plen 4                    #91 [hci0] 1.394224
        Interval: 160.000 msec (0x0100)
        Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                     #92 [hci0] 1.395178
      Write Page Scan Activity (0x03|0x001c) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Page Scan Type (0x03|0x0047) plen 1                        #93 [hci0] 1.395222
        Type: Interlaced Scan (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                     #94 [hci0] 1.396184
      Write Page Scan Type (0x03|0x0047) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1                           #95 [hci0] 1.396218
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                                     #96 [hci0] 1.397179
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Write Local Name (0x03|0x0013) plen 248                          #97 [hci0] 1.397220
        Name:
> HCI Event: Command Complete (0x0e) plen 4                                     #98 [hci0] 1.398027
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Local Name Changed (0x0008) plen 260                         {0x0001} [hci0] 1.398034
        Name:
        Short name:
< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 35           #99 [hci0] 1.398040
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x03
        TX power: 7 dBm
@ MGMT Event: New Settings (0x0006) plen 4                                 {0x0001} [hci0] 1.398065
        Current settings: 0x00000687
          Powered
          Connectable
          Fast Connectable
          BR/EDR
          Low Energy
          Advertising
@ RAW Close: hciconfig                                                            {0x0002} 1.398073
> HCI Event: Command Complete (0x0e) plen 4                                    #100 [hci0] 1.399037
      LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
        Status: Success (0x00)
@ RAW Open: python (privileged) version 2.22                               {0x0002} [hci0] 5.824942
< HCI Command: Set Event Mask (0x03|0x0001) plen 8                             #101 [hci0] 5.825183
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
> HCI Event: Command Complete (0x0e) plen 4                                    #102 [hci0] 5.941154
      Set Event Mask (0x03|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Event Mask (0x08|0x0001) plen 8                          #103 [hci0] 5.941220
        Mask: 0x000000000000001f
          LE Connection Complete
          LE Advertising Report
          LE Connection Update Complete
          LE Read Remote Used Features Complete
          LE Long Term Key Request
> HCI Event: Command Complete (0x0e) plen 4                                    #104 [hci0] 5.942062
      LE Set Event Mask (0x08|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0             #105 [hci0] 5.942154
> HCI Event: Command Complete (0x0e) plen 12                                   #106 [hci0] 5.943143
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.1 (0x0a) - Revision 256 (0x0100)
        LMP version: Bluetooth 5.1 (0x0a) - Subversion 256 (0x0100)
        Manufacturer: Intel Corp. (2)
< HCI Command: Write LE Host Supported (0x03|0x006d) plen 2                    #107 [hci0] 5.943210
        Supported: 0x01
        Simultaneous: 0x00
> HCI Event: Command Complete (0x0e) plen 4                                    #108 [hci0] 5.944197
      Write LE Host Supported (0x03|0x006d) ncmd 1
        Status: Success (0x00)
< HCI Command: Read LE Host Supported (0x03|0x006c) plen 0                     #109 [hci0] 5.944241
> HCI Event: Command Complete (0x0e) plen 6                                    #110 [hci0] 5.945028
      Read LE Host Supported (0x03|0x006c) ncmd 1
        Status: Success (0x00)
        Supported: 0x01
        Simultaneous: 0x00
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0                               #111 [hci0] 5.945101
> HCI Event: Command Complete (0x0e) plen 10                                   #112 [hci0] 5.946106
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: DC:FB:48:24:13:5E (Intel Corporate)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1                    #113 [hci0] 5.946156
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    #114 [hci0] 5.947194
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15             #115 [hci0] 5.947240
        Min advertising interval: 100.000 msec (0x00a0)
        Max advertising interval: 100.000 msec (0x00a0)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    #116 [hci0] 5.948050
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32                 #117 [hci0] 5.948270
        Length: 6
        Name (short): echo
> HCI Event: Command Complete (0x0e) plen 4                                    #118 [hci0] 5.949022
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32                   #119 [hci0] 5.949029
        Length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xec00)
> HCI Event: Command Complete (0x0e) plen 4                                    #120 [hci0] 5.950051
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1                    #121 [hci0] 5.950099
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                    #122 [hci0] 5.951190
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32                 #123 [hci0] 5.951236
        Length: 6
        Name (short): echo
> HCI Event: Command Complete (0x0e) plen 4                                    #124 [hci0] 5.952022
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Command Disallowed (0x0c)
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32                   #125 [hci0] 5.952032
        Length: 7
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xec00)
> HCI Event: Command Complete (0x0e) plen 4                                    #126 [hci0] 5.953022
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Command Disallowed (0x0c)
@ RAW Close: python                                                        {0x0002} [hci0] 7.889134

