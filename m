Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030514093233.0d4e2a28@unixmail.qualcomm.com>
Date: Wed, 14 May 2003 09:34:45 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000501c31a32$327c9be0$1a01010a@baked>
References: <1052872215.4608.44.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:02 AM 5/14/2003, Daryl Van Vorst wrote:
>Hey Marcel,
>
>> > L2CAP_LM_RELIABLE
>
>L2CAP_LM_RETENTIVE? ;) (Not sure if the slang meaning of that word comes
>through in other countries. The real meaning may not be appropriate.) Some
>others: intolerant, cautious.
I think 'reliable' is ok.

>> > Now we just need to add support for it in l2test.
>> 
>> Daryl, it is your test :)
>
>Cool. :)
>
>Another addition to l2test (and maybe rctest) that would be handy for
>testing is an option to specify how many packets to send. It would be nice
>to have the option of sending only a few packets rather than an infinite
>number. None of the tests that I've encountered so far require sending large
>amounts of data... Just a packet or two. For rfcomm testing I could probably
>just do an "rfcomm connect /dev/something etc.." and redirect something
>small to /dev/something if rctest is causing trouble.
Go for it. I mean l2test/rctest changes. And sent us a patch(es).

Max
