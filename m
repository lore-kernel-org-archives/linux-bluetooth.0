Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 8 May 2003 11:11:45 -0700
Message-ID: <000801c3158d$497da950$5796fea9@baked>
MIME-Version: 1.0
In-Reply-To: <1052401433.2669.93.camel@pegasus.local>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hey Marcel,

Thanks for your response!

It'll take me a bit of time to gather all of the logs. I'll send them to yo=
u
as I get them. The logs are a bit lengthy, so I'll send them directly to yo=
u
instead of the list.

My comments are inserted below.

> Can you tell us a little bit more about your product, because=20
> I can't find enough details on the website.

The product hasn't been released yet, so I can't publicly discuss too much.
We could talk a bit off-list about it if you'd like.

> The biggest problem in this test case is the=20
> bluez-kernel-2.3, because it is too much outdated. You should=20
> better use one of -mh patches or try to build a new=20
> bluez-kernel package from the kernel scripts that I have put=20
> into CVS. The bluez-libs-2.3 shouldn't make any problems, but=20
> it is a good idea to update to bluez-sdp-1.1.

Yeah, I figured.  It took a bit of work, but I now have a 2.4.18 kernel up
to mh4 (the latest on your site).

> The L2CAP and RFCOMM part is kernel specific and it is a good=20
> idea to do the qualification tests with the an up-to-date=20
> kernel, because in this case it is easier to look at the=20
> problems and fix them.

Yup. From here on it will be done on an up-to-date kernel (Is 2.4.18 with
your most recent patch level considered up-to-date? Moving to 2.4.20 would
be a major hassle). I would have done that earlier, but I didn't realize ho=
w
outdated the bluez-kernel package was until it was too late.

> > L2CAP:
> >         1.) TP/COS/CED/BI-01: Verifies that the IUT rejects=20
> an unkown=20
> > signalling command. The tester sends an unkown L2CAP=20
> command. The IUT=20
> > should respond with an L2CAP_Reject with reason 0 "Command not=20
> > understood". The IUT did not.
>=20
> We have a fixme for this in the l2cap.c code, but currently=20
> no code exists. Should be easy to fix, but nobody cares about it.

Heh heh. I care! ;)  Are you going to take a look at that?  I could have a
look, but it might take me a while to figure it out.

> >         2.) TP/COS/CFD/BV-01: Tests that IUT is able to handle the=20
> > receiving of more than one request for configuration of=20
> data channel.=20
> > Tester sends L2CAP_Config Req with flag=3D1, IUT responds=20
> with flag=3D0.=20
> > According to section 5.4 p.290 of the version 1.1 spec,=20
> "When used in=20
> > the Configuration Response, the continuation flag must be=20
> set if the=20
> > flag is set in the Request".
>=20
> This seems to be a bug in the current code. But I have to=20
> re-read the L2CAP specification for the details.

It might also help to take a look at the test cases, which are free to
download. But, as with everything bluetooth, if you want all the details yo=
u
have to pay. ;)

> >         3.) TP/COS/CFD/BV-02: Tests that IUT is able to perform=20
> > negotiation while the tester rejects the configuration of a data=20
> > channel. The IUT sends a configuration request and the=20
> tester rejects=20
> > it. The IUT should send another configuration request, but it does=20
> > not.
>=20
> Currently the channel is closed if they reject our config=20
> request, because we don't know how to proceed if they don't=20
> like our settings. We can sent them again, but they will be=20
> rejected again. For this case I also have to read the L2CAP in detail.

Yeah, it seemed a bit odd to me too. But that's what the test case tests.
I'll get some clarification on this one.

> >         4.) TP/COS/RCO/BI-01, BI-02: These tests verify=20
> that the IUT=20
> > performs a consistency check on the data. Both tests send=20
> two packets=20
> > to the IUT. In each test, the first packet has a mistake.=20
> In BI-01 the=20
> > first packet is too short by one byte, and in BI-02 the=20
> first packet=20
> > is too long by one byte. In both cases the stack must correctly=20
> > receive the second packet, but not the first. The data should be=20
> > discarded in the case of the inconsistencies, and an error=20
> reported to=20
> > the application.
>=20
> It seems that we can't handle this case complete correctly,=20
> if the data was put only in one fragment. But in the basics=20
> this should work and the malformed packets should be dropped.=20
> Did you have a detailed log of this test which shows us byte=20
> by byte which request was sent?

Yeah. I should have an HCI dump for both cases. I'll send them to you right
after this.

> > RFCOMM:
> > 	Note: Some of these comments don't apply to a specific=20
> test case=20
> > (they are more general).
> >         1.) Must not modify pbits in pn (parameter negotiation)=20
> > response. The pbits are dependent on which DLC is being configured.=20
> > Apparently this is a common problem, and one that has been argued=20
> > about with the SIG because apparently nobody uses the bits=20
> - but the=20
> > SIG would not give in (refer to erratum 364). They are specified in=20
> > the TS GSM 07.10 630 spec, section 5.4.6.3.1.
>=20
> I am little bit confused, because I thought that the P/F bit=20
> in a UIH packet response on dlci 0 should always be zero. The=20
> only case where the P/F bit is set should be with credit=20
> based flow control. I will check the specification. Can you=20
> send me the erratum 364?

I should have been more clear. By pbits I meant priority bits, not the P/F
bit. I don't have a copy of the 07.10 630 spec, so I can't look up the
details. Do you have a copy? Anyway, the priority bits are set to a certain
value depending on which DLC you are using. I'm pretty sure that for DLC 0
they should be set to 0. For DLC's 1 through 7, I think they are set to 7.
Beyond that I don't remember. I'll see what I can do about getting a copy o=
f
the erratum 364...  But I'm pretty sure there aren't any interesting detail=
s
in it, just people complaining that the bits are pointless. The TS GSM 07.1=
0
630 spec is where the details are.

> >         2.) TP/RFC/BV-07: Closing rfcomm doesn't appear to close=20
> > l2cap. Is this true? This isn't actually required to pass=20
> this test,=20
> > but it did confuse the tester. This may have been a mistake on my=20
> > part. I just hit ctrl-c when rctest was connected and assumed that=20
> > everything would get closed. Would calling close() have a different=20
> > effect?
>=20
> This is working fine for me. After closing the channel, we=20
> close dlci 0 and this also closes the L2CAP connection.

I can retry it with the new kernel modules.

> >         3.) TP/RFC/BV-13-C: Verifies that the IUT responds=20
> to a Remote=20
> > Line Status command from the tester. When the remote line status=20
> > command is received, the remote device must respond with a=20
> remote line=20
> > status response. We responded with NSC (not supported=20
> command) instead=20
> > of RLS response.
>=20
> I have fixed this in patch-2.4.20-mh7 and it is in the not=20
> released 2.4.21-rc2 mainstream kernel.

Great!  Is that also in patch-2.4.18-mh4?

> >         4.) TP/RFC/BV-17-C: RFCOMM Parameter Negotiation: RFCOMM=20
> > doesn't respond with desired parameters in RPN response (it=20
> responds=20
> > with 0's). I took a quick look at the RFCOMM code (our=20
> older version)=20
> > and it's apparent that variables are being set with the=20
> desired values=20
> > when the tester requests values that we don't like, but those=20
> > variables are not the ones that are actually sent in the=20
> response. The=20
> > parameter mask is set correctly though.
>=20
> Please enable RFCOMM debug output and send us the request=20
> that the Tester performs.

It'll take a bit of work to accomplish that because testing is being done
remotely... But if we need to do it, we can.

As a first step I'll send you an e-mail with the snippet of code I'm talkin=
g
about and point out what I think the problem is. And when I get tester logs
I'll send them too.

> >         5.) Once an RFCOMM channel is established, the IUT must=20
> > exchange MSC's (modem status commands) before sending data.=20
> That is,=20
> > it must send an MSC, wait for a response, wait for the=20
> sender's MSC,=20
> > and respond to it before sending data. Our device sent an=20
> MSC and then=20
> > immediately started sending data when we used rctest. This=20
> applies to=20
> > many test cases.
>=20
> We send the MSC after the UA. But we also go into=20
> BT_CONNECTED state and in this state you can also start=20
> sending data. We should maybe go from BT_CONNECT -> BT_CONFIG=20
> and only switch to BT_CONNECTED after the successful exchange of MSC.

That sounds good to me. Not sure about the UA though... I'll check on it.

> >         6.) If a connecting device doesn't send a PN=20
> command with CL=20
> > bits set to 0x0f, then it means it is not a 1.1 device and=20
> we must not=20
> > use credit based flow control. In our case, when such a PN=20
> command was=20
> > received, data was sent using credit based flow control but=20
> shouldn't=20
> > have been. This applies to many test cases.
>=20
> This should not happen, because the current RFCOMM code can=20
> deal with 1.0b and 1.1 devices correctly. Please check this=20
> with latest RFCOMM code and send us the detailed log of this problem.

Ok... I'll try it out with the new kernel modules.

-Daryl.
