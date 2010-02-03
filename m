Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 4 Feb 2010 00:08:08 +0300
Message-ID: <24cc6d3e1002031308p67049d3djfc8d729681123244@mail.gmail.com>
Subject: Problem with bluetooth headset IQUA BHS-333
From: =?KOI8-R?B?4czFy9PFyiDz1czJzg==?= <sulinalex@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello! My bluetooth headset IQUA BHS-333 work only on kernel 2.6.24.
On all newer
does not work. Tried last kernel from git blietooth-test, it also does not
work.

nilus@HoMe /usr/src/linux-2.6.24-gentoo-r8 $ cat .config | grep BT

 Log Here: http://paste.org.ru/?86qoqu


Now installed gentoo-kernel-2.6.31
net-wireless/bluez-4.39-r2
media-sound/pulseaudio-0.9.19

The headset is connected, I hear the hiss, but the sound is not heard.
Microphone does not work too.

# cat /usr/src/linux-2.6.31-gentoo-r6/.config | grep BT
Log here: http://paste.org.ru/?4d7k3k


$ sudo tailf /var/log/messages

Log here: http://paste.org.ru/?i62q0n

What other logs need to send?
