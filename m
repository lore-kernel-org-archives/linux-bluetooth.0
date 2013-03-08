Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
References: <A286798B34C0C9419EDBB5F44D457E14137231@SHSMSX101.ccr.corp.intel.com>
Date: Fri, 8 Mar 2013 09:59:45 -0400
Message-ID: <CAJdJm_OO4SXo6sSCnuoCWYB2nvhHjWp=gPwY9bAjPRYij2UAmA@mail.gmail.com>
Subject: Re: one question on BLE device authentication error
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Huang, Christina" <christina.huang@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christina,

On Fri, Mar 8, 2013 at 3:54 AM, Huang, Christina
<christina.huang@intel.com> wrote:
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28        [hci0] 5.724000
>         Handle: 71
>         Random number: 8c126b665d2de279
>         Encryption diversifier: 0x3f55
>         Long term key: dcd74a1a07f653c0e27f65888debcbe5
> @ Device Connected: 00:17:EA:91:8C:78 (1) flags 0x0000
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

It looks like your LE device lost the bonding information (e.g. LTK)
and thus is not able to just encrypt the connection with the LTK BlueZ
is trying to use. You can try removing the bonding on BlueZ side (e.g.
"test-device remove <bdaddr>" or "remove <bdaddr>" on bluetoothctl)
and try again a complete pairing.

Best regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
