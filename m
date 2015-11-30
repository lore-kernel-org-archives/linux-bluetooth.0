Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: Unknown Connection Identifier
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <877fkz5du1.fsf@intel.com>
Date: Mon, 30 Nov 2015 14:31:28 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	=?utf-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>,
	Szymon Janc <szymon.janc@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Message-Id: <CA22CE56-73FD-49F4-9C5B-B11C879580DF@holtmann.org>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com> <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org> <2045332.GytFuFKTvp@ix> <CAEZxfGOdyZat1evKm0Jfwg=knuigGdfK_wVqS8NG=zFAY3aRXg@mail.gmail.com> <2DBBB005-93A7-47ED-8E88-1D6B92ACCC07@holtmann.org> <CAEZxfGOJK00YMX+_Kpde9kv38XB9q+EvXYoEF4ic94VWZEhZKg@mail.gmail.com> <20151130105141.GA12764@t440s.lan> <877fkz5du1.fsf@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

>>>>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>>>>>              [hci0] 15.669171
>>>>>       Scan interval: 60.000 msec (0x0060)
>>>>>       Scan window: 30.000 msec (0x0030)
>>>> 
>>>> we might should have the LE Create Connection scan with a full duty
>>>> cycle here. So it does not miss any advertising PDUs.
>>> 
>>> Is this something the Linux Bluetooth team is going to address?
>> 
>> I think this alone might fix the issue you're seeing. Could you please
>> try the patch I just sent and see if it solves the issue for you:
>> 
>>  Bluetooth: Use continuous scanning when creating LE connections
> 
> I ended up with the same problem using the 4.3 kernel.
> 
> The patch seems to solve the issue, and could perhaps be submitted to
> -stable.
> 
> I gave it a few tries trying to connect to a Parrot Flower Power, and
> got into a situation that may indicate a possible race condition:
> 
> (this line: '< HCI Command: LE Create Connection Cancel... ')
> 
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                        [hci0] 20.602345
>        Type: Passive (0x00)
>        Interval: 60.000 msec (0x0060)
>        Window: 30.000 msec (0x0030)
>        Own address type: Public (0x00)
>        Filter policy: Ignore not in white list (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 20.603330
>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                            [hci0] 20.603348
>        Scanning: Enabled (0x01)
>        Filter duplicates: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 20.604339
>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 36                                          [hci0] 21.508266
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Connectable undirected - ADV_IND (0x00)
>        Address type: Public (0x00)
>        Address: A0:14:3D:08:B5:36 (PARROT SA)
>        Data length: 24
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        128-bit Service UUIDs (partial): 1 entry
>          39e1fa00-84a8-11e2-afba-0002a5d5c51b
>        RSSI: -59 dBm (0xc5)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                            [hci0] 21.508332
>        Scanning: Disabled (0x00)
>        Filter duplicates: Disabled (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 21.510342
>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25                         [hci0] 21.510396
>        Scan interval: 60.000 msec (0x0060)
>        Scan window: 60.000 msec (0x0060)
>        Filter policy: White list is not used (0x00)
>        Peer address type: Public (0x00)
>        Peer address: A0:14:3D:08:B5:36 (PARROT SA)
>        Own address type: Public (0x00)
>        Min connection interval: 50.00 msec (0x0028)
>        Max connection interval: 70.00 msec (0x0038)
>        Connection latency: 0x0000
>        Supervision timeout: 420 msec (0x002a)
>        Min connection length: 0.000 msec (0x0000)
>        Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4                                          [hci0] 21.512248
>      LE Create Connection (0x08|0x000d) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0                   [hci0] 23.512098
>> HCI Event: LE Meta Event (0x3e) plen 19                                          [hci0] 23.514370
>      LE Connection Complete (0x01)
>        Status: Success (0x00)
>        Handle: 64
>        Role: Master (0x00)
>        Peer address type: Public (0x00)
>        Peer address: A0:14:3D:08:B5:36 (PARROT SA)
>        Connection interval: 67.50 msec (0x0036)
>        Connection latency: 0.00 msec (0x0000)
>        Supervision timeout: 420 msec (0x002a)
>        Master clock accuracy: 0x05
> @ Device Connected: A0:14:3D:08:B5:36 (1) flags 0x0000
>        02 01 06 11 06 1b c5 d5 a5 02 00 ba af e2 11 a8  ................
>        84 00 fa e1 39 02 ff 03                          ....9...
>> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 23.519286
>      LE Create Connection Cancel (0x08|0x000e) ncmd 1
>        Status: Command Disallowed (0x0c)

I assume you means this one. The LE Connection Complete event arrives before the LE Create Connection Cancel actually completes.

Actually I do not think this is a race condition, it is just something with the nature on how LE connection are established (remember there is no CONN_RSP, just a CONN_REQ). It is just to catch this one since I think we need to be able to handle this one correctly.

If I remember the specification correctly, then you can only cancel a LE Create Connection that has not yet received its first data packet. Once the first data packet has arrived, then the connection has been established. Meaning the cancel operation either cancels the scanning or has to wait for the timeout of CONN_REQ. If you actually get a data packet, then it can not do anything anymore. Hence we have the Command Disallowed error here. Now only sending Disconnect will work.

It would be great if we have l2cap-tester or mgmt-tester test cases that simulate this behavior and also the other one where the LE Create Connection requires more than 2 seconds. Ensuring that we handle these correctly is important.

> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2                  [hci0] 23.519347
>        Handle: 64
>> HCI Event: Command Status (0x0f) plen 4                                          [hci0] 23.520302
>      LE Read Remote Used Features (0x08|0x0016) ncmd 1
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 12                                          [hci0] 23.632256
>      LE Read Remote Used Features (0x04)
>        Status: Success (0x00)
>        Handle: 64
>        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          LE Encryption
> < ACL Data TX: Handle 64 flags 0x00 dlen 11                                       [hci0] 23.632361
>      SMP: Pairing Request (0x01) len 6
>        IO capability: NoInputNoOutput (0x03)
>        OOB data: Authentication data not present (0x00)
>        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>        Max encryption key size: 16
>        Initiator key distribution: EncKey Sign LinkKey (0x0d)
>        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)

Regards

Marcel

