Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced05030321482f162db2@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net, sebastian.roth@esk.fhg.de
Subject: Re: Fw: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <004401c5207b$c13a3210$4100a8c0@benjamin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <004401c5207b$c13a3210$4100a8c0@benjamin>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 4 Mar 2005 11:18:23 +0530

Hi Sebastian,
                  I bought a new dongle, and now the send program is
working on two sides.
                  I am facing one more problem. The send program is
reading a character for PC keyboard using getch()
function,immediately, it establishes a connection using connect() and
then it sends the data. This is in a do-while loop to read and send
the continous key press. The problem is, I am not getting all the data
on the recv side, what i have typed on the send side. As for I know
the problem is due to delay in l2cap connection establishment. Is
there any way to avoid the delay? Kindly suggest me.

Thanks and regards,
Mohan



> > From: Sebastian Roth <sebastian.roth@esk.fhg.de>
> > Date: Thu, 24 Feb 2005 08:23:30 +0100
> > Subject: [Bluez-users] Re: Can't able to send data in both direction
> > To: bluez-users@lists.sourceforge.net
> >
> >
> > Hi Mohan,
> >
> > I'm sorry. I have not made this point clear!
> >
> >>                   Can you tell me whether the send program is working
> >> after making the device up using "hciconfig hci0 up" on the SiW dongle
> >> side?
> > Yes, after starting `hcid' (or using `hciconfig hci0 up') I was able to
> > connect and send data in both directions.
> >
> > Wugh? What's this? hciconfig shows a "Transilica, Inc." chip to me.
> > Don't know why but I thought that this dongle has a SiW chip in it.
> >
> > Are you able to send data using another programm? Please try l2ping to
> > see if both directions work.
> >
> > Best regards,
> > Sebastian
> >
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> > --
> > This message contains information from GDA Technologies LTD  and
> > affiliates, and is intended for the sole use of the individual and entity
> > to whom it is addressed. It may contain information, including any
> > attachments, that is privileged, confidential and exempt from disclosure
> > under applicable law. If you are not the intended addressee, nor
> > authorized to receive for the intended addressee, you are hereby notified
> > that you may not use, copy, disclose or distribute to anyone the message
> > or any information contained in the message. If you have received this
> > electronic transmission in error, please notify the sender immediately by
> > a "reply to sender only" message and destroy all electronic and hard
> > copies of the communication, including attachments.
> > This message was scanned for spam and viruses by BitDefender.
> >
> >
> 
> --
> This message contains information from GDA Technologies LTD  and affiliates, and is intended for the sole use of the individual and entity to whom it is addressed. It may contain information, including any attachments, that is privileged, confidential and exempt from disclosure under applicable law. If you are not the intended addressee, nor authorized to receive for the intended addressee, you are hereby notified that you may not use, copy, disclose or distribute to anyone the message or any information contained in the message. If you have received this electronic transmission in error, please notify the sender immediately by a "reply to sender only" message and destroy all electronic and hard copies of the communication, including attachments.
> This message was scanned for spam and viruses by BitDefender.
> 
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
