Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Problem with mpris-proxy
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <68c8200a-d99f-431c-8685-30b5b9e395c4@interia.pl>
 <CABBYNZKAHLb9ELQUyvfCdb70HdfbWDXMO201d9_4yebPvWDBLQ@mail.gmail.com>
From: =?UTF-8?Q?Rafa=c5=82_Bilski?= <rafalbilski@interia.pl>
Message-ID: <0e802acc-1fe8-da6c-4dea-110332b88d50@interia.pl>
Date: Sat, 26 May 2018 10:37:41 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKAHLb9ELQUyvfCdb70HdfbWDXMO201d9_4yebPvWDBLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Rafal,
>
> On Fri, May 25, 2018 at 7:31 PM, Rafał Bilski <rafalbilski@interia.pl> wrote:
>> Hello,
>>
>>      I've been trying to display track name on bluetooth device AND control a
>> player on computer using
>>
>> device's buttons.
>>
>>      I can have one, but not both.
>>
>>      If "mpris-proxy" isn't running I get key pressed/released event on
>> computer and I can control the player
>>
>> with buttons. Even if player doesn't have GUI it seems to get signals on
>> dbus mpris interface. BUT no metadata
> Do you have the mpris-player and bluetoothd logs?
Hi,

I do now. With debugging enabled information in log is much more useful.

Working (no "mpris-proxy"):
bluetoothd[5584]: profiles/audio/avctp.c:handle_panel_passthrough() AV/C: PAUSE pressed
bluetoothd[5584]: profiles/audio/avctp.c:handle_panel_passthrough() AV/C: PAUSE released

Not working ("mpris-proxy" running):
bluetoothd[5584]: profiles/audio/media.c:play()
dbus-daemon[274]: [system] Rejected send message, 1 matched rules; type="method_call", 
sender=":1.90" (uid=0 pid=5584 comm="//libexec/bluetooth/bluetoothd -d ") 
interface="org.mpris.MediaPlayer2.Player" member="Play" error name="(unset)" requested_reply="0" 
destination=":1.95" (uid=1000 pid=5684 comm="mpris-proxy ")
bluetoothd[5584]: profiles/audio/media.c:pause()
dbus-daemon[274]: [system] Rejected send message, 1 matched rules; type="method_call", 
sender=":1.90" (uid=0 pid=5584 comm="//libexec/bluetooth/bluetoothd -d ") 
interface="org.mpris.MediaPlayer2.Player" member="Pause" error name="(unset)" requested_reply="0" 
destination=":1.95" (uid=1000 pid=5684 comm="mpris-proxy ")

>
>> seems to be send to bluetooth device and there isn't anything on display.
>>
>>      When "mpris-proxy" is running player doesn't get any button events, BUT
>> I have all track information on
>>
>> a display.
> Perhaps with dbus-monitor if the message is not being rejected or something.
It looks like you are spot on.
I guess default dbus configuration in ArchLinux isn't good enough?
Could you point me in right direction?
>
>>      In both cases, with pulseaudio, "btmon" shows that device sends key
>> pressed/released events:
>>
>>> ACL Data RX: Handle 43 flags 0x02 dlen 12                  #1 [hci0]
>>> 6.185397
>>        Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>>          30 11 0e 00 48 7c 46 00 0...H|F.
>> < ACL Data TX: Handle 43 flags 0x00 dlen 12 #2 [hci0] 6.185506
>>        Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>>          32 11 0e 09 48 7c 46 00 2...H|F.
>>> ACL Data RX: Handle 43 flags 0x02 dlen 12 #3 [hci0] 6.189511
>>        Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>>          40 11 0e 00 48 7c c6 00 @...H|..
>> < ACL Data TX: Handle 43 flags 0x00 dlen 12 #4 [hci0] 6.189650
>>        Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>>          42 11 0e 09 48 7c c6 00 B...H|..
>>> HCI Event: Number of Completed Packets (0x13) plen 5 #5 [hci0] 6.191383
>>          Num handles: 1
>>          Handle: 43
>>          Count: 1
>>> HCI Event: Number of Completed Packets (0x13) plen 5 #6 [hci0] 6.193385
>>          Num handles: 1
>>          Handle: 43
>>          Count: 1
>>
>>      On bluealsa I only have sound. No keys or information on display.
>>
>> Is this issue related to pulseaudio?
>> Can I somehow take over uuid 0x110e using dbus and python and still have
>> sound?
>> I tried connecting to 0x110e L2CAP socket, but this only works if device is
>> disconnected and unable to produce sound.
>>
>> Please advise
>> Rafal Bilski
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

