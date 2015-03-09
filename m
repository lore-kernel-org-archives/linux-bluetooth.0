Return-Path: <cyrus@holtmann.org>
Message-ID: <54FDD6E7.6050501@ubnt.com>
Date: Mon, 09 Mar 2015 19:22:47 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tim Tisdall <tisdall@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: bt dongle goes awry after too many connections
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com> <6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org> <CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com> <EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org> <CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com> <CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com> <54FDBBD2.10608@ubnt.com> <185295B8-ABD9-4EDF-B290-12C430CCA906@holtmann.org> <54FDCEBC.2050705@ubnt.com> <14B1E1BA-C93F-42BC-B2DD-0C8DBE6C68AA@holtmann.org>
In-Reply-To: <14B1E1BA-C93F-42BC-B2DD-0C8DBE6C68AA@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

On 2015.03.09. 19:10, Marcel Holtmann wrote:
> Hi Andrejs,
>
>>>>>> If you do not need BR/EDR, you can switch that off and it might free the radio resources you need for the many LE connections.
>>>>> Would someone please tell me how you do that?  I haven't seen this
>>>>> being done before.  Is it an HCI command?  ioctl command to the
>>>>> kernel?
>>>> ControllerMode = le
>>>> in /etc/bluetooth/main.conf
>>> which might at least need a 3.13.x kernel to actually work correctly. While the API is there, we have made significant fixes to the LE only mode in later kernels. Using a dual-mode controller in LE only mode actually needed some extra care.
>>>
>>> As I said, if it is not 3.18.x or 3.19.x kernel, then personally I would not bet on it. We have made sure that bug fixes are put into the -stable kernels for these release. Anything older has no guarantee anymore.
>> Sure, I noticed that lots of work has been done lately in regard to LE, so I'm indeed using 5.28 daemon@3.19.x kernel in LE-only mode and so far so good.
>> One of the useful things which still seems to be missing is the control over LE advertisements via D-Bus iface. "Discoverable" property change does not affect LE advs. I'm currently using 'hciconfig hci0 leadv' to make it work. But still, LE advs stop and do not re-start after adapter is connected/disconnected to some peripheral.
> you might want to try "btmgmt advertising on" instead. It will toggle the connectable and discoverable settings accordingly.
>
> You also really want the kernel take control over advertising. Otherwise you have to keep re-enabling after each connection. The controller will turn it off once a connection has been created. The kernel does take care of that for you if you use the mgmt interface.
Oh, thank you! It really works now as it should. For some reason, it 
didn't work for me when I tried it an hour ago :)
>
> Regards
>
> Marcel
>
