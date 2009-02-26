Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2009 15:40:48 +0530
Message-ID: <6887eb5d0902260210q100eca7bnfea66422ec61e58d@mail.gmail.com>
Subject: Query: using obexftp application with no pin
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi

Is it possible to send file using obexFTP by just accepting the
request to receive at the far end?

Just like it is possible to send ringtone / .jpg file from 1 bluetooth
enable mobile to another bluetooth enable mobile by just discovering
it and sending the selected file to it.
At the destination end user just needs to click on yes to accept data
from remote device.

In that case pairing is not required, that means neither side it
prompts to enter pin and on successful completion of the operation the
received file will be there in Received Files folder on the
destination bluetooth enable mobile phone.

I have written an file transfer application using openObex and obexFTP
functions which performs similar function.

In my application I did prompt user for any type of PIN / passkey,
still when my application attempts to connect with remote device it
prompt to enter PIN on the remote device and on successful submission
of PIN, bluez-gnome utility prompts me to enter PIN.

If both PIN are matches, it creates bonding and then I can have file
transfer between these two.

Is it possible to disable this PIN request and connection without any
PIN / linkkey? i.e. is it possible to exchange files withough bonding?

I m using openObex-1.5, obexFTP-0.23 and bluez-4.30 on Fedora 9

Awaiting for reply...

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
