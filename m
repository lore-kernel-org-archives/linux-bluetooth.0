Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2014 15:51:40 +0000
Message-ID: <CALdY0K5NNrrWdY73e44kp+QNxF2dizEyU44ny9k5h1YFQDf21w@mail.gmail.com>
Subject: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I was trying to connect my Jawbone UP 24 with my pc to get some data from
this device.
This is how much I have done:

$ sudo hcitool  lescan
LE Scan ...
DC:7A:F8:10:AF:A5 (unknown)
DC:7A:F8:10:AF:A5 UP24
DC:7A:F8:10:AF:A5 (unknown)
DC:7A:F8:10:AF:A5 (unknown)

$ sudo hcitool lecc --random DC:7A:F8:10:AF:A5
Connection handle 70

 sudo gatttool -b DC:7A:F8:10:AF:A5 -I
[   ][DC:7A:F8:10:AF:A5][LE]> connect
[CON][DC:7A:F8:10:AF:A5][LE]>


After this I tried to type "primary" but I just get a timeout.
The device should vibrate to accept the pairing, there is in someway to set
a PIN when pairing?

Also I tried with my android, the procedure is the same:
- Scan for devices
- Find Jawbone
- Vibrate the device
- Press a button on the device
- The pairing is done


I suppose there is a special command to send, in the meantime I will try to
make a small app with Android to pair the device.
Anyway I would like to know how to use gatt to pair with my pc and I am
sure I am missing some steps :S

Thanks

-- 
---------------------------
Web/Mobile Developer
Luiis Group
christian@bianchini.ch
