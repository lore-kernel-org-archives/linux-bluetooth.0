Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2015 08:53:38 +1000
Message-ID: <CAPcThSGd9RO=8aK0ALkyWzSa7zLpr=8o7qMpT5sNex=LWu_XtQ@mail.gmail.com>
Subject: How to write a C program to be paired asynchronously?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluetooth community,

I am a rookie to bluez internals. After "fixing" a potential defect in
one of blueman's script
(http://ubuntuforums.org/showthread.php?t=2286664) I can pair the HCI
adapter on my laptop from my mobile phone.

Now I would like to come up with a C program for the same purpose, it
will manipulate the dbus APIs to capture the messages emitted from
bluetoothd when receiving async pairing request and consult the end
user whether to accept it.

I can use dbus-monitor --system "sender='org.bluez'" command to
monitor all potential messages sent from bluetoothd during this
process, however, they all seem to be the PropertyChanged signal when
populating the newly created object /org/bluez/<pid>/hciX/dev_xx with
new properties. I am still clueless about relevant method_calls
blueman may have captured for pairing purpose, and am wondering if I
can do something similar for the same purpose but in C directly.

Any suggestions or comments or references to bluez's work flow during
pairing process would be highly appreciated.

Thanks!

Harry
