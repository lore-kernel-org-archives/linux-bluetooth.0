Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced05030404572b157616@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: Fw: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <1109933262.8058.21.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <004401c5207b$c13a3210$4100a8c0@benjamin>
	 <7aa80ced05030321482f162db2@mail.gmail.com>
	 <1109933262.8058.21.camel@pegasus>
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
Date: Fri, 4 Mar 2005 18:27:31 +0530

Hi Marcel,
              Thanks for your suggestion. I tried by keeping the
connection open. On the receiving side I am using recv() function.
Immediately after recv() function I want to print the data. The
problem I am facing is, it prints the received data only after
disconnecting the connection on the sending side with close(). For
that time the data is available in the buffer. Whether I want to
multithread the recveive portion, sothat I can dispay the data
immediately after receiving? Is there any other bluez command to
receive the data?

Thanks & Regards
Mohan


On Fri, 04 Mar 2005 11:47:42 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mohan,
> 
> >                   I bought a new dongle, and now the send program is
> > working on two sides.
> >                   I am facing one more problem. The send program is
> > reading a character for PC keyboard using getch()
> > function,immediately, it establishes a connection using connect() and
> > then it sends the data. This is in a do-while loop to read and send
> > the continous key press. The problem is, I am not getting all the data
> > on the recv side, what i have typed on the send side. As for I know
> > the problem is due to delay in l2cap connection establishment. Is
> > there any way to avoid the delay? Kindly suggest me.
> 
> you must keep the connection open.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
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
