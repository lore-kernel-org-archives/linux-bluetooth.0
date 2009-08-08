Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1249670135.30166.14.camel@localhost.localdomain>
References: <113d36d80908071126j521df37aked5fec76df09006c@mail.gmail.com>
	 <1249670135.30166.14.camel@localhost.localdomain>
Date: Sat, 8 Aug 2009 12:04:10 +0800
Message-ID: <113d36d80908072104m777fdf95q9db99ffb863744dc@mail.gmail.com>
Subject: Re: sco connection issue for BlueZ 4.x on kernel 2.6.29
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=GB2312
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/8/8 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>> Can not accept incoming SCO connection. Kernel version 2.6.29. Kernel
>> log is as below. Is this a kernel bug? Is there any fix already for
>> this?
>>
>> <6>[  158.339691] sco_connect_ind: hdev hci0, bdaddr CA:D3:10:55:0C:00
>>     -------// receive incoming sco
>> <6>[  158.518554] sco_connect_cfm: hcon cf18ee00 bdaddr CA:D3:10:55:0C:0=
0 status
>> <6>[  158.721160] sco_connect_cfm: hcon cf149c00 bdaddr CA:D3:10:55:0C:0=
0 status
>> <6>[  158.728851] sco_conn_add: hcon cf149c00 conn cc772640
>> <6>[  158.734313] sco_conn_ready: conn cc772640
>> -----------// handle sco connection complete
>> <6>[  158.738800] sco_sock_init: sk cf18c400
>> -----------// start handle sco socket
>> <6>[  158.742858] __sco_chan_add: conn cc772640
>> <6>[  159.693023] sco_sock_accept: sk ccfdf400 timeo 0
>> <6>[  159.708038] sco_sock_accept: new socket cf18c400
>> <6>[  159.713073] sco_sock_getsockopt: sk cf18c400
>> <6>[  159.717834] sco_sock_getsockopt_old: sk cf18c400
>> <6>[  159.722839] sco_sock_getsockopt_old: mtu 180
>> <6>[  159.727661] sco_sock_getname: sock ce9d80a0, sk cf18c400
>> <6>[  159.733398] sco_sock_getname: sock ce9d80a0, sk cf18c400
>> <6>[  159.739166] sco_sock_release: sock ce9d80a0, sk cf18c400
>> -----------// don't know why it call sco_sock_release
>> <6>[  159.745025] sco_sock_clear_timer: sock cf18c400 state 1
>> <6>[  159.750671] sco_sock_close: sk cf18c400 state 1 conn cc772640 sock=
et ce9d8
>> <6>[  159.758453] sco_chan_del: sk cf18c400, conn cc772640, err 104
>> <6>[  159.764770] sco_sock_kill: sk cf18c400 state 9
>> <6>[  159.769592] sco_sock_destruct: sk cf18c400
>> ------------// destruct sco socket, and disconnect SCO connection
>> <6>[  159.782745] l2cap_disconn_ind: hcon cf149c00
>> <6>[  159.787384] hci_acl_disconn: cf149c00
>> <6>[  159.950805] hci_disconn_complete_evt: hci0 status 0
>> <6>[  159.956207] l2cap_disconn_cfm: hcon cf149c00 reason 22
>> <6>[  159.961730] sco_disconn_cfm: hcon cf149c00 reason 22
>> -------------// sco disconnected
>> <6>[  159.967102] sco_conn_del: hcon cf149c00 conn cc772640, err 103
>> <6>[  162.130523] hci_disconn_complete_evt: hci0 status 0
>> <6>[  162.136291] l2cap_disconn_cfm: hcon cf18ee00 reason 19
>> <6>[  162.149871] sco_disconn_cfm: hcon cf18ee00 reason 19
>> <4>[  165.382141] done EDISCO CTRL ENABLE
>> <7>[  165.386077] sholes-panel:  edisco_ctrl_enable_te
>
> what kind of program are you using?
>
> Regards
>
> Marcel
>
>
>

This issue was found when testing HFP on android platform with a
Bluetooth carkit which is not support eSCO. At first android tries to
establish eSCO with carkit, carkit response with error that eSCO is
not supported. Then carkit send SCO connect request to android
automatically, android accepted this connection but disconnect it
immediately.

I also use scotest command to test it. Run "scotest -r" on one device
to accept sco connection, run "scotest -s xx:xx:xx:xx" on another
device to send sco connection. This problem is reproduceable
everytime.

This is the hcidump log on the acceptor device,

1970-01-01 00:02:38.138427 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0C:55:10:D3:CA class 0x480100 type ACL
1970-01-01 00:02:38.202423 < HCI Command: Accept Connection Request (0x01|0=
x0009
) plen 7
    bdaddr 00:0C:55:10:D3:CA role 0x00
    Role: Master
1970-01-01 00:02:38.323730 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
1970-01-01 00:02:38.510467 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:0C:55:10:D3:CA role 0x00
    Role: Master
1970-01-01 00:02:38.534637 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0C:55:10:D3:CA type ACL encrypt 0x00
1970-01-01 00:02:38.552123 > HCI Event: Page Scan Repetition Mode Change (0=
x20)
plen 7
    bdaddr 00:0C:55:10:D3:CA mode 0
1970-01-01 00:02:38.579528 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
1970-01-01 00:02:38.603668 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0C:55:10:D3:CA class 0x480100 type SCO
1970-01-01 00:02:38.746490 < HCI Command: Read Remote Supported Features (0=
x01|0
x001b) plen 2
    handle 1
1970-01-01 00:02:38.827789 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
1970-01-01 00:02:38.845550 > HCI Event: Read Remote Supported Features (0x0=
b) pl
en 11
    status 0x00 handle 1
    Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
1970-01-01 00:02:38.929840 < HCI Command: Accept Synchronous Connection (0x=
01|0x
0029) plen 21
    bdaddr 00:0C:55:10:D3:CA
    0000: 40 1f 00 00 40 1f 00 00  ff ff 60 00 ff c7 03     @...@...=FF=FF`=
.=FF?
1970-01-01 00:02:39.012329 > HCI Event: Command Status (0x0f) plen 4
    Accept Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1
1970-01-01 00:02:39.044982 > HCI Event: Synchronous Connect Complete (0x2c)=
 plen
 17
    status 0x00 handle 257 bdaddr 00:0C:55:10:D3:CA type SCO
    Air mode: CVSD
1970-01-01 00:02:39.062438 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 3
1970-01-01 00:02:39.371032 < HCI Command: Remote Name Request (0x01|0x0019)=
 plen
 10
    bdaddr 00:0C:55:10:D3:CA mode 2 clkoffset 0x0000
1970-01-01 00:02:39.452514 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
1970-01-01 00:02:39.509918 > HCI Event: Remote Name Req Complete (0x07) ple=
n 255

    status 0x00 bdaddr 00:0C:55:10:D3:CA name '"generic"'
1970-01-01 00:02:40.178985 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 257 reason 0x13
    Reason: Remote User Terminated Connection
1970-01-01 00:02:40.260284 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
1970-01-01 00:02:40.284271 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 257 reason 0x16
    Reason: Connection Terminated by Local Host
1970-01-01 00:02:40.301849 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
1970-01-01 00:02:42.486175 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection


Thanks,
Zhu Lan
