Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
From: Marcel Holtmann <marcel@holtmann.org>
To: James Cameron <james.cameron@hp.com>
Cc: Albert Huang <ashuang@gmail.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040629043356.GK20139@hp.com>
References: <ef9938ec040628194321db5d9c@mail.gmail.com>
	 <20040629043356.GK20139@hp.com>
Content-Type: text/plain
Message-Id: <1088545055.6030.339.camel@pegasus>
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
Date: Tue, 29 Jun 2004 23:37:35 +0200

Hi James,

> You could certainly fork() a process to exec() hcitool, and when it
> finishes it could send the information to your program, through a pipe
> that your program is select()ing on, or something similar.

very bad idea :(

> You could use threads.  Erk.

Possible, but not needed.

> But how to implement it asynchronously all in one process using an event
> model ... doesn't seem to be a way to do it.  Maybe I just can't find
> it.  Here's how I looked ...

You don't looked into the details. The inquiry ioctl() is one way. The
other one is the HCI raw socket. Open and bind a device and then set an
event filter on it. Send an inquiry command according to the spec. and
listen for the incoming inquiry result events.

> Warning though; in hci_request() in the hci_core.c file, all requests to
> the device are serialised.  Multiple attempts to do hci_inquiry() will
> be queued.

It is impossible to run two inquiries at the same time. The Bluetooth
chip won't allow and even the HCI core don't accepts it. There is the
INQUIRY flag that will set if an inquiry is in progress.

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
