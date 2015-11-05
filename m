Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ6-jQh-yF6Pg6vhYJ4D_oH1t61B=809nU_RgU0AS-s1g@mail.gmail.com>
References: <CAKafyqp6af4MCcXQ6Db=hw8WNiYSfGDdq0gJTfav4pt2u1yk4A@mail.gmail.com>
	<CABBYNZJ6-jQh-yF6Pg6vhYJ4D_oH1t61B=809nU_RgU0AS-s1g@mail.gmail.com>
Date: Thu, 5 Nov 2015 16:44:38 +0530
Message-ID: <CAKafyqrDztp4g1E6vxecVtaMaYrn3fYMG-VSDhjfE0xsL0EEkg@mail.gmail.com>
Subject: Re: HoG Devices is not auto connecting after reboot.
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Nov 5, 2015 at 3:35 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Prabhu,
>
> On Thu, Nov 5, 2015 at 11:09 AM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
>> Hi All,
>>
>>   I got HoG key board, I scan and connect with bluez-5.35 it works fine.
>>
>> But after reboot of the pc, whenever i pressed key  i dont see the key
>> reaching to pc. I need to scan it agian and connect.
>>
>> Le me know how can I make it to work.
>>
>> Directed advertisement from hcidump.
>>> HCI Event: LE Meta Event (0x3e) plen 12
>> LE Advertising Report
>> ADV_DIRECT_IND - Connectable directed advertising (1)
>> bdaddr 61:99:5B:00:15:10 (Public)
>> RSSI: -70
>
> Is bluetoothd running at this point? Im asking this because bluetoothd
> needs to program the addresses for passive scanning to auto connect,
> or in case your kernel (3.17 >) don't support passive scanning then
> bluetoothd would be doing active scanning.
>
>
> --

Bluetoothd is running.  My kernel version is   3.18.100 its fedora
20... Do you want me to run later version of Kernel ? Please let me
know version passive scanning is supposed to work ? I will try
updating kernel in that case.


> Luiz Augusto von Dentz
