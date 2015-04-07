Return-Path: <cyrus@holtmann.org>
Message-ID: <55240848.9000408@bitcircle.com>
Date: Tue, 07 Apr 2015 12:39:36 -0400
From: Jason Flanagan <jason@bitcircle.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothctl Segmentation Fault on confirm
References: <551D879B.7020409@bitcircle.com> <10129831.UNLGbbm0e3@leonov>
In-Reply-To: <10129831.UNLGbbm0e3@leonov>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry for the wait, I just heard back from my supervisor that the error 
only occurs when we cross compile with the uClibc library. 
(libuClibc-0.9.33.2)
The actual error message is

bluetoothctl[2545]: segfault at 0 ip b7564efd sp bff77324 error 4 in 
libuClibc-0.9.33.2.so[b753f000+4f000]

On 04/03/2015 06:51 AM, Szymon Janc wrote:
> Hi Jason,
>
> On Thursday 02 of April 2015 14:16:59 Jason Flanagan wrote:
>> The issue that i'm currently having with BlueZ 5.29 is that when i say
>> no to confirming a passkey i get a "Segmentation Fault". I've tried
>> multiple times on multiple devices and i get the same result.
>>
>> bluetoothctl
>> [bluetooth]#agent on
>> [bluetooth]#default-agent
>> [bluetooth]# pair XX:XX:XX:XX:XX:XX
>> Attempting to pair with XX:XX:XX:XX:XX:XX
>> [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
>> Request confirmation
>> [agent] Confirm passkey 080443 (yes/no): no
>> Segmentation fault
> I'm not able to reproduce this. Could you try running bluetoothctl under
> valgrind or gdb and provide full backtrace of crash?
>

