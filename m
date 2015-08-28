Return-Path: <cyrus@holtmann.org>
Message-ID: <55E073DF.4040900@convergeddevices.net>
Date: Fri, 28 Aug 2015 15:44:47 +0100
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: SEC SEM BV 09, MITM + No Bonding
References: <55D4834E.9080705@convergeddevices.net> <20150819162319.GA16000@t440s.P-661HNU-F1>
In-Reply-To: <20150819162319.GA16000@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 19/08/15 17:23, Johan Hedberg wrote:
> Hi Tony,
>
> On Wed, Aug 19, 2015, tony wrote:
>> Can somebody please advise on how to force blueZ to initiate connection with
>> authentication requirement 1 (MITM required + No Bonding)? From the blueZ
>> code, I noticed it follows lead from the remote device. But couldn't find
>> anything obvious when initiating connection.
>
> IIRC you do this by setting HIGH or FIPS security level together with
> PSM 1 (SDP). l2cap_get_auth_type() in net/bluetooth/l2cap_core.c seems
> to indicate that is will give no bonding + MITM.
>
> Johan
>
Thank you Johan.

For anyone who comes here looking for SEC SEM BV 09, following worked.
"l2test -n -P 1 -E"  (unauthenticated link).
"l2test -n -P 1 -S"  (authenticate link, make sure simple-agent is 
running to manage MITM).

Tony
