Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513161044.0d3063b0@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 16:11:42 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification - L2CA_DisconnectCfm
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052865860.4609.13.camel@pegasus.local>
References: <5.1.0.14.2.20030513105017.0d234df0@unixmail.qualcomm.com>
	<1052783343.1132.159.camel@pegasus.local>
	<5.1.0.14.2.20030513105017.0d234df0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:44 PM 5/13/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> What we need is SO_LINGER option support. Application doesn't care so much about
>> the disconnect itself but it does care if all the data that it had written to a 
>> socket has been sent.
>> i.e. 
>>         connect(sk);
>>         send(sk, stuff, sizeof(stuff));
>>         close(sk);
>> 
>> Some apps want close() to sleep until all data has been sent and connection was 
>> successfully closed.
>
>I never have tought about it before, but SO_LINGER support seems useful.
>And with this passing the test will be easy. Did using shutdown() for
>disabling sending and receiving works?
shutdown() == disconnect in L2CAP because we can't shutdown only on direction.
And yes it does work.

Max
