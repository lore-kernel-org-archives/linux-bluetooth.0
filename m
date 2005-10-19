Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
Message-ID: <20051019174549.GA15795@localhost.localdomain>
References: <20051019140715.GA15123@localhost.localdomain> <9307f5f20510190803g3f78775dr4d817acc0cd18171@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9307f5f20510190803g3f78775dr4d817acc0cd18171@mail.gmail.com>
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
Date: Wed, 19 Oct 2005 20:45:49 +0300

Hi,

On Wed, Oct 19, 2005, P. Durante wrote:
> - receive the dbus method_call asking to perform some hci command
> - save the call_message somewhere ( a pointer )
> - fill the hci command packet
> - save a structure containing the packet and the aforementioned
> pointer in a queue ( this structure contains other things, like a
> timeout object to know when the command didn't complete in time, but
> let's get over that )
> - send the hci command packet
> - move it to another queue
> - return to the main loop
> [you could use the glib main loop if you like ( or that 'scary'
> glib-ectomy in bluez-utils :) but I wanted to avoid such a dependency
> for a daemon and wrote my own main loop adapter.]
> 
> when some data is ready on the hci control socket ( you have one of
> those for each active device )
> - read the generated event
> - see if it corresponds to one of the pending commands in the queue (
> this part includes some dirty magic to avoid messing things up if you
> send twice the same command )
> - if so, read the event data and send the method_reply over dbus (
> using the pointer you saved before )

What you describe is pretty much as I have implemented the bluetooth
D-BUS applications that are part of maemo (www.maemo.org, osso-bttools
and osso-gwconnect packages). For those I had the luxury of using glib
so doing things asynchronously was quite simple.

The results of the Inquiry and RemoteName methods are already sent as
D-BUS signals, so it doesn't necessarely make sense to send the
information a second time in the D-BUS method returns. However, there
will for sure come scerarios where we need to store information in some
queue, return to the mainloop, and retreive the information from the
queue when the appropriate event comes.

Since I don't have a very clear picture of what kind of mainloop Marcel
would like to use when we move the development over to bluetoothd from
hcid, I have intentionally tried to stay away from touching features
which would require doing things asychronously as you describe ;-)

Johan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
