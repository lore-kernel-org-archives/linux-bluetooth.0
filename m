Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67563C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F152076B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgFAUr6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgFAUr6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 16:47:58 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208015] Logitech K380 pairs but cannot connect
Date:   Mon, 01 Jun 2020 20:47:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gm4jervin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208015-62941-QJIQNcJGzM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208015-62941@https.bugzilla.kernel.org/>
References: <bug-208015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208015

--- Comment #2 from Joseph Ervin (gm4jervin@gmail.com) ---
Interestingly, I pulled the USB bluetooth dongle and reinserted it, and then
things worked on the next try.  Here's the btmon output of a successful
connection. Note, I unpaired the keyboard and tried pairing it again and it
failed, and pulling the dongle didn't work, so I don't think that's really
related, or a workaround. 


> HCI Event: Connect Request (0x04) plen 10                                    
>                                                #1756 [hci0] 4834.006397
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7                  
                                               #1757 [hci0] 4834.006471
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                                      
>                                                #1758 [hci0] 4834.008364
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                                         
>                                                #1759 [hci0] 4834.167371
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                   
>                                                #1760 [hci0] 4834.174407
        Status: Success (0x00)
        Handle: 11
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2             
                                               #1761 [hci0] 4834.174565
        Handle: 11
> HCI Event: Command Status (0x0f) plen 4                                      
>                                                #1762 [hci0] 4834.175368
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1                          
                                               #1763 [hci0] 4834.175423
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                                #1764 [hci0] 4834.176409
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11                     
>                                                #1765 [hci0] 4834.183368
        Status: Success (0x00)
        Handle: 11
        Features: 0xbc 0x04 0x82 0x78 0x00 0x06 0x79 0x83
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Channel quality driven data rate (CQDDR)
          Paging parameter negotiation
          Broadcast Encryption
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Sniff subrating
          Pause encryption
          Extended Inquiry Response
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Extended features
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3              
                                               #1766 [hci0] 4834.183446
        Handle: 11
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                                      
>                                                #1767 [hci0] 4834.184373
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13                      
>                                                #1768 [hci0] 4834.187389
        Status: Success (0x00)
        Handle: 11
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10                       
                                               #1769 [hci0] 4834.187444
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 11 flags 0x00 dlen 10                                    
                                               #1770 [hci0] 4834.187459
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Link Key Request (0x17) plen 6                                    
>                                                #1771 [hci0] 4834.189418
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
> HCI Event: Command Status (0x0f) plen 4                                      
>                                                #1772 [hci0] 4834.190382
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22                    
                                               #1773 [hci0] 4834.190437
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Link key: 5809d35d40d10613e9135c086d2d1d6e
> ACL Data RX: Handle 11 flags 0x02 dlen 16                                    
>                                                #1774 [hci0] 4834.193249
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000280
          Fixed Channels
          Unicast Connectionless Data Reception
< ACL Data TX: Handle 11 flags 0x00 dlen 10                                    
                                               #1775 [hci0] 4834.193267
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> HCI Event: Command Complete (0x0e) plen 10                                   
>                                                #1776 [hci0] 4834.195361
      Link Key Request Reply (0x01|0x000b) ncmd 1
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
> ACL Data RX: Handle 11 flags 0x02 dlen 20                                    
>                                                #1777 [hci0] 4834.196987
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000006
          L2CAP Signaling (BR/EDR)
          Connectionless reception
> HCI Event: Remote Name Req Complete (0x07) plen 255                          
>                                                #1778 [hci0] 4834.212362
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Name: Keyboard K380
@ MGMT Event: Device Connected (0x000b) plen 33                                
                                            {0x0001} [hci0] 4834.212400
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Flags: 0x00000000
        Data length: 20
        Name (complete): Keyboard K380
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
@ MGMT Event: Device Connected (0x000b) plen 33                                
                                            {0x0002} [hci0] 4834.212400
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Flags: 0x00000000
        Data length: 20
        Name (complete): Keyboard K380
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1779 [hci0] 4834.213376
        Num handles: 1
        Handle: 11
        Count: 2
> HCI Event: Encryption Change (0x08) plen 4                                   
>                                                #1780 [hci0] 4834.222367
        Status: Success (0x00)
        Handle: 11
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2                   
                                               #1781 [hci0] 4834.222447
        Handle: 11
> HCI Event: Command Complete (0x0e) plen 7                                    
>                                                #1782 [hci0] 4834.223376
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 11
        Key size: 16
> ACL Data RX: Handle 11 flags 0x02 dlen 12                                    
>                                                #1783 [hci0] 4834.225757
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 17 (0x0011)
        Source CID: 64
< ACL Data TX: Handle 11 flags 0x00 dlen 16                                    
                                               #1784 [hci0] 4834.225799
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 12                                    
                                               #1785 [hci0] 4834.225804
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 64
        Flags: 0x0000
> ACL Data RX: Handle 11 flags 0x02 dlen 16                                    
>                                                #1786 [hci0] 4834.229501
      L2CAP: Configure Request (0x04) ident 3 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 48
< ACL Data TX: Handle 11 flags 0x00 dlen 18                                    
                                               #1787 [hci0] 4834.229554
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 48
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1788 [hci0] 4834.230363
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 14                                    
>                                                #1789 [hci0] 4834.230751
      L2CAP: Configure Response (0x05) ident 3 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> ACL Data RX: Handle 11 flags 0x02 dlen 12                                    
>                                                #1790 [hci0] 4834.234485
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 19 (0x0013)
        Source CID: 65
< ACL Data TX: Handle 11 flags 0x00 dlen 16                                    
                                               #1791 [hci0] 4834.234548
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 65
        Source CID: 65
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 11 flags 0x00 dlen 16                                    
                                               #1792 [hci0] 4834.234637
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 65
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 12                                    
                                               #1793 [hci0] 4834.234648
      L2CAP: Configure Request (0x04) ident 4 len 4
        Destination CID: 65
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1794 [hci0] 4834.237375
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 16                                    
>                                                #1795 [hci0] 4834.239503
      L2CAP: Configure Request (0x04) ident 5 len 8
        Destination CID: 65
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 48
< ACL Data TX: Handle 11 flags 0x00 dlen 18                                    
                                               #1796 [hci0] 4834.239515
      L2CAP: Configure Response (0x05) ident 5 len 10
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 48
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1797 [hci0] 4834.240399
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 14                                    
>                                                #1798 [hci0] 4834.240755
      L2CAP: Configure Response (0x05) ident 4 len 6
        Source CID: 65
        Flags: 0x0000
        Result: Success (0x0000)
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1799 [hci0] 4834.244190
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1800 [hci0] 4834.247364
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 25                                    
>                                                #1801 [hci0] 4834.280740
      Channel: 65 len 21 [PSM 19 mode Basic (0x00)] {chan 1}
        a1 11 ff 06 00 32 14 00 00 00 00 00 00 00 00 00  .....2..........
        00 00 00 00 00                                   .....           
> ACL Data RX: Handle 11 flags 0x02 dlen 25                                    
>                                                #1802 [hci0] 4834.281984
      Channel: 65 len 21 [PSM 19 mode Basic (0x00)] {chan 1}
        a1 11 ff 0c 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> HCI Event: Mode Change (0x14) plen 6                                         
>                                                #1803 [hci0] 4834.284361
        Status: Success (0x00)
        Handle: 11
        Mode: Sniff (0x02)
        Interval: 12.500 msec (0x0014)
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1804 [hci0] 4834.295630
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1805 [hci0] 4834.295696
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
< HCI Command: Exit Sniff Mode (0x02|0x0004) plen 2                            
                                               #1806 [hci0] 4834.295706
        Handle: 11
> HCI Event: Command Status (0x0f) plen 4                                      
>                                                #1807 [hci0] 4834.297361
      Exit Sniff Mode (0x02|0x0004) ncmd 1
        Status: Success (0x00)
< ACL Data TX: Handle 11 flags 0x00 dlen 7                                     
                                               #1808 [hci0] 4834.299140
      Channel: 65 len 3 [PSM 19 mode Basic (0x00)] {chan 3}
        a2 01 01                                         ...             
> HCI Event: Mode Change (0x14) plen 6                                         
>                                                #1809 [hci0] 4834.313237
        Status: Success (0x00)
        Handle: 11
        Mode: Active (0x00)
        Interval: 0.000 msec (0x0000)
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1810 [hci0] 4834.313246
      Channel: 65 len 3 [PSM 19 mode Basic (0x00)] {chan 1}
        a1 03 08                                         ...             
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1811 [hci0] 4834.316365
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1812 [hci0] 4834.316982
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1813 [hci0] 4834.317032
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 25                                    
>                                                #1814 [hci0] 4834.318235
      Channel: 65 len 21 [PSM 19 mode Basic (0x00)] {chan 1}
        a1 11 ff 0c 00 01 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00                                   .....           
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1815 [hci0] 4834.321988
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1816 [hci0] 4834.322242
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1817 [hci0] 4834.326363
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1818 [hci0] 4834.326983
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1819 [hci0] 4834.327599
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1820 [hci0] 4834.331988
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1821 [hci0] 4834.332044
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1822 [hci0] 4834.336366
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1823 [hci0] 4834.336986
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1824 [hci0] 4834.337058
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1825 [hci0] 4834.340754
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1826 [hci0] 4834.346481
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1827 [hci0] 4834.350386
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1828 [hci0] 4834.350751
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1829 [hci0] 4834.350878
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1830 [hci0] 4834.354489
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1831 [hci0] 4834.370245
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1832 [hci0] 4834.375365
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1833 [hci0] 4834.375734
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1834 [hci0] 4834.376266
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1835 [hci0] 4834.381990
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1836 [hci0] 4834.383343
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1837 [hci0] 4834.386364
        Num handles: 1
        Handle: 11
        Count: 2
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1838 [hci0] 4834.386985
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
< ACL Data TX: Handle 11 flags 0x00 dlen 6                                     
                                               #1839 [hci0] 4834.387088
      Channel: 64 len 2 [PSM 17 mode Basic (0x00)] {chan 2}
        41 03                                            A.              
> ACL Data RX: Handle 11 flags 0x02 dlen 7                                     
>                                                #1840 [hci0] 4834.391988
      Channel: 64 len 3 [PSM 17 mode Basic (0x00)] {chan 0}
        a1 03 08                                         ...             
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                                #1841 [hci0] 4834.578389
        Num handles: 1
        Handle: 11
        Count: 1
> HCI Event: Mode Change (0x14) plen 6                                         
>                                                #1842 [hci0] 4835.317374
        Status: Success (0x00)
        Handle: 11
        Mode: Sniff (0x02)
        Interval: 12.500 msec (0x0014)

-- 
You are receiving this mail because:
You are the assignee for the bug.
