Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Unexpected SMP Command 0x0a
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E3B98393E6037849B63EA428240A6513607424@PGSMSX103.gar.corp.intel.com>
Date: Mon, 27 Mar 2017 15:59:48 +0200
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>
Message-Id: <4B147732-E995-4B84-8EDA-5F8F050C51E7@holtmann.org>
References: <E3B98393E6037849B63EA428240A6513607424@PGSMSX103.gar.corp.intel.com>
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

please refrain from top posting on this mailing list.

> Thank you for your reply. We are using the 4.1.x kernel as our group has performed validation work on it and achieved 'Gold release' standard for our customers.
> I have attached my logs during the LE pairing process at the end of this email. There are two logs namely master and slave device. Note that the logs I provided is for secure connections on.
> The log I sent previously was ford secure connections turned off. Nonetheless, the LE pairing fails on both settings i.e. when secured connections is turned on and when secured connections is turned off.

So the pairing itself succeeds, but for some reason the mgmt command indicating its completion.

> < ACL Data TX: Handle 128 flags 0x00 dlen 21                               [hci0] 760.114731
>      SMP: Pairing DHKey Check (0x0d) len 16
>        E: f3373b60ba9063449ebef0f3dd7d9781
>> HCI Event: Number of Completed Packets (0x13) plen 5                     [hci0] 760.132942
>        Num handles: 1
>        Handle: 128
>        Count: 1
>> ACL Data RX: Handle 128 flags 0x02 dlen 21                               [hci0] 760.200373
>      SMP: Pairing DHKey Check (0x0d) len 16
>        E: 975be5ee4a205e1ac4811baa970abf10
> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28                   [hci0] 760.200595
>        Handle: 128
>        Random number: 0x0000000000000000
>        Encrypted diversifier: 0x0000
>        Long term key: 7ee01e3f27750b9393533941a4f3e198
>> HCI Event: Command Status (0x0f) plen 4                                  [hci0] 760.206677
>      LE Start Encryption (0x08|0x0019) ncmd 1
>        Status: Success (0x00)
>> ACL Data RX: Handle 128 flags 0x02 dlen 21                               [hci0] 760.470529
>      SMP: Signing Information (0x0a) len 16
>        Signature key: 1866336f92238bf953611245b7ad51f7
>> HCI Event: Encryption Change (0x08) plen 4                               [hci0] 760.470733
>        Status: Success (0x00)
>        Handle: 128
>        Encryption: Enabled with AES-CCM (0x01)
>> HCI Event: Disconnect Complete (0x05) plen 4                             [hci0] 790.576443
>        Status: Success (0x00)
>        Handle: 128
>        Reason: Remote User Terminated Connection (0x13)
> @ Device Disconnected: 74:C6:3B:AB:68:EA (1) reason 3

The pairing itself completes and the encryption gets enabled. Also the CSRK gets distributed (note LTK gets not distributed in the SC case).

What is missing here is that mgmt notifies user space about the new LTK and CSRK. However what I wonder is if the CSRK distribution might cause some issue since it is the only distributed material. I don’t think that I have seen that before.

Can this be reproduced with a 4.9 kernel?

Regards

Marcel

