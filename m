Return-Path: <james.cameron@hp.com>
Date: Wed, 30 Jun 2004 11:48:36 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Albert Huang <ashuang@gmail.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
Message-ID: <20040630014836.GI15948@hp.com>
References: <ef9938ec040628194321db5d9c@mail.gmail.com> <20040629043356.GK20139@hp.com> <1088545055.6030.339.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088545055.6030.339.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Jun 29, 2004 at 11:37:35PM +0200, Marcel Holtmann wrote:
> James wrote:
> > You could certainly fork() a process to exec() hcitool, and when it
> > finishes it could send the information to your program, through a pipe
> > that your program is select()ing on, or something similar.
> 
> very bad idea :(

Aww, it's just another way to do it, that doesn't require as much
dependency or learning.  ;-)

> You don't looked into the details. The inquiry ioctl() is one way. The
> other one is the HCI raw socket. Open and bind a device and then set an
> event filter on it. Send an inquiry command according to the spec. and
> listen for the incoming inquiry result events.

I stand corrected.

Albert, there is a good example of this in src/btctl-discovery-source.c
in the libbtctl-0.4.1 package.
http://usefulinc.com/software/gnome-bluetooth/

btctl_discovery_source_new()
The hci device is opened, then set O_NONBLOCK, and the event filters are
set.  There's no sign of binding.

btctl_discovery_source_send_inquiry()
is used to send the inquiry command, but returns immediately.

The surrounding code handles the data as it comes back, using the event
model; typical for a GNOME or glib based application.

Fascinating.

-- 
James Cameron
