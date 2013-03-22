Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 22 Mar 2013 16:00:01 +0900
Message-ID: <CAHLX0ue__CbJ2hYGe7V6mYVJPiqUktkKH=tvAYRBw=E+g1jZCg@mail.gmail.com>
Subject: The way of using several usb bluetooth dongles to support more
 bluetooth devices
From: Chang Chao <charleschung.cn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,bluez developers.

I use usb bluetooth dongle to connect to other bluetooth device using
rfcomm(with bluez-4.66).
as one usb dongle can support 7 devices at most,to support 8 devices 2
usb dongles(hci0 and hci1) is used.

hci0:rfcomm0,rfcomm1,...,rfcomm6
hci1:rfcomm7

#more contents of /etc/bluetooth/rfcomm_hci0.conf
     rfcomm0 {
         bind yes;
         device BD ADDRESS;
     }

     rfcomm1 {
         bind yes;
         device BD ADDRESS;
     }
     ...
     rfcomm6 {
         bind yes;
         device BD ADDRESS;
     }

#more /etc/bluetooth/rfcomm_hci1.conf
     rfcomm7 {
         bind yes;
         device BD ADDRESS;
     }

I'v tried to acheive this with 2 methods.

Method1(the simple one,which I wonder why it failed):
#rfcomm -i hci0 -f /etc/bluetooth/rfcomm_hci0.conf  bind all
#rfcomm -i hci1 -f /etc/bluetooth/rfcomm_hci1.conf  bind all
when I connect to the serial ports using minicom,only six of them can
connect simultaneously.
the seventh connecting attemp always gives a "Too many links" error and failed.

Method2
#rfcomm -i hci0 -f /etc/bluetooth/rfcomm_hci0.conf connect rfcomm0 &
#rfcomm -i hci0 -f /etc/bluetooth/rfcomm_hci0.conf connect rfcomm1 &
#...
#rfcomm -i hci0 -f /etc/bluetooth/rfcomm_hci0.conf connect rfcomm6 &

#rfcomm -i hci1 -f /etc/bluetooth/rfcomm_hci1.conf connect rfcomm7 &
This method works well(minicom can connect to 7 serial ports simultaneously)

Method1 is simple,but it failed,Would anyone please explain why did it fail?
And what is the recommended method to acheive what I want to do
(several usb dongles to support more bluetooth devices).
