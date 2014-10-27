Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1410161007340.1316-100000@iolanthe.rowland.org>
References: <CAG0bkv+bu23Fm_thq7A5AOrCEXaaWmcKNaX-193GqFh=W0S8xA@mail.gmail.com>
	<Pine.LNX.4.44L0.1410161007340.1316-100000@iolanthe.rowland.org>
Date: Mon, 27 Oct 2014 14:49:06 +0530
Message-ID: <CAG0bkvKd7w1acwQfBPknKmTJN0Xhj0PmPUw_kanBkMRcTsGXmg@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 16, 2014 at 7:39 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 16 Oct 2014, Naveen Kumar Parna wrote:
>
>> > Indeed. However, it is possible to use an additional in between your
>> > devices and the internal hub.
>> >
>> >         Regards
>> >                 Oliver
>> >
>> >
>>
>>
>> Tested with this configuration(external hubs Dev 3, Dev 4, Dev 17, Dev
>> 10) and got the same result.
>>
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>>
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M
>>
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>
>>         |__ Port 5: Dev 3, If 0, Class=hub, Driver=hub/7p, 12M
>>
>>             |__ Port 1: Dev 4, If 0, Class=hub, Driver=hub/7p, 12M
>
> This is not what Oliver meant.  You have to use a USB-2 hub.  And
> having one of them is enough; you don't need two.
>
> Alan Stern
>


As suggested, I connected USB-2 hub(Dev 87) in between my devices and
the internal hub. In this scenario also observed the STALL packets.

I am interested in understanding the objective of this test, can you
please help me?


[lowerlayers@banunxcas29 ~]$ lsusb -t

1-1.5.1:1.2: No such file or directory

1-1.5.3:1.2: No such file or directory

1-1.5.4:1.2: No such file or directory

/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M

    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M

        |__ Port 5: Dev 87, If 0, Class=hub, Driver=hub/4p, 480M

            |__ Port 1: Dev 88, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 1: Dev 88, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 1: Dev 88, If 2, Class=app., Driver=, 12M

            |__ Port 3: Dev 90, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 3: Dev 90, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 3: Dev 90, If 2, Class=app., Driver=, 12M

            |__ Port 4: Dev 89, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 4: Dev 89, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 4: Dev 89, If 2, Class=app., Driver=, 12M



[root@banunxcas29 ~]# cat /sys/kernel/debug/usb/usbmon/1u

ffff8800b2036540 2419900733 C Ii:1:090:1 -32:1 0

ffff8800b2036540 2419900753 S Ii:1:090:1 -115:1 16 <

ffff8800b2036540 963424773 C Ii:1:090:1 -32:1 0

ffff8800b2036540 963424792 S Ii:1:090:1 -115:1 16 <

ffff8800b2036540 963448864 C Ii:1:090:1 -32:1 0

ffff8800b2036540 963448880 S Ii:1:090:1 -115:1 16 <


/var/log/kernel

Oct 27 13:21:15 banunxcas29 kernel: [1017571.251514] hci2 urb
ffff8800b2036540 status -32 count 0

Oct 27 14:05:15 banunxcas29 kernel: [1020211.003086] hci2 urb
ffff8800b2036540 status -32 count 0

Oct 27 14:05:15 banunxcas29 kernel: [1020211.027178] hci2 urb
ffff8800b2036540 status -32 count 0


Thanks,
Naveen
