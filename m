Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030724103726.099c2978@unixmail.qualcomm.com>
Date: Thu, 24 Jul 2003 10:38:23 -0700
To: Stephen Crane <steve.crane@rococosoft.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] EBADFD on RFComm connect
Cc: bluez-devel@lists.sourceforge.net, marcel@rvs.uni-bielefeld.de
In-Reply-To: <1059055794.9806.43.camel@baroque.rococosoft.com>
References: <5.1.0.14.2.20030722172712.098034f8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030722172712.098034f8@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 07:09 AM 7/24/2003, Stephen Crane wrote:
>On Wed, 2003-07-23 at 01:33, Max Krasnyansky wrote:
>
>> You can not do this
>>         while (0 > connect(s, (struct sockaddr *)&addr, sizeof(addr)))
>>                if (errno != EBUSY) {
>>                    perror("connect");
>>                    return -1;
>>                }
>> 
>> If connect returns EBUSY error you have to close() the socket. And it does
>> indeed return EBUSY in your case (I ran the progs) because close() is asynchronous
>> and that channel still exist (two connections on the same channel are not allowed 
>> in RFCOMM). What you can do to avoid that error is to enable SO_LINGER option on that
>> socket, in which case close() will be synchronous. 
>
>Thanks Max. That's fixed it. Another one for the programming manual?
Yep.

Max
