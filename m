Received: from skyboo.net (skyboo.net [5.252.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCB6A347
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404574; cv=none; b=TH7Dl9sksF2Ivn6j2XPaZq5BHlZmgg77QiKV8gVM8xuUEHkvidEhM8+xZ/URTWq4xHuM5C2r12iQhH9jiR8A83CJ8qKeTzKgX81F8ER4+wT4NSr6hjl3LbQtnSLuXSRA5agjVTwBQ2feXSmnrMzDUKjlZx6hPzs+w7ZWbryXSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404574; c=relaxed/simple;
	bh=uD6m+t+9wjzVJaVGj7JRKU27l8dJVZG6EKMTXAz7U/w=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Subject; b=Dj/qi1O+U1jCFudQ7/f2nihYAuthPMjmwhs6UoNsfGoaSg71H9Cx8sxL3QX6nJPv+4jzKjLgQtOsEa1h3M+kSnEkim+0n1HY7lwHZKxbrAlKrhZ513DTkcUoobETzWw/4LVoUgEndornF1yJiAKDWORhn59LzcVwlvxV84zeOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyboo.net; spf=pass smtp.mailfrom=skyboo.net; arc=none smtp.client-ip=5.252.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skyboo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyboo.net
Received: from manio by skyboo.net with local (Exim 4.96)
	(envelope-from <manio@skyboo.net>)
	id 1rY5eD-00Dsa3-1B;
	Thu, 08 Feb 2024 15:45:05 +0100
Date: Thu, 8 Feb 2024 15:45:05 +0100
From: Mariusz =?utf-8?B?QmlhxYJvxYRjenlr?= <manio@skyboo.net>
To: linux-bluetooth@vger.kernel.org
Cc: Andreas Radke <andyrtr@archlinux.org>,
	Robin Candau <antiz@archlinux.org>
Message-ID: <20240208144505.koxpmchpkrg6r2c4@skyboo.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="emrg5mvgsghxonbv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-bluetooth@vger.kernel.org, andyrtr@archlinux.org, antiz@archlinux.org
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Level: 
Subject: RFCOMM not working anymore?
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)


--emrg5mvgsghxonbv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
I am trying to use an RFCOMM-capable dongle under Arch Linux (kernel: 6.6.10-arch1-1).
The BT usb adapter is:
ID 0bda:8771 Realtek Semiconductor Corp. Bluetooth Radio

dmesg:
[   19.174428] Bluetooth: Core ver 2.22
[   19.174448] NET: Registered PF_BLUETOOTH protocol family
[   19.174448] Bluetooth: HCI device and connection manager initialized
[   19.174452] Bluetooth: HCI socket layer initialized
[   19.174454] Bluetooth: L2CAP socket layer initialized
[   19.174460] Bluetooth: SCO socket layer initialized
[   20.497753] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[   20.500891] Bluetooth: hci0: RTL: rom_version status=0 version=1
[   20.500894] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[   20.502433] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[   20.503140] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[   20.898620] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   20.898620] Bluetooth: BNEP filters: protocol multicast
[   20.898620] Bluetooth: BNEP socket layer initialized
[   21.285074] Bluetooth: hci0: RTL: fw version 0xdfc6d922
[   21.430191] Bluetooth: MGMT ver 1.22
[   40.360736] Bluetooth: RFCOMM TTY layer initialized
[   40.360743] Bluetooth: RFCOMM socket layer initialized
[   40.360746] Bluetooth: RFCOMM ver 1.11

The rfcomm utility was not provided so I had to install:
https://archlinux.org/packages/extra/x86_64/bluez-deprecated-tools/

unfortunately the command:
rfcomm connect 0 B8:8B:15:0A:1C:AD
gives:
Can't connect RFCOMM socket: Operation now in progress

I tried also with bind - all of this gives errors.
Finally I tried python tools to directly use RFCOMM, then even a rust
rfcat tool from:
https://github.com/bluez/bluer/blob/master/bluer-tools/src/rfcat.rs
All gives various errors/timeouts and cannot connect to the dongle's
serial port. I was also trying to pair/connect with bluetoothctl prior
this - no change.
In fact (see below - pairing seems not needed at all).

Finally I started very very old Asus laptop with debian.
I invoked:
rfcomm connect 0 B8:8B:15:0A:1C:AD
and this immediately gives me:
Connected /dev/rfcomm0 to B8:8B:15:0A:1C:AD on channel 1
Press CTRL-C for hangup

... and it works like a charm!!! I can connect minicom and communication is
working (no pairing/connecting with bluetoothctl needed).

dmesg there:
[  298.641307] Bluetooth: Core ver 2.22
[  298.641393] Bluetooth: HCI device and connection manager initialized
[  298.641405] Bluetooth: HCI socket layer initialized
[  298.641409] Bluetooth: L2CAP socket layer initialized
[  298.641419] Bluetooth: SCO socket layer initialized
[  299.673331] Bluetooth: hci0: unexpected event for opcode 0x0000
[  311.510413] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  311.510422] Bluetooth: BNEP filters: protocol multicast
[  311.510435] Bluetooth: BNEP socket layer initialized
[ 1902.017008] Bluetooth: RFCOMM TTY layer initialized
[ 1902.017026] Bluetooth: RFCOMM socket layer initialized
[ 1902.017048] Bluetooth: RFCOMM ver 1.11

the adapter is:
ID 0b05:1712 ASUSTek Computer, Inc. BT-183 Bluetooth 2.0+EDR adapter

I am now trying to identify the problem. I've logged all data using
btmon from the start to invoking the rfcom connect.

I can see that the difference start when my Asus laptop is showing this:
< ACL Data TX: Handle 42 flags 0x02 dlen 10                                                                        #13 [hci0] 40.891571
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                             #14 [hci0] 40.898476
        Num handles: 1
        Handle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)
        Count: 1
> ACL Data RX: Handle 42 flags 0x02 dlen 16                                                                        #15 [hci0] 40.899488
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000000
< ACL Data TX: Handle 42 flags 0x02 dlen 12                                                                        #16 [hci0] 40.899554
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 3 (0x0003)
        Source CID: 64

I don't see any L2CAP and RFCOMM lines on the "bad" ArchLinux setup.

Please help! I really like to connect to this dongle (even no matter
which software involved - I just want to access this serialport somehow).

I am attaching full logs (called good and bad). dvbsnoop logs also
included.

ps. I tested the dongle also from Windows and Android - also works OK.

-- 
regards,
Mariusz Białończyk
https://skyboo.net | https://github.com/manio

--emrg5mvgsghxonbv
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="bad_btsnoop.log"
Content-Transfer-Encoding: base64

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
AAI=

--emrg5mvgsghxonbv
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="bad_typescript.log"
Content-Transfer-Encoding: quoted-printable

Script started on 2024-02-08 12:54:52+01:00 [TERM=3D"xterm-256color" TTY=3D=
"/dev/pts/13" COLUMNS=3D"182" LINES=3D"54"]
=1B[1m=1B[7m#=1B[27m=1B[1m=1B[0m                                           =
                                                                           =
                                                               =0D =0D=0D=
=1B[0m=1B[27m=1B[24m=1B[J=0D
=1B[1;31mroot=1B[0m in =1B[1;36m/dev/shm=1B[0m =0D
=1B[1;32m=E2=9D=AF=1B[0m =1B[K=1B[?2004hb=08btmon=1B[1m =1B[0m=08=1B[0m -w =
=2E/log=0D=0D=1B[A=1B[A=1B[0m=1B[27m=1B[24m=1B[J=0D
=1B[1;31mroot=1B[0m in =1B[1;36m/dev/shm=1B[0m =0D
=1B[1;32m=E2=9D=AF=1B[0m btmon -w ./log=0D=0D=1B[A=1B[A=1B[0m=1B[27m=1B[24m=
=1B[J=0D
=1B[1;31mroot=1B[0m in =1B[1;36m/dev/shm=1B[0m =0D
=1B[1;32m=E2=9D=AF=1B[0m btmon -w ./log=1B[?2004l=0D=0D
Bluetooth monitor ver 5.71=0D
=1B[0mbtmon[2269455]: =3D Note: Linux version 6.6.10-arch1-1 (x86_64)=1B[0m=
                                                                 =1B[0;33m=
=1B[0;33m 0.884325=1B[0m=0D
=1B[0mbtmon[2269455]: =3D Note: Bluetooth subsystem version 2.22=1B[0m     =
                                                                 =1B[0;33m=
=1B[0;33m 0.884327=1B[0m=0D
=1B[0;32m=3D New Index: 8C:88:2B:12:47:8A=1B[0m (Primary,USB,hci0)         =
                                                             =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.884329=1B[0m=0D
=1B[0;32m=3D Open Index: 8C:88:2B:12:47:8A=1B[0m                           =
                                                             =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.884330=1B[0m=0D
=1B[0;32m=3D Index Info: 8C:88:2B:12:47:8A=1B[0m (Realtek Semiconductor Cor=
poration)                                                    =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.884332=1B[0m=0D
=1B[1;32mbluetoothd[1755534]: @ MGMT Open: bluetoothd=1B[0m (privileged) ve=
rsion 1.22                                               =1B[0;33m=1B[0;37m=
 {0x0001}=1B[0;33m 0.884334=1B[0m=0D
=1B[0;34m< HCI Command: Create Connection=1B[0m (0x01|0x0005) plen 13      =
                                                       =1B[0;33m=1B[0;37m #=
1=1B[0;37m [hci0]=1B[0;33m 22.035468=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mPacket type: 0xcc18=1B[0m=0D
        =1B[0m=1B[0m  DM1 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH1 may be used=1B[0m=0D
        =1B[0m=1B[0m  DM3 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH3 may be used=1B[0m=0D
        =1B[0m=1B[0m  DM5 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH5 may be used=1B[0m=0D
        =1B[0m=1B[0mPage scan repetition mode: R2 (0x02)=1B[0m=0D
        =1B[0m=1B[0mPage scan mode: Mandatory (0x00)=1B[0m=0D
        =1B[0m=1B[0mClock offset: 0x0000=1B[0m=0D
        =1B[0m=1B[0mRole switch: Allow peripheral (0x01)=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
2=1B[0;37m [hci0]=1B[0;33m 22.149266=1B[0m=0D
      =1B[0;34mCreate Connection=1B[0m (0x01|0x0005) ncmd 2=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Connect Complete=1B[0m (0x03) plen 11                =
                                                       =1B[0;33m=1B[0;37m #=
3=1B[0;37m [hci0]=1B[0;33m 24.860582=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 2=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mLink type: ACL (0x01)=1B[0m=0D
        =1B[0m=1B[0mEncryption: Disabled (0x00)=1B[0m=0D
=1B[0;34m< HCI Command: Read Remote Supported Features=1B[0m (0x01|0x001b) =
plen 2                                                 =1B[0;33m=1B[0;37m #=
4=1B[0;37m [hci0]=1B[0;33m 24.860660=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
=1B[1;32mbtmon[2269455]: @ RAW Open: btmon=1B[0m (privileged) version 2.22 =
                                                        =1B[0;33m=1B[0;37m =
{0x0002}=1B[0;33m 24.861029=1B[0m=0D
=1B[1;31mbtmon[2269455]: @ RAW Close: btmon=1B[0m                          =
                                                        =1B[0;33m=1B[0;37m =
{0x0002}=1B[0;33m 24.861032=1B[0m=0D
=1B[0;35m> HCI Event: Max Slots Change=1B[0m (0x1b) plen 3                 =
                                                       =1B[0;33m=1B[0;37m #=
5=1B[0;37m [hci0]=1B[0;33m 24.861582=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mMax slots: 5=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
6=1B[0;37m [hci0]=1B[0;33m 24.863582=1B[0m=0D
      =1B[0;34mRead Remote Supported Features=1B[0m (0x01|0x001b) ncmd 2=1B=
[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Read Remote Supported Features=1B[0m (0x0b) plen 11  =
                                                       =1B[0;33m=1B[0;37m #=
7=1B[0;37m [hci0]=1B[0;33m 24.868581=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mFeatures: 0xbf 0x02 0x00 0x70 0x18 0x1c 0x79 0x83=1B[0m=
=0D
        =1B[0m=1B[0m  3 slot packets=1B[0m=0D
        =1B[0m=1B[0m  5 slot packets=1B[0m=0D
        =1B[0m=1B[0m  Encryption=1B[0m=0D
        =1B[0m=1B[0m  Slot offset=1B[0m=0D
        =1B[0m=1B[0m  Timing accuracy=1B[0m=0D
        =1B[0m=1B[0m  Role switch=1B[0m=0D
        =1B[0m=1B[0m  Sniff mode=1B[0m=0D
        =1B[0m=1B[0m  Power control requests=1B[0m=0D
        =1B[0m=1B[0m  Interlaced inquiry scan=1B[0m=0D
        =1B[0m=1B[0m  Interlaced page scan=1B[0m=0D
        =1B[0m=1B[0m  RSSI with inquiry results=1B[0m=0D
        =1B[0m=1B[0m  AFH capable peripheral=1B[0m=0D
        =1B[0m=1B[0m  AFH classification peripheral=1B[0m=0D
        =1B[0m=1B[0m  Pause encryption=1B[0m=0D
        =1B[0m=1B[0m  AFH capable central=1B[0m=0D
        =1B[0m=1B[0m  AFH classification central=1B[0m=0D
        =1B[0m=1B[0m  Extended Inquiry Response=1B[0m=0D
        =1B[0m=1B[0m  Secure Simple Pairing=1B[0m=0D
        =1B[0m=1B[0m  Encapsulated PDU=1B[0m=0D
        =1B[0m=1B[0m  Erroneous Data Reporting=1B[0m=0D
        =1B[0m=1B[0m  Non-flushable Packet Boundary Flag=1B[0m=0D
        =1B[0m=1B[0m  Link Supervision Timeout Changed Event=1B[0m=0D
        =1B[0m=1B[0m  Inquiry TX Power Level=1B[0m=0D
        =1B[0m=1B[0m  Extended features=1B[0m=0D
=1B[0;34m< HCI Command: Read Remote Extended Features=1B[0m (0x01|0x001c) p=
len 3                                                  =1B[0;33m=1B[0;37m #=
8=1B[0;37m [hci0]=1B[0;33m 24.868595=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mPage: 1=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
9=1B[0;37m [hci0]=1B[0;33m 24.870585=1B[0m=0D
      =1B[0;34mRead Remote Extended Features=1B[0m (0x01|0x001c) ncmd 2=1B[=
0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Read Remote Extended Features=1B[0m (0x23) plen 13   =
                                                      =1B[0;33m=1B[0;37m #1=
0=1B[0;37m [hci0]=1B[0;33m 24.897600=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mPage: 1/1=1B[0m=0D
        =1B[0m=1B[0mFeatures: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=1B[0m=
=0D
        =1B[0m=1B[0m  Secure Simple Pairing (Host Support)=1B[0m=0D
=1B[0;34m< HCI Command: Remote Name Request=1B[0m (0x01|0x0019) plen 10    =
                                                      =1B[0;33m=1B[0;37m #1=
1=1B[0;37m [hci0]=1B[0;33m 24.897646=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mPage scan repetition mode: R2 (0x02)=1B[0m=0D
        =1B[0m=1B[0mPage scan mode: Mandatory (0x00)=1B[0m=0D
        =1B[0m=1B[0mClock offset: 0x0000=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                      =1B[0;33m=1B[0;37m #1=
2=1B[0;37m [hci0]=1B[0;33m 24.899592=1B[0m=0D
      =1B[0;34mRemote Name Request=1B[0m (0x01|0x0019) ncmd 2=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Remote Name Req Complete=1B[0m (0x07) plen 255       =
                                                      =1B[0;33m=1B[0;37m #1=
3=1B[0;37m [hci0]=1B[0;33m 24.922588=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mName: KONNWEI=1B[0m=0D
=1B[1;35m@ MGMT Event: Device Connected=1B[0m (0x000b) plen 22             =
                                                 =1B[0;33m=1B[0;37m {0x0001=
}=1B[0;37m [hci0]=1B[0;33m 24.922603=1B[0m=0D
        =1B[0m=1B[0mBR/EDR Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=
=0D
        =1B[0m=1B[0mFlags: 0x00000008=1B[0m=0D
        =1B[0m=1B[0m  Connection Locally Initiated=1B[0m=0D
        =1B[0m=1B[0mData length: 9=1B[0m=0D
        =1B[0m=1B[0mName (complete): KONNWEI=1B[0m=0D
=1B[0;34m< HCI Command: Authentication Requested=1B[0m (0x01|0x0011) plen 2=
                                                      =1B[0;33m=1B[0;37m #1=
4=1B[0;37m [hci0]=1B[0;33m 24.922610=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                      =1B[0;33m=1B[0;37m #1=
5=1B[0;37m [hci0]=1B[0;33m 24.924601=1B[0m=0D
      =1B[0;34mAuthentication Requested=1B[0m (0x01|0x0011) ncmd 2=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Link Key Request=1B[0m (0x17) plen 6                 =
                                                      =1B[0;33m=1B[0;37m #1=
6=1B[0;37m [hci0]=1B[0;33m 24.925588=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;34m< HCI Command: Link Key Request Negative Reply=1B[0m (0x01|0x000c)=
 plen 6                                               =1B[0;33m=1B[0;37m #1=
7=1B[0;37m [hci0]=1B[0;33m 24.925601=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: Command Complete=1B[0m (0x0e) plen 10                =
                                                      =1B[0;33m=1B[0;37m #1=
8=1B[0;37m [hci0]=1B[0;33m 24.928591=1B[0m=0D
      =1B[0;34mLink Key Request Negative Reply=1B[0m (0x01|0x000c) ncmd 2=
=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: IO Capability Request=1B[0m (0x31) plen 6            =
                                                      =1B[0;33m=1B[0;37m #1=
9=1B[0;37m [hci0]=1B[0;33m 24.929600=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;34m< HCI Command: IO Capability Request Reply=1B[0m (0x01|0x002b) ple=
n 9                                                   =1B[0;33m=1B[0;37m #2=
0=1B[0;37m [hci0]=1B[0;33m 24.929640=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mIO capability: DisplayYesNo (0x01)=1B[0m=0D
        =1B[0m=1B[0mOOB data: Authentication data not present (0x00)=1B[0m=
=0D
        =1B[0m=1B[0mAuthentication: No Bonding - MITM not required (0x00)=
=1B[0m=0D
=1B[0;35m> HCI Event: Command Complete=1B[0m (0x0e) plen 10                =
                                                      =1B[0;33m=1B[0;37m #2=
1=1B[0;37m [hci0]=1B[0;33m 24.932593=1B[0m=0D
      =1B[0;34mIO Capability Request Reply=1B[0m (0x01|0x002b) ncmd 2=1B[0m=
=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: IO Capability Response=1B[0m (0x32) plen 9           =
                                                      =1B[0;33m=1B[0;37m #2=
2=1B[0;37m [hci0]=1B[0;33m 24.961594=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mIO capability: NoInputNoOutput (0x03)=1B[0m=0D
        =1B[0m=1B[0mOOB data: Authentication data not present (0x00)=1B[0m=
=0D
        =1B[0m=1B[0mAuthentication: General Bonding - MITM not required (0x=
04)=1B[0m=0D
=1B[0;35m> HCI Event: User Confirmation Request=1B[0m (0x33) plen 10       =
                                                      =1B[0;33m=1B[0;37m #2=
3=1B[0;37m [hci0]=1B[0;33m 25.379644=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mPasskey: 299050=1B[0m=0D
=1B[0;34m< HCI Command: User Confirmation Request Reply=1B[0m (0x01|0x002c)=
 plen 6                                               =1B[0;33m=1B[0;37m #2=
4=1B[0;37m [hci0]=1B[0;33m 25.379668=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: Command Complete=1B[0m (0x0e) plen 10                =
                                                      =1B[0;33m=1B[0;37m #2=
5=1B[0;37m [hci0]=1B[0;33m 25.622674=1B[0m=0D
      =1B[0;34mUser Confirmation Request Reply=1B[0m (0x01|0x002c) ncmd 2=
=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: Simple Pairing Complete=1B[0m (0x36) plen 7          =
                                                      =1B[0;33m=1B[0;37m #2=
6=1B[0;37m [hci0]=1B[0;33m 26.589786=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
=1B[0;35m> HCI Event: Auth Complete=1B[0m (0x06) plen 3                    =
                                                      =1B[0;33m=1B[0;37m #2=
7=1B[0;37m [hci0]=1B[0;33m 56.710325=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;31mLMP Response Timeout / LL Response Tim=
eout=1B[0m (0x22)=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
=1B[1;35m@ MGMT Event: Authentication Failed=1B[0m (0x0011) plen 8         =
                                                 =1B[0;33m=1B[0;37m {0x0001=
}=1B[0;37m [hci0]=1B[0;33m 56.710352=1B[0m=0D
        =1B[0m=1B[0mBR/EDR Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=
=0D
        =1B[0m=1B[0mStatus: =1B[0;31mTimeout=1B[0m (0x08)=1B[0m=0D
=1B[0;34m< HCI Command: Disconnect=1B[0m (0x01|0x0006) plen 3              =
                                                      =1B[0;33m=1B[0;37m #2=
8=1B[0;37m [hci0]=1B[0;33m 56.743032=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mReason: =1B[0;31mRemote User Terminated Connection=1B[0=
m (0x13)=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                      =1B[0;33m=1B[0;37m #2=
9=1B[0;37m [hci0]=1B[0;33m 56.745340=1B[0m=0D
      =1B[0;34mDisconnect=1B[0m (0x01|0x0006) ncmd 2=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Disconnect Complete=1B[0m (0x05) plen 4              =
                                                      =1B[0;33m=1B[0;37m #3=
0=1B[0;37m [hci0]=1B[0;33m 56.818364=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 2 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[=
0m=0D
        =1B[0m=1B[0mReason: =1B[0;31mConnection Terminated By Local Host=1B=
[0m (0x16)=1B[0m=0D
=1B[1;35m@ MGMT Event: Device Disconnected=1B[0m (0x000c) plen 8           =
                                                 =1B[0;33m=1B[0;37m {0x0001=
}=1B[0;37m [hci0]=1B[0;33m 56.818410=1B[0m=0D
        =1B[0m=1B[0mBR/EDR Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=
=0D
        =1B[0m=1B[0mReason: Connection terminated by local host (0x02)=1B[0=
m=0D
^C=1B[1m=1B[7m#=1B[27m=1B[1m=1B[0m                                         =
                                                                           =
                   =0D =0D=0D=1B[0m=1B[27m=1B[24m=1B[J=0D
=1B[1;31mroot=1B[0m in =1B[1;36m/dev/shm=1B[0m took =1B[1;33m1m15s=1B[0m =0D
=1B[1;32m=E2=9D=AF=1B[0m =1B[K=1B[?2004h=1B[?2004l=0D=0D

Script done on 2024-02-08 12:57:13+01:00 [COMMAND_EXIT_CODE=3D"0"]

--emrg5mvgsghxonbv
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="good_btsnoop.log"
Content-Transfer-Encoding: base64

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
QA==

--emrg5mvgsghxonbv
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="good_typescript.log"
Content-Transfer-Encoding: quoted-printable

Script started on 2024-02-08 13:08:24+01:00 [TERM=3D"xterm-256color" TTY=3D=
"/dev/pts/0" COLUMNS=3D"136" LINES=3D"58"]
=1B[?2004hcyrus:/dev/shm# =0D(reverse-i-search)`': =08=08=08b': rfcomm un=
=1B[7mb=1B[27mind 0 B8:8B:15:0A:1C:AD=08=08=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=1B=
[8Pt': =1B[7mbt=1B[27mmon -w ./log > log.txt=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=1B[1@m': =1B[7mbtm=1B[2=
7m=08=08=08=08=08=08=1B[1@o': =1B[7mbtmo=1B[27m=08=08=08=08=0D=1B[10Pcyrus:=
/dev/shm# btmo=08=08=08=08=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[=
C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=1B[C=08=
=08=08=08=08=08=08=1B[K=08=1B[K=08=1B[K=08=1B[K=0D
=1B[?2004l=0DBluetooth monitor ver 5.66=0D
=1B[0m=3D Note: Linux version 5.10.0-8-686-pae (i686)=1B[0m                =
                                                                 =1B[0;33m=
=1B[0;33m 0.559085=1B[0m=0D
=1B[0m=3D Note: Bluetooth subsystem version 2.22=1B[0m                     =
                                                                 =1B[0;33m=
=1B[0;33m 0.559095=1B[0m=0D
=1B[0;32m=3D New Index: 00:1A:92:C7:CE:51=1B[0m (Primary,USB,hci0)         =
                                                             =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.559100=1B[0m=0D
=1B[0;32m=3D Open Index: 00:1A:92:C7:CE:51=1B[0m                           =
                                                             =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.559104=1B[0m=0D
=1B[0;32m=3D Index Info: 00:1A:92:C7:CE:51=1B[0m (Cambridge Silicon Radio) =
                                                             =1B[0;33m=1B[0=
;37m [hci0]=1B[0;33m 0.559107=1B[0m=0D
=1B[1;32m@ MGMT Open: bluetoothd=1B[0m (privileged) version 1.18           =
                                                         =1B[0;33m=1B[0;37m=
 {0x0001}=1B[0;33m 0.559113=1B[0m=0D
=1B[0;34m< HCI Command: Create Connection=1B[0m (0x01|0x0005) plen 13      =
                                                       =1B[0;33m=1B[0;37m #=
1=1B[0;37m [hci0]=1B[0;33m 40.522815=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mPacket type: 0xcc18=1B[0m=0D
        =1B[0m=1B[0m  DM1 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH1 may be used=1B[0m=0D
        =1B[0m=1B[0m  DM3 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH3 may be used=1B[0m=0D
        =1B[0m=1B[0m  DM5 may be used=1B[0m=0D
        =1B[0m=1B[0m  DH5 may be used=1B[0m=0D
        =1B[0m=1B[0mPage scan repetition mode: R2 (0x02)=1B[0m=0D
        =1B[0m=1B[0mPage scan mode: Mandatory (0x00)=1B[0m=0D
        =1B[0m=1B[0mClock offset: 0x0000=1B[0m=0D
        =1B[0m=1B[0mRole switch: Allow peripheral (0x01)=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
2=1B[0;37m [hci0]=1B[0;33m 40.532478=1B[0m=0D
      =1B[0;34mCreate Connection=1B[0m (0x01|0x0005) ncmd 1=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Connect Complete=1B[0m (0x03) plen 11                =
                                                       =1B[0;33m=1B[0;37m #=
3=1B[0;37m [hci0]=1B[0;33m 40.840478=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 42=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mLink type: ACL (0x01)=1B[0m=0D
        =1B[0m=1B[0mEncryption: Disabled (0x00)=1B[0m=0D
=1B[0;34m< HCI Command: Read Remote Supported Features=1B[0m (0x01|0x001b) =
plen 2                                                 =1B[0;33m=1B[0;37m #=
4=1B[0;37m [hci0]=1B[0;33m 40.840690=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
=1B[1;32m@ RAW Open: btmon=1B[0m (privileged) version 2.22                 =
                                                        =1B[0;33m=1B[0;37m =
{0x0002}=1B[0;33m 40.841050=1B[0m=0D
=1B[1;31m@ RAW Close: btmon=1B[0m                                          =
                                                        =1B[0;33m=1B[0;37m =
{0x0002}=1B[0;33m 40.841067=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
5=1B[0;37m [hci0]=1B[0;33m 40.857466=1B[0m=0D
      =1B[0;34mRead Remote Supported Features=1B[0m (0x01|0x001b) ncmd 0=1B=
[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Max Slots Change=1B[0m (0x1b) plen 3                 =
                                                       =1B[0;33m=1B[0;37m #=
6=1B[0;37m [hci0]=1B[0;33m 40.859464=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mMax slots: 5=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                       =1B[0;33m=1B[0;37m #=
7=1B[0;37m [hci0]=1B[0;33m 40.864464=1B[0m=0D
      =1B[0;34mNOP=1B[0m (0x00|0x0000) ncmd 1=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Read Remote Supported Features=1B[0m (0x0b) plen 11  =
                                                       =1B[0;33m=1B[0;37m #=
8=1B[0;37m [hci0]=1B[0;33m 40.879478=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mFeatures: 0xbf 0x02 0x00 0x70 0x18 0x1c 0x79 0x83=1B[0m=
=0D
        =1B[0m=1B[0m  3 slot packets=1B[0m=0D
        =1B[0m=1B[0m  5 slot packets=1B[0m=0D
        =1B[0m=1B[0m  Encryption=1B[0m=0D
        =1B[0m=1B[0m  Slot offset=1B[0m=0D
        =1B[0m=1B[0m  Timing accuracy=1B[0m=0D
        =1B[0m=1B[0m  Role switch=1B[0m=0D
        =1B[0m=1B[0m  Sniff mode=1B[0m=0D
        =1B[0m=1B[0m  Power control requests=1B[0m=0D
        =1B[0m=1B[0m  Interlaced inquiry scan=1B[0m=0D
        =1B[0m=1B[0m  Interlaced page scan=1B[0m=0D
        =1B[0m=1B[0m  RSSI with inquiry results=1B[0m=0D
        =1B[0m=1B[0m  AFH capable peripheral=1B[0m=0D
        =1B[0m=1B[0m  AFH classification peripheral=1B[0m=0D
        =1B[0m=1B[0m  Pause encryption=1B[0m=0D
        =1B[0m=1B[0m  AFH capable central=1B[0m=0D
        =1B[0m=1B[0m  AFH classification central=1B[0m=0D
        =1B[0m=1B[0m  Extended Inquiry Response=1B[0m=0D
        =1B[0m=1B[0m  Secure Simple Pairing=1B[0m=0D
        =1B[0m=1B[0m  Encapsulated PDU=1B[0m=0D
        =1B[0m=1B[0m  Erroneous Data Reporting=1B[0m=0D
        =1B[0m=1B[0m  Non-flushable Packet Boundary Flag=1B[0m=0D
        =1B[0m=1B[0m  Link Supervision Timeout Changed Event=1B[0m=0D
        =1B[0m=1B[0m  Inquiry TX Power Level=1B[0m=0D
        =1B[0m=1B[0m  Extended features=1B[0m=0D
=1B[0;34m< HCI Command: Read Remote Extended Features=1B[0m (0x01|0x001c) p=
len 3                                                  =1B[0;33m=1B[0;37m #=
9=1B[0;37m [hci0]=1B[0;33m 40.879547=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mPage: 1=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                      =1B[0;33m=1B[0;37m #1=
0=1B[0;37m [hci0]=1B[0;33m 40.886476=1B[0m=0D
      =1B[0;34mRead Remote Extended Features=1B[0m (0x01|0x001c) ncmd 1=1B[=
0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;35m> HCI Event: Read Remote Extended Features=1B[0m (0x23) plen 13   =
                                                      =1B[0;33m=1B[0;37m #1=
1=1B[0;37m [hci0]=1B[0;33m 40.891477=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mPage: 1/1=1B[0m=0D
        =1B[0m=1B[0mFeatures: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00=1B[0m=
=0D
        =1B[0m=1B[0m  Secure Simple Pairing (Host Support)=1B[0m=0D
=1B[0;34m< HCI Command: Remote Name Request=1B[0m (0x01|0x0019) plen 10    =
                                                      =1B[0;33m=1B[0;37m #1=
2=1B[0;37m [hci0]=1B[0;33m 40.891552=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mPage scan repetition mode: R2 (0x02)=1B[0m=0D
        =1B[0m=1B[0mPage scan mode: Mandatory (0x00)=1B[0m=0D
        =1B[0m=1B[0mClock offset: 0x0000=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 10                 =
                                                      =1B[0;33m=1B[0;37m #1=
3=1B[0;37m [hci0]=1B[0;33m 40.891571=1B[0m=0D
      =1B[0;34mL2CAP: Information Request=1B[0m (0x0a) ident 1 len 2=1B[0m=
=0D
        =1B[0m=1B[0mType: Extended features supported (0x0002)=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #1=
4=1B[0;37m [hci0]=1B[0;33m 40.898476=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 16                 =
                                                      =1B[0;33m=1B[0;37m #1=
5=1B[0;37m [hci0]=1B[0;33m 40.899488=1B[0m=0D
      =1B[0;35mL2CAP: Information Response=1B[0m (0x0b) ident 1 len 8=1B[0m=
=0D
        =1B[0m=1B[0mType: Extended features supported (0x0002)=1B[0m=0D
        =1B[0m=1B[0mResult: Success (0x0000)=1B[0m=0D
        =1B[0m=1B[0mFeatures: 0x00000000=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #1=
6=1B[0;37m [hci0]=1B[0;33m 40.899554=1B[0m=0D
      =1B[0;34mL2CAP: Connection Request=1B[0m (0x02) ident 2 len 4=1B[0m=0D
        =1B[0m=1B[0mPSM: 3 (0x0003)=1B[0m=0D
        =1B[0m=1B[0mSource CID: 64=1B[0m=0D
=1B[0;35m> HCI Event: Command Status=1B[0m (0x0f) plen 4                   =
                                                      =1B[0;33m=1B[0;37m #1=
7=1B[0;37m [hci0]=1B[0;33m 40.904476=1B[0m=0D
      =1B[0;34mRemote Name Request=1B[0m (0x01|0x0019) ncmd 1=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 16                 =
                                                      =1B[0;33m=1B[0;37m #1=
8=1B[0;37m [hci0]=1B[0;33m 40.905481=1B[0m=0D
      =1B[0;35mL2CAP: Connection Response=1B[0m (0x03) ident 2 len 8=1B[0m=
=0D
        =1B[0m=1B[0mDestination CID: 71=1B[0m=0D
        =1B[0m=1B[0mSource CID: 64=1B[0m=0D
        =1B[0m=1B[0mResult: Connection pending (0x0001)=1B[0m=0D
        =1B[0m=1B[0mStatus: Authorization pending (0x0002)=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #1=
9=1B[0;37m [hci0]=1B[0;33m 40.906462=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 16                 =
                                                      =1B[0;33m=1B[0;37m #2=
0=1B[0;37m [hci0]=1B[0;33m 40.929484=1B[0m=0D
      =1B[0;35mL2CAP: Connection Response=1B[0m (0x03) ident 2 len 8=1B[0m=
=0D
        =1B[0m=1B[0mDestination CID: 71=1B[0m=0D
        =1B[0m=1B[0mSource CID: 64=1B[0m=0D
        =1B[0m=1B[0mResult: Connection successful (0x0000)=1B[0m=0D
        =1B[0m=1B[0mStatus: No further information available (0x0000)=1B[0m=
=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 16                 =
                                                      =1B[0;33m=1B[0;37m #2=
1=1B[0;37m [hci0]=1B[0;33m 40.929560=1B[0m=0D
      =1B[0;34mL2CAP: Configure Request=1B[0m (0x04) ident 3 len 8=1B[0m=0D
        =1B[0m=1B[0mDestination CID: 71=1B[0m=0D
        =1B[0m=1B[0mFlags: 0x0000=1B[0m=0D
        =1B[0m=1B[0mOption: Maximum Transmission Unit (0x01) [mandatory]=1B=
[0m=0D
        =1B[0m=1B[0m  MTU: 1021=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 16                 =
                                                      =1B[0;33m=1B[0;37m #2=
2=1B[0;37m [hci0]=1B[0;33m 40.932479=1B[0m=0D
      =1B[0;35mL2CAP: Configure Request=1B[0m (0x04) ident 13 len 8=1B[0m=0D
        =1B[0m=1B[0mDestination CID: 64=1B[0m=0D
        =1B[0m=1B[0mFlags: 0x0000=1B[0m=0D
        =1B[0m=1B[0mOption: Maximum Transmission Unit (0x01) [mandatory]=1B=
[0m=0D
        =1B[0m=1B[0m  MTU: 128=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 18                 =
                                                      =1B[0;33m=1B[0;37m #2=
3=1B[0;37m [hci0]=1B[0;33m 40.932539=1B[0m=0D
      =1B[0;34mL2CAP: Configure Response=1B[0m (0x05) ident 13 len 10=1B[0m=
=0D
        =1B[0m=1B[0mSource CID: 71=1B[0m=0D
        =1B[0m=1B[0mFlags: 0x0000=1B[0m=0D
        =1B[0m=1B[0mResult: Success (0x0000)=1B[0m=0D
        =1B[0m=1B[0mOption: Maximum Transmission Unit (0x01) [mandatory]=1B=
[0m=0D
        =1B[0m=1B[0m  MTU: 128=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 14                 =
                                                      =1B[0;33m=1B[0;37m #2=
4=1B[0;37m [hci0]=1B[0;33m 40.940478=1B[0m=0D
      =1B[0;35mL2CAP: Configure Response=1B[0m (0x05) ident 3 len 6=1B[0m=0D
        =1B[0m=1B[0mSource CID: 64=1B[0m=0D
        =1B[0m=1B[0mFlags: 0x0000=1B[0m=0D
        =1B[0m=1B[0mResult: Success (0x0000)=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 8                  =
                                                      =1B[0;33m=1B[0;37m #2=
5=1B[0;37m [hci0]=1B[0;33m 40.940587=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 4 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Set Async Balance Mode (SABM)=1B[0m (0x2f)=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0x3f poll/final 1=1B[0m=0D
        =1B[0m=1B[0m Length: 0=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x1c=1B[0m=0D
=1B[0;35m> HCI Event: Remote Name Req Complete=1B[0m (0x07) plen 255       =
                                                      =1B[0;33m=1B[0;37m #2=
6=1B[0;37m [hci0]=1B[0;33m 40.947472=1B[0m=0D
        =1B[0m=1B[0mStatus: =1B[0;32mSuccess=1B[0m (0x00)=1B[0m=0D
        =1B[0m=1B[0mAddress: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=0D
        =1B[0m=1B[0mName: KONNWEI=1B[0m=0D
=1B[1;35m@ MGMT Event: Device Connected=1B[0m (0x000b) plen 27             =
                                                 =1B[0;33m=1B[0;37m {0x0001=
}=1B[0;37m [hci0]=1B[0;33m 40.947524=1B[0m=0D
        =1B[0m=1B[0mBR/EDR Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B[0m=
=0D
        =1B[0m=1B[0mFlags: 0x00000000=1B[0m=0D
        =1B[0m=1B[0mData length: 14=1B[0m=0D
        =1B[0m=1B[0mName (complete): KONNWEI=1B[0m=0D
        =1B[0m=1B[0mClass: 0x040424=1B[0m=0D
        =1B[0m=1B[0m  Major class: Audio/Video (headset, speaker, stereo, v=
ideo, vcr)=1B[0m=0D
        =1B[0m=1B[0m  Minor class: Set-top box=1B[0m=0D
        =1B[0m=1B[0m  Rendering (Printing, Speaker)=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 8                  =
                                                      =1B[0;33m=1B[0;37m #2=
7=1B[0;37m [hci0]=1B[0;33m 40.948468=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 4 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Ack (UA)=1B[0m (0x63)=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0x73 poll/final 1=1B[0m=0D
        =1B[0m=1B[0m Length: 0=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xd7=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 18                 =
                                                      =1B[0;33m=1B[0;37m #2=
8=1B[0;37m [hci0]=1B[0;33m 40.948566=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 14 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 10=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x70=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: DLC Parameter Negotiation CMD (0x20)=
=1B[0m=0D
        =1B[0m=1B[0m   Length: 8=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 frame_type 0 credit_flow 15 pri 7=1B[0m=0D
        =1B[0m=1B[0m   ack_timer 0 frame_size 123 max_retrans 0 credits 7=
=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #2=
9=1B[0;37m [hci0]=1B[0;33m 40.949469=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #3=
0=1B[0;37m [hci0]=1B[0;33m 40.951463=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #3=
1=1B[0;37m [hci0]=1B[0;33m 40.953476=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #3=
2=1B[0;37m [hci0]=1B[0;33m 40.956477=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 18                 =
                                                      =1B[0;33m=1B[0;37m #3=
3=1B[0;37m [hci0]=1B[0;33m 40.957482=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x01 cr 0 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 10=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xaa=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: DLC Parameter Negotiation RSP (0x20)=
=1B[0m=0D
        =1B[0m=1B[0m   Length: 8=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 frame_type 0 credit_flow 14 pri 7=1B[0m=0D
        =1B[0m=1B[0m   ack_timer 0 frame_size 123 max_retrans 0 credits 4=
=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 8                  =
                                                      =1B[0;33m=1B[0;37m #3=
4=1B[0;37m [hci0]=1B[0;33m 40.957579=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 4 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Set Async Balance Mode (SABM)=1B[0m (0x2f)=1B[0m=0D
        =1B[0m=1B[0m Address: 0x0b cr 1 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0x3f poll/final 1=1B[0m=0D
        =1B[0m=1B[0m Length: 0=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x59=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #3=
5=1B[0;37m [hci0]=1B[0;33m 40.963476=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 8                  =
                                                      =1B[0;33m=1B[0;37m #3=
6=1B[0;37m [hci0]=1B[0;33m 40.964481=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 4 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Ack (UA)=1B[0m (0x63)=1B[0m=0D
        =1B[0m=1B[0m Address: 0x0b cr 1 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0x73 poll/final 1=1B[0m=0D
        =1B[0m=1B[0m Length: 0=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x92=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #3=
7=1B[0;37m [hci0]=1B[0;33m 40.964761=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x70=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command CMD (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #3=
8=1B[0;37m [hci0]=1B[0;33m 40.967465=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x01 cr 0 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xaa=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command CMD (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #3=
9=1B[0;37m [hci0]=1B[0;33m 40.967542=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x70=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command RSP (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #4=
0=1B[0;37m [hci0]=1B[0;33m 40.972462=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #4=
1=1B[0;37m [hci0]=1B[0;33m 40.974484=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x01 cr 0 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xaa=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command RSP (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 9                  =
                                                      =1B[0;33m=1B[0;37m #4=
2=1B[0;37m [hci0]=1B[0;33m 40.974590=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 5 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x0b cr 1 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0xff poll/final 1=1B[0m=0D
        =1B[0m=1B[0m Length: 0=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x86=1B[0m=0D
        =1B[0m=1B[0m Credits: 33=1B[0m=0D
        =1B[0m=1B[0;37m86                                               .  =
             =1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #4=
3=1B[0;37m [hci0]=1B[0;33m 40.976460=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #4=
4=1B[0;37m [hci0]=1B[0;33m 40.981477=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 18                 =
                                                      =1B[0;33m=1B[0;37m #4=
5=1B[0;37m [hci0]=1B[0;33m 57.978492=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 14 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 10=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x70=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Remote Port Negotiation Command CMD =
(0x24)=1B[0m=0D
        =1B[0m=1B[0m   Length: 8=1B[0m=0D
        =1B[0m=1B[0m   dlci 2=1B[0m=0D
        =1B[0m=1B[0m   br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0=1B[0m=0D
        =1B[0m=1B[0m   rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19=1B[0m=0D
        =1B[0m=1B[0m   pm 0x0001=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #4=
6=1B[0;37m [hci0]=1B[0;33m 57.978615=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x03 cr 1 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x70=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command CMD (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #4=
7=1B[0;37m [hci0]=1B[0;33m 58.001426=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #4=
8=1B[0;37m [hci0]=1B[0;33m 58.005416=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 18                 =
                                                      =1B[0;33m=1B[0;37m #4=
9=1B[0;37m [hci0]=1B[0;33m 58.005445=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x01 cr 0 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 10=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xaa=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Remote Port Negotiation Command RSP =
(0x24)=1B[0m=0D
        =1B[0m=1B[0m   Length: 8=1B[0m=0D
        =1B[0m=1B[0m   dlci 2=1B[0m=0D
        =1B[0m=1B[0m   br 7 db 3 sb 0 p 0 pt 0 xi 0 xo 0=1B[0m=0D
        =1B[0m=1B[0m   rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19=1B[0m=0D
        =1B[0m=1B[0m   pm 0x0001=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 12                 =
                                                      =1B[0;33m=1B[0;37m #5=
0=1B[0;37m [hci0]=1B[0;33m 58.007419=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 8 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x01 cr 0 dlci 0x00=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 4=1B[0m=0D
        =1B[0m=1B[0m FCS: 0xaa=1B[0m=0D
        =1B[0m=1B[0m MCC Message type: Modem Status Command RSP (0x38)=1B[0=
m=0D
        =1B[0m=1B[0m   Length: 2=1B[0m=0D
        =1B[0m=1B[0m   dlci 2 =1B[0m=0D
        =1B[0m=1B[0m   fc 0 rtc 1 rtr 1 ic 0 dv 1=1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 9                  =
                                                      =1B[0;33m=1B[0;37m #5=
1=1B[0;37m [hci0]=1B[0;33m 61.065068=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 5 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x0b cr 1 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 1=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x9a=1B[0m=0D
        =1B[0m=1B[0;37m41 9a                                            A. =
             =1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #5=
2=1B[0;37m [hci0]=1B[0;33m 61.074400=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 10                 =
                                                      =1B[0;33m=1B[0;37m #5=
3=1B[0;37m [hci0]=1B[0;33m 61.114410=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 6 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x09 cr 0 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 1=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x40=1B[0m=0D
        =1B[0m=1B[0;37m41 40                                            A@ =
             =1B[0m=0D
=1B[0;36m< ACL Data TX: Handle 42=1B[0m flags 0x02 dlen 9                  =
                                                      =1B[0;33m=1B[0;37m #5=
4=1B[0;37m [hci0]=1B[0;33m 61.471610=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 71 len 5 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;34mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x0b cr 1 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
        =1B[0m=1B[0m Length: 1=1B[0m=0D
        =1B[0m=1B[0m FCS: 0x9a=1B[0m=0D
        =1B[0m=1B[0;37m54 9a                                            T. =
             =1B[0m=0D
=1B[0;35m> HCI Event: Number of Completed Packets=1B[0m (0x13) plen 5      =
                                                      =1B[0;33m=1B[0;37m #5=
5=1B[0;37m [hci0]=1B[0;33m 61.481399=1B[0m=0D
        =1B[0m=1B[0mNum handles: 1=1B[0m=0D
        =1B[0m=1B[0mHandle: 42 Address: B8:8B:15:0A:1C:AD (OUI B8-8B-15)=1B=
[0m=0D
        =1B[0m=1B[0mCount: 1=1B[0m=0D
=1B[0;36m> ACL Data RX: Handle 42=1B[0m flags 0x02 dlen 10                 =
                                                      =1B[0;33m=1B[0;37m #5=
6=1B[0;37m [hci0]=1B[0;33m 61.522405=1B[0m=0D
      =1B[0;36mChannel:=1B[0m 64 len 6 [PSM 3 mode Basic (0x00)] {chan 0}=
=1B[0m=0D
      =1B[0;35mRFCOMM: Unnumbered Info with Header Check (UIH)=1B[0m (0xef)=
=1B[0m=0D
        =1B[0m=1B[0m Address: 0x09 cr 0 dlci 0x02=1B[0m=0D
        =1B[0m=1B[0m Control: 0xef poll/final 0=1B[0m=0D
=20
--emrg5mvgsghxonbv--
