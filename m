Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Thu, 12 Jun 2003 11:49:55 -0700
Message-ID: <000c01c33113$6aaf0320$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
In-Reply-To: <5.1.0.14.2.20030612102711.0b283180@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> If an application does not explicitly tell us that it 
> supports larger MTU then it does not support it. As simple as 
> that :). We don't play "guess what MTU I support" games ;-). 

Yup.

> Sure we can make a hack. Once we agree on how should we 
> handle it I'll make 
> the change. But if the hack affects general case we're not 
> going to put it 
> into official kernel.

Of course. :)

> >Apparently, in step 3 above, if we send a config request with no 
> >options it will also pass the test. How silly is that? (specially 
> >considering that's what we send by default in the first place!)
> I'm pretty sure that it's just because they use some dumb 
> tester implementation. It doesn't make sense to resend the 
> same config request.

It's actually written that way in the test case. Here's a quote from the
updated test case (errata correction ID 241):

"Pass Verdict: The IUT sends an L2CAP_ConfigReq with acceptable values
received in the L2CAP_ConfigRsp with Result = Failure - unacceptable
parameters, or the L2CAP_ConfigReq contains no options."

-Daryl.
