Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2009 10:53:18 +0530
Message-ID: <6887eb5d0902092123p2aa3f31chbd00bfc713b313dc@mail.gmail.com>
Subject: Problem in Pairing
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

I m using Bluez-4.27 to implement my bluetooth module which will
detect nearby bluetooth enabled device & connects with its Audio
Gateway.

Now when I attempt to connect Audio Gateway channel through my test
module it prompts me to Pair with "Bluez" on the remote device.

When I accept the same it prompts me to enter "Pass Code" to pair.

I did not ask for such passcodes in my test application...even in my
mobile phone I have not such type of setup to request for passcode.

This problem arise when I attempt to connect on the rfcomm socket
which is bind to local bluetooth adapter.

if somebody has also faced this type of problem, kindly reply me how
to solve this issue.
--
Kartikey Parmar
President AAECC
09879095390 (M)
