Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: jt@hpl.hp.com, Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: [Bluez-devel] Re: bluez & qos
Cc: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
References: <20040204015825.GA2217@bougret.hpl.hp.com> <200402041223.29088.mtortonesi@ing.unife.it> <20040204174648.GA16590@bougret.hpl.hp.com>
In-Reply-To: <20040204174648.GA16590@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402051146.55939.mtortonesi@ing.unife.it>
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
Date: Thu, 5 Feb 2004 11:46:55 +0100

On Wednesday 04 February 2004 18:46, Jean Tourrilhes wrote:
> On Wed, Feb 04, 2004 at 12:23:29PM +0100, Mauro Tortonesi wrote:
> > hi to everybody,
> >
> > 	i was trying to do some qos setup tests with bluez and i have seen that
> > there is barely no qos support in bluez. it would be nice to develop an
> > ioctl(2)-based extension to set up qos on bluez sockets. i have just
> > started working on the code. marcel, would you be intested in having qos
> > support for bluez?
> >
> > BTW: i have seen that Jean Tourrilhes (included in cc) has been working
> > on qos with CSR chips a while ago. jean, since i have seen no
> > announcements on this list i suppose that you haven't production-quality
> > code adding qos support for bluez...
>
> 	My code just open a HCI socket and send HCI commands. The HCI
> commands are pretty straightforward, well documented and do everything
> you want, so I don't see the point in adding weird ioctls. The main
> issue I have with ioctls is that they are blocking, so that's why my
> code use HCI socket for everything (including Inquiry).

i think the "open a HCI socket and send HCI commands" approach (which indeed 
has many advantages) is a bit too low-level to be used in standard 
applications as a way for setting QoS over Bluez.
since QoS is semantically an attribute of a connection, it would be nice to 
have ioctl(2) commands for setting QoS parameters on a given connection.

> 	Not that the main issue will be firware support. For example
> the QoS feature I needed is not implemented in the CSR firmware.

do you mean that most of the firmware of the Bluetooth chips in commerce do 
not support/implement HCI QoS commands (such as OGF 0x0002 OCF 0x0007)? what 
version of CSR firmware are you talking about?

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
