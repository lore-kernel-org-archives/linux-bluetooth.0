Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] avdtp over l2cap
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030820195027.49462.qmail@web10203.mail.yahoo.com>
References: <20030820195027.49462.qmail@web10203.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1061411813.10680.127.camel@pegasus>
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
Date: 20 Aug 2003 22:36:36 +0200

Hi Aarti,

> So you suggest that i can have the implementation of
> audio video tranport protocol in the userspace itself.
> This means that i dont need to have socket ineterface
> for audio video distribution protocol , instead i will
> have the program which will be using l2cap sockets and
> forming a connection between two devices.
> 
> What i think is audio video tranfer protocol should be
> implemented as module (like bnep, rfcomm and sco) and
> regisered in bluetooth stack. The profile development
> or the application using this will be in userspace
> (like pand and sdp).

take another deep look into the AVDTP spec. and you will see that it
adopts the two major protocols RTP and RTCP. The TCP/IP implementation
of both protocols fits perfect into userspace and so should AVDTP do as
well. The AVDTP has not to interact with any other kernel subsystems and
so there is no need to put it into the kernel.

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
