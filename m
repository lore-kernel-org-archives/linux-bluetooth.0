Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date: Sat, 9 Sep 2017 21:34:14 +0300
Message-ID: <CADBWZmXfPxzOqXUES=UtcLBmf0NzWaBzvf+8SbXc1dBnMm6ucg@mail.gmail.com>
Subject: Is it a way to decrease the connection time of a bluetooth socket?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to write a C driver in order to pair with a Bluetooth
device on linux. I had as support "Bluetooth for Programmers" book by
Albert Huang and Larry Rudolph. Even though I am not able to pair in
less than 10 seconds.

1) Let's assume that searching part is no needed anymore, because I
already know the Bluetooth device address.

2) I am trying to open a RFCOMM socket type.
socket s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

3) I am setting the rc_family, rc_channel and rc_baddr properly

4) In the end I am trying to start the connection
connect(s, (struct sockaddr *) &addr, sizeof(addr));

Connection is successful, but only the connect call is taking between
6 and 10 seconds. Is it a way to lower this time a bit? I tried also
the l2cap connection, different type of sockets (RAW socket, UDP
socket etc.) but without success (l2cap approach is slightly faster,
but also around 6-8 seconds).

Any help would be more than appreciated.

Thank you very much and waiting your response with interest.

Cristian-Stefan Neacsu
