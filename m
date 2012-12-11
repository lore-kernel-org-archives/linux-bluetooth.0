Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: XIAN PAN <panxian1212@gmail.com>
Date: Tue, 11 Dec 2012 17:20:07 -0500
Message-ID: <CAEoLCeYAoFN_PXXBd=c40+722TJiNT4tgKJvaBpDL33TiOCc7g@mail.gmail.com>
Subject: Problem on setting up l2cap connection on different version of Bluez
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

My question is about the Bluetooth HID device simulation, for example,
let a computer working as a faked Bluetooth HID device. I study the
l2test.c file. My simulation program first finish hid service record
registration, and then calls l2cap_listen function (similar to the
do_listen function in l2test.c) to wait a connection request. If there
is a connection requirement, the simulation program calls the
l2cap_accept function to set up a connection.

My problem is: the simulation program only can work on Ubuntu 8.04
(kernel 2.6.24.29 and bluez 2.25). I try it on other OS such as Ubuntu
10.04, Fedora 13, Opensuse 11.1 (kernel 2.6x and bluez 4.8), none of
them can work. It looks like no l2cap requirement coming that my
program always wait for accepting l2cap requirement. That seems I miss
something in the program that it cannot work with the latest Bluez. In
fact, I search a lot on Internet and read other similar programs, such
as hidclient program
(http://anselm.hoffmeister.be/computer/hidclient/index.html.en) and
xkbdbthid (http://www.mulliner.org/bluetooth/xkbdbthid.php).
Unfortunately, those programs have the same problem as I meet: Only
can work on old Bluez. I really have not clue for this problem.

The simulation program first finish HID Mouse Service Record
registration, and then calls l2cap_listen function to wait a
connection. If there is a connection requirement, the simulation
program calls the l2cap_accept function. Those functions are taken
from bluez and bluez-utils. (for convenience, the simulation program
is in the attachment). If the simulation program runs on Ubuntu 10.04
or Fedora 13, it will wait there forever, even if another computer
already sends a connection requirement. It looks like that the
simulation program stops on l2cap_listen and never wakes up to call
the l2cap_accept function. What I miss in this process???

Thanks for your kind help.

Sincerely,
Xian
