Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?Q?Rafa=c5=82_Bilski?= <rafalbilski@interia.pl>
Subject: Problem with mpris-proxy
To: linux-bluetooth@vger.kernel.org
Message-ID: <68c8200a-d99f-431c-8685-30b5b9e395c4@interia.pl>
Date: Fri, 25 May 2018 17:31:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

     I've been trying to display track name on bluetooth device AND control a player on computer using

device's buttons.

     I can have one, but not both.

     If "mpris-proxy" isn't running I get key pressed/released event on computer and I can control 
the player

with buttons. Even if player doesn't have GUI it seems to get signals on dbus mpris interface. BUT 
no metadata

seems to be send to bluetooth device and there isn't anything on display.

     When "mpris-proxy" is running player doesn't get any button events, BUT I have all track 
information on

a display.

     In both cases, with pulseaudio, "btmon" shows that device sends key pressed/released events:

 > ACL Data RX: Handle 43 flags 0x02 dlen 12                  #1 [hci0] 6.185397
       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
         30 11 0e 00 48 7c 46 00 0...H|F.
< ACL Data TX: Handle 43 flags 0x00 dlen 12 #2 [hci0] 6.185506
       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
         32 11 0e 09 48 7c 46 00 2...H|F.
 > ACL Data RX: Handle 43 flags 0x02 dlen 12 #3 [hci0] 6.189511
       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
         40 11 0e 00 48 7c c6 00 @...H|..
< ACL Data TX: Handle 43 flags 0x00 dlen 12 #4 [hci0] 6.189650
       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
         42 11 0e 09 48 7c c6 00 B...H|..
 > HCI Event: Number of Completed Packets (0x13) plen 5 #5 [hci0] 6.191383
         Num handles: 1
         Handle: 43
         Count: 1
 > HCI Event: Number of Completed Packets (0x13) plen 5 #6 [hci0] 6.193385
         Num handles: 1
         Handle: 43
         Count: 1

     On bluealsa I only have sound. No keys or information on display.

Is this issue related to pulseaudio?
Can I somehow take over uuid 0x110e using dbus and python and still have sound?
I tried connecting to 0x110e L2CAP socket, but this only works if device is disconnected and unable 
to produce sound.

Please advise
Rafal Bilski

