Return-Path: <akmr2000@yahoo.com>
Message-ID: <20030820162035.11754.qmail@web10204.mail.yahoo.com>
Date: Wed, 20 Aug 2003 09:20:35 -0700 (PDT)
From: Aarti Kumar <akmr2000@yahoo.com>
Subject: [Bluez-devel] avdtp over l2cap
To: marcel@rvs.uni-bielefeld.de
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1061384470.10494.48.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>


I am trying place avdtp layer over l2cap layer with
the existing bluez stack.
I have just come up with basic socket implementation
for avdtp. 
I am not sure whether existing l2cap layer supports
avdp, and whether i need to make any changes to it. As
far as i could understand all the layers above l2cap
have there psm set, and l2cap layer is not aware of
these values. 
I understand the BTPROTO has been defined for
l2cap,rfcomm,bnep, sco from 0-4 and while registering
it checks for the value less than 5, so if need to
register avdtp as BTPROTO_AVDTP 5 , i have to modify
the condition.
What else do i need to do , so that i can send and
receive messages through avdtp sockets ? 
Also I am not sure about the Socket Option level
(SOL_AVDTP) value for AVDTP ?
I quite new to this kernel programming stuff , so
pardon me if my question is too naive .

Thanks,
Aarti.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
