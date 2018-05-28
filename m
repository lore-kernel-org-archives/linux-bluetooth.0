Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: BLE advertise name
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <df2637cb-3888-46c0-53cb-f135e1ecd03b@palumbi.it>
 <CABBYNZKuGtLtvq2Ciu1Mgn-jZDnN4omc3TuYWg7eL7QsUW9ptA@mail.gmail.com>
 <0492fa2a-ab18-c7c7-1b6f-dd24c47e97f9@palumbi.it>
 <CABBYNZK+N+Gpv9vf8V8JnEbwh4EHO0H9vb+o9KfEs=8zynUORA@mail.gmail.com>
From: Marco Palumbi <marco@palumbi.it>
Message-ID: <b4aad154-e54a-62a3-c7fd-49945b41fc88@palumbi.it>
Date: Mon, 28 May 2018 17:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZK+N+Gpv9vf8V8JnEbwh4EHO0H9vb+o9KfEs=8zynUORA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz


On 28/05/2018 12:50, Luiz Augusto von Dentz wrote:
> Hi Marco,
>
> On Mon, May 28, 2018 at 1:40 PM, Marco Palumbi <marco@palumbi.it> wrote:
>> thank you for the replay Luiz.
>>
>>
>> On 27/05/2018 09:01, Luiz Augusto von Dentz wrote:
>>> Hi Marco,
>>>
>>> On Sat, May 26, 2018 at 9:49 PM, Marco Palumbi <marco@palumbi.it> wrote:
>>>> hello to all,
>>>>
>>>> I am trying to let BlueZ advertise on BLE with a name longer than 9
>>>> character. is this possible?
>>>> it seems to me that BlueZ uses the shortname to advertise over BLE.
>>>> Any suggestion?
>>> How exactly are you trying to advertise? Btw, you should be able to
>>> check what type we are using in the advertisement with use of btmon.
>>>
>> I tried to play with btmon but I wasn't able to find useful information from
>> it (probably I am not using it correctly..)
>> here is what I have done (BlueZ 5.41 - Digi Embedded Yocto 2.2-r3)
>>
>> after starting the  bluetoothd
>>
>> btmgmt -i hci0 le on
>> btmgmt -i hci0 connectable on
>> btmgmt -i hci0 advertising on
>> btmgmt -i hci0 discov on
>> btmgmt -i hci0 name MyVeryLongNameThatExceedsNineCharacters
>>
>> now, if I search for BLE devices from an adroid phone using the "nRF Connct"
>> (app from Nordic Semi for BLE tast) I can see my device shown only with this
>> name:
>>
>> MyVeryLong  (indeed they are 10 chars and not 9)
>>
>> while if I do a "classic" ble scan from android I see it shown twice both
>> with the long and the short name.
>>
>> Nevertheless the android app "nRF Connct" is able to get longer names from
>> devices not using BlueZ stack
>>
>> is this a limit of BlueZ or there is something wrong on my setup?
> Except that you should be using btmgmt as that requires sudo/root, I
> actually wonder why you haven't tried with bluetoothctl as that would
> use the D-Bus API available to applications?
>
>
>

I am not using sudo because I am on a very embedded SBC with ARM7 and 
Yocto linux distribution that has only the root user.
I am not using bluetoothctl mainly for lack of documentation..
What I am trying to do is to set up this board as BLE 
peripheral/server...(most of the available documentation refer to 
linux/BueZ as central/client..)
and I wish this board to be discoverable trough the BLE discovery 
protocol with its full name instead of the short one.
looking to the sources of btmgmnt, I understand that it sets the long 
and short names using the hci management soket and that is then managed 
at kernel divice dirver level...
is there any way to let the kernel to use the long name to announce on 
the BLE network?
My problem is that this linux board continues to be discovered whit its 
short name as BLE device


