Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Implementing the PIN helper support
Message-ID: <20060221130240.GA11197@localhost.localdomain>
References: <1140468298.7047.52.camel@localhost> <20060220211402.GA6466@localhost.localdomain> <1140471085.7047.63.camel@localhost> <20060221093118.GA10267@localhost.localdomain> <1140521700.10008.8.camel@localhost> <e1effdeb0602210440p141b4b7cta5c51ca87d135bde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1effdeb0602210440p141b4b7cta5c51ca87d135bde@mail.gmail.com>
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
Date: Tue, 21 Feb 2006 15:02:40 +0200

Hi Claudio,

On Tue, Feb 21, 2006, Claudio Takahasi wrote:
> Let me try expose some D-Bus features that can help us design the PIN
> Agent better...
> 
> Currently PinAgent uses the system bus connection. D-Bus is able to
> start applications automatically. Applications with user interfaces
> can't be started by system dbus-daemon, only the session can run this
> kind of applications. Using the session bus connection,  it is not
> necessary has a applet/or a application always active. The D-Bus
> starts the application when the first message is sent to the path.
> For more information read the section "Message Bus Starting Services":
> http://dbus.freedesktop.org/doc/dbus-specification.html

I'm aware of the activation feature of D-BUS, and if you look through
the bluez-devel archives you'll even find mails from me suggesting to
use it a year ago or so. However, it's most likely not the right
solution nor even feasible currently.

The main problem is that we can't use the session bus for
hcid/bluetoothd since the daemon is a system level service which doesn't
know about any specific session (it might become possible in the future
to discover existing session busses through the system bus, but
currently this is not possible).

Then there's the possibility of creating a bluetoothd specific interface
for the user to tell it about the existence of his session bus. However,
I have a feeling that this would over-complicate the D-BUS code, create
all sorts of extra (e.g. security related) issues, and would conflict
with the "discover session busses through system bus" feature which has
been hinted as a possible addition to post-1.0 versions of dbus (you'll
need to dig the dbus mailing list archives for the exact reference).

Johan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
