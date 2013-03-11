Return-Path: <cyrus@holtmann.org>
From: "Huang, Christina" <christina.huang@intel.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: one question on BLE device authentication error
Date: Mon, 11 Mar 2013 04:17:15 +0000
Message-ID: <A286798B34C0C9419EDBB5F44D457E14137723@SHSMSX101.ccr.corp.intel.com>
References: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
 <CAJdJm_OO4SXo6sSCnuoCWYB2nvhHjWp=gPwY9bAjPRYij2UAmA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Anderson

Sorry to give wrong information, I tried several times with several commands with bluetoothctl and at last the connection succeeds after remove operation.

[bluetooth]# scan on
Discovery started
[CHG] Controller 00:1A:7D:DA:71:05 Discovering: yes
[NEW] Device 00:17:EA:91:8C:78 UJuicer Alert
[CHG] Device 00:17:EA:91:8C:78 RSSI: -42
[CHG] Device 00:17:EA:91:8C:78 RSSI: -52
[bluetooth]# scan off
Discovery stopped
[CHG] Device 00:17:EA:91:8C:78 RSSI is nil
[CHG] Controller 00:1A:7D:DA:71:05 Discovering: no
[bluetooth]# devices
Device 00:17:EA:91:8C:78 UJuicer Alert
[bluetooth]# connect 00:17:EA:91:8C:78
Attempting to connect to 00:17:EA:91:8C:78
Connection successful
[CHG] Device 00:17:EA:91:8C:78 Connected: yes
[CHG] Device 00:17:EA:91:8C:78 Paired: yes
[CHG] Device 00:17:EA:91:8C:78 UUIDs has unsupported type
[CHG] Device 00:17:EA:91:8C:78 Icon is nil
[CHG] Device 00:17:EA:91:8C:78 Appearance is nil

Thank you very much for the helpful reply.

Christina
-----Original Message-----
From: Huang, Christina 
Sent: Monday, March 11, 2013 9:33 AM
To: 'Anderson Lizardo'
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: one question on BLE device authentication error

Hi, Anderson

Thanks for your quick reply, but it looks all same after I did "bluetoothctl remove", please see below log, I'm not sure if I did correct or not. 
It's so strange that this LE device works well with my iphone4S, it connects well, and alert when the device is far away from my iphone.

~/bluez/client$ sudo ./bluetoothctl remove 00:17:EA:91:8C:78 [NEW] Controller 00:1A:7D:DA:71:05 christina-HP-Compaq-8200-Elite-SFF-PC-0 [default] [NEW] Device 00:17:EA:91:8C:78 UJuicer Alert [DEL] Device 00:17:EA:91:8C:78 UJuicer Alert [CHG] Controller 00:1A:7D:DA:71:05 Powered: no [CHG] Controller 00:1A:7D:DA:71:05 Discovering: no [CHG] Controller 00:1A:7D:DA:71:05 Class: 0x000000 [DEL] Controller 00:1A:7D:DA:71:05 christina-HP-Compaq-8200-Elite-SFF-PC-0 [default] [NEW] Controller 00:1A:7D:DA:71:05 christina-HP-Compaq-8200-Elite-SFF-PC-0 [default] [NEW] Device 00:17:EA:91:8C:78 UJuicer Alert [DEL] Device 00:17:EA:91:8C:78 UJuicer Alert [DEL] Controller 00:1A:7D:DA:71:05 christina-HP-Compaq-8200-Elite-SFF-PC-0 [default] [bluetooth]# remove 00:17:EA:91:8C:78 No default controller available [bluetooth]# exit

~/bluez$ sudo bluetoothd

@ Device Connected: 00:17:EA:91:8C:78 (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 208.799845
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 70 flags 0x02 dlen 6                    [hci0] 208.801325
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding - MITM (0x05)
> HCI Event: Encryption Change (0x08) plen 4                  [hci0] 209.081845
        Status: PIN or Key Missing (0x06)
        Handle: 70
        Encryption: Disabled (0x00)
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci0] 209.081876
        Handle: 70
        Reason: Authentication Failure (0x05)

-----Original Message-----
From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
Sent: Friday, March 08, 2013 10:00 PM
To: Huang, Christina
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: one question on BLE device authentication error

Hi Christina,

On Fri, Mar 8, 2013 at 3:54 AM, Huang, Christina <christina.huang@intel.com> wrote:
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28        [hci0] 5.724000
>         Handle: 71
>         Random number: 8c126b665d2de279
>         Encryption diversifier: 0x3f55
>         Long term key: dcd74a1a07f653c0e27f65888debcbe5 @ Device
> Connected: 00:17:EA:91:8C:78 (1) flags 0x0000
>> HCI Event: Command Status (0x0f) plen 4                       [hci0] 5.733922
>       LE Start Encryption (0x08|0x0019) ncmd 1
>         Status: Success (0x00)
>> ACL Data RX: Handle 71 flags 0x02 dlen 6                      [hci0] 5.835521
>       SMP: Security Request (0x0b) len 1
>         Authentication requirement: Bonding - MITM (0x05)
>> HCI Event: Encryption Change (0x08) plen 4                    [hci0] 6.115911
>         Status: PIN or Key Missing (0x06)
>         Handle: 71
>         Encryption: Disabled (0x00)

It looks like your LE device lost the bonding information (e.g. LTK) and thus is not able to just encrypt the connection with the LTK BlueZ is trying to use. You can try removing the bonding on BlueZ side (e.g.
"test-device remove <bdaddr>" or "remove <bdaddr>" on bluetoothctl) and try again a complete pairing.

Best regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
