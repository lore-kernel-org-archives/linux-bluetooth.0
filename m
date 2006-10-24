Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 24 Oct 2006 15:47:36 +1000
References: <200610231025.51818.denis.kenzior@trolltech.com>
	<200610231431.28318.denis.kenzior@trolltech.com>
	<1161588427.7694.11.camel@aeonflux.holtmann.net>
In-Reply-To: <1161588427.7694.11.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4jaPFTaoQyFdxCB"
Message-Id: <200610241547.36330.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Proposed DTD
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_4jaPFTaoQyFdxCB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Based on your feedback a new DTD specification.  Hopefully it is getting 
closer.

-Denis

--Boundary-00=_4jaPFTaoQyFdxCB
Content-Type: text/html;
  charset="iso-8859-1";
  name="record.dtd"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="record.dtd"

<!-- DTD for BlueZ SDP Records -->

<!-- Toplevel element -->
<!ELEMENT record (attribute)*>

<!-- All child elements of record must be attribute elements -->
<!-- The id attribute of the attribute element must be present and unique -->
<!-- If the attribute with id 0x00 is specified, it might be ignored by the -->
<!-- SDP registration functions -->
<!ELEMENT attribute (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ATTLIST attribute id CDATA #REQUIRED>

<!-- Sequence and Alternates are special, only they can contain data records -->
<!ELEMENT sequence (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT sequence8 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT sequence16 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT sequence32 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT alternate (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT alternate8 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT alternate16 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>
<!ELEMENT alternate32 (data|sequence|sequence8|sequence16|sequence32|alternate|alternate8|alternate16|alternate32)+>

<!-- Data elements contain data information -->
<!-- They cannot contain any other data elements -->
<!ELEMENT data EMPTY>

<!-- The type can be one of: -->
<!-- nil -->
<!-- uuid -->
<!-- uuid16 -->
<!-- uuid32 -->
<!-- uuid128 -->
<!-- uint8 -->
<!-- uint16 -->
<!-- uint32 -->
<!-- uint64 -->
<!-- uint128 -- For now this is assumed to be hex encoded -->
<!-- int8 -->
<!-- int16 -->
<!-- int32 -->
<!-- int64 -->
<!-- int128 -- For now this is assumed to be hex encoded -->
<!-- bool -->
<!-- url -->
<!-- url8 -->
<!-- url16 -->
<!-- url32 -->
<!-- text -->
<!-- text8 -->
<!-- text16 -->
<!-- text32 -->
<!ATTLIST data type CDATA #REQUIRED>

<!-- All data elements must have a value, except for nil, its value will be ignored -->
<!-- Two special values exist for integer elements, %rfcomm_channel and %l2cap_psm -->
<!-- If these are specified, then an auto-generated unique rfcomm channel or l2cap psm -->
<!-- number will be substituted for the value -->
<!ATTLIST data value CDATA #REQUIRED>

<!-- Text elements can have an optional encoding attribute.  The encoding can be either -->
<!-- normal or hex.  It is assumed to be normal by default -->
<!ATTLIST data encoding (normal|hex) "normal">


--Boundary-00=_4jaPFTaoQyFdxCB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_4jaPFTaoQyFdxCB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_4jaPFTaoQyFdxCB--
