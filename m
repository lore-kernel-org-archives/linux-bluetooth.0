Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: Albert Huang <ashuang@gmail.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040630014836.GI15948@hp.com>
References: <ef9938ec040628194321db5d9c@mail.gmail.com>
	 <20040629043356.GK20139@hp.com> <1088545055.6030.339.camel@pegasus>
	 <20040630014836.GI15948@hp.com>
Content-Type: text/plain
Message-Id: <1088586574.22940.13.camel@pegasus>
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
Date: Wed, 30 Jun 2004 11:09:34 +0200

Hi James,

> > > You could certainly fork() a process to exec() hcitool, and when it
> > > finishes it could send the information to your program, through a pipe
> > > that your program is select()ing on, or something similar.
> > 
> > very bad idea :(
> 
> Aww, it's just another way to do it, that doesn't require as much
> dependency or learning.  ;-)

It is not fork() that is bad. It the combination of exec() and hcitool
you propose to use. If you fork or use a thread then use hci_inquiry().

> > You don't looked into the details. The inquiry ioctl() is one way. The
> > other one is the HCI raw socket. Open and bind a device and then set an
> > event filter on it. Send an inquiry command according to the spec. and
> > listen for the incoming inquiry result events.
> 
> I stand corrected.
> 
> Albert, there is a good example of this in src/btctl-discovery-source.c
> in the libbtctl-0.4.1 package.
> http://usefulinc.com/software/gnome-bluetooth/
> 
> btctl_discovery_source_new()
> The hci device is opened, then set O_NONBLOCK, and the event filters are
> set.  There's no sign of binding.

If you use hci_open_dev() the binding is done by that call.

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
