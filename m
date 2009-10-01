Return-Path: <cyrus@holtmann.org>
Subject: Re: So very close, but so frustrating...
From: Bastien Nocera <hadess@hadess.net>
To: Dan Williams <dcbw@redhat.com>
In-Reply-To: <1254433173.9657.155.camel@localhost.localdomain>
References: <4AC3EFD9.1020602@shic.co.uk>
	<7cd7fc040909301718r3e441c53x767084b0b01f4a7c@mail.gmail.com>
	<1254433173.9657.155.camel@localhost.localdomain>
Date: Fri, 02 Oct 2009 00:19:29 +0100
Message-Id: <1254439169.22191.317.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	networkmanager-list@gnome.org
List-Unsubscribe: <http://mail.gnome.org/mailman/options/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=unsubscribe>
List-Archive: <http://mail.gnome.org/archives/networkmanager-list/>
List-Post: <mailto:networkmanager-list@gnome.org>
List-Help: <mailto:networkmanager-list-request@gnome.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/networkmanager-list>,
	<mailto:networkmanager-list-request@gnome.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: networkmanager-list-bounces@gnome.org
Errors-To: networkmanager-list-bounces@gnome.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-10-01 at 14:39 -0700, Dan Williams wrote:
> On Wed, 2009-09-30 at 20:18 -0400, Darren Albers wrote:
<snip>
> > At this time Network Manager does not support Bluetooth modems.   I
> > think 0.8 supports phones if they use Bluetooth PAN but not Bluetooth
> > DUN.
> 
> Correct; I may just get bored enough today triaging bugs to go implement
> DUN in 0.8.  That opens up a huge number of cellphones, which will
> inevitably lead to even more bugs since there's much more phone
> variation than in the relatively small data card space.  Oh well; it
> would help a lot of people out.

1. Add ability for MM to identify Bluetooth modems
2. Add plugin in bluez to poke at the modem with MM if it doesn't know
the type of device, cache the result, the bluez plugin exports the
information through a service
3. Add DUN gnome-bluetooth plugin to nm-applet which would poke the
bluez service
4. Add native support in NM to do the connection through bluetoothd

After 3., if the box is ticked, the device should appear like an
unconfigured WWAN modem to the user. The service configuration can then
be done through nm-applet.

I can certainly take care of 2. and 3. if you do 1. and the left-overs
of 4 :)

Cheers

_______________________________________________
NetworkManager-list mailing list
NetworkManager-list@gnome.org
http://mail.gnome.org/mailman/listinfo/networkmanager-list
