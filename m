Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10802071257r1d65d622sffa0e9a21883d9b@mail.gmail.com>
Date: Thu, 7 Feb 2008 15:57:40 -0500
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202410007.15090.255.camel@violet>
MIME-Version: 1.0
References: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
	<1202251232.15090.147.camel@violet>
	<cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
	<1202410007.15090.255.camel@violet>
Subject: Re: [Bluez-devel] sdp_extract_pdu *** stack smashing detected ***
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

In fact I used default Fedora 7 and it has bluez-libs 3.9
(libbluetooth.so.2.5.0)

I did source comparison with current sdp.c from bluez-libs 3.25 and I
was not able to see any changer related to this.  So I blindly assumed
this may be a bug.

Once  bluez-libs 3.25 installed (libbluetooth.so.2.9.4) the original
test works fine but when I change the number of records to 215 I get
the same error.  BUT not every run!!!!

--- start testing SDP convenrsions ---
create SEQ of 215 elements
call sdp_attr_add
call sdp_gen_record_pdu
pdu.data_size 438
call sdp_extract_pdu
pdu scanned 438
OK
--- tests finished ---


--- start testing SDP convenrsions ---
create SEQ of 215 elements
call sdp_attr_add
call sdp_gen_record_pdu
make: *** [run] Segmentation fault


If I have  #define TEST_SEQ_SIZE 128  (On bluez-libs 3.25 )
When I run the test if fails every 10-th run.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
