Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c313f5$b57ae030$1a01010a@baked>
References: <000c01c313f5$b57ae030$1a01010a@baked>
Message-Id: <1052401433.2669.93.camel@pegasus.local>
Mime-Version: 1.0
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
Date: 08 May 2003 15:43:46 +0200
Content-Type: text/plain

Hi Daryl,

> We've started bluetooth qualification testing with Cetecom for our product
> (which uses the bluez stack). Most tests passed, but there were several that
> failed. Below is a summary of the testing that was performed and a list of
> failed tests. We are only testing the portions which are relevant to our
> product, so this is list is not necessarily a complete list of qualification
> related problems. I believe most of the problems will be relatively easy to
> fix. Could you guys take a look?

it looks like that the home of Cetecom is in Germany :)

Can you tell us a little bit more about your product, because I can't
find enough details on the website.

> The tests were performed on a system running a slightly out-of-date bluez
> stack, so it's possible that some of the problems have already been
> resolved. If you could point out any items that have already been resolved
> (or are probably resolved), it would be much appreciated. A qualified
> bluetooth module was not available for testing (but will be soon), so if it
> appears that any of these problems are likely due to a malfunctioning
> module, please let me know.
> 
> The tests were performed on a system running the following bluez component
> versions:
>         bluez-kernel-2.3
>         bluez-libs-2.3
>         bluez-sdp-1.0rc3

The biggest problem in this test case is the bluez-kernel-2.3, because
it is too much outdated. You should better use one of -mh patches or try
to build a new bluez-kernel package from the kernel scripts that I have
put into CVS. The bluez-libs-2.3 shouldn't make any problems, but it is
a good idea to update to bluez-sdp-1.1.

The L2CAP and RFCOMM part is kernel specific and it is a good idea to do
the qualification tests with the an up-to-date kernel, because in this
case it is easier to look at the problems and fix them.

> The portions of each of these required for SPP server and OPP client were
> tested so far: SDP, GAP, RFCOMM, L2CAP. For the most part, optional things
> were not tested. Testing wasn't 100% complete.
> 
> Qualification failures/problems: (I can get tester logs for most of these
> failures if they would be helpful.)

Please send them to me. Stephen has already answered the SDP part and I
try to put some comments on L2CAP and RFCOMM.

> L2CAP:
>         1.) TP/COS/CED/BI-01: Verifies that the IUT rejects an unkown
> signalling command. The tester sends an unkown L2CAP command. The IUT should
> respond with an L2CAP_Reject with reason 0 "Command not understood". The IUT
> did not.

We have a fixme for this in the l2cap.c code, but currently no code
exists. Should be easy to fix, but nobody cares about it.
 
>         2.) TP/COS/CFD/BV-01: Tests that IUT is able to handle the receiving
> of more than one request for configuration of data channel. Tester sends
> L2CAP_Config Req with flag=1, IUT responds with flag=0. According to section
> 5.4 p.290 of the version 1.1 spec, "When used in the Configuration Response,
> the continuation flag must be set if the flag is set in the Request".

This seems to be a bug in the current code. But I have to re-read the
L2CAP specification for the details.

>         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform negotiation
> while the tester rejects the configuration of a data channel. The IUT sends
> a configuration request and the tester rejects it. The IUT should send
> another configuration request, but it does not.

Currently the channel is closed if they reject our config request,
because we don't know how to proceed if they don't like our settings. We
can sent them again, but they will be rejected again. For this case I
also have to read the L2CAP in detail.

>         4.) TP/COS/RCO/BI-01, BI-02: These tests verify that the IUT
> performs a consistency check on the data. Both tests send two packets to the
> IUT. In each test, the first packet has a mistake. In BI-01 the first packet
> is too short by one byte, and in BI-02 the first packet is too long by one
> byte. In both cases the stack must correctly receive the second packet, but
> not the first. The data should be discarded in the case of the
> inconsistencies, and an error reported to the application.

It seems that we can't handle this case complete correctly, if the data
was put only in one fragment. But in the basics this should work and the
malformed packets should be dropped. Did you have a detailed log of this
test which shows us byte by byte which request was sent?

> RFCOMM:
> 	Note: Some of these comments don't apply to a specific test case
> (they are more general).
>         1.) Must not modify pbits in pn (parameter negotiation) response.
> The pbits are dependent on which DLC is being configured. Apparently this is
> a common problem, and one that has been argued about with the SIG because
> apparently nobody uses the bits - but the SIG would not give in (refer to
> erratum 364). They are specified in the TS GSM 07.10 630 spec, section
> 5.4.6.3.1.

I am little bit confused, because I thought that the P/F bit in a UIH
packet response on dlci 0 should always be zero. The only case where the
P/F bit is set should be with credit based flow control. I will check
the specification. Can you send me the erratum 364?

>         2.) TP/RFC/BV-07: Closing rfcomm doesn't appear to close l2cap. Is
> this true? This isn't actually required to pass this test, but it did
> confuse the tester. This may have been a mistake on my part. I just hit
> ctrl-c when rctest was connected and assumed that everything would get
> closed. Would calling close() have a different effect?

This is working fine for me. After closing the channel, we close dlci 0
and this also closes the L2CAP connection.

	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x55 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 4 pf 1 ilen 0 fcs 0x77 
	> ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x40 len 4 [psm 3]
	      RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d 
	< ACL data: handle 0x0029 flags 0x02 dlen 8
	    L2CAP(d): cid 0x55 len 4 [psm 3]
	      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
	< ACL data: handle 0x0029 flags 0x02 dlen 12
	    L2CAP(s): Disconn req: dcid 0x0055 scid 0x0040

>         3.) TP/RFC/BV-13-C: Verifies that the IUT responds to a Remote Line
> Status command from the tester. When the remote line status command is
> received, the remote device must respond with a remote line status response.
> We responded with NSC (not supported command) instead of RLS response.

I have fixed this in patch-2.4.20-mh7 and it is in the not released
2.4.21-rc2 mainstream kernel.

>         4.) TP/RFC/BV-17-C: RFCOMM Parameter Negotiation: RFCOMM doesn't
> respond with desired parameters in RPN response (it responds with 0's). I
> took a quick look at the RFCOMM code (our older version) and it's apparent
> that variables are being set with the desired values when the tester
> requests values that we don't like, but those variables are not the ones
> that are actually sent in the response. The parameter mask is set correctly
> though.

Please enable RFCOMM debug output and send us the request that the
Tester performs.

>         5.) Once an RFCOMM channel is established, the IUT must exchange
> MSC's (modem status commands) before sending data. That is, it must send an
> MSC, wait for a response, wait for the sender's MSC, and respond to it
> before sending data. Our device sent an MSC and then immediately started
> sending data when we used rctest. This applies to many test cases.

We send the MSC after the UA. But we also go into BT_CONNECTED state and
in this state you can also start sending data. We should maybe go from
BT_CONNECT -> BT_CONFIG and only switch to BT_CONNECTED after the
successful exchange of MSC.

>         6.) If a connecting device doesn't send a PN command with CL bits
> set to 0x0f, then it means it is not a 1.1 device and we must not use credit
> based flow control. In our case, when such a PN command was received, data
> was sent using credit based flow control but shouldn't have been. This
> applies to many test cases.

This should not happen, because the current RFCOMM code can deal with
1.0b and 1.1 devices correctly. Please check this with latest RFCOMM
code and send us the detailed log of this problem.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
