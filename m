Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK7t6jRaT1rDoiY=foi+5g74pTYE6KbShYx=8sv+_PW9A@mail.gmail.com>
References: <CAG=hFhL+OiRiwXLU5_9Yc03v8vOYhkfakp26871LU_AZdB2fmQ@mail.gmail.com>
 <CABBYNZK7t6jRaT1rDoiY=foi+5g74pTYE6KbShYx=8sv+_PW9A@mail.gmail.com>
From: Naveen Kaje <nckaje@gmail.com>
Date: Mon, 12 Sep 2016 10:15:21 -0600
Message-ID: <CAG=hFhLGo_0kmWR0oMUP7DMEFD+5QqA5+p5AwfGhPK=-ofmT=Q@mail.gmail.com>
Subject: Re: Issue: Bluez: Bluetooth Mouse Disconnects Soon After Pairing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        me <nckaje@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
Thanks for the input. I tried turning on agent (and various
combinations, such as NoInputNoOutput, default-agent and the exact
steps suggested by you.) I still see similar behavior. The behavior is
similar with Microsoft Disigner Keyboard (for keyboard, I tried with
agent KeyboardOnly and KeyboardDisplay).

Bluetoothctl snippet below

************* begin *************
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# agent on
Agent registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# discoverable on
Changing discoverable on succeeded
[CHG] Controller 44:1C:A8:6C:8F:5E Discoverable: yes
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 44:1C:A8:6C:8F:5E Discovering: yes
[NEW] Device F5:95:EC:5E:0F:D3 Designer Mouse
[NEW] Device 74:9A:AA:38:11:48 74-9A-AA-38-11-48
[NEW] Device 70:97:AD:98:C7:30 70-97-AD-98-C7-30
[NEW] Device 49:5E:30:B2:A7:59 49-5E-30-B2-A7-59
[NEW] Device 6F:9A:D1:81:6C:A2 6F-9A-D1-81-6C-A2
[NEW] Device F3:26:FB:A7:7B:00 F3-26-FB-A7-7B-00
[bluetooth]# pair F5:95:EC:5E:0F:D3
Attempting to pair with F5:95:EC:5E:0F:D3
[CHG] Device F5:95:EC:5E:0F:D3 Connected: yes
[CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5E:0F:D3 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5E:0F:D3 UUIDs:
00001812-0000-1000-8000-00805f9b34fb  <---  At this point, Bluetooth
Mouse Reports seen here and mouse can be used
[CHG] Device F5:95:EC:5E:0F:D3 Connected: no <--- At this point, Mouse
stops working, btmon shows disconnection
Failed to pair: org.bluez.Error.AuthenticationCanceled
************ end *********************

It is encouraging that you were able to use the same device. Could you
please share which Kernel version and Bluez Version you used? I am on
Kernel 3.18 and Bluez 5.41.
Thanks in advance.
Naveen


On Sun, Sep 11, 2016 at 10:59 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Naveen,
>
> On Sun, Sep 11, 2016 at 6:06 AM, Naveen Kaje <nckaje@gmail.com> wrote:
>> Hello,
>> I am seeing a disconnection behavior with Bluetooth mouse (Microsoft
>> Desginer Mouse). Software Baseline 3.18 based kernel and Bluez 5.41.
>>
>> The device is discovered with bluetoothctl. The mouse pairs briefly (for
>> about 30 seconds) and then the host disconnects.
>> Bluetoothctl error reads Failed to pair:
>> org.bluez.Error.AuthenticationCanceled
>>
>> Observations:
>> 1) The time it takes for the mouse to stop working is about 30 seconds
>> since the pair command. This time is consistent.
>>
>> 2) The btmon report says Reason: Remote User Terminated Connection (0x13),
>> which I found to be not entirely true.
>> I hacked the transfport layer (UART) in Kernel to skip sending
>> disconnection message which resulted in the Mouse device
>> continuing to send reports even after this point (Observed on btmon).
>>
>> Bluetoothctl and btmon logs are shown below. What could I be missing?
>>
>> Thanks in advance for the help.
>>
>> ******************** Bluetoothctl log begin ****************************
>> [bluetooth]# show
>> Controller 44:1C:A8:6C:8F:5E
>>         Name: BTHost
>>         Alias: BTHost
>>         Class: 0x000000
>>         Powered: yes
>>         Discoverable: no
>>         Pairable: yes
>>         UUID: Generic Attribute Profile
>> (00001801-0000-1000-8000-00805f9b34fb)
>>         UUID: A/V Remote Control
>>  (0000110e-0000-1000-8000-00805f9b34fb)
>>         UUID: PnP Information
>> (00001200-0000-1000-8000-00805f9b34fb)
>>         UUID: Generic Access Profile
>>  (00001800-0000-1000-8000-00805f9b34fb)
>>         UUID: A/V Remote Control Target
>> (0000110c-0000-1000-8000-00805f9b34fb)
>>         Modalias: usb:v1D6Bp0246d0529
>> [bluetooth]# discoverable on
>> Changing discoverable on succeeded
>> [bluetooth]# pairable on
>> Changing pairable on succeeded
>> [bluetooth]# scan on
>> Discovery started
>> [CHG] Controller 44:1C:A8:6C:8F:5E Discovering: yes
>> [NEW] Device F5:95:EC:5D:0F:D3 Designer Mouse
>> [bluetooth]# pair F5:95:EC:5D:0F:D3
>> Attempting to pair with F5:95:EC:5D:0F:D3
>> [CHG] Device F5:95:EC:5D:0F:D3 Connected: yes
>> [CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001812-0000-1000-8000-00805f9b34fb
>> [CHG] Device F5:95:EC:5D:0F:D3 Modalias: usb:v045Ep0805d0110
>> [Designer Mouse]# info
>> Device F5:95:EC:5D:0F:D3
>>         Name: Designer Mouse
>>         Alias: Designer Mouse
>>         Appearance: 0x03c2
>>         Icon: input-mouse
>>         Paired: no
>>         Trusted: no
>>         Blocked: no
>>         Connected: yes
>>         LegacyPairing: no
>>         UUID: Generic Access Profile
>>  (00001800-0000-1000-8000-00805f9b34fb)
>>         UUID: Generic Attribute Profile
>> (00001801-0000-1000-8000-00805f9b34fb)
>>         UUID: Device Information
>>  (0000180a-0000-1000-8000-00805f9b34fb)
>>         UUID: Battery Service
>> (0000180f-0000-1000-8000-00805f9b34fb)
>>         UUID: Human Interface Device
>>  (00001812-0000-1000-8000-00805f9b34fb)
>>         Modalias: usb:v045Ep0805d0110
>>         RSSI: -91
>> Failed to pair: org.bluez.Error.AuthenticationCancele--
>
> It doesn't look like you have an agent registered which is probably
> why the authentication fails, try with:
>> agent on
>> default-agent
>
> iirc the same mouse used to just work with more recent kernel and
> latest userspace.
>
> Luiz Augusto von Dentz
