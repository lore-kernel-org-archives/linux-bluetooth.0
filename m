Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1929C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2732083B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHSUxV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHSUxS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 16:53:18 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208965] New: not working bluetooth mouse low energy rtl8822ce
Date:   Wed, 19 Aug 2020 20:53:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: fakecop@yandex.ru
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-208965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208965

            Bug ID: 208965
           Summary: not working bluetooth mouse low energy rtl8822ce
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.8.1-arch1-1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: fakecop@yandex.ru
        Regression: No

Created attachment 292031
  --> https://bugzilla.kernel.org/attachment.cgi?id=292031&action=edit
journalctl

I'm use huawei matebook 13 amd (2020), this is notebook use combo module
wifi+bluetooth: Realtek 8822CE. I am trying to connect huawei mouse and i get
error (in attachments)

Systemctl log:

● bluetooth.service - Bluetooth service
     Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; vendor
preset: disabled)
     Active: active (running) since Tue 2020-08-04 16:36:29 MSK; 1min 4s ago
       Docs: man:bluetoothd(8)
   Main PID: 2110 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 17907)
     Memory: 1.7M
     CGroup: /system.slice/bluetooth.service
             └─2110 /usr/lib/bluetooth/bluetoothd -d

авг 04 16:37:14 Anton bluetoothd[2110]: src/agent.c:agent_unref()
0x55720e940a70: ref=1
авг 04 16:37:14 Anton bluetoothd[2110]: src/adapter.c:resume_discovery()
авг 04 16:37:14 Anton bluetoothd[2110]: src/adapter.c:pair_device_complete()
Failed (0x03)
авг 04 16:37:14 Anton bluetoothd[2110]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr FE:FD:2D:11:26:FD type 2
status 0x3
авг 04 16:37:14 Anton bluetoothd[2110]: src/device.c:device_bonding_complete()
bonding (nil) status 0x03
авг 04 16:37:14 Anton bluetoothd[2110]: src/device.c:device_bonding_failed()
status 3
авг 04 16:37:14 Anton bluetoothd[2110]: src/adapter.c:resume_discovery()
авг 04 16:37:16 Anton bluetoothd[2110]: src/agent.c:agent_disconnect() Agent
:1.118 disconnected
авг 04 16:37:16 Anton bluetoothd[2110]: src/agent.c:agent_destroy() agent
:1.118
авг 04 16:37:16 Anton bluetoothd[2110]: src/agent.c:agent_unref()
0x55720e940a70: ref=0


bluetoothctl:

Agent registered
[bluetooth]# select 1C:BF:C0:1A:8E:3C 
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 1C:BF:C0:1A:8E:3C Discovering: yes
[NEW] Device FE:FD:2D:11:26:FD HUAWEI  Mouse
[bluetooth]# agent on
Agent is already registered
[bluetooth]# scan off
Discovery stopped
[CHG] Controller 1C:BF:C0:1A:8E:3C Discovering: no
[CHG] Device FE:FD:2D:11:26:FD RSSI is nil
[bluetooth]# pair FE:FD:2D:11:26:FD
Attempting to pair with FE:FD:2D:11:26:FD
[CHG] Device FE:FD:2D:11:26:FD Connected: yes
[CHG] Device FE:FD:2D:11:26:FD Connected: no
Failed to pair: org.bluez.Error.AuthenticationCanceled
[bluetooth]# connect FE:FD:2D:11:26:FD
Attempting to connect to FE:FD:2D:11:26:FD
[CHG] Device FE:FD:2D:11:26:FD Connected: yes
[CHG] Device FE:FD:2D:11:26:FD Connected: no
Failed to connect: org.bluez.Error.Failed
[bluetooth]# 


btmon log:

Bluetooth monitor ver 5.54
= Note: Linux version 5.7.12-arch1-1 (x86_64)                                  
                                     0.859592
= Note: Bluetooth subsystem version 2.22                                       
                                     0.859597
= New Index: 1C:BF:C0:1A:8E:3C (Primary,USB,hci0)                              
                              [hci0] 0.859598
= Open Index: 1C:BF:C0:1A:8E:3C                                                
                              [hci0] 0.859599
= Index Info: 1C:BF:C0:1A:8E:3C (Realtek Semiconductor Corporation)            
                              [hci0] 0.859601
@ MGMT Open: bluetoothd (privileged) version 1.16                              
                            {0x0001} 0.859602
@ MGMT Open: btmon (privileged) version 1.16                                   
                            {0x0002} 0.859625
@ MGMT Command: Start Discovery (0x0023) plen 1                                
                     {0x0001} [hci0] 5.188846
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                      
                           #1 [hci0] 5.188925
        Address: 3E:88:2E:4E:58:6D (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                            #2 [hci0] 5.302358
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8            
                           #3 [hci0] 5.302395
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                            #4 [hci0] 5.307380
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                           #5 [hci0] 5.307438
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                            #6 [hci0] 5.310369
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                                 
                     {0x0001} [hci0] 5.310427
      Start Discovery (0x0023) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                      
                     {0x0002} [hci0] 5.310439
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                      
                     {0x0001} [hci0] 5.310439
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: LE Meta Event (0x3e) plen 54                                      
>                            #7 [hci0] 6.257392
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0010
            Props: 0x0010
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_NONCONN_IND (0x0010)
          Address type: Public (0x00)
          Address: 00:C3:F4:13:15:07 (Samsung Electronics Co.,Ltd)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -72 dBm (0xb8)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1c
        1b ff 75 00 42 04 01 80 60 00 c3 f4 13 15 07 02  ..u.B...`.......
        c3 f4 13 15 06 01 00 00 00 00 00 00              ............    
@ MGMT Event: Device Found (0x0012) plen 42                                    
                     {0x0002} [hci0] 6.257457
        LE Address: 00:C3:F4:13:15:07 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000004
          Not Connectable
        Data length: 28
        Company: Samsung Electronics Co. Ltd. (117)
          Data: 420401806000c3f413150702c3f413150601000000000000
@ MGMT Event: Device Found (0x0012) plen 42                                    
                     {0x0001} [hci0] 6.257457
        LE Address: 00:C3:F4:13:15:07 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000004
          Not Connectable
        Data length: 28
        Company: Samsung Electronics Co. Ltd. (117)
          Data: 420401806000c3f413150702c3f413150601000000000000
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                            #8 [hci0] 9.000403
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -24 dBm (0xe8)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                            #9 [hci0] 9.147398
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -16 dBm (0xf0)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                           #10 [hci0] 9.357399
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -14 dBm (0xf2)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                           #11 [hci0] 9.567397
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -16 dBm (0xf0)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                           #12 [hci0] 9.777398
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -10 dBm (0xf6)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                           #13 [hci0] 9.987376
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -8 dBm (0xf8)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                          #14 [hci0] 10.197401
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -14 dBm (0xf2)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                          #15 [hci0] 10.407402
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -12 dBm (0xf4)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #16 [hci0] 10.525798
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #17 [hci0] 10.527420
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Device Found (0x0012) plen 40                                    
                    {0x0002} [hci0] 10.527479
        LE Address: FE:FD:2D:11:26:FD (Static)
        RSSI: -12 dBm (0xf4)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
@ MGMT Event: Device Found (0x0012) plen 40                                    
                    {0x0001} [hci0] 10.527479
        LE Address: FE:FD:2D:11:26:FD (Static)
        RSSI: -12 dBm (0xf4)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
< HCI Command: Inquiry (0x01|0x0001) plen 5                                    
                         #18 [hci0] 10.527581
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                                      
>                          #19 [hci0] 10.530407
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
> HCI Event: Inquiry Complete (0x01) plen 1                                    
>                          #20 [hci0] 15.713404
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0002} [hci0] 15.713434
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0001} [hci0] 15.713434
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Command: Pair Device (0x0019) plen 8                                    
                    {0x0001} [hci0] 15.737736
        LE Address: FE:FD:2D:11:26:FD (Static)
        Capability: DisplayYesNo (0x01)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8            
                         #21 [hci0] 15.737806
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #22 [hci0] 15.739428
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #23 [hci0] 15.739490
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #24 [hci0] 15.742444
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                          #25 [hci0] 15.847438
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -40 dBm (0xd8)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #26 [hci0] 15.847520
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #27 [hci0] 15.849412
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 26             
                         #28 [hci0] 15.849470
        Filter policy: White list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:FD:2D:11:26:FD (Static)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                      
>                          #29 [hci0] 15.852531
      LE Extended Create Connection (0x08|0x0043) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 31                                      
>                          #30 [hci0] 16.036426
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Handle: 16
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:FD:2D:11:26:FD (Static)
        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Connection interval: 45.00 msec (0x0024)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 39                                
                    {0x0002} [hci0] 16.036500
        LE Address: FE:FD:2D:11:26:FD (Static)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
@ MGMT Event: Device Connected (0x000b) plen 39                                
                    {0x0001} [hci0] 16.036500
        LE Address: FE:FD:2D:11:26:FD (Static)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2               
                         #31 [hci0] 16.036597
        Handle: 16
> HCI Event: Command Status (0x0f) plen 4                                      
>                          #32 [hci0] 16.038415
      LE Read Remote Used Features (0x08|0x0016) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 4                                       
>                          #33 [hci0] 16.059417
      LE Channel Selection Algorithm (0x14)
        Handle: 16
        Algorithm: #1 (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                 
>                          #34 [hci0] 16.284578
        Status: Success (0x00)
        Handle: 16
        Reason: Connection Failed to be Established (0x3e)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                    {0x0002} [hci0] 16.284608
        LE Address: FE:FD:2D:11:26:FD (Static)
        Reason: Unspecified (0x00)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                    {0x0001} [hci0] 16.284608
        LE Address: FE:FD:2D:11:26:FD (Static)
        Reason: Unspecified (0x00)
@ MGMT Event: Command Complete (0x0001) plen 10                                
                    {0x0001} [hci0] 16.284627
      Pair Device (0x0019) plen 7
        Status: Failed (0x03)
        LE Address: FE:FD:2D:11:26:FD (Static)
@ MGMT Command: Start Discovery (0x0023) plen 1                                
                    {0x0001} [hci0] 18.178861
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                      
                         #35 [hci0] 18.178943
        Address: 19:76:BC:0F:FA:10 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #36 [hci0] 18.180482
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8            
                         #37 [hci0] 18.180539
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #38 [hci0] 18.183465
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #39 [hci0] 18.183520
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #40 [hci0] 18.186452
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                                 
                    {0x0001} [hci0] 18.186538
      Start Discovery (0x0023) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0002} [hci0] 18.186547
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0001} [hci0] 18.186547
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Command: Stop Discovery (0x0024) plen 1                                 
                    {0x0001} [hci0] 19.465795
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #41 [hci0] 19.465838
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #42 [hci0] 19.467439
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                                 
                    {0x0001} [hci0] 19.467508
      Stop Discovery (0x0024) plen 1
        Status: Success (0x00)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0002} [hci0] 19.467526
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Event: Discovering (0x0013) plen 2                                      
                    {0x0001} [hci0] 19.467526
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Command: Stop Discovery (0x0024) plen 1                                 
                    {0x0001} [hci0] 19.467699
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Event: Command Complete (0x0001) plen 4                                 
                    {0x0001} [hci0] 19.467709
      Stop Discovery (0x0024) plen 1
        Status: Rejected (0x0b)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
@ MGMT Command: Pair Device (0x0019) plen 8                                    
                    {0x0001} [hci0] 19.467757
        LE Address: FE:FD:2D:11:26:FD (Static)
        Capability: DisplayYesNo (0x01)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 8            
                         #43 [hci0] 19.467802
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #44 [hci0] 19.470445
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #45 [hci0] 19.470513
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #46 [hci0] 19.473434
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 52                                      
>                          #47 [hci0] 19.587457
      LE Extended Advertising Report (0x0d)
        Num reports: 1
        Entry 0
          Event type: 0x0013
            Props: 0x0013
              Connectable
              Scannable
              Use legacy advertising PDUs
            Data status: Complete
          Legacy PDU Type: ADV_IND (0x0013)
          Address type: Random (0x01)
          Address: FE:FD:2D:11:26:FD (Static)
          Primary PHY: LE 1M
          Secondary PHY: No packets
          SID: no ADI field (0xff)
          TX power: 127 dBm
          RSSI: -44 dBm (0xd4)
          Periodic advertising invteral: 0.00 msec (0x0000)
          Direct address type: Public (0x00)
          Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
          Data length: 0x1a
        0e 09 48 55 41 57 45 49 20 20 4d 6f 75 73 65 03  ..HUAWEI  Mouse.
        19 c2 03 02 01 05 03 03 12 18                    ..........      
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6                
                         #48 [hci0] 19.587536
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                    
>                          #49 [hci0] 19.589453
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 26             
                         #50 [hci0] 19.589492
        Filter policy: White list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:FD:2D:11:26:FD (Static)
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 30.00 msec (0x0018)
          Max connection interval: 50.00 msec (0x0028)
          Connection latency: 0 (0x0000)
          Supervision timeout: 420 msec (0x002a)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                      
>                          #51 [hci0] 19.592524
      LE Extended Create Connection (0x08|0x0043) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 31                                      
>                          #52 [hci0] 19.798455
      LE Enhanced Connection Complete (0x0a)
        Status: Success (0x00)
        Handle: 16
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:FD:2D:11:26:FD (Static)
        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
        Connection interval: 45.00 msec (0x0024)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 39                                
                    {0x0002} [hci0] 19.798500
        LE Address: FE:FD:2D:11:26:FD (Static)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
@ MGMT Event: Device Connected (0x000b) plen 39                                
                    {0x0001} [hci0] 19.798500
        LE Address: FE:FD:2D:11:26:FD (Static)
        Flags: 0x00000000
        Data length: 26
        Name (complete): HUAWEI  Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2               
                         #53 [hci0] 19.798601
        Handle: 16
> HCI Event: Command Status (0x0f) plen 4                                      
>                          #54 [hci0] 19.800437
      LE Read Remote Used Features (0x08|0x0016) ncmd 2
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 4                                       
>                          #55 [hci0] 19.826470
      LE Channel Selection Algorithm (0x14)
        Handle: 16
        Algorithm: #1 (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                                 
>                          #56 [hci0] 20.051518
        Status: Success (0x00)
        Handle: 16
        Reason: Connection Failed to be Established (0x3e)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                    {0x0002} [hci0] 20.051576
        LE Address: FE:FD:2D:11:26:FD (Static)
        Reason: Unspecified (0x00)
@ MGMT Event: Device Disconnected (0x000c) plen 8                              
                    {0x0001} [hci0] 20.051576
        LE Address: FE:FD:2D:11:26:FD (Static)
        Reason: Unspecified (0x00)
@ MGMT Event: Command Complete (0x0001) plen 10                                
                    {0x0001} [hci0] 20.051594
      Pair Device (0x0019) plen 7
        Status: Failed (0x03)
        LE Address: FE:FD:2D:11:26:FD (Static)


P.S.: Please help and fix it! Mouse used bluetooth 4.0 low energy

-- 
You are receiving this mail because:
You are the assignee for the bug.
