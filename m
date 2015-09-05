Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Nazmul Alam <fadedreamz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: DBus WriteValue is failing for bluez 5.31 with kernel 4.1+
Date: Sat, 05 Sep 2015 19:58:17 +0200
Message-ID: <9183639.i2tkjIN3Um@ix>
In-Reply-To: <CACjvaw=OrVRqQG37j6gh7Pap7sksqonNhauBrHxTK720T-Uk-g@mail.gmail.com>
References: <CACjvaw=OrVRqQG37j6gh7Pap7sksqonNhauBrHxTK720T-Uk-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 04 September 2015 18:05:56 Nazmul Alam wrote:
> Hello,
> I am unable to write to atrribute value to a characteristics exposed
> via dbus on the new 4.1 kernel.
> 
> Before upgrading to kernel 4.1 the same application can write
> attribute value to the characteristics via dbus without any issue.
> 
> Following is the log collected from bluetoothd -
> 
> org.freedesktop.DBus.Error.AccessDenied: Rejected send message, 1
> matched rules; type="method_call", sender=":1.24" (uid=0 pid=4112
> comm="bluez-5.31/src/bluetoothd -ndE ")
> interface="org.bluez.GattCharacteristic1" member="WriteValue" error
> name="(unset)" requested_reply="0" destination=":1.25" (uid=0 pid=4114
> comm="./test ")
> 
> Any suggestions?
> Thanks in advance.

This error doesn't seem to be related to kernel change but to outdated 
bluetoothd D-Bus policy file. (src/bluetooth.conf)

-- 
pozdrawiam
Szymon Janc
