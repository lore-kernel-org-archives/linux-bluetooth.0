Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <000c01c313f5$b57ae030$1a01010a@baked>
MIME-Version: 1.0
Subject: [Bluez-devel] Qualification Testing
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 6 May 2003 10:34:12 -0700
Content-Type: text/plain; CHARSET=us-ascii

Max, Marcel,

We've started bluetooth qualification testing with Cetecom for our product
(which uses the bluez stack). Most tests passed, but there were several tha=
t
failed. Below is a summary of the testing that was performed and a list of
failed tests. We are only testing the portions which are relevant to our
product, so this is list is not necessarily a complete list of qualificatio=
n
related problems. I believe most of the problems will be relatively easy to
fix. Could you guys take a look?

The tests were performed on a system running a slightly out-of-date bluez
stack, so it's possible that some of the problems have already been
resolved. If you could point out any items that have already been resolved
(or are probably resolved), it would be much appreciated. A qualified
bluetooth module was not available for testing (but will be soon), so if it
appears that any of these problems are likely due to a malfunctioning
module, please let me know.

The tests were performed on a system running the following bluez component
versions:
        bluez-kernel-2.3
        bluez-libs-2.3
        bluez-sdp-1.0rc3

The test specifications are available to download on the bluetooth website,
under Technology->Testing (you must be logged in):
        http://www.bluetooth.org

The portions of each of these required for SPP server and OPP client were
tested so far: SDP, GAP, RFCOMM, L2CAP. For the most part, optional things
were not tested. Testing wasn't 100% complete.

Qualification failures/problems: (I can get tester logs for most of these
failures if they would be helpful.)

SDP:
        PASS! (for our purposes), but there were a few things of note:
        1.) The SDP entry for the SDP server itself should have a Language
Base Attribute ID List (because there are text descriptions). I'm not
absolutely clear on whether or not it is mandatory, but it would make the
testers happy. Can an application add an attribute to that record, or would
sdpd have to be modified?
        2.) There appears to be a problem handling continuation states.
Handling continuation state is optional. We found that if the querying
device sends a maximum byte count of 100, the continutation state worked
fine. But if the querying device sent a maximum byte count of 8, the
continuation state doesn't work (the continuation flag wasn't recognized in
the next packet). I can dig up an example log if it would help.

GAP: PASS.

L2CAP:
        1.) TP/COS/CED/BI-01: Verifies that the IUT rejects an unkown
signalling command. The tester sends an unkown L2CAP command. The IUT shoul=
d
respond with an L2CAP_Reject with reason 0 "Command not understood". The IU=
T
did not.
        2.) TP/COS/CFD/BV-01: Tests that IUT is able to handle the receivin=
g
of more than one request for configuration of data channel. Tester sends
L2CAP_Config Req with flag=3D1, IUT responds with flag=3D0. According to se=
ction
5.4 p.290 of the version 1.1 spec, "When used in the Configuration Response=
,
the continuation flag must be set if the flag is set in the Request".
        3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform negotiation
while the tester rejects the configuration of a data channel. The IUT sends
a configuration request and the tester rejects it. The IUT should send
another configuration request, but it does not.
        4.) TP/COS/RCO/BI-01, BI-02: These tests verify that the IUT
performs a consistency check on the data. Both tests send two packets to th=
e
IUT. In each test, the first packet has a mistake. In BI-01 the first packe=
t
is too short by one byte, and in BI-02 the first packet is too long by one
byte. In both cases the stack must correctly receive the second packet, but
not the first. The data should be discarded in the case of the
inconsistencies, and an error reported to the application.

RFCOMM:
	Note: Some of these comments don't apply to a specific test case
(they are more general).
        1.) Must not modify pbits in pn (parameter negotiation) response.
The pbits are dependent on which DLC is being configured. Apparently this i=
s
a common problem, and one that has been argued about with the SIG because
apparently nobody uses the bits - but the SIG would not give in (refer to
erratum 364). They are specified in the TS GSM 07.10 630 spec, section
5.4.6.3.1.
        2.) TP/RFC/BV-07: Closing rfcomm doesn't appear to close l2cap. Is
this true? This isn't actually required to pass this test, but it did
confuse the tester. This may have been a mistake on my part. I just hit
ctrl-c when rctest was connected and assumed that everything would get
closed. Would calling close() have a different effect?
        3.) TP/RFC/BV-13-C: Verifies that the IUT responds to a Remote Line
Status command from the tester. When the remote line status command is
received, the remote device must respond with a remote line status response=
.
We responded with NSC (not supported command) instead of RLS response.
        4.) TP/RFC/BV-17-C: RFCOMM Parameter Negotiation: RFCOMM doesn't
respond with desired parameters in RPN response (it responds with 0's). I
took a quick look at the RFCOMM code (our older version) and it's apparent
that variables are being set with the desired values when the tester
requests values that we don't like, but those variables are not the ones
that are actually sent in the response. The parameter mask is set correctly
though.
        5.) Once an RFCOMM channel is established, the IUT must exchange
MSC's (modem status commands) before sending data. That is, it must send an
MSC, wait for a response, wait for the sender's MSC, and respond to it
before sending data. Our device sent an MSC and then immediately started
sending data when we used rctest. This applies to many test cases.
        6.) If a connecting device doesn't send a PN command with CL bits
set to 0x0f, then it means it is not a 1.1 device and we must not use credi=
t
based flow control. In our case, when such a PN command was received, data
was sent using credit based flow control but shouldn't have been. This
applies to many test cases.

-Daryl.

Senior Hardware Engineer
WideRay Corp.
604-233-1104



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
