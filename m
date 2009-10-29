Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4AE971D9.2010409@gmail.com>
References: <4AE971D9.2010409@gmail.com>
Date: Thu, 29 Oct 2009 15:06:23 -0200
Message-ID: <6b53b1990910291006x5c9473eep26725b082334c953@mail.gmail.com>
Subject: Re: ERMT and Streaming mode in L2CAP
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: sancane <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi sancane,

On Thu, Oct 29, 2009 at 8:43 AM, sancane <sancane@gmail.com> wrote:
> Hi,
> I'm programming a MCAP library for Bluez, (it is in beta state yet). I
> need add support for ERTM and Streaming mode to L2CAP sockets and i've
> seen some work included in l2cap kernel module by Gustavo F. Padovan. I
> have downloaded the kernel source from
> git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git
> <http://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-2.6.git>
> and compiled it enabling ERTM module parameter to test my current
> implementation of MCAP profile.
> I would like to know which is the current state of ERTM and Streaming
> mode in l2cap and if you are planning to continue the development task
> in above mentioned retransmission modes.
> My tests using ERTM results in kernel oops messages when i try to
> send/receive a buffer data. I tested Streaming mode too but it does not
> do anything when data is sent over L2CAP sockets.
> In [1] i adjunct the kernel oops message when ERTM is used.
>
> Is it possible that i'm doing something wrong?. Next is the code that
> i'm using to set ERTM and Streaming mode in l2cap:
>
> static int set_sock_options (int sock, uint16_t imtu, uint16_t omtu,
> uint8_t mode) {
>   struct l2cap_options opts;
>   int err;
>   socklen_t optlen = sizeof(opts);
>
>   err = getsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, &optlen );
>   if (!err) {
>       opts.omtu = omtu;
>       opts.imtu = imtu;
>       opts.mode = mode;
>       MCAP_DBG("Mode %d, fcs %d", opts.mode, opts.fcs);
>       err = setsockopt( sock, SOL_L2CAP, L2CAP_OPTIONS, &opts, optlen );
>   }
>   return err;
>
> }
>
> i'm using L2CAP_MODE_ERTM and L2CAP_MODE_STREAMING macros to set the
> l2cap option mode field.
>
> Best regards
>
> [1] http://www.kerneloops.org/submitresult.php?number=858407
> <http://www.kerneloops.org/submitresult.php?number=858407>
>
> Next is the output that i got before kernel error is shown:
>
> HCI sniffer - Bluetooth packet analyzer ver 1.42
> device: hci0 snap_len: 1028 filter: 0xffffffff
>> HCI Event: Connect Request (0x04) plen 10
>   bdaddr 00:0A:94:02:CE:87 class 0x4a0100 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   bdaddr 00:0A:94:02:CE:87 role 0x00
>   Role: Master
>> HCI Event: Command Status (0x0f) plen 4
>   Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>> HCI Event: Role Change (0x12) plen 8
>   status 0x00 bdaddr 00:0A:94:02:CE:87 role 0x00
>   Role: Master
>> HCI Event: Connect Complete (0x03) plen 11
>   status 0x00 handle 46 bdaddr 00:0A:94:02:CE:87 type ACL encrypt 0x00
> < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
>   handle 46
>> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   bdaddr 00:0A:94:02:CE:87 mode 1
>> HCI Event: Command Status (0x0f) plen 4
>   Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
>> HCI Event: Max Slots Change (0x1b) plen 3
>   handle 46 slots 5
>> HCI Event: Command Status (0x0f) plen 4
>   Unknown (0x00|0x0000) status 0x00 ncmd 1
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>   bdaddr 00:0A:94:02:CE:87 mode 2 clkoffset 0x0000
>> HCI Event: Read Remote Supported Features (0x0b) plen 11
>   status 0x00 handle 46
>   Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>> HCI Event: Command Status (0x0f) plen 4
>   Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
>> ACL data: handle 46 flags 0x02 dlen 10
>   L2CAP(s): Info req: type 2
> < ACL data: handle 46 flags 0x02 dlen 16
>   L2CAP(s): Info rsp: type 2 result 0
>     Extended feature mask 0x00b8
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 10
>   L2CAP(s): Info req: type 3
> < ACL data: handle 46 flags 0x02 dlen 20
>   L2CAP(s): Info rsp: type 3 result 0
>     Unknown (len 8)
>> ACL data: handle 46 flags 0x02 dlen 12
>   L2CAP(s): Connect req: psm 4097 scid 0x0040
> < ACL data: handle 46 flags 0x02 dlen 16
>   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
>     Connection pending - No futher information available
> < ACL data: handle 46 flags 0x02 dlen 10
>   L2CAP(s): Info req: type 2
>> HCI Event: Remote Name Req Complete (0x07) plen 255
>   status 0x00 bdaddr 00:0A:94:02:CE:87 name 'blueztester-0'
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 16
>   L2CAP(s): Info rsp: type 2 result 0
>     Extended feature mask 0x00b8
> < ACL data: handle 46 flags 0x02 dlen 10
>   L2CAP(s): Info req: type 3
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 20
>   L2CAP(s): Info rsp: type 3 result 0
>     Unknown (len 8)
> < ACL data: handle 46 flags 0x02 dlen 16
>   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>     Connection successful
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 23
>   L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
>     RFC 0x03 (Reserved)
> < ACL data: handle 46 flags 0x02 dlen 29
>   L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 15
>     MTU 672 RFC 0x03 (Reserved)
> < ACL data: handle 46 flags 0x02 dlen 23
>   L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
>     RFC 0x03 (Reserved)
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> HCI Event: Number of Completed Packets (0x13) plen 5
>   handle 46 packets 1
>> ACL data: handle 46 flags 0x02 dlen 29
>   L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 15
>     MTU 672 RFC 0x03 (Reserved)
>> ACL data: handle 46 flags 0x02 dlen 13
>   L2CAP(d): cid 0x0040 len 9 ctrl 0x0000 fcs 0x33e3 [psm 4097]
>     I-frame: Unsegmented TxSeq 0 ReqSeq 0
>     0000: 01 01 00 01 01                                    .....
> < ACL data: handle 46 flags 0x02 dlen 13
>   L2CAP(d): cid 0x0040 len 9 ctrl 0x0000 fcs 0x9ff6 [psm 4097]
>     I-frame: Unsegmented TxSeq 0 ReqSeq 0
>     0000: 02 00 01 00 01


It looks you are using a duplex channel. This code doesn't support
that. You need the patches I sent to mailing list on Oct 3.
                                 .....
>
> Message from syslogd@XXXX at Oct 29 11:15:02 ...
>  kernel:[ 7162.427921] ------------[ cut here ]------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan
http://padovan.org
