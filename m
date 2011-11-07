Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Proposal for GATT Client Dbus API.
Date: Mon, 7 Nov 2011 13:52:52 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B026017DB4@DNCE02.ent.ti.com>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
 <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
 <7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478523E8@banasiexm01.ASIA.ROOT.PRI>
 <F0070FBC0FB3174D8D11444EB2D5B0260106E6@DNCE02.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478529E4@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <F82830D409D80E4881C83250E051B74B478529E4@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vijay,

> -----Original Message-----
> From: Vijaykumar Dadmode [mailto:Vijaykumar.Dadmode@csr.com]
> Sent: Monday, November 07, 2011 3:35 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: Proposal for GATT Client Dbus API.
> 
> Hi Chen,
> Below is the latest diff, with all the changes incorporated. Let me
> know your view.
> 
> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
> index 98d7f30..9dd8222 100644
> --- a/doc/attribute-api.txt
> +++ b/doc/attribute-api.txt
> @@ -110,6 +110,20 @@ Methods		dict GetProperties()
>  			read-write properties can be changed. On success
>  			this will emit a PropertyChanged signal.
> 
> +		void GetCharacteristicValue(uint16 timeout)
> +
> +			Read the value of the characteristic with timeout
> value in seconds.
> +			This will emit a ReadResponse signal with status
> code.
The ReadResponse will be emitted on timeout as well ? Why do you call this GetCharacteriristicValue instead of ReadCharacteristicValue, as the GATT spec names this operation ?

> +
> +		void SetCharacteristicValue(variant value, string method,
> uint16 offset, uint16 timeout)
Why do you call this SetCharacteristicValue instead of WriteCharacteristic value (Write is defined in the GATT spec) ?

> +
> +			Changes the value of the specified characteristic as
> per the offset and method, with timeout value in seconds.
> +			This will emit a WriteResponse signal with status
> code.
> +
> +			Write the value of the characreristic, with any of
> these specified method:
> +			"WriteWithResponse", "SignedWriteWithoutResponse",
> +			"WriteLongCharacteristicValue", "PrepareWrite",
> "ExecuteWrite".
> +
>  			Possible Errors: org.bluez.Error.InvalidArguments
> 
>  Properties 	string UUID [readonly]
> @@ -126,7 +140,41 @@ Properties 	string UUID [readonly]
>  			Textual optional characteristic descriptor describing
>  			the Characteristic Value.
> 
> +		boolean Broadcast [readwrite]
> +
> +		    	Indicates whether this characteristic is broadcasted
> or not.
> +		    	If GATT Server Characteristic Configuration
> descriptor
> +		    	is not available for this characteristic, or if the
> characteristic
> +		    	properties do not allow this, writing to this
> property is not
> +		    	allowed.
> +
> +		boolean Indicate [readwrite]
> +
> +		    	Indicates whether this characteristic is notified or
> not.
> +		    	If GATT Client Characteristic Configuration
> descriptor
> +		    	is not available for this characteristic, or if the
> characteristic
> +		    	properties do not allow this, writing to this
> property is not
> +		    	allowed.
> +
> +		boolean Notify [readwrite]
> +
> +		    	Indicates whether this characteristic is indicated or
> not.
> +		    	If GATT Client Characteristic Configuration
> descriptor
> +		    	is not available for this characteristic, or if the
> characteristic
> +		    	properties do not allow this, writing to this
> property is not
> +		    	allowed.
> +
> +		boolean Readable [readonly]
> +
> +		    	Indicates wether this characteristic value can be
> read.
> +
> +		array{string} WriteMethods [readonly]
> +
> +			Write methods supported by the characteristic,
> includes extended properties if defined, format defined by GATT spec.
> +			Possible values:
> +			{ "WriteWithoutResponse", "Write",
> "AuthenticatedSignedWrite", "ReliableWrite", "WritableAuxiliaries"}
> +
> 
> -		struct Format [readonly]
> +		array{struct} Format [readonly]
> 
>  			Optional Characteristic descriptor which defines the
>  			format of the Characteristic Value. For numeric
> @@ -142,6 +190,11 @@ Properties 	string UUID [readonly]
>  			  uint16 | Description: Description of the
> characteristic defined
>  			         | in a high layer profile.
> 
> +		array{object} CustomCharacteristicsDesc [readonly]
> +
> +			This list contains the user defined characteristics
> descriptors owned by this
> +			specific characteristics.
> +
>  		array{byte} Value [readwrite]
> 
>  			Raw value of the Characteristic Value attribute.
We should be perfectly clear here, that this is the last known value. It may be wrong, and GetCharacteristicValue should be used to get the latest value. We also should make sure that setting this property will use the Bluez preferred way of writing this characteristic, according to the supported permissions and properties. In addition, ValueChanged will be emitted is the value is actually written and a success was returned from the server. GetProperty on this property will get the current value, and a gatt_read command will be issued, emitting a ValueChanged event if the value is different when the read is complete and the value is different than what was initially returned.


> @@ -162,3 +215,11 @@ Object path	freely definable
>  Methods		void ValueChanged(object characteristic, array{byte})
> 
>  			New raw value of the Characteristic Value attribute.
This will be sent in one of the following scenarios :
1. Value was notified/indicated by the server
2. Value was read using the GetProperty, and the updated value received from the server was different than the one provided as the GetProperty result.


> +
> +		void ReadResponse(object characteristic, uint8 status,
> variant value)
> +
> +			Value read and status code for Read Characteristic
> Value attribute operation.
> +
> +		void WriteResponse(object characteristic, uint8 status)
> +
> +			Status code for Write Characteristic Value attribute
> opeartion.
> 
This one will be used only when using Write operations which have a response. Write command for example will not emit this signal, and it is the responsibility of the client to make sure (by reading the value) that the value was actually set correctly.

> 
> Member of the CSR plc group of companies. CSR plc registered in England
> and Wales, registered number 4187346, registered office Churchill
> House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United
> Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at
> http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

I think this is ok. I don't see any big issues with this one.



Best regards,
Chen Ganir
Texas Instruments.
