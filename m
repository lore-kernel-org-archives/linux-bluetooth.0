Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus support
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076266267.14742.38.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076267396.2670.58.camel@pegasus>
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
Date: Sun, 08 Feb 2004 20:09:56 +0100

Hi Fredrik,

> > My problem is now that I don't wanna link the Bluetooth library itself 
> > with the D-Bus library. So what I was thinking of that we extend the 
> > hcid to be a multiplexer with a D-Bus interface. So we have the HCI raw 
> > socket and ioctl's for configuration and we can use the D-Bus interface 
> > for this and also advanced things like PIN management etc. My idea behind
> > this is, that graphical interfaces like Gnome or KDE only have to use the 
> > D-Bus for their stuff.
> 
> I have implemented this in hcid, DBus sockets, Gnome configuration
> interface and so on. Please look at: http://noring.nocrew.org/bluetooth/

I already looked at your stuff. Nice work btw. At the moment I am more
concerned on how the D-Bus interface should look like than a real
implementation. You now that an important part for me is the security.
For example a user can see what devices a paired and it can delete a
pairing, but it don't have to see the link key itself. This is the job
of the daemon that provides this interface. The same applies for
changing device settings and storing them on the harddisk.

Another point is that I want to use the system message bus for it.

> > Proposals and comments?
> 
> Later tonight, I'll write you a detailed description on what's already
> implemented on the hcid DBus interfaces, new configuration options, the
> nametab and keytab files etc. I'd like to discuss these things so that
> we can agree on the API:s etc.

My favourite storage is Berkeley DB.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
