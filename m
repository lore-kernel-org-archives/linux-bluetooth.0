Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2013 00:16:21 +0200
Message-ID: <CALN1cnt9UuSgEpcg47Rt9HooU+idURYHyeOd8905coOJV8qaZg@mail.gmail.com>
Subject: Use Bluez as peripheral
From: Elvis Angelaccio <angelaccioelvis@libero.it>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, this is my first post to this mailing list, sorry if I am in the
wrong place.
I'm learning Bluetooth Low Energy with a simple Android application. Since
the Android API implements only the "central" side of the BTLE stack, I
need to implement the "peripheral" side on my laptop (thinkpad edge e130,
bluetooth 4.0, linux 3.11).

As I understand, Bluez should support this feature (while Windows 8 and Max
OSX don't).
For now I'm able to "advertise" my laptop using the command "hciconfig hci0
leadv". My android app succeeds to find my laptop after a btleScan().
Of course actually there is no a GATT server and no "characteristics" to
read and write.

I really need some hints on how to create a GATT server using Bluez, so I
have some questions.

1. In my distro, I have by default Bluez 4.101. Should I compile Bluez 5?
2. If I have to use Bluez 5, should I learn how to program using DBus?
3. I I can use Bluez 4, what are the header files that I'm required to
include? (i.e. the function that I have to use?)


I know the C language, but I have no idea how to deal with kernel code as
Bluez seems to be, sorry if these are noob questions.

Thank you all in Advance,
Elvis
