Return-Path: <cyrus@holtmann.org>
Message-ID: <506D8DC2.7010506@rug.nl>
Date: Thu, 04 Oct 2012 15:23:14 +0200
From: Sietse Achterop <s.achterop@rug.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Using multiple adapters do not work
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Dear list,

I want to use a number, say 2, of local bluetooth adapters that each communicate with a single
different bluetooth device. The	devices	appear as rfcomm devices.
We can communicate with the devices using minicom.

Binding of the 2 adapters in linux:
   rfcomm -i hci0 bind /dev/rfcomm1 10:00:E8:6C:D8:14 1
   rfcomm -i hci1 bind /dev/rfcomm7 10:00:E8:6C:EC:9E 1
I test with starting minicom for each rfcomm device.
The first minicom invocation works perfectly, but the second (and third ...) gets an error:
  minicom: cannot open /dev/rfcomm7: No such file or directory
or sometimes: Permission denied.
  (the device exists and is said to be readable by ls -l)
This on 2 machines with up to date kernels  2.6.32-43-generic and  3.2.0-31-generic (ubuntu)

Using only a single adapter in the usual way, using rfcomm.conf, it works perfectly.
That is the way in which the pairing has been done before doing the above tests.

I assumed that the above would work.
What am I doing wrong?


Again, if this is the wrong list, please tell me.

  Regards,
    Sietse


PS I am using this approach because of problems as described on this list on
   October 2-nd in:
    Unreliable communication with multiple bluetooth devices and some delay.

