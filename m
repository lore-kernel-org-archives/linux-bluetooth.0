Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus support
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076265358.2670.36.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076266267.14742.38.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 19:51:07 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

HI Marcel

On Sun, 2004-02-08 at 19:35, Marcel Holtmann wrote:
> while thinking about the best management interface and API for the new
> Bluetooth library and utils I came to the conlusion that D-Bus is the
> right way to go. 

Excellent choice, I believe so too. ;)

> My problem is now that I don't wanna link the Bluetooth library itself 
> with the D-Bus library. So what I was thinking of that we extend the 
> hcid to be a multiplexer with a D-Bus interface. So we have the HCI raw 
> socket and ioctl's for configuration and we can use the D-Bus interface 
> for this and also advanced things like PIN management etc. My idea behind
> this is, that graphical interfaces like Gnome or KDE only have to use the 
> D-Bus for their stuff.

I have implemented this in hcid, DBus sockets, Gnome configuration
interface and so on. Please look at: http://noring.nocrew.org/bluetooth/

> Proposals and comments?

Later tonight, I'll write you a detailed description on what's already
implemented on the hcid DBus interfaces, new configuration options, the
nametab and keytab files etc. I'd like to discuss these things so that
we can agree on the API:s etc.

Here's the release notes for the Gnome Bluetooth Configuration tool
0.1.0, released today:

   o All clickable buttons are actually working! This includes:

        - Devices can be brought up and down by clicking
          on the Activate/Deactivate buttons.
        - Device names can be set by typing in the Name field.
        - Trusted devices pop up instantly below the "Trusted 
          Devices" tab when paired, with both names and addresses.
        - Trusted devices can be removed by clicking on the
          "Remove" button.
        - Devices pop up automatically in the device list
          when inserted (USB etc.). Remove should work too.

   o Installation target (--prefix) works with the glade file.

   o A name cache is maintained by hcid in /etc/bluetooth/nametab.
     The location of this file may change in the future, and
     it will be configurable. The new "pair_name" option to hcid
     (default "yes") makes hcid save the names of remote devices
     when pairing.

Fredrik
