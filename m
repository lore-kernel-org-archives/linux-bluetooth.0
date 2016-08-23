Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BLE Hexiwear connection fail
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOsEZogZpPu7NBgVnp=eamwMp-jn8_9hTuK9PEua=2Pme9v5Eg@mail.gmail.com>
Date: Tue, 23 Aug 2016 07:53:56 -0400
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <78FD0E95-1E02-4EDC-874D-AFD0AC0511E5@holtmann.org>
References: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com> <8CD08159-2E3B-4663-9C49-56131BB77AFA@holtmann.org> <CABBYNZ+cLHkDYH+L78oAr1P6Uua_TrbA02DE_tE0LoNq7wv=7A@mail.gmail.com> <CAOsEZogZpPu7NBgVnp=eamwMp-jn8_9hTuK9PEua=2Pme9v5Eg@mail.gmail.com>
To: Jay Aurabind <jay.aurabind@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

>>>> I have the IoT device Hexiwear[1], which connects through BLE. They
>>>> have an android app which can take data from it. I want to use from my
>>>> linux machine. Its BLE API is provided at their github[2] page.
>>> 
>>> does it work on Android? If so, then enable Bluetooth HCI tracing/logging in Android and send around the /sdcard/btsnoop_hci.log file. You can read that wit btmon by yourself and compare.
>>> 
>>> I would also propose you start using btmon instead of hcidump.
>> 
> 
> 
> I took the btsnoop log from Android while the device is being paired.
> To my surprise btmon crashes as I scroll down. The file is attached.
> The crash is probably a different discussion,  but given below is the
> backtrace. Can you please check if the same file crashes your btmon as
> well?
> 
> #0  0x00007ffff7a4b6f5 in raise () from /lib64/libc.so.6
> #1  0x00007ffff7a4d2fa in abort () from /lib64/libc.so.6
> #2  0x00007ffff7a8c670 in __libc_message () from /lib64/libc.so.6
> #3  0x00007ffff7b2bc57 in __fortify_fail () from /lib64/libc.so.6
> #4  0x00007ffff7b29d80 in __chk_fail () from /lib64/libc.so.6
> #5  0x00007ffff7b29339 in _IO_str_chk_overflow () from /lib64/libc.so.6
> #6  0x00007ffff7a905a0 in __GI__IO_default_xsputn () from /lib64/libc.so.6
> #7  0x00007ffff7a635ac in vfprintf () from /lib64/libc.so.6
> #8  0x00007ffff7b293cc in __vsprintf_chk () from /lib64/libc.so.6
> #9  0x00007ffff7b2931d in __sprintf_chk () from /lib64/libc.so.6
> #10 0x000055555558a533 in print_uuid ()
> #11 0x0000555555588352 in att_packet ()
> #12 0x00005555555888f3 in l2cap_frame ()
> #13 0x000055555557f517 in packet_hci_acldata ()
> #14 0x000055555557fae7 in packet_monitor ()
> #15 0x000055555556a1c6 in control_reader ()
> #16 0x00005555555670bc in main ()

it does not crash for me with the latest btmon from git. So maybe that is already fixed. If not, then lets us know and we have to figure out what is crashing here.

So the trace is funny. It seems that Android tries to connect to the LE device over and over again. And on the 3rd attempt it gets through. However I see nothing different in Android. Minus the fact that Bluedroid is not even keeping track of Disconnect Events and sending packets anyway. That stack really has no clue what state it is in :(

Can you just keep trying to connect and see if it eventually succeeds. If so, then please tell the manufacturer of that device to fix their BLE stack on the peripheral. Since there is little we can do to make this more reliable.

Regards

Marcel

