Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT_ADDR Address Resolution
From: Marcel Holtmann <marcel@holtmann.org>
To: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.BSO.4.58.0406241437430.23390@nemo.student.utwente.nl>
References: <200406241009.i5OA9wFo030305@news01.csr.com>
	 <Pine.BSO.4.58.0406241335110.23949@nemo.student.utwente.nl>
	 <1088078815.4296.55.camel@pegasus>
	 <Pine.BSO.4.58.0406241408110.8407@nemo.student.utwente.nl>
	 <1088080317.4296.59.camel@pegasus>
	 <Pine.BSO.4.58.0406241437430.23390@nemo.student.utwente.nl>
Content-Type: text/plain
Message-Id: <1088081650.4296.63.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 24 Jun 2004 14:54:10 +0200

Hi Assed,

> > the Linux PAN is a point-to-point connection. If you want to build a NAP
> > or GN you must also use the Linux bridge. So this is not a PAN question,
> > this depends on how you configured your bridge.
> 
> You are right, it was a bridge question. I think it would be fair to 
> assume that the bridge is going to forward all broadcast traffic it 
> recieves on all the ports (except the one it came on).

depends on your bridge configuration ;)

> > No Bluetooth broadcast is used. Read the BNEP and PAN specifications.
> 
> Read those and tried to understand them. What I gathered is that there 
> will be one Bluetooth broadcast sent to each of the connected PANUs. i.e. 
> one Bluetooth broadcast sent on each bridge port, and that seems very 
> wasteful since just one bluetooth broadcast on any port would have been 
> recieved by all the PANUs right?

Bluetooth PAN is point-to-point. It is like that you replace the CAT-5
cable between your machine and the switch with a Bluetooth connection.
Everything else is then TCP/IP specific.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
