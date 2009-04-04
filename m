Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 4 Apr 2009 09:38:35 +0530
Message-ID: <6887eb5d0904032108k73484ee9p7b872bf0c492f0ed@mail.gmail.com>
Subject: bluez PIN generation in non-gui based application
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi
I m working on bluez-4.30 which will be compiled for cross platform ARM.

On ARM simple linux will be installed which will not have GUI based
application except QT - that we are going to use for touch screen and
graphical LCD.

I have downloaded bluez-gnome-1.8 from www.bluez.org along with bluez-4.30.
This bluez-gnome help to pair devices by generating passkey.

While cross compiling bluez-gnome-1.8, I found that it is dependent on
GTK+ and GTK+ is dependent on ATK, PANGO, CAIRO.
Is it possible to run bluez-gnome-1.8 application on simple linux that
doesn't support GUI? or is there any other application available which
can be used to generate linkkey from fixed PIN given? (In my case PIN
will be fixed as our product will be pairing bluetooth headset with
our DKP.)

Awaiting for reply...
Regards
-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
