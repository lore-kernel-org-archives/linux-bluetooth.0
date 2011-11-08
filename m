Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>,
	"'claudio.takahasi@openbossa.org'" <claudio.takahasi@openbossa.org>,
	"'mathewm@codeaurora.org'" <mathewm@codeaurora.org>,
	"'luiz.dentz@gmail.com'" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"'Ganir, Chen'" <chen.ganir@ti.com>
Subject: RE: Proposal for GATT Client Dbus API.
Date: Tue, 8 Nov 2011 13:52:18 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B47852C55@banasiexm01.ASIA.ROOT.PRI>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
 <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
 <F82830D409D80E4881C83250E051B74B4784F0B3@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4785205C@banasiexm01.ASIA.ROOT.PRI>
 <7769C83744F2C34A841232EF77AEA20C01DCC8DD1C@dnce01.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478523E8@banasiexm01.ASIA.ROOT.PRI>
 <F0070FBC0FB3174D8D11444EB2D5B0260106E6@DNCE02.ent.ti.com>
 <F82830D409D80E4881C83250E051B74B478529E4@banasiexm01.ASIA.ROOT.PRI>
 <F0070FBC0FB3174D8D11444EB2D5B026017DB4@DNCE02.ent.ti.com>
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026017DB4@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
Below is the updated proposal with all your valuable feedback. Could you please let me know your inputs for the same? 

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 98d7f30..a6b79c9 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -110,6 +110,20 @@ Methods		dict GetProperties()
 			read-write properties can be changed. On success
 			this will emit a PropertyChanged signal.
 
+		void ReadCharacteristicValue(uint16 timeout)
+
+			Read the value of the characteristic with timeout value. 
+			This will emit a ReadResponse signal with status code.
+
+		void WriteCharacteristicValue(variant value, string method, uint16 offset, uint16 timeout)
+
+			Changes the value of the specified characteristic as per the offset and method, with timeout value. 
+			This will emit a WriteResponse signal with status code.
+			
+			Write the value of the characreristic, with any of these specified method:
+			"WriteWithResponse", "SignedWriteWithoutResponse", 
+			"WriteLongCharacteristicValue", "PrepareWrite", "ExecuteWrite".
+
 			Possible Errors: org.bluez.Error.InvalidArguments
 
 Properties 	string UUID [readonly]
@@ -121,12 +135,46 @@ Properties 	string UUID [readonly]
 			Optional field containing a friendly name for the
 			Characteristic UUID.
 
+		boolean Broadcast [readwrite]
+
+		    	Indicates whether this characteristic is broadcasted or not.
+		    	If GATT Server Characteristic Configuration descriptor
+		    	is not available for this characteristic, or if the characteristic
+		    	properties do not allow this, writing to this property is not
+		    	allowed.
+
+		boolean Indicate [readwrite]
+
+		    	Indicates whether this characteristic is indicated or not.
+		    	If GATT Client Characteristic Configuration descriptor
+		    	is not available for this characteristic, or if the characteristic
+		    	properties do not allow this, writing to this property is not
+		    	allowed.
+
+		boolean Notify [readwrite]
+
+		    	Indicates whether this characteristic is notified or not.
+		    	If GATT Client Characteristic Configuration descriptor
+		    	is not available for this characteristic, or if the characteristic
+		    	properties do not allow this, writing to this property is not
+		    	allowed.
+
+		boolean Readable [readonly]
+
+		    	Indicates wether this characteristic value can be read.
+
+		array{string} WriteMethods [readonly]
+
+			Write methods supported by the characteristic, includes extended properties if defined, format defined by GATT spec. 
+			Possible values: 
+			{ "WriteWithoutResponse", "Write", "AuthenticatedSignedWrite", "ReliableWrite", "WritableAuxiliaries"}
+
 		string Description [readonly]
 
 			Textual optional characteristic descriptor describing
 			the Characteristic Value.
 
-		struct Format [readonly]
+		array{struct} Format [readonly]
 
 			Optional Characteristic descriptor which defines the
 			format of the Characteristic Value. For numeric
@@ -144,13 +192,17 @@ Properties 	string UUID [readonly]
 
 		array{byte} Value [readwrite]
 
-			Raw value of the Characteristic Value attribute.
+			The last known raw value of the Characteristic Value attribute. ReadCharacteristicValue should be used to get the 			latest value from the server.
 
 		string Representation (of the binary Value) [readonly]
 
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		array{object} CustomCharacteristicsDesc [readonly]
+
+			This list contains the user defined characteristics descriptors owned by this
+			specific characteristics, access the descriptor as attributes.
 
 Characteristic Watcher hierarchy
 ===============================
@@ -161,4 +213,14 @@ Object path	freely definable
 
 Methods		void ValueChanged(object characteristic, array{byte})
 
-			New raw value of the Characteristic Value attribute.
+			New raw value of the Characteristic Value attribute. This will be sent in one of the following scenarios :
+			Value was notified/indicated by the server.
+			Value was read using the GetProperty, and the updated value received from the server was different than the one 				provided as the GetProperty result.
+
+		void ReadResponse(object characteristic, uint8 status, variant value)
+
+			Value read and status code for Read Characteristic Value attribute operation. 
+
+		void WriteResponse(object characteristic, uint8 status)
+
+			Status code for Write Characteristic Value attribute opeartion. Should be used only when using Write operations which +			have a response. Write command will not emit this signal, it is the responsibility of the client to make sure (by 				reading the value) that the value was actually set correctly.


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
