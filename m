Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 phone & logitech DiNovo keyboard /
	MX900 mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102727487.6653.6.camel@localhost>
References: <1102035154.4258.14.camel@localhost>
	 <1102042749.7350.33.camel@pegasus>  <1102291223.4219.3.camel@localhost>
	 <1102315314.8510.57.camel@pegasus>  <1102639996.4112.10.camel@localhost>
	 <1102666379.11207.2.camel@pegasus>  <1102727487.6653.6.camel@localhost>
Content-Type: text/plain
Message-Id: <1102756324.19086.6.camel@pegasus>
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
Date: Sat, 11 Dec 2004 10:12:04 +0100

Hi Laurence,

> > > Yes hidd --server --search
> > 
> > no, only "hidd --server". The search option is only for the first
> > connection.
> > 
> > > run at boot S26hidd in rc5.d
> > > after S25bluetooth
> > 
> > There is a nice init script in bluez-utils that does this all for you
> > and with Fedore Core 3 this should be all in place and you only need to
> > activate it somewhere. Maybe /etc/default/ or so.
> > 
> 
>  I took out the --server option,but it still isn't working.
> it displays the following message during boot:-
> 'Can't open RFCOMM console socket: address family not supported by
> protocol'

didn't I said that you should use "hidd --server" and leave out the
"--search" option.

The RFCOMM error message has nothing do to with HID and if the modules
don't get loaded then some module aliases are missing or wrong. Check
the modules-init-tools packages.

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
