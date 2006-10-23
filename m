Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 23 Oct 2006 10:25:51 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PwAPFr63HZ6ymQH"
Message-Id: <200610231025.51818.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] Proposed DTD
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

--Boundary-00=_PwAPFr63HZ6ymQH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

Here's the proposed DTD for SDP over XML.  It closely follows the SDP profile 
doc.  I wasn't sure whether sequences can be empty (which makes no sense to 
me), so I required at least one element in a sequence.    The sizes for Text, 
URLs and Sequences was dropped.  It can easily be inferred from parsing the 
document.  

I'd like to get some feedback as to how to manage things like Record Handle, 
and RFCOMM/L2Cap channels, etc.  For record handle I think it is easy, just 
remove that particular attribute and let the SDP server figure it out.  For 
RFCOMM channel, etc it is more tricky.  Should we use a magic value or just 
override it behind the scenes?  We can always rely on the user to pick a 
correct channel as well (and fail registration if they pick a channel that is 
already in use)

-Denis

--Boundary-00=_PwAPFr63HZ6ymQH
Content-Type: text/plain;
  charset="us-ascii";
  name="sdprecord.dtd"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sdprecord.dtd"

<!ELEMENT SdpRecord (Attribute)*>
<!ELEMENT Attribute (Sequence|Alternate|UUID16|UUID32|UUID128|UINT8|UINT16|UINT32|UINT64|UINT128|INT8|INT16|INT32|INT64|INT128|BOOL|Text|URL|NIL)>
<!ATTLIST Attribute id CDATA #REQUIRED>
<!ELEMENT Sequence (Sequence|Alternate|UUID16|UUID32|UUID128|UINT8|UINT16|UINT32|UINT64|UINT128|INT8|INT16|INT32|INT64|INT128|BOOL|Text|URL|NIL)+>
<!ELEMENT Alternate (Sequence|Alternate|UUID16|UUID32|UUID128|UINT8|UINT16|UINT32|UINT64|UINT128|INT8|INT16|INT32|INT64|INT128|BOOL|Text|URL|NIL)+>
<!ELEMENT UUID16 (#PCDATA)>
<!ELEMENT UUID32 (#PCDATA)>
<!ELEMENT UUID128 (#PCDATA)>
<!ELEMENT UINT8 (#PCDATA)>
<!ELEMENT UINT16 (#PCDATA)>
<!ELEMENT UINT32 (#PCDATA)>
<!ELEMENT UINT64 (#PCDATA)>
<!ELEMENT UINT128 (#PCDATA)>
<!ELEMENT INT8 (#PCDATA)>
<!ELEMENT INT16 (#PCDATA)>
<!ELEMENT INT32 (#PCDATA)>
<!ELEMENT INT64 (#PCDATA)>
<!ELEMENT INT128 (#PCDATA)>
<!ELEMENT BOOL (#PCDATA)>
<!ELEMENT URL (#PCDATA)>
<!ELEMENT Text (#PCDATA)>
<!ATTLIST Text type (data|string) "string">


--Boundary-00=_PwAPFr63HZ6ymQH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_PwAPFr63HZ6ymQH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_PwAPFr63HZ6ymQH--
