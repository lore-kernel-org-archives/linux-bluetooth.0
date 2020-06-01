Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A3BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893FA206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAQVM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQVL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 12:21:11 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208015] New: Logitech K380 pairs but cannot connect
Date:   Mon, 01 Jun 2020 16:21:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-208015-62941@https.bugzilla.kernel.org/>
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

            Bug ID: 208015
           Summary: Logitech K380 pairs but cannot connect
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.6.14-300.fc32.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: gm4jervin@gmail.com
        Regression: No

I have a logitech K380 which goes through the pair process, either from
bluetoothctl or from the gnome bluetooth control panel, accepting the
keystrokes for the pairing password, right up to the RETURN, and then the
connection fails. 

At that point, bluetoothctl shows it as paired, but it cannot connect. Touching
a key on the keyboard to get it to try to connect shows this in btmon. 


> HCI Event: Connect Request (0x04) plen 10                                    
>                                             #3535 [hci0] 4323.298970
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7                  
                                            #3536 [hci0] 4323.299047
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3537 [hci0] 4323.300969
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                                         
>                                             #3538 [hci0] 4323.458938
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                   
>                                             #3539 [hci0] 4323.464949
        Status: Success (0x00)
        Handle: 11
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2             
                                            #3540 [hci0] 4323.465091
        Handle: 11
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3541 [hci0] 4323.466939
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1                          
                                            #3542 [hci0] 4323.466975
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                             #3543 [hci0] 4323.467935
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11                     
>                                             #3544 [hci0] 4323.474969
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
                                            #3545 [hci0] 4323.475009
        Handle: 11
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3546 [hci0] 4323.475935
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6                                    
>                                             #3547 [hci0] 4323.478966
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22                    
                                            #3548 [hci0] 4323.479030
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Link key: 5a101d47bab277b8dcf5520ed9cd905e
> HCI Event: Read Remote Extended Features (0x23) plen 13                      
>                                             #3549 [hci0] 4323.479964
        Status: Success (0x00)
        Handle: 11
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< ACL Data TX: Handle 11 flags 0x00 dlen 10                                    
                                            #3550 [hci0] 4323.480019
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Complete (0x0e) plen 10                                   
>                                             #3551 [hci0] 4323.483965
      Link Key Request Reply (0x01|0x000b) ncmd 1
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10                       
                                            #3552 [hci0] 4323.484029
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3553 [hci0] 4323.485932
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Remote Name Req Complete (0x07) plen 255                          
>                                             #3554 [hci0] 4323.506965
        Status: Success (0x00)
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Name: Keyboard K380
@ MGMT Event: Device Connected (0x000b) plen 33                                
                                         {0x0002} [hci0] 4323.507012
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Flags: 0x00000000
        Data length: 20
        Name (complete): Keyboard K380
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
@ MGMT Event: Device Connected (0x000b) plen 33                                
                                         {0x0001} [hci0] 4323.507012
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Flags: 0x00000000
        Data length: 20
        Name (complete): Keyboard K380
        Class: 0x000540
          Major class: Peripheral (mouse, joystick, keyboards)
          Minor class: 0x10
> HCI Event: Encryption Change (0x08) plen 4                                   
>                                             #3555 [hci0] 4323.511937
        Status: Success (0x00)
        Handle: 11
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2                   
                                            #3556 [hci0] 4323.511970
        Handle: 11
> HCI Event: Command Complete (0x0e) plen 7                                    
>                                             #3557 [hci0] 4323.512911
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 11
        Key size: 16
> ACL Data RX: Handle 11 flags 0x02 dlen 16                                    
>                                             #3558 [hci0] 4323.515567
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000c200b
          Flow control mode
          Retransmission mode
          Enhanced Retransmission Mode
          Unknown features (0x000c2000)
> ACL Data RX: Handle 8 flags 0x00 dlen 1                                      
>                                             #3559 [hci0] 4323.515575
        frame too short
        02                                               .               
> HCI Event: Number of Completed Packets (0x13) plen 5                         
>                                             #3560 [hci0] 4323.687970
        Num handles: 1
        Handle: 11
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3                                 
                                            #3561 [hci0] 4327.542193
        Handle: 11
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3562 [hci0] 4327.652689
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                 
>                                             #3563 [hci0] 4327.726690
        Status: Success (0x00)
        Handle: 11
        Reason: Connection Terminated By Local Host (0x16)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                                         {0x0002} [hci0] 4327.726746
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Reason: Connection terminated by local host (0x02)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                                         {0x0001} [hci0] 4327.726746
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Reason: Connection terminated by local host (0x02)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1                          
                                            #3564 [hci0] 4327.744330
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                                             #3565 [hci0] 4327.745663
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
****************************************************************

If I try to initiate the connection from bluetoothctl instead of from the
keyboard, the btmon output is slightly different, and much shorter:



< HCI Command: Create Connection (0x01|0x0005) plen 13                         
                                            #3566 [hci0] 4417.886051
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                                      
>                                             #3567 [hci0] 4417.997065
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                   
>                                             #3568 [hci0] 4423.198882
        Status: Page Timeout (0x04)
        Handle: 12
        Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
@ MGMT Event: Connect Failed (0x000d) plen 8                                   
                                         {0x0002} [hci0] 4423.198916
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Status: Connect Failed (0x04)
@ MGMT Event: Connect Failed (0x000d) plen 8                                   
                                         {0x0001} [hci0] 4423.198916
        BR/EDR Address: 34:88:5D:BA:B5:28 (Logitech Far East)
        Status: Connect Failed (0x04)
= bluetoothd: 34:88:5D:BA:B5:28: error updating services: Host is down (112)   
                                                         4423.199390
*****************************************************************

I regularly use this keyboard on my Windows10 laptop and my android tablet, and
it works perfectly in those environments.

There have been times when somehow the keyboard and BlueZ seem to get into a
happy state and the pairing and connection will work, and then the keyboard
will connect successfully for several days of use,...and then it will
disconnect spontaneously while I'm typing,...just *bam*,...keyboard is gone and
now it cannot connect again.  

I've not found any reliable way of getting it to connect.  Just try pairing and
connecting over and over and then after 100 tries or so it'll connect and work
for a few days.  

The Logitech K380 is a current shipping product, and I *love* this keyboard. 
I'm ready to dive in on this to get to the bottom of it, at least in terms of
doing experiments and providing logs.  I'm not a programmer.

-- 
You are receiving this mail because:
You are the assignee for the bug.
