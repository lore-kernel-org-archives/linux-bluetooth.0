Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: bluez & qos
Message-ID: <20040205172242.GB5417@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <200402041223.29088.mtortonesi@ing.unife.it> <20040204174648.GA16590@bougret.hpl.hp.com> <200402051146.55939.mtortonesi@ing.unife.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402051146.55939.mtortonesi@ing.unife.it>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
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
Date: Thu, 5 Feb 2004 09:22:42 -0800

On Thu, Feb 05, 2004 at 11:46:55AM +0100, Mauro Tortonesi wrote:
> 
> i think the "open a HCI socket and send HCI commands" approach (which indeed 
> has many advantages) is a bit too low-level to be used in standard 
> applications as a way for setting QoS over Bluez.
> since QoS is semantically an attribute of a connection, it would be nice to 
> have ioctl(2) commands for setting QoS parameters on a given connection.

	Aggregating the QoS of the various sockets into a generic QoS
that you can pass to the HCI is not a trivial problem. You can not
guarantee that there will only be one socket per handle.

> > 	Not that the main issue will be firware support. For example
> > the QoS feature I needed is not implemented in the CSR firmware.
> 
> do you mean that most of the firmware of the Bluetooth chips in commerce do 
> not support/implement HCI QoS commands (such as OGF 0x0002 OCF 0x0007)? what 
> version of CSR firmware are you talking about?

	No, I'm saying "the QoS feature I *needed*". I want QoS
*events*, most firmware don't support that.

> Mauro Tortonesi

	Ciao.

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
