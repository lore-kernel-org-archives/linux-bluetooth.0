Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
From: Marcel Holtmann <marcel@holtmann.org>
To: nicolas <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200406242015.13230.n1c0l4s.l3@wanadoo.fr>
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr>
	 <200406241932.24780.n1c0l4s.l3@wanadoo.fr>
	 <1088098323.4296.68.camel@pegasus>
	 <200406242015.13230.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1088106990.4296.131.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Jun 2004 21:56:30 +0200

Hi Nicolas,

> > > if i enter Hidd --server  the console    tell me:
> > >
> > > # hidd --server
> > > Can't listen on HID control channel: Address already in use
> >
> > then there is already one server running on that PSM. Check with ps what
> > daemons you use.
> >
> 
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> nicolas   4344  0.0  3.1 22748 8128 ?        S    02:07   0:01 kdeinit: dcopserver --nosid
> nicolas   4397  0.0  5.0 26560 12856 ?       S    02:08   0:05 kbluetoothd --dontforceshow
> 
> is kdeinit: dcopserver --nosid   my "ghost" deamon ?

there must be something like hcid and hidd.

> And sometimes if i put out the batteries and i put on all work well whereas  pressing mouse button gives no result

I have no answer for that. Here everything works perfect. May I asked
that already. Is role switch and sniff link policy activated?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
