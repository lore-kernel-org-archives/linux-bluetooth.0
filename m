Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010D943FDB37@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D943FDA25@EMBSVR01.ember.local>
	<CAJLTA8gaxn4qt-U7Rmud7NPA=HXysMVw0hTqNkysbfrGPc25Fw@mail.gmail.com>
	<BD5E516FF3711A41B93DC005170007BB010D943FDB37@EMBSVR01.ember.local>
Date: Wed, 13 May 2015 10:32:19 -0700
Message-ID: <CAJLTA8j-v6wk5U5qiaFOGhKPyh90mTYQBZ89h1pdpTMicvykwA@mail.gmail.com>
Subject: Re: Issue with Add Advertisement and Bonding Procedure
From: Michael Janssen <jamuraa@google.com>
To: Ankur Patel <ankur@embertec.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

On Tue, May 12, 2015 at 5:13 PM, Ankur Patel <ankur@embertec.com> wrote:
>> Hi Ankur,
>>
>> On Tue, May 12, 2015 at 2:23 AM, Ankur Patel <ankur@embertec.com>
>> wrote:
>> > Hello Folks,
>> >
>> > Back with some more questions. I did tried googling but couldn't able to
>> find much info on 'btmgmt' tool hence sharing issues.
>> >
>> > Ran below commands to Setup the device (All went Good):
>> > btmgmt name testbt
>> > btmgmt privacy on
>> > btmgmt le on
>> > btmgmt keys on
>> > btmgmt ltks off
>> > btmgmt irks
>> > btmgmt connectable on
>> > btmgmt bondable on
>> > btmgmt pairable on
>> > btmgmt discov on
>> > btmgmt advertising on
>> > btmgmt fast-conn on
>> > btmgmt linksec on
>> > btmgmt power on
>> >
>> > Failed to Add Advertisement
>> > ------------------------------------
>> >
>> > root@imx28evk:~/tools# btmgmt info
>> > Index list with 1 item
>> > hci0:   Primary controller
>> >         addr 1C:BA:8C:86:81:21 version 6 manufacturer 13 class 0x000000
>> >         supported settings: powered connectable fast-connectable
>> discoverable bondable link-security ssp br/edr hs le advertising debug-keys
>> privacy
>> >         current settings: powered connectable fast-connectable discoverable
>> bondable link-security ssp br/edr hs le advertising debug-keys privacy
>> >         name testbt
>> >         short name
>> >
>> > // Starting Gatt Service
>> > root@imx28evk:~/tools# ./gatt-service & gatt-service unique name: :1.6
>> > Registered service: /service1 Get UUID:
>> > 00001802-0000-1000-8000-00805f9b34fb
>> > Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
>> > Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
>> > Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
>> >
>> > // Adding Advertisement but Fails
>> > root@imx28evk:~/tools# btmgmt add-adv -u 180d -u 180f -d
>> > 090954657374204C4505FFE0000102 1 Add Advertising failed with status
>> > 0x01 (Unknown Command)
>> >
>> > I am sure I am missing something to add advertisement. Can anyone share
>> how to add advertisement?
>>
>> This usually means that your kernel does not have support for the Add
>> Advertisement MGMT command, which recently got added currently in
>> mainline Linux 4.1 rc kernels but not 4.0.
>
> Thank you Michael for your kind response. We already ported our kernel from 3.10  to 3.18 to get the mgmt. support and it will be tough to migrate one more time. Then is there any way to add advertisement apart from using
> 'hciconfig' and 'hcitool' ?

hcitool will work for setting the advertisement data, but it will be
overridden by the kernel mgmt layer whenever it updates it's
advertisement data, because the kernel does not know about this data.
So you must take this into account.

-- 
M Janssen
