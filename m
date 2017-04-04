Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E3B98393E6037849B63EA428240A65136126D7@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A65136126D7@PGSMSX103.gar.corp.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Apr 2017 12:34:57 +0300
Message-ID: <CABBYNZKOCF3byyLP56niieuAxO2wWYixWLnaKTvbiGsuUCmTyA@mail.gmail.com>
Subject: Re: Bluetooth PAN Connection - NAP and GN
To: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

On Tue, Apr 4, 2017 at 10:51 AM, Wong, Joshua Weng Onn
<joshua.weng.onn.wong@intel.com> wrote:

> I would like to follow up with this issue. I am also testing the Group Network (GN) with PANU using the following steps:
>
> Master side:
> 1. ./test-gn (registers the UUID service 0x1117 for GN)
> 2. Perform pairing between the master and slave device via bluetoothctl
>
> Slave side:
> 1. Accept the pairing via bluetoothctl
> 2. ./test-network <MASTER_BT_MAC> gn
>
> On btmon, I observe an output which says "Connection refused - security block" which is the same message encountered by Jon.
>
>> ACL Data RX: Handle 1 flags 0x02 dlen 16                                [hci0] 6608.309405
>       L2CAP: Connection Response (0x03) ident 3 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection pending (0x0001)
>         Status: Authorization pending (0x0002)
>> ACL Data RX: Handle 1 flags 0x02 dlen 16                                [hci0] 6608.364566
>       L2CAP: Connection Response (0x03) ident 3 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection refused - security block (0x0003)
>         Status: No further information available (0x0000)
> < HCI Command: Disconnect (0x01|0x0006) plen 3                            [hci0] 6610.367786
>         Handle: 1
>         Reason: Remote User Terminated Connection (0x13)
>> HCI Event: Command Status (0x0f) plen 4                                 [hci0] 6610.368878
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Success (0x00)
>> HCI Event: Disconnect Complete (0x05) plen 4                            [hci0] 6610.420389
>         Status: Success (0x00)
>         Handle: 1
>         Reason: Connection Terminated By Local Host (0x16)
> @ Device Disconnected: 74:C6:3B:AB:68:E0 (0) reason 2
>
> I have added the Network1 and NetworkServer1 interfaces in my dbus configuration file in /etc/dbus-1/system.d/bluetooth.conf on both the master and slave device but am still facing the message.
> I have also trusted each device via bluetoothctl on the master and slave.
>
> Has anyone successfully tested out this PAN scenario involving GN and PANU connection? What additional settings should we change to create this connection?

I guess you forgot to check if there where any fixes pushed upstream:

commit 49707d7a508fb01760713b7265a15886977b096f
Author: Maxime Chevallier <maxime.chevallier@smile.fr>
Date:   Tue Oct 25 16:25:14 2016 +0200

    profiles/network: Check for any server when accepting connections

    When asking confirmation to accept an incoming connection,
    we now only check for any network_server to be registered to
    the adapter.

    This fixes GN Master role, that wouldn't accept any connection
    before.

-- 
Luiz Augusto von Dentz
