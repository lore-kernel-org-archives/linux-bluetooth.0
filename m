Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722172712.098034f8@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 17:33:15 -0700
To: Stephen Crane <steve.crane@rococosoft.com>, bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] EBADFD on RFComm connect
Cc: marcel@rvs.uni-bielefeld.de
In-Reply-To: <1058880571.1670.425.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 06:29 AM 7/22/2003, Stephen Crane wrote:
>Hi Max, Marcel,
>Under what circumstances can connect() return EBADFD?
>
>I have a couple of programs (attached) one of which opens a listening
>socket and accepts 32 connections. The other loops attempting 32
>connections to the same channel. On the second connection connect()
>always fails with EBADFD. (If I leave in the 0.5 second delay it all
>works fine.)

You can not do this
        while (0 > connect(s, (struct sockaddr *)&addr, sizeof(addr)))
               if (errno != EBUSY) {
                   perror("connect");
                   return -1;
               }

If connect returns EBUSY error you have to close() the socket. And it does
indeed return EBUSY in your case (I ran the progs) because close() is asynchronous
and that channel still exist (two connections on the same channel are not allowed 
in RFCOMM). What you can do to avoid that error is to enable SO_LINGER option on that
socket, in which case close() will be synchronous. 

Max
 
