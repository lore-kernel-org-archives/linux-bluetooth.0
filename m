Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Himanshu Gusain <himanshu.gusain1989@gmail.com>
Date: Sat, 26 May 2018 13:08:29 -0500
Message-ID: <CAE8=ow2C5U0jvEqPgeyx94fEF1vdJ913toMdUynBU4Xk2X7rgQ@mail.gmail.com>
Subject: Unable to assign ip address to bnep interface
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All

I am facing  some trouble while setting up Bluetooth
PAN communication between our reference board (which act as Server)
& Ubuntu system (which act as Client )

Below is the error I am getting when setting IP in Server,

        ifconfig bnep0 10.0.0.2 netmask 255.255.255.0 up
       //ifconfig: SIOCSIFFLAGS: Cannot assign requested address

Although i am able to successfully set IP on the client system

I can see the bnep session is running on the Server


       1292 root     hciattach /dev/ttyPS1 any 115200

       1334 root     bluetoothd -d

       1389 root     pand --listen --role NAP --persist

       1451 root     pand --listen --role NAP --persist

       1455 root    [kbnepd bnep0]



Below is the ifconfig command ouput
what it looks the Server is not transmiiting any packets

# ifconfig -a

bnep0     Link encap:Ethernet  HWaddr 43:39:00:07:1F:AC

          inet addr:10.0.0.2  Bcast:10.255.255.255  Mask:255.0.0.0

          BROADCAST MULTICAST  MTU:1500  Metric:1

          RX packets:15 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:1000

          RX bytes:963 (963.0 B)  TX bytes:0 (0.0 B)


After enabling the debug logs i can see bnep_rx_frame getting
called whenever I ping from Client side,but don't see any bnep_tx_frame logs

Not sure what is blocking the tx from server

Thanks
Himanshu
