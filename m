Return-Path: <cyrus@holtmann.org>
Message-ID: <4B9B815D.9030907@gmail.com>
Date: Sat, 13 Mar 2010 15:13:17 +0300
From: Alexander Markov <dortlih@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: builtin bluetooth dongle not in PSCAN mode at startup anymore, though
 it was in 4.42
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

i've installed Fedora 12 on my laptop recently (in addition to Fedora 
11) and have got a problem with my bluetooth mouse. it didnt want to 
connect AT STARTUP.

in F11 it works just fine. ive started researching the problem and found 
that in F11 hciconfig output is as follow:

hci0:   Type: USB
         BD Address: 00:0B:6B:90:0B:7C ACL MTU: 377:10 SCO MTU: 64:8
         UP RUNNING PSCAN
	...
	...

while in F12

hci0:   Type: USB
         BD Address: 00:0B:6B:90:0B:7C ACL MTU: 377:10 SCO MTU: 64:8
         UP RUNNING
	...
	...

So. it's the same laptop, the same builtin dongle.

but in F11 it is bluez-4.42, and in F12 it is bluez-4.58

Ive tried to install the last available bluez-4.62 at my F11, and got 
what was expected: hci0: UP RUNNING.   (no PSCAN)

Ive tried using bluetoothd binary from F11 on my F12 and again i got 
what expected:  hci0: UP RUNNING PSCAN.
I could not use it that way as it's difficult to downgrade to 4.42 on 
F12 and probably it's not the best way to solve problems :)

So, my question is can i overcome it by use of any conf files or can 
anybody fix this bug(?) ?

