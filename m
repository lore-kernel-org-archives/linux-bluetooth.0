Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Jay Aurabind <jay.aurabind@gmail.com>
Date: Fri, 19 Aug 2016 19:36:10 +0530
Message-ID: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com>
Subject: BLE Hexiwear connection fail
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have the IoT device Hexiwear[1], which connects through BLE. They
have an android app which can take data from it. I want to use from my
linux machine. Its BLE API is provided at their github[2] page.

I tried connecting to it, but fails with an error no implemented:

[root@fedaura-envy jayaura]# gatttool -b 00:20:40:0B:00:24 -I
[00:20:40:0B:00:24][LE]> connect
Attempting to connect to 00:20:40:0B:00:24
Error: connect error: Function not implemented (38)
[00:20:40:0B:00:24][LE]>


I have the log[3] while this is happening. Does the above error mean
that connect is not implemented in my device? That is highly unlikely
as I can read data through the Android app.

Please provide some recommendations to get some data out of this
device through bluez




[1]:http://www.hexiwear.com/
[2]:https://github.com/MikroElektronika/HEXIWEAR/blob/master/documentation/HEXIWEAR%20Bluetooth%20Specifications.pdf
[3]:https://paste.gnome.org/pcdgqjf9r

-- 

Thanks and Regards,
Aurabindo J
