Return-Path: <cyrus@holtmann.org>
Message-ID: <5098D41F.4080902@rug.nl>
Date: Tue, 06 Nov 2012 10:10:55 +0100
From: Sietse Achterop <s.achterop@rug.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Multiple adapters do not work
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

     Dear list,

I am trying to use multiple adapters to	control	multiple bluetooth devices.
But it doesn't work. I already mailed it to this list but got no replay.
I know that normally this isn't	the way	to do this, but I am trying to avoid another
problem.

I bind 4 devices to 4 adapters as follows:

  rfcomm -i hci0 bind rfcomm1 10:00:E8:6C:D8:14 1
  rfcomm -i hci1 bind rfcomm2 10:00:E8:6C:D8:1D 1
  rfcomm -i hci2 bind rfcomm3 10:00:E8:6C:EC:98 1
  rfcomm -i hci3 bind rfcomm4 10:00:E8:6C:D7:D9 1

But, using minicom, I can only connect to the first device,
the others give	either
   cannot open /dev/rfcomm3: Connection refused
or
   cannot open /dev/rfcomm4: No such file or directory

All devices are available:
  crw-rw---- 1 root dialout 216, 1 Nov  6 09:49 /dev/rfcomm1
  crw-rw---- 1 root dialout 216, 2 Nov  6 09:46 /dev/rfcomm2
  crw-rw---- 1 root dialout 216, 3 Nov  6 09:46 /dev/rfcomm3
  crw-rw---- 1 root dialout 216, 4 Nov  6 09:46 /dev/rfcomm4

What am I doing wrong?
 (Using	Ubuntu 12.04 with bluez-4.101 install from source.)

   Regards,
     Sietse


PS On a side note: I think there is a bug in the rfcomm manual page.

   I don't understand the desciption of	the -i parameter, but it is the	same for years,	The desciption looks mangled.
     -i <hciX> | <bdaddr>
              The command is applied to device -A Enable authentication.  -E Enable encryption.  -S Secure connection.  -M Become the master of a piconet.  hciX , which must be the
name or
              the address of an installed Bluetooth device. If not specified, the command will be use the first available Bluetooth device.
   The mentioning of -A	to -M should be	removed	I guess.
