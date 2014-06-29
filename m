Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] doc: Add management command for adding devices for passive scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAN_7+YajEYwDHqJpVBtiwLcZiZb7_-A5E7QUpLvHNRE3byM_0Q@mail.gmail.com>
Date: Sun, 29 Jun 2014 20:30:39 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9D38FD89-9C1F-4CB6-A04E-96F2730A9466@holtmann.org>
References: <1404035356-37352-1-git-send-email-marcel@holtmann.org> <CAN_7+YajEYwDHqJpVBtiwLcZiZb7_-A5E7QUpLvHNRE3byM_0Q@mail.gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

>> ---
>> doc/mgmt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 62 insertions(+)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index d329d4a66d9c..d428f7718512 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -1866,6 +1866,68 @@ Get Clock Information Command
>>                                Invalid Index
>> 
>> 
>> +Add Device Command
>> +==================
>> +
>> +       Command Code:           0x0034
>> +       Controller Index:       <controller id>
>> +       Command Parameters:     Address (6 Octets)
>> +                               Address_Type (1 Octet)
>> +                               Action (1 Octet)
>> +       Return Parameters:
>> +
> Address and address type will be useful in the return parameters.
> For example,  application wants to set auto connect to many devices.
> In that case daemon should be able to reply with success or failure
> for each of device.
> For sure it will be useful in Android case.

documentation has been updated and I already send v2 of my patch.

Regards

Marcel

