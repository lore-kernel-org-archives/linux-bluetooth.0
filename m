Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 9 May 2003 11:11:45 -0700
Message-ID: <000301c31656$73bb2930$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <1052442873.1069.35.camel@pegasus.local>
Content-Type: text/plain; CHARSET=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Max, Marcel,

> > >>         1.) TP/COS/CED/BI-01: Verifies that the IUT rejects an 
> > >> unkown signalling command. The tester sends an unkown L2CAP 
> > >> command. The IUT should respond with an L2CAP_Reject 
> with reason 0 
> > >> "Command not understood". The IUT did not.
> > >
> > >We have a fixme for this in the l2cap.c code, but 
> currently no code 
> > >exists. Should be easy to fix, but nobody cares about it.
> > Hold on. That's exactly what we do
> >                 if (err) {
> >                         l2cap_cmd_rej rej;
> >                         BT_DBG("error %d", err);
> > 
> >                         /* FIXME: Map err to a valid reason. */
> >                         rej.reason = __cpu_to_le16(0);
> >                         l2cap_send_rsp(conn, cmd.ident, 
> L2CAP_COMMAND_REJ, L2CAP_CMD_REJ_SIZE, &rej);
> >                 }
> > Reason is always set to 0.
> > Test should not fail.
> 
> you are right. This test should not fail.

Ok. That could have been something else going wrong then.  When I get the
detailed logs I'll look through them closely. If it still appears that
something's wrong with the stack, I'll forward the details.

> > >>         2.) TP/COS/CFD/BV-01: Tests that IUT is able to 
> handle the 
> > >> receiving of more than one request for configuration of data 
> > >> channel. Tester sends L2CAP_Config Req with flag=1, IUT responds 
> > >> with flag=0. According to section 5.4 p.290 of the version 1.1 
> > >> spec, "When used in the Configuration Response, the continuation 
> > >> flag must be set if the flag is set in the Request".
> > >
> > >This seems to be a bug in the current code. But I have to 
> re-read the 
> > >L2CAP specification for the details.
> > Easy.
> > 
> > --- 1.9/net/bluetooth/l2cap.c   Wed Apr 23 04:45:41 2003
> > +++ edited/net/bluetooth/l2cap.c        Thu May  8 17:26:28 2003
> > @@ -1320,15 +1320,18 @@
> >  {
> >         l2cap_conf_rsp *rsp = (l2cap_conf_rsp *) data;
> >         void *ptr = rsp->data;
> > +       u16 flags = 0;
> >  
> >         BT_DBG("sk %p complete %d", sk, result ? 1 : 0);
> >  
> >         if (result)
> >                 *result = l2cap_conf_output(sk, &ptr);
> > +       else
> > +               flags |= 0x0001;
> >  
> >         rsp->scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
> >         rsp->result = __cpu_to_le16(result ? *result : 0);
> > -       rsp->flags  = __cpu_to_le16(0);
> > +       rsp->flags  = __cpu_to_le16(flags);
> >  
> >         return ptr - data;
> > 
> > I'll commit this to my BK.
> 
> Fine.

Thanks guys. :)
 
> > >>         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform 
> > >> negotiation while the tester rejects the configuration of a data 
> > >> channel. The IUT sends a configuration request and the tester 
> > >> rejects it. The IUT should send another configuration 
> request, but 
> > >> it does not.
> > >
> > >Currently the channel is closed if they reject our config request, 
> > >because we don't know how to proceed if they don't like 
> our settings. 
> > >We can sent them again, but they will be rejected again. For this 
> > >case I also have to read the L2CAP in detail.
> > Yeah we talked about that. Test is stupid. I'm not sure how to fix 
> > that without
> > affecting general logic. 
> 
> I put this to the last item on the list. At the moment I 
> don't care, but I will spent some time to look at it.

Not sure if you saw a slightly more recent post from me.  The test isn't
quite as stupid as it seems. When the tester rejects the config request, it
gives desired configuration values inside that response. We're supposed to
return those values in the next config request (providing we like them well
enough). It'll accept those values. This behaviour makes sense to me now.
Thoughts?

> > >>         4.) TP/COS/RCO/BI-01, BI-02: These tests verify that the 
> > >> IUT performs a consistency check on the data. Both tests 
> send two 
> > >> packets to the IUT. In each test, the first packet has a 
> mistake. 
> > >> In BI-01 the first packet is too short by one byte, and in BI-02 
> > >> the first packet is too long by one byte. In both cases 
> the stack 
> > >> must correctly receive the second packet, but not the first. The 
> > >> data should be discarded in the case of the 
> inconsistencies, and an 
> > >> error reported to the application.
> > >
> > >It seems that we can't handle this case complete correctly, if the 
> > >data was put only in one fragment. But in the basics this 
> should work 
> > >and the malformed packets should be dropped. Did you have 
> a detailed 
> > >log of this test which shows us byte by byte which request 
> was sent?
> > Hmm, how should we return error to the application. Most socket app 
> > close
> > the socket than read() returns error. i.e. Even if we fix 
> the kernel to
> > return some BT specific error, test will fail on other apps 
> which will 
> > simply close the socket.
> > Also are those corrupted data packets or signaling packets ?
> > If signalling we're not supposed to return error to all 
> L2CAP apps are we ? ;-)
> 
> The test should pass if we correctly drop those wrong 
> packets. But we need to see how the test acts. We need a 
> "hcidump -w <file>". 

I sent a raw HCI dump for the two test cases in another message to the list
yesterday. Is that enough information?

-Daryl.
