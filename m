Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030612120846.0ba3b5c8@unixmail.qualcomm.com>
Date: Thu, 12 Jun 2003 12:11:32 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c33113$6aaf0320$1a01010a@baked>
References: <5.1.0.14.2.20030612102711.0b283180@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 11:49 AM 6/12/2003, Daryl Van Vorst wrote:
>> >Apparently, in step 3 above, if we send a config request with no 
>> >options it will also pass the test. How silly is that? (specially 
>> >considering that's what we send by default in the first place!)
>> I'm pretty sure that it's just because they use some dumb 
>> tester implementation. It doesn't make sense to resend the 
>> same config request.
>
>It's actually written that way in the test case. Here's a quote from the
>updated test case (errata correction ID 241):
>
>"Pass Verdict: The IUT sends an L2CAP_ConfigReq with acceptable values
>received in the L2CAP_ConfigRsp with Result = Failure - unacceptable
>parameters, or the L2CAP_ConfigReq contains no options."
Consider it done then :). Sounds like this will be useful for other folks
to pass qualification. I'll put it in.

Max
