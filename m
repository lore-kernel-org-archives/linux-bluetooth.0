Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Oct 2008 00:25:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-bluetooth@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, cijoml@volny.cz
Subject: Re: [Bugme-new] [Bug 11705] New: l2cap_recv_acldata: Unexpected
 continuation frame (len 0)
Message-Id: <20081005002558.3a31acd5.akpm@linux-foundation.org>
In-Reply-To: <bug-11705-10286@http.bugzilla.kernel.org/>
References: <bug-11705-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat,  4 Oct 2008 23:28:41 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11705
> 
>            Summary: l2cap_recv_acldata: Unexpected continuation frame (len
>                     0)
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.27-rc6
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: cijoml@volny.cz
> 
> 
> Latest working kernel version: unknown
> Earliest failing kernel version: unknown
> Distribution: Debian testing
> Hardware Environment: 
> 
> compaq:/home/cijoml# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:1E:37:XX:XX:XX ACL MTU: 1017:8 SCO MTU: 64:8
>         Firmware 41.65 / 207
> compaq:/home/cijoml# hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:1E:37:XX:XX:XX ACL MTU: 1017:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO> <broadcast encrypt>
>                 <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
>                 <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
>                 <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
>                 <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
>                 <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
>                 <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>
> compaq:/home/cijoml# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:1E:37:XX:XX:XX ACL MTU: 1017:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:100912 acl:1363 sco:0 events:13089 errors:0
>         TX bytes:21534098 acl:26024 sco:0 commands:49 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'compaq-0'
>         Class: 0x180100
>         Service Classes: Capturing, Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x2129 LMP Ver: 2.0 (0x3) LMP Subver:
> 0x41cf
>         Manufacturer: Broadcom Corporation (15)
> 
> HIFI Motorola:
> compaq:/home/cijoml# hcitool info 00:0C:55:XX:XX:XX
> Requesting information ...
>         BD Address:  00:0C:55:XX:XX:XX
>         Device Name: Motorola S805
>         LMP Version: 2.0 (0x3) LMP Subversion: 0xa41
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO> <broadcast encrypt>
>                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
>                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
>                 <AFH cap. master> <AFH class. master> <extended features>
> 
> 
> Software Environment:
> 2.6.27-rc6, 
> compaq:/usr/src# dpkg -l |grep bluez
> ii  bluez-audio                          3.36-1                       
> Bluetooth audio support
> ii  bluez-utils                          3.36-1                       
> Bluetooth tools and daemons
> 
> Problem Description:
> After start of A2DP stream to my Motorola S805,my dmesg log is flooded with
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> l2cap_recv_acldata: Unexpected continuation frame (len 0)
> 
> Sound goes great!
> 
> Steps to reproduce:
> start play
> 

