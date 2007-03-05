Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45EC8278.9020508@apnet.pl>
Date: Mon, 05 Mar 2007 21:50:00 +0100
From: milosz danielewski <master@apnet.pl>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45EAAB70.60302@apnet.pl>	<1173029470.5752.6.camel@aeonflux.holtmann.net>	<loom.20070305T200231-670@post.gmane.org>	<1173126164.6638.90.camel@aeonflux.holtmann.net>	<45EC7338.5030901@apnet.pl>
	<1173127826.6638.98.camel@aeonflux.holtmann.net>
In-Reply-To: <1173127826.6638.98.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------050307010801080206000600"
Subject: Re: [Bluez-devel] sdp_uuid32_to_uuid128, lack of declaration
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

This is a multi-part message in MIME format.
--------------050307010801080206000600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Milosz,
> 
>>  As I am newbie here, what's the policy of sending patches? Should I
>> send it to bluez-devel list, or directly to you or whatever?
> 
> create a unified diff with your changes against the latest CVS code and
> send it to the BlueZ developer mailing list.

here it goes...

milosz danielewski

--------------050307010801080206000600
Content-Type: text/x-patch;
 name="sdp_lib.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdp_lib.h.patch"

Index: sdp_lib.h
===================================================================
RCS file: /cvsroot/bluez/libs/include/sdp_lib.h,v
retrieving revision 1.29
diff -u -r1.29 sdp_lib.h
--- sdp_lib.h	13 Jan 2007 17:50:06 -0000	1.29
+++ sdp_lib.h	5 Mar 2007 20:10:25 -0000
@@ -475,6 +475,7 @@
 int sdp_uuid128_cmp(const void *p1, const void *p2);
 uuid_t *sdp_uuid_to_uuid128(uuid_t *uuid);
 void sdp_uuid16_to_uuid128(uuid_t *uuid128, uuid_t *uuid16);
+void sdp_uuid32_to_uuid128(uuid_t *uuid128, uuid_t *uuid32);
 int sdp_uuid128_to_uuid(uuid_t *uuid);
 int sdp_uuid_to_proto(uuid_t *uuid);
 int sdp_uuid_extract(const uint8_t *buffer, uuid_t *uuid, int *scanned);

--------------050307010801080206000600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050307010801080206000600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050307010801080206000600--
