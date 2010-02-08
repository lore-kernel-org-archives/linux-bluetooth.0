Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 8 Feb 2010 23:04:23 +0530
Message-ID: <912bb79a1002080934r5cab2823kded04a942cd4a993@mail.gmail.com>
Subject: Unable to get device name while discovery
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Most of the time I am unable to get device name while discovering for
new device.

I am using Dbus API to discover new devices, I am able to get the
signal DeviceFound() , using this signal I am able to get device
addresses, paired or not, connected or not, but some times its not
showing the name of the device.

Can anybody suggest me what should i do to get device name while
searching for the new devices.

( If the file names available at /var/lib/run/bluetooth/... then it's
shows device name , as per my understanding while searching its trying
to get device name from this "names " file , but if the file is not
available it won't show the device name.  If the bluetooth dongle is
connection at first time then no "names" file will be available , so
how to get device name? )


-- 
With Regards,
Nirav Rabara
