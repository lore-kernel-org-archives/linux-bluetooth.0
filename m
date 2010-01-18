Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 18 Jan 2010 15:35:06 +0530
Message-ID: <912bb79a1001180205y18dee28dj628d0187f90e4ceb@mail.gmail.com>
Subject: Unable to get AT+CKPD=200 (key press command )
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am connection HS by using "Connect" DBUS API of headset interface, I
am able to connect with device, but when I press key single time on HS
it's not showing AT+CKPD=200 (I kept debugg in source).

But when I press HS key two times it show me,

bluetoothd[815]: Received AT+BLDN
bluetoothd[815]: Telephone indicator "callsetup" 0 -> 2
bluetoothd[815]: Telephone indicator "callsetup" 2 -> 3

and then when I press HS key single time it show following,

bluetoothd[815]: Received AT+CHUP
bluetoothd[815]: Telephone indicator "callsetup" 3 -> 0
bluetoothd[815]: Received AT+BTRH?

But I am not able to get AT+CKPD=200, It would be really appreciable
if somebody guide/suggest me what should I do to get AT+CKPD=200 when
connected through API "Connect" on DBUS.

-- 
With Regards,
Nirav Rabara
