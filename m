Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Printing (Belkin Print Server)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041123091654.GB16952@suse.de>
References: <41A2089D.5030100@phaldor.co.uk>
	 <1101139759.15086.14.camel@pegasus> <41A21EE3.5060408@phaldor.co.uk>
	 <20041123091654.GB16952@suse.de>
Content-Type: text/plain
Message-Id: <1101202810.26578.61.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 23 Nov 2004 10:40:10 +0100

Hi Stefan,

> >    I have tried that via the web page and the KDE Print manager. It 
> > still does not work. The blue light on the print server flashes wildly 
> > for ever, but nothing prints. The same result is obtained by clicking on 
> 
> Since you are using Suse, have you tried to configure it using Yast?
> Printing via BT worked fine for me after configuring it with Yast. Never
> tried the KDE Printmanager, so I can't say much about that.
> (Which webpage are you refering to,btw.?)

the webpage should be localhost:631 and I always configured my printers
this way.

> The flashing ligth looks to me like the printer is receiving data, but the
> printer is not understanding it. Otoh I might be wrong :)
> I would suggest to configure the pritner with Yast, and set the correct
> printer there. 

I also think that maybe the printer settings are wrong, because actually
the Bluetooth CUPS backend is quite dump and it is only a transport.

However if this device is still not working I need one of these to check
by myself what is going wrong.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
