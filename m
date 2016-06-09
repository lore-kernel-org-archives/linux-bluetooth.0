Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Privacy mode breaking BLE reconnects
To: <linux-bluetooth@vger.kernel.org>
References: <2cd3f83d-6057-c813-4eaf-50a39d4e85a7@lnihealth.com>
 <20160609171845.GA19799@t440s.P-661HNU-F1>
From: Tom Harada <tomharada@lnihealth.com>
Message-ID: <bc96a1e1-7c35-944c-d214-acf298d2cc34@lnihealth.com>
Date: Thu, 9 Jun 2016 13:41:07 -0400
MIME-Version: 1.0
In-Reply-To: <20160609171845.GA19799@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 06/09/2016 01:18 PM, Johan Hedberg wrote:
> Hi Tom,
>
> On Thu, Jun 09, 2016, Tom Harada wrote:
>> I have a particular device that requires an IRK from BlueZ during pairing.
>> To my limited understanding this is wrong since my Bluetooth adapter uses a
>> public address by default, but I have to live with it in any case. I've
>> found that turning on privacy mode using `btmgmt privacy on` allows BlueZ to
>> pair with the device. However, it also prevents reconnecting to any
>> already-paired BLE device, even if privacy mode was enabled when I paired
>> with it.
>>
>> This is the sequence of events:
>> 1. Pair with a BLE device.
>> 2. Power off the adapter, run `btmgmt privacy on`, and power the adapter
>> back on.
>> 3. Connect to the device. The connection fails with the status "Connection
>> Failed to be Established" in the LE Read Remote Used Features HCI event.
>
> First of all, btmgmt is mainly intended for testing. Its privacy command
> creates a new random IRK every time so you can't really use it to create
> persistent pairings. You could get a little bit better behavior by
> giving the command a third parameter which btmgmt will interpret as a
> hex encoded IRK value. This is still just a "testing" style solution
> however.

That clears things up a lot. Thanks for your help.

Tom
