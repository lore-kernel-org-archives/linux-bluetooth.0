Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'Ganir, Chen'" <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Proposal for GATT Client Dbus API.
Date: Fri, 4 Nov 2011 12:45:56 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B478523E8@banasiexm01.ASIA.ROOT.PRI>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
 <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
 <7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,
Thanks for your inputs. Please find my comments inline. 
 
> > Queries:
> > 1) As the "Signals" are a broadcast, how do we direct it to the
> > application which requests for it?
> We can use the existing watchers. At the moment, watchers are registered to be called when indication/notification arrives from the > > sever. This means that a watcher will receive ValueChanged message with characteristic path and new value. We could use this > >interface >and add the ReadRespnse and WriteResponse to it.

So you mean we add the ReadResponse and WriteResponse to Watcher Hierarchy?  , but what if we don't register the watcher and just want to read/write?  

>> 
>> +		void GetCharacteristicValue( )
>> +
>> +			Read the value of the characteristic.
>> +			This will emit a ReadResponse signal with status
>> code.


>When will this signal/message be sent ? Do we implement a timeout for connection timeout ? Can we set it as a parameter to this message?


Method can be called when applications want to read the value on server(active read).

> > +
> > +		void SetCharacteristicValue(variant value, string method,
> uint16 offset)
> > +
> > +			Changes the value of the specified characteristic as
> > per the offset and method. Only
> > +			read-write characteristic value can be changed.
> What is this read-write char value you are referring to here ?

Updated.

> +			This will emit a WriteResponse signal with status
> code.
> Again, we need some timeout, to allow clean upper level implementation.

> +
> +			Write the value of the characreristic, with any of
> these specified method:
> +			"WriteWithResponse", "SignedWriteWithoutResponse",
> +			"WriteLongCharacteristicValue", "PrepareWrite",
> "ExecuteWrite".
> +
> +		void  ReadDescriptor(uint16 handle)
> +
> +			Read the value of the specified characteristic
> descriptor matching the handle.
> +			This will emit a ReadDescriptorResponse signal with
> status code.
> This will not go through. Handles should not be used by the users. In fact, all descriptors can be turned into D-BUS dictionaries, >and be available as characteristic properties. This is already done today for some descriptors. However, not all of them should be >exposed directly to user (client characteristic config descriptor for example can be exposed as properties Notify and Indicate, server >char config descriptor can be exposed as property Broadcast, and so on. Format is already discovered and partially used in the >existing code.

ReadDescriptor and WriteDescriptor we have added keeping "Custom" descriptors (Optional Characteristic descriptor which
defines profile defined descriptor UUID's.)  in mind.
> +		dict Descriptors [readonly]

So a property which contains a dict (mapping handle -> uuid) for
*all* descriptors (of course the properties for known descriptors
would still exist, but this generic read/write API would be used for
them as well). 



> +
> +		void  WriteDescriptor(uint16 handle, array{byte} value)
> +
> +			Changes the value of the specified characteristic
> descriptor matching the handle. Only
> +			read-write descriptors can be changed.
> +			This will emit a WriteDescriptorResponse signal with
> status code.
> +
>  			Possible Errors: org.bluez.Error.InvalidArguments
> 
> No use for this one - see above my previous comment.

> +Signals		PropertyChanged(string name, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> When will this be used? We already have readresponse, writeresponse. Other properties are fixed, and read on connection > >automatically. We will not need this. We can use this if we expose Notify, Indicate, Broadcast properties. Writing to these properties >will cause the propertychanged event to be called, once the write has completed, if that's possible.

Yes agree with adding Notify, Indicate, Broadcast as properties. 



> +		ReadResponse(uint8 status, variant value)
> +
> +			Parameter is the read value and status code for
> GetCharacteristicValue operation.
>We need to add the characteristic path as well. We may issue multiple read requests, and receive them all after a while - we need to >be able to understand which characteristic value we received.

Agreed.

> +
> +		WriteResponse(uint8 status)
> +
> +			Parameter is the status code for
> SetCharacteristicValue operation.
>Same as above - we need the characteristic path.

Agreed.

> +
> +
> +		ReadDescriptorResponse(uint8 status, variant value)
> +
> +			Parameter is the read value and status code for
> ReadDescriptor operation.
> +
> +		WriteDescriptorResponse(uint8 status)
> +
> +			Parameter is the status code for WriteDescriptor
> operation.
> +
>No need for this.

Added keeping "Custom" descriptors in mind.

>  Properties 	string UUID [readonly]
> 
>  			UUID128 of this characteristic.
> @@ -121,12 +169,22 @@ Properties 	string UUID [readonly]
>  			Optional field containing a friendly name for the
>  			Characteristic UUID.
> 
> +		array{string} Properties [readonly]
> +
> +			The characteristic properties includes extended
> properties if defined, format defined by GATT spec.
> +			Possible values representing each bit field:
> +			{ "Broadcast", "Read", "WriteWithoutResponse",
> "Write", "Notify", "Indicate", "AuthenticatedSignedWrite",
> 			"ExtentedProperties", "ReliableWrite",
> "WritableAuxiliaries"}
> +
>Properties which can be changed, such as Broadcast, Indicate, Notify should be standalong, Boolean read/write properties. See above >for more information on why we need these.

Agreed. I think we can have this array plus for the simpler usage we can add the r/w Broadcast, Indicate, Notify properties.

> +		uint16 ClientConfiguration [readwrite]
> +
> +			Optional field containing the client configuration
> value on the server.
> +
> We should not expose bit fields to the users. We can abstract this to Notify/Indicate Boolean properties.

Agreed

>>  		string Description [readonly]
>> 
>  			Textual optional characteristic descriptor describing
>  			the Characteristic Value.
> 
> -		struct Format [readonly]
> +		array{struct} Format [readonly]
> 
>  			Optional Characteristic descriptor which defines the
>  			format of the Characteristic Value. For numeric
> @@ -151,6 +209,11 @@ Properties 	string UUID [readonly]
>  			Friendly representation of the Characteristic Value
>  			based on the format attribute.
> 
> This also needs to be simplified. We need to take the format strings from the spec, and apply the correct properties according to the > format descriptor. Again, we should not expose raw bit fields here.

>> +		dict Descriptors [readonly]
>> +
>> +			The value is a dictionary for all Characteristic
>> descriptor with the handle as keys and the UUID as values.The key is
> 			uint16 and the value a string for this dictionary.
> Can be used with WriteDescriptor and ReadDescriptor.
> +		      These attribute handle is only valid during the
>> session, and should not be stored/cached by the client.
>> +
> See above. Not needed.
Explained part of ReadDescriptor. 

Thanks,
Vijay



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
