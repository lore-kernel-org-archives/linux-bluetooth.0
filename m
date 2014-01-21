Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v2 01/18] doc: Add GATT API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140121194842.GA3342@x220.p-661hnu-f1>
Date: Tue, 21 Jan 2014 11:51:48 -0800
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <A2AE2AD7-95DE-4D61-9218-68A467FDC33F@holtmann.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org> <1390310814-19880-2-git-send-email-claudio.takahasi@openbossa.org> <B5AE7C1F-664D-4859-9793-E853DFF02FC5@holtmann.org> <CAKT1EBc-VL5M0c1yt8LpGvaTyyE7P=9w5jGOZs7wUpRpsS7A8Q@mail.gmail.com> <20140121194842.GA3342@x220.p-661hnu-f1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> +Interface    org.bluez.GattServiceManager1 [Experimental]
>>>> +Object path  /org/bluez
>>> 
>>> Here we could discuss to use GattManager1 to make it shorter, but I
>>> am not sure if that actually helps. I currently tend to leave it as
>>> GattServiceManager1.
>> 
>> I prefer GattManager1. I have two reasons:
>> * "Service" is included in the methods names: RegisterService and
>> UnregisterService
>> * GattManager1 name is more generic and we can use it for other GATT
>> methods not directly related to "Service". At the moment, I don't have
>> examples, but I was thinking on potential methods related to GATT
>> Client.
>> 
>> Marcel/Johan: Please define which name will be used.
> 
> I'm voting for GattManager1, but Marcel has veto rights :)

lets go with GattManager1 and see where it takes us.

Regards

Marcel

