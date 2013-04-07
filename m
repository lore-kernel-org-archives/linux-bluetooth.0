Return-Path: <cyrus@holtmann.org>
From: "Huang, Christina" <christina.huang@intel.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: one question on BLE device authentication error
Date: Sun, 7 Apr 2013 06:23:25 +0000
Message-ID: <A286798B34C0C9419EDBB5F44D457E1413D2D6@SHSMSX101.ccr.corp.intel.com>
References: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
 <CAJdJm_OO4SXo6sSCnuoCWYB2nvhHjWp=gPwY9bAjPRYij2UAmA@mail.gmail.com>
In-Reply-To: <CAJdJm_OO4SXo6sSCnuoCWYB2nvhHjWp=gPwY9bAjPRYij2UAmA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi, Anderson

I met one more issue on connecting with Wahoo BlueSC BLE speed / cadence sensor device, it could be discovered successfully, while fails in connection and reports error " Command Disallowed ". Could you suggest what I could do to allow the "connect" command? 
I found this same issue reported before but no available answer.
http://www.spinics.net/lists/linux-bluetooth/msg30681.html

Thank you very much.
Christina

@ Device Found: EF:CE:46:33:62:F6 (2) rssi -55 flags 0x0000
        02 01 06 03 02 16 18 12 09 57 61 68 6f 6f 20 42  .........Wahoo B
        6c 75 65 53 43 20 76 31 2e 34                    lueSC v1.4
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                         [hci0] 6.358536
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Address: EF:CE:46:33:62:F6 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                         [hci0] 6.360646
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Command Disallowed (0x0c)

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
