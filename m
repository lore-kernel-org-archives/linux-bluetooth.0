Return-Path: <Steven.Singer@csr.com>
Message-ID: <3F83F423.7020406@csr.com>
Date: Wed, 08 Oct 2003 12:25:23 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Peter Bergmann <bergmann.peter@gmx.net>,
   BlueZ Mailing List
    <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
References: <1065171540.1734.97.camel@pegasus>
    <28385.1065174121@www39.gmx.net> <1065174943.1734.101.camel@pegasus>
    <3F7D5B72.1050900@csr.com> <1065443556.21958.39.camel@pegasus>
In-Reply-To: <1065443556.21958.39.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
 > Steven Singer wrote:
>>In theory it would be possible for BlueZ to detect that the rfcomm
>>link has gone quiet (a simple timer from the last packet sent or
>>received) and then automatically switch into sniff mode.  [...]
> 
> this idea is nice and it sounds like a useful feature. But it can't
> depend on the RFCOMM traffic. It must depend on the ACL traffic and the
> BlueZ core must handle it.

Yes, sorry. Of course it must depend on ACL traffic not RFCOMM. I
suspect the easiest way to do it is to advertise an ioctl for this
feature. I'm not quite sure what the interface should be, but I'm sure
you can think of something.

We're getting ahead of ourselves though. We need confirmation from Peter
that sniff helps the problem. If it doesn't we're wasting our time
(unless you think the feature is useful for other applications).

	- Steven
-- 



**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited.  
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************
