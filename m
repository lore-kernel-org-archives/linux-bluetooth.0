Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter getting
Message-ID: <20051107145430.GA12669@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain> <1131315924.5824.14.camel@blade> <20051107093436.GB6845@localhost.localdomain> <1131359661.5824.97.camel@blade> <20051107121354.GA9950@localhost.localdomain> <1131368088.5824.116.camel@blade> <e1effdeb0511070612u7555e383kaaade3f1f0c7bbd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0511070612u7555e383kaaade3f1f0c7bbd1@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 7 Nov 2005 16:54:30 +0200

On Mon, Nov 07, 2005, Claudio Takahasi wrote:
> Use a per client connection identification will be nice if we have a
> peer responses instead of using signals. This will be nice when the
> kernel cache can be retrieved.
> 
> I didn't understand how the client id works.  Could you explain a
> little bit more?

The id I was talking about is in practice what you get when you call
dbus_message_get_sender for a received message. The D-BUS spec. calls it
"Unique name of the sending connection".

> Every time that a client establish a connection with the d-bus daemon
> the connection id changes.  Therefore control client id is useful only
> for clients that is always connected with the daemon.

True, and that was also one thing I was worried about when it comes to
the practicality of that solution (the settings wouldn't be persistent
enough). So, I think using the user id might be better in this respect.

However, let me now introduce a third option which we just discussed on
IRC with Claudio: optional D-BUS method parameters. It would be quite
easy to implement the methods so that the client could leave out most
parameters in which case hcid (or bluetoothd) would use some set of
default values. You could e.g. call the Inquiry method without any
parameters and it would just work (kind of the same way that dbus-test
allows doing "./dbus-test Inquiry" in which case it uses length=10 &
num_resp=100 as the default values). If the client insists on using its
own values for the method it would simply include them in the method
call.

In case this variable parameters solution doesn't work out for all
scenarios it could probably happily co-exist with the per-user id
settings solution.

Johan


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
