Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] EBADFD on RFComm connect
From: Stephen Crane <steve.crane@rococosoft.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net, marcel@rvs.uni-bielefeld.de
In-Reply-To: <5.1.0.14.2.20030722172712.098034f8@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030722172712.098034f8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1059055794.9806.43.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: 24 Jul 2003 15:09:54 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2003-07-23 at 01:33, Max Krasnyansky wrote:

> You can not do this
>         while (0 > connect(s, (struct sockaddr *)&addr, sizeof(addr)))
>                if (errno != EBUSY) {
>                    perror("connect");
>                    return -1;
>                }
> 
> If connect returns EBUSY error you have to close() the socket. And it does
> indeed return EBUSY in your case (I ran the progs) because close() is asynchronous
> and that channel still exist (two connections on the same channel are not allowed 
> in RFCOMM). What you can do to avoid that error is to enable SO_LINGER option on that
> socket, in which case close() will be synchronous. 

Thanks Max. That's fixed it. Another one for the programming manual?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
