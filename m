Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] avdtp over l2cap
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030820162035.11754.qmail@web10204.mail.yahoo.com>
References: <20030820162035.11754.qmail@web10204.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1061397856.10680.100.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 20 Aug 2003 18:44:10 +0200

Hi Aarti,

> I am trying place avdtp layer over l2cap layer with
> the existing bluez stack.
> I have just come up with basic socket implementation
> for avdtp. 
> I am not sure whether existing l2cap layer supports
> avdp, and whether i need to make any changes to it. As
> far as i could understand all the layers above l2cap
> have there psm set, and l2cap layer is not aware of
> these values. 
> I understand the BTPROTO has been defined for
> l2cap,rfcomm,bnep, sco from 0-4 and while registering
> it checks for the value less than 5, so if need to
> register avdtp as BTPROTO_AVDTP 5 , i have to modify
> the condition.
> What else do i need to do , so that i can send and
> receive messages through avdtp sockets ? 
> Also I am not sure about the Socket Option level
> (SOL_AVDTP) value for AVDTP ?
> I quite new to this kernel programming stuff , so
> pardon me if my question is too naive .

some time ago I also looked at the AVDTP and you don't need to write a
kernel module for it. It can be done in userspace like SDP, OBEX, HCRP
etc.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
