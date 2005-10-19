Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f20510190803g3f78775dr4d817acc0cd18171@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Make RemoteName D-BUS method non-blocking
In-Reply-To: <20051019140715.GA15123@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051019140715.GA15123@localhost.localdomain>
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
Date: Wed, 19 Oct 2005 17:03:34 +0200

Hi Johan,

I've also written a bluetooth daemon with dbus support and have
stumbled in exactly the same problem a couple of months ago, the
blocking nature of the bluez api has been a great obstacle for me, of
course I could not accept that the daemon became completely
unresponsive while waiting for a lengthy command ( like an inquiry or
a remote_name_request ) to complete, for this reason I could not use
hci_send_req ( and sdp_send_req_w4_rsp, but that's for another post )
and had to rewrite all the functions using them in a sane ( at least
for what I was trying to do ) way, here's more or less my approach:

- receive the dbus method_call asking to perform some hci command
- save the call_message somewhere ( a pointer )
- fill the hci command packet
- save a structure containing the packet and the aforementioned
pointer in a queue ( this structure contains other things, like a
timeout object to know when the command didn't complete in time, but
let's get over that )
- send the hci command packet
- move it to another queue
- return to the main loop
[you could use the glib main loop if you like ( or that 'scary'
glib-ectomy in bluez-utils :) but I wanted to avoid such a dependency
for a daemon and wrote my own main loop adapter.]

when some data is ready on the hci control socket ( you have one of
those for each active device )
- read the generated event
- see if it corresponds to one of the pending commands in the queue (
this part includes some dirty magic to avoid messing things up if you
send twice the same command )
- if so, read the event data and send the method_reply over dbus (
using the pointer you saved before )

that's it!

There are surely better ways to do it, ( and I'm looking for some now
that I'm rewriting the whole thing ) but I hope this can be a starting
point for a discussion.

regards


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
