Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to use GattProfile1
From: Krasi Georgiev <krasi.root@gmail.com>
In-Reply-To: <39cb9ea22f14454d83b6e62e59bdc955@sjbsvr074.groupe.local>
Date: Sun, 4 Jun 2017 16:15:03 +0300
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <8D8EB08D-CA68-400C-A987-8ADA4B45E2C2@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
 <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com>
 <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com>
 <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com>
 <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
 <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com>
 <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com>
 <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com> <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
 <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com> <CABBYNZLVjXXmbfTb2Uo9KvE2D83c1PU7f2p=t6JawfeyUfN2+w@mail.gmail.com>
 <3290BB41-234F-4D7B-BF37-0CC2966CB416@gmail.com> <CABBYNZKoACnV5rOQ1dJH56Uien-CdMy7CUfgvZEGdJvuLXKBgQ@mail.gmail.com>
 <5D01EC8C-E51B-4F89-8F9B-5D7946674116@gmail.com> <CABBYNZ+P8fzQP_v5dtWTHhXthE7JhsJeLBts4+_eweVDBMZpSQ@mail.gmail.com>
 <329D353B-8799-434A-9049-AE8904429A78@gmail.com> <CABBYNZJPrNfN-ns60zts863J=0Ec-np5AQb9aguS67fF0ZNbkA@mail.gmail.com>
 <39cb9ea22f14454d83b6e62e59bdc955@sjbsvr074.groupe.local>
To: Boris Passerat de la chapelle <bpasserat@h2ad.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

just tried with the latest master and I still can=E2=80=99t get it to =
auto connect


Here is what happens so let me know if I am doing in the correct =
sequence


[bluetooth]# devices
Device 34:31:11:00:CD:7A Samsung Galaxy S IV
Device 04:52:C7:57:85:84 Bose Mini II SoundLink
Device FF:FF:50:00:53:B6 iTAG

[bluetooth]# power on
Changing power on succeeded
[CHG] Controller B8:27:EB:D5:54:1C Powered: yes
[bluetooth]# connect FF:FF:50:00:53:B6
Attempting to connect to FF:FF:50:00:53:B6
[CHG] Device FF:FF:50:00:53:B6 Connected: yes
Connection successful
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006/char0007
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009
	00001802-0000-1000-8000-00805f9b34fb
	Immediate Alert
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009/char000a
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c
	0000ffe0-0000-1000-8000-00805f9b34fb
	Unknown
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c/char000d
	0000ffe1-0000-1000-8000-00805f9b34fb
	Unknown
[CHG] Device FF:FF:50:00:53:B6 UUIDs: =
00001800-0000-1000-8000-00805f9b34fb
[CHG] Device FF:FF:50:00:53:B6 UUIDs: =
00001802-0000-1000-8000-00805f9b34fb
[CHG] Device FF:FF:50:00:53:B6 UUIDs: =
0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device FF:FF:50:00:53:B6 UUIDs: =
0000ffe0-0000-1000-8000-00805f9b34fb
[CHG] Device FF:FF:50:00:53:B6 ServicesResolved: yes
[CHG] Device FF:FF:50:00:53:B6 Icon is nil
[CHG] Device FF:FF:50:00:53:B6 Appearance is nil

[iTAG            ]# register-application =
0000180f-0000-1000-8000-00805f9b34fb
Application registered
[CHG] Device FF:FF:50:00:53:B6 ServicesResolved: no
[CHG] Device FF:FF:50:00:53:B6 Connected: no


Here i power cycled the iTag and waited few minutes but bluetoothctl =
didn=E2=80=99t reconnect so I did it manually.


[bluetooth]# info FF:FF:50:00:53:B6
Device FF:FF:50:00:53:B6
	Name: iTAG
	Alias: iTAG
	Paired: no
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Generic Access Profile    =
(00001800-0000-1000-8000-00805f9b34fb)
	UUID: Immediate Alert           =
(00001802-0000-1000-8000-00805f9b34fb)
	UUID: Battery Service           =
(0000180f-0000-1000-8000-00805f9b34fb)
	UUID: Unknown                   =
(0000ffe0-0000-1000-8000-00805f9b34fb)
[bluetooth]# connect FF:FF:50:00:53:B6
Attempting to connect to FF:FF:50:00:53:B6
[CHG] Device FF:FF:50:00:53:B6 Connected: yes
Connection successful
[CHG] Device FF:FF:50:00:53:B6 ServicesResolved: yes
[iTAG            ]#=
