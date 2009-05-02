Return-Path: <cyrus@holtmann.org>
Message-ID: <49FCD7E7.9020105@gmail.com>
Date: Sun, 03 May 2009 03:31:51 +0400
From: Ilya Rubtsov <lusyaru@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: DeviceFound and DeviceDisappeared signals
References: <49FB0A07.2020200@gmail.com> <49FB3C18.8030505@gmail.com> <2d5a2c100905021520i374024a2u565626e4c7f00b87@mail.gmail.com>
In-Reply-To: <2d5a2c100905021520i374024a2u565626e4c7f00b87@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Luiz Augusto von Dentz пишет:
> Hi,
>
> On Fri, May 1, 2009 at 3:14 PM, Ilya Rubtsov <lusyaru@gmail.com> wrote:
>   
>> I just would add that with hardware scheduler DeviceDisappeared signal works
>> fine if there two remote devices in the field, and doesn't work if there is
>> only one remote device:
>>
>> ---
>> # Now there only 00:16:B8:53:5F:17 is turned on
>> Fri May  1 20:36:48 2009 Signal: DeviceFound 00:16:B8:53:5F:17
>> # Now I turn off 00:16:B8:53:5F:17 and wait, but no signal being emitted...
>> # So, I turn on 00:02:76:16:F6:8F
>> Fri May  1 20:38:52 2009 Signal: DeviceFound 00:02:76:16:F6:8F
>> Fri May  1 20:39:01 2009 Signal: DeviceDisappeared 00:16:B8:53:5F:17
>>     
>
> You may just have to wait longer to get the DeviceDisappeared signal
> the fact the you turned off the device doesn't mean it will instantly
> disappear it may happen that bluetoothd is idle waiting for scheduler
> to start another discovery round (use Discovering property to check
> that.). I will double check if there is some logic problem while
> emitting DeviceDisappeared but I remember fixing it myself last time
> and have no complaining since then.
>
>   
I connected to PropertyChanged signal:

# device (bluetooth module in phone) is turned on. I run script
Sun May 3 02:55:00 2009 Signal: PropertyChanged Discovering 1
Sun May 3 02:55:03 2009 Signal: DeviceFound 00:16:B8:53:5F:17 kkk -45
Sun May 3 02:55:10 2009 Signal: PropertyChanged Discovering 0
Sun May 3 02:55:21 2009 Signal: PropertyChanged Discovering 1
Sun May 3 02:55:31 2009 Signal: PropertyChanged Discovering 0
Sun May 3 02:55:50 2009 Signal: PropertyChanged Discovering 1
Sun May 3 02:56:00 2009 Signal: PropertyChanged Discovering 0
# turn device off
# And then no signal. At all. You even may go and drink cup of coffee or 
smth :) There won't be any signal. But LED on my dongle indicates mode 
changing: waiting (blinking), inquiry (permanent light), waiting, inquiry...
# turn device on
Sun May 3 02:59:39 2009 Signal: PropertyChanged Discovering 0
Sun May 3 02:59:55 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:00:05 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:00:23 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:00:30 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:00:46 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:00:54 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:01:08 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:01:15 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:01:31 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:01:38 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:01:49 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:01:59 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:02:22 2009 Signal: PropertyChanged Discovering 1
Sun May 3 03:02:30 2009 Signal: PropertyChanged Discovering 0
Sun May 3 03:02:44 2009 Signal: PropertyChanged Discovering 1
# turn device off
Sun May 3 03:02:51 2009 Signal: PropertyChanged Discovering 0
# and then silent...


BlueZ 4.36
Script source: http://pastebin.com/m26afe2e2
Hardware scheduler

