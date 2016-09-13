Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHFy41-2omfTux6-3VPcv0nHBZEdDu0r0ap2UTrc2z=3c_dtCg@mail.gmail.com>
References: <CAG=hFhL+OiRiwXLU5_9Yc03v8vOYhkfakp26871LU_AZdB2fmQ@mail.gmail.com>
 <CABBYNZK7t6jRaT1rDoiY=foi+5g74pTYE6KbShYx=8sv+_PW9A@mail.gmail.com>
 <CAG=hFhLGo_0kmWR0oMUP7DMEFD+5QqA5+p5AwfGhPK=-ofmT=Q@mail.gmail.com> <CAHFy41-2omfTux6-3VPcv0nHBZEdDu0r0ap2UTrc2z=3c_dtCg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Sep 2016 12:58:00 +0300
Message-ID: <CABBYNZ+B0sMpfg5chgz4nBgF0K9sTdWhxjkM2M9CboqiiBjuOQ@mail.gmail.com>
Subject: Re: Issue: Bluez: Bluetooth Mouse Disconnects Soon After Pairing
To: Joseph Hwang <josephsih@google.com>
Cc: Naveen Kaje <nckaje@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 13, 2016 at 4:36 AM, Joseph Hwang <josephsih@google.com> wrote:
> This looks a bit weird to me. The disconnection reason in btmon log is 0x13:
>
> < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0]
> 98.788720
>         Handle: 1
>         Reason: Remote User Terminated Connection (0x13)
>
>
> Looking at src/adapter.c, the 0x13 indicates HCI_OE_USER_ENDED_CONNECTION
> which is sent in reply_pending_requests() which in turn is called by
> adapter_stop(). Why adapter_stop() is called?
>
> Joseph
>
>
> On Tue, Sep 13, 2016 at 12:15 AM, Naveen Kaje <nckaje@gmail.com> wrote:
>>
>> Hi Luiz,
>> Thanks for the input. I tried turning on agent (and various
>> combinations, such as NoInputNoOutput, default-agent and the exact
>> steps suggested by you.) I still see similar behavior. The behavior is
>> similar with Microsoft Disigner Keyboard (for keyboard, I tried with
>> agent KeyboardOnly and KeyboardDisplay).
>>
>> Bluetoothctl snippet below
>>
>> ************* begin *************
>> [bluetooth]# power on
>> Changing power on succeeded
>> [bluetooth]# agent on
>> Agent registered
>> [bluetooth]# default-agent
>> Default agent request successful
>> [bluetooth]# discoverable on
>> Changing discoverable on succeeded
>> [CHG] Controller 44:1C:A8:6C:8F:5E Discoverable: yes
>> [bluetooth]# pairable on
>> Changing pairable on succeeded
>> [bluetooth]# scan on
>> Discovery started
>> [CHG] Controller 44:1C:A8:6C:8F:5E Discovering: yes
>> [NEW] Device F5:95:EC:5E:0F:D3 Designer Mouse
>> [NEW] Device 74:9A:AA:38:11:48 74-9A-AA-38-11-48
>> [NEW] Device 70:97:AD:98:C7:30 70-97-AD-98-C7-30
>> [NEW] Device 49:5E:30:B2:A7:59 49-5E-30-B2-A7-59
>> [NEW] Device 6F:9A:D1:81:6C:A2 6F-9A-D1-81-6C-A2
>> [NEW] Device F3:26:FB:A7:7B:00 F3-26-FB-A7-7B-00
>> [bluetooth]# pair F5:95:EC:5E:0F:D3
>> Attempting to pair with F5:95:EC:5E:0F:D3
>> [CHG] Device F5:95:EC:5E:0F:D3 Connected: yes
>> [CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5E:0F:D3 UUIDs:
>> 00001812-0000-1000-8000-00805f9b34fb  <---  At this point, Bluetooth
>> Mouse Reports seen here and mouse can be used
>> [CHG] Device F5:95:EC:5E:0F:D3 Connected: no <--- At this point, Mouse
>> stops working, btmon shows disconnection
>> Failed to pair: org.bluez.Error.AuthenticationCanceled


With upstream the mouse is still working fine:

[bluetooth]# scan on
Discovery started
[CHG] Controller 7C:7A:91:18:82:46 Discovering: yes
[NEW] Device F3:F8:16:59:F6:74 Designer Mouse
[NEW] Device CB:43:A1:BF:48:16 Surge
[NEW] Device 77:39:0B:40:81:C4 77-39-0B-40-81-C4
[bluetooth]# scan off
[CHG] Device 77:39:0B:40:81:C4 RSSI is nil
[CHG] Device CB:43:A1:BF:48:16 RSSI is nil
[CHG] Device F3:F8:16:59:F6:74 RSSI is nil
Discovery stopped
[CHG] Controller 7C:7A:91:18:82:46 Discovering: no
[bluetooth]# pair F3:F8:16:59:F6:74
Attempting to pair with F3:F8:16:59:F6:74
[CHG] Device F3:F8:16:59:F6:74 Connected: yes
[CHG] Device F3:F8:16:59:F6:74 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device F3:F8:16:59:F6:74 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device F3:F8:16:59:F6:74 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device F3:F8:16:59:F6:74 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device F3:F8:16:59:F6:74 UUIDs: 00001812-0000-1000-8000-00805f9b34fb
[CHG] Device F3:F8:16:59:F6:74 ServicesResolved: yes
[CHG] Device F3:F8:16:59:F6:74 Paired: yes
[NEW] Primary Service
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service0008
Generic Attribute Profile
[NEW] Primary Service
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service0009
Device Information
[NEW] Characteristic
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service0009/char000a
Manufacturer Name String
[NEW] Characteristic
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service0009/char000c
PnP ID
[NEW] Primary Service
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service000e
Battery Service
[NEW] Characteristic
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service000e/char000f
Battery Level
[NEW] Descriptor
/org/bluez/hci0/dev_F3_F8_16_59_F6_74/service000e/char000f/desc0011
Client Characteristic Configuration
Pairing successful
[CHG] Device F3:F8:16:59:F6:74 Modalias: usb:v045Ep0805d0100


Btw, by upstream I mean a very recent kernel such as
4.6.5-300.fc24.x86_64 and latest BlueZ userspace.

-- 
Luiz Augusto von Dentz
