Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: Albert Huang <ashuang@gmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do asynchronous device inquiry?
Message-ID: <20040629043356.GK20139@hp.com>
References: <ef9938ec040628194321db5d9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ef9938ec040628194321db5d9c@mail.gmail.com>
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
Date: Tue, 29 Jun 2004 14:33:56 +1000

G'day Albert,

You could certainly fork() a process to exec() hcitool, and when it
finishes it could send the information to your program, through a pipe
that your program is select()ing on, or something similar.

If you knew your application environment well, you could configure the
inquiry to take far less time.  e.g. "hcitool inq --length=1" is
supposed to work for 1.28 seconds only, assuming no cache.  If you can
change the inquiry parameters of the other device, you can help this to
go even faster.

I've tried running "hcitool inq --length=1" repeatedly until another
device is found.  It doesn't seem as reliable as doing a full inquiry.

You could use threads.  Erk.

But how to implement it asynchronously all in one process using an event
model ... doesn't seem to be a way to do it.  Maybe I just can't find
it.  Here's how I looked ...

Looking at tools/hcitool.c, an inquiry uses hci_inquiry() function, part
of libbluetooth1 on my system.  I'm looking at 2.7.

In libbluetooth1, hci_inquiry() calls ioctl() to do the work.  It passes
an hci_inquiry_req struct.  I'm not sure what possible flag bits are
valid.  IREQ_CACHE_FLUSH is the only one I can see defined.

The ioctl() is handled by kernel function hci_sock_ioctl() in
net/bluetooth/hci_sock.c which dispatches it to hci_inquiry() in
net/bluetooth/hci_core.c and there doesn't seem to be any clear support
for doing the inquiry asynchronously.  I'm looking at 2.6.6.

Warning though; in hci_request() in the hci_core.c file, all requests to
the device are serialised.  Multiple attempts to do hci_inquiry() will
be queued.

-- 
James Cameron


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
