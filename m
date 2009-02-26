Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Feb 2009 12:59:45 +0100
Message-ID: <bc36f8ed0902260359t6a3fe2c0vc4baefd3c205cebf@mail.gmail.com>
Subject: Performance considerations
From: Mickael Chazaux <mickael.chazaux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am programming with bluez in C, transfering data from a linux PC to a
java application on a phone. All works fine. I have some performance
questions.

When I use L2CAP sockets, I get an average of 10% better bitrate on a
given pair PC/phone than with RFCOMM sockets. Also, changing the MTU
of the L2CAP socket has an impact on bitrate. An MTU of 672 on some
phones gives a average bitrate of 190kB/s, nearly 50% more than with
an MTU of 256 bytes.

Also, in noisy environements (with lots and lots of phones with
bluetooth enabled), there is a great decrease in performance (
an average of 50kB/s with a good phone).

What bitrate values can you achieve? Can I expect an amelioration, for
example on fine tuning the stack's parameters, to get the maximum
bitrate possible?

Regards,
Mickael
