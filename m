Return-Path: <cyrus@holtmann.org>
Message-ID: <cc1649d10802051215j7f1d9406u6c4cda1b161c77de@mail.gmail.com>
Date: Tue, 5 Feb 2008 15:15:55 -0500
From: "Vlad Skarzhevskyy" <skarzhevskyy@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] sdp_extract_pdu *** stack smashing detected ***
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

Hi
  We have experimental JSR-82 module that is directly bound to libbluetooth.so
  svn  http://bluecove.googlecode.com/svn/bluecove-gpl/trunk

 Don't worry we also working D-Bus bound module as well....

  Now we just found a small problem in bluez sdp.c. When we are
creating service record that contains SDP_SEQ and its (SEQ) binary
size more then 254 bytes we get *** stack smashing detected *** error.

 For tests SDP_SEQ containing 253 Null elements has been used.

Stack: [0xb512f000,0xb5180000),  sp=0xb517e930,  free space=318k
Native frames: (J=compiled Java code, j=interpreted, Vv=VM code, C=native code)
C  [libbluetooth.so.2+0xace2]  sdp_append_to_buf+0x22
C  [libbluetooth.so.2+0xde08]  sdp_append_to_pdu+0x98

My entry point to the library is sdp_extract_pdu

  Tested on Fedora 7 2.6.21 i386,  bluez-libs 3.9

  I was looking at the source code for sdp.c 3.25 and can't see any
related changes.

 The code creating the test is in java and it call function in
BlueCoveBlueZ_Tests.c

  How should I approach to fix this bluez?

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
