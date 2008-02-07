Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10802071025s38dbe8dbuaeff21f05e45b49f@mail.gmail.com>
Date: Thu, 7 Feb 2008 13:25:26 -0500
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202251232.15090.147.camel@violet>
MIME-Version: 1.0
References: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
	<1202251232.15090.147.camel@violet>
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

Hi Marcel
 I create a small test in C  bluez-sdp-tests.c
 Source code there: http://snapshot.bluecove.org/bluecove-gpl/bluez/test/

 If the SDP binary size is 258  bytes still works OK.
 But when I make it bigger call to sdp_gen_record_pdu will crash.

===================TEST_SEQ_SIZE 125=========================
--- start testing SDP convenrsions ---
create SEQ of 125 elements
call sdp_attr_add
call sdp_gen_record_pdu
pdu.data_size 258
call sdp_extract_pdu
pdu scanned 258
OK
--- tests finished ---
===================TEST_SEQ_SIZE 126=========================
 --- start testing SDP convenrsions ---
create SEQ of 126 elements
call sdp_attr_add
call sdp_gen_record_pdu
*** stack smashing detected ***: target/bluez-tests terminated
make: *** [run] Aborted

Regards,
Vlad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
