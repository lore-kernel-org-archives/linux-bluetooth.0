Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Message-ID: <20040204174648.GA16590@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <200402041223.29088.mtortonesi@ing.unife.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402041223.29088.mtortonesi@ing.unife.it>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: [Bluez-devel] Re: bluez & qos
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
Date: Wed, 4 Feb 2004 09:46:48 -0800

On Wed, Feb 04, 2004 at 12:23:29PM +0100, Mauro Tortonesi wrote:
> 
> hi to everybody,
> 
> 	i was trying to do some qos setup tests with bluez and i have seen that there 
> is barely no qos support in bluez. it would be nice to develop an 
> ioctl(2)-based extension to set up qos on bluez sockets. i have just started  
> working on the code. marcel, would you be intested in having qos support for 
> bluez?
> 
> BTW: i have seen that Jean Tourrilhes (included in cc) has been working on qos 
> with CSR chips a while ago. jean, since i have seen no announcements on this 
> list i suppose that you haven't production-quality code adding qos support 
> for bluez...

	My code just open a HCI socket and send HCI commands. The HCI
commands are pretty straightforward, well documented and do everything
you want, so I don't see the point in adding weird ioctls. The main
issue I have with ioctls is that they are blocking, so that's why my
code use HCI socket for everything (including Inquiry).
	Not that the main issue will be firware support. For example
the QoS feature I needed is not implemented in the CSR firmware.

	Ciao...

	Jean


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
