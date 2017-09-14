Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date: Thu, 14 Sep 2017 12:36:08 +0300
Message-ID: <CADBWZmW2UuWGa_fbiYfbsnBGqJdgXftbDVzHtjLium_y3WzySA@mail.gmail.com>
Subject: RFCOMM socket connection is taking a bit too much time
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I would kindly ask you for your support. For some days in a row, I am
struggling to reduce as much as possible the connection to a bluetooth
device, without any success. Assuming that the address of the device
is known and stable, as well as the device in available.
Opening a socket only [socket(PF_BLUETOOTH, SOCK_STREAM,
BTPROTO_RFCOMM)] is taking a constant time of 5017 ms on my system
(every run is 5017 with a variation of maximum 2 ms - highly suspect
that there is a timeout or so, but I was not able to debug to deep). I
am using Ubuntu 16.04 and BlueZ 5.46 library.
I tried all kind of attempts, nonblocking socket, different socket
types, without any success. I tried as well the default rfcomm tool
from the blueZ package, scanning the implementation, trying same
approach, I really cannot decrease this connection time. Are there any
timeout that I could modify, or so?
Mainly my code is inspired from "Bluetooth for Programmers" book,
chapter being presented here
https://people.csail.mit.edu/albert/bluez-intro/x502.html .
I doubt that is something wrong with my hardware configuration
(adapter, device, PC etc.) due to the fact that on windows OS, using
BlueCove java library, connection to the device is below 2 seconds
(same conditions - address of the device is already known & the device
is ready to connect).
Again I tried as well BlueCove-Bluez linux library (I know it is old,
and is a pain in the neck to make it work ...) and still the same
issue (BlueCove-gpl as well with the same long timeout).
Maybe I am doing something wrong. I would really appreciate a
suggestion or a direction how I can achieve a better connection time.

Thank you in advance.

Kindly regards,
Cristian-Stefan Neacsu
