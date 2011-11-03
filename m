Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>,
	"'claudio.takahasi@openbossa.org'" <claudio.takahasi@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Proposal for GATT Client Dbus API.
Date: Thu, 3 Nov 2011 10:32:13 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
 <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
Here's my proposal for modification to existing attribute-api.doc.
The addition include:
1)Comments provided on this post.
2)Comments taken from the discussion part of " GATT Dbus API on BlueZ - attirbute-api.txt modifications" post.
3) Doesn't address ServiceChanged(), will discuss as part of another post. 

Queries:
1) As the "Signals" are a broadcast, how do we direct it to the application which requests for it?
2) Does bluez support SetConnectionParameters & UpdateConnectionParameters, if not do we need to add the APIs for the same ? 


diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 98d7f30..34d77bc 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -110,8 +110,56 @@ Methods		dict GetProperties()
 			read-write properties can be changed. On success
 			this will emit a PropertyChanged signal.
 
+		void GetCharacteristicValue( )
+
+			Read the value of the characteristic.
+			This will emit a ReadResponse signal with status code.
+
+		void SetCharacteristicValue(variant value, string method, uint16 offset)
+
+			Changes the value of the specified characteristic as per the offset and method. Only
+			read-write characteristic value can be changed.
+			This will emit a WriteResponse signal with status code.
+			
+			Write the value of the characreristic, with any of these specified method:
+			"WriteWithResponse", "SignedWriteWithoutResponse", 
+			"WriteLongCharacteristicValue", "PrepareWrite", "ExecuteWrite".
+			 
+		void  ReadDescriptor(uint16 handle)
+                        
+			Read the value of the specified characteristic descriptor matching the handle.
+			This will emit a ReadDescriptorResponse signal with status code.
+                        
+		void  WriteDescriptor(uint16 handle, array{byte} value)
+
+			Changes the value of the specified characteristic descriptor matching the handle. Only
+			read-write descriptors can be changed.
+			This will emit a WriteDescriptorResponse signal with status code.
+
 			Possible Errors: org.bluez.Error.InvalidArguments
 
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+		
+		ReadResponse(uint8 status, variant value)
+
+			Parameter is the read value and status code for GetCharacteristicValue operation. 
+
+		WriteResponse(uint8 status)
+
+			Parameter is the status code for SetCharacteristicValue operation. 
+			
+
+		ReadDescriptorResponse(uint8 status, variant value)
+
+			Parameter is the read value and status code for ReadDescriptor operation. 
+
+		WriteDescriptorResponse(uint8 status)
+
+			Parameter is the status code for WriteDescriptor operation. 
+
 Properties 	string UUID [readonly]
 
 			UUID128 of this characteristic.
@@ -121,12 +169,22 @@ Properties 	string UUID [readonly]
 			Optional field containing a friendly name for the
 			Characteristic UUID.
 
+		array{string} Properties [readonly]
+
+			The characteristic properties includes extended properties if defined, format defined by GATT spec. 
+			Possible values representing each bit field: 
+			{ "Broadcast", "Read", "WriteWithoutResponse", "Write", "Notify", "Indicate", "AuthenticatedSignedWrite", 					"ExtentedProperties", "ReliableWrite", "WritableAuxiliaries"}
+
+		uint16 ClientConfiguration [readwrite]
+
+			Optional field containing the client configuration value on the server.
+
 		string Description [readonly]
 
 			Textual optional characteristic descriptor describing
 			the Characteristic Value.
 
-		struct Format [readonly]
+		array{struct} Format [readonly]
 
 			Optional Characteristic descriptor which defines the
 			format of the Characteristic Value. For numeric
@@ -151,6 +209,11 @@ Properties 	string UUID [readonly]
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		dict Descriptors [readonly]
+
+			The value is a dictionary for all Characteristic descriptor with the handle as keys and the UUID as values.The key is 			uint16 and the value a string for this dictionary. Can be used with WriteDescriptor and ReadDescriptor.  
+		      These attribute handle is only valid during the session, and should not be stored/cached by the client.
+


> Hi,
> Thanks for your inputs. I am extending the current doc/attribute-api.txt. Will work towards your proposed changes and > > update the same. 

> Thanks,
> Vijay

Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
