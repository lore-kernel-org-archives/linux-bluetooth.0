Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449991256.8150.3.camel@gmail.com>
References: <CA+RPYyX5b=QGdym1V0pFrU5kT_4HbTPeJF8piheUcp9MnOSYdQ@mail.gmail.com>
	<1449991256.8150.3.camel@gmail.com>
Date: Mon, 14 Dec 2015 16:50:07 +0100
Message-ID: <CA+RPYyX36po6s4ixErtboU8q=sSiMWvTJRF8E96GPYzxZf=XTw@mail.gmail.com>
Subject: Re: Lenovo keyboard
From: chris <inkbottle007@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Dec 13, 2015 at 8:20 AM, Berend De Schouwer
<berend.de.schouwer@gmail.com> wrote:
> On Sat, 2015-12-12 at 17:06 +0100, chris wrote:
>> Dear list,
>>
>> I've been consistently using a lenovo bluetooth keyboard since
>> Bluez4.
>> Since a recent (a month ago or so) upgrade (debian/stretch) it
>> doesn't
>> connect anymore.
>> Neither does a Jabra Stealth earpiece which was doing fine a month
>> ago.
>>
>> Even when it says conneced: yes, it isn't actually connected:
>> the led of the keyboard indicates it isn't connected and there is no
>> input.
>
> I've got similar symptoms with 4 different bluetooth keyboards.  One
> Logitech, one Apple, one Kanex and one Astrum.
>
> Pairing works, input fails.
>
> At the same time, the kernel loops:
> [ 1449.370904] Bluetooth: hci0 ACL packet for unknown connection handle
> 2
> [ 1455.734779] Bluetooth: hci0 ACL packet for unknown connection handle
> 3
> [ 1461.731976] Bluetooth: hci0 ACL packet for unknown connection handle
> 4
> [ 1468.037014] Bluetooth: hci0 ACL packet for unknown connection handle
> 5
> [ 1474.005517] Bluetooth: hci0 ACL packet for unknown connection handle
> 6
> [ 1479.972716] Bluetooth: hci0 ACL packet for unknown connection handle
> 7
> [ 1491.066637] Bluetooth: hci0 ACL packet for unknown connection handle
> 8
>
>
> Eventually a working handle is found.
>
> The Logitech is ancient, but the others are relatively new.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for the answer,

I also have the same sort of error when I do "dmesg". However I don't
know whether they are relevant or not.

Also the problem is not limited to keyboard only; here is a session
with a "Jabra STEALTH" earpiece:
# bluetoothctl -a
[NEW] Controller 9C:2A:70:82:50:FB pluto [default]
Agent registered
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# agent on
Agent is already registered
[bluetooth]# default-agent
Default agent request successful
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 9C:2A:70:82:50:FB Discovering: yes
[NEW] Device 50:C9:71:B5:42:2F Jabra STEALTH a1.15.0
[CHG] Device 50:C9:71:B5:42:2F RSSI: -71
[bluetooth]# pair 50:C9:71:B5:42:2F
Attempting to pair with 50:C9:71:B5:42:2F
[CHG] Device 50:C9:71:B5:42:2F Connected: yes
[CHG] Device 50:C9:71:B5:42:2F Paired: yes
Pairing successful
[CHG] Device 50:C9:71:B5:42:2F Connected: no
[CHG] Device 50:C9:71:B5:42:2F Connected: yes
[CHG] Device 50:C9:71:B5:42:2F Connected: no
[bluetooth]# trust 50:C9:71:B5:42:2F
[CHG] Device 50:C9:71:B5:42:2F Trusted: yes
Changing 50:C9:71:B5:42:2F trust succeeded
[bluetooth]# connect 50:C9:71:B5:42:2F
Attempting to connect to 50:C9:71:B5:42:2F
[CHG] Device 50:C9:71:B5:42:2F Connected: yes
[CHG] Device 50:C9:71:B5:42:2F Connected: no
[CHG] Device 50:C9:71:B5:42:2F Connected: yes
[Jabra STEALTH a1.15.0]# quit
Agent unregistered
[DEL] Controller 9C:2A:70:82:50:FB pluto [default]

Even though the earpiece "looks" connected, somehow, from the computer
side, sometime; when pressing the appropriate button on the earpiece,
it definitely says "you device is not connected".

Last point, as I already mentioned in the first mail, the computer did
somehow take the input from the keyboard at one moment; in the
following bit of the pairing session with the keyboard:
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
[agent] Passkey: 136021
Each line correspond to a keystroke from the (lenovo) bluetooth keyboard.

Hence, the controller is very much "aware" of the keyboard.

(here the "info" file created during the pairing attempt of the earpiece:
# cat /var/lib/bluetooth/9C\:2A\:70\:
82\:50\:FB/50\:C9\:71\:B5\:42\:2F/info
[General]
Name=Jabra STEALTH a1.15.0
Class=0x240404
SupportedTechnologies=BR/EDR;
Trusted=true
Blocked=false

[LinkKey]
Key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Type=4
PINLength=0
)

Chris
