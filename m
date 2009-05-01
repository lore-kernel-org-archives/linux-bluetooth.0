Return-Path: <cyrus@holtmann.org>
Message-ID: <49FB3C18.8030505@gmail.com>
Date: Fri, 01 May 2009 22:14:48 +0400
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: DeviceFound and DeviceDisappeared signals
References: <49FB0A07.2020200@gmail.com>
In-Reply-To: <49FB0A07.2020200@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I just would add that with hardware scheduler DeviceDisappeared signal 
works fine if there two remote devices in the field, and doesn't work if 
there is only one remote device:

---
# Now there only 00:16:B8:53:5F:17 is turned on
Fri May  1 20:36:48 2009 Signal: DeviceFound 00:16:B8:53:5F:17
# Now I turn off 00:16:B8:53:5F:17 and wait, but no signal being emitted...
# So, I turn on 00:02:76:16:F6:8F
Fri May  1 20:38:52 2009 Signal: DeviceFound 00:02:76:16:F6:8F
Fri May  1 20:39:01 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
# So new device appearing causes emitting DeviceDisappeared signal for 
device that was turned off some time ago
---

P.S. I use BlueZ 4.36

Ilya Rubtsov пишет:
> Hi! I have some troubles with using DeviceFound and DeviceDisappeared 
> signals. I use simple test script: http://pastebin.com/m45de7894 . 
> There are two cases: if I use software inquire scheduler and if I use 
> hardware one.
>
> Hardware scheduler. Bluetooth module in phone is on and I run script:
> ---
> ilya@ilya-laptop:~/blue$ python fodis.py
> Fri May  1 16:36:44 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> ---
> And no more signals. Then I wait 2 mins, turn off Bluetooth in phone 
> and wait 2 more mins, but no one signal is emitted.
> I don't know if DeviceFound signal should be emitted on every inquire, 
> maybe not. But I'm sure DeviceDisappeared signal should be emitted at 
> least once :)
>
>
> Software scheduler ("DiscoverSchedulerInterval = 1" at main.conf). 
> Bluetooth module in phone is on and I run script:
> ---
> ilya@ilya-laptop:~/blue$ python fodis.py
> Fri May  1 16:43:52 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> Fri May  1 16:44:11 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
> Fri May  1 16:44:14 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> Fri May  1 16:44:34 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
> Fri May  1 16:44:37 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> Fri May  1 16:44:57 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
> Fri May  1 16:45:00 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> Fri May  1 16:45:20 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
> Fri May  1 16:45:23 2009 Signal: DeviceFound 00:16:B8:53:5F:17
> ### At this moment I turn off Bluetooth in phone
> Fri May  1 16:45:43 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
> ---
>
> So, both signals was emitted on every inquiry. I think this is wrong 
> behavior. Am I right?
> And DeviceDisappeared was emitted once after remote device was 
> actually turned off. That's good :)

