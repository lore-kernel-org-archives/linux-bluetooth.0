Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 2 Jul 2015 14:22:14 -0500
Message-ID: <CABKPALrTMqgvxRgu7TmUw+1MrTCL10FAGGzyphb1oAAyFGOBNQ@mail.gmail.com>
Subject: Trying to run example-advertisement
From: Neil Martin <neil@vnp.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I was having trouble using the advertising api in my own code, so
decided to run the example-advertisement python test to rule out
errors in my code.  This doesn't work either - I get the following
error message:

LEAdvertisingManager1 interface not found

I know the advertising api is experimental.  My bluez was built with
--enable-experimental  and I'm running bluetoothd with the -E flag.
It seems like this is an environment issue, but I don't find any
suggestions when I try googling for help.  Is there anything obvious
that I'm missing?

Neil
