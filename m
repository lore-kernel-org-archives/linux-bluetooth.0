Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: adding sdp service record attributes
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20050318T140410-908@post.gmane.org>
References: <20050318104405.27323.qmail@web60903.mail.yahoo.com>
	 <loom.20050318T140410-908@post.gmane.org>
Content-Type: text/plain
Message-Id: <1111160030.9600.18.camel@pegasus>
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
Date: Fri, 18 Mar 2005 16:33:50 +0100

Hi Andreas,

> > 1.Is there any extra thing I have to put so that the
> > service record and attributes are set in my PC
> > permanently and not being erased after reboot?
> 
> Small shell script ?

there is no shell script needed, because if you wanna run a server then
you need to write a program (and start it) that fulfils this job. The
same program can create the SDP record when it starts.

> > 2.After I add the service record and attribute, I wish
> > to let T610 to search my PC as headset. So, is there
> > any extra thing that I have to put in my code?
> 
> I guess you has to change your device class of your BT-device to phone. Please 
> have a look into the hcid config file.

You must set yourself to the headset class of device (0x200404).

> > 3.Is it possible that to browse the services in T610,
> > and even other mobile devices, and then add the
> > service records and attributes automatically?
> 
> Where? In our own SDP database? What would you like to reach with those?

No it is not possible and it also makes no sense at all.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
