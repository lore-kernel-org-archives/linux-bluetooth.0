Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
References: <000c01c313f5$b57ae030$1a01010a@baked>
	<000c01c313f5$b57ae030$1a01010a@baked>
	<5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
Message-Id: <1052442873.1069.35.camel@pegasus.local>
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
Date: 09 May 2003 03:14:26 +0200
Content-Type: text/plain

Hi Max,

> >>         1.) TP/COS/CED/BI-01: Verifies that the IUT rejects an unkown
> >> signalling command. The tester sends an unkown L2CAP command. The IUT should
> >> respond with an L2CAP_Reject with reason 0 "Command not understood". The IUT
> >> did not.
> >
> >We have a fixme for this in the l2cap.c code, but currently no code
> >exists. Should be easy to fix, but nobody cares about it.
> Hold on. That's exactly what we do
>                 if (err) {
>                         l2cap_cmd_rej rej;
>                         BT_DBG("error %d", err);
> 
>                         /* FIXME: Map err to a valid reason. */
>                         rej.reason = __cpu_to_le16(0);
>                         l2cap_send_rsp(conn, cmd.ident, L2CAP_COMMAND_REJ, L2CAP_CMD_REJ_SIZE, &rej);
>                 }
> Reason is always set to 0.
> Test should not fail.

you are right. This test should not fail.

> >>         2.) TP/COS/CFD/BV-01: Tests that IUT is able to handle the receiving
> >> of more than one request for configuration of data channel. Tester sends
> >> L2CAP_Config Req with flag=1, IUT responds with flag=0. According to section
> >> 5.4 p.290 of the version 1.1 spec, "When used in the Configuration Response,
> >> the continuation flag must be set if the flag is set in the Request".
> >
> >This seems to be a bug in the current code. But I have to re-read the
> >L2CAP specification for the details.
> Easy.
> 
> --- 1.9/net/bluetooth/l2cap.c   Wed Apr 23 04:45:41 2003
> +++ edited/net/bluetooth/l2cap.c        Thu May  8 17:26:28 2003
> @@ -1320,15 +1320,18 @@
>  {
>         l2cap_conf_rsp *rsp = (l2cap_conf_rsp *) data;
>         void *ptr = rsp->data;
> +       u16 flags = 0;
>  
>         BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
>  
>         if (result)
>                 *result = l2cap_conf_output(sk, &ptr);
> +       else
> +               flags |= 0x0001;
>  
>         rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
>         rsp->result = __cpu_to_le16(result ? *result : 0);
> -       rsp->flags  = __cpu_to_le16(0);
> +       rsp->flags  = __cpu_to_le16(flags);
>  
>         return ptr - data;
> 
> I'll commit this to my BK.

Fine.

> >>         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform negotiation
> >> while the tester rejects the configuration of a data channel. The IUT sends
> >> a configuration request and the tester rejects it. The IUT should send
> >> another configuration request, but it does not.
> >
> >Currently the channel is closed if they reject our config request,
> >because we don't know how to proceed if they don't like our settings. We
> >can sent them again, but they will be rejected again. For this case I
> >also have to read the L2CAP in detail.
> Yeah we talked about that. Test is stupid. I'm not sure how to fix that without 
> affecting general logic. 

I put this to the last item on the list. At the moment I don't care, but
I will spent some time to look at it.

> >>         4.) TP/COS/RCO/BI-01, BI-02: These tests verify that the IUT
> >> performs a consistency check on the data. Both tests send two packets to the
> >> IUT. In each test, the first packet has a mistake. In BI-01 the first packet
> >> is too short by one byte, and in BI-02 the first packet is too long by one
> >> byte. In both cases the stack must correctly receive the second packet, but
> >> not the first. The data should be discarded in the case of the
> >> inconsistencies, and an error reported to the application.
> >
> >It seems that we can't handle this case complete correctly, if the data
> >was put only in one fragment. But in the basics this should work and the
> >malformed packets should be dropped. Did you have a detailed log of this
> >test which shows us byte by byte which request was sent?
> Hmm, how should we return error to the application. Most socket app close 
> the socket than read() returns error. i.e. Even if we fix the kernel to
> return some BT specific error, test will fail on other apps which will 
> simply close the socket.
> Also are those corrupted data packets or signaling packets ?
> If signalling we're not supposed to return error to all L2CAP apps are we ? ;-)

The test should pass if we correctly drop those wrong packets. But we
need to see how the test acts. We need a "hcidump -w <file>". 

> >> RFCOMM:
> >>       Note: Some of these comments don't apply to a specific test case
> >> (they are more general).
> >>         1.) Must not modify pbits in pn (parameter negotiation) response.
> >> The pbits are dependent on which DLC is being configured. Apparently this is
> >> a common problem, and one that has been argued about with the SIG because
> >> apparently nobody uses the bits - but the SIG would not give in (refer to
> >> erratum 364). They are specified in the TS GSM 07.10 630 spec, section
> >> 5.4.6.3.1.
> Yeah, we can fix that. We simply have to copy those bits into response.
> Another one of those useless rules.

I have fixed this already.

> >>         2.) TP/RFC/BV-07: Closing rfcomm doesn't appear to close l2cap. Is
> >> this true? This isn't actually required to pass this test, but it did
> >> confuse the tester. This may have been a mistake on my part. I just hit
> >> ctrl-c when rctest was connected and assumed that everything would get
> >> closed. Would calling close() have a different effect?
> >
> >This is working fine for me. After closing the channel, we close dlci 0
> >and this also closes the L2CAP connection.
> Yes. I'm 100% sure it works. rfcomm_session_del() kills L2CAP socket.

Can you remember if we had a problem with this in bluez-kernel-2.3 ?

> >>         5.) Once an RFCOMM channel is established, the IUT must exchange
> >> MSC's (modem status commands) before sending data. That is, it must send an
> >> MSC, wait for a response, wait for the sender's MSC, and respond to it
> >> before sending data. Our device sent an MSC and then immediately started
> >> sending data when we used rctest. This applies to many test cases.
> >
> >We send the MSC after the UA. But we also go into BT_CONNECTED state and
> >in this state you can also start sending data. We should maybe go from
> >BT_CONNECT -> BT_CONFIG and only switch to BT_CONNECTED after the
> >successful exchange of MSC.
> I remember thinking about that. But they way I interpreted spec was that we
> don't have to wait for MSC response. 
> This should be easy to fix.

I leave this up to you to fix.

> >>         6.) If a connecting device doesn't send a PN command with CL bits
> >> set to 0x0f, then it means it is not a 1.1 device and we must not use credit
> >> based flow control. In our case, when such a PN command was received, data
> >> was sent using credit based flow control but shouldn't have been. This
> >> applies to many test cases.
> I don't believe your testing software :).
> So you should check your tester app :).

I think we changed some code of the credit based flow control handling
from bluez-kernel-2.3 to the current state.

> btw When CFC is not enabled we will have to wait for MSC from the other side. Notice that we set
> THROTTLED flag in that case. Which is cleared by the MSC or more credits.
> So I guess we can just always set that flag and clear it when we get MSC which will fix the MSC 
> test case without messing with the state machine.

Sounds reasonable to me.

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
