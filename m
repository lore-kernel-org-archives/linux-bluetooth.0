Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Slaves in Sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: tOpSy TuRvY <topsyturvy@nemo.student.utwente.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.BSO.4.58.0406231451130.835@nemo.student.utwente.nl>
References: <E1BcqIi-0002cT-53@sc8-sf-list2.sourceforge.net>
	 <Pine.BSO.4.58.0406222046050.9882@nemo.student.utwente.nl>
	 <1087939830.4209.12.camel@pegasus>
	 <Pine.BSO.4.58.0406222346200.5451@nemo.student.utwente.nl>
	 <1087942444.4209.45.camel@pegasus>
	 <Pine.BSO.4.58.0406231319140.20827@nemo.student.utwente.nl>
	 <1087992990.4209.79.camel@pegasus>
	 <Pine.BSO.4.58.0406231451130.835@nemo.student.utwente.nl>
Content-Type: text/plain
Message-Id: <1087997435.4209.104.camel@pegasus>
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
Date: Wed, 23 Jun 2004 15:30:35 +0200

Hi Assed,

> I'm wondering how the master can request an unsniff if the slave is not 
> listening to the channel.
> 
> I suppose the master should delay transmission till the next sniff window 
> starts (i.e. as Peter suggested). Of course I'm guessing that at this 
> point it could request an unsniff if the packet to be transmitted will 
> not fit the sniff window.

everything depends on the sniff window, but the HCI also defines an exit
sniff mode command. I don't know how this is implemented on link manager
level.

> p.s. I'm also wondering how you get the time to reply to everybodys 
> questions!

I do my best ;)

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
