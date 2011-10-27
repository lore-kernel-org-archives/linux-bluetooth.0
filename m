Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Oct 2011 04:30:03 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Brian Gix <bgix@codeaurora.org>,
	Inga Stotland <ingas@codeaurora.org>
Subject: RE: GATT Dbus API on BlueZ - attirbute-api.txt modifications
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
Message-ID: <alpine.DEB.2.02.1110270417210.30510@mathewm-linux>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org> <4EA6143E.4000606@googlemail.com> <7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com> <CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
 <7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com> <CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com> <7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com> <alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
 <7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Thu, 27 Oct 2011, Ganir, Chen wrote:

> Hi Mat.
>
>> -----Original Message-----
>> From: Mat Martineau [mailto:mathewm@codeaurora.org]
>> Sent: Thursday, October 27, 2011 9:17 AM
>> Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
>>
>> Hi Chen -
>>
>> On Wed, 26 Oct 2011, Ganir, Chen wrote:
>>
>>> Hi.
>>>
>>> Here's my proposal for some modifications to the existing attribute-
>> api.doc file.
>>>
>>> These additions include :
>>> 1. Support for more properties, such as writable, readable, notify
>>> 2. Remove Value from the properties, and handle write/read with
>> specific functions. This was done since currently the value is only
>> read once from the server, and there is no way to refresh the value
>> using the dbus API. In addition, the value can be written in multiple
>> ways (we currently support write with response and write without
>> response, but future write methods include write reliable and write
>> signed, which may be required by profiles in the future).
>>>
>>> Here's the diff from the current docs/attribute-api.txt file :
>>>
>>> ---->8---------------
>>> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
>>> index 98d7f30..fbc6957 100644
>>> --- a/doc/attribute-api.txt
>>> +++ b/doc/attribute-api.txt
>>> @@ -112,6 +112,17 @@ Methods		dict GetProperties()
>>>
>>> 			Possible Errors: org.bluez.Error.InvalidArguments
>>>
>>> +		array{byte} ReadValue()
>>> +
>>> +		    Read the value of the characteristic.
>>> +
>>
>> One aspect of the current client implementation is that it caches the
>> read values within bluetoothd.  Do you prefer to completely eliminate
>> that storage and always have ReadValue fetch from the remote device?
>>
>> If there's still a use case for locally cached values (maybe there
>> isn't), a "method" parameter could specify the source of the data.  It
>> could also provide some future-proofing for ReadValue.
>>
>
> I do not see any reason why caching of data is required. Data should be read directly from the GATT server. Caching it may cause inconsistency. There is also no reason to read the values on characteristic object creation in the client.c file. I think the decision of reading the value should be by the user and not the system.
> In addition, Value is not a property of a characteristic.
>
>
>>> +		int WriteValue(array{byte} value, int method)
>>> +
>>> +		    Write the value of the characteristic, with specified
>> method :
>>> +		    0: Write without response. Always return 0.
>>> +		    1: Write with response. Return server response code.
>>> +		    Other write methods will be added in the future.
>>> +
>>
>> This addresses the shortcomings we saw with SetProperty, and also
>> gives options for the future - seems like a great idea to me!
>>
>>
>>> Properties 	string UUID [readonly]
>>>
>>> 			UUID128 of this characteristic.
>>> @@ -142,15 +153,58 @@ Properties 	string UUID [readonly]
>>> 			  uint16 | Description: Description of the
>> characteristic defined
>>> 			         | in a high layer profile.
>>>
>>> -		array{byte} Value [readwrite]
>>> -
>>> -			Raw value of the Characteristic Value attribute.
>>> -
>>> 		string Representation (of the binary Value) [readonly]
>>>
>>> 			Friendly representation of the Characteristic Value
>>> 			based on the format attribute.
>>>
>>> +		boolean Broadcast [readwrite]
>>> +
>>> +		    Indicates whether this characteristic is broadcasted or
>> not.
>>> +		    If GATT Server Characteristic Configuration descriptor
>>> +		    is not available for this characteristic, or if the
>> characteristic
>>> +		    properties do not allow this, writing to this property
>> is not
>>> +		    allowed.
>>> +
>>> +		boolean Indicate [readwrite]
>>> +
>>> +		    Indicates whether this characteristic is notified or
>> not.
>>> +		    If GATT Client Characteristic Configuration descriptor
>>> +		    is not available for this characteristic, or if the
>> characteristic
>>> +		    properties do not allow this, writing to this property
>> is not
>>> +		    allowed.
>>> +
>>> +		boolean Notify [readwrite]
>>> +
>>> +		    Indicates whether this characteristic is indicated or
>> not.
>>> +		    If GATT Client Characteristic Configuration descriptor
>>> +		    is not available for this characteristic, or if the
>> characteristic
>>> +		    properties do not allow this, writing to this property
>> is not
>>> +		    allowed.
>>> +
>>> +		boolean Readable [readonly]
>>> +
>>> +		    Indicates wether this characteristic value can be read.
>>> +
>>> +		boolean WritableNoRsp [readonly]
>>> +
>>> +		    Indicates whether this characteristic value can be
>> written without
>>> +		    response.
>>> +
>>> +		boolean WritableRsp [readonly]
>>> +
>>> +		    Indicates whether this characteristic can be written
>> with response.
>>> +
>>> +		boolean WritableSigned [readonly]
>
> The WritableSigned is going to be changed to WritableAuth (this is true for both Authenticated link or signed GATT Write commands).
>
>>> +
>>> +		    Indicates whether this characteristic can be written
>> with signed
>>> +		    authentication method.
>>> +
>>> +		boolean WritableReliable [readonly]
>>> +
>>> +		    Indicates whether this characteristic can be written
>> with the
>>> +		    reliable write procedure.
>>> +
>>>
>>> Characteristic Watcher hierarchy
>>> ===============================
>>>
>>> --------8<-----------
>>>
>>> I would appreciate your comments on this.
>>
>> The additional properties also seem like nice additions, and work well
>> to provide clear differentiation between the characteristic value and
>> other metadata.
>>
>> Thanks for the proposal!
>>
>
> Thanks for the review. Do these changes break the current implementation of your solution?
>
> If there are no more comments, I think I'll start sending patches for the required changes to support this.

The changes should be compatible with our Android code, provided we 
update the DBus method calls to use the new names and properties.

Brian & Inga (cc'd) know all the details and should be available to 
comment later today.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


